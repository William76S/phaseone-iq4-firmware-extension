# IQ4 execution / metadata channel：公开边界与内部静态链

**本轮没有确认一个可以交给执行者运行的公开 SDK shell、OS 文件元数据或临时扩展入口。** 官方 Linux static archive 保留完整 development agent；Linux shared 还导出一个内部 camera accessor。它们不等于公开、已可用的入口：缺私有 transport owner、对象/回调 ABI、当前 FF.0 advertisement、合法 development 认证与内层 shell 消息契约。Windows 两个 DLL 不导出这些 development 方法。本轮仅解析本地文件，没有加载 SDK、初始化连接、打开设备或构造/发送命令。

这是一份窄查增量；固定文件二进制读回仍以 `DEVICE_FILE_CHANNEL.md` / `FILE_READ_TRANSPORT.md` 和 SDK 代理的 `analysis/sdk_reference/DOWNLOAD_FILE_STATIC_PATH.md` 为准。它们被冻结，未修改。F4 图像、编码、页面与卡接口材料也未修改。

## 输入与地址域

| 输入 | SHA-256 |
| --- | --- |
| 精确应用 `P1Linux_6.03.21.bin`，来自用户指定 6.03.18 `.fwr` | `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb` |
| 官方 SDK 3.2.5 Linux `libCameraSdkCpp.so.3.2.5` | `fc94f19ed5bebfd4db61906dce529c1c57e360d9cc6eb02f3da33dcbf708c3e4` |
| 官方 SDK 3.2.5 Linux `libCameraSdkCppStatic.a` | `3754ed25d9d98b8da8a7648d011d2904be82f824144c9ae366af1aa98692dde2` |
| Windows `CameraSdkCpp.dll` | `f395aa33ee5a44626d8050c63953efb9f113970330aa3a3ad5670176868c3891` |
| Windows `CameraSdkCppBindingsForCs.dll` | `5c6c4dee07f145ea68f573a72027690fadd5f10ad1e60b33d3fb42e34d4e00c2` |

`execution_channel_static/exact_bytes.json` 将每个窗口绑定输入、文件偏移、原字节和字节哈希。**archive offset** 是 x86-64 `.text` 节内偏移；**shared VA** 是主机 ELF 的链接地址；**firmware VA** 是 IQ4 AArch64 ELF 的链接地址。三者不得混用；没有测量 ASLR、相机运行映射或完整对象 ABI。私有“最近导出符号+偏移”标签不作为设备函数名称证据。

## 公开面：准确区分“无声明”“无导出”和“内部导出”

collector 逐个哈希/检索 Linux、Windows 各18个官方 `.h/.hpp`，保留完整 Linux 动态/静态符号清单及 Windows PE named exports（C++ 474、C# bridge 389）。搜索名称与每文件结果在 `public_api_coverage.json`，不是靠 strings 猜测。

| 层 | 本轮观察 |
| --- | --- |
| 官方 public headers | 没有 `IsDevelopmentSupported/StartDevelopment/StopDevelopment/SendDevelopmentMessage/SetDevelopmentReceiver/SetDevelopmentAuthenticationPassword` 的声明；也没有 `ExecuteCommand/ReadMetadata/GetFileStat/GetMountInfo` 或私有 `P1::IQP::Camera` access 的公开声明。`P1CameraCamera.hpp:95–98` 的 `mImpl` 是 private，只把 `CameraPimpl` / `Notifications` 设为 friend。 |
| Linux shared 动态导出 | 上述 development 方法与 `DevelopmentAgent` 没有 T/t 导出；有 `IqpLibTransport::GetCamera(int,P1::IQP::Camera*&)`，VA **0x94c10**，及 `IqpLibTransport` ctor。也有内部 `CameraPimpl::GetIdFromCamera`，VA **0xa9720**。**不能把内部 accessor 漏记，也不能把它叫 public API。** |
| Windows C++ DLL、C# native bridge | 上述 development 方法和 `DevelopmentAgent` 的 named exports 均为0；也没有 `IqpLibTransport::GetCamera` 的命名导出。仅搜索到 image/LV 参数类型中的 IQP 名称不构成 development method。 |
| Linux static archive | `IQPCamera.cpp.o` / `IQPDevelopment.cpp.o` / `IQPChannel.cpp.o` 保留相关全局 T 符号及重定位，可被私有桥接研究复用。archive 中“全局 T”不是 shared 导出、公开头文件或安全可调用完整 ABI。 |

