# 原厂临时 Locked false → 原始 true → false：有限执行与恢复合同

提供可集成主机状态机 `tools/firmware/volatile_lock_roundtrip_host.py` 与15项合成故障测试。**本阶段仅静态/主机验证，没有SDK加载、相机控制、实际状态修改或回滚。** real adapter由Root唯一执行者提供，不能把本模块的合成成功当作临时实机验收，更不能当持久解除或F4机内录像完成。

程序版本、Locked bool/事件注册、original setter/通知/五权限正向链复用冻结 `VOLATILE_LOCK_COMMAND_STATIC.md`、`VOLATILE_PERMISSION_READ_STATIC.md`；源地址只绑定 User SHA `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`，11,874,544 B。actual query/有限echo、原厂FF Start/Send/Stop同module契约及输入pool未关闭边界复用 `DEVELOPMENT_SHELL_LIFECYCLE_STATIC.md` 与 SDK `DEVELOPMENT_SHELL_SINGLE_V2_CONTRACT.md`。本模块不改这些冻结工具，不提供任意shell、属性、内存写、PIN输入/查询、NoLock、reset、固件部署或record接口。

## 1. 具体原厂完成与异步边界

`OsEvent set` `0x6bbbf0..0x6bbf0c` 对全名字匹配，调用bool decoder后，在没有 `-ns` 时 `0x6bbe70→0x70f2f8` 通知原event，再 `0x6bbe9c→0x6bdfb0` 格式化当前值。首个匹配产生两行heading+一行event；每个额外同名字会另加行，未找到则error文字。两条固定body分别是 `"OsEvent set Locked 0 -f"` 与 `"OsEvent set Locked 1 -f"`；全ASCII、原厂两层lexer逐字核对、不使用Sys重拼、不传true/false/hex、没有 `-ns`、长度<255。

完整正常set回复可由旧 `validate_locked_reply` 验证为**恰好三行、唯一精确Locked、类型b、canonical目标bool**。set回显只是当前值；decoder返回值不等于notification已全部处理。`0x70f2f8` 对wrapper VT+0x10通知，`0x710820` 进入原厂thread queue；原worker `0x70ff84..0x710060` 后续回调SecurityHandler，再重算权限。`0x6aab5c..0x6aac70` 的Locked订阅及 `0x6aac70..0x6ab23c` 证明 Locked=false→Unlocked和四个Unlock* true，但secondary通知/所有异步写并没有全局排除。

DevelopmentShell `0x8729f0` 同步目录调用返回后才 `0x872a28→0x8725a4` 发末片。只接受原厂Common ff/81、完整LE32 discriminator=2、commandType1、correlation71、seq从0连续、offset20/actual total及有效first/middle/final flags。应用输出总长<=32760；不接受缺末片、复用事务、后续多片、序号回绕、foreign片、NUL、截断record或三行以外输出。

**完整final证明本次目录调用已返回；不证明queued SecurityHandler或所有后续存储工作已结束。** 每个发送/读取都须原厂Start/Send owner与同module约束、receiver span/seq证明、正常Stop Join/cleanup、thread/callback storage清零、receiver清除及Close/identity/idle guard完整。SDK原Send/Stop没有已证硬deadline；60s是完成读取后的观测预算，不是取消保证。未知Send、缺final或cleanup不明时，保留payload/callback/SDK/Camera原owner，停止后续调用；不把Stop/Close/kill/重新Open当作取消设备命令。

## 2. Adapter的有限证据边界

`Workflow`只接注入的adapter。公开API合同如下；本工程本阶段没有real adapter或设备调用实现：

| 方法 | 必须来自实际证据，不能用缓存/猜测替代 |
| --- | --- |
| `identity() → Identity` | 当前/proc PID、start_ticks、exe实际路径、完整User哈希/长度及metadata；每次与初始一致。路径仅接受旧冻结User路径集合，不混Factory。另有Root原厂model293/6.03.18/private-serial guard。 |
| `quiescent() → bool` | 同一串行执行lease，无C1/其他SDK、拍摄/LV/保存/配置操作竞争；原厂identity/idle guard有证据。 |
| `capture_eeprom() → Capture` | 动态0057 sysfs leaf唯一实际读回；完整metadata前后相同、精确EOF、全部连续chunk、device whole digest与assembled bytes相同，来自冻结Sys `BackupPass.finish`。每次都重新采集，不能返回原件缓存或只再算主机hash。 |
| `transact(Plan) → NativeReply` | 只原厂SDK有限profile，transaction_id与本计划相同，原始LE32-length received Common payload records及已验证original cleanup/idle。不能伪造成功bool、剥离error、混上一次输出或只提供formatter文本。 |
| `monotonic()/wait(seconds)` | 实际单调时钟与间隔；不能用延时替代完成。wait只请求0.2s。 |

Root先检查不可变query PASS/finiteecho PASS及SDK/hash/sourceguard、same owner、single executor、原件Windowsowner/protected single-user DACL、quiescent。`Gate`是经Root审阅的证据记录，**不是加密attestation**；调用者可以伪造dataclass，因此实机controller必须从保存的actual trace/profile与readonly结果产生，不能手填true。

两个完整EEP原件Capture必须同源path、metadata、data、device digest、EOF证据全部相同；完整原件已私有保存，源extent真实验证，正长regular source及工具选项实际通过，不能以包内0x4000访问上限推定source完整性。源形状允许已审阅2MiB以内，volatile路线没有裸EEP写或要求修改record。module不解析原件PIN/keys/calibration语义、不保存原件、不修改ACL，不能代替Windows私有采集管线。

