# frozen_string_literal: true

class OidcAuthorizationRequest
  def initialize(
    discovery:,
    client_id:,
    redirect_uri:,
    code_challenge:,
    code_challenge_method:,
    state:,
    nonce:,
    scope: "openid"
  )
    @discovery = discovery
    @client_id = client_id
    @redirect_uri = redirect_uri
    @code_challenge = code_challenge
    @code_challenge_method = code_challenge_method
    @state = state
    @nonce = nonce
    @scope = scope
  end

  def authorization_redirect_url(request_uri)
    uri = URI(@discovery.authorization_endpoint)
    uri.query = URI.encode_www_form(
      {
        client_id: @client_id,
        request_uri:,
      },
    )
    uri.to_s
  end

  def to_params
    {
      response_type: "code",
      client_id: @client_id,
      redirect_uri: @redirect_uri,
      code_challenge: @code_challenge,
      code_challenge_method: @code_challenge_method,
      scope: @scope,
      state: @state,
      nonce: @nonce,
    }
  end

  # OIDC 用。FAPI2.0 では使用しない。
  def to_url
    uri = URI(@discovery.authorization_endpoint)
    uri.query = URI.encode_www_form(to_params)
    uri.to_s
  end
end
