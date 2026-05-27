# frozen_string_literal: true

require "rails_helper"

RSpec.describe OidcTokenExchange do
  let(:token_endpoint) { "https://issuer.example.com/realms/test/protocol/openid-connect/token" }
  let(:discovery) { instance_double(OidcDiscovery, token_endpoint:) }
  let(:dpop_key) { instance_double(OidcDpopKey) }

  before do
    allow(dpop_key).to receive(:proof)
      .with(htm: "POST", htu: token_endpoint)
      .and_return("the-proof")
  end

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
          headers: { "DPoP" => "the-proof" },
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
          dpop_key:,
          redirect_uri: "http://localhost:3000/oidc/callback",
          code: "the-code",
          code_verifier: "the-verifier",
        )

        expect(exchange.tokens).to include(access_token: "AT", id_token: "IDT", token_type: "Bearer")
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
          dpop_key:,
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
          dpop_key:,
          redirect_uri: "http://localhost:3000/oidc/callback",
          code: "the-code",
          code_verifier: "the-verifier",
        )
        expect { exchange.tokens }.to raise_error(OidcTokenExchange::TokenResponseParseError)
      end
    end

    context "use_dpop_nonce で 400 が返った場合" do
      it "nonce 付き proof で単回リトライして token を返す" do
        allow(dpop_key).to receive(:proof)
          .with(htm: "POST", htu: token_endpoint).and_return("proof1") # 1回目（nonce 無し）
        allow(dpop_key).to receive(:proof)
          .with(htm: "POST", htu: token_endpoint, nonce: "the-nonce").and_return("proof2") # 再送

        stub = stub_request(:post, token_endpoint)
          .to_return(
            status: 400,
            body: { error: "use_dpop_nonce" }.to_json,
            headers: { "Content-Type" => "application/json", "DPoP-Nonce" => "the-nonce" },
          )
          .to_return(
            status: 200,
            body: { access_token: "AT", id_token: "IDT", token_type: "DPoP" }.to_json,
            headers: { "Content-Type" => "application/json" },
          )

        exchange = described_class.new(
          discovery:,
          client_assertion:,
          dpop_key:,
          redirect_uri: "http://localhost:3000/oidc/callback",
          code: "the-code",
          code_verifier: "the-verifier",
        )

        expect(exchange.tokens).to include(access_token: "AT")
        expect(a_request(:post, token_endpoint).with(headers: { "DPoP" => "proof2" })).to have_been_made
        expect(stub).to have_been_requested.twice
      end
    end
  end
end
