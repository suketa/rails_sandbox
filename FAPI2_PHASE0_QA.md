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
- 認証サーバーがトークンを発行した場合のトークンエンドポイントを含めるため。
- ~トークンが確かに認証サーバーのトークンエンドポイントにより生成されたことを保証する（改竄されていないことを確認する）ため。認証サーバーが確認のために使用する。~ => NG

**補足**:
- client_assertion JWT は「クライアント → AS」方向の認証 (クライアントが作成)
- 値: AS の token endpoint URL (OIDC Core §9) または issuer URL (RFC 7523 §3)
- 役割: cross-AS replay 攻撃の防止 ("この assertion はこの AS 専用" を宣言)
- 改竄検知は JWS 署名の役割。aud は audience-binding のための別レイヤ
- 関連 claim: iss=sub=client_id, jti で同一 AS 内の replay 防止, exp で時間制限
- DPoP の ath が「proof と access token を bind」するのと同様、aud は
  「assertion と AS を bind」する位置づけ — JWT 系で頻出のパターン

---

## Q4. ID Token を JWE (signed→encrypted) で受け取ったとき、RP は「復号 → 署名検証」の順序で処理する。逆順 (署名検証 → 復号) にすると何が問題か?

**参照ヒント**: OIDC Core 1.0 §16.7, RFC 7516 §11 / 一般的に外側の処理を先に解く理由を考える

**答え**:
署名が改竄されているリスクがあるため。

**補足**:
- 内側 JWS は外側 JWE の plaintext として埋め込まれている。復号して初めて JWS structure が露出する
- 「外側を先に解く」は JOSE の一般原則 (RFC 7516 §11, OIDC Core §16.7)。ネスト JWT でも、Russian doll を外から開けるのと同じ
- 改竄検知は JWE 自体が AEAD (例: A256GCM) で integrityを持っているので、復号成功時点で外側の改竄は検出済み
- 順序を逆にしようとしても、検証する対象 (署名値) が暗号化されていて見えないので、そもそも操作が始められない — 「危険」というより「不可能」

---

## Q5. Authorization Code Binding to DPoP Key (RFC 9449 §10.1) は何を防ぐか? 具体的な攻撃シナリオで説明せよ

**参照ヒント**: RFC 9449 §10.1, §10.2, FAPI 2.0 final の対応箇所

**答え**:
トークンが盗まれて悪意あるクライアントから送信されたときにそのリクエストを無視することができる。

**補足**:
1. 正規クライアント C が AS に authorization request を投げる (PAR で dpop_jkt = SHA-256(C の公開鍵) を送付、または DPoP proof を添付)
2. AS は authorization code を発行し、内部で code ↔ jkt の紐付けを記憶
3. 何らかの経路で attacker が code を入手 (Referer leak / ログ漏洩 / redirect_uri の取り違え / プロキシ経由 / open redirect 経由 …)
4. attacker が自分の DPoP key で proof を作って token endpoint に redeem を試みる
5. AS: 「この code に bind された jkt と、proof の jkt が一致しない」→ token 発行を拒否
6. → attacker は code を持っていても token に交換できない
---
## Q6. RFC 9207 (`iss` パラメータ) はどんな攻撃を防ぐか? `state` だけで十分でない理由は?

**参照ヒント**: RFC 9207 §1 (Introduction), §2.4 (Validation), draft-ietf-oauth-security-topics の mix-up attack の節

**答え**:
Mix-Up攻撃を防ぐ。クライアントが iss パラメータで設定されているコード発行元と実際に通信している認可サーバーが同一かどうかを判定して異なればリクエストを中断する。


Mix-Up 攻撃 (クライアントが複数の AS をサポートしているとき、攻撃者が「どの AS が
response を返したか」をすり替える攻撃) を防ぐ。

state だけで不十分な理由:
- state は「リクエストとレスポンスの 1 対 1 対応」を守る CSRF 対策であり、
  正規ユーザーが正規に開始したフローでは state は一致してしまう
- state は **どの AS が応答したか** をエンコードしていない
- → クライアントが期待した AS と実際の発行 AS が異なっていても検出できない

iss パラメータは authorization response に発行 AS の issuer URL を埋め込み、
クライアントが「自分が認可リクエストを送った AS の issuer」と strict equal で
比較できるようにすることで、AS identity レイヤの検証を追加する。

**補足**:

---

## Q7. FAPI 2.0 で許されている JWS 署名アルゴリズムを挙げよ。禁止されているものは何か? なぜ禁止か?

**参照ヒント**: FAPI 2.0 Security Profile final §5.3 / §5.4 の "MUST use" / "MUST NOT use" 節, RFC 8725 (JWT BCP) §3

**答え**:

- 許可: PS256, ES256, EdDSA(Ed25519使用)
- 禁止: それ以外
- 理由: 弱点が見つかった場合、なりすましができてしまうため。


- 許可: PS256, ES256, EdDSA (Ed25519)
- 禁止: 上記以外。特に
  - `none` (署名なし)
  - HS256/HS384/HS512 (HMAC: 対称鍵)
  - RS256/RS384/RS512 (RSA + PKCS#1 v1.5 padding)
  - ES384/ES512 (P-256 以外の ECDSA)
- 理由: アルゴリズムごとに異なる
  - `none`: そもそも署名がない → 検証ライブラリの実装次第で無検証通過
      (古典的 JWT 脆弱性)
  - HS*: ① 対称鍵共有が高セキュリティ profile に合わない
         ② alg confusion 攻撃 (公開鍵を HMAC 鍵として使われる) の歴史的事故
  - RS*: PKCS#1 v1.5 padding は Bleichenbacher 系の歴史的脆弱性 →
         RSA を使うなら PSS (PS256) を使う
  - ES384/ES512: 機能的問題ではなく、実装多様性を削って相互運用と実装ミスの余地を減らすため (allow-list 主義)

**補足**:
- 設計思想: "small allow-list" 主義。"禁止リスト" ではなく "許可リスト" を
    小さく保つことで実装の選択肢を狭め、実装側の脆弱性混入余地を削る
- RFC 8725 (JWT BCP) §3.1 と整合: alg=none, weak alg を avoid
- 関連: アルゴリズム選択の実装ミス (alg confusion) は OIDC/OAuth で繰り返し起きてきた領域 — Q4 (JWE 順序) と並ぶ JOSE 実装ミスの定番ジャンル
- EdDSA で Ed448 ではなく Ed25519 限定なのは相互運用性の観点 (ライブラリ実装のカバレッジが Ed25519 の方が圧倒的に広い)

  ポイントは 「FAPI 2.0 は allow-list アプローチ」 で、blocklist 主義 (危ないやつを拒否) ではなく
  「これだけ使え」 という設計思想だと押さえること。Q3 (aud)・Q6 (iss) と同じく、FAPI 2.0
  の各仕様は「攻撃シナリオ → 必要な binding/制約」という対応関係で読むと一気通貫します。

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