公开 `CameraPimpl::RequestMetadata(unsigned imageId)` / image metadata 只描述图像；`PropertySpec` 只描述相机属性。它们不接受 OS 路径，不能提供拟写扩展文件的 uid/gid/mode/xattr、symlink、不存在状态或当前 mount。公开 `DownloadFile` 仍接受固定 FileId，不是任意路径的 stat/read channel。

内部 accessor 的**已观察而未批准的契约**：archive `IqpLibTransport.cpp.o+0x1d60..0x263d`，输入 `this`、int handle、`IQP::Camera*&` output；锁 `this+0xc10` 并在该 transport 的 connection map 查 handle，成功从 node `+0x30` 取 pointer，`+0x24c5` 写 output，没有本窗口中的 AddRef/ownership transfer。必须使用拥有该 connection 的同一 transport，不能新建一个对象后拿别处的 handle，也不能在 close/erase 后使用 pointer。官方 headers 没有给出获取该 owner 的接口。`GetIdFromCamera` 是内部 helper，不授权读取 private layout 或混合不同 SDK 实例/版本对象。

作为排除检查，shared `CameraSdkC::Test(int)` 的 `0x825f0..0x82630` 只选择错误文本并调用 `CameraSdkError::Error`；这里没有发送 development/执行命令。不能因方法名 `Test` 就当作无害执行入口。

## Host development agent：创建、启停、回调与认证

下面偏移均相对**指定 archive member `.text`**；函数参数名字由 demangled symbol / 指令支持，返回类型不能从 Itanium mangling 自动恢复。

| 私有方法或步骤 | 精确证据 |
| --- | --- |
| 是否存在 agent | `IQPCamera.cpp.o+0x5570` 的 `IsDevelopmentSupported()` 只在 mutex `camera+0x4b0` 下检查 `camera+0x4d8 != null`。没有向设备查询/完成通道认证；true 不能验收 shell 可用。 |
| 创建 FF.0 | `Camera::Open` 在 `+0x73f8` 比较 transport descriptor `+0xc==0xff`，`+0x73fe` 比较 `+0xd==0`，并检查 `+0x18` transport pointer。命中后 `+0x7447` 分配0xf20，`+0x7460` 构造 `DevelopmentAgent`，`+0x7473` 保存到 `camera+0x4d8`，绑定协议版本与 receiver。**设备必须先公布 FF.0；当前设备是否公布未读到。** |
| FF.0 channel | `IQPDevelopment.cpp.o+0x679..0x688` 调 `BaseAgent` 时 channelId=0xff、subId=0；`IQPAgentBase.cpp.o+0x40..0x5e` 把这些值传到 `Channel` ctor。 |
| 启动 / 停止 | `Camera::StartDevelopment +0x55d0` / `StopDevelopment +0x5660` 仅把现有 agent 转给其 Start/Stop。`DevelopmentAgent::Start +0x1ab0` 先 Stop 再在 `+0x1b01` 调 `Channel::Open()`；只有成功才建立收发线程。此时不是“已有 USB 连接便可发”。 |
| 发送 | `Camera::SendDevelopmentMessage +0x5820` 输入 U8 messageType、const void* data、U32 length；`+0x58c0` 转发 `DevelopmentAgent::SendMessage`，timeout=0xffffffff。后者 `+0xcb0..0xd2a` 要求两个线程都运行，并拒绝非零 length 配 null data；转 `SendAsync_Message`。没有实际送达/设备执行返回值可由 wrapper 直接验收。 |
| 缓冲复制 | `IQPDevelopment.cpp.o+0x9fb` 分配 negotiated-header-size + dataLen；`+0xa07..0xa23` 写 Common development header class0xff / caller messageType；`+0xbcd` memcpy caller data 到 header+0x10，进入原厂队列。它只生成 development Common header，**没有构造 shell raw 的内层 message fields、分片/关联或文本命令**。本文不给可发送封包。 |
| 接收器 | `Camera::SetDevelopmentReceiver +0x56c0` 接收 `P1::Universal::FunctionPointer<void(U8,const void*,U32)> const&`，clone其多态 callback object，而非三参数 C function pointer。`DevelopmentAgent` 接收 `+0x535..0x53d` 传 length / data / type 给 receiver VT+0x10，随即销毁本地 buffer，`+0x558` 的 delete 表明数据只在 callback 内借用，不能留存裸 pointer。普通公开 Listener 不代替此 receiver。 |
| 独立 host token | `Camera::SetDevelopmentAuthenticationPassword +0x1880` 经 `Channel::GenerateAuthenticationToken` (`+0x18e0`) 保存32-byte token到 `camera+0x2c8`，再更新 development BaseAgent。普通密码保存区域是 `+0x2a8`；二者分开。`IQPChannel.cpp.o+0x170` 对非空密码使用 strlen / SHA-256；空值产生零 token。没有查询、猜测或设置任何密码/token。 |
| 公开 open 路径 | `IqpLibTransport.cpp.o+0x91d0..0x97b0` 的 `OpenCameraFromMoniker` 在 `+0x9236` 只调用普通 `SetAuthenticationPassword`，随后 Initialize/Open；没有调用 development password setter 或 StartDevelopment。因此成功公开连接不证明 development channel 已打开。 |

`Channel::SendOpenRequest +0x990..0xab0` 使用原厂 channel/token/协议内容及 `WritePacket`，`HandleOpenReply +0xd50` 检查 openreply result 后才改变通道状态、登记协商版本。这里复用原厂 transport/认证状态机的方向有证据，但 transport ownership、callback C++ ABI、实际版本协商、线程取消/重连、设备合法认证均未验证；不能凭这些 member offsets hand-declare 一个类然后调用。

## 设备 FF 通道的完整认证指针链

下面是 firmware VA，全部有逐指令窗口与原字节。需要更正一个容易混淆的字段：factory **+0x150** 才流向本链的 authentication group；factory **+0xa8** 由配置传入允许连接的 bool，不能将其标为认证 group。

1. `0x41a570..0x41a5f0` 分别创建4个 `0x2e0` authentication group，ctor **0x663fc8**，name string `0x9f45a0=UsbNormal`、`0x9f45b0=UsbDevel`、`0x9f45c0=EthNormal`、`0x9f45d0=EthDevel`。Main locals分别在 `sp+0x1b70/+0x1b68/+0x1b60/+0x1b58`。
2. Ethernet factory ctor调用 `0x424d78` 前，`0x424cf4..0x424cf8` 把 **EthDevel** (`sp+0x1b58`) 传到 caller `sp+0x78`；USB factory ctor调用 `0x425064` 前，`0x424fe0..0x424fe4` 对 **UsbDevel** (`sp+0x1b68`) 同样传入。相邻 `sp+0x70` 是对应 Normal group。
3. factory ctor **0x85cb64** 的 `0x85cd54..0x85cd58` 把入口 stack+0x78 保存到 **factory+0x150**。`0x85cd48..0x85cd4c` 把入口 stack+0x70 的 Normal group 保存到 **+0x148**。这两个 group 是不同参数，不能沿用普通密码。
4. FF branch：`0x85d178..0x85d17c` channelId0xff → **0x85db34**；`0x85db78` 取 factory+0x150，`0x85db88` 传到 stack+8，再在 `0x85dbb0` 构造 **ChannelManager 0x85bd0c**。`0x85d0b4..0x85d0c0` 将此 manager 保存 bundle+0x48；lookup **0x875300** 的 FF branch `0x875478..0x875480` 正是取 bundle+0x48。
5. ChannelManager `0x85bf30` 取自己的入口 stack+8 给 x7，`0x85bf50` 构造 state owner **0x8510f4**；该 ctor在 `0x85111c` 保存 x7，`0x8512c0..0x8512c4` 写入 **state+0x2b8**。
6. OpenStateGate **0x851c3c** 的认证窗口 `0x851fac..0x8520c0` 对这个 group+8 通过 bool getter判断required；required=true才取group+0xe0的32-byte token，与 open request token 比较。不匹配设置结果6并拒绝打开。完整一般open/version/flags/flow约束仍见冻结 `FILE_READ_TRANSPORT.md`。

group ctor `0x663fc8` 建立 required/token 配置对象，但 constructor 默认值不能替代随后配置加载和当前设备值。本轮没有读取 `UsbDevel` / `EthDevel` 的实时 required/code/token，更没有关闭认证、写allow bool、使用FACE1绕过文件下载主机gate或构造自定义 USB open。FF lookup在本窗口不检查subId，并不意味着允许绕过manager中的subId/version要求。

## metadata / volatile execution 到达哪里、在哪里阻塞

| 目标 | 本轮可证实部分 | 缺少的必要条件 |
| --- | --- | --- |
| 回读原厂 User/Factory ELF | 固定 FileId 405/415 的 binary backend/SDK内部Programming路径已存在。 | SDK合法开放条件与真实读回文件；文件字节不包含新hook/adapter路径元数据。 |
| 读取 uid/gid/mode/mount、路径不存在状态 | development shell的本机Linux `sys` 后端存在：`0x862d5c` Common classff/type1 → `0x8637f4` development payload2 → `0x8728c8` command-directory → Linux command id1 → `0x778244`。`0x778288` popen、`0x7782e0` fgets、`0x778364` callback、`0x778394` pclose。它理论上可产生文本诊断，证据等级仅为静态。 | 公开/私有合法host入口、当前FF.0公布、单独认证、内层命令契约和稳定回送；**没有实际文件元数据或mount输出**。文本/NUL链不能当完整二进制备份。 |
| 不依赖持久hook的临时运行扩展 | 本机shell后端能调用OS command；并未找到 SDK提供任意代码缓冲执行、dlopen/load-module或任意路径binary上传的公开contract。 | 扩展原件路径/元数据、合法送入RAM/临时文件及启动/停止方法、权限、独占控制、退出恢复、干净帧source/原生UI/卡backend。 shell后端存在不等于这些已经满足。 |
| 应用/hook损坏后恢复 | Boot原始 `init_shell` 2/3分支可静态绕过普通rcS/global hook，已冻结记录。 | 物理激活、控制台可达、真实故障退出恢复。运行中原厂IQP channel依赖应用存活，不能作为应用起不来的独立恢复。 |

可供下一阶段决策的是：优先取得 Phase One 提供的 development/private SDK headers/合法诊断入口及认证支持，或其他已验证只读原厂入口；然后只读检验FF.0、元数据和读回原件。不要将私有符号存在、普通SDK认证成功、某个FileId传输成功或静态init_shell分支等价成部署前置已通过。没有生成猜测的shell payload、内存跳转器、注入安装物或设备测试脚本。

## 重现与层级

工程根运行 `python3 tools/firmware/execution_channel_collect_static.py`。脚本校验5个精确输入、从GNU archive提取5个对象用于**本地**反汇编、保存34个字节窗口、两平台36份header覆盖和Windows export tables。原始对象是私有中间物，不放入源码/安装物；不需要运行SDK或访问相机。目标函数列表 `execution_decompile_targets.txt` 只供已有Ghidra辅助阅读；无需反编译也能重现本文指令结论。

`EXECUTION_CHANNEL_SHA256.json` 绑定本报告、collector、targets与证据；每行rstrip、文本单EOF以保证 `git diff --check` 和重现哈希一致。结论等级：**静态分析已完成；主机只验证本地解析/哈希；临时实机未执行；持久验收未执行。**
