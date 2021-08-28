IDE_SCRIPT=run-ide-docker.sh
BUILD_SCRIPT=build.sh
export COMPOSE_SERVICE_NAME="cpp"
if [ -z "${PROJECT_NAME}" ]; then
    export DOCKER_CONTAINER_NAME="cpp-qt-ubuntu"
else
    export DOCKER_CONTAINER_NAME="${PROJECT_NAME}-cpp-ubuntu"
fi
