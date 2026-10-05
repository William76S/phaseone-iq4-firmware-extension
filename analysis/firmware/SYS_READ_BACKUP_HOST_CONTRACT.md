# 原厂 Sys 只读原件备份：主机源码合同

**已实现主机命令计划和严格接收/完整性验证源码；尚未证明 FF.0 shell 在相机可运行，尚无设备原件备份或解除锁定验收。** `tools/firmware/sys_read_backup_host.py` 不含 SDK、transport、设备访问或目标地址调用。它只生成受限的 Sys 文本计划、处理执行者已经收到的 reply，并在主机私有保存完整性通过的原件。静态/主机验证与临时实机必须分别记录。

对应静态依据是冻结 `SECURITY_EEPROM_SYS_READ_CONTRACT_STATIC.md`（共享 CommandDirectory、两层 lexer、Sys 255 字节重接、无 numeric exit、动态 EEPROM path）和 `DEVELOPMENT_SHELL_LIFECYCLE_STATIC.md`（原厂 Common ff/81、raw discriminator2/type1、correlation/flags/seq/末片）。当前 User ELF 身份、development Start/auth、输入借用池和实际工具 options 都未因源码合成测试而得到验证。

## 两层 parser 的具体适配

生成的 host text 把**完整 `Sys ...` 置于一个外层双引号 token**。字符设备加 `IqpDevelRaw ` 前缀后，第一层得到两个 tokens；结束双引号变 NUL，但内部空格保留，供 DevelopmentShell 从 token1 pointer 第二次 parse。第二层只用不含 `=`、双引号、反斜线、tab、NUL、新行的简单参数；Sys 重接结果与预期相同，包含前导空格时最多255字节，tokens少于40。此模型仅覆盖生成的受限 alphabet，不是一份可用于任意 shell 输入的 parser 实现。

裸 `Sys ...` 没有外层保护会被工具拒绝。内层引号/等号被拒绝，不能使用一般 `dd if=...` 或带空格的引用格式。metadata 采用无空格 `stat -c` format；HEX 采用 `od -An -v -tx1 -j OFFSET -N COUNT PATH`。具体 runtime options 必须先实测，package applet 名称证据不能替代这个前置。

每条 OS 计划是 `printf BEGIN; READ_COMMAND && printf END`。`&&` 避免 read command 的失败被末尾成功 printf 遮蔽。marker 没有反斜线或引号，不依赖 shell escape。printf 仅向 stdout 输出事务标记；read templates 不含相机文件写、配置改变、密码尝试、程序重启、任意 memory、EEPROM写或 firmware覆盖。

## 第一批有限 discovery

`python3 -B tools/firmware/sys_read_backup_host.py discovery --nonce 12345678ab` **仅打印 JSON 计划，不执行**。固定模板包括 p1linux PID、EEPROM 原厂 parent 下的匹配 glob、od/stat/readlink/sha256sum help。没有实例化或猜 bus 号。`parse_pid` 要求唯一正整数；`parse_eeprom_path` 要求唯一实际输出路径、同一个单数字 bus 在两处一致、精确 `0057/eeprom` leaf。多匹配、空结果、异常文字均失败。

得到实际 PID 后，`process` 计划只读 `/proc/PID/exe` symlink 和摘要。路径解析只接受已知 User 目录原件；Factory、deleted executable 或其他路径不会被默认为 User。后续 readonly original templates 限于已观察的原厂 EEPROM leaf、User p1linux 原件；没有通用任意路径 CLI。

runtime tool help 不是充分验收。执行者还需验证一个短 metadata/少量 HEX read 的实际完整 reply及所需 options，才可提高 chunk size。默认 HEX计划长度为256 bytes；上限8192 bytes，使用 `-v` 禁止相同块折叠，典型输出小于32768字节字符设备缓冲。实际输出数量/frames 仍由接收器上限检查；不以预估替代真实完整性。

## 接收和双读验收

`FragmentAssembler` 只消费 native receiver **已经提取的 Common payload**，不构造 outgoing packet。执行者必须先独立验证 raw callback buffer 的边界、outer/Common extraction 和 native receiver 生命周期；不得把这一 host parser 当新的发送协议。

