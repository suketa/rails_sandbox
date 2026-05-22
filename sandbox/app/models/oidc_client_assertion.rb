# frozen_string_literal: true

class OidcClientAssertion
  LIFETIME_SECONDS = 60
  ALG = :ES256
  JWT_BEARER = "urn:ietf:params:oauth:client-assertion-type:jwt-bearer"

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
    JSON::JWT.new(payload).tap { |j| j.kid = @signing_jwk[:kid] }.sign(@signing_jwk, ALG).to_s
  end

  def to_params
    {
      client_assertion_type: JWT_BEARER,
      client_assertion: to_jwt,
    }
  end
end
