# frozen_string_literal: true

require "rails_helper"

RSpec.describe OidcTokenExchange do
  let(:token_endpoint) { "https://issuer.example.com/realms/test/protocol/openid-connect/token" }
  let(:discovery) { instance_double(OidcDiscovery, token_endpoint:) }

  describe "#tokens" do
    let(:client_assertion) do
      instance_double(
        OidcClientAssertion,
        to_params: {
          client_assertion_type: "urn:ietf:params:oauth:client-assertion-type:jwt-bearer",
          client_assertion: "the-assertion",
        },
      )
    end

    context "結果が2XXの場合" do
      it "tokenを返す" do
        stub = stub_request(:post, token_endpoint).with(
          body: hash_including(
            "grant_type" => "authorization_code",
            "code" => "the-code",
            "redirect_uri" => "http://localhost:3000/oidc/callback",
            "code_verifier" => "the-verifier",
            "client_assertion_type" => "urn:ietf:params:oauth:client-assertion-type:jwt-bearer",
            "client_assertion" => "the-assertion",
          ),
        ).to_return(
          status: 200,
          body: { access_token: "AT", id_token: "IDT", token_type: "Bearer" }.to_json,
          headers: { "Content-Type" => "application/json" },
        )

        exchange = described_class.new(
          discovery:,
          client_assertion:,
          redirect_uri: "http://localhost:3000/oidc/callback",
          code: "the-code",
          code_verifier: "the-verifier",
        )

        expect(exchange.tokens).to include(access_token: "AT", id_token: "IDT")
        expect(stub).to have_been_requested
      end
    end

    context "結果が2XXではない場合" do
      before do
        stub_request(:post, token_endpoint).to_return(
          status: 400,
          body: { error: "invalid_grant" }.to_json,
          headers: { "Content-Type" => "application/json" },
        )
      end

      it "OidcTokenExchange::TokenEndpointErrorが発生する" do
        exchange = described_class.new(
          discovery:,
          client_assertion:,
          redirect_uri: "http://localhost:3000/oidc/callback",
          code: "the-code",
          code_verifier: "the-verifier",
        )
        expect { exchange.tokens }.to raise_error(OidcTokenExchange::TokenEndpointError)
      end
    end

    context "結果が200だが body がjsonでない場合" do
      before do
        stub_request(:post, token_endpoint).to_return(
          status: 200,
          body: "<html><body>html</body></html>",
          headers: { "Content-Type" => "application/json" },
        )
      end

      it "OidcTokenExchange::TokenResponseParseErrorが発生する" do
        exchange = described_class.new(
          discovery:,
          client_assertion:,
          redirect_uri: "http://localhost:3000/oidc/callback",
          code: "the-code",
          code_verifier: "the-verifier",
        )
        expect { exchange.tokens }.to raise_error(OidcTokenExchange::TokenResponseParseError)
      end
    end
  end
end
