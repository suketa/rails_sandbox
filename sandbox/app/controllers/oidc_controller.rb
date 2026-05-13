# frozen_string_literal: true

class OidcController < ApplicationController
  def start
    rp = OidcRelyingParty.new
    pkce = rp.generate_pkce
    session[:oidc_code_verifier] = pkce[:verifier]
    redirect_to(rp.authorization_url(code_challenge: pkce[:challenge]), allow_other_host: true)
  end

  def callback
  end

  def userinfo
  end
end
