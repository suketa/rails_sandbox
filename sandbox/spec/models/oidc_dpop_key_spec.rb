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
  end
end
