# README

PWA example

https://alicia-paz.medium.com/make-your-rails-app-work-offline-part-1-pwa-setup-3abff8666194

## How to start

```
cp dot.env .env
# edit .env file and set environment variables if you need.
# edit docker-compose.yml if you need.
docker compose build
docker compose up -d
docker compose exec web bash
bin/rails s -b 0.0.0.0
```

access http://localhost:3030/ from your browser
