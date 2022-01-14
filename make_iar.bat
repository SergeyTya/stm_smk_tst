
rmdir "../build" /s /q
cmake -G "Eclipse CDT4 - Ninja" -DCMAKE_TOOLCHAIN_FILE=iar-toolchain.cmake -DCMAKE_ECLIPSE_VERSION=4.2 -S . -B../build
