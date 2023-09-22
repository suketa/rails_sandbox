# Rails Sandbox

This project is sandbox for trying new features of Rails

## How to run

```
$ docker compose build
$ env POSTGRES_USER=xxxx POSTGRES_PASSWORD=yyyy docker-compose up -d
$ docker compose exec web bash
# bundle
# bin/rails db:create db:migrate
# bin/rails c
> Bug.bbb
```
