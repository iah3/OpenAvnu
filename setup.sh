#!/bin/bash
set -ev

git submodule update --init --recursive
cd avdecc-lib
mkdir build
cd build
cmake ..
make
cd ./../../
cd ./lib/igb_avb/
make all
cp -r ./kmod ./../../
cp -r ./lib/* ./../
cd ./../../
cd ./daemons/gptp/
git pull https://github.com/iah3/gptp.git master
cd ./linux/build
ARCH=I210 make clean all
cd ./../../../../
make daemons_all
make examples_all
make avtp_pipeline
make avtp_avdecc
mkdir build
cd build
cmake .. -G "Unix Makefiles"
make
export ARGS=--output-on-failure
make test