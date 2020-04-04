#!/bin/bash

groupmod -g ${GROUP_ID} ${DEVUSER}
usermod -u ${USER_ID} -g ${GROUP_ID} ${DEVUSER}
export DISPLAY=$DISPLAY
export SSH_AUTH_SOCK=$SSH_AUTH_SOCK

su --whitelist-environment=\
DISPLAY,\
SSH_AUTH_SOCK,\
PROJECT_NAME,\
DEVENV,\
CMAKE_BUILD_TYPE,\
CMAKE_TOOLCHAIN_FILE,\
CMAKE_MAKE_PROGRAM,\
HUNTER_ROOT,\
PROJECT_PATH,\
BUILD_DIR \
-l ${DEVUSER} $@
