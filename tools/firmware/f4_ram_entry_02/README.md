# RAM 一次性启动源码 02

这是完整、默认禁用的主机交叉构建与有限安装计划生成器。没有相机 transport、SDK 加载、设备连接、任意地址调用或实际运行。首模块仅发送固定 constructor marker，F4 UI/帧/录像 adapter 不在这个模块里。

`entry.c` 实现固定目录下的预检、只创建新的 RAM launcher、准备原 runner 双字节副本和 inode hardlink、独立 session 监督、等长替换一行、**先恢复 runner 再 exec 未修改 User**、失败走 stock，以及恢复原 runner 的 disable。没有 User signal、进程内卸载或自动清理原件。`marker.c` 只用自有 fd198 非阻塞发送 5 B marker 并关闭；`sha256.h` 是有界文件核验用实现。`audit_build.py` 将全部分支编译成没有 main/constructor 的 AArch64 ET_REL 对象，不生成可安装 enabled ELF。

独立 `readonly_facts.c` 无参数、固定只读打开 User/runner，输出整文件hash、runner inode/mode/owner/dev、xattr名称长度/errno和双stat稳定性，不输出文件内容、环境或xattr值。它可帮助采集以后启用arm所需的事实，但没有stage执行计划，尚未实际运行；没有将EN0 mutation guard放宽。其目标链接导入已检查没有rename/link/chmod/fsync/execve/fork/socket等写入或控制分支。

门禁按实际修改域分开：独立只读 monitor 核对 User 完整文件哈希及 PID/start_ticks；RAM marker 还必须备份将修改的 runner 两遍全文、原 inode/元数据、实际 RAM mount、原厂 User 退出/stock respawn、冷启动恢复和 SDK 关闭后的独立性。未修改 User 不要求将其 12 MB 全文导出；User 全文原件可选保全。若后续持久修改 User/config，必须补其完整设备原件与独立恢复。当前三个 profile 都没有实机验收；默认 preview 的安装 command list 是空的。

复现（全部在主机）：

```
python3 -m unittest discover -s tools/firmware/f4_ram_entry_02 -p 'test_*.py' -v
python3 tools/firmware/f4_ram_entry_02/generate.py
python3 tools/firmware/f4_ram_entry_02/audit_build.py
python3 tools/firmware/f4_ram_entry_02/freeze.py
python3 tools/firmware/f4_ram_entry_02/validate.py
```

只复用项目内锁定 Zig 0.15.2；不下载工具。实际 enabled RAM marker 包仅在 Root 已获得全部 18 项实际 receipt 后，传 `--emit-enabled --proof ... --runner-a ... --runner-b ...` 生成；可选 `--user-a/--user-b` 必须成对完整一致。Proof 解析器检查严格类型、完整性、来源文件哈希和固定路径；Root 必须审查 receipt 的设备语义，主机写入 `true` 不构成硬件证据。Synthetic tests 不生成 enabled 安装物。

只有五个固定公开 artifact 可以被有限 staging 计划编码为 32 B 的 octal printf 分片，文字上限 242 B（含两层外引号，不含 NUL），无 literal `=`。采用已冻结三位 octal **format** 分支，不依赖 `%b` 参数分支。每次创建/追加及完成后仍需真实 reply final/EOF、目录和文件元数据、整文件 SHA 验证；Sys 文本不提供 numeric exit。计划没有实际执行器，也没有网络下载/URL。大量分片会较慢，后续较快入口另行验收。

完整调用顺序、恢复限制及下一实机证据见 `analysis/firmware/F4_RAM_ENTRY_IMPLEMENTATION_02.md`。不要将 preview ELF、ET_REL 编译对象或有限主机测试升级为机内实现成功。
