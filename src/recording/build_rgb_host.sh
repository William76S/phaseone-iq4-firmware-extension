#!/bin/sh
set -eu
RECORDING_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PROJECT_DIR=$(CDPATH= cd -- "$RECORDING_DIR/../.." && pwd)
BUILD_DIR="$PROJECT_DIR/evidence/recording/build/rgb-chain"
CODEC_BUILD="$PROJECT_DIR/evidence/codec/build"
JPEG_LIB="$CODEC_BUILD/libjpeg8/.libs/libjpeg.a"
RGB_FLAGS='-O2'
if [ "${1:-}" = '--sanitize' ]; then
    BUILD_DIR="$BUILD_DIR/sanitized"
    CODEC_BUILD="$CODEC_BUILD/sanitized"
    JPEG_LIB="$PROJECT_DIR/evidence/codec/build/libjpeg8_sanitized/.libs/libjpeg.a"
    RGB_FLAGS='-O1 -g -fsanitize=address,undefined -fno-omit-frame-pointer'
elif [ -n "${1:-}" ]; then
    echo 'Usage: build_rgb_host.sh [--sanitize]' >&2
    exit 2
fi
mkdir -p "$BUILD_DIR"
RGB_SDK=$(xcrun --show-sdk-path)
clang++ -std=c++17 $RGB_FLAGS -Wall -Wextra -Wpedantic -Werror \
    -isysroot "$RGB_SDK" -isystem "$RGB_SDK/usr/include/c++/v1" \
    "$PROJECT_DIR/src/runtime/recording.cpp" "$RECORDING_DIR/mjpeg_avi.cpp" \
    "$RECORDING_DIR/rgb_jpeg_backend.cpp" "$PROJECT_DIR/tests/recording/test_rgb_backend.cpp" \
    "$CODEC_BUILD/libiq4_bounded_codec.a" "$JPEG_LIB" -o "$BUILD_DIR/iq4_rgb_recording_tests"
