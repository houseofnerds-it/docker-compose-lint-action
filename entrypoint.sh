#!/bin/sh -l

COMPOSE_PATH="$1"
COMPOSE_SECRET_PATH=$(echo $COMPOSE_PATH | sed  "s/docker-compose.yml/${INPUT_SECRET_FILENAME:-docker-compose.secret.yml}/")

if [[ ! -f "$COMPOSE_PATH" ]]; then
    echo "$COMPOSE_PATH not found"
    exit 1
fi


if [[ -f "$COMPOSE_SECRET_PATH" ]]; then
    echo "Secret File found. Using both files for linting."
    docker compose -f "$COMPOSE_PATH" -f "$COMPOSE_SECRET_PATH" config
else
    echo checking "$COMPOSE_PATH"
    docker compose -f "$COMPOSE_PATH" config
fi