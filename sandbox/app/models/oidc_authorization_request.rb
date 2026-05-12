# frozen_string_literal: true

class OidcAuthorizationRequest
  def initialize(discovery:, client_id:, redirect_uri:, code_challenge:, code_challenge_method:, scope: "openid")
    @discovery = discovery
    @client_id = client_id
    @redirect_uri = redirect_uri
    @code_challenge = code_challenge
    @code_challenge_method = code_challenge_method
    @scope = scope
  end

  def to_url
    uri = URI(@discovery.authorization_endpoint)
    uri.query = URI.encode_www_form(
      response_type: "code",
      client_id: @client_id,
      redirect_uri: @redirect_uri,
      code_challenge: @code_challenge,
      code_challenge_method: @code_challenge_method,
      scope: @scope,
    )
    uri.to_s
  end
end
