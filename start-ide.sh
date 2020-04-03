#!/bin/bash

tmux -S /var/tmp/${PROJECT_NAME}-${DEVENV} -L ${PROJECT_NAME}-${DEVENV} new /bin/bash
