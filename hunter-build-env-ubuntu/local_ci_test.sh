#/bin/sh

cd docs
source ./jenkins.sh
./make.sh
cd ..

export PATH="$HOME/Development/polly/bin:$PATH"

TOOLCHAIN=gcc PROJECT_DIR=examples/$1 ./jenkins.py
