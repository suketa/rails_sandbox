# frozen_string_literal: true

class OidcClientAssertion
  LIFETIME_SECONDS = 60

  def initialize(client_id:, audience:, signing_jwk:)
    @client_id = client_id
    @audience = audience
    @signing_jwk = signing_jwk
  end

  def to_jwt
    now = Time.current.to_i
    payload = {
      iss: @client_id,
      sub: @client_id,
      aud: @audience,
      jti: SecureRandom.uuid,
      iat: now,
      exp: now + LIFETIME_SECONDS,
    }
    JSON::JWT.new(payload).tap { |j| j.kid = @signing_jwk[:kid] }.sign(@signing_jwk, :ES256).to_s
  end
end
