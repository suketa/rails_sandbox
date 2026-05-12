# frozen_string_literal: true

class Settings
  PASSWORD='p@ssw0rd1!'
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
  end
end
