# frozen_string_literal: true

require "rails_helper"

RSpec.describe OidcDpopProof do
  let(:signing_jwk) { JSON::JWK.new(OpenSSL::PKey::EC.generate("prime256v1")) }

  before do
    freeze_time
  end

  describe "#to_jwt" do
    it "typ == 'dpop+jwt' / alg == ES256 がヘッダにあること" do
      proof = described_class.new(signing_jwk:, htm: "POST", htu: "http://example.com")
      jwt = proof.to_jwt

      decoded = JSON::JWT.decode(jwt, signing_jwk)
      expect(decoded.header[:typ]).to eq("dpop+jwt")
      expect(decoded.header[:alg]).to eq("ES256")
    end

    it "jwk に d が無いこと" do
      proof = described_class.new(signing_jwk:, htm: "POST", htu: "http://example.com")
      jwt = proof.to_jwt

      decoded = JSON::JWT.decode(jwt, signing_jwk)
      jwk_header = decoded.header[:jwk]
      expect(jwk_header.keys.map(&:to_s)).not_to include("d")
    end
  end
end
