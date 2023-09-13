# Roles

This service is responsible for managing the roles of the users.

It enhances the `Users` and `Teams` services, by giving us the concept of team
roles and  the ability to associate them with team members.

## Stack

- Ruby on Rails 7.0 (API mode)
- PostgreSQL 13
- Rspec
- Docker + Composer

## Setup

> **Before proceding, make sure that you have `docker` and `docker-compose`
installed. See https://docs.docker.com/compose/install/ for more information.**

All you need to do is build the images and run the containers.

Build images:
```shell
docker compose build
```

Create databases:
```shell
docker compose run --rm api bin/rails db:create
docker compose run --rm api bin/rails db:migrate
docker compose run --rm api bin/rails db:seed
```

Run containers:
```shell
docker compose up
```

## Testing

Testing the application is pretty simple, it uses Rspec and you can run the
tests with the following command:

```shell
bundle exec rspec
```

If that doesn't work, make sure you have all dependencies install before running
the tests. So don't forget to run:

```shell
bundle install
```

Running specs in containers are not advised.

## Accessing the app

- Rails API: http://localhost:3000