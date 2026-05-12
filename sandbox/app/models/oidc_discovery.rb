# frozen_string_literal: true

class OidcDiscovery
  class << self
    def config
      OpenIDConnect::Discovery::Provider::Config.discover!(Settings.oidc_issuer)
    end
  end
end
