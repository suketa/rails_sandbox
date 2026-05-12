# frozen_string_literal: true

require "rails_helper"

RSpec.describe OidcDiscovery do
  let(:issuer) { "https://issuer.example.com/realms/test" }
  let(:discovery_url) { "#{issuer}/.well-known/openid-configuration" }
  let(:discovery_response) do
    {
      issuer: issuer,
      authorization_endpoint: "#{issuer}/protocol/openid-connect/auth",
      token_endpoint: "#{issuer}/protocol/openid-connect/token",
      userinfo_endpoint: "#{issuer}/protocol/openid-connect/userinfo",
      jwks_uri: "#{issuer}/protocol/openid-connect/certs",
      pushed_authorization_request_endpoint: "#{issuer}/protocol/openid-connect/ext/par/request",
      response_types_supported: ["code"],
      subject_types_supported: ["public"],
      id_token_signing_alg_values_supported: ["PS256", "ES256"],
    }
  end

  before do
    stub_request(:get, discovery_url)
      .to_return(
        status: 200,
        body: discovery_response.to_json,
        headers: { "Content-Type" => "application/json" },
      )
  end

  describe "#config" do
    it "returns a hash with all expected keys and values" do
      discovery = described_class.new(issuer:)
      expected = discovery_response.slice(
        :issuer,
        :authorization_endpoint,
        :token_endpoint,
        :userinfo_endpoint,
        :jwks_uri,
        :pushed_authorization_request_endpoint,
      )
      expect(discovery.config).to eq(expected)
    end
  end

  describe "#authorization_endpoint" do
    it "returns authorization endpoint" do
      discovery = described_class.new(issuer:)
      expect(discovery.authorization_endpoint).to eq(discovery_response[:authorization_endpoint])
    end
  end

  describe "#token_endpoint" do
    it "returns token endpoint" do
      discovery = described_class.new(issuer:)
      expect(discovery.token_endpoint).to eq(discovery_response[:token_endpoint])
    end
  end

  describe "#userinfo_endpoint" do
    it "returns userinfo endpoint" do
      discovery = described_class.new(issuer:)
      expect(discovery.userinfo_endpoint).to eq(discovery_response[:userinfo_endpoint])
    end
  end

  describe "#jwks_uri" do
    it "returns jwks uri" do
      discovery = described_class.new(issuer:)
      expect(discovery.jwks_uri).to eq(discovery_response[:jwks_uri])
    end
  end

  describe "#issuer" do
    it "returns issuer" do
      discovery = described_class.new(issuer:)
      expect(discovery.issuer).to eq(discovery_response[:issuer])
    end
  end

  describe "#pushed_authorization_request_endpoint" do
    it "returns pushed authorization request endpoint" do
      discovery = described_class.new(issuer:)
      expect(discovery.pushed_authorization_request_endpoint).to eq(discovery_response[:pushed_authorization_request_endpoint])
    end
  end
end
