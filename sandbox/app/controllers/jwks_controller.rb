# frozen_string_literal: true

class JwksController < ApplicationController
  def show
    jwks_set = OidcJwk.public_keys([Settings.oidc_signing_key])
    render(json: jwks_set)
  end
end
