# frozen_string_literal: true

class OidcRelyingParty
  class StateMismatchError < OidcError; end
  class IssMismatchError < OidcError; end

  class << self
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
  end

  def initialize(
    issuer: Settings.oidc_issuer,
    client_id: Settings.oidc_client_id,
    redirect_uri: Settings.oidc_redirect_uri,
    signing_key_pem: Settings.oidc_signing_key
  )
    @issuer = issuer
    @client_id = client_id
    @redirect_uri = redirect_uri
    @signing_jwk = build_jwk(signing_key_pem)
  end

  def authorization_url(code_challenge:, state:, nonce:)
    auth = OidcAuthorizationRequest.new(
      discovery: discovery,
      client_id: @client_id,
      redirect_uri: @redirect_uri,
      code_challenge_method: "S256",
      code_challenge:,
      state:,
      nonce:,
    )
    request_uri = OidcPushedAuthorizationRequest.new(
      discovery:,
      client_assertion:,
      params: auth.to_params,
    ).request_uri
    auth.authorization_redirect_url(request_uri)
  end

  def callback(code:, iss:, state:, expected_state:, expected_nonce:, code_verifier:)
    raise StateMismatchError unless state == expected_state
    raise IssMismatchError unless iss == discovery.issuer

    tokens = OidcTokenExchange.new(
      discovery:,
      client_assertion:,
      redirect_uri: @redirect_uri,
      code:,
      code_verifier:,
    ).tokens

    claims = OidcIdTokenVerifier.new(
      id_token: tokens[:id_token],
      discovery:,
      client_id: @client_id,
      nonce: expected_nonce,
      allowed_algs: discovery.id_token_signing_alg_values_supported,
    ).verify!

    { access_token: tokens[:access_token], claims: }
  end

  def userinfo(access_token:)
    OidcUserInfo.new(discovery:, access_token:).fetch
  end

  private

  def discovery
    @discovery ||= OidcDiscovery.new(issuer: @issuer)
  end

  def build_jwk(pem)
    JSON::JWK.new(OpenSSL::PKey::EC.new(pem))
  end

  def client_assertion
    OidcClientAssertion.new(
      client_id: @client_id,
      audience: @issuer,
      signing_jwk: @signing_jwk,
    )
  end
end
