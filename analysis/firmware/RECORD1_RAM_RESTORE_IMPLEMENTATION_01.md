# record1 opaque16 RAM 实现 01

证据层级：新增源码、合成主机验证和 AArch64 交叉编译。没有设备访问、真实 EEPROM 原件读取、actual private profile、目标运行、实际写入或解锁。公开默认 ELF 读写均禁用；全分支编译审计为无 main/constructor 的 ET_REL。RAMEntry02 和既有 Stage2/3 冻结材料未修改。

## 固定修改范围与依据

`tools/firmware/record1_ram_restore_01/engine.c` 仅处理完整 0x4000B owned snapshot 和已经存在的 System key1 16B payload。结构范围由冻结 `validate_security_eeprom_structure.py` / `audit_security_record1_range.py` 核对：System [0x400,0xc00)，20B header、记录 `(key,len,payload)`、唯一 key、FF terminator、key1 长度16、已有 key23/24 的合法长度。payload offset 必须从实际完整原件扫描取得，不能输入猜测地址或创建新记录。

原16B恢复直接复制 opaque 原件。清除仅沿冻结 `SECURITY_PIN_CLEAR_NATIVE_STATIC.md` / `PIN_RECORD1_OPAQUE_RESTORE_STATIC.md` 已闭合的原厂 undefined payload =16个 FF；不计算、解码、读取文本 PIN 或生成安全码。此 C 工具未调用私有 ABI，而使用标准 `pread` / `pwrite`。其访问 leaf、范围和 provider 仍需实际证明。完整 EEPROM 的任何其他字节，包括记录头、尝试计数/Level records、校准及密钥区，均不允许写入。

## 有限执行合同

| 动作 | 前置 | 唯一允许 EEPROM 写入 | 结果边界 |
|---|---|---|---|
| `--preflight` / 默认 | actual 只读绑定、完整原件及 runtime 身份 | 无 | 原结构、其他全量字节是否仍原件；不公开 payload |
| `--same-original` | Root 新 sole 授权、完整双原件、恢复路线审阅、readonly RAM probe、完整当前原件 | existing payload 原16B | 仅 same-original transport |
| `--clear` | 上述条件，另 actual same-original transport 与 clear→restore→coldboot 原始基线路线审阅 | existing payload FF16 | 仅完整字节读回；不宣称已解除 |
| `--restore-original` | Root 新 sole 授权和 reviewed recovery；其他全 EEPROM 字节原件 | existing payload 原16B | 完整原件读回；不宣称已完成 coldboot restore |

每次先双 full snapshot；shape 和 offset 必须与真实原件一致。用 owned snapshot 暂将 record1 payload 替回原16B，再计算整个 EEPROM SHA 与完整原件 SHA 比较，以验证所有其他字节。写前再次双 full snapshot，要求与最初当前完整 digest 一致。维护 lease 禁止并行原厂控制/配置写入；本工具的本地 flock 仅排除本工具并发，不能冒充原厂 EEPROM 锁。Root 仍需独立私有完整读回、literal byte comparison 和真实维护状态验收。

target 固定 root UID/GID、EEP canonical leaf/inode/device/mode/stat_size、实际 kernel release、User 文件 SHA/大小及 root0755、PID/start_ticks 和 `/proc/PID/exe`。PID/start_ticks 在 exe 检查前后读取，User hash 后再次核对。不是只凭 PID 相同判断未重启。每次 full EEPROM 读取必须 exact16384B、offset16384处真实 EOF、前后 metadata/runtime 一致；最多4次读取 EINTR，避免无限信号重试。`st_size=0` 可作为已绑定 metadata，但不证明 extent。

每写只有一个 `pwrite(fd,bytes,16,offset)`，无短写/EINTR重试，close错误也视为失败。冻结 `SYS_EEPROM_RANGE_RESTORE_STATIC.md` 的 at24/nvmem/sysfs 写路径可能页分片、部分失败；fsync 为 noop，不能作为持久证据，因此本工具不以 fsync 成功充数。写后双完整读取必须证明所有其他字节原件、payload 目标值、header/offset不变和 runtime身份一致。

