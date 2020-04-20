#!/bin/bash

groupmod -g ${GROUP_ID} ${DEVUSER}
usermod -u ${USER_ID} -g ${GROUP_ID} ${DEVUSER}
export DISPLAY=$DISPLAY
export SSH_AUTH_SOCK=$SSH_AUTH_SOCK

su --whitelist-environment=\
SSH_AUTH_SOCK,\
DISPLAY,\
DEVENV,\
HUNTER_ROOT,\
PROJECT_NAME,\
BUILD_DIR \
-l ${DEVUSER} $@
