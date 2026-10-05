#!/bin/sh
set -eu
task_root=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)
mkdir -p "$task_root/build/runtime" "$task_root/evidence/runtime"
if [ "$(uname -s)" = Darwin ]; then
    task_sdk=$(xcrun --show-sdk-path)
    clang++ -std=c++17 -isysroot "$task_sdk" -isystem "$task_sdk/usr/include/c++/v1" \
      -O1 -g -Wall -Wextra -Werror -fsanitize=address,undefined \
      "$task_root/src/runtime/recording.cpp" "$task_root/tests/runtime/test_recording.cpp" \
      -o "$task_root/build/runtime/test_recording"
else
    c++ -std=c++17 -O1 -g -Wall -Wextra -Werror -fsanitize=address,undefined \
      "$task_root/src/runtime/recording.cpp" "$task_root/tests/runtime/test_recording.cpp" \
      -o "$task_root/build/runtime/test_recording"
fi
"$task_root/build/runtime/test_recording" > "$task_root/evidence/runtime/test_output.txt"
cat "$task_root/evidence/runtime/test_output.txt"