原始Locked必须稳定true，五权限必须全coverage、canonicalbool、唯一精确名字、Unlocked=false。Baseline来自stage2真实两轮读后，还需本workflow三轮重新验证；拒绝unknown、重复、prefix collision、wrongtype、extra output、native错误和非完整回复。每轮读取 Locked前→5个有限权限→Locked后，并且两个Locked相等；要求三轮相同目标bool/权限，轮间>=200ms；最多6轮、每phase观测60s。baseline/rollback target是**实际保存五权限精确相等**，不能按“Basic应如此”推算。

三轮与间隔是有界实际probe策略，不是证明任何未来异步线程绝不再动；所有判断仍需前后完整EEP、身份及原厂权限读回。若观察到变化，计数归零，达不到三连续则失败，不靠固定sleep宣称稳定。

## 3. 固定状态机与完整恢复条件

1. `BASELINE_CHECK`：核真实gate、当前identity/quiescent、实际完整EEP原件相等；三轮原始true+实际五权限；再次完整EEP与identity。任何失败都不发set。
2. `TEMPORARY_CLEAR`：set前重新identity/quiescent、实际完整EEP相等和三轮原始target；只发一次0。要求完整精确set回包false、三轮false+五权限全true、完整EEP仍逐字节等于原件、identity/idle。记录临时结果。
3. `ROLLBACK_ORIGINAL`：set前重复当前false target与完整EEP/identity；只发一次1。完整回包true、三轮true+**五权限全等原始baseline**、完整EEP等原件、identity/idle才令rollback_verified=true。
4. `FINAL_TEMPORARY_CLEAR`：只有回滚成功后，set前再检查原始target与完整EEP/identity；一次0、完整replyfalse、三轮五权限全true、完整EEP相等、identity/idle。最终只报告 `COMPLETE_TEMPORARY_FALSE`。不承诺重启存活、持久码恢复或F4。

主流程严格0→1→0，总计划三次set；Workflow一次使用，成功/失败都不能重复run。每次set前后有完整实际EEP读取，整个流程最大512次native事务；正文只有固定两个setter或六个finite reader。不能接受任意name/value/path输入形成设备命令。

## 4. 故障恢复不等于重新发送失败请求

| 状态 | 下一步 |
| --- | --- |
| `REJECTED_BEFORE_WRITE` | 未发set；Root保留原件/失败证据，继续独立工作。 |
| `HOLD_UNCERTAIN_NATIVE_OWNER` | Send异常、无final、raw framing/correlation/事务id错误、cleanup/idle未证。没有rollback/Stop/Close/retry；唯一执行者保留owners并单独解决in-flight状态。 |
| `HOLD_IDENTITY_OR_EEPROM_CHANGED` | 当前User/PID/startticks/path/metadata/quiescent或实际全EEP变化。禁止继续set、raw restore、重启/Factory切换去掩盖差异。保全新完整私有快照，Root查明范围。 |
| 命令已完整final+正常cleanup，但setecho/类型/稳定target不符 | 可进入一次有守卫的恢复：重核identity、完整EEP相等、三轮当前唯一typed状态。若false，最多一次**新恢复操作**set1，要求原始baseline、完整EEP、identity完全回来；若已true且baseline完全相等，只验证不再写。绝不重发0。 |
| `RESTORED_AFTER_FAILURE` | 原始true+五权限+全EEP+identity已验证；trial失败，不发最终false、不冒称轮返成功。 |
| `HOLD_FAILED_BASELINE_RECOVERY` | 有完整结束的恢复仍不符。禁止同值重复通知、再次恢复、reset或最终false；Root保全证据处理。 |
| `HOLD_UNCLASSIFIED_ADAPTER_FAILURE` | 没有vendor异常正文泄露；不推断状态/取消。 |

正常三次之外仅可能一次新原始true恢复；不完整command不触发它。未知输入/重复名字时没有可靠的unique target，不能强行恢复。同值true但permissions不等原始baseline也不盲目再发true。unexpectedEEP变化没有自动writer。源码不调用摄像机Stop/Close，不向其他任务或用户发送消息。

## 5. 输出、验证与仍待实机项

public_result只返回固定状态/计数/有限history和布尔，不含raw、路径、PIN、credential摘要或vendor exception。`explicit_PIN_Level_counter_record_command_generated=false`只说明这份有限计划不生成这些命令；`vendor_transitive_sideeffects_globally_excluded=false`避免全局排除。只有成功状态才 whole_EEPROM_equality_at_success=true。普通完整EEP原件SHA仍可在Root原件完整性记录保留；本模块不输出它，不拆credential单值hash。

15项合成测试覆盖真实风险对应的状态转换：正常0/1/0、observer延迟、六gate分别拒绝、User身份不符、EOF/双原件不等、prefixcollision、时钟NaN、未知发送/缺final/cleanup/id错误、完成但wrong/duplicate回包后的单次true恢复、权限不重算、rollback权限不等baseline、EEP/metadata/User变化后无续写、quiescent与baseline拒绝、一次使用及有限正文/全LE32守卫。测试只构造**接收方向合成fixture**，不构造/发送设备wire。

运行 `python3 -B tools/firmware/test_volatile_lock_roundtrip_host.py`；冻结 `python3 -B tools/firmware/volatile_lock_roundtrip_collect_static.py`。源静态合同与主机状态机已经可复现。Windows real adapter/profile构建、actualquery/echo、当前User/EEP双原件、exactbaseline、实际0/1/0及cleanup/完整EEP/权限验收仍由Root唯一执行者完成，未在本模块执行。
