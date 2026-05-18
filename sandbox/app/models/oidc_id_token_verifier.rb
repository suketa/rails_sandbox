# frozen_string_literal: true

class OidcIdTokenVerifier
  class VerificationError < StandardError; end

  def initialize(id_token:, discovery:, client_id:, nonce:)
    @id_token = id_token
    @discovery = discovery
    @client_id = client_id
    @nonce = nonce
  end

  def verify!
    jwk_set = JSON::JWK::Set.new(fetch_jwk_json)
    claims = JSON::JWT.decode(@id_token, jwk_set).to_h.symbolize_keys

    verify_iss!(claims)

    claims
  end

  private

  def verify_iss!(claims)
    raise VerificationError, "iss mismatch" if claims[:iss] != @discovery.issuer
  end

  def fetch_jwk_json
    uri = URI.parse(@discovery.jwks_uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    req = Net::HTTP::Get.new(uri.path)
    res = http.request(req)
    JSON.parse(res.body)
  end
end
