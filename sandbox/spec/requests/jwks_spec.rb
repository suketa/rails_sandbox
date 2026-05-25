# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Jwks" do
  let(:pkey) { OpenSSL::PKey::EC.generate("prime256v1") }
  let(:pem) { pkey.to_pem }

  before do
    allow(Settings).to receive(:oidc_signing_key).and_return(pem)
  end

  describe "GET /jwks.json" do
    it "keys を返す" do
      get "/jwks.json"
      json = response.parsed_body
      expect(json["keys"]).to be_instance_of(Array)
      key = json["keys"].first
      expect(key.key?("d")).to be(false)
    end
  end
end
