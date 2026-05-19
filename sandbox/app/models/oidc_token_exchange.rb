# frozen_string_literal: true

class OidcTokenExchange
  def initialize(
    discovery:,
    client_id:,
    client_secret:,
    redirect_uri:,
    code:,
    code_verifier:
  )
    @discovery = discovery
    @client_id = client_id
    @client_secret = client_secret
    @redirect_uri = redirect_uri
    @code = code
    @code_verifier = code_verifier
  end

  def tokens
    uri = URI.parse(@discovery.token_endpoint)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    req = Net::HTTP::Post.new(uri.path)
    req.form_data = {
      code: @code,
      code_verifier: @code_verifier,
      grant_type: "authorization_code",
      redirect_uri: @redirect_uri,
    }
    req.basic_auth(@client_id, @client_secret)
    res = http.request(req)
    case res
    when Net::HTTPSuccess
      json = JSON.parse(res.body)
      { access_token: json["access_token"], id_token: json["id_token"] }
    else
      # TODO: We should define appropriate error class
      raise "TODO: fix error handling when response is not Net::HTTPSuccess"
    end
  end
end
