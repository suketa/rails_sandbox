# frozen_string_literal: true

class OidcController < ApplicationController
  def start
    rp = OidcRelyingParty.new
    pkce = OidcRelyingParty.generate_pkce
    state = OidcRelyingParty.generate_state
    nonce = OidcRelyingParty.generate_nonce
    session[:oidc_code_verifier] = pkce[:verifier]
    session[:oidc_state] = state
    session[:oidc_nonce] = nonce
    redirect_to(rp.authorization_url(code_challenge: pkce[:challenge], state:, nonce:), allow_other_host: true)
  end

  def callback
    rp = OidcRelyingParty.new
    result = rp.callback(
      code: params[:code],
      iss: params[:iss],
      state: params[:state],
      expected_state: session[:oidc_state],
      expected_nonce: session[:oidc_nonce],
      code_verifier: session[:oidc_code_verifier],
    )
    session.delete(:oidc_state)
    session.delete(:oidc_nonce)
    session.delete(:oidc_code_verifier)
    session[:oidc_access_token] = result[:access_token]

    redirect_to(oidc_userinfo_path)
  end

  def userinfo
  end
end
