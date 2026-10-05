#!/bin/sh
set -eu
DISPLAY_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PROJECT_DIR=$(CDPATH= cd -- "$DISPLAY_DIR/../.." && pwd)
BUILD_DIR="$PROJECT_DIR/evidence/display/build"
mkdir -p "$BUILD_DIR"
CXX=${CXX:-clang++}
set --
if [ "$(uname -s)" = Darwin ]; then
    DISPLAY_SDK=$(xcrun --show-sdk-path)
    set -- -isysroot "$DISPLAY_SDK" -isystem "$DISPLAY_SDK/usr/include/c++/v1"
fi
"$CXX" --version > "$BUILD_DIR/compiler.txt"
"$CXX" "$@" -std=c++17 -O2 -Wall -Wextra -Wpedantic -Werror -pthread -I "$PROJECT_DIR/src/core/include" -I "$DISPLAY_DIR/include" -c "$DISPLAY_DIR/lib/display_mask.cpp" -o "$BUILD_DIR/display_mask.o"
ar rcs "$BUILD_DIR/libiq4_display_mask.a" "$BUILD_DIR/display_mask.o"
"$CXX" "$@" -std=c++17 -O2 -Wall -Wextra -Wpedantic -Werror -pthread -I "$PROJECT_DIR/src/core/include" -I "$DISPLAY_DIR/include" "$PROJECT_DIR/src/core/lib/image_core.cpp" "$PROJECT_DIR/tests/display/test_display.cpp" "$BUILD_DIR/libiq4_display_mask.a" -o "$BUILD_DIR/iq4_display_tests"
"$BUILD_DIR/iq4_display_tests" > "$BUILD_DIR/test.log" 2>&1 || { cat "$BUILD_DIR/test.log"; exit 1; }
cat "$BUILD_DIR/test.log"
sed -n 's/^RESULT_JSON //p' "$BUILD_DIR/test.log" > "$BUILD_DIR/test_results.json"
