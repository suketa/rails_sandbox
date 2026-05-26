# frozen_string_literal: true

class OidcUserInfo
  class UserInfoEndpointError < OidcError; end
  class UserInfoResponseParseError < OidcError; end

  def initialize(discovery:, access_token:, dpop_key:)
    @discovery = discovery
    @access_token = access_token
    @dpop_key = dpop_key
  end

  def fetch
    body = fetch_userinfo_response
    JSON.parse(body, symbolize_names: true)
  rescue JSON::ParserError
    raise UserInfoResponseParseError, "failed to parse response body"
  end

  private

  def fetch_userinfo_response
    endpoint = @discovery.userinfo_endpoint
    uri = URI.parse(endpoint)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    req = Net::HTTP::Get.new(uri.path)
    ath = Base64.urlsafe_encode64(Digest::SHA256.digest(@access_token), padding: false)
    req["Authorization"] = "DPoP #{@access_token}"
    req["DPoP"] = @dpop_key.proof(htm: "GET", htu: endpoint, ath:)
    res = http.request(req)
    case res
    when Net::HTTPSuccess
      res.body
    else
      raise UserInfoEndpointError, "status=#{res.code}"
    end
  end
end
