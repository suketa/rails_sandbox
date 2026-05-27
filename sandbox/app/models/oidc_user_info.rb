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
    res = get_userinfo
    res = get_userinfo(nonce: res["DPoP-Nonce"]) if use_dpop_nonce?(res)
    case res
    when Net::HTTPSuccess then res.body
    else raise UserInfoEndpointError, "status=#{res.code}"
    end
  end

  def get_userinfo(nonce: nil)
    endpoint = @discovery.userinfo_endpoint
    uri = URI.parse(endpoint)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    req = Net::HTTP::Get.new(uri.path)
    req["Authorization"] = "DPoP #{@access_token}"
    req["DPoP"] = dpop_proof(nonce:)
    http.request(req)
  end

  def dpop_proof(nonce:)
    endpoint = @discovery.userinfo_endpoint
    ath = Base64.urlsafe_encode64(Digest::SHA256.digest(@access_token), padding: false)
    nonce ? @dpop_key.proof(htm: "GET", htu: endpoint, ath:, nonce:) : @dpop_key.proof(htm: "GET", htu: endpoint, ath:)
  end

  def use_dpop_nonce?(res)
    return false unless res.code == "401" && res["DPoP-Nonce"]

    res["WWW-Authenticate"].to_s.include?('error="use_dpop_nonce"')
  end
end
