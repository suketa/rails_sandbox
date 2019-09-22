# Rails Sandbox

This project is sandbox for trying new features of Rails

## How to run

```
$ env POSTGRES_USER=xxxx POSTGRES_PASSWORD=yyyy docker-compose up -d
$ docker-compose exec web bash
```

## Try Rails features using Rails 6.0.0

### feature [Instrument middleware processing](https://github.com/rails/rails/commit/04ae0b0b5e594e0bb99c5cd60892  1745977bcdcd)
* branch try090_instrument_middleware
* article:

### feature [Add event object subscriptions to AS::Notifications](https://github.com/rails/rails/pull/33451)
* branch try089_subscriber_event
* article:

### feature [Fix Time#advance to work with dates before 1001-03-07](https://github.com/rails/rails/pull/35659)
### feature [Add cpu time, idle time, and allocations features to log subscriber events](https://github.com/rails/rails/pull/33449)
* branch try088_add_info_of_subscriber_events
* article:

### feature [Fix Time#advance to work with dates before 1001-03-07](https://github.com/rails/rails/pull/35659)

* branch try087_time_advance
* article:

### feature [Support Optimizer Hints](https://github.com/rails/rails/pull/35615)

* branch try086_optimizer_hint
* article:

### feature [Add insert_many to ActiveRecord models](https://github.com/rails/rails/pull/35077)

* branch: try085_insert_all
* article:

### feature [Add locale option to #parameterize](https://github.com/rails/rails/pull/35571)

* branch: try084_parameterize_locale
* article:

### feature [Added Array#including, Array#excluding, Enumerable#including, Enumerable#excluding](https://github.com/rails/rails/commit/bfaa3091c3c32b5980a614ef0f7b39cbf83f6db3)

* branch: try083_excluding
* article:

### feature [Allow `truncate` for SQLite3 adapter and add `rails db:seed:replant`](https://github.com/rails/rails/pull/34779)

* branch: try082_db_seed_replant
* article: https://qiita.com/suketa/items/bce6f88360757fe31f99 (日本語)

### feature [Deprecate mismatched collation comparison for uniquness validator](https://github.com/rails/rails/pull/35350)

* branch: try081_mysql_comparison
* article: https://qiita.com/suketa/items/29159070f240338b0f20 (日本語)

### feature [Add reselect method](https://github.com/rails/rails/pull/33611)

* branch: try080_reselect
* article: https://qiita.com/suketa/items/203b0dd05c8963c5e097 (日本語)

### feature [Add negative scopes for all enum values](https://github.com/rails/rails/pull/35381)

* branch: try079_enum_negative
* article: https://qiita.com/suketa/items/93fa8a1324b83cbe1504 (日本語)

### feature [Guard against DNS rebinding attacks by permitting hosts](https://github.com/rails/rails/pull/33145)

* branch: try078_guard_dns_rebiding_attack
* article: https://qiita.com/suketa/items/f00570e6f171cb987ddd (日本語)

### feature [Ensure `update_all` series cares about optimistic locking](https://github.com/rails/rails/pull/35352)

* branch: try077_update_all
* article: https://qiita.com/suketa/items/88c930dd911eec5d9a80 (日本語)

## Try Rails features using Rails 6.0.0rc2

Some features are included in Rails 6.0.0rc1. Some features (bug fixes) are backported to Rails 5.x.x.

### feature: [Introduce delete_by and destroy_by methods to ActiveRecord::Relation](https://github.com/rails/rails  /pull/35316)

* branch: try076_delete_by_destroy_by
* article: https://qiita.com/suketa/items/d2886eac45064d18e282 (日本語)

### feature: [Adding enque time tracking and logging](https://github.com/rails/rails/pull/35238)

* branch: try075_activejob_enqueued_at
* article: https://qiita.com/suketa/items/961f8be7944b5cd74d8f (日本語)

### feature: [Allow using parsed_body in ActionController::TestCase](https://github.com/rails/rails/pull/34717)

* branch: try074_parsed_body
* article: https://qiita.com/suketa/items/0206bbcb1627e048cbce (日本語)

### feature: [[UPDATED] Implement a way to add browser capabilities](https://github.com/rails/rails/pull/35081)

* branch: try073_add_browser_capabilities
* article: https://qiita.com/suketa/items/3ebb5bd0e6f617fb71ed (日本語)

### feature: [option to disable all scopes that `ActiveRecord.enum` generates](https://github.com/rails/rails/pull/34605)

