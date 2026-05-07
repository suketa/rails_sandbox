# Phase 0 自己テスト QA

- 目的: 仕様の地図 (Phase 0) が頭に入ったかを資料を見ずに確認する
- 使い方:
  1. 学習中はヒントを見ずに **答え** 欄に書く
  2. 行き詰まったら **参照ヒント** に挙げた RFC 章節を読む
  3. 全問書けたら模範解答と突き合わせ、ずれは **補足** 欄にメモ
  4. 全問正答できたら本ファイルを `agents/bank/issue/fapi2_phase0_qa_done.md` に昇格させて Phase 0 完了
- 関連ファイル: `agents/bank/issue/fapi2_learning_plan.md`

---

## 学習ログ

| 日付 | 読んだもの | 時間 | メモ |
|---|---|---|---|
|   |   |   |   |
|   |   |   |   |
|   |   |   |   |

---

## Q1. PAR (Pushed Authorization Request) がない場合と比べて、何が解決されるか? 3つ以上挙げよ

**参照ヒント**: RFC 9126 §1 (Introduction), §3 (Security Considerations) / FAPI 2.0 final §5.3.2

**答え**:

- 認証されているクライアントサーバーからのリクエストのみを許可するようにできる。クライアントが認証されたクライアントかどうかをPAR許可サーバーが認証する。
- リクエストが途中で書き変えられていないか確認できる。
- URLパラメータとしてブラウザを経由してやり取りする必要がなくクライアントサーバーとPAR許可サーバー間で情報がやり取りされる。

**補足**:

- 機密性 (confidentiality): claims や RAR (authorization_details)、PII
  を含むようなパラメータがブラウザ履歴・Referer ヘッダ・プロキシログに残らない。RFC 9126 §1
  の主要動機の一つ。
- URL 長制限の回避: 大きな request object をクエリで送ると URL 長制限 (ブラウザ/プロキシ)
  に引っかかるが、request_uri は短い不透明文字列に置き換わる。
- request_uri の短命・ワンタイム化: §2.2 で短い有効期限と single-use が要求され、リプレイ攻撃耐性が高い
  (PAR を使わない request_uri の旧来仕様で問題視されていた点)。
---

## Q2. DPoP の proof JWT に `ath` claim が必要なのはどのリクエストか? なぜそのリクエストでだけ必要か?

**参照ヒント**: RFC 9449 §4.2, §6 (Token Binding to Access Token)

**答え**:
保護されたリソースにアクセスする場合、 ath が必要。
~クライアント側がトークンを秘密鍵で復号する必要があるため。~ => NG

**補足**:

- ath = SHA-256(access_token) を base64url したもの
- 用途は proof JWT と access token の cryptographic binding
- token endpoint には access token がまだないため ath 不要
- RS(Resource Server) は受け取った access token から ath を再計算し proof と一致するか検証
- 復号ではなくハッシュ・署名検証であることに注意

  DPoP は「①送信者制約 (sender-constrained) を秘密鍵保持で実現」「②proof と access token を ath で相互拘束」の2層構造になっている、と覚えておくと Q5 (Authorization Code Binding) や Q9 (nonce) にも繋がります。
---

## Q3. private_key_jwt の `client_assertion` JWT の `aud` claim には何を入れるか? なぜそうするのか?

**参照ヒント**: RFC 7523 §3, OIDC Core 1.0 §9 (private_key_jwt)

**答え**:

**補足**:

---

## Q4. ID Token を JWE (signed→encrypted) で受け取ったとき、RP は「復号 → 署名検証」の順序で処理する。逆順 (署名検証 → 復号) にすると何が問題か?

**参照ヒント**: OIDC Core 1.0 §16.7, RFC 7516 §11 / 一般的に外側の処理を先に解く理由を考える

**答え**:

**補足**:

---

## Q5. Authorization Code Binding to DPoP Key (RFC 9449 §10.1) は何を防ぐか? 具体的な攻撃シナリオで説明せよ

**参照ヒント**: RFC 9449 §10.1, §10.2, FAPI 2.0 final の対応箇所

**答え**:

**補足**:

---

## Q6. RFC 9207 (`iss` パラメータ) はどんな攻撃を防ぐか? `state` だけで十分でない理由は?

**参照ヒント**: RFC 9207 §1 (Introduction), §2.4 (Validation), draft-ietf-oauth-security-topics の mix-up attack の節

**答え**:

**補足**:

---

## Q7. FAPI 2.0 で許されている JWS 署名アルゴリズムを挙げよ。禁止されているものは何か? なぜ禁止か?

**参照ヒント**: FAPI 2.0 Security Profile final §5.3 / §5.4 の "MUST use" / "MUST NOT use" 節, RFC 8725 (JWT BCP) §3

**答え**:

- 許可:
- 禁止:
- 理由:

**補足**:

---

## Q8. FAPI 2.0 で Refresh Token rotation がなぜ不要 (むしろ禁止) か? Sender-Constrained Token との関係で説明せよ

**参照ヒント**: FAPI 2.0 final §5.x (Refresh Token に関する節), RFC 9449 §1 / §6 (sender-constraining の効果)

**答え**:

**補足**:

---

## Q9. DPoP nonce は誰が発行し、クライアントはどうリクエストを再送するか? また nonce が必要になる典型的な状況は?

**参照ヒント**: RFC 9449 §8 (Authorization Server / Resource Server-Provided Nonce), §9

**答え**:

- 発行者:
- 再送方法:
- 必要になる状況:

**補足**:

---

## Q10. Corppass の ID Token は JWS と JWE のどちらか? RP は何の鍵を所有する必要があるか? それぞれの鍵の用途は?

**参照ヒント**: Corppass Integration Guide / OIDC Core 1.0 §10.2 (ID Token Encryption), RFC 7517 §4.2 (`use` パラメータ)

**答え**:

- 形式:
- RP が持つ鍵:
  -
  -
- 用途:
  -
  -

**補足**:

---

## 模範解答との突き合わせ後のメモ

(全問書き終わってから、ずれや追加で気づいたことをここに残す)

-
-
-
