# F4：RAM 程序与一次性 preload / 原厂 respawn 正向入口

本轮闭合了原厂 **init → runner → User ELF → ld.so preload → DSO init** 的静态加载链，并交付了不发信号的有限只读 RAM 程序源码及主机恢复模型。选择的后续路线是先验证独立 RAM 程序，再验证 **RAM one-shot runner 先恢复原 runner、仅一次 exec 原 User 带 preload**。原 User/Factory ELF、QSPI、全局 hook、校准和密钥都不在本候选的变更范围。

这还不是可部署入口：实际 root/mount、runner 原件、工具与执行权限、独立监督者生存、原厂 User 退出/respawn 都未在本轮实机验证。主机模型不能赋予原厂退出后硬件/PL ownership 安全性；仅恢复启动脚本也不会移除仍在运行的 User 已加载模块。本轮没有设备访问、SDK 加载、网络请求、目标 ELF 执行、设备 payload、下载命令或启动脚本安装物；Stage2/Stage3 和此前冻结材料未改。

## 输入、地址与复现

| 固定本地输入 | SHA-256 |
| --- | --- |
| 包内 Boot_4.00.13.bin | 7a3a3d6f62c61e7d627a9f55d844d74be9111b26eb7a7fa42f5bdd7be7dabe9e |
| Boot 解出的 134217728 B ramdisk | 2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb |
| User P1Linux_6.03.21.bin，11874544 B | 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb |
| 原 rootfs /lib/ld-2.28.so，136792 B | 9be1d9704ad489d8d573f6a9fb851d4522f92481de5795d9defee99ba96dce8f |
| 原 rootfs /bin/busybox.nosuid，719432 B | bf695c8a770fc3fb0d47b3daf46b5c5841e538b3df17054e73660399d221597d |

包标示 6.03.18 与 User 文件名 6.03.21 并存，地址只绑定上述完整字节哈希。ld.so/BusyBox 是各自 ELF relative VA，不可套 User 的 VA−0x400000 规则。collector 经原 ELF section 映射保存每个窗口原文件偏移、原 bytes、哈希与 disassembly；ld.so complete_unwind 标记还核原 .eh_frame_hdr 的207个起点。未标 complete 的窗口不冒称完整函数。

复现 `python3 tools/firmware/f4_ram_loader_collect_static.py`。证据在 `analysis/firmware/f4_ram_loader_static/`：25个指令窗口、9个数据窗口、原件 rootfs metadata/text、User PT_INTERP、Boot RAM root 条件、applet 表和等长差分。私有分析用 ELF 副本被 .gitignore 排除；不需强制加入反编译二进制。主机测试/交叉构建见 `tools/firmware/f4_ram_entry_01/README.md`，使用已有锁定 Zig0.15.2；不下载新工具链。

## 1. 根文件系统及原厂 init 的独立重启链

Boot `[0x44891c0,0x448986b)` 的环境原字节 SHA `1291372f254498774b68cc66bcb0a094958e448cb70cabc33a71d34ac74556f7`，qspi bootargs 给出 `ramdisk_size=131072 root=/dev/ram0`，并把 User/Factory、modeboot 追加到 cmdline。但同块还有 NFS bootargs 和自定义 user_settings，故**静态 qspi 默认不证明本机实际 RAM root**。原 kernel config 为 INITRD=y、BLK_DEV_RAM=y、EXT4=y、EXT4_USE_FOR_EXT2=y、TMPFS=y；EXT2_FS 本身未编入。ramdisk 是 ext2 格式，不应要求实际 mount fstype 字符串必须为 ext2。

原 `/etc/fstab` 将 `/run` 挂 tmpfs，选项 `mode=0755,nodev,nosuid,strictatime`，没有 noexec；实际 flags 仍待读回。`p1-mount-squashfs.sh` 只在 cmdline squashfs 条件下把只读 loop 挂 `/mnt/squashfs`，没有在这份脚本中覆盖 `/p1/scripts`。任何运行时额外 bind/overlay/persistent mount 都必须通过完整 mountinfo 排除后，才能认为 runner 修改只在 RAM。

原 `/etc/inittab` inode2302、mode0644、uid/gid0、516 B，SHA `da1a356326c458b73d1abb187e9eb537c7d9ac86b7bb4cf3c567edb43115f535`，最后一条为 `ttyPS0::respawn:/p1/scripts/boot_run_p1linux.sh`。/sbin/init 指向 BusyBox。除文本外，实际 binary 有连续正向链：

