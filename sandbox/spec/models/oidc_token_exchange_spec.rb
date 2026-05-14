# frozen_string_literal: true

require "rails_helper"

RSpec.describe OidcTokenExchange do
  let(:token_endpoint) { "https://issuer.example.com/realms/test/protocol/openid-connect/token" }
  let(:discovery) { instance_double(OidcDiscovery, token_endpoint:) }

  it "token_endpointへのPost成功時には取得できたトークンを返す" do
    stub_request(:post, token_endpoint).to_return(
      status: 200,
      body: { access_token: "AT", id_token: "IDT", token_type: "Bearer" }.to_json,
      headers: { "Content-Type" => "application/json" },
    )

    exchange = described_class.new(
      discovery:,
      client_id: "cid",
      client_secret: "secret",
      redirect_uri: "http://localhost:3000/oidc/callback",
      code: "the-code",
      code_verifier: "the-verifier",
    )

    expect(exchange.tokens).to include(access_token: "AT", id_token: "IDT")
  end

  it "token endpointにパラメータを指定して呼び出す" do
    stub = stub_request(:post, token_endpoint).with(
      body: hash_including(
        "grant_type" => "authorization_code",
        "code" => "the-code",
        "redirect_uri" => "http://localhost:3000/oidc/callback",
        "code_verifier" => "the-verifier",
      ),
    ).to_return(
      status: 200,
      body: { access_token: "AT", id_token: "IDT", token_type: "Bearer" }.to_json,
      headers: { "Content-Type" => "application/json" },
    )

    described_class.new(
      discovery:,
      client_id: "cid",
      client_secret: "secret",
      redirect_uri: "http://localhost:3000/oidc/callback",
      code: "the-code",
      code_verifier: "the-verifier",
    ).tokens

    expect(stub).to have_been_requested
  end
end
