# F1 独立显示绘制层 0.1.0

本组件复用 `src/core` 的 `maskGeometry`，完成显示绘制计划、临时设置与主机软件 Canvas 验证。没有连接相机、写相机文件、调用原厂私有 ABI、接受 RAW/JPEG/LV 输入像素指针或证明机内 F1 已完成。真实 target surface adapter、原厂页面与清层方式仍未验证。

## 语义与隔离

`ViewMapping` 由目标接入层提供完整有效源坐标、同一源到显示仿射变换、实际图像 viewport、源映射是否已知和 focus zoom 状态。viewport 必须排除工具条与留边；本组件从不根据显示 buffer 的宽高猜传感器比例。

`makeDrawPlan` 先在完整源上构造 Off、精确 65:24、16:9、3:2、1:1 五档框，再构造其外部四个互不重叠的源坐标 band。band 经同一矩阵变换为凸多边形，随后裁到图像 viewport。反射时规范化顶点绕向，裁切经过既有顶点时消除重复顶点/零长边。缩放与平移始终映射完整源框，不在放大局部重新构框。focus zoom 中，源映射已知继续显示，未知才隐藏；Off/隐藏计划不发出绘制命令。

默认 Off、不透明度 65%、边界线关闭。`TemporaryMask::select/setOpacity/setBoundary` 仅修改页内内存；`exitToFactory()` 清回默认设置。没有任何配置持久化文件或 CameraSDK property 写入。

`DisplayCanvas` 只有 `fillConvexBlack` 和 `strokeWhiteSegment` 绘制命令，参数为几何、透明度与图像 clip。接口没有图像缓冲、相机、照片/视频编码器或文件输入。边界线用真实框边裁切，不在 zoom viewport 边缘重新画一个假框；stroke width 也必须受 image clip 约束。

目标 compositor 必须为每轮渲染提供新/已清空的透明 overlay，或在 Off/隐藏/退出时销毁旧 layer 并请求原厂 repaint。`exitToFactory()` 停止新命令，不能证明未知原厂保留层会自动消失。目标 adapter 必须单独证明仅操作 display compositor surface、触摸穿透、不进入 RAW/JPEG/录像、原厂控制与辅助显示正常，并验证恢复页面。通用接口没有能力核验接入者是否违反该 surface 契约。

## 构建

在项目根目录：

```sh
sh src/display/build_host.sh
```

生成 `evidence/display/build/libiq4_display_mask.a` 与 `iq4_display_tests`。Apple clang 17.0.0，C++17，`-O2 -Wall -Wextra -Wpedantic -Werror -pthread`；脚本显式使用本机 SDK 完整 libc++ 头，未修改工具链。构建与测试日志、compiler.txt、test_results.json 保留在同目录。这些产物为 macOS arm64，未证明 IQ4 ABI，不能直接部署。

CMake 3.16+ 子目录入口可在已有 `iq4_image_core` target 中复用；独立构建时自动引入 `../core`：

```sh
cmake -S src/display -B evidence/display/build/cmake
cmake --build evidence/display/build/cmake
ctest --test-dir evidence/display/build/cmake --output-on-failure
```

本机项目 venv 的 CMake 4.4.3 已完成顶层集成构建，CTest 三个主机测试组全部通过；记录见 `evidence/display/cmake_verification.json`。direct clang 与下面 sanitizer 路线也已实测。

```sh
clang++ -std=c++17 -O1 -g -Wall -Wextra -Wpedantic -Werror -pthread \
  -fsanitize=address,undefined -fno-omit-frame-pointer \
  -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk \
  -isystem /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/c++/v1 \
  -I src/core/include -I src/display/include \
  src/core/lib/image_core.cpp src/display/lib/display_mask.cpp tests/display/test_display.cpp \
  -o evidence/display/build/iq4_display_tests_sanitized
ASAN_OPTIONS=detect_leaks=0 evidence/display/build/iq4_display_tests_sanitized
```

LeakSanitizer 在本主机平台不支持，未宣称完成 leak 检测。

## 验证证据

2026-10-04 08:18（Asia/Shanghai）完成：优化构建和 ASan+UBSan 各 50/50 主机测试通过。49 项通过后新增的边界回归测试确实暴露过裁切重复顶点问题；失败日志 `evidence/display/build/corner_regression_before_fix.log` 保留，修复后两构建全部通过。

软件 Canvas 拥有独立输出 surface，仅复制测试生成素材作背景。独立逆仿射逐像素参照累计核对 3400740 个像素，其中 792982 个为遮罩像素：覆盖位置正确、65% alpha 仅应用一次、band 无重叠、框内不变、工具条/留边不变、输入素材 checksum 不变。测试覆盖两种显示尺度、四比例、四方向旋转、反射、非轴仿射、zoom+pan、完整源偏移、准确穿过变换顶点的裁切、边界线、临时切换、退出原厂 repaint 模拟、未知 zoom 坐标隐藏和坏配置拒绝。

软件 Canvas 与 host 配置过程未读取或写入样本 IIQ、JPEG、相机 LV 缓冲或存储卡。此隔离测试不替代真实设备同场景 RAW/JPEG/视频检查，也不推断帧率下降或 target surface 可达性。

机器结果与精确哈希见 `evidence/display/verification.json`、`evidence/display/SHA256SUMS.txt`；实际逐项日志见 `evidence/display/build/test.log`、`sanitizer_test.log`。
