# F1 前置：IQP 文件读回与独立恢复静态证据

本记录只包含离线分析。没有连接相机、监听网络、构造/发送协议、执行相机命令或写入固件。源码、现有 ENTRYPOINTS/MODULE_MAP 与主状态记录未改。本阶段优先为 F1 机内 LV 遮罩寻找可读回原件的原厂通道。

**结论：原厂有完整二进制读取后端，但尚无已验证的主机入口或独立恢复路线。** `FileManagerIqpClient` 可以读取白名单中的 User/Factory `p1linux` 与 manifest；`sys` 的输出则是文本链，不能代替二进制备份。`init_shell` 在静态启动图中可绕过普通早/晚 hook，但其物理激活与控制台可达性未知。当前证据不能授权安装全局 hook 或替换原厂应用。

## 输入绑定与证据层级

| 项目 | 精确绑定 |
|---|---|
| `.fwr` | `Firmware-BP-IQ4-IQ4_6.03.18.fwr`，SHA-256 `a52758ffb163023e5323297e450450f91002175b69bed7590fe2cd037c2ab300` |
| Linux 应用 | `analysis/firmware/extracted/P1Linux_6.03.21.bin`，11,874,544 bytes，SHA-256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb` |
| 应用架构 | ELF64 LE AArch64、ET_EXEC；BuildID `1f451370d713ae1f341e9d5de5615717f9fb36ed` |
| Boot | `Boot_4.00.13.bin`，SHA-256 `7a3a3d6f62c61e7d627a9f55d844d74be9111b26eb7a7fa42f5bdd7be7dabe9e` |
| 根文件系统 | ext2 ramdisk，SHA-256 `2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb` |

下面全部地址是此 ELF 的链接 VA。`.text`/`.rodata` 的文件偏移等于 VA − `0x400000`；本记录所用初始化 `.data` 表偏移等于 VA − `0x410000`。没有测量运行时映射或恢复调用 ABI。指令读取出的结构偏移是**收到解析后消息的内存字段**；不能把它们自动当作 USB/TCP 完整封包规格。

| 验证类别 | 本记录结果 |
|---|---|
| 静态分析 | 指令、白名单表、启动脚本确认 |
| 主机验证 | 原始二进制解析与反汇编可重现；未模拟完整 IQP 状态机 |
| 临时实机 | 未执行 |
| 持久验收 | 未执行 |

## 原厂 managed file 二进制读取

这与原厂 shell 中的 `FileManager [list|md5]` 不是同一能力。后者 help 还出现 `signature [set|clear]`，其中 set/clear 有副作用，不属于本阶段只读操作。

| 静态入口 | 指令证据 |
|---|---|
| `FileManagerIqpClient` 构造器 `0x750ee4` | 安装 vtable `0xc36c48`；FileManager owner 存 `+0x10`，FileStream 在 `+0x18`，状态 `+0x30` |
| IQ4 配置器注册 | `0x425558` 构造上述 client；`0x425578` 调用 `0x871260` 加入 ProgrammingAndLog handler 的 client 列表 |
| 文件消息分发 `0x870318` | CommonMessage `+4` U8 必须 `0x65`（明确断言 DeviceProgramming）；`+5` U8 为 `1` 才到 `0x870418` |
| 只读 open 分发 `0x870418` | 从 CommonMessage `+0x10` 读取 U32 fileId (`0x870528`)；把 mode `1` 传给 client vtable `+0` (`0x87053c–0x870544`)；按 client 返回值与完整文件尺寸处理 |
| client open `0x750f9c` | 参数 fileId `<=399` 返回 `2`；否则减 `400` (`0x750fdc`) 后，经 `0x74e120` 在固定表查 internal FileId；不接受路径字符串 |
| 只读权限 | open 参数 mode `1` 且 `0x74e058` 返回 flags 的 bit `0x1` 置位才进入读分支 (`0x751048–0x751060`) |
| 文件打开 | `0x74e5a8` 按 folderId 取得 FileSystem；`0x74df84` 取得固定 basename；`0x7510b4` 调 FileSystem vtable `+0x28`，本分支传参数 `w3=0,w4=1,w5=0` |
| 完整尺寸 | `0x751100` 调 FileStream size getter `0x825a24`，返回 U32 尺寸，写入 caller 的 expected-size 指针 `x3` (`0x75111c`)；零尺寸被上层拒绝 |
| 二进制 read `0x75124c` | `0x75128c` 调 `0x82586c`，后者转 FileSystem vtable `+0xf0`，传原始 destination pointer 与 byte count；本链没有 `strlen`/`fgets`/文本格式化 |
| outgoing block provider `0x870a2c` | `0x870c0c` 调 active client vtable `+0x10`，返回读取字节数；累计超过 expected-size 时 abort (`0x870c34–0x870c90`) |
| close/abort | client `0x751218` / `0x75136c` 调 FileStream close `0x82580c` 并清零 remaining-size 与状态 |

`FileManagerIqpClient` vtable `0xc36c48` 的首项 Open 是 `0x750f9c`，`+0x10` Read 是 `0x75124c`。客户端返回值在 open 分发中可确认 `0` 为成功、`1` 为拒绝、`2` 继续寻找其他 client；这些不是已经确认的线缆错误码。顺序读取可见，但任意 seek、重传、最终端到端摘要与断线恢复仍需完整协议/主机实现证据。

### 与 F1 备份直接相关的固定文件

固定文件表位于 VA `0xf55f18`、file `0xb45f18`，86 条、每条 40 bytes：`+0` U32 internal FileId，`+8` basename pointer，`+0x10` flags，`+0x18` folderId，`+0x20` description pointer。`0x74df84`、`0x74e058`、`0x74e120` 的循环都确认 86 条边界和 40-byte stride。表中 `+0x14`、`+0x1c` 还有元数据，本阶段不将它们冒认为权限。

| 固定目标 | internal ID | Open 参数候选（ID+400） | flags | folderId | 表项 VA |
|---|---:|---:|---:|---:|---|
| User `manifest.xml` | 4 | 404 | `3` | 4 | `0xf55fe0` |
| User `packagemanifest.xml` | 60 | 460 | `3` | 4 | `0xf56008` |
| User **`p1linux` 原件** | 5 | **405** | `3` | 4 | `0xf56030` |
| User `p1linux.bin` 安装触发文件 | 6 | 406 | `3` | 4 | `0xf56058` |
| Factory `manifest.xml` | 14 | 414 | `3` | 5 | `0xf56238` |
| Factory `packagemanifest.xml` | 61 | 461 | `3` | 5 | `0xf56260` |
| Factory **`p1linux` 原件** | 15 | **415** | `3` | 5 | `0xf56288` |
| Factory `p1linux.bin` 安装触发文件 | 16 | 416 | `3` | 5 | `0xf562b0` |
| storage `debug` | 25 | 425 | `3` | 1 | `0xf56468` |
| storage `test.txt` | 26 | 426 | `3` | 1 | `0xf56490` |
| storage `ethdebug.cfg` | 27 | 427 | `3` | 1 | `0xf564b8` |
| `/var/log/p1Linux.log` | 29 | 429 | `1` | 6 | `0xf56558` |
| `/var/log/messages` | 63 | 463 | `1` | 6 | `0xf56580` |

flags bit `1` 为 read、bit `2` 为 write 的语义由 Open 两个分支确认（写分支在 `0x751134–0x751200`）。**表项 flags=3 不等于已经批准写入。** 读回 `p1linux` 不需要向 `p1linux.bin` 写任何内容。该触发文件一旦存在可能被启动脚本安装，不能拿它测试传输。

固定 folder 表 VA `0xf55cb8`、file `0xb45cb8`，19 条、每条 32 bytes。`0x74e260` 返回 `+8` 路径字符串，`0x74e454`/`0x74e5a8` 选择 FileSystem owner：

| folderId | 静态根路径 | 表项 VA |
|---:|---|---|
| 1 | `/run/media/storage/` | `0xf55cd8` |
| 4 | `/run/media/storage/User/` | `0xf55d38` |
| 5 | `/run/media/storage/Factory/` | `0xf55d58` |
| 6 | `/var/log/` | `0xf55d98` |
| 8 | `/mnt/qspi/` | `0xf55dd8` |
| 13 | `/run/` | `0xf55e78` |

86 项表中没有 `autostart.sh`、`late-autostart.sh`、`init_shell-autostart.sh` 或新的扩展文件/目录；没有证据表明 Open 可绕过 basename 白名单。也没有证据表明它提供 Unix mode、uid/gid、xattr、symlink target 或“不存在”的完整备份描述。不要把读回字节称作已经完成可恢复文件系统备份。

## development shell 接收与文本回送

原厂确有 development shell 后端，不是仅 strings 命中，但外层可达性仍未知。

`0x862b40` 构造 IqpDevelopmentHandler，vtable `0xda4168`，保存 Rx queue `+0x20`、Tx queue `+0x28`、buffer owner `+0x38`、busy U32 `+0x44`、character-device `+0x48`；IQP simple factory 在 `0x85dc30` 构造它。`0x862ce4` 收到正确队列通知后调用 `0x862d5c`；后者取得解析后的 CommonMessage。

| 解析后字段 | 观察值/意义 | 指令位置 |
|---|---|---|
| CommonMessage `+4`, U8 | `0xff` development class gate | `0x862eac–0x862eb4` |
| CommonMessage `+5`, U8 | `1` accepted message type | `0x862efc–0x862f04` |
| CommonMessage `+6`, U16 | 相对 CommonMessage 的 payload offset；LE AArch64 直接 `ldrh`，此点没有 byteswap | `0x862f0c–0x862f18` |
| development payload `+0`, U8 | `2` 到 shell dispatcher；`1` 是另一条 capability-response 分支 | `0x8637f4–0x863820` |
| shell payload `+4`, U8 | commandType `1`；明确断言 `kDevelopmentCmdShell_raw` | `0x8630d8–0x8630fc`, `0x871e3c–0x871e44` |
| shell payload `+5`, U8 | 接收后保存并回送的关联值，尚未给出正式字段名 | `0x871fa4–0x871fb0` |
| shell payload `+6`, U8 | 必须 `3`；日志明确“不支持 split in two or more messages” | `0x863044–0x863054`, string file `0x9a3e38` |
| shell payload `+8`, U32 | data length | `0x871ef4` |
| shell payload `+0xc`, U16 | 相对该 shell payload 的 command-data offset | `0x871edc–0x871ee8` |

没有检查所有 length bounds、marker、checksum、channel negotiation、authentication、transaction setup、device user-level gate、USB/TCP 端点权限或 host listener ownership；不能据此生成线缆包。`/dev/ffs-iqp/ep0/ep1/ep2` 和 USB mux Rx/Tx 确实存在于固件，但现有 Capture One/public CameraSDK 是否可打开 development/file 通道仍无静态证明。

### 文本输出与限制

IQ4 应用配置器 `0x4246a8` 构造 development 字符设备（构造器 `0x871d40`），`0x424710` 构造 `IqpDevelopmentShellCommandHandler` (`0x872828`)，随后通过原厂 command-directory vtable 注册。该 command 对象 vtable `0xda7d48`，执行槽 `+0x48` → `0x8728c8`，命令类型参数 `0` 才进入解析；最终使用原厂 shell owner vtable `+0xa8`。这不是可直接从主机调用的 ABI。

`0x872314` 接收 C string（首条 `strlen` 在 `0x87232c`），将字符复制进 character-device `+0xc` 的 32,768-byte buffer；满时由 `0x8724e4` 调 `0x863618` 发片。序号 U8 在 device `+0x8021`，关联值 U8 在 `+0x8020`。首个满片 flags=1，随后满片 flags=0；结束 `0x8725a4` 使用 flags=2，未发过片时 flags=3，并调用 `0x8637c0` 清 busy。序号增加后按 U8 截断，长输出的序号绕回是可见静态风险，尚未验证主机如何处理。

`0x863618` 分配 header+data（shell header 20 bytes），`0x863aa0` 构造 payload：`+0=2`，`+4=commandType`，`+5=关联值`，`+6=flags`，`+7=片序号`，`+8=U32 dataLen`，`+0xc=U16 20`，`+0x10=U32(20+dataLen)`；`0x8637a4` 用 memcpy 写 data。回送调用通常 commandType=`0x81`、应用 class/message 参数=1，而拒绝通知使用 `0xff`。这里只给代码中实际参数，不声称已还原全部协议枚举。

随后 `0x863570` 包装 event type `11`，通过 Tx queue vtable `+0x30` 入队（参数 60000、1000，正式单位未恢复）；队列失败时释放 buffer。没有运行时输出、ACK 或流控可靠性验收。以下方法明确只记录未实现：Putb `0x872764`、XModemSend `0x8727a4`、XModemReceive `0x8727e4`。

LinuxCommands command-id `1` 分支在 `0x6c39dc` 起，将 token 重新连接到 256-byte command buffer；`0x6c3a8c` → `0x7781a4` → `0x778214` → `0x778244`：

- `0x778288`：`popen(command,"re")`。
- `0x7782e0`：`fgets(buffer,65,FILE*)`。
- `0x778364`：callback vtable `+0x10`，作为 C string 输出。
- `0x778394`：`pclose`；可读取 exit status。

该链说明文本读回有实现后端；裸二进制会因 C string/NUL 截断而失真，不符合原件备份。也没有生成 Base64/hex 命令来规避未知通道、输出流控或恢复前置条件。文本链可继续用于已文档化且获验证的原厂诊断入口；完整原件优先 managed-file binary client。

## 恢复分支与全局 hook

以下源文件是 Boot ramdisk 的原始脚本，既未执行也未修改。

| 静态路径 | 已证实行为 | 不能推断的部分 |
|---|---|---|
| `rootfs_static/etc/init.d/p1-mount-qspi-partitions.sh:8–15` | `ubiattach -m 1`；UBIFS `/dev/ubi0_0` → `/mnt/qspi` | 实机 mount 状态、实际内容与权限 |
| `rootfs_static/etc/init.d/p1-link-to-user-storage.sh:24–39` | 普通 boot 的 storage 指向 qspi；只有 cmdline 含 `modeboot=sdboot` 才指向 SD mmc mount | 不等于插普通照片 SD 就可执行 hook |
| `rootfs_static/etc/init.d/userhook.sh:10–14` | 同步运行 storage `autostart.sh` | 没有 extension bypass 或 Factory 条件 |
| `rootfs_static/etc/init.d/p1-late-userhook.sh:7–11` | 同步运行 storage `late-autostart.sh` | 没有 extension bypass 或 Factory 条件 |
| `rootfs_static/etc/inittab:7,20` | 正常 init 调 p1-rcS 后台 rcS；ttyPS0 respawn 原厂应用脚本 | 原厂 app 与 rcS 时序不能当作有保证的恢复窗口 |
| `rootfs_static/p1/scripts/boot_run_p1linux.sh:53–65` | User/Factory 选不同 app 文件 | 两者仍共享普通 rcS 的全局 hook |
| 同脚本 `77–87` | `p1linux=skip` 或 storage debug 文件可跳过 app 并到 sulogin | 单独跳过 app 不跳过 rcS hook；debug 还改变 services |
| 同脚本 `98–119` | `p1linux.bin` 可替换原厂 app | 不是无害文件传输测试 |
| `boot_environment.static.txt` | `bootargs.shell` 增加 `init=/sbin/init_shell`；bootargs 仍带 user_or_factory/modeboot | 如何物理选择、env 的可信来源和实机启动 loader 门控未知 |
| `rootfs_static/sbin/init_shell:1–31` | 自身挂 dev/proc/sys；选择2直接 shell；选择3只挂 qspi 并可跑**另一文件** `init_shell-autostart.sh`；未执行普通 rcS；选择1才 exec 正常 init | 必须先证明能从应用或 hook 故障状态激活，并可操作 ttyPS0/console |

因此存在**静态独立 bypass 候选**：loader 选择 shell → `init_shell` 的2/3分支，不调用普通 rcS，故可绕过 `autostart.sh` 与 `late-autostart.sh`。它不是已确认的用户恢复步骤，不能据此写 hook。Factory 切换、app skip 或 debug 文件均不能独立解决坏全局 hook。

## F1 可执行前置与精准阻塞

1. 先获得官方/已验证主机调用入口，证明它使用上述 read-only FileId client，而不是猜 IQP wire packet。可对 405/415（应用）、404/414/460/461（manifest）与实际将动的已有配置做只读读回；保存字节数、摘要、文件来源和版本。此处尚未读回任何实机文件。
2. 如 F1 只使用原厂 overlay 属性且无需持久文件，备份实际属性值并使用其已确认 getter/setter；恢复原值并验证原厂 LV 行为。本记录没有证明该属性支持自定义比例或 XPan。
3. 新 hook/adapter 路径不在 managed-file 白名单内。要动这类文件，仍缺能够只读确认其存在/内容/元数据、取出原件及删除/恢复该路径的经过验证接口；不能用“可以读 p1linux”替代这些条件。
4. 持久 app 变更还缺独立启动 bypass 实机验证、当前 Factory 原件确认、替换原件的安装/签名条件，以及实际冷启动后可恢复的证据。Windows 预检/编译也不构成这些验证。
5. 即使 managed-file 白名单带写权限，校准、license/密钥、boot、Factory 元件等不属当前 F1 写入范围。本阶段无相关写入。

## 可重现静态检查

下述只读命令在项目根执行，使用已安装的 LLVM；不会连接设备。先核对 SHA-256，未知哈希的二进制不得复用这些地址。

```sh
shasum -a 256 analysis/firmware/extracted/P1Linux_6.03.21.bin
/Library/Developer/CommandLineTools/usr/bin/llvm-objdump -d --start-address=0x750f9c --stop-address=0x75136c analysis/firmware/extracted/P1Linux_6.03.21.bin
/Library/Developer/CommandLineTools/usr/bin/llvm-objdump -d --start-address=0x74df84 --stop-address=0x74e1b0 analysis/firmware/extracted/P1Linux_6.03.21.bin
/Library/Developer/CommandLineTools/usr/bin/llvm-objdump -d --start-address=0x870318 --stop-address=0x870700 analysis/firmware/extracted/P1Linux_6.03.21.bin
/Library/Developer/CommandLineTools/usr/bin/llvm-objdump -d --start-address=0x872314 --stop-address=0x8726b0 analysis/firmware/extracted/P1Linux_6.03.21.bin
```

注意 llvm-objdump 的“最近 libstdc++ 导出符号+大偏移”标签不是上述私有函数名称。函数字节与字段是证据，未恢复原型不能直接调用。

```python
# 只读解析固定表；此数据不是线路封包。
from pathlib import Path
import hashlib, struct
b = Path("analysis/firmware/extracted/P1Linux_6.03.21.bin").read_bytes()
assert hashlib.sha256(b).hexdigest() == "9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb"
for i in range(86):
    o = 0xf55f18 - 0x410000 + 40*i
    ident, _, name, flags, _, folder, _, description = struct.unpack_from("<IIQIIIIQ", b, o)
    if ident in (4, 5, 6, 14, 15, 16, 25, 26, 27, 29, 60, 61, 63):
        n = name - 0x400000
        print(ident, ident+400, b[n:b.index(0,n)].decode(), flags, folder)
```
