# IQ4 bootstrap / recovery：启动入口窄查增量

**最接近独立恢复的是原厂 FSBL 的 Factory 选槽分支；普通照片卡的临时脚本入口尚未闭合。** 本轮恢复了 Factory/User 环境的实际生产代码和 GPIO 17 强制 Factory 的有限调用链。还不能把它写成用户按键操作：GPIO 的外部按键名称、实机启动槽以及退出恢复均未验证。另一个具体执行候选是原厂网络配置的 shell `source`，但普通启动仍在内部 QSPI，并被 `debug` 等条件门控，不能当作无害卡脚本入口。

本轮完全离线：没有运行目标代码、加载 SDK、连接相机、发送包、写相机、尝试安全码或修改校准/密钥。没有制作安装物。此前冻结的 execution/file-read/F4 材料未改。非公开接口可以继续从精确二进制恢复 ABI；缺私有头文件不是永久前提。

## 输入和地址边界

| 输入 | SHA-256 |
| --- | --- |
| 用户 6.03.18 包内 `Boot_4.00.13.bin`，71,874,288 B | `7a3a3d6f62c61e7d627a9f55d844d74be9111b26eb7a7fa42f5bdd7be7dabe9e` |
| 同 Boot 原始 ramdisk，134,217,728 B | `2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb` |
| 包内应用 `P1Linux_6.03.21.bin` | `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb` |
| 原始 `boot_inventory.json` | `d75acf1247e82b20c867a5d9affd15e514a5f143ef8a260d0fd40f0141c0aace` |
| 逐字节等于 Boot `[0x44891c0,0x448986b)` 的环境文本 | `1291372f254498774b68cc66bcb0a094958e448cb70cabc33a71d34ac74556f7` |

这些是包内静态输入，不能据此证明相机当前加载的 Boot/User 程序身份。已取得的旧 Factory 实机 ELF 没有参与本轮地址分析。

FSBL 反汇编使用**仅为静态解码构造、没有 program headers 的 section view**：原 Boot file `[0x222e0,0x406d8)` 映射拟 VA `[0xfffc0000,0xfffde3f8)`。Boot `+0x2c=0xfffc0000`；`+0x30=0x2800` 加 `+0x34=0x1fae0` 等于 `0x222e0`；`+0x3c=0x1e3f8`；首 partition 长度字 `+0x1100=0xf7b6` 满足 `0x2800+0xf7b6*4=0x406d8`。PC 相对引用恰好命中原 Factory/User 字符串，支持这一静态地址模型。Boot 文件偏移和原字节是权威证据；拟 VA 不是实机地址验收，section view 不是可安装固件。

## Factory/User 的实际生产链

| 原 Boot 文件偏移 / 拟 VA | 寄存器与分支证据 |
| --- | --- |
| `0x33494 / 0xfffd11b4` 起 | `w24=2`；对 `0x02000000` 调原厂字符串复制函数初始化 FSBL 环境。后续 append 仍写 RAM 此地址。 |
| `0x33554 / 0xfffd1274` | `x23=0xfffd3fd1`，对应 Boot `0x362b1` 的 `factory_or_user=factory\n\0`。 |
| `0x335a4..0x335bc / 0xfffd12c4..0xfffd12dc` | `x0=0xffca0010`；`ldr w25,[x0]`；`cmp w25,#0x4ff`；`csel x23,x23,x1,hi`，其中 `x1=0xfffd3fea` 对应 Boot `0x362ca` 的 `factory_or_user=user\n\0`。**unsigned 值大于 0x4ff 选择 Factory，其余选择 User。** |
| `0x335c0..0x335d0 / 0xfffd12e0..0xfffd12f0` | 对环境 RAM `0x02000000` 求字符串长度；将长度加到目的地址，再把 `x23` 指向的文本复制到尾部。这里没有保存 U-Boot 环境到 flash 的调用。 |
| 环境文本第 19–20、29 行 | U-Boot `env import -t ${addr_fsblenv}` 从同一 `0x02000000` 导入；`bootcmd2` 将 `user_or_factory=$factory_or_user`、`modeboot=$modeboot` 追加到 kernel bootargs。 |
| rootfs `p1-create-user-or-factory-state.sh:28–34` | 从 `/proc/cmdline` 判断 `user_or_factory=factory`；创建 `/run/boot_is_factory`，否则 `/run/boot_is_user`。 |
| `boot_run_p1linux.sh:53–65` | Factory flag 选择 `${storage}/Factory/p1linux`，其余选择 `${storage}/User/p1linux`。 |