| BusyBox relative VA / 原文件偏移 | 实际寄存器/分支 |
| --- | --- |
| 0x851a8..0x853ac | 0x851c4 将 0xa3218 `/etc/inittab` 交 parser；0x8527c..0x852cc 在 0xab7ce action-name 表寻找第三字段，并以 `1 << nameIndex` 创建 action。`respawn` 是 index3→bit8。 |
| 0x85c54..0x85c58 | init 主循环给 0x856e8 的 mask 为 0x18，即 respawn/askfirst；非一次性的解析结论。 |
| 0x856e8..0x857b4 | 0x85760 检 action flags&0x18；0x85768 读 action+8 PID，只在0时调0x85594并保存新PID。 |
| 0x85c88..0x85c98 → 0x84f78..0x84fd8 | waitpid 返回已结束 PID，helper 比对 action+8，0x84fa8 清PID；随后主循环可再次启动该 action。 |
| 0x85594..0x856e8 → 0x8541c..0x85594 | 创建子进程、setsid、准备 terminal，0x856d4 传 action+0x2d command 字符串至 executor，最终0x854f0 execvp；无额外 shell 元字符时按空白拆 argv，重新执行相同 runner 路径。 |

因此 init 不必重新解析 inittab 就能重新打开 runner 路径。**关闭 SDK 与这个 init action 无静态依赖**；独立监督者是否留在自己的 session、fd 是否脱离 User/SDK、启动及退出是否正常仍需实测。不要通过向 init 发送 restart/halt/reboot 信号来验证本项。

## 2. 原 runner 可采用一次性等长分叉，先恢复再 exec

原 `/p1/scripts/boot_run_p1linux.sh` inode2347、inode offset8694016、mode0755、uid/gid0、5105 B，SHA `fe57b899f3a583e1058e4e856cf80704d902d6989b802154d02e77bc93305e88`。第157行 file offset4809（0x12c9），为 `    ${P1LINUX_PATH} ${P1LINUX_ARGS}`，**35个源字符加1个LF共36 B**。主机只检查候选 `    /run/f4launch   ${P1LINUX_ARGS}` 同样36 B，差分恰为 file offsets4813..4827的15 bytes；没有生成修改后的整份脚本。

原 runner 先等 essential_boot_done；按 boot flag 选 User 或 Factory。它还会先消费所选目录的 p1linux.bin 升级文件、chmod原程序、检查 debug/skip 和三项 /run/p1linux_respawn_* action。这些正常逻辑全部早于157行。User 返回后原158..163行打包 runtime logs 到 storage、sync、sleep0.5秒，然后 runner 结束，init才重新启动它。**原厂 exit 会导致日志写卡/内部storage，本候选并未把这项原厂副作用隐藏掉。**

后续只研究以下窄顺序，当前没有设备 implementation：

1. 完整读回当前 root/mountinfo/cmdline、inittab、runner 两原件与 uid/gid/mode/inode；保全实际 User 完整原件、哈希、PID/start_ticks、argv/environment 启动方式。检查所选slot、debug、升级 bin、三个 respawn flags 与原 factory/user boot flags，遇到未知值不删除它们。
2. `/run` 实际 tmpfs且可exec、`/p1/scripts`确在RAM根且无covering persistent mount后，先验证有限只读 RAM 程序；再验证独立监督者不需要 SDK在线、不发User signal、有限deadline正常退出。
3. 新 runner 必须作为新inode构造；原 runner 保留同 filesystem 的原inode hardlink备份，保存原内容及所有 metadata。原打开的 shell fd仍看原inode；**不可 in-place overwrite正在执行的脚本**，未闭合 shell缓冲边界。/run是另一mount，不能用跨filesystem rename代替原inode备份。
4. 独立恢复者先ready且验证原件/候选哈希、inode和路径独占，再atomic rename候选到runner路径。只有经过单独验收的原厂 User 退出方式才能使init进入新runner；本轮不发送Restart/Quit/kill。
5. RAM launcher第一项动作必须atomic恢复保存的原runner inode、读回原hash/metadata及nlink cleanup结果，**然后**再通过自身execve环境只给本次原 User 加LD_PRELOAD。原argv/env须匹配已保存的启动方式；launcher不得接受任意可执行路径。代码/库核hash或secure gate不符则只exec同原User无preload。恢复失败不能加载adapter。
6. launcher未运行/无法exec时，预先独立ready的RAM恢复者仍能在期限后恢复runner；已经restore后后续init respawn会走原脚本且无adapter。首次只验证constructor有限marker、不注册帧/UI、不写卡。退出当前带adapter的User以及原厂硬件ownership归还必须另有经过实测的原生stop/exit合同。

