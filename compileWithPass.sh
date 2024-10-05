#!/usr/bin/env bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Compile Pass
rm -rf build
cmake -S "${SCRIPT_DIR}" -B "${SCRIPT_DIR}/build"
make -C "${SCRIPT_DIR}/build"

# Generate IR of src/app.c
rm -rf build-trace
mkdir "${SCRIPT_DIR}/build-trace" &> /dev/null || true
mkdir "${SCRIPT_DIR}/IR" &> /dev/null || true
clang-18 \
    -I "${SCRIPT_DIR}/include" \
    -S \
    -emit-llvm \
    -O2 \
    -fpass-plugin="${SCRIPT_DIR}/build/lib/libPass.so" \
    "${SCRIPT_DIR}/src/app.c" \
    -o "${SCRIPT_DIR}/IR/app_with_trace.ll"

# Compile executable
clang-18 \
    -I "${SCRIPT_DIR}/include" \
    -O2 \
    -lSDL2 \
    "${SCRIPT_DIR}/src/start.c" \
    "${SCRIPT_DIR}/IR/app_with_trace.ll" \
    "${SCRIPT_DIR}/build/lib/libsim.a" \
    "${SCRIPT_DIR}/build/lib/libdeps.a" \
    -o "${SCRIPT_DIR}/build-trace/start_with_trace" \