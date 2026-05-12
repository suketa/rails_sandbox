# frozen_string_literal: true

class Settings
  class << self
    def oidc_issuer
      ENV.fetch('OIDC__ISSUER') do
        Rails.application.credentials.dig(:oidc, :issuer)
      end
    end
  end
end
