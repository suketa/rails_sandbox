# frozen_string_literal: true

class OidcUserInfo
  class UserInfoEndpointError < OidcError; end
  class UserInfoResponseParseError < OidcError; end

  def initialize(discovery:, access_token:)
    @discovery = discovery
    @access_token = access_token
  end

  def fetch
    body = fetch_userinfo_response
    JSON.parse(body, symbolize_names: true)
  rescue JSON::ParserError
    raise UserInfoResponseParseError, "failed to parse response body"
  end

  private

  def fetch_userinfo_response
    uri = URI.parse(@discovery.userinfo_endpoint)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    req = Net::HTTP::Get.new(uri.path)
    req["Authorization"] = "Bearer #{@access_token}"
    res = http.request(req)
    case res
    when Net::HTTPSuccess
      res.body
    else
      raise UserInfoEndpointError, "status=#{res.code}"
    end
  end
end
