#!/bin/sh
set -eu
CODEC_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PROJECT_DIR=$(CDPATH= cd -- "$CODEC_DIR/../.." && pwd)
BUILD_DIR="$PROJECT_DIR/evidence/codec/build"
CODEC_FLAGS='-O2'
JPEG_BUILD="$BUILD_DIR/libjpeg8"
if [ "${1:-}" = '--sanitize' ]; then
    JPEG_BUILD="$BUILD_DIR/libjpeg8_sanitized"
    BUILD_DIR="$BUILD_DIR/sanitized"
    CODEC_FLAGS='-O1 -g -fsanitize=address,undefined -fno-omit-frame-pointer'
elif [ -n "${1:-}" ]; then
    echo 'Usage: build_host.sh [--sanitize]' >&2
    exit 2
fi
if [ ! -f "$JPEG_BUILD/.libs/libjpeg.a" ]; then
    echo 'Missing fixed host libjpeg-turbo1.5.3 JPEG8 build; see src/codec/README.md' >&2
    exit 1
fi
mkdir -p "$BUILD_DIR"
clang -std=c11 $CODEC_FLAGS -Wall -Wextra -Wpedantic -Werror -c "$CODEC_DIR/bounded_jpeg.c" -o "$BUILD_DIR/bounded_jpeg.o"
ar rcs "$BUILD_DIR/libiq4_bounded_codec.a" "$BUILD_DIR/bounded_jpeg.o"
CODEC_SDK=$(xcrun --show-sdk-path)
clang++ -std=c++17 $CODEC_FLAGS -Wall -Wextra -Wpedantic -Werror -isysroot "$CODEC_SDK" -isystem "$CODEC_SDK/usr/include/c++/v1" "$PROJECT_DIR/tests/codec/test_bounded.cpp" "$BUILD_DIR/libiq4_bounded_codec.a" "$JPEG_BUILD/.libs/libjpeg.a" -o "$BUILD_DIR/iq4_codec_tests"
