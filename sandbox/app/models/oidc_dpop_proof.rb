# frozen_string_literal: true

class OidcDpopProof
  ALG = :ES256

  def initialize(signing_jwk:, htm:, htu:, ath: nil, nonce: nil)
    @signing_jwk = signing_jwk
    @htm = htm
    @htu = htu
    @ath = ath
    @nonce = nonce
  end

  def to_jwt
    payload = {
      htm: @htm,
      htu: @htu,
      jti: SecureRandom.uuid,
      iat: Time.current.to_i,
    }
    payload = payload.merge(ath: @ath) if @ath.present?
    payload = payload.merge(nonce: @nonce) if @nonce.present?

    JSON::JWT.new(payload).tap do |j|
      j.header[:typ] = "dpop+jwt"
      j.header[:jwk] = @signing_jwk.normalize
    end.sign(@signing_jwk, ALG).to_s
  end
end