主机临时fixture证明hardlink + replace保留原open fd、恢复同原inode/mode/content/nlink；状态模型覆盖每一缺门槛拒绝、restore-before-exec、SDK close后deadline恢复、未知runner拒绝覆盖、artifact/AT_SECURE不符回原User和下一次respawn不重复preload。这不是机内 inode/权限/启动验收；也不是“任何故障都自动解除”的声明。运行中模块不退出、root挂起或意外另一writer改runner仍是具体未闭合故障。

普通冷启动重新加载原ramdisk、丢弃RAM runner及/run只在本机实际RAM根/无持久覆盖、正常冷启动已实测后成立。Factory也执行全局hooks，不能替代本候选的独立撤销门；本路线没有改globalhook或User/Factory启动槽。

## 3. 原动态链接器提供正向 preload，不需要 User dlopen

User PT_INTERP原文件0x270、27 B为 `/lib/ld-linux-aarch64.so.1\0`；rootfs此symlink inode2356→ld-2.28.so。SDK已有材料证明 User 自身未导入loader函数；**程序重新exec时的原ld.so preload是不同入口**，不会向已经运行的User动态加载模块。

| ld.so relative VA / exact window | 指令证据 |
| --- | --- |
| 0x14af0..0x14b40 | iterator依次比较L、D、_，返回env entry+3；只消费LD_前缀。 |
| 0x20fc..0x2210 | 从 `__libc_enable_secure` relativeVA0x2fdc8读状态，环境循环找到`=`；长度7分支到0x3278。 |
| 0x3278..0x32a4、0x3714..0x3744 | 比较 little-endian PREL，再比较OA与D；0x3734跳过`PRELOAD=`，0x3738把value pointer存0x2f680。不是只搜字符串。 |
| 0x3580..0x359c、0x5070..0x5084 | consumer读同0x2f680，非null将preload文本/mainmap交0x1fe8，保存加载数量。 |
| 0x1fe8..0x20d0 | strcspn使用原0x18728 `space/colon` delimiters；最多4095 B token复制到ownedstack，终止后交0x1570检查，再0x1230加载。 |
| 0x1570..0x15d0 | secure0只需非空；secure非0要求长度≤254并拒绝含`/`的名字。因此绝对RAM库路径要求实际User exec时AT_SECURE/loader secure状态为0；这与Security UI Locked/Level没有已证明等价关系。 |
| 0x1230..0x12c8 → 0x12c8..0x1308 | wrapper通过 `_dl_catch_error`、原callback0x12c8和mode0x04000000调用0x7c68原map loader，保存map结果；失败有忽略preload日志路径。mode不赋予超出指令的私有语义。 |
| 0xd770..0xd8a8 | initialized bit门，依link_map读取DT_INIT/DT_INIT_ARRAY：0xd7d8 BLR init、0xd810..0xd820逐指针调用array，以保存的argc/argv/env进入。 |
| 0xd8a8..0xda00 | 原init序列处理主preinit及依赖map，0xd924调用同0xd770。 |

这些原指令闭合“stock loader可以映射并运行共享库构造器”的静态候选。尚未验证真实secureflag、库ABI/glibc兼容、constructor执行顺序/耗时、User初始化时机、UI thread/observer owner、代码卸载quiescence。构造器不得假设UiData已有，不做任意地址调用；SDKagent另独占原厂UI/queue/counter adapter。这条链不证明本轮已有临时in-process adapter运行。

## 4. 原厂下载工具的事实与边界

原BusyBox实际applet name table file0xa4d26，main table relativeVA0xbdbd8/file0xadbd8，通过R_AARCH64_RELATIVE addend恢复197项。rootfs inode和applet同时确认：

| 工具 | symlink inode / relative function VA |
| --- | --- |
| wget | /usr/bin/wget inode2093→/bin/busybox.nosuid；index189→0x259f0 |
| tftp | /usr/bin/tftp inode2131；index166→0x24cd8 |
| ftpget / nc | inode2188 /2074；index53→0x17130、107→0x20188 |
| sha256sum | inode2149；index143→0x68c14 |
| setsid / nohup | inode2118 /2127；index140→0x54f7c、109→0x694b0 |
| curl | 本原rootfs无/usr/bin/curl；197-entry applet也无curl。未扩成整个系统所有路径都无curl的排他断言。 |

