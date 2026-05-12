# frozen_string_literal: true

# TODO: 本番環境や mTLS, DPoP の検証では無効化すること
if Rails.env.development?
  SWD.url_builder = URI::HTTP
  OpenIDConnect.http_config do |faraday|
    faraday.ssl.verify = false
  end
end
