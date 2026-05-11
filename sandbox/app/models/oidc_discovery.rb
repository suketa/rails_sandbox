# frozen_string_literal: true

class OidcDiscovery
  class << self
    def config
      url = Settings.oidc_issuer + '/.well-known/openid-configuration'
      OpenIDConnect::Discovery::Provider::Config.discover!(url)
    end
  end
end
