# Rails Sandbox

This project is sandbox for trying new features of Rails

## How to run

Run your console
```
docker compose build
env POSTGRES_USER=xxxx POSTGRES_PASSWORD=yyyy docker-compose up -d
docker compose exec web bash
```

Run at web container
```
bundle
bin/rails db:create db:migrate
bin/rails c
```

Run at rails console
```
Bug.bbb
```
