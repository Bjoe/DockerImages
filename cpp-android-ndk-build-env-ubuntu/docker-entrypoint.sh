#!/bin/bash

groupmod -g ${GROUP_ID} developer
usermod -u ${USER_ID} -g ${GROUP_ID} developer

id

su --whitelist-environment=\
ANDROID_NDK_HOME,\
ANDROID_HOME,\
PATH,\
CI,\
GITHUB_ACTIONS \
-l developer set-android-env.sh
