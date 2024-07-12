# memo

https://www.hotrails.dev/turbo-rails

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
