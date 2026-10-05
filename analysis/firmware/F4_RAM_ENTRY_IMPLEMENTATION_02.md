# F4 RAM 一次性入口 02：完整源码与恢复合同

本增量完成可审阅的原 runner 恢复先于 User exec、独立监督器、constructor-only marker 和 stage/install/disable 生成器。验证层级为主机测试及 AArch64 交叉构建；没有设备访问、实际 User 退出、SDK Start/Send、target ELF 执行或相机写入。它不完成录像、UI 页面或持久部署。

源码在 `tools/firmware/f4_ram_entry_02`；新的证据和 inert build 在 `analysis/firmware/f4_ram_entry_02`。不修改已冻结 RAM01、frame adapter、Stage2/3、原固件、原厂程序或 Root 主记录。地址和 bootstrap 静态依赖仍由冻结 `F4_RAM_ONE_SHOT_ENTRY_STATIC.md` / `f4_ram_loader_static/manifest.json` 绑定。

## 精确输入和修改范围

静态候选 rootfs runner `/p1/scripts/boot_run_p1linux.sh` 为 5105 B，SHA `fe57b899f3a583e1058e4e856cf80704d902d6989b802154d02e77bc93305e88`。只接受其中唯一的 36 B 原调用行等长替换成固定 `/run/f4launch`；候选整文件 SHA `5edb451013419a70a73b480ba02c07b4fa6454103cded66832d4433401f1a8fe`。没有生成完整修改脚本；实际执行者必须先两遍读取目标 runner 原件和 inode/mode/owner/xattrs，并验证其实际挂载。

