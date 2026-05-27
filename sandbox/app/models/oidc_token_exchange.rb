# frozen_string_literal: true

class OidcTokenExchange
  class TokenEndpointError < OidcError; end
  class TokenResponseParseError < OidcError; end

  def initialize(
    discovery:,
    client_assertion:,
    dpop_key:,
    redirect_uri:,
    code:,
    code_verifier:
  )
    @discovery = discovery
    @client_assertion = client_assertion
    @dpop_key = dpop_key
    @redirect_uri = redirect_uri
    @code = code
    @code_verifier = code_verifier
  end

  def tokens
    body = fetch_token_response
    json = JSON.parse(body)
    { access_token: json["access_token"], id_token: json["id_token"], token_type: json["token_type"] }
  rescue JSON::ParserError
    raise TokenResponseParseError, "failed to parse response body"
  end

  private

  def fetch_token_response
    res = post_token
    res = post_token(nonce: res["DPoP-Nonce"]) if use_dpop_nonce?(res)
    case res
    when Net::HTTPSuccess then res.body
    else raise TokenEndpointError, "status=#{res.code}"
    end
  end

  def post_token(nonce: nil)
    uri = URI.parse(@discovery.token_endpoint)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    req = Net::HTTP::Post.new(uri.path)
    req["DPoP"] = dpop_proof(nonce:)
    req.form_data = {
      code: @code,
      code_verifier: @code_verifier,
      grant_type: "authorization_code",
      redirect_uri: @redirect_uri,
    }.merge(@client_assertion.to_params)
    http.request(req)
  end

  def dpop_proof(nonce:)
    ep = @discovery.token_endpoint
    nonce ? @dpop_key.proof(htm: "POST", htu: ep, nonce:) : @dpop_key.proof(htm: "POST", htu: ep)
  end

  def use_dpop_nonce?(res)
    return false unless res.code == "400" && res["DPoP-Nonce"]

    JSON.parse(res.body)["error"] == "use_dpop_nonce"
  rescue JSON::ParserError
    false
  end
end
