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
* article:

## feature: [Add deprecation warning when String#first and String#last receive negative integers](https://github.com/rails/rails/pull/33058)

* branch: try037_string_first_last
* article:
