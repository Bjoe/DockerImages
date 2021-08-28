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

if [ "$(docker ps -q -f name=\^$DOCKER_CONTAINER_NAME\$)" ]; then
  set -x
  docker attach $DOCKER_CONTAINER_NAME
elif [ "$(docker ps -aq -f name=\^$DOCKER_CONTAINER_NAME\$)" ]; then
  set -x
  docker start -ai $DOCKER_CONTAINER_NAME
else
  export USER_ID=$(id -u ${USER})
  export GROUP_ID=$(id -g ${USER})
  set -x
  docker-compose -f "$BASE_DIR/cpp-build-env-ubuntu/docker-compose.yml" -f "$BASE_DIR/$PROJECT_SETTINGS_DIR/docker-compose.yml" run --name ${DOCKER_CONTAINER_NAME} ${COMPOSE_SERVICE_NAME} "/bin/bash"
fi
