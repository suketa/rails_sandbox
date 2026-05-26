# frozen_string_literal: true

class OidcDpopKey
  class << self
    def generate
      new(OpenSSL::PKey::EC.generate("prime256v1"))
    end

    def from_pem(pem)
      new(OpenSSL::PKey::EC.new(pem))
    end
  end

  delegate :to_pem, to: :@ec
  delegate :thumbprint, to: :jwk

  def initialize(ec)
    @ec = ec
  end

  def proof(htm:, htu:, ath: nil)
    OidcDpopProof.new(signing_jwk: jwk, htm:, htu:, ath:).to_jwt
  end

  private

  def jwk
    @jwk ||= JSON::JWK.new(@ec)
  end
end
