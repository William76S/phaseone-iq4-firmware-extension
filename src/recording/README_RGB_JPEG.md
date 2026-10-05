# Owned RGB → 有界 JPEG → 容器

`rgb_jpeg_backend.hpp/.cpp` 是现有 `runtime::Backend` 的串行 decorator，组成真正可编译的 RGB24→固定容量 JPEG→Matroska/AVI 源码链。调用者提供 width、height、stride、maxInputBytes、quality、maxOutputBytes、显式 `Iq4JpegApi` 函数表及一个 packet backend。本层不绑定设备、推断 stride、缩放图像、叠加显示遮罩、生成/复制源帧或生成源时间戳。

本阶段为宿主验证：优化及全部链路 ASan/UBSan 两轮各13/13，五个真实可解码容器共13帧，每个 JPEG packet 与独立直接编码的 packet 字节相同；Matroska 精确保留不规则纳秒间隔，原始 PTS/sequence journal 逐项一致。API82 的 AArch64 对象编译通过。没有相机执行、真实卡写入、LV owner 接口或硬件fps结论；宿主文件系统 APFS 不能代表 IQ4 FAT/exFAT 卡。

## 生命周期与边界

`prepare` 先验证函数表和全部布局/预算，在任何 downstream IO 前分配固定上限 JPEG buffer。输入必须至少覆盖 `(height-1)*stride + width*3`，且不超过显式 maxInputBytes。编码使用调用者已经持有的 `Frame.bytes`，不会额外复制 RGB；该 RGB 必须保持独占稳定直到同步返回。

每个成功的 codec 调用只提交一个完整 packet，原 PTS 和 optional sequence 原样转发。packet buffer 分配在 session 内复用，下游 `encode(const Frame&)` 必须同步消费或自行建立拥有权，不能保存该借用 pointer/reference。整个 decorator 和 Recorder 均需一个串行执行者，调用和回调不得重入；UI 应投递到该执行者。

编码容量不足、无效输入、downstream错误都会收尾并 rethrow，现有 Recorder 进入 Error；第二次 abort 不重复执行 downstream abort。finalize成功或abort均释放 packet allocation。prepare部分失败也清理；再次prepare不会打断已经活动的session。没有全局默认 encoder binding，也没有持久配置写入。

输出 buffer 的硬容量上限不约束 libjpeg 的内部工作分配，完整错误和 ABI 边界见 `src/codec/README.md`。下游质量、尺寸与maxPacketBytes应与本配置一致，尺寸不一致或预算不足由下游明确拒绝。调用者不能把录像总encode耗时或容器rate当作采集帧率。

对可变 LV 使用现有 `MjpegMatroskaBackend`；`MjpegAviBackend` 默认严格CFR，不规则输入会报错。空会话遵循现有下游对零packet的拒绝语义，abort留下可检查partial；没有伪造一帧作为占位。源中断通过 Recorder.source_lost 保存队列内拥有的帧并收尾后报告中断。

## 宿主复现

先完成 `src/codec/README.md` 的固定官方库及适配层构建，再从工程根执行：

```sh
sh src/recording/build_rgb_host.sh
build/host-venv/bin/python tests/recording/run_rgb_host_validation.py \
  --test-executable evidence/recording/build/rgb-chain/iq4_rgb_recording_tests \
  --evidence-root evidence/recording/runs/rgb-native
```

```sh
sh src/recording/build_rgb_host.sh --sanitize
ASAN_OPTIONS=detect_leaks=0 UBSAN_OPTIONS=halt_on_error=1 \
  build/host-venv/bin/python tests/recording/run_rgb_host_validation.py \
  --test-executable evidence/recording/build/rgb-chain/sanitized/iq4_rgb_recording_tests \
  --evidence-root evidence/recording/runs/rgb-sanitized
```

runner每次建立新目录，真实FFmpeg/ffprobe缺失即失败。测试使用主机96×64合成RGB，无camera素材。输出包含五个容器、独立编码expected packets和完整decode/PTS/sequence证据。截短RGB与非CFR错误后的恢复写入新exclusive final，原partial逐字节不变。

## 项目集成

根集成由主执行者完成，可独立建立：

```cmake
add_library(iq4_rgb_jpeg_backend STATIC src/recording/rgb_jpeg_backend.cpp)
target_link_libraries(iq4_rgb_jpeg_backend PUBLIC iq4_bounded_codec iq4_recording)
add_executable(iq4_rgb_recording_tests tests/recording/test_rgb_backend.cpp)
target_link_libraries(iq4_rgb_recording_tests PRIVATE
  iq4_rgb_jpeg_backend iq4_runtime_core ${IQ4_CODEC_HOST_LIBJPEG})
add_test(NAME iq4_rgb_recording_host_validation
  COMMAND ${Python3_EXECUTABLE} ${CMAKE_SOURCE_DIR}/tests/recording/run_rgb_host_validation.py
    --test-executable $<TARGET_FILE:iq4_rgb_recording_tests>
    --evidence-root ${CMAKE_SOURCE_DIR}/evidence/recording/runs/rgb-cmake)
```

新 library 继承 `iq4_bounded_codec` 的 PUBLIC API version definition，host固定80，目标显式82。不需要改变已经冻结的 `mjpeg_avi.cpp/.hpp`。目标独立编译命令实际通过：

```sh
build/toolchains/zig-aarch64-macos-0.15.2/zig c++ \
  -target aarch64-linux-gnu.2.28 -std=c++17 -O2 -Wall -Wextra -Wpedantic -Werror \
  -DIQ4_JPEG_API_VERSION=82 -c src/recording/rgb_jpeg_backend.cpp \
  -o evidence/recording/build/rgb-chain/rgb_jpeg_backend_aarch64.o
```

源码与证据清单：`evidence/recording/SHA256SUMS_RGB`；阶段结果：`evidence/recording/rgb_chain_verification.json`。目标运行和原厂ABI未验证，不得据此启用自动相机部署。

This software is based in part on the work of the Independent JPEG Group.
