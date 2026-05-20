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
    let(:now) { Time.current.to_i }
    let(:claims) do
      { iss: issuer, aud: "cid", nonce: "nonce", sub: "user-1", iat: now, exp: now + 60 }
    end
    let(:id_token) { JSON::JWT.new(claims).tap { |j| j.kid = jwk[:kid] }.sign(jwk, :PS256).to_s }

    before do
      allow(Settings).to receive_messages(
        oidc_issuer: issuer,
        oidc_client_id: "cid",
        oidc_client_secret: "secret",
        oidc_redirect_uri: "http://localhost:3000/oidc/callback",
      )
      stub_request(:get, discovery_url).to_return(status: 200, body: discovery_response.to_json, headers: { "Content-Type" => "application/json" })
      stub_request(:post, token_endpoint)
        .with(basic_auth: ["cid", "secret"])
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
    let(:userinfo_endpoint) { "https://issuer.example.com/realms/test/protocol/openid-connect/userinfo" }
    let(:discovery) { instance_double(OidcDiscovery, userinfo_endpoint:) }
    before do
      stub_request(:get, userinfo_endpoint)
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
end
