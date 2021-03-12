IDE_SCRIPT=run-ide-docker.sh
BUILD_SCRIPT=build.sh
export COMPOSE_SERVICE_NAME="cpp-ide"
if [ -z "${PROJECT_NAME}" ]; then
    export DOCKER_CONTAINER_NAME="dev-qt-cpp-ide"
else
    export DOCKER_CONTAINER_NAME="${PROJECT_NAME}-dev-qt-cpp-ide"
fi
