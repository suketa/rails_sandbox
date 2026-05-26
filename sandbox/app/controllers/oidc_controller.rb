# frozen_string_literal: true

class OidcController < ApplicationController
  def start
    rp = OidcRelyingParty.new
    pkce = OidcRelyingParty.generate_pkce
    state = OidcRelyingParty.generate_state
    nonce = OidcRelyingParty.generate_nonce
    dpop_key = OidcDpopKey.generate
    session[:oidc_code_verifier] = pkce[:verifier]
    session[:oidc_state] = state
    session[:oidc_nonce] = nonce
    session[:oidc_dpop_key_pem] = dpop_key.to_pem
    redirect_to(rp.authorization_url(code_challenge: pkce[:challenge], dpop_jkt: dpop_key.thumbprint, state:, nonce:), allow_other_host: true)
  end

  def callback
    rp = OidcRelyingParty.new
    dpop_key = OidcDpopKey.from_pem(session[:oidc_dpop_key_pem])

    result = rp.callback(
      code: params[:code],
      iss: params[:iss],
      state: params[:state],
      expected_state: session[:oidc_state],
      expected_nonce: session[:oidc_nonce],
      code_verifier: session[:oidc_code_verifier],
      dpop_key:,
    )
    session.delete(:oidc_state)
    session.delete(:oidc_nonce)
    session.delete(:oidc_code_verifier)
    session[:oidc_access_token] = result[:access_token]

    redirect_to(oidc_userinfo_path)
  end

  def userinfo
    rp = OidcRelyingParty.new
    @userinfo = rp.userinfo(access_token: session[:oidc_access_token])
  end
end
