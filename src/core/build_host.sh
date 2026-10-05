#!/bin/sh
set -eu
CORE_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PROJECT_DIR=$(CDPATH= cd -- "$CORE_DIR/../.." && pwd)
BUILD_DIR="$PROJECT_DIR/build/core"
mkdir -p "$BUILD_DIR"
CXX=${CXX:-clang++}
set --
# This host's CLT includes an incomplete usr/include/c++/v1 tree; use the SDK's
# complete matching libc++ headers explicitly. No toolchain installation needed.
if [ "$(uname -s)" = Darwin ]; then
    CORE_SDK=$(xcrun --show-sdk-path)
    set -- -isysroot "$CORE_SDK" -isystem "$CORE_SDK/usr/include/c++/v1"
fi
"$CXX" --version > "$BUILD_DIR/compiler.txt"
"$CXX" "$@" -std=c++17 -O2 -Wall -Wextra -Wpedantic -Werror -pthread -I "$CORE_DIR/include" -c "$CORE_DIR/lib/image_core.cpp" -o "$BUILD_DIR/image_core.o"
ar rcs "$BUILD_DIR/libiq4_image_core.a" "$BUILD_DIR/image_core.o"
"$CXX" "$@" -std=c++17 -O2 -Wall -Wextra -Wpedantic -Werror -pthread -I "$CORE_DIR/include" "$PROJECT_DIR/tests/core/test_core.cpp" "$BUILD_DIR/libiq4_image_core.a" -o "$BUILD_DIR/iq4_core_tests"
"$BUILD_DIR/iq4_core_tests" "$PROJECT_DIR/fixtures/luts" > "$BUILD_DIR/test.log" 2>&1 || { cat "$BUILD_DIR/test.log"; exit 1; }
cat "$BUILD_DIR/test.log"
sed -n 's/^RESULT_JSON //p' "$BUILD_DIR/test.log" > "$BUILD_DIR/test_results.json"
