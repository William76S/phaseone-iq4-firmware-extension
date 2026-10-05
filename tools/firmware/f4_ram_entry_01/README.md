# RAM 入口主机材料 01

全部工具只在主机复核或交叉构建；没有 transport、SDK、下载 URL、原厂地址调用、启动脚本写入器、安装命令或相机控制。

`readonly_monitor.c` 是首个机内执行候选，尚未在相机运行。接受三项严格十进制参数：已验证 User 的 PID、`/proc/PID/stat` field22 start_ticks、1..30000 ms 观察期限。只打开 `/proc/PID/stat` 为只读、读取 `/proc/PID/exe` symlink，成对再核 start_ticks；前后执行路径必须相同且 basename 为 p1linux。它只输出最多两行固定公开结果，使用非阻塞 stdout，绝不打开写入文件、发送 signal、停止 User 或触及帧/hardware。stdout 本身有 write；如另一个已验证启动器将其重定向，那个启动器仍须保全输出文件/目录合同。

PID/start_ticks 不替代 User 完整哈希和原件门控。期限是 CLOCK_MONOTONIC 的用户态循环上限，不能保证遇到内核/文件系统挂起仍硬实时退出。此程序也不是修复或卸载监督者：不执行 restore/stop，不证明 SDK Close 后仍存活。要验证独立性，需受审查的独立 session、所有 inherited fd、有限 tmpfs 输出路径与实际 SDK 断开观察。

返回码：0 为期限到达且身份稳定；2 参数拒绝；3 stdout 非阻塞设置失败；4 初始身份/clock 拒绝；5 输出失败；6 clock 异常；7 观察中或收尾身份改变/不可读。原厂 Sys 没有 numeric exit 合同，执行者不能从文本 alone 推定这些码；固定末行与进程实际退出须另外验证。

`one_shot_model.py` 是恢复先于 exec 的状态模型，不能执行任何设备操作。`describe_equal_length` 只返回原 runner 单行等长差分元数据，不输出完整修改脚本。主机临时目录 fixture 核对 hardlink 备份和 atomic replace 保留原 inode/open fd；不能据此证明相机实际 fs 支持。

复现：

```
python3 -m unittest discover -s tools/firmware/f4_ram_entry_01 -p 'test_*.py' -v
python3 tools/firmware/f4_ram_entry_01/run_host_validation.py
python3 tools/firmware/f4_ram_entry_01/build_readonly_probe.py
python3 tools/firmware/f4_ram_loader_collect_static.py
python3 tools/firmware/f4_ram_loader_validate_static.py
```

原件/根 mount/原厂退出与 respawn 尚未实机验证时，状态模型拒绝 arm。源码没有将模型变成 runner patch、loader 或通用 shell 执行器。in-process adapter 的 callback owner/quiescence、UI 及帧/codec/卡路径另由根执行者集成。