未修改 User 的固定完整文件哈希 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`、11874544 B，canonical path `/mnt/qspi/User/p1linux`，原 argv0 `/run/media/storage/User/p1linux`，无额外参数。每次 arm 核对当前完整文件、PID/start_ticks、exe 和原 umask；launcher 要求旧实例已消失，parent 必须是 init 的 stock BusyBox shell runner，BusyBox 本身核完整 SHA。包名字不替代哈希；Factory 的地址/哈希不混入这个 User 合同。

| Profile | 必要备份和恢复条件 | 本次产物 |
| --- | --- | --- |
| readonly_monitor | 当前 User 完整文件 hash、PID/start_ticks；自有 RAM 文件/输出范围、有限退出、SDK Close 后独立性 | 原 RAM01只读源码保持冻结；02仅列 disabled requirements |
| RAM_marker_once | 修改 runner 两遍全文/元数据/inode；实际 root=/dev/ram0 与 RAM ext2/ext4、可执行 /run tmpfs；hardlink/rename/fsync 同 fs 探针；原厂退出、stock respawn、冷boot原 runner；当前 User hash/argv/env/umask基线 | 完整源码，默认 EN0，stage_commands=[] |
| persistent_deployment | 每个将修改 User/config 的完整实际设备原件、修改之外的独立恢复、禁用/冷boot恢复验收及精确安装物 | 未实现，明确 disabled |

User 12 MB 两遍全文导出是 RAM marker 的可选保全，不是修改域之外的新门槛。持久修改 User 时则必须取得真实全文原件；本地包或 `/proc/PID/exe` hash 不等于其设备原件。EEPROM 双原件在这个项目当前 recovery-aware 首次 restart gate 中保留，但此源码不打开 EEPROM、PIN、校准或密钥。

## 实现与固定调用契约

1. 生成器默认 `F4_ENABLED=0`。entrytool所有 mode 都在 main 中先拒绝，默认包没有设备 command。实际 enabled package 需要严格 profile `RAM_marker_once`、18 项真实 receipt、两个独立 runner 全原件、Root 单执行者身份与实际 mount/metadata/PID/start_ticks；每个 receipt 完整 SHA 可复核。校验程序验证类型和文件完整性，Root 必须审查硬件语义。测试用 synthetic true 不生成 enabled 包。
2. 有限 staging 只能创建 `/run/iq4_f4_entry02` 0700 后五项固定公开 artifact：entrytool、marker.so、entry.sha256、install.sh、disable.sh。marker 和 tool 固定哈希，文件 0500；digest 0600。目录需真实新建且空，不使用 `mkdir -p`。按固定三位 octal format 每块32 B，全部 source≤242 B，literal `=`/LF/NUL 均拒绝。文件内容可包含任意 ELF 字节，源命令自身无 actual credential。每步仍需实际 receipt、EOF、目录/文件元数据及整 SHA；失败不得凭 Sys 文本继续。没有网络/任意 URL/任意路径/万能 shell executor。
3. `entrytool --stage-launcher`：只 atomic hardlink 新 `/run/f4launch`，核 tool digest 和元数据，不修改 runner。`--preflight` 默认只读。`install.sh --arm` 必须显式进入 arm；脚本及 C 都不请求 User 退出、不发 signal。
4. Arm 从当前原厂 User 原 argv/environ 两遍抓取受保护 RAM 快照，拒绝 LD_*、重复/malformed名字或>16384 B/>256 项。快照不输出或公开摘要；它们可能含敏感数据，保持 RAM0700/0600。保存 runner 双字节副本0600和原 inode hardlink0755，创建等长 candidate，整 hash 验证。原件都在替换路径外；任何部分失败保留原件并拒绝重复覆盖。
5. Arm fork 独立 supervisor，setsid，标准 fd转/dev/null，关闭其它 inherited fd，固定 `/proc/self/fd` 枚举上限4096。ready pipe 原厂进程退出之前必须确认。监督器独占 owner.lock、固定私有 AF_UNIX/SOCK_SEQPACKET control.sock0600；只有 SO_PEERCRED root UID/GID且 exe匹配的固定工具/launcher能够进入。父在 supervisor ready 后再检查原状态并 atomic rename候选到 runner，原 inode hardlink保留。监督不依赖 SDK session/原User；这种独立性仍需要真实 SDK Close 验收。
6. Root 另行执行经过实测原厂 graceful exit；本包不提供它。init 按静态候选 respawn stock runner时，launcher **第一步恢复原 runner hardlink/inode/hash+目录fsync**，然后验证真实 parent、旧 User gone、flags、当前 User 和环境。恢复失败拒绝 exec；不冒险覆未知文件。恢复成功后，模块不符、disabled、fd198已有所有者、无监督 ACK或 loader exec syscall失败均走同一未改 User stock执行。原argv0/环境/umask保留，只有 marker preload成功路径增加固定 LD_PRELOAD。fd198的成功dup由本程序拥有，所有失败分支成对关闭；不关闭预先存在的borrowed fd198。
7. IPC launch request=`F4L2\n` 5 B，ACK=`F4OK2\n` 6 B；constructor=`F4M2\n` 5 B，只发一次并关闭owned fd198。非阻塞、MSG_NOSIGNAL，监督者死亡不能让 constructor SIGPIPE User。Supervisor在 exec前绑定 PID/start_ticks，marker后核 User exe/comm/ticks，成功写独立 marker.observed0600。它仅证明 constructor执行过，不证明 owner/UI/frame/codec/storage工作。
8. Supervisor期限固定 CLOCK_MONOTONIC 30 s，poll100 ms，launcher ACK至多1000 ms，父ready至多2000 ms。期限结束再次独立恢复 runner，不signal User；status.json最后 phase可能覆盖早期 phase，marker.observed保留。内核/文件系统挂起没有硬实时退出保证，不能把用户态deadline当 watchdog设备已证明。
9. `disable.sh --disable` 创建RAM disabled，恢复原 runner，再可选发固定`F4D2\n`给监督者。无监督时仍能恢复；没有进程内卸载、盲kill或自动删除原件。返回 `unload_verified=false`。先用实际原厂正常退出/stock重启或已验证冷boot让module mapping消失，再分别核 User identity、runner字节/inode、无扩展marker/observer；没有该验收不能称为退出恢复成功。

## 拒绝与恢复边界

恢复只接受“当前已为精确原 inode+bytes”或“当前精确candidate且备份为精确原inode+bytes”。陌生runner、备份缺失/损坏、wronginode、symlink、owner/mode/xattr异常、root或/run mount变化均拒绝并保留文件，不尝试复制未知文件覆盖。原 hardlink 的丢失不是字节副本可自动升级为等价恢复的理由。两个 runner 字节副本允许人工/Root复核，但任何较低层恢复须新合同。

Fatal loader/constructor死亡后只能依赖**实际已验证**的 original init runner respawn；原 runner已在 exec前恢复。若监督者突然死亡且当前 User未退出，RAM candidate可能仍待替换；standalone disable或经过验证的冷boot恢复是前置，不以“有deadline”推断已经恢复。不会发送未知packet/MMIO或修改init/QSPI/User。Factory/debug/upgrade/.bin及三种respawn旗标存在时拒绝。

恢复前置：当前版本、actual mount/AT_SECURE/可执行tool/原 runner双原件与元数据、同 fs 原子机制、原argv/env/umask、独立只读monitor退出、原厂graceful exit+stock respawn、冷boot原runner、SDK关闭后独立性全部实测；任一缺失只阻止对应 RAM runner arm。当前硬件不在此子代理范围，这些门没有置真。

## 主机验证与仍需真机验证

20 个主机测试已通过：SHA空/abc/边界/million-a和extent；实际 C exclusive create、原 inode/open fd恢复、idempotence、未知内容/备份缺失/wronginode/权限/xattr/symlink拒绝、跨进程flock；环境LD/duplicate/extent拒绝；实际 C ACK正确/错误span；有限profile/每个actualgate拒绝；全256字节通过已冻native两层lexer及三位octal formatter。C测试逐字提取生产函数，fixture固定临时目录和当前hostUID，不编入相机路径。

macOS fixture仅适配 flistxattr签名，并过滤host自动不可删除的com.apple.provenance；其他xattr保留且拒绝。IPC fixture采用host AF_UNIX/SOCK_DGRAM保留message边界验证ACK；目标SOCK_SEQPACKET/peer creds/setsid/inherited-fd/real init respawn仍未测试。没有拿host fsync/rename测试证明目标文件系统。

Preview AArch64 PIE及constructor SO针对GLIBC2.17构建；marker dynamic imports只有send/close。另以合成编译常量将所有launcher/arm/disable/supervisor分支编入ET_REL对象，没有main/constructor，不可作为安装ELF。对象未执行，67个undefined符号审计无kill/raise/ptrace/system/popen/execvp/dlopen/ioctl/pthread_create；execve/fork/socket等是本固定启动器的预期接口。

另完成独立fixed-path `readonly_facts.c` 及PIE链接。它只读固定User/runner整hash和前后stat、runner xattr名称总字节/errno；仅输出一行元数据，不输出内容、环境、xattr值或PIN。负errno不视为无xattrs。没有参数解释器，没有arm/改runner/更改flag；源复用只读C helper，target imports确认 mutation/exec/socket分支均未链接。它不在五artifact mutation stage plan内，没有已运行/已部署证据，可在独立只读入口成立后由Root有限stage作为未知xattrs的采样工具。

下一实机步骤由Root唯一Windows执行者协调：先解决现有USB枚举/公共Open失败；原厂query/有限Sys只读成立后取得实际mount/runner双原件/argv与工具，并先独立readonly监测验收。完成原厂退出/stock恢复和RAM机制探针后，再生成精准enabled marker包、实际stage全hash、预检、arm、一次graceful exit、marker及stock恢复往返。counter/UI observer新模块必须另绑定完整owner/生命周期与模块hash，不可直接替换首marker。录像最终卡写/尺寸/真实新帧及持久部署仍由后续阶段完成。
