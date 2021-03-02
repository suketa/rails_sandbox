bash-5.0# bin/rails g model User mfa_code_digest name
Running via Spring preloader in process 12144
      invoke  active_record
      create    db/migrate/20210302230124_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
bash-5.0# bin/rails g db:migrate
Running via Spring preloader in process 12149
Could not find generator 'db:migrate'.
Run `rails generate --help` for more options.
bash-5.0# bin/rails c
Running via Spring preloader in process 12157
Loading development environment (Rails 6.0.3.2)
irb(main):001:0> u = User.new
Traceback (most recent call last):
        1: from (irb):1
ActiveRecord::NoDatabaseError (FATAL:  database "app_development" does not exist)
irb(main):002:0> exit
bash-5.0# binr/rails db:create
bash: binr/rails: No such file or directory
bash-5.0# bin/rails db:create
Created database 'app_development'
Created database 'app_test'
bash-5.0# bin/rails db:migrate
== 20210302230124 CreateUsers: migrating ======================================
-- create_table(:users)
   -> 0.0090s
== 20210302230124 CreateUsers: migrated (0.0091s) =============================

bash-5.0# bin/rails c
Running via Spring preloader in process 12220
Loading development environment (Rails 6.0.3.2)
irb(main):001:0> u = User.new
=> #<User id: nil, mfa_code_digest: nil, name: nil, created_at: nil, updated_at: nil>
irb(main):002:0> u.name = 'aaa'
=> "aaa"
irb(main):003:0> u.mfa_code = '012345'
=> "012345"
irb(main):004:0> u.save
   (0.3ms)  BEGIN
  User Create (1.2ms)  INSERT INTO "users" ("mfa_code_digest", "name", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["mfa_code_digest", "$2a$12$5BD//QRjZdT2zR0NSgVSrec1gcAFFm.ft4dsUB4N0UHibZooRVncO"], ["name", "aaa"], ["created_at", "2021-03-02 23:03:41.642643"], ["updated_at", "2021-03-02 23:03:41.642643"]]
   (1.5ms)  COMMIT
=> true
irb(main):005:0> u.reload
  User Load (0.4ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
=> #<User id: 1, mfa_code_digest: "$2a$12$5BD//QRjZdT2zR0NSgVSrec1gcAFFm.ft4dsUB4N0UH...", name: "aaa", created_at: "2021-03-02 23:03:41", updated_at: "2021-03-02 23:03:41">
irb(main):006:0> u.authenticate_mfa_code('123456')
=> false
irb(main):007:0> u.authenticate_mfa_code('012345')
=> #<User id: 1, mfa_code_digest: "$2a$12$5BD//QRjZdT2zR0NSgVSrec1gcAFFm.ft4dsUB4N0UH...", name: "aaa", created_at: "2021-03-02 23:03:41", updated_at: "2021-03-02 23:03:41">
irb(main):008:0> u.mfa_code = ''
=> ""
irb(main):009:0> u.save
=> true
irb(main):010:0> u.reload
  User Load (0.7ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
=> #<User id: 1, mfa_code_digest: "$2a$12$5BD//QRjZdT2zR0NSgVSrec1gcAFFm.ft4dsUB4N0UH...", name: "aaa", created_at: "2021-03-02 23:03:41", updated_at: "2021-03-02 23:03:41">
irb(main):011:0> u.mfa_code = '-'
=> "-"
irb(main):012:0> u.save
   (0.4ms)  BEGIN
  User Update (0.5ms)  UPDATE "users" SET "mfa_code_digest" = $1, "updated_at" = $2 WHERE "users"."id" = $3  [["mfa_code_digest", "$2a$12$dh7Azqr1wSpTSlt3F0YTMOJgV9GUmOLV6qKapkin0N6lZND6oPPYW"], ["updated_at", "2021-03-02 23:05:07.935302"], ["id", 1]]
   (2.0ms)  COMMIT
=> true
irb(main):013:0> u.reload
  User Load (2.4ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
=> #<User id: 1, mfa_code_digest: "$2a$12$dh7Azqr1wSpTSlt3F0YTMOJgV9GUmOLV6qKapkin0N6...", name: "aaa", created_at: "2021-03-02 23:03:41", updated_at: "2021-03-02 23:05:07">
irb(main):014:0> u.mfa_code_digest = ''
=> ""
irb(main):015:0> u.save
   (0.5ms)  BEGIN
  User Update (0.5ms)  UPDATE "users" SET "mfa_code_digest" = $1, "updated_at" = $2 WHERE "users"."id" = $3  [["mfa_code_digest", ""], ["updated_at", "2021-03-02 23:06:32.494986"], ["id", 1]]
   (2.7ms)  COMMIT
=> true
irb(main):016:0> u.reload
  User Load (0.9ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
=> #<User id: 1, mfa_code_digest: "", name: "aaa", created_at: "2021-03-02 23:03:41", updated_at: "2021-03-02 23:06:32">
irb(main):017:0> u.authenticate('012345')
Traceback (most recent call last):
        1: from (irb):17
NoMethodError (undefined method `authenticate' for #<User:0x000055de6dd3b2c8>)
Did you mean?  authenticate_mfa_code
irb(main):018:0> u.authenticate_mfa_code('012345')
Traceback (most recent call last):
        2: from (irb):18
        1: from (irb):18:in `rescue in irb_binding'
BCrypt::Errors::InvalidHash (invalid hash)
irb(main):019:0> u.mfa_code='X'
=> "X"
irb(main):020:0> u.save
   (0.2ms)  BEGIN
  User Update (0.8ms)  UPDATE "users" SET "mfa_code_digest" = $1, "updated_at" = $2 WHERE "users"."id" = $3  [["mfa_code_digest", "$2a$12$mPRb08qZXzzxmqhyp6skCOJHyvpxf6ASBQGPKG.OofaEVYza5gPF."], ["updated_at", "2021-03-02 23:07:31.076586"], ["id", 1]]
   (2.1ms)  COMMIT
=> true
irb(main):021:0> u.reload
  User Load (0.8ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
=> #<User id: 1, mfa_code_digest: "$2a$12$mPRb08qZXzzxmqhyp6skCOJHyvpxf6ASBQGPKG.Oofa...", name: "aaa", created_at: "2021-03-02 23:03:41", updated_at: "2021-03-02 23:07:31">
irb(main):022:0> exit