这里已经从字符串推进到 producer、RAM 环境、U-Boot 消费、rootfs 选程序的连续静态证据。它没有证明当前设备选择了哪一个槽。应用中有 `MultiBootRegister` 类型和相关命令，但 UI 文本 `Revert To Factory Installed Firmware` 不能直接当作这条只切槽分支，未给执行者运行未闭合的 UI/命令。

## GPIO 17 强制 Factory 分支与写入范围

1. 主函数 `0xfffd0b50..0xfffd0b54` 设置 `x21=0xfffe0640`；GPIO owner 是 `x21-0x40`。Boot file `0x3fce0` 的配置表（拟 VA `0xfffdda00`）包含 device ID 0、GPIO base `0xff0a0000`。`0xfffd1330..0xfffd133c` 将其传到 GPIO 初始化函数；该函数 `0xfffc386c` 把 base 写 owner `+4`，`0xfffc38cc..0xfffc38d0` 写初始化标志 `0x11111111`。
2. `0xfffd12f4..0xfffd12f8`：若启动寄存器值 `>0x4ff`，跳回主状态循环，**不执行以下强制 Factory 检查**。否则 `0xfffd12fc..0xfffd1308` 传 `pin=0x11`、direction 参数 0 到原厂 GPIO direction helper `0xfffc36dc`。
3. `0xfffd1358..0xfffd1364` 调 pin→bank/bit helper `0xfffc1054`，输入 17。helper 的边界表从 25 开始，因此得到 bank 0、bit 17。`0xfffd136c..0xfffd1384` 读取 `base+(bank+0x18)*4`，即此配置下的 **`0xff0a0060` 输入寄存器**，右移 bit 17；bit 为 0 返回普通循环，非零进入强制 Factory 分支。不能把 rootfs 通用 MIO 脚本的 `0xff0a0040` output/data 公式误写成这里的 input read 地址。
4. `0xfffd1388..0xfffd1398`：打印 Boot `0x36523` 的 `Forcing factory default`；设 `w0=0x500`；调用 `0xfffc8b30`。
5. **完整有限 reset writer** `0xfffc8b30..0xfffc8bac`：`str w0,[0xffca0010]`；另读 `0xffca0044` 的低 4 位并在特定分支对 `0xff5e0030` OR `0x8`；执行 `dsb sy`、`isb`；检查原内部状态，正常分支打印后对 `0xff5e0218` OR `0x10`，然后自旋；另一状态分支直接自旋。这里的唯一 `bl` 是原厂日志函数。**没有 QSPI/UBI 文件写、ELF 覆盖、安装或 `saveenv` 调用。**

可证结论限于“原厂代码向 MMIO 启动选择值写 0x500 并进入复位/停止链”。当前没有实机证据说明寄存器跨冷断电保持、复位成功、释放按键后如何回到 User，不能把它称为已验收的可恢复操作。

板级止点：两份原 DT（Boot `0x86430`、`0xdd4440`）只有 `gpio@ff0a0000` controller、mask-low `0x5600` 和 generic-uio GPIO IRQ，没有 gpio-keys、gpio-line-names 或命名 pin17 的节点。原应用有 UI 按键文字和 GPIO 配置类，尚未恢复将具体外部键连到 MIO17 的指令证据。**不给用户猜按键组合，也不直接写 MMIO。**

Factory 程序启动还有两个必要副作用检查：早/晚 global hook 仍由共有 rcS 执行，Factory 不绕过坏 hook；`boot_run_p1linux.sh:98–119` 会消费**所选目录**的 `p1linux.bin` 升级文件，即使之后 skip 也先处理该文件。这个处理路径只指向所选目录，不能据此推断整个 Factory 程序不会改 User。下一次切槽验证必须先排除待升级文件，并核对进入的程序和恢复路径。

## 卡脚本、动态库及配置入口的具体边界

