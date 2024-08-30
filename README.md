# memo

## How to use

You need to install Docker and Docker Compose.
This branch is for Rails.
There is a Rails sandbox app in this branch created by the following command.

```bash
rails new sandbox --database postgresql
```
You can create a new Rails app in this branch.

```bash
cp .env.local .env
docker compose up -d
docker compose exec web bash
cd sandbox
bundle install
bin/rails -v # => Rails 7.2.1
bin/rails db:create
bin/rails -p -b 0.0.0.0 # => access http://localhost:3000 from your browser.
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
