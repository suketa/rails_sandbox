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

    it "claims に htm, htu, iat, jti がある" do
      proof = described_class.new(signing_jwk:, htm: "POST", htu: "http://example.com")
      jwt = proof.to_jwt
      decoded = JSON::JWT.decode(jwt, signing_jwk)

      expect(decoded[:htm]).to eq("POST")
      expect(decoded[:htu]).to eq("http://example.com")
      expect(decoded[:iat]).to eq(Time.current.to_i)
      expect(decoded[:jti]).to be_a(String).and be_present
    end

    it "jti が2回の生成で異なる" do
      proof = described_class.new(signing_jwk:, htm: "POST", htu: "http://example.com")
      jwt1 = proof.to_jwt
      decoded1 = JSON::JWT.decode(jwt1, signing_jwk)
      jwt2 = proof.to_jwt
      decoded2 = JSON::JWT.decode(jwt2, signing_jwk)

      expect(decoded1[:jti]).not_to eq(decoded2[:jti])
    end

    it "ath 指定なら claim に含まれ、指定しなければ含まれない" do
      proof = described_class.new(signing_jwk:, htm: "POST", htu: "http://example.com", ath: "the-ath")
      jwt = proof.to_jwt
      decoded = JSON::JWT.decode(jwt, signing_jwk)
      expect(decoded[:ath]).to eq("the-ath")

      proof = described_class.new(signing_jwk:, htm: "POST", htu: "http://example.com")
      jwt = proof.to_jwt
      decoded = JSON::JWT.decode(jwt, signing_jwk)
      expect(decoded.key?(:ath)).to be(false)
    end

    it "nonce 指定なら claim に含まれ、指定しなければ含まれない" do
      proof = described_class.new(signing_jwk:, htm: "POST", htu: "http://example.com", nonce: "the-nonce")
      jwt = proof.to_jwt
      decoded = JSON::JWT.decode(jwt, signing_jwk)
      expect(decoded[:nonce]).to eq("the-nonce")

      proof = described_class.new(signing_jwk:, htm: "POST", htu: "http://example.com")
      jwt = proof.to_jwt
      decoded = JSON::JWT.decode(jwt, signing_jwk)
      expect(decoded.key?(:nonce)).to be(false)
    end

    it "header に埋め込んだ公開鍵でのみ検証できる" do
      proof = described_class.new(signing_jwk:, htm: "POST", htu: "http://example.com", nonce: "the-nonce")
      jwt = proof.to_jwt
      decoded = JSON::JWT.decode(jwt, signing_jwk)
      embedded_key = JSON::JWK.new(decoded.header[:jwk])

      expect { JSON::JWT.decode(jwt, embedded_key) }.not_to raise_error

      other_key = JSON::JWK.new(OpenSSL::PKey::EC.generate("prime256v1"))
      expect { JSON::JWT.decode(jwt, other_key) }.to raise_error(JSON::JWS::VerificationFailed)
    end
  end
end
