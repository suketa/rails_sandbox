# frozen_string_literal: true

class OidcDiscovery
  module UrlBuilder
    def authorization_url
      uri = URI(authorization_endpoint)
      uri.query = URI.encode_www_form(
        response_type: "code",
        client_id: Settings.oidc_client_id,
        redirect_uri: Settings.oidc_redirect_uri,
        scope: "openid",
      )
      uri.to_s
    end
  end
end