- 仅 Common ff/81、payload discriminator2、raw type1；匹配关联 ID 和从0开始连续 U8 sequence。首片 flags1/3，后续0/2；末片后拒绝额外数据，禁止序号wrap。少末片不能完成。
- 固定 dataOffset20；声明 length/total 与实收 bytes一致；禁止 NUL、超限或混入其他通道。reserved bytes不猜语义。
- ASCII text 要求 exact BEGIN/END，无额外echo、日志、失败文字或重复marker。未知输出形态宁可失败，不能截取看似 HEX 的子串来宣布成功。
- HEX只允许每字节恰好两个hex字符及许可空白；拒绝星号折叠、地址列、错误文字、奇数/额外/短 bytes。

`BackupPass` 按连续 offset 组装，不允许重复、间隙或乱序。完成必须满足：

1. 前后 size/mode/uid/gid/permissions/mtime/inode 完全一致；positive-size regular file metadata 已验证。
2. 所有 chunks 解码 bytecount 的和恰好等于实际 metadata size。
3. exact EOF 边界 probe：在该 length 读取1byte时得到成功marker和0bytes；错误/缺END不等于EOF。
4. 组装数据 SHA-256 与独立目标 whole-file `sha256sum` 输出相同，精确路径匹配。不能仅凭 sysfs stat size、partition尾 `0x4000` 或两个相同的截断当完整 EEPROM。
5. 独立第二遍全部读取/metadata/EOF/whole-file hash也通过，两份 bytes 和 metadata一致。

工具不从这些 raw bytes解析 PIN、尝试解锁或打印 payload。必要的结构检查可另用已冻结的 `validate_security_eeprom_structure.py`，仅返回结构 flags；结构有效不是 Pin有效/锁状态或恢复成功证明。

`save_private_double_read` 在 POSIX 主机 exclusive 创建新目录（0700）及两份原件（0600），不覆盖已存原件，写本地完整性摘要；报告仅size、SHA、metadata与一致性。该 saver 拒绝 Windows：0700/0600 不证明 Windows ACL，Windows 执行者须独立检查项目私有目录的 owner/DACL 并用验证过的 native saver，不扩展其他人的读取权，不修改非项目文件 ACL。调用者必须先完成 `BackupPass.finish` 的两次验证，保存函数单独的 bytes-equal 条件不能替代前述设备真实性/读取验收。`restoration_verified` 和 `hardware_feature_acceptance` 保持false。

## 执行顺序和恢复边界

所有设备操作继续由 Root 协调的唯一 Windows 执行者串行：先 native protocol query/Start/auth的独立证据，再一个有限 discovery，等待匹配末片/完整marker后下一条；不能同时跑 Capture One 或多个 shell命令。系统命令没有已证OS timeout/kill；SDK Stop/断开不证明取消popen，超时或缺末片后不能盲目重发、切换线程或进入写操作。

首先取得原始 User hash、当前 PID/exe、文件 metadata和完整 EEPROM双副本，不写配置/record。约11.9MB User原件按8KiB块双读需要约2900条命令；先完成较小的EEPROM，User full backup单独推进，不能用摘要取代主程序原件。若后来改用原厂 Sys 临时 RAM/卡承载新备份文件，须先验证实际挂载、路径/权限、cardlease与取消/清理合同，本源码没有加入这个写入路线。原件私有保全后可继续研究原厂 CommandDirectory 直接 volatile Locked setter/getter。当前源码没有 RAM/EEPROM修改或解除锁定逻辑；直接写 event当前字节不触发原厂 notification也不等于原厂菜单权限恢复，不能当解除验收。

`collect_sys_read_backup_host.py` 运行28个合成测试并生成 deterministic manifest。测试覆盖两层解析、截断/丢片/错误 framing、失败输出、bytecount、metadata/hash/EOF与本地私有保存；仅主机合成数据，没有执行 camera/SDK/busybox。当前实机可用性前置仍未通过，不把这个源码完成记成已读取原件或已恢复安全状态。
