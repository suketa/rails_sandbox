# frozen_string_literal: true

require "rails_helper"

RSpec.describe OidcRelyingParty do
  describe "#callback" do
    let(:issuer) { "https://issuer.example.com" }
    let(:token_endpoint) { "#{issuer}/token" }
    let(:jwks_uri) { "#{issuer}/jwks" }
    let(:discovery_url) { "#{issuer}/.well-known/openid-configuration" }
    let(:discovery_response) do
      {
        issuer:,
        token_endpoint:,
        jwks_uri:,
        authorization_endpoint: "#{issuer}/auth",
        userinfo_endpoint: "#{issuer}/user_info",
        response_types_supported: ["code"],
        subject_types_supported: ["public"],
        id_token_signing_alg_values_supported: ["PS256", "ES256"],
      }
    end
    let(:jwk) { JSON::JWK.new(OpenSSL::PKey::RSA.generate(2048)) }
    let(:pkey) { OpenSSL::PKey::EC.generate("prime256v1") }
    let(:pem) { pkey.to_pem }
    let(:now) { Time.current.to_i }
    let(:claims) do
      { iss: issuer, aud: "cid", nonce: "nonce", sub: "user-1", iat: now, exp: now + 60 }
    end
    let(:id_token) { JSON::JWT.new(claims).tap { |j| j.kid = jwk[:kid] }.sign(jwk, :PS256).to_s }

    before do
      allow(Settings).to receive_messages(
        oidc_issuer: issuer,
        oidc_client_id: "cid",
        oidc_redirect_uri: "http://localhost:3000/oidc/callback",
        oidc_signing_key: pem,
      )
      stub_request(:get, discovery_url).to_return(status: 200, body: discovery_response.to_json, headers: { "Content-Type" => "application/json" })
      stub_request(:post, token_endpoint)
        .to_return(
          body: { access_token: "AT", id_token: id_token }.to_json,
          headers: { "Content-Type" => "application/json" },
        )
      stub_request(:get, jwks_uri).to_return(
        body: JSON::JWK::Set.new(jwk).to_json,
        headers: { "Content-Type" => "application/json" },
      )
    end

    context "happy path" do
      it "claims と access_token を返す" do
        rp = described_class.new
        result = rp.callback(
          code: "the-code",
          iss: issuer,
          state: "the-state",
          expected_state: "the-state",
          expected_nonce: "nonce",
          code_verifier: "the-verifier",
        )
        expect(result).to include(access_token: "AT", claims: include(sub: "user-1", iss: issuer))
      end
    end

    context "id_token の alg が discovery の宣言に含まれないとき" do
      let(:id_token) { JSON::JWT.new(claims).tap { |j| j.kid = jwk[:kid] }.sign(jwk, :RS512).to_s }

      it "VerificationError になる" do
        rp = described_class.new
        expect do
          rp.callback(
            code: "the-code",
            iss: issuer,
            state: "the-state",
            expected_state: "the-state",
            expected_nonce: "nonce",
            code_verifier: "the-verifier",
          )
        end.to raise_error(OidcIdTokenVerifier::VerificationError, /alg/)
      end
    end

    context "state が expected state と一致しないとき" do
      it "StateMismatchError になる" do
        rp = described_class.new
        expect do
          rp.callback(
            code: "the-code",
            iss: issuer,
            state: "tampered-state",
            expected_state: "the-state",
            expected_nonce: "nonce",
            code_verifier: "the-verifier",
          )
        end.to raise_error(OidcRelyingParty::StateMismatchError)
      end
    end

    context "iss が discovery.issuer と一致しないとき" do
      it "IssMismatchError になる" do
        rp = described_class.new
        expect do
          rp.callback(
            code: "the-code",
            iss: "https://attacker.example.com",
            state: "the-state",
            expected_state: "the-state",
            expected_nonce: "nonce",
            code_verifier: "the-verifier",
          )
        end.to raise_error(OidcRelyingParty::IssMismatchError)
      end
    end

    context "iss が nil のとき" do
      it "IssMismatchError になる" do
        rp = described_class.new
        expect do
          rp.callback(
            code: "the-code",
            iss: nil,
            state: "the-state",
            expected_state: "the-state",
            expected_nonce: "nonce",
            code_verifier: "the-verifier",
          )
        end.to raise_error(OidcRelyingParty::IssMismatchError)
      end
    end

    context "state と iss 両方が nil のとき" do
      it "StateMismatchError になる" do
        rp = described_class.new
        expect do
          rp.callback(
            code: "the-code",
            iss: nil,
            state: nil,
            expected_state: "the-state",
            expected_nonce: "nonce",
            code_verifier: "the-verifier",
          )
        end.to raise_error(OidcRelyingParty::StateMismatchError)
      end
    end
  end

  describe "#userinfo" do
    let(:issuer) { "https://issuer.example.com" }
    let(:token_endpoint) { "#{issuer}/token" }
    let(:jwks_uri) { "#{issuer}/jwks" }
    let(:discovery_url) { "#{issuer}/.well-known/openid-configuration" }
    let(:discovery_response) do
      {
        issuer:,
        token_endpoint:,
        jwks_uri:,
        authorization_endpoint: "#{issuer}/auth",
        userinfo_endpoint: "#{issuer}/user_info",
        response_types_supported: ["code"],
        subject_types_supported: ["public"],
        id_token_signing_alg_values_supported: ["PS256", "ES256"],
      }
    end
    let(:pkey) { OpenSSL::PKey::EC.generate("prime256v1") }
    let(:pem) { pkey.to_pem }

    before do
      allow(Settings).to receive_messages(
        oidc_issuer: issuer,
        oidc_client_id: "cid",
        oidc_signing_key: pem,
        oidc_redirect_uri: "http://localhost:3000/oidc/callback",
      )
      stub_request(:get, discovery_url).to_return(status: 200, body: discovery_response.to_json, headers: { "Content-Type" => "application/json" })
      stub_request(:get, discovery_response[:userinfo_endpoint])
        .with(headers: { "Authorization" => "Bearer AT" })
        .to_return(
          status: 200,
          body: { sub: "user-1" }.to_json,
          headers: { "Content-Type" => "application/json" },
        )
    end

    context "happy path" do
      it "UserInfo の claims を取得できる" do
        rp = described_class.new
        expect(rp.userinfo(access_token: "AT")).to include(sub: "user-1")
      end
    end
  end

  describe "#authorization_url" do
    let(:issuer) { "https://issuer.example.com" }
    let(:authorization_endpoint) { "#{issuer}/auth" }
    let(:par_endpoint) { "#{issuer}/par" }
    let(:discovery_url) { "#{issuer}/.well-known/openid-configuration" }
    let(:discovery_response) do
      {
        issuer:,
        authorization_endpoint:,
        pushed_authorization_request_endpoint: par_endpoint,
        token_endpoint: "#{issuer}/token",
        jwks_uri: "#{issuer}/jwks",
        userinfo_endpoint: "#{issuer}/user_info",
        response_types_supported: ["code"],
        subject_types_supported: ["public"],
        id_token_signing_alg_values_supported: ["PS256", "ES256"],
      }
    end
    let(:pkey) { OpenSSL::PKey::EC.generate("prime256v1") }
    let(:pem) { pkey.to_pem }

    before do
      allow(Settings).to receive_messages(
        oidc_issuer: issuer,
        oidc_client_id: "cid",
        oidc_signing_key: pem,
        oidc_redirect_uri: "http://localhost:3000/oidc/callback",
      )
      stub_request(:get, discovery_url)
        .to_return(
          status: 200,
          body: discovery_response.to_json,
          headers: { "Content-Type" => "application/json" },
        )
    end

    it "PAR に push し、client_id と request_uri だけの authorize URL を返す" do
      par_stub = stub_request(:post, par_endpoint)
        .with(
          body: hash_including(
            "response_type" => "code",
            "code_challenge" => "the-challenge",
            "client_assertion_type" => OidcClientAssertion::JWT_BEARER,
          ),
        ).to_return(
          status: 201,
          body: { request_uri: "urn:ietf:params:oauth:request_uri:abc123", expires_in: 60 }.to_json,
          headers: { "Content-Type" => "application/json" },
        )
      rp = described_class.new
      url = rp.authorization_url(code_challenge: "the-challenge", dpop_jkt: "the-dpop-jkt", state: "the-state", nonce: "the-nonce")
      expect(url).to eq("#{authorization_endpoint}?client_id=cid&request_uri=urn%3Aietf%3Aparams%3Aoauth%3Arequest_uri%3Aabc123")
      expect(par_stub).to have_been_requested
      expect(
        a_request(:post, par_endpoint).with do |req|
          assertion = URI.decode_www_form(req.body).to_h["client_assertion"]
          decode = JSON::JWT.decode(assertion, JSON::JWK.new(pkey))
          decode[:aud] == issuer && decode[:iss] == "cid" && decode[:sub] == "cid"
        end,
      ).to have_been_made
    end
  end
end
