#!/usr/bin/env bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


# Compile Pass, libdeps.a (depemdencies for Pass) and libsim.a
rm -rf build
cmake -S "${SCRIPT_DIR}" -B "${SCRIPT_DIR}/build"
cmake --build "${SCRIPT_DIR}/build"


# Generate IR of src/app.c
mkdir "${SCRIPT_DIR}/IR" &> /dev/null || true
clang-18 \
    -I "${SCRIPT_DIR}/include" \
    -S \
    -emit-llvm \
    -O2 \
    -fpass-plugin="${SCRIPT_DIR}/build/lib/libPass.so" \
    "${SCRIPT_DIR}/src/app.c" \
    -o "${SCRIPT_DIR}/IR/app_with_trace.ll"


# Prepare build-trace directory
rm -rf build-trace
mkdir "${SCRIPT_DIR}/build-trace" &> /dev/null || true


# Compile src/app.c into object file
clang-18 \
    -I "${SCRIPT_DIR}/include" \
    -c \
    -O2 \
    -fpass-plugin="${SCRIPT_DIR}/build/lib/libPass.so" \
    "${SCRIPT_DIR}/src/app.c" \
    -o "${SCRIPT_DIR}/build-trace/app_with_trace.o"


# Compile executable
clang-18 \
    -I "${SCRIPT_DIR}/include" \
    -O2 \
    -lSDL2 \
    "${SCRIPT_DIR}/src/start.c" \
    "${SCRIPT_DIR}/build-trace/app_with_trace.o" \
    "${SCRIPT_DIR}/build/lib/libsim.a" \
    "${SCRIPT_DIR}/build/lib/libdeps.a" \
    -o "${SCRIPT_DIR}/build-trace/start_with_trace" \