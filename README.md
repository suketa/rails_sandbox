# Rails 6.0.0rc1 Sandbox

This project is sandbox for trying new features of Rails 6.0.0rc1

## How to run

```
$ env POSTGRES_USER=xxxx POSTGRES_PASSWORD=yyyy docker-compose up -d
$ docker-compose exec web bash
```

## feature: [Store newly-uploaded files on save rather than assignment](https://github.com/rails/rails/pull/33303)

* branch: try015_active_storage
* article: https://qiita.com/suketa/items/2daad87d8c22737f5582 (日本語)

## feature: [Add implicit to path conversion to uploaded file](https://github.com/rails/rails/pull/28676)

* branch: try016_uploaded_file_path
* article: https://qiita.com/suketa/items/c06068518ae0ba283b2b (日本語)

## feature: [Use public_send in value_for_collection](https://github.com/rails/rails/pull/33547)

* branch: try018
* article: https://qiita.com/suketa/items/8e238df881b2c55b24f9 (日本語)

## feature: [Emit warning for unknown inflection rule when generating model](https://github.com/rails/rails/pull/33766)

* branch try019_db_singular_and_plural_warning
* article: https://qiita.com/suketa/items/82da66f61c9a0f337126 (日本語)

## feature: [Fail more gracefully from ActiveStorage missing file exceptions](https://github.com/rails/rails/pull/33666)

* branch try020_active_storage_missing_file
* article: https://qiita.com/suketa/items/97bbfa3626ea542e9e0b (日本語)

## feature: [Maintain html_safe? on sliced HTML safe strings](https://github.com/rails/rails/pull/33808)

* branch try021_html_safe
* article: https://qiita.com/suketa/items/bf4f422d7797fae97406 (日本語)

## feature: [Configuration item config.filter_parameters could also filter out sensitive values of database columns when call #inspect](https://github.com/rails/rails/pull/33756)

* branch try022_filter_parameters
* article: https://qiita.com/suketa/items/ce5d3e6439086b5e86f9 (日本語)

## feature: [update I18n fallbacks configuration to be compatible with i18n 1.1.0](https://github.com/rails/rails/pull/33574)

* branch try023_i18n_fallbacks
* article: https://qiita.com/suketa/items/27251aeef4fac8cc5262 (日本語)

## feature: [Add #unfreeze_time to ActiveSupport::Testing::TimeHelpers](https://github.com/rails/rails/pull/33813)

* branch: try024_unfreeze_time
* article: https://qiita.com/suketa/items/9830f814ee824ca4e681 (日本語)

## feature: [Make sure there are no duplicated nested records with create_with](https://github.com/rails/rails/pull/33639)

* branch: try025_fix_create_with
* article: https://qiita.com/suketa/items/ac35fafb422cd8c672dd (日本語)

## feature: [Use utf8mb4 character set by default for MySQL database](https://github.com/rails/rails/pull/33608)

* branch: try026_mysql_utf8mb4
* article: https://qiita.com/suketa/items/d7dabe31decff87e26e6 (日本語)

## feature: [Skip delivery notification when perform_deliveries is false.](https://github.com/rails/rails/pull/33824)

* branch: try027_perform_deliveries
* article: https://qiita.com/suketa/items/4daf2767071ab0a70176 (日本語)

## feature: [TaggedLogging to return a new logger instance](https://github.com/rails/rails/pull/27792)

* branch: try028_tagged_logging
* article: https://qiita.com/suketa/items/dfff84951cc251df834e (日本語)

## feature: [Deprecate ActiveRecord::Result#to_hash in favor of #to_a](https://github.com/rails/rails/pull/33912)

* branch: try029_activerecord_result_to_a
* article: https://qiita.com/suketa/items/812882409bd4e44d586a (日本語)

## feature: [Allow subclasses to redefine autosave callbacks for associated records](https://github.com/rails/rails/pull/33378)