* branch: try072_enum_disable_scopes
* article: https://qiita.com/suketa/items/cbf3ef9cebaddf108344 (日本語)

### feature: [Make it possible to override the implicit order column](https://github.com/rails/rails/pull/34480)

* branch: try071_implicit_order_column
* article: https://qiita.com/suketa/items/932f47dbbecd55d7f58d (日本語)

### feature: [Add slice! method to ActiveModel::Errors](https://github.com/rails/rails/pull/34489)

* branch: try070_active_model_errors_slice
* article: https://qiita.com/suketa/items/75f417b5609971a2ba27 (日本語)

## Try Rails features using Rails 6.0.0rc1

### feature: [Store newly-uploaded files on save rather than assignment](https://github.com/rails/rails/pull/33303)

* branch: try015_active_storage
* article: https://qiita.com/suketa/items/2daad87d8c22737f5582 (日本語)

### feature: [Add implicit to path conversion to uploaded file](https://github.com/rails/rails/pull/28676)

* branch: try016_uploaded_file_path
* article: https://qiita.com/suketa/items/c06068518ae0ba283b2b (日本語)

### feature: [Use public_send in value_for_collection](https://github.com/rails/rails/pull/33547)

* branch: try018
* article: https://qiita.com/suketa/items/8e238df881b2c55b24f9 (日本語)

### feature: [Emit warning for unknown inflection rule when generating model](https://github.com/rails/rails/pull/33766)

* branch try019_db_singular_and_plural_warning
* article: https://qiita.com/suketa/items/82da66f61c9a0f337126 (日本語)

### feature: [Fail more gracefully from ActiveStorage missing file exceptions](https://github.com/rails/rails/pull/33666)

* branch try020_active_storage_missing_file
* article: https://qiita.com/suketa/items/97bbfa3626ea542e9e0b (日本語)

### feature: [Maintain html_safe? on sliced HTML safe strings](https://github.com/rails/rails/pull/33808)

* branch try021_html_safe
* article: https://qiita.com/suketa/items/bf4f422d7797fae97406 (日本語)

### feature: [Configuration item config.filter_parameters could also filter out sensitive values of database columns when call #inspect](https://github.com/rails/rails/pull/33756)

* branch try022_filter_parameters
* article: https://qiita.com/suketa/items/ce5d3e6439086b5e86f9 (日本語)

### feature: [update I18n fallbacks configuration to be compatible with i18n 1.1.0](https://github.com/rails/rails/pull/33574)

* branch try023_i18n_fallbacks
* article: https://qiita.com/suketa/items/27251aeef4fac8cc5262 (日本語)

### feature: [Add #unfreeze_time to ActiveSupport::Testing::TimeHelpers](https://github.com/rails/rails/pull/33813)

* branch: try024_unfreeze_time
* article: https://qiita.com/suketa/items/9830f814ee824ca4e681 (日本語)

### feature: [Make sure there are no duplicated nested records with create_with](https://github.com/rails/rails/pull/33639)

* branch: try025_fix_create_with
* article: https://qiita.com/suketa/items/ac35fafb422cd8c672dd (日本語)

### feature: [Use utf8mb4 character set by default for MySQL database](https://github.com/rails/rails/pull/33608)

* branch: try026_mysql_utf8mb4
* article: https://qiita.com/suketa/items/d7dabe31decff87e26e6 (日本語)

### feature: [Skip delivery notification when perform_deliveries is false.](https://github.com/rails/rails/pull/33824)

* branch: try027_perform_deliveries
* article: https://qiita.com/suketa/items/4daf2767071ab0a70176 (日本語)

### feature: [TaggedLogging to return a new logger instance](https://github.com/rails/rails/pull/27792)

* branch: try028_tagged_logging
* article: https://qiita.com/suketa/items/dfff84951cc251df834e (日本語)

### feature: [Deprecate ActiveRecord::Result#to_hash in favor of #to_a](https://github.com/rails/rails/pull/33912)

* branch: try029_activerecord_result_to_a
* article: https://qiita.com/suketa/items/812882409bd4e44d586a (日本語)

### feature: [Allow subclasses to redefine autosave callbacks for associated records](https://github.com/rails/rails/pull/33378)

* branch: try030_subclass
* article: https://qiita.com/suketa/items/7ccd1b64d9934867ff33 (日本語)

### feature: [Configure Active Storage route prefix](https://github.com/rails/rails/pull/33883)

