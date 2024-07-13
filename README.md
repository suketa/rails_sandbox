# memo

https://www.hotrails.dev/turbo-rails

Next: https://www.hotrails.dev/turbo-rails/css-ruby-on-rails

config/database.yml

```yml
# postgresql setting

  host: <%= ENV.fetch("DB_HOST", "postgres") %>
  username: <%= ENV.fetch("POSTGRES_USER") %>
  password: <%= ENV.fetch("POSTGRES_PASSWORD") %>

# mysql setting

  username: root
  password:
  host: <%= ENV.fetch("DB_HOST") { "mysql" } %>
```
