# frozen_string_literal: true

class OidcPushedAuthorizationRequest
  class ParEndpointError < OidcError; end
  class ParResponseParseError < OidcError; end

  def initialize(
    discovery:,
    client_assertion:,
    params:
  )
    @discovery = discovery
    @client_assertion = client_assertion
    @params = params
  end

  def request_uri
    body = fetch_request_uri_response
    json = JSON.parse(body)
    json["request_uri"]
  rescue JSON::ParserError
    raise ParResponseParseError, "failed to parse response body"
  end

  private

  def fetch_request_uri_response
    uri = URI.parse(@discovery.pushed_authorization_request_endpoint)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    req = Net::HTTP::Post.new(uri.path)
    req.form_data = @params.merge(@client_assertion.to_params)
    res = http.request(req)
    case res
    when Net::HTTPSuccess
      res.body
    else
      raise ParEndpointError, "status=#{res.code}"
    end
  end
end
