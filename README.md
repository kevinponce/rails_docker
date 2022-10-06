# README

Create and copy the following files:
* `Dockerfile`
* `docker-compose.yml`
* `entrypoint.sh`

# rails_docker/config/database.yml
```
development:
  <<: *default
  host: db
  database: rails_docker_development
  username: postgres
  password: password
```

## Get it up and running
```
docker compose build
docker compose up
```

## Helpful commands
```
docker exec -it rails_docker-db-1 psql -U postgres
docker exec -it rails_docker-web-1 bin/rails db:create
docker exec -it rails_docker-web-1 bin/rails db:migrate
docker exec -it rails_docker-web-1 bin/rails c
```
