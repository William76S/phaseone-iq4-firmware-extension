# IQ4 6.03.55

2026-10-07；P1Linux **6.03.55** / IQ **6.03.52** / System **8.02.34**。

本版合入50% JPEG的照片UID/图库索引绑定修复、匹配本任务的内层等待及失败收尾；新增 **Storage Setup → XQD Storage**，选择 JPEG Only / IIQ Only / IIQ+JPEG。JPEG Size保留4K、50%，质量100。移除旧JPEG Export的Destination和Off/New/All选择，目标卡由原厂SD Storage策略和实际完成RAW的卡决定。Ratio Mask和Dual EXP保持。

## 使用

1. 备份卡上照片及已保存的XFSystem.set，保留53回退包及原厂固件。经此前原厂升级入口载入 `IQ4_6.03.55.fwp`，确认上述版本。
2. Storage Setup → XQD Storage选择格式；**这个格式也用于SD Primary和只有SD时**。
3. Storage Setup → JPEG Size选4K或50%，Quality显示100。50%为14204×10652完整RAW生成7102×5326（约37.8MP）JPEG，首版只支持原厂rotation0。它不是放大4K，也不生成缩小IIQ。
4. 本次先只插XQD，用 **IIQ+JPEG、50%** 普通横向新拍一张。等待处理结束，确认同目录IIQ和JPG都存在、JPG能完整打开且7102×5326，并正常关机无永久Saving等待。随后再验收JPEG Only和双卡策略。

拍摄/待导出/卡任务未结束时，格式和尺寸修改会拒绝；等待任务结束再操作。不会为已有done16 JPEG重做尺寸或覆盖旧文件。JPEG Size中只有一行简短JPEG Status，用于指出50%来源/渲染/编码/写卡/等待状态；Ready仅说明没有已记录失败，不代表已经保存成功。

## 存储联动

| 卡与SD Storage设置 | 保存路线 |
|---|---|
| 只有XQD | XQD按所选格式保存 |
| 只有SD | 通过原厂Primary设置，SD按所选格式保存 |
| 双卡，SD Off | XQD按所选格式保存 |
| 双卡，SD Overflow | 原厂XQD优先及SD溢出；JPEG跟随实际完成RAW的卡 |
| 双卡，SD Archive | XQD按所选格式保存，SD镜像同样的IIQ/JPEG类型 |
| 双卡，SD Primary | SD优先，按所选格式保存 |
| 双卡，SD JPEG Only | XQD按所选格式保存；仅当所选格式含JPEG时，另向SD保存JPEG |

Archive的原厂Backup All在拍摄/备份都空闲时通过原厂属性接口切成New，避免旧RAW全卡备份与JPEG Only冲突；忙时拒绝格式修改，保存配置失败会恢复旧值。

JPEG Only仍先用完整IIQ作原厂渲染输入；全部指定JPEG写卡同步并关闭、真实JPEG解码验证、原RAW消费者退出后，才退休本次普通新拍的临时IIQ。失败会保留RAW；旧照片/手动导出/Black Ref/校准/未支持的多曝光保留原厂RAW。不会把未保存JPEG标为完成。JPEG-only独立图库扫描及LCD预览/缩放已实现，仍需设备验收。当前自有图库登记最多1024项；没有余量时拒绝新的RAW退休并保留IIQ。

若RAW退休与图库提交之间发生排序，精确身份校验会拒绝提交并显示Hold；已同步的真实JPEG仍在卡上。源码已接入正常冷启动后的独立JPG扫描恢复；要求卡在场、文件可读和目录余量。当前进程的即时刷新/热拔插恢复未闭合，冷启动恢复与LCD显示尚未实机验证。

## 关闭与回退

停止新增JPEG：空闲时XQD Storage选 **IIQ Only**。仅停用50%：JPEG Size选4K。

格式配置为 `/mnt/qspi/iq4-storage55.cfg`，合法原记录更新前备份为 `.bak`；尺寸配置沿用 `iq4-stock-half.cfg`。不更改安全码、校准或密钥。回退前也应把原厂SD Storage恢复为所需策略，特别是本版曾把SD-only设成Primary或Archive Backup All切成New的情况。

正常启动时，可经原厂升级入口回退到53：`../iq4_6.03.53/IQ4_6.03.53.fwp`，SHA256 `9d9b970da0ee56fabe73e76b74bedbeb9692f7376b8d4cf7be274d83d3932370`。53没有50%/JPEG Only，旧目的卡配置仍由53处理；55自有配置不需擦除。该回退未实机验证，也不覆盖失败启动。对应/dev/mtd0整擦除块原件和独立失败User恢复仍缺失，本轮只离线交付，不能把封包成功称作恢复已验证。

## 验证与复现

50% UID/index反例、原A64内层超时/锁内pending清理、路由/保存身份/失败保RAW、真实JPEG熵解码与文件收尾通过主机验证。原厂4K/Half producer继续使用完整RAW处理路径；新JPEG decoder仅供JPEG-only验证与LCD，不替代拍摄导出编码器。原始固件/私有照片未改动或上传。本版没有访问Windows或相机。

静态和主机通过不能证明本版真实50%落盘、JPEG Only删除/独立回放、双卡连续拍摄、冷启动和恢复；这些均待验收。53由用户确认XQD同时有IIQ/JPG；54由用户确认50%失败、4K正常。此版没有把该报告标为已修复实机通过。

源码和锁定对象清单在 `tools/firmware/stock_storage_*_55`、`stock_new_raw_receipt_55`、`stock_jpeg_gallery_55`、`stock_jpeg_decode_55_memory`；各SOURCE_SHA256与COMMANDS记录精确源码、编译器、原字节和对象hash。原User6.03.21 SHA256为 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`。

工程根目录用新的、不存在的输出目录复现：

```sh
python3 tools/firmware/stock_storage_release_55/assemble.py \
  --gallery-link analysis/firmware/stock_jpeg_gallery_55_build_final/LINK.json \
  --inputs analysis/firmware/iq4_55_reproduce_inputs \
  --build analysis/firmware/iq4_55_reproduce_build \
  --package deploy/iq4_55_reproduce
```

实际analysis/firmware/stock_jpeg_gallery_55_build_final/LINK.json、输入/产物hash和完整验证命令由交付收据补充。封包仍保留未改的原厂其余segment，只替换版本绑定User；不是将固件全源代码重编译。
