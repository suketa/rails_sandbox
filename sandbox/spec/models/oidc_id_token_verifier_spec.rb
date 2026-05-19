# frozen_string_literal: true

require "rails_helper"

RSpec.describe OidcIdTokenVerifier do
  let(:issuer) { "https://issuer.example.com" }
  let(:jwks_uri) { "https://issuer.example.com/jwks_uri" }
  let(:discovery) { instance_double(OidcDiscovery, issuer:, jwks_uri:) }
  let(:jwk) { JSON::JWK.new(OpenSSL::PKey::RSA.generate(2048)) }
  let(:now) { Time.current.to_i }
  let(:base_claims) do
    { iss: issuer, aud: "cid", nonce: "nonce", sub: "user-1", iat: now, exp: now + 60 }
  end
  let(:claims) { base_claims }
  let(:id_token) { JSON::JWT.new(claims).tap { |j| j.kid = jwk[:kid] }.sign(jwk, :RS256).to_s }

  describe "#verify!" do
    before do
      stub_request(:get, jwks_uri).to_return(
        status: 200,
        body: JSON::JWK::Set.new(jwk).to_json,
        headers: { "Content-Type" => "application/json" },
      )
      freeze_time
    end

    context "正しく検証できるレスポンスのとき" do
      it "認証に成功する" do
        verifier = described_class.new(id_token:, discovery:, client_id: "cid", nonce: "nonce")
        expect(verifier.verify!).to include({
          sub: "user-1",
          iss: issuer,
        })
      end
    end

    context "iss が discovery.issuer と一致しないとき" do
      let(:claims) { base_claims.merge(iss: "https://invalid.example.com") }

      it "検証に失敗する" do
        verifier = described_class.new(id_token:, discovery:, client_id: "cid", nonce: "nonce")
        expect { verifier.verify! }.to raise_error(OidcIdTokenVerifier::VerificationError, /iss/)
      end
    end

    context "aud が不一致のとき" do
      let(:claims) { base_claims.merge(aud: "invalid-cid") }

      it "検証に失敗する" do
        verifier = described_class.new(id_token:, discovery:, client_id: "cid", nonce: "nonce")
        expect { verifier.verify! }.to raise_error(OidcIdTokenVerifier::VerificationError, /aud/)
      end
    end

    context "nonce が不一致のとき" do
      let(:claims) { base_claims.merge(nonce: "invalid-nonce") }

      it "検証に失敗する" do
        verifier = described_class.new(id_token:, discovery:, client_id: "cid", nonce: "nonce")
        expect { verifier.verify! }.to raise_error(OidcIdTokenVerifier::VerificationError, /nonce/)
      end
    end

    context "exp が切れているとき" do
      let(:claims) { base_claims.merge(exp: now - 60) }

      it "検証に失敗する" do
        verifier = described_class.new(id_token:, discovery:, client_id: "cid", nonce: "nonce")
        expect { verifier.verify! }.to raise_error(OidcIdTokenVerifier::VerificationError, /exp/)
      end
    end

    context "別鍵で署名されているとき" do
      let(:other_jwk) { JSON::JWK.new(OpenSSL::PKey::RSA.generate(2048)) }
      let(:id_token) { JSON::JWT.new(claims).tap { |j| j.kid = jwk[:kid] }.sign(other_jwk, :RS256).to_s }

      it "検証に失敗する" do
        verifier = described_class.new(id_token:, discovery:, client_id: "cid", nonce: "nonce")
        expect { verifier.verify! }.to raise_error(OidcIdTokenVerifier::VerificationError, /signature.*:.*VerificationFailed/)
      end
    end

    context "kid が JWKS にないとき" do
      let(:id_token) { JSON::JWT.new(claims).tap { |j| j.kid = "" }.sign(jwk, :RS256).to_s }

      it "検証に失敗する" do
        verifier = described_class.new(id_token:, discovery:, client_id: "cid", nonce: "nonce")
        expect { verifier.verify! }.to raise_error(OidcIdTokenVerifier::VerificationError, /signature.*:.*KidNotFound/)
      end
    end

    context "id_token が Invalid format のとき" do
      let(:id_token) { "invalid format" }

      it "検証に失敗する" do
        verifier = described_class.new(id_token:, discovery:, client_id: "cid", nonce: "nonce")
        expect { verifier.verify! }.to raise_error(OidcIdTokenVerifier::VerificationError, /signature.*:.*InvalidFormat/)
      end
    end

    context "iat が未来のとき" do
      let(:claims) { base_claims.merge(iat: now + described_class::CLOCK_SKEW_SECONDS + 5) }

      it "検証に失敗する" do
        verifier = described_class.new(id_token:, discovery:, client_id: "cid", nonce: "nonce")
        expect { verifier.verify! }.to raise_error(OidcIdTokenVerifier::VerificationError, /iat/)
      end
    end

    context "iat が境界内のとき" do
      let(:claims) { base_claims.merge(iat: now + described_class::CLOCK_SKEW_SECONDS - 5) }

      it "検証に成功する" do
        verifier = described_class.new(id_token:, discovery:, client_id: "cid", nonce: "nonce")
        expect(verifier.verify!).to include({
          sub: "user-1",
          iss: issuer,
        })
      end
    end

    context "alg: none で署名されているとき" do
      let(:id_token) do
        header = Base64.urlsafe_encode64({ alg: "none", type: "JWT" }.to_json, padding: false)
        payload = Base64.urlsafe_encode64(claims.to_json, padding: false)
        "#{header}.#{payload}."
      end

      it "検証に失敗する" do
        verifier = described_class.new(id_token:, discovery:, client_id: "cid", nonce: "nonce")
        expect { verifier.verify! }.to raise_error(OidcIdTokenVerifier::VerificationError)
      end
    end

    context "alg が allowed_algs に含まれないとき" do
      let(:allowed_algs) { ["PS256", "ES256"] }

      it "検証に失敗する" do
        verifier = described_class.new(id_token:, discovery:, client_id: "cid", nonce: "nonce", allowed_algs:)
        expect { verifier.verify! }.to raise_error(OidcIdTokenVerifier::VerificationError, /alg/)
      end
    end
  end
end
