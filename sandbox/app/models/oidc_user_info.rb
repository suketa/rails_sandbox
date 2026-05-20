# frozen_string_literal: true

class OidcUserInfo
  def initialize(discovery:, access_token:)
    @discovery = discovery
    @access_token = access_token
  end

  def fetch
    uri = URI.parse(@discovery.userinfo_endpoint)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    req = Net::HTTP::Get.new(uri.path)
    req["Authorization"] = "Bearer #{@access_token}"
    res = http.request(req)
    JSON.parse(res.body, symbolize_names: true)
  end
end