* branch: try031_active_storage_route_prefix
* article: https://qiita.com/suketa/items/bca2efe9df7c1d3496ee (日本語)

### feature: [index option added for change_table migrations](https://github.com/rails/rails/pull/23593)

* branch: try032_index_option
* article: https://qiita.com/suketa/items/253b654ceaeb7277faca (日本語)

### feature: [Error when using "recyclable" cache keys with a store that does not support it](https://github.com/rails/rails/pull/33932)

* branch: try033_cache_error
* article: https://qiita.com/suketa/items/725e69fd6bbf45e344af (日本語)

### feature: [Encode Content-Disposition filenames on send_data and send_file](https://github.com/rails/rails/pull/33829)

* branch: try034_send_data_filename
* article: https://qiita.com/suketa/items/b2efca0cfb24f97ae65b (日本語)

### feature: [Refactor migrations_path command option to database](https://github.com/rails/rails/pull/34021)

* branch: try035_database_option
* article: https://qiita.com/suketa/items/98c0e5e7af310915205f (日本語)

### feature: [Added ActionController::Parameters.each_value methods](https://github.com/rails/rails/pull/33979)

* branch: try036_params_each_values
* article: https://qiita.com/suketa/items/6861e650f927c4e8e304 (日本語)

### feature: [Add deprecation warning when String#first and String#last receive negative integers](https://github.com/rails/rails/pull/33058)

* branch: try037_string_first_last
* article: https://qiita.com/suketa/items/0b113959c8c0afcb5f5b (日本語)

### feature: [Prefix Module#parent, Module#parents, and Module#parent_name with module](https://github.com/rails/rails/pull/34051)

* branch: try038_parent_deprecated
* article: https://qiita.com/suketa/items/f9c2dc61dad80f6f1a50 (日本語)

### feature: [Deprecate the `LoggerSilence` constant](https://github.com/rails/rails/pull/34045)

* branch: try039_logger_silence
* article: https://qiita.com/suketa/items/5b906ca9dcf716e4fc83 (日本語)

### feature: [Make Webpacker the default JavaScript compiler for Rails 6 ](https://github.com/rails/rails/pull/33079)

* branch: try040_webpacker_bootstrap
* article: https://qiita.com/suketa/items/3f5ff1c7d0d7d215a532 (日本語)

### feature: [Move MailDeliveryJob default to 6.0 defaults](https://github.com/rails/rails/pull/34692)

* branch: try041_mail_delivery_job
* article: https://qiita.com/suketa/items/7058785a8911c658c03c (日本語)

### feature: [Add multi-db support to rails db:migrate:status](https://github.com/rails/rails/pull/34137)

* branch: try042_multidb_migrate_status
* article: https://qiita.com/suketa/items/aaa314d11ab6294afb70 (日本語)

### feature: [Fix inconsistent behavior by clearing QueryCache when reloading associations](https://github.com/rails/rails/pull/34094)

* branch: try043_query_cache
* article: https://qiita.com/suketa/items/42e8bd6c79b05e54c2e9 (日本語)

### feature: [Enum raises on invalid definition values](https://github.com/rails/rails/pull/34110)

* branch: try044_enum_validation
* article: https://qiita.com/suketa/items/d007b5ebca5cf107ed87 (日本語)

### feature: [Add allocations to template renderer subscription](https://github.com/rails/rails/pull/34136)

* branch: master
* article: https://qiita.com/suketa/items/835119ddc3e611e1b334 (日本語)

### feature: [Part 4: Multi db improvements, Basic API for connection switching](https://github.com/rails/rails/pull/34052)

* branch: try046_multidb_connection_switching
* article: https://qiita.com/suketa/items/91ea3e6ebaac131d5d9d (日本語)

### feature: [Deprecate Unicode#downcase/upcase/swapcase](https://github.com/rails/rails/pull/34123)

* branch: try047_unicode
* article: https://qiita.com/suketa/items/a4f4c8b7a3dd21078de2 (日本語)

### feature: [Fix issue where duration where always rounded up to a second](https://github.com/rails/rails/pull/34135)

* branch: try048_duration
* article: https://qiita.com/suketa/items/90a713787121e4400322 (日本語)

### feature: [Deprecate ActiveSupport::Multibyte::Chars.consumes?](https://github.com/rails/rails/pull/34215)

* branch: try049_deprecated_consumes
* article: https://qiita.com/suketa/items/1a04fd7e18977d00e10d (日本語)

