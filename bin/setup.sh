#!/bin/sh

# Remove any preexisting containers and volumes
docker compose down
docker rmi api-roles
docker volume rm priceline-roles_postgres-data

# Build the image
docker compose build

# Setup the database
docker compose run --rm api bin/rails db:create
docker compose run --rm api bin/rails db:migrate
docker compose run --rm api bin/rails db:migrate RAILS_ENV=test
docker compose run --rm api bin/rails db:seed

# Start the application
docker compose up -d