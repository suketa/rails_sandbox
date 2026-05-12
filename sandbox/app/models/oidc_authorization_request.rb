# frozen_string_literal: true

class OidcAuthorizationRequest
  def initialize(discovery:, client_id:, redirect_uri:, scope: "openid")
    @discovery = discovery
    @client_id = client_id
    @redirect_uri = redirect_uri
    @scope = scope
  end

  def to_url
    uri = URI(@discovery.authorization_endpoint)
    uri.query = URI.encode_www_form(
      response_type: "code",
      client_id: @client_id,
      redirect_uri: @redirect_uri,
      scope: @scope,
    )
    uri.to_s
  end
end
