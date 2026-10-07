# 构建状态与可运行入口

2026-10-08，源码快照对应6.03.61。请区分独立主机组件和完整相机固件。

## 独立主机组件

需要Git、POSIX shell、C++17编译器和ar。下面两个脚本不使用原厂固件、SDK或相机，不控制设备：

```sh
git clone https://github.com/William76S/phaseone-iq4-firmware-extension.git
cd phaseone-iq4-firmware-extension
sh src/core/build_host.sh
sh src/display/build_host.sh
```

macOS脚本使用Xcode Command Line Tools的`xcrun`/clang++；Linux默认clang++，也可设置`CXX=g++`。产物分别写入`build/core/`和`evidence/display/build/`。这些测试检查图像核心和遮罩组件，**不能证明最终固件能启动、写卡或删除照片**。其他平台未在本次发布中验证。

## 完整6.03.61固件

当前**没有**可从干净克隆独立执行的完整构建命令。`tools/firmware/jpeg_4k_rollback_61/`是已有研究工程上的增量构建入口，依赖旧版本对象、源码锁、生成文件和原厂输入。只把原厂固件放进仓库仍不够。

[完整缺项和已有本地复现范围](docs/BUILD_GAPS_6.03.61.md)。`tools/target/build_target.py`只产生组件库/验证程序，不产生完整FWP；不要将旧版rebuild脚本直接用于61。

本机已生成的固件从[Release](https://github.com/William76S/phaseone-iq4-firmware-extension/releases/tag/v6.03.61)获取。源码与构建检查通过不等于相机验收或失败恢复已经验证。
