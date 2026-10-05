# 有限 opaque record1 RAM 工具 01

本目录提供可构建 C 源码与私有绑定生成器。公开默认产物 `R1_BOUND_READ=0`、`R1_BOUND_WRITE=0`，在打开 EEPROM 前返回。没有设备连接、SDK 载入、实际原件读取、实际私有头生成或目标执行。

```sh
python3 tools/firmware/record1_ram_restore_01/freeze.py
python3 tools/firmware/record1_ram_restore_01/validate.py
```

复用锁定 Zig 0.15.2，不下载工具链。`audit_build.py` 将实际 target IO 分支用已知合成配置编译成无 main/constructor 的 AArch64 ET_REL；它不是安装物。测试编译实际 `engine.c`，使用合成 EEPROM 与主机普通临时文件，未证明相机 at24 provider、写入、恢复或解锁。

仅有四个固定动作：默认或 `--preflight`、`--same-original`、`--clear`、`--restore-original`。路径、16B 原件、existing record1 offset、完整原件 SHA、内核、EEP metadata、当前 User SHA/PID/start_ticks 和 RAM state device 在受保护配置中固定；不接收路径、偏移、字节、命令或地址参数。公开产物没有任何实际绑定。

写动作先获取独占 RAM transaction 锁并创建对应 `.once` 标志；一次调用即消耗该动作，不自动删标志。成功 clear 后不会自动 restore，便于单独验收；失败 clear 仅在实际双全量读回证明其他全 EEPROM 字节仍原件时，允许一次完整原16B回退。没有 User signal、重载、格式化、记录创建或整 EEPROM 写入。

`generate.py --emit-private` 仅允许 Windows 已有单用户 DACL 目录、两份真实完整原件和 Root 审阅的实际 receipts。必须提供独立实际 extent/EOF/provider 证据，不能用 `st_size=0` 或包内型号推断 extent。本版只兼容实际证明为 16384B 的原件；其他 extent 拒绝。原件和 receipts 在读取前检查保护；配置、ELF、编译缓存、临时文件、日志及产物摘要全留私有目录，不进入公开 ZIP/manifest/stdout。实际运行、上传和 restart 不由这个生成器实施。

same-original 写回仅证明有限 transport。工具永远不宣称改后冷启动恢复或持久解除，详见 [实现与验收边界](../../../analysis/firmware/RECORD1_RAM_RESTORE_IMPLEMENTATION_01.md)。
