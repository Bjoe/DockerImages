#!/bin/bash

if [ -z "$GROUP_ID" -a -n "$USER_ID" ]
then
    echo "Set user id to ${USER_ID} for developer user"
    usermod -u ${USER_ID} developer
fi
if [ -n "$USER_ID" -a -n "$GROUP_ID" ]
then
    echo "set user id to ${USER_ID} and group id to ${GROUP_ID} for developer user"
    groupmod -g ${GROUP_ID} developer
    usermod -u ${USER_ID} -g ${GROUP_ID} developer
fi

su --whitelist-environment=\
ANDROID_NDK_HOME,\
ANDROID_HOME,\
PATH,\
CI,\
GITHUB_ACTIONS \
-l developer set-android-env.sh "$@"
