#!/bin/bash

if [ ! `which docker-compose` ]; then
  echo "docker-compose is not installed. Please install docker-compose via: sudo apt-get install docker-compose"
  exit 1;
fi

export BASE_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"

#if [ ! -f "$DOCKER_SOURCE_DIR/cleanup-build.sh" ]; then
#    cp "$BASE_DIR/cleanup-build.sh" "$DOCKER_SOURCE_DIR"
#fi

if [ ! -d "$BUILD_DIR" ]; then
    mkdir -p "$BUILD_DIR"
fi

COMPOSE_SERVICE="$1"

START_IDE_SCRIPT=start-ide.sh

export USER_ID=$(id -u ${USER})
export GROUP_ID=$(id -g ${USER})
docker-compose -f "$BASE_DIR/docker-compose/docker-compose.yml" -f "$BASE_DIR/$PROJECT_SETTINGS_DIR/docker-compose.yml" run --rm ${COMPOSE_SERVICE} "/home/developer/build-env/setup-build-env.sh" "/home/developer/build-env/${START_IDE_SCRIPT}"
