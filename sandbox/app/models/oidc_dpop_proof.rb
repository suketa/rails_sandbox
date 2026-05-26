# frozen_string_literal: true

class OidcDpopProof
  ALG = :ES256

  def initialize(signing_jwk:, htm:, htu:)
    @signing_jwk = signing_jwk
    @htm = htm
    @htu = htu
  end

  def to_jwt
    payload = {
    }
    JSON::JWT.new(payload).tap do |j|
      j.header[:typ] = "dpop+jwt"
      j.header[:jwk] = @signing_jwk.normalize
      j.kid = @signing_jwk[:kid]
    end.sign(@signing_jwk, ALG).to_s
  end
end
