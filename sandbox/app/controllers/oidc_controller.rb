# frozen_string_literal: true

class OidcController < ApplicationController
  def start
    rp = OidcRelyingParty.new
    pkce = rp.generate_pkce
    state = rp.generate_state
    nonce = rp.generate_nonce
    session[:oidc_code_verifier] = pkce[:verifier]
    session[:oidc_state] = state
    session[:oidc_nonce] = nonce
    redirect_to(rp.authorization_url(code_challenge: pkce[:challenge], state:, nonce:), allow_other_host: true)
  end

  def callback
  end

  def userinfo
  end
end
