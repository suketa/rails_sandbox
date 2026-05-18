# frozen_string_literal: true

require "rails_helper"

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

    def oidc_client_secret
      ENV.fetch("OIDC__CLIENT_SECRET") do
        Rails.application.credentials.dig(:oidc, :client_secret)
      end
    end
  end
end