优先有限自有LAN HTTP下载一个冻结公开ELF到已确认项目独占tmpfs目录，完成后原sha256sum独立核精确size/hash、再设置执行mode、再有限运行。要先读取实际工具帮助/文件hash、root/mount/tool symlink；不能仅凭包内工具称相机已可下载。URL只能由根执行者绑定实际自有LAN literal host/port、单一公开artifact，无userinfo/query、未知redirect或credentials。本轮没有URL/下载wire或执行设备命令。

wget binary0x25a58..0x25aa4把short option0x99808、long table0xa9e8a交原getopt32long：有 `O:`（保存到context+0x58）、`Y:`（+0x60）、`T:+`（+0x70 numeric）。原default +0x70=900。short/long确有output-document、proxy、timeout，TFTP0x99760有g/p/l/r及互斥条件。完整数据字节在exactmanifest。

**输出不是exclusive**：0x25b98给-O路径的flags0x241，0x25f14..0x25f1c交原open helper，含WRONLY/CREAT/TRUNC，不含EXCL。故必须先创建独占新目录与固定未存在artifact路径，不可覆盖原runner/ELF。继续模式也不能默认使用。proxy选项off比较0x25bec..0x25bfc为0时跳过0x2663c读取代理环境；有限下载计划需要显式不使用环境proxy，仍不据此证明LAN路由/网络可用。

`-T` **不是整个下载的总期限**：0x25700保存timeout计数、0x2583c poll1000ms超时递减；0x2586c在有效数据后重置计数，因此连续慢速数据可以延长总时长。实际任务仍需独立有限deadline/child退出观察，不能把900默认或-T单值写成总deadline。此处没有实现任意网络下载器，也没有改变eth1g.cfg；439 up/down source同步无timeout，非本路线的stage路径。

## 5. 首个可编译 RAM 程序及下一实测顺序

`tools/firmware/f4_ram_entry_01/readonly_monitor.c` 没有原厂地址/SDK/硬件调用。输入只接受实际已绑定 PID、start_ticks、1..30000 ms；每轮只读proc stat field22，readlink exe，成对再核start_ticks，路径basename必须p1linux且前后相同。身份或clock异常立即退出；固定最多两行公开结果，不打印argv/env/路径/内存/credential。stdout write明确存在，但没有打开任何写入文件；非阻塞stdout避免receiver不读导致输出无限等待。用户态CLOCK_MONOTONIC期限不能覆盖内核挂起；本程序不信号User、不restore脚本、不卸载模块。

主机synthetic C parser7项（64位start_ticks、overflow/sign/zero、exact PID/comm/state、truncation/NUL、signed其他field、4096上限）与恢复模型11项共18 tests通过；没有监视本机或相机实际User。已有锁定Zig编译目标PIE ELF64 AArch64 machine183、仅GLIBC2.17导入；build receipt保存具体imports/hash/命令。目标从未执行。import负检查只是源码受审查的补充，不作为完整side effect排他证明。

建议根执行者按下一项一项推进：

1. 先完成query/finite Sys/EEPROM双原件与异常锁恢复，保持唯一设备执行者。
2. 在有限Sys读回cmdline、mountinfo、实际工具与inittab/runner原件metadata后，评审RAM root和有限LAN artifact计划；Stage2/3不升级成拥有新profiles。所有quoted Sys text必须满足已冻SHELL_INPUT_GUARD的≤242 source bytes，不能拿原255join上限替代。
3. 首次只stage并运行readonly_monitor，验证同User identity、期限、进程结束/清理；再独立session运行同probe，断开SDK仍记录deadline末片并正常退出。此时原runner完全未改，也未重启User。
4. 原runner完备备份、native无debug修改的User exit及module-free respawn先实测。Restart仅在debug确不存在的原厂分支才能考虑，Quit可能创建debug并SIGTERM，不用作快捷恢复。不要执行未核allhandlers的kill/escalation。
5. 完成上述恢复验收后，才实现并验证RAMrestorer/one-shotlauncher，先constructor marker→退出→原runner/User哈希、普通LV、权限及完整EEPROM与原baseline一致；再接counter-only UI adapter；最后接owned-copy/encoder/原厂卡后端。SDK/HDMI录制不充作机内实现。

结果层级：**新静态正向入口完成；主机18项测试和AArch64交叉构建完成；RAM staging、有限代码运行、User一次preload/fallback、机内录像与持久安装均未验收**。本材料提供具体可继续实现/实测的路线，而不把独立恢复已可用写入STATUS。
