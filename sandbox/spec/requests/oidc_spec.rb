# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Oidc" do
  describe "GET /oidc/start" do
    let(:issuer) { "https://issuer.example.com/realms/test" }
    let(:discovery_url) { "#{issuer}/.well-known/openid-configuration" }
    let(:authorization_endpoint) { "#{issuer}/protocol/openid-connect/auth" }
    let(:discovery_response) do
      {
        issuer: issuer,
        authorization_endpoint: authorization_endpoint,
        token_endpoint: "#{issuer}/protocol/openid-connect/token",
        userinfo_endpoint: "#{issuer}/protocol/openid-connect/userinfo",
        jwks_uri: "#{issuer}/protocol/openid-connect/certs",
        response_types_supported: ["code"],
        subject_types_supported: ["public"],
        id_token_signing_alg_values_supported: ["PS256", "ES256"],
      }
    end

    before do
      stub_request(:get, discovery_url)
        .to_return(
          status: 200,
          body: discovery_response.to_json,
          headers: { "Content-Type" => "application/json" },
        )
      allow(Settings).to receive_messages(
        oidc_issuer: issuer,
        oidc_client_id: "rails-sandbox-rp",
        oidc_redirect_uri: "http://localhost:3000/oidc/callback",
      )
    end

    it "authorization endpoint にリダイレクトする" do
      get "/oidc/start"
      expect(response).to have_http_status(:found)
      expect(response.location).to start_with(authorization_endpoint)
    end

    it "authorization endpoint にリダイレクトする際に必要なURLパラメータが設定されている" do
      get "/oidc/start"
      uri = URI.parse(response.location)
      params = URI.decode_www_form(uri.query).to_h
      expect(params).to include(
        "response_type" => "code",
        "client_id" => "rails-sandbox-rp",
        "redirect_uri" => "http://localhost:3000/oidc/callback",
        "scope" => "openid",
      )
    end

    it "authorization endpoint にリダイレクトする際にURLに code challengeを設定し、sessionにverifierを保存" do
      get "/oidc/start"
      uri = URI.parse(response.location)
      params = URI.decode_www_form(uri.query).to_h
      expect(params).to include("code_challenge_method" => "S256")
      expect(params["code_challenge"]).to match(/\A[A-Za-z0-9_-]+\z/) # URL-safe base64
      expect(session[:oidc_code_verifier]).to match(/\A[A-Za-z0-9_-]+\z/)
    end

    it "authorization endpoint にリダイレクトする際にURLに state を設定し、session に保存" do
      get "/oidc/start"
      uri = URI.parse(response.location)
      params = URI.decode_www_form(uri.query).to_h
      expect(params["state"]).to match(/\A[A-Za-z0-9_-]+\z/) # URL-safe base64
      expect(params["state"]).to eq(session[:oidc_state])
    end

    it "authorization endpoint にリダイレクトする際にURLに nonce を設定し、session に保存" do
      get "/oidc/start"
      uri = URI.parse(response.location)
      params = URI.decode_www_form(uri.query).to_h
      expect(params["nonce"]).to match(/\A[A-Za-z0-9_-]+\z/) # URL-safe base64
      expect(params["nonce"]).to eq(session[:oidc_nonce])
    end
  end
end
