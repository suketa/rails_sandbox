# Rails 6.0.0rc1 Sandbox

This project is sandbox for trying new features of Rails 6.0.0rc1

## How to run

```
$ env POSTGRES_USER=xxxx POSTGRES_PASSWORD=yyyy docker-compose up -d
$ docker-compose exec web bash
```

## feature: [Store newly-uploaded files on save rather than assignment](https://github.com/rails/rails/pull/33303)

* branch: try015_active_storage
* article: https://qiita.com/suketa/items/2daad87d8c22737f5582 (Japanese)

## feature: [Add implicit to path conversion to uploaded file](https://github.com/rails/rails/pull/28676)

* branch: try016_uploaded_file_path
* article: https://qiita.com/suketa/items/c06068518ae0ba283b2b (Japanese)

## feature: [Use public_send in value_for_collection](https://github.com/rails/rails/pull/33547)

* branch: try018
* article: https://qiita.com/suketa/items/8e238df881b2c55b24f9 (Japanese)

## feature: [Emit warning for unknown inflection rule when generating model](https://github.com/rails/rails/pull/33766)

* branch try019_db_singular_and_plural_warning
* article: https://qiita.com/suketa/items/82da66f61c9a0f337126 (Japanese)

## feature: [Fail more gracefully from ActiveStorage missing file exceptions](https://github.com/rails/rails/pull/33666)

* branch try020_active_storage_missing_file
* article: https://qiita.com/suketa/items/97bbfa3626ea542e9e0b (Japanese)

## feature: [Maintain html_safe? on sliced HTML safe strings](https://github.com/rails/rails/pull/33808)

* branch try021_html_safe
* article: https://qiita.com/suketa/items/bf4f422d7797fae97406 (Japanese)

## feature: [Configuration item config.filter_parameters could also filter out sensitive values of database columns when call #inspect](https://github.com/rails/rails/pull/33756)

* branch try022_filter_parameters
* article: https://qiita.com/suketa/items/ce5d3e6439086b5e86f9 (Japanese)

## feature: [update I18n fallbacks configuration to be compatible with i18n 1.1.0](https://github.com/rails/rails/pull/33574)

* branch try023_i18n_fallbacks
* article: https://qiita.com/suketa/items/27251aeef4fac8cc5262 (Japanese)
