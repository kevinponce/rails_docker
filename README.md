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
docker ps
docker compose build
```

## Helpful commands
```
docker compose up
docker compose run web bin/rails c

docker container ls # use name for commands below

docker exec -it rails_docker-db-1 psql -U postgres
docker exec -it rails_docker-db-1 psql -U postgres -d rails_docker_development < backup.sql

docker exec -it rails_docker-web-1 bin/rails db:create
docker exec -it rails_docker-web-1 bin/rails db:migrate
docker exec -it rails_docker-web-1 bin/rails c

docker exec -it rails_docker-railsdocker-1 bin/rails c

kompose convert -o .kubernetes/ -f docker-compose.yml
```

# TODO
* fix db name
* Add redshift to testing eks
* delete `.kubernetesMongo`
* seed database
* test
