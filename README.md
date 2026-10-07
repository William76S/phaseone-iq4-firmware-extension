# Phase One IQ4 firmware extensions

当前源码与固件版本：**P1Linux 6.03.61 / IQ 6.03.58 / System 8.02.40**。

[下载 6.03.61](https://github.com/William76S/phaseone-iq4-firmware-extension/releases/tag/v6.03.61) · [本版功能与限制](docs/RELEASE_6.03.61.md) · [构建说明](BUILD.md) · [未解决问题](docs/KNOWN_ISSUES.md)

本项目基于精确版本的原厂固件做扩展，不是 Phase One 官方固件，也不包含原厂完整源码。

## 当前功能

- Ratio Mask：LV侧栏图标短按开关、开启蓝点、长按设置比例与透明度；包含缩放与持久设置相关修复。
- Dual Exposure：原厂双曝光流程上的可调EV差值及加减按钮，范围最高+5EV。
- JPEG：仅原厂4K，质量100；XQD的IIQ Only / IIQ+JPEG / JPEG Only与SD存储策略联动。
- 6.03.61新增同卡、同目录、同名IIQ+JPG配对删除，以及JPEG Only图库主卡删除。

50% / Sensor+大尺寸JPEG试验已撤回，LV Recording已移除。LUT和无卡Capture One JPEG传输未完成。历史目录中的实现或菜单不代表当前固件具有这些能力。

**验证范围：** 6.03.53的XQD同时保存IIQ和4K JPEG有用户实机成功反馈；Ratio Mask和Dual Exposure也有阶段性实机反馈。**6.03.61本版只有静态及主机验证，尚未完成实机验收。** JPEG Only、双卡组合、删除和失败恢复不能视为已全部通过。XQD开机Ready慢的问题仍未查明。

## 别人可以自行构建吗？

**可以构建、运行独立主机组件测试；目前不能仅靠干净克隆直接重建完整6.03.61固件。** 原因不仅是未附原厂固件：当前装配脚本还依赖本地历史对象、生成头文件、冻结清单与收据，尚未整理成从源文件到FWP的独立构建流程。详见[构建缺项](docs/BUILD_GAPS_6.03.61.md)。

Release提供本机已生成的FWP和校验值。GitHub自动附带的Source code压缩包是这个源码快照，不能与完整可独立重建包混同。

## 内容与来源

`src/`、`tests/`和`fixtures/`提供独立组件与合成测试；`tools/firmware/`保存版本绑定、原生接口和补丁构建源码。`analysis/`及旧`deploy/`是历史资料。

本次同步记录见`UPDATE_MANIFEST_6.03.61.json`。`IMPORT_MANIFEST.json`只描述2026-10-05首次导入。新的原厂固件、SDK、工具链、样本照片、设备日志、安全调查和私有备份未随本次源码更新上传。

仓库未另行授予开源许可证；第三方文件遵循随附许可。This software is based in part on the work of the Independent JPEG Group. 参见`src/codec/vendor/libjpeg-turbo-1.5.3/LICENSE.md`及`README.ijg`。
