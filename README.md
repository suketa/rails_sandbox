# README

try Rails7 bootstrap

## what I tried

```
rails new . --database=postgresql --css=bootstrap
bin/rails g scaffold User name
bin/rails db:create db:migrate
foreman start -f Procfile.dev
```

## How to run
```
env POSTGRES_USER=xxx POSTGRES_PASSWORD=yyy docker-compose up -d
docker-compose exec web bash
bin/rails db:create db:migrate
foreman start -f Procfile.dev
```

access http://localhost:3000/users
