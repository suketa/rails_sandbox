# frozen_string_literal: true

require "rails_helper"

RSpec.describe OidcDpopKey do
  describe ".generate" do
    it "keyを生成する" do
      key = described_class.generate
      decoded = JSON::JWT.decode(key.proof(htm: "POST", htu: "http://e"), :skip_verification)
      expect(decoded.header[:jwk]["kty"]).to eq("EC")
      expect(decoded.header[:jwk]["crv"]).to eq("P-256")
    end
  end

  describe "#thumbprint" do
    it "pem 往復で同一鍵になる" do
      key = described_class.generate
      expect(described_class.from_pem(key.to_pem).thumbprint).to eq(key.thumbprint)
    end

    it "43文字 (base64url)になる" do
      expect(described_class.generate.thumbprint).to match(/\A[A-Za-z0-9_-]{43}\z/)
    end
  end

  describe "#proof" do
    it "鍵で署名されているjwk の thumbprint が一致する" do
      key = described_class.generate
      jwt = key.proof(htm: "POST", htu: "http://example.com")
      decoded = JSON::JWT.decode(jwt, :skip_verification)

      # この鍵で署名されている＝埋め込み jwk の thumbprint が一致
      expect(JSON::JWK.new(decoded.header[:jwk]).thumbprint).to eq(key.thumbprint)
      expect { JSON::JWT.decode(jwt, JSON::JWK.new(decoded.header[:jwk])) }.not_to raise_error

      # 別鍵では失敗
      other_key = JSON::JWK.new(OpenSSL::PKey::EC.generate("prime256v1"))
      expect { JSON::JWT.decode(jwt, other_key) }.to raise_error(JSON::JWS::VerificationFailed)
    end

    it "ath を渡すと proof の payload に乗る" do
      key = described_class.generate
      decoded = JSON::JWT.decode(key.proof(htm: "GET", htu: "http://e", ath: "the-ath"), :skip_verification)
      expect(decoded["ath"]).to eq("the-ath")
    end

    it "nonce を渡すと proof の payload に乗る" do
      key = described_class.generate
      decoded = JSON::JWT.decode(key.proof(htm: "GET", htu: "http://e", ath: "the-ath", nonce: "the-nonce"), :skip_verification)
      expect(decoded["ath"]).to eq("the-ath")
      expect(decoded["nonce"]).to eq("the-nonce")
    end
  end
end
