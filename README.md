# README

```shell
env POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose up -d --build
rails new . --database=postgresql -j esbuild --css tailwind
bin/rails db:create
bin/rails g scaffold user name
bin/rails db:migrate
foreman start -f Procfile.dev
```
