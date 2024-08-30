# memo

## How to use

You need to install Docker and Docker Compose.
This branch is for Rails but there is no Rails app in this branch.
You can create a new Rails app in this branch.

```bash
cp .env.local .env
docker compose up -d
docker compose exec web bash
rails -v # => Rails 7.2.1
node -v # => v20.17.0
```

## config/database.yml

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
