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
    # TODO: remove render(plain: ...)
    # currently, this render is to verify keycloak integration works fine.
    render(plain: {
      params: params.to_unsafe_h,
      session_state: session[:oidc_state],
      session_nonce: session[:oidc_nonce],
      session_verifier_present: session[:oidc_code_verifier].present?,
    })
  end

  def userinfo
  end
end
