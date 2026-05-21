# frozen_string_literal: true

require "rails_helper"

RSpec.describe OidcAuthorizationRequest do
  describe "#to_params" do
    let(:discovery) { instance_double(OidcDiscovery) }

    it "インスタンス変数からhashを生成する" do
      request = described_class.new(
        discovery: discovery,
        client_id: "cid",
        redirect_uri: "https://localhost:3000/oidc/callback",
        code_challenge_method: "S256",
        code_challenge: "the-challenge",
        state: "the-state",
        nonce: "the-nonce",
      )
      expect(request.to_params).to eq(
        {
          client_id: "cid",
          response_type: "code",
          redirect_uri: "https://localhost:3000/oidc/callback",
          code_challenge_method: "S256",
          scope: "openid",
          code_challenge: "the-challenge",
          state: "the-state",
          nonce: "the-nonce",
        },
      )
    end
  end

  describe "#authorization_redirect_url" do
    let(:authorization_endpoint) { "https://issuer.example.com/realms/test/protocol/openid-connect/auth" }
    let(:discovery) { instance_double(OidcDiscovery, authorization_endpoint:) }

    it "client_id と request_url だけの authorization URL を返す" do
      request = described_class.new(
        discovery: discovery,
        client_id: "cid",
        redirect_uri: "https://localhost:3000/oidc/callback",
        code_challenge_method: "S256",
        code_challenge: "the-challenge",
        state: "the-state",
        nonce: "the-nonce",
      )
      expect(request.authorization_redirect_url("urn:ietf:params:oauth:request_uri:abc123"))
        .to eq("#{authorization_endpoint}?client_id=cid&request_uri=urn%3Aietf%3Aparams%3Aoauth%3Arequest_uri%3Aabc123")
    end
  end

  describe "#to_url" do
    let(:authorization_endpoint) { "https://issuer.example.com/realms/test/protocol/openid-connect/authorization_endpoint" }
    let(:discovery) { instance_double(OidcDiscovery, authorization_endpoint:) }

    it "インスタンス変数から authorization_endpoint にアクセスするための url を生成する" do
      request = described_class.new(
        discovery: discovery,
        client_id: "cid",
        redirect_uri: "https://localhost:3000/oidc/callback",
        code_challenge_method: "S256",
        code_challenge: "the-challenge",
        state: "the-state",
        nonce: "the-nonce",
      )
      expect(request.to_url).to eq("https://issuer.example.com/realms/test/protocol/openid-connect/authorization_endpoint?response_type=code&client_id=cid&redirect_uri=https%3A%2F%2Flocalhost%3A3000%2Foidc%2Fcallback&code_challenge=the-challenge&code_challenge_method=S256&scope=openid&state=the-state&nonce=the-nonce")
    end
  end
end
