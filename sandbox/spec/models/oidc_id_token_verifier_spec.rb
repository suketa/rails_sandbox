# frozen_string_literal: true

require "rails_helper"

RSpec.describe OidcIdTokenVerifier do
  let(:issuer) { "https://issuer.example.com" }
  let(:jwks_uri) { "https://issuer.example.com/jwks_uri" }
  let(:discovery) { instance_double(OidcDiscovery, issuer:, jwks_uri:) }
  let(:jwk) { JSON::JWK.new(OpenSSL::PKey::RSA.generate(2048)) }
  let(:now) { Time.current.to_i }
  let(:base_claims) do
    { iss: issuer, aud: "cid", nonce: "nonce", sub: "user-1", iat: now, exp: now + 60 }
  end
  let(:claims) { base_claims }
  let(:id_token) { JSON::JWT.new(claims).tap { |j| j.kid = jwk[:kid] }.sign(jwk, :RS256).to_s }

  describe "#verify!" do
    before do
      stub_request(:get, jwks_uri).to_return(
        status: 200,
        body: JSON::JWK::Set.new(jwk).to_json,
        headers: { "Content-Type" => "application/json" },
      )
    end

    context "正しく検証できるレスポンスのとき" do
      it "認証に成功する" do
        verifier = described_class.new(id_token:, discovery:, client_id: "cid", nonce: "nonce")
        expect(verifier.verify!).to include({
          sub: "user-1",
          iss: issuer,
        })
      end
    end

    context "iss が discovery.issuer と一致しないとき" do
      let(:claims) { base_claims.merge(iss: "https://invalid.example.com") }

      it "検証に失敗する" do
        verifier = described_class.new(id_token:, discovery:, client_id: "cid", nonce: "nonce")
        expect { verifier.verify! }.to raise_error(OidcIdTokenVerifier::VerificationError, /iss/)
      end
    end

    context "aud が不一致のとき" do
      let(:claims) { base_claims.merge(aud: "invalid-cid") }

      it "検証に失敗する" do
        verifier = described_class.new(id_token:, discovery:, client_id: "cid", nonce: "nonce")
        expect { verifier.verify! }.to raise_error(OidcIdTokenVerifier::VerificationError, /aud/)
      end
    end

    context "nonce が不一致のとき" do
      let(:claims) { base_claims.merge(nonce: "invalid-nonce") }

      it "検証に失敗する" do
        verifier = described_class.new(id_token:, discovery:, client_id: "cid", nonce: "nonce")
        expect { verifier.verify! }.to raise_error(OidcIdTokenVerifier::VerificationError, /nonce/)
      end
    end
  end
end