失败 clear 的读回若仍完整原件，停止且不再写。若仅 record1 payload 不同、其他全量/结构仍原件，允许一次完整原16B回退并双全量核对；若其他区域不同、shape变化、读取失败/不稳定，停止且不碰任何其他字节。same-original 或 restore 失败也不自动重试。单次程序最多 clear+原件回退两次16B write；无 clear 重试。

`/run/iq4_record1_01` 必须实际 tmpfs root0700 并绑定 device，RAM `transaction.lock` root0600、nlink1、flock非阻塞。动作 `.once` 用 O_EXCL 消耗本次权限；即使之后拒绝/断连也不自动删除。自动原件回退会消耗 restore.once。未知传输终止不重复执行、不强杀 User。生成器和 C 端均没有任意命令执行器、内存地址调用、记录新增、整图 write、计数/Level写或 target重启。

## 私有绑定与公开证据

`generate.py --emit-private` 只在 Windows、既有单用户 DACL private目录运行；owner必须当前SID，访问主体仅当前SID/SYSTEM/Administrators。不会修改项目外 ACL。两份独立实际全原件必须稳定读取、相等并匹配全原件 SHA；实际 receipts 的文件摘要逐一核对，Root须审阅 receipt 内容，而非把 host bool 当硬件事实。编译器为已有且审阅摘要的 Zig0.15.2，不下载新工具链。

绑定要求实际唯一相机/执行者、完整原件双读/EOF/device digest、独立 extent、canonical leaf metadata、kernel/at24 provider、当前 User hash/PID/start_ticks、维护 lease、实际 tmpfs、existing16B范围与快照稳定。写角色另外要求 reviewed exact16恢复路线和真实独立 RAM readonly probe；clear角色另外要求真实 same-original transport 和恢复 coldboot 路线审阅。所有门是严格 JSON bool=true，非1/string，附私有 receipt provenance。只支持实际 extent=0x4000；这是一版适配限制，不代表实机已经证明16KiB。

actual原16B、offset、配置、ELF、编译临时文件/缓存/日志以及这些敏感派生产物摘要全留受保护目录；公开源码和 manifest 只有已知合成 fixture。stdout仅固定 typed booleans，不含实际路径、payload、PIN、单值/响应/body摘要。完整原件 SHA 仅按既有完整性证据使用；不得单独发布低熵 credential 或 setter body 摘要。尚无实际 protected profile、目标 staging 或运行计划。

## 验证与剩余验收

20项主机测试编译实际 C engine，覆盖真实普通临时文件 pwrite/full EOF、短写、写后报错、原件未变不重写、其他记录改变拒绝回退、post-read未知不盲写、预写竞态、重复/missing/moved记录、offset溢出、write禁用、所有实际gate类型/extent/provenance拒绝。未模拟相机 EEPROM电源/时序、实际 sysfs、native cache reload 或 coldboot，因此不作为这些验收。

工具输出 `same_original_transport_verified`、`restore_transport_verified`、`clear_payload_verified` 分开记录。`changed_then_restored_coldboot_verified` 与 `persistent_unlock_verified` 始终 false。成功 opaque16写回不会刷新当前 PinHandler 缓存；Root须使用另行闭合的原厂 User退出/正常冷启动路线，不执行任意 kill 或把 RAM armed runner 丢失的 reboot 当已经可恢复。

实际验收顺序必须由唯一执行者串行完成：完整原件及基线保全→独立只读工具验收→same-original transport→clear→原16 restore→冷启动确认完整 EEPROM原件及原 Locked/五权限 baseline→重新取得 actual PID/start_ticks/inode/provider绑定→再次clear→正常冷启动并确认 Locked=false及原厂权限。首次 same-original 不能替代“改后恢复”，主机同字节通过不能将恢复 gate设true。每次 runtime identity改变，旧产物应拒绝，不能重用旧PID绑定。F4功能部署和录像验收仍另行推进。
