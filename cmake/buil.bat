#!/bin/bash

#cmake -G 'Eclipse CDT4 - Unix Makefiles' -DCMAKE_TOOLCHAIN_FILE=arm-gcc-toolchain.cmake -DCMAKE_ECLIPSE_VERSION=4.2 -DCMAKE_BUILD_TYPE=Debug -S . -B../build
#cmake -G 'Unix Makefiles' -DCMAKE_BUILD_TYPE=Debug -S . -Bbuild
#cmake --build build


cmake -G "Ninja" -DCMAKE_TOOLCHAIN_FILE=arm-gcc-toolchain.cmake -DCMAKE_BUILD_TYPE=Debug -S . -B../build
