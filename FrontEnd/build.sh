#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

set -euxo pipefail

pushd "${SCRIPT_DIR}"

bison -d "${SCRIPT_DIR}/lang.y"
lex "${SCRIPT_DIR}/lang.lex"

clang++-18 \
    -I "${SCRIPT_DIR}/../include" \
    "${SCRIPT_DIR}/lex.yy.c" \
    "${SCRIPT_DIR}/lang.tab.c" \
    $(llvm-config-18 --cppflags --ldflags --libs) \
    -o "${SCRIPT_DIR}/start.out"

rm "${SCRIPT_DIR}/lang.tab.c" \
    "${SCRIPT_DIR}/lang.tab.h" \
    "${SCRIPT_DIR}/lex.yy.c"

popd
