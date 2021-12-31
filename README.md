# README

try to use tailwindcss in Rails 7.0.0

```shell
env POSTGRES_USER=xxxx POSTGRES_PASSWORD=yyyy docker-compose up -d --build
rails new . --database=postgresql -j esbuild --css tailwind
bin/rails db:create
bin/rails g scaffold user name
bin/rails db:migrate
foreman start -f Procfile.dev
```
