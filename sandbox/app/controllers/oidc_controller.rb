# frozen_string_literal: true

class OidcController < ApplicationController
  def start
    redirect_to(OidcRelyingParty.new.authorization_url, allow_other_host: true)
  end

  def callback
  end

  def userinfo
  end
end
