# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Rails 8.1.2 sandbox application with Docker development environment. The Rails application code lives in the `sandbox/` directory.

- Ruby 3.4.7
- Rails 8.1.2
- PostgreSQL 18.0
- Frontend: Hotwire (Turbo + Stimulus), Tailwind CSS, Importmap

## Development Commands

All commands should be run from within the `sandbox/` directory (or inside the Docker container).

### Docker Environment
```bash
# Build and start
docker compose build
docker compose up -d

# Enter container shell
docker compose exec web bash
```

### Server
```bash
# Development server with Tailwind watch (uses foreman)
bin/dev

# Or manually
bin/rails server -b 0.0.0.0
bin/rails tailwindcss:watch
```

### Database
```bash
bin/rails db:create db:migrate
bin/rails db:seed
```

### Testing
```bash
# Run all tests
bin/rails test

# Run single test file
bin/rails test test/models/post_test.rb

# Run specific test by line number
bin/rails test test/models/post_test.rb:10
```

### Linting & Security
```bash
# RuboCop (uses rubocop-rails-omakase)
bin/rubocop
bin/rubocop -a  # auto-correct

# Security checks
bin/brakeman --quiet
bin/bundler-audit
bin/importmap audit

# Full CI pipeline
bin/ci
```

### Assets
```bash
bin/rails tailwindcss:build
bin/rails assets:precompile
```

## Architecture

### Current Feature: Markdown Editor
The application includes a Posts CRUD with GitHub-style Markdown preview:

- `PostsController` - Standard CRUD with Commonmarker rendering in show action
- `Posts::PreviewsController` - Live Markdown preview endpoint via Turbo Stream
- `preview_controller.js` - Stimulus controller using @rails/request.js for async preview

### Key Gems
- `commonmarker` - GitHub-flavored Markdown parsing
- `requestjs-rails` - JavaScript request library for Hotwire
- `solid_cache`, `solid_queue`, `solid_cable` - Database-backed Rails infrastructure
- `kamal` + `thruster` - Deployment with HTTP acceleration

### Frontend Stack
- Importmap for ES modules (no bundler)
- Stimulus controllers in `app/javascript/controllers/`
- Tailwind CSS compiled via `tailwindcss-rails`
