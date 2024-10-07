# memo

## https://github.com/rails/rails/pull/50475

partition がない状態でデータを作成するとどうなるか？ => エラーになる。
Event モデルにメソッド `safe_create` を追加して partition が無ければ partition を作るようにすれば、partition がない状態でデータを作成してもエラーにならない。

```
docker compose up -d
docker compose exec web bash

cd sandbox
bundle
rm db/schema.rb # これをしないと一度 migration 実行後に  `rails db:drop db:create db:migrate` を再実行するとエラーが出る。Rails のバグ？
bundle exec rails db:create db:migrate
bundle exec rails db:seed #=> error
# seeds.rb の３行目をコメントアウトして４行目のコメントアウトを外す
bundle exec rails db:seed #=> エラーなし。

bin/rails c
Evnet.where(account_id: 3) #=> partition を意識しなくても普通に events テーブルからデータが取得できる。
```
