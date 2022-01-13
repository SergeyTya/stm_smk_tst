
rmdir "../build" /s /q
cmake -G "Eclipse CDT4 - Ninja" -DCMAKE_TOOLCHAIN_FILE=arm-gcc-toolchain.cmake -DCMAKE_ECLIPSE_VERSION=4.2 -DCMAKE_BUILD_TYPE=Debug -S . -B../build
