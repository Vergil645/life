#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

set -euxo pipefail

pushd "${SCRIPT_DIR}"

bison -d "lang.y"
lex "lang.lex"

clang++-18 \
    -I "../include" \
    "lex.yy.c" \
    "lang.tab.c" \
    $(llvm-config-18 --cppflags --ldflags --libs) \
    -lSDL2 \
    "../build/lib/libsim.a" \
    -o "start.out"

rm "lang.tab.c" \
    "lang.tab.h" \
    "lex.yy.c"

popd
