# frozen_string_literal: true

require "rails_helper"

RSpec.describe OidcUserInfo do
  let(:userinfo_endpoint) { "https://issuer.example.com/realms/test/protocol/openid-connect/userinfo" }
  let(:discovery) { instance_double(OidcDiscovery, userinfo_endpoint:) }
  let(:dpop_key) { instance_double(OidcDpopKey) }
  let(:expected_ath) { Base64.urlsafe_encode64(Digest::SHA256.digest("AT"), padding: false) }

  before do
    allow(dpop_key).to receive(:proof)
      .with(htm: "GET", htu: userinfo_endpoint, ath: expected_ath)
      .and_return("the-proof")
  end

  describe "#fetch" do
    context "結果が2XXの場合" do
      it "userinfo endpoint を DPoP で叩いて claims を返す" do
        stub = stub_request(:get, userinfo_endpoint)
          .with(headers: { "Authorization" => "DPoP AT" })
          .to_return(
            status: 200,
            body: { sub: "user-1" }.to_json,
            headers: { "Content-Type" => "application/json" },
          )
        user_info = described_class.new(discovery:, access_token: "AT", dpop_key:)
        expect(user_info.fetch).to include(sub: "user-1")
        expect(stub).to have_been_requested
      end
    end

    context "結果が2XXではない場合" do
      it "OidcUserInfo::UserInfoEndpointError が発生する" do
        stub_request(:get, userinfo_endpoint)
          .with(headers: { "Authorization" => "DPoP AT", "DPoP" => "the-proof" })
          .to_return(
            status: 401,
            body: { error: "invalid_token" }.to_json,
            headers: { "Content-Type" => "application/json" },
          )
        user_info = described_class.new(discovery:, access_token: "AT", dpop_key:)
        expect { user_info.fetch }.to raise_error(OidcUserInfo::UserInfoEndpointError)
      end
    end

    context "結果が2XXだがJSONではない場合" do
      it "OidcUserInfo::UserInfoResponseParseError が発生する" do
        stub_request(:get, userinfo_endpoint)
          .with(headers: { "Authorization" => "DPoP AT" })
          .to_return(
            status: 200,
            body: "<html><body>html</body></html>",
            headers: { "Content-Type" => "application/json" },
          )
        user_info = described_class.new(discovery:, access_token: "AT", dpop_key:)
        expect { user_info.fetch }.to raise_error(OidcUserInfo::UserInfoResponseParseError)
      end
    end

    context "use_dpop_nonce で 401 が返った場合" do
      it "nonce 付き proof で単回リトライして claims を返す" do
        allow(dpop_key).to receive(:proof)
          .with(htm: "GET", htu: userinfo_endpoint, ath: expected_ath, nonce: "the-nonce")
          .and_return("proof2")

        stub = stub_request(:get, userinfo_endpoint)
          .to_return(
            status: 401,
            headers: { "WWW-Authenticate" => 'DPoP error="use_dpop_nonce"', "DPoP-Nonce" => "the-nonce" },
          )
          .to_return(
            status: 200,
            body: { sub: "user-1" }.to_json,
            headers: { "Content-Type" => "application/json" },
          )

        user_info = described_class.new(discovery:, access_token: "AT", dpop_key:)
        expect(user_info.fetch).to include(sub: "user-1")
        expect(a_request(:get, userinfo_endpoint).with(headers: { "DPoP" => "proof2" })).to have_been_made
        expect(stub).to have_been_requested.twice
      end
    end
  end
end
