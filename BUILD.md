# 源码与本轮构建

当前交付是0.1.0主机验证源码与静态定位成果。没有机内ABI适配器、可安装固件包或通过恢复验收的安装物。

在项目目录执行：

```sh
sh src/core/build_host.sh
sh src/display/build_host.sh
sh src/runtime/build_host.sh
python3 -m unittest discover -s tools/sdk -p 'test_*.py' -v
```

原生CMake入口：

```sh
cmake -S . -B build/cmake-host -DCMAKE_BUILD_TYPE=Debug -DPython3_EXECUTABLE="$PWD/build/host-venv/bin/python"
cmake --build build/cmake-host
ctest --test-dir build/cmake-host --output-on-failure
```

录像媒体测试需要可用的 ffmpeg/ffprobe；缺少时明确失败。测试生成 JPEG 素材仅用于容器验证，不算实机帧流或硬件编码性能。每次新建输出目录，验证完整解码、JPEG 包不变、原始 PTS 与中止后的部分文件恢复。这些测试不连接相机。SDK 构建入口见 `tools/sdk/README.md` 与 `tools/sdk/dotnet/README.md`；Windows 已用 PowerShell 7.6.5 实际编译 .NET 诊断库，macOS 可纯托管编译但没有官方 CameraSDK 运行库。相机程序不加入自动化测试。

有界 RGB24 编码器与全部五组主机测试：先按 `src/codec/README.md` 构建固定 libjpeg-turbo 1.5.3 的本地 API80 库，再在以上 CMake 配置命令附加 `-DIQ4_CODEC_BUILD_HOST_TESTS=ON -DIQ4_CODEC_API_VERSION=80 -DIQ4_CODEC_HOST_LIBJPEG="$PWD/evidence/codec/build/libjpeg8/.libs/libjpeg.a"`。编码器使用显式函数表，主机测试不装入原厂固件。目标构建选择静态证据中的 API82/584 字节布局，尚未绑定或运行相机编码器。

固定目标交叉构建：从 `tools/target/toolchain.lock.json` 中的官方 URL 取得 Zig 0.15.2 macOS arm64 包，核对包 SHA-256 后解包到 `build/toolchains/`。脚本再次核对编译器二进制哈希和版本，编译 AArch64/Linux/glibc 2.28 组件，并记录源码、头文件和产物摘要：

```sh
python3 tools/target/build_target.py --zig build/toolchains/zig-aarch64-macos-0.15.2/zig --output build/target
```

产物是组件静态库和未执行的目标验证程序。它没有原厂帧源、编码器和页面的运行适配器，也没有安装入口；不能把该库或验证程序当作可刷固件。`target_build.json` 保留实际命令、输入摘要、ELF 架构和 glibc 版本检查结果。安装物仍须绑定实际设备原件及恢复证据。

原始交接23项哈希初检通过。STATUS和验收CSV随开发更新后，用 `python3 tools/check_original_bundle.py` 对它们的修改前备份及其余原始文件校验。原 `check_bundle.py` 仍保留原样，它只适用于尚未更新这些进度文件的原始包。

同一实拍IIQ主机完整RAW检查/参考渲染：

```sh
python3 -m venv build/host-venv
build/host-venv/bin/python -m pip install -r evidence/p0/host_raw_requirements.txt
build/host-venv/bin/python tools/inspect_iiq.py INPUT.iiq --report evidence/p0/new_raw_decode.json --host-reference-jpeg build/reference/new_full_raw_srgb.jpg
```

输出路径必须不存在，原IIQ只读使用。LibRaw参考没有承诺原厂IQ Style/色调等价，也不作为机内导出验收。所有相机安装仍受 `deploy/RECOVERY.md` 的真实备份与恢复门槛约束。
