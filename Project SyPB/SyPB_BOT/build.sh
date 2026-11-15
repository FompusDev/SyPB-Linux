#!/bin/bash
set -e

echo "=== Building SyPB for Linux (i386) ==="

# Compiling with g++-8 / 32-bit and static libgcc/libstdc++
g++ -m32 -O2 -std=gnu++11 -fPIC -fvisibility=default -w \
    -I./include -I. -I.. -I../.. \
    -D__linux__ -Dlinux -D_GNU_SOURCE -DPLATFORM_LINUX32 \
    -static-libgcc -static-libstdc++ \
    -shared source/*.cpp -ldl -lm -o sypb_i386.so

echo "Build successful! Binary: sypb_i386.so"
ls -lh sypb_i386.so

