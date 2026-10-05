# FF.0 原厂描述查询与独立认证：设备侧窄合同

**本包 DevelopmentHandler有一个不进入 shell 的描述查询支路：Common class ff/type1，development payload首字节1。** 完整支路仅分配、清零并构造8字节回复，然后进入原厂发送队列。回复 Common type81，payload首字节1、+4为1、+5为0，其余字节为0。分配标记明确为 `DevHandlerProtoVer`；因此按协议版本描述记录，不将+4/+5冒认为 shell/EEPROM/ReadMemory能力位。

本项纯离线。输入 `analysis/firmware/extracted/P1Linux_6.03.21.bin`，11,874,544 bytes，SHA-256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`。所有 VA绑定这个 ELF。当前实机 User ELF哈希仍未由本项确认；Root的独立host-only实测已观察FF.0 descriptor和匹配原厂vtable的DevelopmentAgent，其证据等级仅为广告/主机对象存在，未证明打开/认证/执行。

没有加载 SDK、连接设备、生成或发送payload/wire、试认证、读取实际码/token/EEPROM或写任何记录。本报告给设备接收字段和正向支路，不给手工wire。Windows原厂Start/Stop/Send/多态receiver ABI由SDK代理独立绑定固定PE；不得用本固件地址或LinuxSDK布局调用Windows方法。

## Native query消费与回复契约

| 边界 | 精确证据 |
|---|---|
| Incoming Common message | `0x862eac..0x862f28` 要求 +4 U8=ff、+5 U8=1；+6 U16为payload相对Common的offset，经相加传`0x8637e0`。这是已解析内存中的字段，不是外层USB封包offset。 |
| 查询与shell严格分支 | `[0x8637e0,0x863960)` 只在入参payload+0读U8。值1到`0x863828`；值2到`0x863028`的shell；其他值走错误文本。查询分支没有读取payload+4命令、关联ID、offset、长度或命令文本。 |
| 已消费输入范围 | 查询分支消费且仅消费payload首字节，最低有效内存跨度1 byte。没有证据支持必须提供任意8字节request结构，也不能从8字节response倒推出request大小。外层协商header/完整消息长度/transport所有权由原厂SDK sender和Channel契约处理；本报告不擅自补结构或封包。 |
| Reply allocation | `0x863838..0x86384c` w3=8（payload长度）、w2=81、buffer tag VA`0xda4060`=`DevHandlerProtoVer`，调用`0x863280`。 |
| Cleared buffer | `0x863304..0x863324` 对buffer raw pointer和实际容量调用memset0，先于header和payload构造。不能把未写字节称为泄漏数据。 |
| Reply payload | `0x8638c0..0x8638e0` 用builder返回payload偏移，构造8byte区；`0x863a68..0x863a94` 写首字节1、+4=1、+5=0。+1..3/+6..7由先前清零保留0。 |
| Reply Common | `0x863388..0x8633a4` caller messageType81、payload起始版本/长度由`0x863b3c`取协商表；`0x863b70..0x863b78`给Common class ff。`0x84b73c`写marker与class/type/offset/size。不能固定为硬编码Common header16/USB外层长度。 |
| Ownership / failure | `0x8638e4..0x8638ec→0x863570` 把buffer包装event11给Tx queue virtual+30。`0x8635dc..0x863608`队列失败才本地释放；成功后的发送owner由原厂queue/transport管理。无借用buffer外泄给调用者。 |

查询支路没有进入 command-directory、LinuxCommands、popen、PinCodeEventGroup、SystemStorage或SecureCommand。这个**完整有限支路**的正向观察不排除外层Channel创建、日志、队列/原厂generic回调的其他作用，也不证明实际设备与本包一致。

`DevHandlerProtoVer`及构造常量支持把回复+4/+5当版本字段候选（1.0），正式私有枚举/语义仍以实测和双方原厂契约为准；它只确认能回描述，不验收 EEPROM备份或恢复。不要把“回复可构造”升级为“已取得回复”。

## Development认证是另一对象，不能拿GUI PIN尝试

已冻 [Execution channel](EXECUTION_CHANNEL_STATIC.md) 的Main→factory→manager→state链在此重取精确窗口。UsbDevel group由Main `0x41a590..0x41a5b0` 创建，与UsbNormal分开。USBfactory参数Main `0x424fe0..0x424fe4` 经factory+150、FF branch`0x85db78..0x85db88`传至manager，再至state+2b8。group+8名`IqpAuthIsRequired`，group+e0名`IqpAuthDigest`；它不是PinGroup Locked/PinCode/Fails。

`0x851d44..0x851d7c` 从state+2b8 group+8读required；true才在`0x851fac..0x852094`取group+e0并与Open request outer+22的32byte token比较；不匹配设置本次open结果6。group+8构造默认false（`0x664004..0x664014`），但独立配置加载可覆盖，默认绝不能证明这台设备当前无需认证。没有读取current required/token。

state+2c0另存allow-connection bool（`0x8512c8..0x8512d0`），FFfactory参数来自factory+a8 (`0x85db7c..0x85db84`)；`0x852098..0x85213c`若该bool存在且false则本次open拒绝。它不能混同authentication group，更不能通过写allow bool绕过。

本次完整认证比较支路只有读取认证group和返回open状态，没有调用UI EnterPin/SetPin或累加PinCodeFails；仍保留outer state/log/event全部回调与真实版本的边界，不作全局排他证明。正常SDK现有token的合法一次通道Open、成功/失败及Stop/cleanup应由Root决定和记录；本报告不生成密码/token、不关闭required、不改connection配置，不把空值/常量当“默认PIN”尝试。

## Shell / EEPROM后续只读合同的边界

只有payload2另到shell，且`0x863044..0x863054`要求flags=3（不支持输入多片），`0x8630d8..0x8630fc`要求commandType1 raw。`0x871edc..0x871f6c`读取dataOffset U16、dataLength U32，用strnlen限于声明长度，并保存输入pointer、关联byte和命令状态。其异步借用输入buffer、完成通知、取消/断线生命周期仍需闭合后才给执行者可调用的shell合同；不得把query支路直接扩成任意发送器。

原厂Linux sys后端已静态存在，production dump只是解码字段文本，managed-file白名单没有System EEPROM raw入口。完整System `[0x400,0xc00)`原件必须证明path实际存在、只读范围、短读/输出编码不失真、接收结束/摘要及私有保存。独立 sys/parser/EEPROM路径helper正在窄查。恢复写还需要字节备份和有限字段的可验证写回/退出恢复，不由本query免除。

下一可逆验证是：使用固定Windows原厂owner/ABI，先Start及独立Open结果；确认取消/Stop后再只执行这一协议描述查询，保存类型/长度/常量对照并通过身份/idle/cleanup。这一顺序不要求用户提供私有头文件或现成通道，但每步仍由已恢复的二进制契约与实测决定。当前没有执行这一步，Root为唯一设备协调者。
