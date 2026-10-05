#!/bin/sh
set -eu
RECORDING_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PROJECT_DIR=$(CDPATH= cd -- "$RECORDING_DIR/../.." && pwd)
BUILD_DIR="$PROJECT_DIR/evidence/recording/build"
mkdir -p "$BUILD_DIR"
set --
if [ "$(uname -s)" = Darwin ]; then
    RECORDING_SDK=$(xcrun --show-sdk-path)
    set -- -isysroot "$RECORDING_SDK" -isystem "$RECORDING_SDK/usr/include/c++/v1"
fi
CXX=${CXX:-clang++}
"$CXX" --version > "$BUILD_DIR/compiler.txt"
"$CXX" "$@" -std=c++17 -O2 -Wall -Wextra -Wpedantic -Werror -c "$RECORDING_DIR/mjpeg_avi.cpp" -o "$BUILD_DIR/mjpeg_avi.o"
ar rcs "$BUILD_DIR/libiq4_recording.a" "$BUILD_DIR/mjpeg_avi.o"
"$CXX" "$@" -std=c++17 -O2 -Wall -Wextra -Wpedantic -Werror "$PROJECT_DIR/src/runtime/recording.cpp" "$PROJECT_DIR/tests/recording/test_recording.cpp" "$BUILD_DIR/libiq4_recording.a" -o "$BUILD_DIR/iq4_recording_tests"