* branch: try030_subclass
* article: https://qiita.com/suketa/items/7ccd1b64d9934867ff33 (日本語)

## feature: [Configure Active Storage route prefix](https://github.com/rails/rails/pull/33883)

* branch: try031_active_storage_route_prefix
* article: https://qiita.com/suketa/items/bca2efe9df7c1d3496ee (日本語)

## feature: [index option added for change_table migrations](https://github.com/rails/rails/pull/23593)

* branch: try032_index_option
* article: https://qiita.com/suketa/items/253b654ceaeb7277faca (日本語)

## feature: [Error when using "recyclable" cache keys with a store that does not support it](https://github.com/rails/rails/pull/33932)

* branch: try033_cache_error
* article: https://qiita.com/suketa/items/725e69fd6bbf45e344af (日本語)

## feature: [Encode Content-Disposition filenames on send_data and send_file](https://github.com/rails/rails/pull/33829)

* branch: try034_send_data_filename
* article: https://qiita.com/suketa/items/b2efca0cfb24f97ae65b (日本語)

## feature: [Refactor migrations_path command option to database](https://github.com/rails/rails/pull/34021)

* branch: try035_database_option
* article: https://qiita.com/suketa/items/98c0e5e7af310915205f (日本語)

## feature: [Added ActionController::Parameters.each_value methods](https://github.com/rails/rails/pull/33979)

* branch: try036_params_each_values
* article: https://qiita.com/suketa/items/6861e650f927c4e8e304 (日本語)

## feature: [Add deprecation warning when String#first and String#last receive negative integers](https://github.com/rails/rails/pull/33058)

* branch: try037_string_first_last
* article: https://qiita.com/suketa/items/0b113959c8c0afcb5f5b (日本語)

## feature: [Prefix Module#parent, Module#parents, and Module#parent_name with module](https://github.com/rails/rails/pull/34051)

* branch: try038_parent_deprecated
* article: https://qiita.com/suketa/items/f9c2dc61dad80f6f1a50 (日本語)

## feature: [Deprecate the `LoggerSilence` constant](https://github.com/rails/rails/pull/34045)

* branch: try039_logger_silence
* article: https://qiita.com/suketa/items/5b906ca9dcf716e4fc83 (日本語)

## feature: [Make Webpacker the default JavaScript compiler for Rails 6 ](https://github.com/rails/rails/pull/33079)

* branch: try040_webpacker_bootstrap
* article: https://qiita.com/suketa/items/3f5ff1c7d0d7d215a532 (日本語)

## feature: [Move MailDeliveryJob default to 6.0 defaults](https://github.com/rails/rails/pull/34692)

* branch: try041_mail_delivery_job
* article: https://qiita.com/suketa/items/7058785a8911c658c03c (日本語)

## feature: [Add multi-db support to rails db:migrate:status](https://github.com/rails/rails/pull/34137)

* branch: try042_multidb_migrate_status
* article: https://qiita.com/suketa/items/aaa314d11ab6294afb70 (日本語)

## feature: [Fix inconsistent behavior by clearing QueryCache when reloading associations](https://github.com/rails/rails/pull/34094)

* branch: try043_query_cache
* article: https://qiita.com/suketa/items/42e8bd6c79b05e54c2e9 (日本語)

## feature: [Enum raises on invalid definition values](https://github.com/rails/rails/pull/34110)

* branch: try044_enum_validation
* article: https://qiita.com/suketa/items/d007b5ebca5cf107ed87 (日本語)

## feature: [Add allocations to template renderer subscription](https://github.com/rails/rails/pull/34136)

* branch: master
* article: https://qiita.com/suketa/items/835119ddc3e611e1b334 (日本語)

## feature: [Part 4: Multi db improvements, Basic API for connection switching](https://github.com/rails/rails/pull/34052)

* branch: try046_multidb_connection_switching
* article: https://qiita.com/suketa/items/91ea3e6ebaac131d5d9d (日本語)

