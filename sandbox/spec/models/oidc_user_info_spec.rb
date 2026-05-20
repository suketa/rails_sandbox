# frozen_string_literal: true

require "rails_helper"

RSpec.describe OidcUserInfo do
  let(:userinfo_endpoint) { "https://issuer.example.com/realms/test/protocol/openid-connect/userinfo" }
  let(:discovery) { instance_double(OidcDiscovery, userinfo_endpoint:) }

  describe "#fetch" do
    it "userinfo endpoint を Bearer で叩いて claims を返す" do
      stub = stub_request(:get, userinfo_endpoint)
        .with(headers: { "Authorization" => "Bearer AT" })
        .to_return(
          status: 200,
          body: { sub: "user-1" }.to_json,
          headers: { "Content-Type" => "application/json" },
        )
      user_info = described_class.new(discovery:, access_token: "AT")
      expect(user_info.fetch).to include(sub: "user-1")
      expect(stub).to have_been_requested
    end
  end
end
