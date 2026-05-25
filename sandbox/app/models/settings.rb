# frozen_string_literal: true

class Settings
  class << self
    def oidc_issuer
      ENV.fetch("OIDC__ISSUER") do
        Rails.application.credentials.dig(:oidc, :issuer)
      end
    end

    def oidc_client_id
      ENV.fetch("OIDC__CLIENT_ID") do
        Rails.application.credentials.dig(:oidc, :client_id)
      end
    end

    def oidc_redirect_uri
      ENV.fetch("OIDC__REDIRECT_URI") do
        Rails.application.credentials.dig(:oidc, :redirect_uri)
      end
    end

    def oidc_signing_key
      raw = ENV.fetch("OIDC__SIGNING_KEY") do
        Rails.application.credentials.dig(:oidc, :signing_key)
      end
      Base64.strict_decode64(raw)
    end
  end
end
