# Windows 本地 AArch64 工具链 01

独立源码计划，既有 record1/RAM/Stage2/Stage3 冻结不变。默认 `acquire.py` / PowerShell Preflight 只显示公有锁定元数据，不下载、不创建目录。实际 Windows 下载/编译由 Root 明确执行；本阶段没有执行 Windows 或目标程序，没有设备/SDK/真实原件输入。

[官方索引](https://ziglang.org/download/index.json) 的 Zig0.15.2 `x86_64-windows`：ZIP92614574B，SHA256 `3a0ed1e8799a2f8ce2a6e6290a9ff22e6906f8227865911fb7ddedc3cc14cb0c`，链接和范围锁在 `toolchain.windows.lock.json`。官方未单列 zig.exe SHA；实际必须由已核 ZIP 导出全文件摘要并核版本，不借用 Mac compiler 摘要。

已有 Windows x64、Python3.9+、PowerShell5.1 及项目 `build/toolchains` 私有父目录前置。脚本只读取 ACL：owner当前用户，访问主体当前用户/SYSTEM/Administrators；不改 ACL、不提升权限、不全局安装、不改 PATH，不调用 Get-FileHash。项目内固定新目录 `build/toolchains/zig-x86_64-windows-0.15.2-acquired01` 已存在即拒绝，失败保留材料供 Root 核查，不覆盖旧目录。

Root 后续在 Windows 分阶段运行：

```powershell
python.exe tools/firmware/windows_aarch64_toolchain_01/acquire.py
python.exe tools/firmware/windows_aarch64_toolchain_01/acquire.py --acquire
python.exe tools/firmware/windows_aarch64_toolchain_01/acquire.py --verify
python.exe tools/firmware/windows_aarch64_toolchain_01/acquire.py --build-probes
```

也可用同目录 `Acquire-Verify.ps1 -Mode Preflight|Acquire|Verify|BuildProbes -PythonExe <已有Python路径>`。Acquire是一次明示动作；没有隐式镜像、重定向、latest版本或重试覆盖。Verify先重新验证 ZIP 和逐成员摘要，再比较实际目录整个文件集合/摘要、zig.exe x64 PE32+、单用户ACL和 `zig version=0.15.2`。

BuildProbes只有两个固定产物：冻结 record1 公有 `EN0` PIE（无 EEPROM open/pread/pwrite）和已知合成配置的 private IO 分支 ET_REL（无main/constructor、不安装执行）。核实际 AArch64 ELF、PIE interpreter `/lib/ld-linux-aarch64.so.1`、仅libc、GLIBC≤2.17及有限imports。输出目录必须新建，缓存/日志/临时文件全项目内；不运行任何目标 ELF。

私有真实 record1 配置/16B/ELF仍由已冻结生成器在 Windows受保护目录构建。Root可将真实 `acquisition.json` 中 `zig_exe_sha256` 纳入实际 private proof，将实际已验证 `toolchain/zig.exe` 路径交原生成器；新工具不会自动填任何 EEPROM、restore 或 write gate。原件、包含原16B的头/ELF/日志/摘要不得返回 Mac 或公有包。详见 [交付与证据边界](../../../analysis/firmware/WINDOWS_AARCH64_TOOLCHAIN_01.md)。

本地主机复现（只复用已有 Mac Zig，未下载WindowsZIP）：

```sh
python3 tools/firmware/windows_aarch64_toolchain_01/freeze.py
python3 tools/firmware/windows_aarch64_toolchain_01/validate.py
```
