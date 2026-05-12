# frozen_string_literal: true

class OidcController < ApplicationController
  def start
    oidc = OidcDiscovery.new(issuer: Settings.oidc_issuer)
    redirect_to(oidc.authorization_url, allow_other_host: true)
  end

  def callback
  end

  def userinfo
  end
end
