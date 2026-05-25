# frozen_string_literal: true

require "rails_helper"

RSpec.describe OidcJwk do
  let(:pkey) { OpenSSL::PKey::EC.generate("prime256v1") }

  describe ".public_keys" do
    it "pem に対応する公開鍵の配列を返す" do
      keys = described_class.public_keys([pkey.to_pem])
      expect(keys).to be_instance_of(JSON::JWK::Set)
      key = keys.first
      expect(key.key?(:d)).to be(false)
      expect(key).to include(
        "use" => "sig",
        "alg" => "ES256",
        "kid" => JSON::JWK.new(pkey)[:kid],
        "kty" => :EC,
        "crv" => :"P-256",
        "x" => be_a(String),
        "y" => be_a(String),
      )
    end

    context "複数個のpem" do
      let(:other_pkey) { OpenSSL::PKey::EC.generate("prime256v1") }

      it "kid の異なる公開鍵の配列を返す" do
        keys = described_class.public_keys([pkey.to_pem, other_pkey.to_pem])
        key = keys.first
        other = keys.last
        expect(other["kid"]).not_to eq(key["kid"])
      end
    end
  end
end
