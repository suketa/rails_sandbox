# frozen_string_literal: true

class OidcRelyingParty
  def initialize(
    issuer: Settings.oidc_issuer,
    client_id: Settings.oidc_client_id,
    redirect_uri: Settings.oidc_redirect_uri,
    client_secret: Settings.oidc_client_secret
  )
    @issuer = issuer
    @client_id = client_id
    @redirect_uri = redirect_uri
  end

  def authorization_url(code_challenge:, state:, nonce:)
    OidcAuthorizationRequest.new(
      discovery: discovery,
      client_id: @client_id,
      redirect_uri: @redirect_uri,
      code_challenge_method: "S256",
      code_challenge:,
      state:,
      nonce:,
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

  def generate_nonce
    SecureRandom.urlsafe_base64(32)
  end

  def callback(code:, state:, expected_state:, expected_nonce:, code_verifier:)
    raise StateMismatchError unless state == expected_state

    tokens = OidcTokenExchange.new(
      discovery:,
      client_id: @client_id,
      client_secret: @client_secret,
      redirect_uri: @redirect_uri,
      code:,
      code_verifier:,
    ).tokens

    OidcIdTokenVerifier.new(
      id_token: tokens[:id_token],
      discovery:,
      client_id: @client_id,
      nonce: expected_nonce,
    ).verify!
  end

  private

  def discovery
    @discovery ||= OidcDiscovery.new(issuer: @issuer)
  end
end
