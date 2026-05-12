# frozen_string_literal: true

class OidcRelyingParty
  def initialize(
    issuer: Settings.oidc_issuer,
    client_id: Settings.oidc_client_id,
    redirect_uri: Settings.oidc_redirect_uri
  )
    @issuer = issuer
    @client_id = client_id
    @redirect_uri = redirect_uri
  end

  def authorization_url
    OidcAuthorizationRequest.new(
      discovery: discovery,
      client_id: @client_id,
      redirect_uri: @redirect_uri,
    ).to_url
  end

  private

  def discovery
    @discovery ||= OidcDiscovery.new(issuer: @issuer)
  end
end