| 路线 | 已确认条件 / 未确认条件 |
| --- | --- |
| 普通卡→`autostart.sh` | `p1-link-to-user-storage.sh:24–39` 只有 cmdline 含 `modeboot=sdboot` 才把 `storage` 链到 `/var/run/media/mmc*`，否则链到 `/mnt/qspi`；普通插照片卡不能自动得到 hook 路径。`/run/media/sdcard` alias 不被 hook 使用。 |
| sdboot 卡脚本 | `modeboot` 仍由早期启动产生。本轮没有闭合外部触发；原 mdev.conf 自动 mount 规则被注释，实际热插拔规则只写通知 FIFO，故还不能保证 S07 前的 mmc 目录已挂载。未见 XQD 作为 storagealias 目标。 |
| 动态库/plugin | 原 ramdisk inventory 无 `/etc/ld.so.preload`、`/etc/ld.so.conf.d`；应用无 DT_RPATH/RUNPATH、无 `dlopen/dlsym` 等直接动态导入；已有启动脚本没有有效 LD_PRELOAD/LD_LIBRARY_PATH 卡路径。只排除了这些直接入口，没有宣称所有传递依赖或运行时不存在任何 loader。 |
| `init_shell` 独立 bypass | U-Boot `bootargs.shell` 给 `init=/sbin/init_shell`；脚本 2/3 分支不跑普通 rcS，静态可绕过 global hooks。但 `boot_method=shell` 的实际选择、可操作 console 和回正常 init 未验，不能给恢复安装物。 |
| 网络配置 shell source | S46 `p1-setup-debug-network.sh:9,34–37` 要求 MACB 平台目录、`storage/debug` 和 `storage/ethdebug.cfg` 存在；调用 `setup-network.sh`，后者 `:32–33` 执行 `source "$ETH_CFG_FILE"`。这是实际 shell 读取入口，普通 storage 仍是 QSPI。 |
| `debug` 条件 | 固定 FileId 425 / `debug` 的静态文件 flags=3；S94启动 inetd/dropbear，但 boot_run 同时跳过应用→sulogin。会影响相机 UI 与 SDK 控制，且没有独立认证/控制台恢复证据，不能以此做“无害执行”实测。 |
| 固定文件读写能力 | 86 项静态 whitelist 含 ethdebug.cfg（427）等；不含 autostart.sh、late-autostart.sh、init_shell-autostart.sh、任意新扩展或 preload 文件。flags 不能当作当前设备 permission/read/write 成功证据。 |

确切启动顺序由原 ext2 symlink 元数据重现：S04 mdev→S05 QSPI mount→S07 storagealias→S38 User/Factory flag→S40 early hook→S46 debug network→S61 application release→S94 debug services→S95 late hook。`boot_run` 等 `/run/essential_boot_done`，该文件在 S61 创建，因此 **early hook 在原厂应用释放之前；late hook 与应用实际启动没有全序保证**。

## 下一次可逆验证的最短条件

1. **优先完成纯只读的原厂 transport descriptor / DevelopmentAgent 存在检查契约。** 可从精确 SDK 二进制恢复 owner、句柄、锁、字段和返回 ABI，再只读检查官方已经创建的 FF.0 agent。此步骤不需要预先取得 private headers，也不调用 Start/Send/auth。只有存在检查通过仍不能证明 development 认证或 shell 可用；认证与内层 framing 必须分别完整恢复/核对，不能猜消息。
2. **独立恢复的下一证据是 GPIO17 的板级命名和原厂切槽/退出路径。** 已恢复的 selector 能指导这个窄查，不授权猜按键/MMIO。如果 Factory 启动和回 User 经原厂操作验证，且排除 global hook/待升级 artifact 副作用，执行者可在实际 Factory 程序下用原厂固定 FileId 405 做一次只读下载，检验 User ELF 的 O_RDWR/ETXTBSY 条件假说；错误 -1 不等于 errno，成功后仍要补 metadata。
3. 在这两个前置闭环之前，不写 debug/network配置/global hook，不替换 User/Factory ELF，也不制作依赖它们的持久安装物。继续 F4 独立源码/主机验证并不会解除机内入口和恢复门槛。

工程根运行 `python3 tools/firmware/bootstrap_recovery_collect_static.py` 重现。本 collector 校验输入与冻结引用、原 ramdisk inode/block/raw 内容、原 symlink 顺序、两份 DT GPIO 子集、完整86项 whitelist、FSBL 指令和原字节。`BOOTSTRAP_RECOVERY_SHA256.json` 绑定本报告、collector 和所有文本/JSON 证据；私有 section view 只留本地且单独记 hash。

等级：**静态分析已完成；主机仅验证解析/哈希和静态解码；临时实机未执行；持久验收未执行。**
