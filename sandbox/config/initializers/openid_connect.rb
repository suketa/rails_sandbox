# frozen_string_literal: true

# TODO: 本番環境や mTLS, DPoP の検証では無効化すること
if Rails.env.development?
  # issuer の scheme に追従させる:
  #   Keycloak (http)            -> 従来どおり HTTP discovery + TLS 検証なし
  #   Conformance Suite (https)  -> HTTPS discovery + TLS 検証あり
  #     (Suite の CA はコンテナ信頼ストアに導入済み。docker-compose.conformance.yml 参照)
  https = ENV["OIDC__ISSUER"].to_s.start_with?("https://")
  SWD.url_builder = https ? URI::HTTPS : URI::HTTP
  OpenIDConnect.http_config do |faraday|
    faraday.ssl.verify = https
  end
end
