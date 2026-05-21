# frozen_string_literal: true

require "rails_helper"

RSpec.describe OidcPushedAuthorizationRequest do
  let(:par_endpoint) { "https://issuer.example.com/realms/test/protocol/openid-connect/ext/par/request" }
  let(:discovery) { instance_double(OidcDiscovery, pushed_authorization_request_endpoint: par_endpoint) }
  let(:params) do
    {
      response_type: "code",
      client_id: "cid",
      redirect_uri: "http://localhost:3000/oidc/callback",
      code_challenge: "the-challenge",
      code_challenge_method: "S256",
      scope: "openid",
      state: "the-state",
      nonce: "the-nonce",
    }
  end

  describe "#request_uri" do
    context "結果が2XXの場合" do
      it "PAR endpoint に Basic 認証 + 認可パラメータを POST して request_uri を返す" do
        stub = stub_request(:post, par_endpoint).with(
          headers: { "Authorization" => "Basic #{Base64.strict_encode64("cid:secret")}" },
          body: hash_including(
            "response_type" => "code",
            "client_id" => "cid",
            "redirect_uri" => "http://localhost:3000/oidc/callback",
            "code_challenge" => "the-challenge",
            "code_challenge_method" => "S256",
            "scope" => "openid",
            "state" => "the-state",
            "nonce" => "the-nonce",
          ),
        ).to_return(
          status: 201,
          body: { request_uri: "urn:ietf:params:oauth:request_uri:abc123", expires_in: 60 }.to_json,
          headers: { "Content-Type" => "application/json" },
        )

        par = described_class.new(
          discovery:,
          client_id: "cid",
          client_secret: "secret",
          params:,
        )

        expect(par.request_uri).to eq("urn:ietf:params:oauth:request_uri:abc123")
        expect(stub).to have_been_requested
      end
    end

    context "結果が2XXではない場合" do
      it "ParEndpointError が発生する" do
        stub_request(:post, par_endpoint).with(
          headers: { "Authorization" => "Basic #{Base64.strict_encode64("cid:secret")}" },
          body: hash_including(
            "response_type" => "code",
            "client_id" => "cid",
            "redirect_uri" => "http://localhost:3000/oidc/callback",
            "code_challenge" => "the-challenge",
            "code_challenge_method" => "S256",
            "scope" => "openid",
            "state" => "the-state",
            "nonce" => "the-nonce",
          ),
        ).to_return(
          status: 400,
          body: { error: "invalid_request" }.to_json,
          headers: { "Content-Type" => "application/json" },
        )

        par = described_class.new(
          discovery:,
          client_id: "cid",
          client_secret: "secret",
          params:,
        )

        expect { par.request_uri }.to raise_error(OidcPushedAuthorizationRequest::ParEndpointError)
      end
    end

    context "結果が2XXだがbodyがJSONではない場合" do
      it "ParResponseParseErrorが発生する" do
        stub_request(:post, par_endpoint).with(
          headers: { "Authorization" => "Basic #{Base64.strict_encode64("cid:secret")}" },
          body: hash_including(
            "response_type" => "code",
            "client_id" => "cid",
            "redirect_uri" => "http://localhost:3000/oidc/callback",
            "code_challenge" => "the-challenge",
            "code_challenge_method" => "S256",
            "scope" => "openid",
            "state" => "the-state",
            "nonce" => "the-nonce",
          ),
        ).to_return(
          status: 200,
          body: "<html><body>html</body></html>",
          headers: { "Content-Type" => "application/json" },
        )

        par = described_class.new(
          discovery:,
          client_id: "cid",
          client_secret: "secret",
          params:,
        )

        expect { par.request_uri }.to raise_error(OidcPushedAuthorizationRequest::ParResponseParseError)
      end
    end
  end
end
