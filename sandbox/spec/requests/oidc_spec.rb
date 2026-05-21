# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Oidc" do
  describe "GET /oidc/start" do
    let(:issuer) { "https://issuer.example.com/realms/test" }
    let(:discovery_url) { "#{issuer}/.well-known/openid-configuration" }
    let(:authorization_endpoint) { "#{issuer}/protocol/openid-connect/auth" }
    let(:pushed_authorization_request_endpoint) { "#{issuer}/protocol/openid-connect/par" }
    let(:discovery_response) do
      {
        issuer: issuer,
        authorization_endpoint: authorization_endpoint,
        pushed_authorization_request_endpoint: pushed_authorization_request_endpoint,
        token_endpoint: "#{issuer}/protocol/openid-connect/token",
        userinfo_endpoint: "#{issuer}/protocol/openid-connect/userinfo",
        jwks_uri: "#{issuer}/protocol/openid-connect/certs",
        response_types_supported: ["code"],
        subject_types_supported: ["public"],
        id_token_signing_alg_values_supported: ["PS256", "ES256"],
      }
    end

    before do
      allow(OidcRelyingParty).to receive_messages(
        generate_state: "the-state",
        generate_nonce: "the-nonce",
        generate_pkce: { verifier: "the-verifier", challenge: "the-challenge" },
      )
      allow(Settings).to receive_messages(
        oidc_issuer: issuer,
        oidc_client_id: "rails-sandbox-rp",
        oidc_redirect_uri: "http://localhost:3000/oidc/callback",
        oidc_client_secret: "secret",
      )
      stub_request(:get, discovery_url)
        .to_return(
          status: 200,
          body: discovery_response.to_json,
          headers: { "Content-Type" => "application/json" },
        )
      stub_request(:post, pushed_authorization_request_endpoint)
        .to_return(
          status: 201,
          body: { request_uri: "urn:ietf:params:oauth:request_uri:abc123", expires_in: 60 }.to_json,
          headers: { "Content-Type" => "application/json" },
        )
    end

    it "authorization endpoint にリダイレクトする" do
      get "/oidc/start"
      expect(response).to have_http_status(:found)
      expect(response.location).to start_with(authorization_endpoint)
    end

    it "authorization endpoint にリダイレクトする際に必要なパラメータが設定されている" do
      get "/oidc/start"
      uri = URI.parse(response.location)
      params = URI.decode_www_form(uri.query).to_h
      expect(params).to include(
        "client_id" => "rails-sandbox-rp",
        "request_uri" => "urn:ietf:params:oauth:request_uri:abc123",
      )
      expect(
        a_request(:post, pushed_authorization_request_endpoint)
        .with(
          body: hash_including(
            "response_type" => "code",
            "client_id" => "rails-sandbox-rp",
            "code_challenge" => "the-challenge",
            "state" => "the-state",
            "nonce" => "the-nonce",
          ),
        ),
      ).to have_been_made
    end

    it "session に verifier を保存" do
      get "/oidc/start"
      expect(session[:oidc_code_verifier]).to match(/\A[A-Za-z0-9_-]+\z/)
    end

    it "session に state を保存" do
      get "/oidc/start"
      expect(session[:oidc_state]).to eq("the-state")
    end

    it "session に nonce を保存" do
      get "/oidc/start"
      expect(session[:oidc_nonce]).to eq("the-nonce")
    end
  end

  describe "GET /oidc/callback" do
    let(:issuer) { "https://issuer.example.com/realms/test" }
    let(:discovery_url) { "#{issuer}/.well-known/openid-configuration" }
    let(:authorization_endpoint) { "#{issuer}/protocol/openid-connect/auth" }
    let(:pushed_authorization_request_endpoint) { "#{issuer}/protocol/openid-connect/par" }
    let(:discovery_response) do
      {
        issuer: issuer,
        pushed_authorization_request_endpoint: pushed_authorization_request_endpoint,
        authorization_endpoint: authorization_endpoint,
        token_endpoint: "#{issuer}/protocol/openid-connect/token",
        userinfo_endpoint: "#{issuer}/protocol/openid-connect/userinfo",
        jwks_uri: "#{issuer}/protocol/openid-connect/certs",
        response_types_supported: ["code"],
        subject_types_supported: ["public"],
        id_token_signing_alg_values_supported: ["PS256", "ES256"],
      }
    end

    let(:jwk) { JSON::JWK.new(OpenSSL::PKey::RSA.generate(2048)) }
    let(:now) { Time.current.to_i }
    let(:claims) do
      { iss: issuer, aud: "rails-sandbox-rp", nonce: "the-nonce", sub: "user-1", iat: now, exp: now + 60 }
    end
    let(:id_token) { JSON::JWT.new(claims).tap { |j| j.kid = jwk[:kid] }.sign(jwk, :PS256).to_s }

    let(:callback_params) do
      {
        state: "the-state",
        iss: issuer,
        code: "the-code",
      }
    end

    before do
      allow(OidcRelyingParty).to receive_messages(
        generate_state: callback_params[:state],
        generate_nonce: claims[:nonce],
        generate_pkce: { verifier: "v", challenge: "c" },
      )
      allow(Settings).to receive_messages(
        oidc_issuer: issuer,
        oidc_client_id: "rails-sandbox-rp",
        oidc_client_secret: "secret",
        oidc_redirect_uri: "http://localhost:3000/oidc/callback",
      )
      stub_request(:get, discovery_url)
        .to_return(
          status: 200,
          body: discovery_response.to_json,
          headers: { "Content-Type" => "application/json" },
        )
      stub_request(:post, discovery_response[:token_endpoint])
        .with(basic_auth: ["rails-sandbox-rp", "secret"])
        .to_return(
          body: { access_token: "AT", id_token: id_token }.to_json,
          headers: { "Content-Type" => "application/json" },
        )
      stub_request(:get, discovery_response[:jwks_uri]).to_return(
        body: JSON::JWK::Set.new(jwk).to_json,
        headers: { "Content-Type" => "application/json" },
      )
      stub_request(:post, pushed_authorization_request_endpoint)
        .to_return(
          status: 201,
          body: { request_uri: "urn:ietf:params:oauth:request_uri:abc123", expires_in: 60 }.to_json,
          headers: { "Content-Type" => "application/json" },
        )
    end

    it "oidc/userinfo へリダイレクト" do
      get "/oidc/start"
      get "/oidc/callback", params: callback_params
      expect(response).to have_http_status(:found)
      expect(response.location).to match(oidc_userinfo_path)
    end

    it "sessionにアクセストークンが追加され state, nonce, code_verifier が session から削除される" do
      get "/oidc/start"
      expect(session[:oidc_state]).not_to be_nil
      expect(session[:oidc_nonce]).not_to be_nil
      expect(session[:oidc_code_verifier]).not_to be_nil

      get "/oidc/callback", params: callback_params
      expect(session[:oidc_access_token]).to eq("AT")
      expect(session[:oidc_state]).to be_nil
      expect(session[:oidc_nonce]).to be_nil
      expect(session[:oidc_code_verifier]).to be_nil
    end
  end

  describe "GET /oidc/userinfo" do
    let(:issuer) { "https://issuer.example.com/realms/test" }
    let(:discovery_url) { "#{issuer}/.well-known/openid-configuration" }
    let(:authorization_endpoint) { "#{issuer}/protocol/openid-connect/auth" }
    let(:pushed_authorization_request_endpoint) { "#{issuer}/protocol/openid-connect/par" }
    let(:discovery_response) do
      {
        issuer: issuer,
        authorization_endpoint: authorization_endpoint,
        pushed_authorization_request_endpoint: pushed_authorization_request_endpoint,
        token_endpoint: "#{issuer}/protocol/openid-connect/token",
        userinfo_endpoint: "#{issuer}/protocol/openid-connect/userinfo",
        jwks_uri: "#{issuer}/protocol/openid-connect/certs",
        response_types_supported: ["code"],
        subject_types_supported: ["public"],
        id_token_signing_alg_values_supported: ["PS256", "ES256"],
      }
    end

    let(:jwk) { JSON::JWK.new(OpenSSL::PKey::RSA.generate(2048)) }
    let(:now) { Time.current.to_i }
    let(:claims) do
      { iss: issuer, aud: "rails-sandbox-rp", nonce: "the-nonce", sub: "user-1", iat: now, exp: now + 60 }
    end
    let(:id_token) { JSON::JWT.new(claims).tap { |j| j.kid = jwk[:kid] }.sign(jwk, :PS256).to_s }

    let(:callback_params) do
      {
        state: "the-state",
        iss: issuer,
        code: "the-code",
      }
    end

    before do
      allow(OidcRelyingParty).to receive_messages(
        generate_state: callback_params[:state],
        generate_nonce: claims[:nonce],
        generate_pkce: { verifier: "v", challenge: "c" },
      )
      allow(Settings).to receive_messages(
        oidc_issuer: issuer,
        oidc_client_id: "rails-sandbox-rp",
        oidc_client_secret: "secret",
        oidc_redirect_uri: "http://localhost:3000/oidc/callback",
      )
      stub_request(:get, discovery_url)
        .to_return(
          status: 200,
          body: discovery_response.to_json,
          headers: { "Content-Type" => "application/json" },
        )
      stub_request(:post, discovery_response[:token_endpoint])
        .with(basic_auth: ["rails-sandbox-rp", "secret"])
        .to_return(
          body: { access_token: "AT", id_token: id_token }.to_json,
          headers: { "Content-Type" => "application/json" },
        )
      stub_request(:get, discovery_response[:jwks_uri]).to_return(
        body: JSON::JWK::Set.new(jwk).to_json,
        headers: { "Content-Type" => "application/json" },
      )
      stub_request(:get, discovery_response[:userinfo_endpoint])
        .with(headers: { "Authorization" => "Bearer AT" })
        .to_return(
          status: 200,
          body: { sub: "user-1" }.to_json,
          headers: { "Content-Type" => "application/json" },
        )
      stub_request(:post, pushed_authorization_request_endpoint)
        .to_return(
          status: 201,
          body: { request_uri: "urn:ietf:params:oauth:request_uri:abc123", expires_in: 60 }.to_json,
          headers: { "Content-Type" => "application/json" },
        )
    end

    it "userinfoが取得できる" do
      get "/oidc/start"
      get "/oidc/callback", params: callback_params
      get "/oidc/userinfo"
      expect(response.body).to include("sub: user-1")
    end
  end
end