### feature: [Issue #29200 scaffold an object with a reference displays an object memory address to user](https://github.com/rails/rails/pull/29204)

* branch: try050_scaffold
* article: https://qiita.com/suketa/items/98833dbf6eda211a4232 (日本語)

### feature: [Support default expression and expression indexes for MySQL](https://github.com/rails/rails/pull/34307)

* branch: try051_mysql_default_expression
* article: https://qiita.com/suketa/items/00e40d38a5b3180a8b32 (日本語)

### feature: [Rails6 のちょい足しな新機能を試す52（ActiveStorage::Blob#key編）](https://github.com/rails/rails/pull/34818)

* branch: try052_active_storage_blob_keys
* article: https://qiita.com/suketa/items/e39d2ffaa87bc7531344 (日本語)

### feature: [[ActiveStorage] Allow `variant` method to be called by `TIFF` images](https://github.com/rails/rails/pull/34824)

* branch: try053_accept_tiff_by_variant
* article: https://qiita.com/suketa/items/3f44636148afd26658bf (日本語)

### feature: [Allow strong params in ActiveRecord::Base#exists?](https://github.com/rails/rails/pull/34891)

* branch: try054_exists_accept_strong_params
* article: https://qiita.com/suketa/items/34d2092f86a89e7665e3 (日本語)

### feature: [Deprecate Unicode#downcase/upcase/swapcase](https://github.com/rails/rails/pull/34123)

* branch: try055_enum_blank
* article: https://qiita.com/suketa/items/f3047b2481217a0690d6 (日本語)

### feature: [Add an :if_not_exists option to create_table](https://github.com/rails/rails/pull/31382)

* branch: try056_create_table_if_not_exists
* article: https://qiita.com/suketa/items/3e24bef571572b6f7231 (日本語)

### feature: [Arel: Implemented DB-aware NULL-safe comparison](https://github.com/rails/rails/pull/34451)

* branch: try057_arel_null_safe_comparison
* article: https://qiita.com/suketa/items/9d93a241bdb569933ff6 (日本語)

### feature: [Add `ActiveModel::Errors#of_kind?`](https://github.com/rails/rails/pull/34866)

* branch: try058_errors_of_kind
* article: https://qiita.com/suketa/items/f86de3933978f249f9d8 (日本語)

### feature: [Support endless ranges in where](https://github.com/rails/rails/pull/34906)

* branch: try059_where_endless_range
* article: https://qiita.com/suketa/items/058044547543ffea1849 (日本語)

### feature: [Prevent TextHelper#word_wrap from stripping white space on the left side of long lines; Fixes #34487](https://github.com/rails/rails/pull/34488)

* branch: try060_word_wrap
* article: https://qiita.com/suketa/items/eed3e642e35f451d861c (日本語)

### feature: [ActionMailer: support overriding template name in multipart](https://github.com/rails/rails/pull/22534)

* branch: try061_mail_multi_part_template
* article: https://qiita.com/suketa/items/52389aad5566c59e220c (日本語)

### feature: [Refs #28025 nullify *_type column on polymorphic associations on :nulify polymorphic *_type column on dependent: :nullify strategy](https://github.com/rails/rails/pull/28078)

* branch: try062_nullify_polymorphic
* article: https://qiita.com/suketa/items/b8346f847513a5417505 (日本語)

### feature: [Add rails db:system:change command](https://github.com/rails/rails/pull/34832)

* branch: try063_db_system_change, try063_db_system_change_to_mysql
* article:

### feature: [Seed database with inline ActiveJob job adapter](https://github.com/rails/rails/pull/34953)

* branch: try064_seed_inline_active_job
* article:

### feature: [Make `t.timestamps` with precision by default](https://github.com/rails/rails/pull/34970)

* branch: try065_mysql_precision
* article:

### feature: [All of queries should return correct result even if including large number](https://github.com/rails/rails/pull/30000)

* branch: try066_query_with_large_number
* article:

### feature: [MySQL: Support `:size` option to change text and blob size](https://github.com/rails/rails/pull/35071)

* branch: try067_text_size
* article:

### feature: [Support before_reset callback in CurrentAttributes](https://github.com/rails/rails/pull/35063)

* branch: try068_current_attribute_before_reset
* article:

### feature: [Add 'Hash#deep_transform_values', and 'Hash#deep_transform_values!'](https://github.com/rails/rails/commit/b8dc06b8fdc16874160f61dcf58743fcc10e57db)

* branch: try069_deep_transform_values
* article:
