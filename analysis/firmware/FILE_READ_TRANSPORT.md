# 原厂二进制文件读回：应答、通道封装和认证门控

本阶段是严格离线分析；没有打开USB/网络设备，没有构造/发送IQP封包，没有生成线缆发送器，没有读取或修改相机认证配置。它补充 `DEVICE_FILE_CHANNEL.md`，不把静态可见的read405/415记为已有备份。最终应优先使用原厂SDK已有binary transfer，而不是手写未知线路命令。

输入仍为 `P1Linux_6.03.21.bin`，SHA-256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`，来自显示版本6.03.18的指定包。全部VA为本ELF链接地址，code/rodata offset=VA−0x400000；没有验证运行时对象或ABI。`read_channel_static/exact_bytes.json` 保存本文用到窗口原字节和offset，`FILE_READ_TRANSPORT_SHA256.json` 保存本阶段文件哈希。辅助伪代码不替代指令。

## 完整静态链及当前结论

USB FFS已启用/端点已初始化 → 原厂USB mux读16字节头与其声明的后续长度 → 查存在的channel manager → 原厂通道open/version/requirements/认证状态机 → channel **1.0** ProgrammingAndLog → CommonMessage DeviceProgramming class0x65/type1 → FileManager fixedFileId read mode1 → open应答绑定fileId/result/transferId → 原厂DataTransfer provider按偏移提供二进制 → 原厂close/abort。

除405/415 fixedFileId权限外，此链还需要已打开的合法channel/session和必要的用户认证。SDK代理另行确认公开DownloadFile对这些ID的主机状态gate；那是主机条件，不能与相机认证混为一谈。本文没有证明当前设备通道/认证已满足，也没有给出绕过方案。

## USB传输封装：实际指令读取的字段

| 原厂接口 | VA | 证据 |
| --- | --- | --- |
| USB mux Rx构造 | `0x874468` | 初始化线程与endpoint fd；保存group owner `+0x1c0`，不自行证明主机可直接占用设备。 |
| USB mux packet循环 | `0x87483c` | 从group buffer manager申请0x110 buffer；调用 `0x8745b8` 先读取16字节，从得到的buffer `+0x28` 取packet pointer。 |
| 外层marker校验 | 同上，`0x874944` 后窗口 | packet `+0` U32等于 **0xddccbbaa** 才继续；失败丢弃buffer。小端原字节是 `aa bb cc dd`，这里只是读取证据。 |
| 后续长度 | 同函数 | packet `+8` U16 与 `+0xa` U8 相加，非零时从offset16读该长度。需完整channel/packet约束才可安全解析；不能只按marker拼包。 |
| channel选择 | 同函数，`0x874a24`附近 | 从packet `+6/+7` 读U8，经 `0x875300(group,id,subId)` 查manager；null或manager拒收均释放buffer。 |
| DataPacketHeader构造 | `0x84bb0c` | 清16字节；写marker、`+4=2`、`+5=16`、`+6/+7=channel IDs`；本构造用于设备数据应答。其他类型有不同构造/长度，不把它当通用主机命令header。 |
| Common pointer getter | `0x84c178` | 从DataPacketHeader pointer加16。 |
| Common marker校验 | `0x856b00` | 上述pointer `+0` 必须U32 **0x44332211**，否则返回null。小端字节 `11 22 33 44`。 |

主配置静态 `0x40fba8/0x40fbb4` 使用 `/dev/ffs-iqp/ep2` 与 `/dev/ffs-iqp/ep1` 路径；另有ep0 setup字符串及USB connection manager。这些是相机内gadget节点，不是主机可照抄打开的节点，也不是USB descriptor/interface/端点号、bulk transfer边界、控制请求或当前会话可用性的完整证据。没有将串/网络端点当成已授权执行入口。

`0x875300` channelId1选择group `+0x14f8`下 `+0x10` manager。`0x85d108` simple factory channel1分支 `0x85d2a8..0x85d39c` 创建 ProgrammingAndLog manager，并调用真正handler ctor **0x86feac**。`0x8700f0` 是收到IqpEvent的事件分发函数，**不是构造函数**。这些命名根据本轮指令更正。

## 通道open认证与其他必要要求

OpenStateGate `0x851c3c` 先取得并检查open request。它检查通道协议版本/子版本、message version兼容、flags、最大收发payload等条件；只有0错误状态并成功送出openreply才返回成功。具体每个协商枚举不在本阶段恢复，不能从这几个字段形成完整open实现。

认证分支：

- state owner `+0x2b8` 是authentication group候选。如果为空，或其 `+8` 的原厂bool getter `0x41497c` 返回false，则此分支不要求token。它不意味着当前设备auth关闭。
- required为true时，`0x851fec..0x852000` 从group `+0xe0` 通过 `0x66473c` 取32字节token值；`0x852004..0x852010` 从open request `+0x22` 通过 `0x853520` 取客户端token。
- `0x85205c` 调比较函数 `0x6641b0`。不匹配进入 `0x852078` 的“Authentication failed/missing - client rejected”诊断，并在 `0x852090` 设置openreply结果 **6**；该请求不会成功打开通道。

AuthenticationSetup handler `0x8782dc` 监听本地认证事件，构造并保存token；存在PicoSHA2实现。没有读取认证code/token的运行时值，没有改变required、code或digest，也不尝试猜密码或重放。获得正确session应走原厂SDK/CaptureOne已有合法连接和设备用户认证配置。用户授权功能扩展不自动证明未知认证property可写。

上面的required gate是相机通道open状态；SDK DownloadFile host allow-flag是另一层。即使主机放行FileId，也必须保留此原厂通道验证、sequence/flow-control和transfer状态机。

## Read-open应答与二进制数据传输

`0x870318` 收到CommonMessage class0x65/type1后调用 `0x870418`。它读取Common `+0x10` U32 fileId，向各registered client VT+0传入read mode1与expectedSize pointer，返回0成功、1拒绝、2继续找client。成功expectedSize存handler `+0x788`，client存 `+0x798`，active flag `+0x790=1`，transferId从handler `+0x54` 复制至 `+0x7a0`。busy flag `+0x784` 非零时拒绝第二次open。

更正一个细节：client成功但expectedSize=0时，`0x870418` 此处记录错误日志，仍进入成功状态分支；本轮没有证据证明该点立即拒绝零尺寸。备份实测仍应要求合理非零长度和ELF内容，不可仅以返回码0验收。

`0x870ca0` read-open response分配 **0x2c=44字节**设备buffer：先构造16字节DataPacketHeader，channel IDs取自原请求 `+6/+7`；Common后部由 `0x87172c` 构造28字节，再设置DataPacketHeader payload length。发送使用Tx queue的原厂event11，而非直接未知USB write。

| 应答字段（相对CommonMessage） | 指令支持值 | 地址依据 |
| --- | --- | --- |
| `+0` U32 | marker0x44332211 | Common ctor `0x84b73c` |
| `+4` U8 | class0x65 | `0x871764` |
| `+5` U8 | type0x81 | `0x871760`，byte截断 |
| `+6` U16 / `+8` U32 | header/total length字段由版本大小函数 `0x871854/0x87189c` 计算 | `0x84b778..0x84b78c`，不硬编码全部版本 |
| `+0x10` U32 | 请求fileId | `0x871778` |
| `+0x14` U32 | result：0成功、1无client处理、2拒绝；busy同2 | `0x871784` 与 `0x870418` 分支 |
| `+0x18` U32 | transferId；失败为0xffffffff | `0x871790` 与调用者参数 |

成功后 `0x870700` 设置busy并通知原厂DataTransfer base事件。后续provider `0x870a2c` 检查transferId匹配、offset小于expectedSize，再调用client VT+0x10原始read；offset+returnedLength超过expectedSize时调用client abort VT+0x20并返回0。offset等于expectedSize返回0结束，不在此处发送未经恢复的线路seek/retry。

`FileManagerIqpClient 0x750f9c` 固定白名单与raw byte Read `0x75124c` 已在 `DEVICE_FILE_CHANNEL.md` 精确记录。405=User p1linux、415=Factory p1linux。它只接受固定ID，不接受任意路径；因此无法通过此ID通道备份新hook文件的存在状态、内容、mode/uid/gid/xattr。

另一个需要准确区分的细节：read mode1分支传LinuxFileSystem open参数 `(writeFlag=0,rwFlag=1,syncFlag=0)`。`0x825ed4` 按这些参数使用OS flags **0x80002=O_CLOEXEC|O_RDWR**，不是O_RDONLY；client本次只执行read，不进入write分支。即使功能意图只读，底层fd模式仍可能需要可写挂载/权限，不能将它称为任何只读介质均可打开的接口。此信息与原厂文件权限/当前mount应一起验证。

## 精确阻塞与下一步

1. 相机fixedFileId二进制read、应答、传输provider已经有完整静态可达后端；缺的是公开原厂SDK对405/415的合法可调用入口和本机读取证据。SDK代理独立记录其host gate，不能据此写未知设备property。
2. USB outer与Common header部分字段已由读/构造双向指令确认；channel协商、版本、sequence、ACK/重传/flow-control、endpoint setup和认证当前状态未运行验证。不能拿本文拼未知包发送。
3. 合法SDK实际read405/415若可完成，应记录实机来源、长度、SHA-256、ELF版本与精确本地比对；之后单独验证其余将修改的配置元数据。不能因读取了Factory/User ELF而宣称所有可恢复备份完成。
4. 通道只在原厂应用运行时可用，不能解决应用无法启动后的独立恢复。Factory仍共享global hook；init_shell bypass候选物理激活与控制台操作未验证。持续部署前仍缺这个闭环。

复现本阶段字节/反汇编：工程根 `python3 tools/firmware/read_channel_collect_static.py`。这只访问本地文件并核对精确ELF哈希。所列结果全部为静态分析；主机协议模拟、临时实机与持久验收均未完成。
