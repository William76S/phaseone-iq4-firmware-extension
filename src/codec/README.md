# 有界 RGB24 → JPEG 适配层

本目录完成的是宿主可验证的同步编码适配层。它通过调用者显式提供的公共 C libjpeg 函数表，使用固定容量 destination；容量耗尽立即返回 `IQ4_JPEG_OUTPUT_CAPACITY`，不会扩容、越界、暴露半个 JPEG 或修改 RGB 输入。所有 `setjmp/longjmp` 与资源收尾均在 C11 内完成，C++ 调用者的析构链不会被跳过。

目前没有相机函数地址绑定、私有 wrapper 调用、设备控制、部署、机内编码性能或帧率验收。`binding_abi_verified=1` 只是调用者的明确断言，本库不能代替执行者核对设备 hash、函数地址、内存映射、线程和运行时 ABI。默认零值拒绝编码。

## 宿主复现

从工程根目录执行。准备脚本只下载固定官方源包到 `evidence/codec/downloads`，检查 SHA256，构建本地静态库；不运行 install，不修改系统库。首次需要官方 GitHub 下载访问。

```sh
build/host-venv/bin/python src/codec/prepare_host_libjpeg.py
sh src/codec/build_host.sh
build/host-venv/bin/python tests/codec/run_host_validation.py \
  --test-executable evidence/codec/build/iq4_codec_tests \
  --host-library evidence/codec/build/libjpeg8/.libs/libjpeg.a \
  --evidence-root evidence/codec/runs/native
```

`ffmpeg` 和 `ffprobe` 必须可用，缺失时验证失败，不降级为只检查 JPEG 魔数。输入为 C++ 测试现场生成的 96×64 RGB 渐变/棋盘，包含每行 17 字节 padding。每次 runner 建立独立新目录。26 项测试覆盖容量 guard、输入不变、stride、描述符别名、API 错配、库 fatal/finish/cleanup 与悬停/错误进度；三份真实编码 JPEG 完整解码为 18,432 字节 RGB。JPEG 是有损输出，误差记录仅作证据，不代表色彩保真、相机 JPEG 风格或画质验收。

全部库 C 源及适配层的 sanitizer 复现：

```sh
build/host-venv/bin/python src/codec/prepare_host_libjpeg.py --sanitize
sh src/codec/build_host.sh --sanitize
ASAN_OPTIONS=detect_leaks=0 UBSAN_OPTIONS=halt_on_error=1 \
  build/host-venv/bin/python tests/codec/run_host_validation.py \
  --test-executable evidence/codec/build/sanitized/iq4_codec_tests \
  --host-library evidence/codec/build/libjpeg8_sanitized/.libs/libjpeg.a \
  --evidence-root evidence/codec/runs/sanitized
```

macOS 这轮未启用 LeakSanitizer。错误路径以 destroy 次数和后续可用编码验证收尾；如果原厂 `destroy_compress` 自身在释放完资源前 fatal，本层会报告 `IQ4_JPEG_CLEANUP_ERROR` 并避免递归 destroy，不能保证该未知实现已释放全部内部内存。

## CMake 与 AArch64

根项目可 `add_subdirectory(src/codec)` 并链接 `iq4_bounded_codec`。该库只有 libc/setjmp 依赖，没有链接原厂 libjpeg；全部八个 C API 入口由函数表提供。宿主公共头默认 API 80；目标布局请显式 `-DIQ4_CODEC_API_VERSION=82`，由 target 的 PUBLIC compile definition 向消费方传播。

独立宿主 CMake 示例：

```sh
cmake -S src/codec -B evidence/codec/build/cmake-host \
  -DIQ4_CODEC_BUILD_HOST_TESTS=ON \
  -DIQ4_CODEC_HOST_LIBJPEG="$PWD/evidence/codec/build/libjpeg8/.libs/libjpeg.a" \
  -DPython3_EXECUTABLE="$PWD/build/host-venv/bin/python"
cmake --build evidence/codec/build/cmake-host
ctest --test-dir evidence/codec/build/cmake-host --output-on-failure
```

已实际验证的目标编译命令如下，仅生成 relocatable ELF 对象，没有运行：

```sh
build/toolchains/zig-aarch64-macos-0.15.2/zig cc \
  -target aarch64-linux-gnu.2.28 -std=c11 -O2 -Wall -Wextra -Werror \
  -DIQ4_JPEG_API_VERSION=82 -c src/codec/bounded_jpeg.c \
  -o evidence/codec/build/bounded_jpeg_aarch64.o
```

CMake 示例是否实际执行请看 `evidence/codec/verification.json`，不得把构建说明当作验证结果。

## Recorder 集成约束

调用者持有整帧 RGB 副本及其真实源 PTS/sequence，直到同步编码返回。目标 source adapter 必须证明行距、有效完整源框、未合成显示遮罩，以及与采集 owner 的安全关系。成功后将 caller-owned 输出截到 `result.jpeg_bytes`，保留原帧 PTS/sequence，再交给现有 `MjpegMatroskaBackend` 或严格 CFR 的 `MjpegAviBackend`。适配层不会生成 PTS、重复帧、LUT、显示遮罩或 RAW 风格元数据，也不会自动将失败输出写入容器。

输入固定为 8-bit interleaved RGB24，尺寸 1..65500，显式 stride，quality 1..100，baseline JPEG。库默认 subsampling 与颜色转换来自所绑定的 libjpeg `set_defaults`。本层不宣称对 source RGB 自动建立 sRGB/ICC。输出容量 1..128 MiB；这个硬上限只约束 caller-owned JPEG destination，libjpeg 内部工作内存仍由库分配，分配失败经过 error_exit 收尾。

## 固定来源与许可

公开头 `jpeglib.h`、`jmorecfg.h`、`jerror.h` 与 `LICENSE.md`、`README.ijg` 原样来自 [官方 1.5.3 发布包](https://github.com/libjpeg-turbo/libjpeg-turbo/releases/tag/1.5.3)。固定包 SHA256：`b24890e2bb46e12e72a79f7e965f409f4e16466d00e1dd15d93d73ee6b592523`。每份 vendor 文件 hash 与源文件一致记录在 `evidence/codec/source_provenance.json`。

`vendor/.../jconfig.h` 是本项目明确标注的生成配置，不是原厂文件。官方 1.5.3 默认 API 62、JPEG8 模式为 80；静态固件检查要求 82。API82 配置只用于已核对的 JPEG8 系 LP64 结构布局，不能声称已获得原厂完整配置。完整证据与未验证项见 `analysis/recording/JPEG_BOUNDED_ADAPTER.md`。

This software is based in part on the work of the Independent JPEG Group.

分发时保留 vendor 目录的未修改版权/许可及 `README.ijg`；具体条款见 `vendor/libjpeg-turbo-1.5.3/LICENSE.md`。本工程未将私有固件模块或原厂库作为编码测试依赖提交。
