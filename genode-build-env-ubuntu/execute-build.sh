#!/bin/bash -x

cd source && \
tool/tool_chain MAKE_JOBS=15 x86 && \
tool/create_sdk x86_64 && \
tool/create_builddir x86_64 BUILD_DIR=build/x86_64
cd build/x86_64
make KERNEL=nova run/demo
