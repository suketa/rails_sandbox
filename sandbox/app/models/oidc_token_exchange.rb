# frozen_string_literal: true

class OidcTokenExchange
  class TokenEndpointError < OidcError; end
  class TokenResponseParseError < OidcError; end

  def initialize(
    discovery:,
    client_assertion:,
    redirect_uri:,
    code:,
    code_verifier:
  )
    @discovery = discovery
    @client_assertion = client_assertion
    @redirect_uri = redirect_uri
    @code = code
    @code_verifier = code_verifier
  end

  def tokens
    body = fetch_token_response
    json = JSON.parse(body)
    { access_token: json["access_token"], id_token: json["id_token"] }
  rescue JSON::ParserError
    raise TokenResponseParseError, "failed to parse response body"
  end

  private

  def fetch_token_response
    uri = URI.parse(@discovery.token_endpoint)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    req = Net::HTTP::Post.new(uri.path)
    req.form_data = {
      code: @code,
      code_verifier: @code_verifier,
      grant_type: "authorization_code",
      redirect_uri: @redirect_uri,
    }.merge(@client_assertion.to_params)
    res = http.request(req)
    case res
    when Net::HTTPSuccess
      res.body
    else
      raise TokenEndpointError, "status=#{res.code}"
    end
  end
end
