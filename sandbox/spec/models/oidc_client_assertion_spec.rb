# frozen_string_literal: true

require "rails_helper"

RSpec.describe OidcClientAssertion do
  describe "#to_jwt" do
    let(:issuer) { "https://issuer.example.com" }
    let(:signing_jwk) { JSON::JWK.new(OpenSSL::PKey::EC.generate("prime256v1")) }

    before { freeze_time }

    it "private_key_jwt の client_assertion を生成する" do
      now = Time.current.to_i
      jwt = described_class.new(
        client_id: "cid",
        audience: issuer,
        signing_jwk:,
      ).to_jwt

      decoded = JSON::JWT.decode(jwt, signing_jwk)
      claims = decoded.to_h.symbolize_keys

      expect(claims[:iss]).to eq("cid")
      expect(claims[:sub]).to eq("cid")
      expect(claims[:aud]).to eq(issuer)
      expect(claims[:jti]).to be_a(String).and be_present
      expect(claims[:iat]).to eq(now)
      expect(claims[:exp]).to eq(now + 60)
      expect(decoded.kid).to eq(signing_jwk[:kid])
      expect(decoded.alg.to_s).to eq("ES256")
    end

    it "jti は毎回異なる" do
      jwt1 = described_class.new(client_id: "cid", audience: issuer, signing_jwk:).to_jwt
      jwt2 = described_class.new(client_id: "cid", audience: issuer, signing_jwk:).to_jwt
      decoded1 = JSON::JWT.decode(jwt1, signing_jwk).to_h.symbolize_keys
      decoded2 = JSON::JWT.decode(jwt2, signing_jwk).to_h.symbolize_keys
      expect(decoded1[:jti]).not_to eq(decoded2[:jti])
    end
  end
end
