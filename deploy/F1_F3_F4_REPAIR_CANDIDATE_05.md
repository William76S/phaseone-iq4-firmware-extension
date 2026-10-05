# IQ4 修复候选 05

版本 **P1Linux 6.03.34 / IQ 6.03.31 / System 8.02.13**，日期 **05.10.2026**。

用户要求先交付一版、停止扩展测试。本版已编译和封装，保留已完成的模块测试证据；未进行本版相机试用、持久恢复或整套源码重新编译验收。不能称全部功能已修好。

## 文件

[下载固件](f1_f3_f4_card_candidate_05_blackref_01/IQ4-user-only-candidate.fwp)，13,304,571 字节。
SHA-256：`7030c97a90237b231649a7aa58726af8cc84f6c529f43996dfc6331319c7da40`。
只使用本目录的文件，旧候选保留用于追溯。

## 已包含的修复与入口

- **Ratio Mask**：保留 LiveView Settings 中唯一入口、透明度、Off/native、65:24、16:9、3:2、1:1、4:5、6:7、21:9；仅 LV 显示。
- **Storage Setup → JPEG Size**：4K、8K、75%、50%、25%、100%，移除 Thumbnail。Capture Output 中不再重复尺寸入口。
- **File Settings → Capture Output**：SD output、XQD output 独立选择 RAW / JPEG / RAW + JPEG，JPEG Quality 默认100并显示当前值；手动 Export selected RAW 保留。Storage Setup 中原 SD 设置也接到同一 SD output。
- 修正合法4KiB加载地址被旧64KiB检查拒绝的问题；接通原厂存储模式与新增完整RAW处理，避免另一路旧缩略图JPEG写入冲突。完整RAW转换失败不会把缩略图放大冒充全尺寸。
- **LiveView Settings → LV Recording**：默认XQD，先开启原厂LV，再Start；Stop后等待收尾。加入启动失败清理、原厂释放LV client后的正常停止。当前是原生LV帧的MJPEG/MKV实现，尚未证明1080p60，录像能否成功仍需本版实机确认。
- **Dual Exposure**：点原EXP数值循环选择+1/3至+3 EV，修正1/3档对应长快门显示与计算。保留原厂更严格的0.8秒基础快门上限、原厂忙碌检查和原sensor ratio接口。
- **Black Ref保护**：自动JPEG只接收正向确认的普通照片；校准/未知帧继续走原厂流程。原厂临时关闭存储时不会由新增设置强行重开。保留原校准文件和安全码。

## 尚未完成与使用限制

- **无卡Capture One的JPEG/RAW+JPEG传输未接通**，本版不包含该能力。
- Black Ref完整机内兼容尚未验收。原厂关闭存储会取消新增覆盖，恢复后可能需要重新选择SD/XQD保存格式；不声称已完成自动恢复。
- RAW到JPEG的实机文件、色彩、图库、两卡拍摄以及录像Start/Stop仍未获得本版成功回执。后端如果仍不可用会显示诊断，不会伪装成功。
- 设置仍为进程内状态，重启回到RAW/RAW、100%尺寸、质量100，录像默认XQD。F2 LUT继续暂缓。

## 禁用与恢复

Ratio Mask设Off，两卡输出设RAW；录像Stop并等待收尾后退出页面，即停止使用新增功能。

本包仅包含User组件，未携带Boot、校准或安全记录写入。你此前使用的原厂卡载流程仍是候选的载入入口；本项目本轮没有联机或代为刷写。

原厂包保存在 `analysis/firmware/vendor_downloads/stock_fwp_01/XFSystem8.02.0.fwp`。
原User升级仍会改写mtd0 marker擦除块；该整块备份和失败User的独立恢复仍未验证，不能把这份候选称为安全刷写或保证可降级恢复。

## 复现

精确输入：`tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_05.json`，SHA-256 `fd3ed3ca20315a4a54e5f15496946354afb5ebcc4da07cf76f80502c1ce799ca`。

在原工作目录使用已保存的精确本地原件、编译器和依赖，可运行：

```sh
python3 tools/firmware/f1_f3_f4_user_integration_05/reproduce.py --spec tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_05.json --spec-sha256 fd3ed3ca20315a4a54e5f15496946354afb5ebcc4da07cf76f80502c1ce799ca --reference-build analysis/firmware/f1_f3_f4_user_integration_build_05_blackref_01 --reference-package deploy/f1_f3_f4_card_candidate_05_blackref_01 --output analysis/firmware/reproduce_candidate_05
```

该完整重编命令在本轮按用户要求未执行。实际已执行的是冻结对象核验与组合编译、37处跳转/70对象检查、必要异常展开/封印检查、186个原字节窗口、内外版本/CRC和重新封装逐字节比较。命令和结果在build目录的RELEASE_CHECK_COMMANDS.json及候选目录的ROOT_PACKAGE_INSPECTION.json。
