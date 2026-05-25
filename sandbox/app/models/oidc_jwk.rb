# frozen_string_literal: true

class OidcJwk
  class << self
    def public_keys(pems)
      jwks = pems.map do |pem|
        JSON::JWK.new(OpenSSL::PKey::EC.new(pem)).except(:d).merge(use: "sig", alg: "ES256")
      end
      JSON::JWK::Set.new(jwks)
    end
  end
end
