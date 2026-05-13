# frozen_string_literal: true

class OidcRelyingParty
  def initialize(
    issuer: Settings.oidc_issuer,
    client_id: Settings.oidc_client_id,
    redirect_uri: Settings.oidc_redirect_uri
  )
    @issuer = issuer
    @client_id = client_id
    @redirect_uri = redirect_uri
  end

  def authorization_url(code_challenge:, state:)
    OidcAuthorizationRequest.new(
      discovery: discovery,
      client_id: @client_id,
      redirect_uri: @redirect_uri,
      code_challenge_method: "S256",
      code_challenge:,
      state:,
    ).to_url
  end

  def generate_pkce
    verifier = SecureRandom.urlsafe_base64(64)
    challenge = Base64.urlsafe_encode64(Digest::SHA256.digest(verifier), padding: false)
    { verifier:, challenge: }
  end

  def generate_state
    SecureRandom.urlsafe_base64(32)
  end

  private

  def discovery
    @discovery ||= OidcDiscovery.new(issuer: @issuer)
  end
end
