# Phase One IQ4 firmware extensions

私人研究工程快照，最新离线候选 **P1Linux 6.03.34 / IQ 6.03.31 / System 8.02.13**（2026-10-05）。

[固件候选下载](deploy/f1_f3_f4_card_candidate_05_blackref_01/IQ4-user-only-candidate.fwp) · [菜单、限制和复现说明](deploy/F1_F3_F4_REPAIR_CANDIDATE_05.md)

包含 Ratio Mask、SD/XQD RAW/JPEG/RAW+JPEG 保存设置、六档 JPEG 尺寸、默认质量100、Dual Exposure 1/3档调节，以及原生 LV 录像和 Black Ref 保护的研究实现。

**仅 Ratio Mask 有此前用户可见成功反馈；最新组合 JPEG、录像、Black Ref 兼容与持久恢复未实机验收。** 无卡 Capture One JPEG 传输未完成；Black Ref 后可能需重新选择保存格式。此仓库不能视为安全刷写或失败恢复保证。

## 仓库内容与本地依赖

这是从本地研究工程导出的新快照，不包含历史 Git 提交。包含自主源码、主机测试、合成测试素材、固件静态分析和候选05。原厂固件/库、SDK、工具链、样本照片、相机备份、设备日志与安全相关调查保留本地。

已有文件保持原字节及哈希，因此部分历史构建记录仍引用本地路径。完整固件重建须恢复拥有合法来源的本地原件、依赖和生成对象；**此快照并非开箱即用的独立工具链**。IMPORT_MANIFEST.json 列出已导入文件的长度与SHA-256，构建入口见交付说明。

## 常用目录

- `src/`、`tools/firmware/`：核心代码、原生接入、版本绑定和打包工具。
- `tests/`、`fixtures/`：主机测试和合成输入。
- `analysis/firmware/`：保留的静态分析和构建证据；不等于实机结果。
- `deploy/`：最新候选及限制说明。

未为原厂内容授予任何额外许可；仓库当前不添加开源许可证。