## feature: [Deprecate Unicode#downcase/upcase/swapcase](https://github.com/rails/rails/pull/34123)

* branch: try047_unicode
* article: https://qiita.com/suketa/items/a4f4c8b7a3dd21078de2 (日本語)

## feature: [Fix issue where duration where always rounded up to a second](https://github.com/rails/rails/pull/34135)

* branch: try048_duration
* article: https://qiita.com/suketa/items/90a713787121e4400322 (日本語)

## feature: [Deprecate ActiveSupport::Multibyte::Chars.consumes?](https://github.com/rails/rails/pull/34215)

* branch: try049_deprecated_consumes
* article: https://qiita.com/suketa/items/1a04fd7e18977d00e10d (日本語)

## feature: [Issue #29200 scaffold an object with a reference displays an object memory address to user](https://github.com/rails/rails/pull/29204)

* branch: try050_scaffold
* article: https://qiita.com/suketa/items/98833dbf6eda211a4232 (日本語)

## feature: [Support default expression and expression indexes for MySQL](https://github.com/rails/rails/pull/34307)

* branch: try051_mysql_default_expression
* article: https://qiita.com/suketa/items/00e40d38a5b3180a8b32 (日本語)

## feature: [Rails6 のちょい足しな新機能を試す52（ActiveStorage::Blob#key編）](https://github.com/rails/rails/pull/34818)

* branch: try052_active_storage_blob_keys
* article: https://qiita.com/suketa/items/e39d2ffaa87bc7531344 (日本語)

## feature: [[ActiveStorage] Allow `variant` method to be called by `TIFF` images](https://github.com/rails/rails/pull/34824)

* branch: try053_accept_tiff_by_variant
* article: https://qiita.com/suketa/items/3f44636148afd26658bf (日本語)

## feature: [Allow strong params in ActiveRecord::Base#exists?](https://github.com/rails/rails/pull/34891)

* branch: try054_exists_accept_strong_params
* article: https://qiita.com/suketa/items/34d2092f86a89e7665e3 (日本語)

## feature: [Deprecate Unicode#downcase/upcase/swapcase](https://github.com/rails/rails/pull/34123)

* branch: try055_enum_blank
* article: https://qiita.com/suketa/items/f3047b2481217a0690d6 (日本語)

## feature: [Add an :if_not_exists option to create_table](https://github.com/rails/rails/pull/31382)

* branch: try056_create_table_if_not_exists
* article: https://qiita.com/suketa/items/3e24bef571572b6f7231 (日本語)

## feature: [Arel: Implemented DB-aware NULL-safe comparison](https://github.com/rails/rails/pull/34451)

* branch: try057_arel_null_safe_comparison
* article:

## feature: [Add `ActiveModel::Errors#of_kind?`](https://github.com/rails/rails/pull/34866)

* branch: try058_errors_of_kind
* article:

## feature: [Support endless ranges in where](https://github.com/rails/rails/pull/34906)

* branch: try059_where_endless_range
* article:

## feature: [Prevent TextHelper#word_wrap from stripping white space on the left side of long lines; Fixes #34487](https://github.com/rails/rails/pull/34488)

* branch: try060_word_wrap
* article:

## feature: [ActionMailer: support overriding template name in multipart](https://github.com/rails/rails/pull/22534)

* branch: try061_mail_multi_part_template
* article:

## feature: [Refs #28025 nullify *_type column on polymorphic associations on :nulify polymorphic *_type column on dependent: :nullify strategy](https://github.com/rails/rails/pull/28078)

* branch: try062_nullify_polymorphic
* article:

## feature: [Add rails db:system:change command](https://github.com/rails/rails/pull/34832)

* branch: try063_db_system_change, try063_db_system_change_to_mysql
* article:

## feature: [Seed database with inline ActiveJob job adapter](https://github.com/rails/rails/pull/34953)

* branch: try064_seed_inline_active_job
* article:
