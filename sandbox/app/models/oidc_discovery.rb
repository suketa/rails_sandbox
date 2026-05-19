# frozen_string_literal: true

class OidcDiscovery
  def initialize(issuer:)
    @issuer = issuer
  end

  def config
    Rails.cache.fetch("oidc:discovery:#{@issuer}", expires_in: 1.hour) do
      result = OpenIDConnect::Discovery::Provider::Config.discover!(@issuer)
      {
        authorization_endpoint: result.authorization_endpoint,
        token_endpoint: result.token_endpoint,
        userinfo_endpoint: result.userinfo_endpoint,
        jwks_uri: result.jwks_uri,
        issuer: result.issuer,
        pushed_authorization_request_endpoint: result.raw["pushed_authorization_request_endpoint"],
        id_token_signing_alg_values_supported: result.raw["id_token_signing_alg_values_supported"],
      }
    end
  end

  def authorization_endpoint
    config[:authorization_endpoint]
  end

  def token_endpoint
    config[:token_endpoint]
  end

  def userinfo_endpoint
    config[:userinfo_endpoint]
  end

  def jwks_uri
    config[:jwks_uri]
  end

  def issuer
    config[:issuer]
  end

  def pushed_authorization_request_endpoint
    config[:pushed_authorization_request_endpoint]
  end

  def id_token_signing_alg_values_supported
    config[:id_token_signing_alg_values_supported]
  end
end
