# frozen_string_literal: true

class OidcController < ApplicationController
  def start
    rp = OidcRelyingParty.new
    pkce = rp.generate_pkce
    state = rp.generate_state
    session[:oidc_code_verifier] = pkce[:verifier]
    session[:oidc_state] = state
    redirect_to(rp.authorization_url(code_challenge: pkce[:challenge], state:), allow_other_host: true)
  end

  def callback
  end

  def userinfo
  end
end
