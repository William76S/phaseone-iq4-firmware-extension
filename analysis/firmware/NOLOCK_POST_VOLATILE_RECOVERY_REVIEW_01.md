# 原厂 No Lock：临时解锁之后的最小配置恢复范围

**已验证的临时 Locked=false 可使原厂 Security Level 菜单进入，再选 No Lock；这一菜单路径不需要再提交 PIN。原厂 No Lock 是现有一字节 SecurityLevel 配置改变，保留 PIN record1，不等于持久 Locked=false。** 本轮没有访问相机、Windows、SDK、真实原件或安全码，没有执行固件或产生设备写入。

输入仅为包内 User `analysis/firmware/extracted/P1Linux_6.03.21.bin`，11,874,544 B，SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`，BuildID `1f451370d713ae1f341e9d5de5615717f9fb36ed`。下面 VA 属于此 AArch64 ET_EXEC；本报告不认证实际设备版本。新审查只引用、逐项核验已有冻结材料，未重写旧证据。`no_lock_post_volatile_review_01/` 记录源锁、精确窗口索引及本地验证结果。

## 能实际推进的两个原厂入口

| 路线 | 精确正向链 | 已证明条件与止点 |
|---|---|---|
| 原厂屏幕 Security Level → No Lock | `4f1708..4f1720` GUI+140→SecurityDTO+8→`4e6560` 枚举菜单；`4e6dc0` child activation→DTO VT+a0=`5efbe0`→index 校验、取 24B 记录+10 的 U8→DTO VT+100=`5f0210`→owner VT+48=`52d0d8` | `4f1728..4f1744→4f683c` 将 PinGroup+8 Locked 绑定为 required=false；`4e5394`/`4e7ce4` 先拒绝 Locked=true。实际 volatile false 之后可进入这一 bounded 原链，不必输入 PIN。原值 index0/1/2/3 是 raw0/1/3/2，不把 presentation ID 当 host property ID。 |
| 原厂 Development OsEvent 有限配置入口 | 原 OsCommands ID2 注册 `6ba570..6ba594`→VT+48=`6bd814`→`6bb978`；完整 set branch `6bbbf0..6bbf0c` 遍历已注册 event，整名比较→interior VT+20 text decoder→`70f2f8` notify→formatter | 该本地 set 分支没有额外 PIN/Locked 检验；FF.0 创建、认证、完整回包与生命周期仍由已审 transport 负责，不能由此声明整个通道无 gate。名匹配可作用于所有同名 event，因此必须实际有限 list 证明唯一、完整名称、U8 `h` 类型。现有 Stage3 只允许 Locked0/1，尚不能发送本名，需要全新有限增量。 |

这两条不是相同 setter ABI。UI 的 `52d0d8..52d154` 是有临界区、值比较的原 U8 setter，只在变化时通知。OsEvent 是 `6bbe0c..6bbe3c` 经 interior decoder（`5ed598` thunk→`5ed12c`），直接更新事件 current+ c0 后另行通知；不能把它写成调 UI setter。它们都通知同一原 SecurityLevel event，进入现有 config observer。这里只推荐有限非秘密配置值，不改 PinCode、SetPinCode、PinCodeFails、密钥或校准。

既有离线 candidate 的 body 只有 `"OsEvent list SecurityLevel -f"`、`"OsEvent set SecurityLevel 0 -f"` 及绑定实际原值的恢复 body。对本项目 Basic 原值的新增有限源码只需恢复 `1`；**原1必须由完整 typed 当前读取和 private 原 record24 双重证实，不能取构造默认1。** 它是顶层 CommandDirectory OsEvent；不要添加字面 `Sys`，也不要套用 Sys 的破坏性 token join。复用实际已审 transport 的外引号/tail guard、nonce、完整 LE32 fragments/final、cleanup；没有自制 packet。读取用 prefix filter，须拒绝额外/重复行；setter whole-name匹配仍须先证明唯一。U8 decoder 按 `%hhu` 且不检查转换数，只允许精确十进制0/1，不接受空值、hex、expression、额外 token、`-ns` 或其他名称。

## 五权限、保存设置与异步刷新

原 `6aac70` updater 读取 Level 和 Locked，`6aacb4..6aacc4` 始终给 `Unlocked=!Locked`。Locked=true/Level0 分支 `6aad44..6aad94` 只给四个操作许可 true；Locked=false 分支 `6ab140..6ab18c` 同样给四个 true。

| 已重算状态 | Unlocked | UnlockFirmwareUpdate | UnlockUI | UnlockCapture | UnlockRestoreToDefault |
|---|---:|---:|---:|---:|---:|
| Locked=true，Basic1 | false | false | true | true | false |
| Locked=false，任一合法级别 | true | true | true | true | true |
| Locked=true，NoLock0 | **false** | true | true | true | true |

Save/Restore System Setup 父菜单 `4f1b10..4f1b68` 检查 UnlockRestoreToDefault=true，所以已重算的 NoLock0 可开放这个已证父 gate；没有把所有后端/子页是否成功当作静态保证。Security Level、Edit Security Code 和 Host-access-code 菜单各直接要求 Locked=false；NoLock0 加 Locked=true 仍可拒绝这些入口。正确结果表述是“持久关闭按级别的操作限制、原 PIN 保留”，不能标“完整持久解锁/五权限全true/安全菜单恢复”。

完整 ctor `6aab5c..6aac48` 只直接订阅 Locked interior，另做 initial recompute；未订阅 Level。因此 Level setter/formatter 完成并不证明当前四权限已刷新。实际 volatile false 后本来五权限全true，这个状态也不能证明 Level0 的 locked 分支。用原已验证 Locked notification/往返采集稳定权限，或正常冷启动后的 initial recompute；不要把重复 ordinary bool same-value setter当必然通知，也不能只看菜单没有警告就认证异步完成。

## 原件、持久化与只用原 config 后端回退

PinGroup+2a0 是 U8 owner VT `bcba48`/interior VT `bcbaf0`，serialized length `5ec9c8`=1。原 config ctor `6a7d7c..6a7da8` 将它登记为 **SystemStorage key24**，与 key23 PinCodeFails 和独立 key1 PIN不同；flags8/1 在 `6a4d70..6a4da0` 跳过 Setup 导出/恢复列表。所以普通保存设置文件不代替原 EEPROM 完整双备份。

SystemStorage registration `717d94..718178` 打开/加载已有 record 并注册观察者。通知 callback `718178..718460` export U8、Open 已有key24、Read old、memcmp；不同才过 `718468..718748` rate guard，调用 backend Write `72104c`。上层忽略 Read/Write 返回值，rate guard 可拒绝，因此 formatter的0/1不是 EEPROM commit receipt。System 分区 `[400,c00)`，顺序 key/length/payload；key24实际物理offset依已有记录而变，禁止固定offset、创建缺失record或重建分区。

仅原 config setter 的恢复顺序如下，**仍待 Root 实际原件和恢复验收，不是已授权现场调用**：

1. 实际同User/hash、同进程 start_ticks、单执行者、native完整reply/正常cleanup；真实 Locked 与五权限；严格唯一完整 SecurityLevel `h` 当前值1。完整EEP两个独立original、实际metadata/extent/EOF/device wholeSHA一致；private结构验证现有key24长度1且值1、key1长度16，不解码它。现有 host snapshot auditor仅适配0x4000，不能据此宣称st_size0或任意设备已取得全extent。
2. 先完成既有 volatile false→原true→false和全EEP相等恢复验收；原菜单或以后有限原事件profile一次Level0。独立全EEP双读：只有原现有key24的一字节从1变0，所有其他EEP字节（包括key1 opaque16、key23、布局、头）相等；再读唯一typed0。无需另写PIN/失败计数或全EEP，也不用 KeyStorage Refresh。
3. 通过同原配置入口一次恢复Level1。唯一typed1；全EEP独立双读必须逐字节等原original；权限须对应实际当前Locked，必要时经已验证原Locked通知验证原Basic gate。**设置相同原字节或 host 合成相等不算改后恢复验收。** 外层发送/末片/owner/cleanup未知则Hold，不第二控制器、自动重发或盲kill；额外EEP差异不能用安全记录改写掩盖。
4. 持久验收还需要正常冷启动，新实际PID/start_ticks/程序hash、typedLevel1和完整原EEP equality验证回退；之后才可最终Level0，再冷启动独立记录实际Locked/五权限和全EEP仅key24差异。菜单进入验证与冷启动结果分开。cold Level0不会强制Lockedfalse：PinHandler `6aa228..6aa3b8` 独立load key1，仅undefined cache分支 `6aa304..6aa328` 清Locked，不能从opaque原件是否非FF推测cache/PIN。

## 普通连接生命周期与 Owner lock 的正向边界

现有 `SECURITY_HOST_CODE_BINDING_STATIC.md` 已闭合 Core+2c98 host-code UI→两个 auth-group+1f8 string setter→`8782dc..87854c` digest更新/清set-code。它没有闭合到 PinGroup Locked、SetPinCode或record1；普通 ChannelOpen token 不等于 UI PIN。固件 IQP ID12 实际绑定系统序列号，不能把 C1 `012E000C Connection password` 低位12当同一命名空间。公开 property list/state/descriptor 和 enable-events 有各自已证 dispatch，不能据 getter名称排除间接副作用。

现有冻结研究**没有可推荐的普通Open/Close/LV/Owner lock自动Lockedfalse正向路线**；这不是全局排除证明，也不能建议反复连接修锁。已证其他 false producer是正常匹配码/undefined cache、accepted SecureCommand、以及Main environment flag0分支；本项没有known码/有效SecureCommand/可设置environment flag的完整可达恢复合同，故不使用。普通busy/host session cleanup与这里的安全Locked/Level门分开观测。当前最短无PIN原配置路线是先真实volatile解锁，再有限level1→0→1恢复，验收结果限定上述范围。
