# 原厂 FF.0 shell 的有限完成、输入借用与断开边界

**原厂 raw shell 存在完成回包契约，但断开只清 DevelopmentHandler 的 busy，不证明终止 OS 子进程。** 完整命令返回后，字符设备生成末片 flags2 或单片 flags3；随后清 busy。只有取得匹配关联 ID、连续片序号和末片的完整输出，才可以确认该次原厂 command-directory 调用已经返回。没有执行本合同、没有生成命令/payload/wire，没有读实际 EEPROM、PIN、认证 token 或访问设备。

输入为 `analysis/firmware/extracted/P1Linux_6.03.21.bin`，11,874,544 bytes，SHA-256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`。VA 只绑定此包 ELF；本项没有证明当前运行 User ELF 身份。Root 的独立 host-only 实測确认 FF.0 advertised/DevelopmentAgent present，仅证明主机对象存在，不证明认证或 shell。版本查询与认证见冻结 [DEVELOPMENT_PROTOCOL_QUERY_STATIC.md](DEVELOPMENT_PROTOCOL_QUERY_STATIC.md)，SYS parser/EEPROM path 见独立 [SECURITY_EEPROM_SYS_READ_CONTRACT_STATIC.md](SECURITY_EEPROM_SYS_READ_CONTRACT_STATIC.md)。Windows SDK owner/Start/Stop/Send/receiver 必须使用另一代理闭合的同版 Windows 契约，不以此 AArch64 ABI 代替。

## 接收、输入与 owner

| 边界 | 正向证据与限制 |
|---|---|
| Handler layout | ctor `0x862b40..0x862c60` 保存 Rx queue+20、Tx queue+28、协议+30、allocator+38；busy+44=0、character-device+48来自 caller stack 参数。不是可用于注入的全对象布局。 |
| Request branch | `0x863028..0x863204` 要求 payload+6 flags=3；非0 busy 会拒绝此次命令；payload+4 raw commandType=1，才调 `0x871e24`。只支持单片输入，不能把 SDK 允许传 blob 推成此设备支持分片。 |
| Declared input span | `0x871edc..0x871ef8` 读取 payload+c U16 dataOffset、payload+8 U32 dataLength；`0x871f4c` 保存 dataPointer到 character+8040，`0x871f5c` strnlen 以声明长度为上限并存 +8048。这不是接收buffer边界验证；offset/length必须由已闭合的原厂 sender 契约生成。 |
| Borrowing | 完整接收函数保存原始 pointer，没有在该有限支路看到 memcpy/retain。原始输入指针由后续 Getc 逐字节读取；不是 host callback 返回即可销毁的字符串。`0x863010..0x863014→0x85a29c→0x853320` 会在 handler 返回后 reset Rx event；event+10非空时调 `0x842b38`，再经 buffer+30 allocator virtual+10 release。allocator具体pool/refcount仍未闭合，不能断言 UAF，也不能假设该设备异步借用绝对安全。只串行、有限命令，实际验证是否完整读取输入；长命令/队列竞争不纳入已验收范围。 |
| Prefix source | Main `0x424688..0x4246a8` 将 VA`0x9f5c20`=`IqpDevelRaw` 传字符设备 ctor，随后 `0x424704..0x424710` 将全局 command-directory owner、同字符设备传 shell handler ctor。caller参数的精确链接独立 SYS 文档已闭合。 |
| Reader state | `0x872080..0x8720ec` 只在state1..4报告有数据。Getc `0x8720ec..0x872314` 顺序发固定prefix、一个space、输入字符、默认一个newline；ctor `0x871e10..0x871e14` 设置 append-newline=1。默认不需要再把末尾newline拼到host输入；本项未给实际输入文本。 |
| Zero length | Getc state3 在比对 index/length前先读 input[index] (`0x872234..0x872280`)。因此声明空输入不能仅凭strnlen=0当作无害 no-op；其实际reader/parser边界未验证。版本描述query独立消费1byte，是更先行的有限验证。 |

## 命令执行与完整输出

`IqpDevelopmentShellCommandHandler` ctor `0x872828..0x8728c8` 保存 command-directory owner+30、character-device+38，注册 command-id0。其 virtual Execute `0x8728c8..0x872a38` 在有第二个token时，将context调整到token1的借用pointer/remaining length (`0x8729ac..0x8729c8`)，再调用 owner virtual+a8 (`0x8729f0`)。该 owner 已由独立 SYS 文档绑定到 `0x73e1a0`。调用返回后才 `0x872a28→0x8725a4`，token缺失/未知id也走完成路径。

SYS 后端的 token parser 会把空格、tab、`=` 当delimiter并写NUL；double quote被移除，Sys重拼不加quote。因此命令合同不能照抄一般 POSIX 命令行。两层parser与借用pointer的影响必须按具体候选文本逐字验证；本报告没有生成EEPROM读取payload，也没有假设outer parse没有改写buffer。SystemCall 使用popen/fgets/格式文本输出，完整退出码不是shell最终回包的一部分，原件读取必须另有精确bytes数量与摘要验证。

| 输出字段/事件 | 精确链 |
|---|---|
| Buffer | `0x872314..0x872528` 从 `strlen(input)` 决定输出长度，并复制至字符设备+c起始的32768byte buffer。入参w2不是此函数使用的二进制长度。遇NUL会截断，不能直接输出raw EEPROM。 |
| Intermediate fragments | 每次buffer满在 `0x8724e4→0x863618` 发送一片；首片 flags1，之后 flags0；片序号 character+8021 自增U8 (`0x8724f0..0x872504`)。序号wrap/超长输出未验收，应保持有限输出。 |
| Final fragment | `0x8725a4..0x8726b0` 先state+8010=0；默认 flags2，如果还没有满buffer片（seq0）改 flags3。同一correlation+8020、seq+8021、有效dataCount+800c一并传回复；随后outputCount0并调用busyclear。 |
| Common reply type | `0x863618..0x8637c0` 在分配调用前固定w2=81 (`0x863664`)。它用原caller w2作为shell payload commandType (`0x863748..0x863764`)；caller w1=81只保存未被此完整函数读取。所以完成/中间回复都是 **Common ff/81，payload discriminator2、raw commandType1**。不能把Common标1或把payload commandType标81。 |
| Payload | builder `0x863aa0..0x863b3c`：+0 U8 discriminator2、+4 U8 commandType、+5 U8 correlation、+6 U8 flags、+7 U8 sequence、+8 U32 dataLength、+c U16 dataOffset20、+10 U32 total20+dataLength。`0x863778` 在默认flags3之外写本片flags。原厂外层协商header仍由allocator/Channel处理，此表不是手工wire格式。 |
| Output owner | `0x8637a4` memcpy到新分配原厂发送buffer，`0x8637b0→0x863570` 包装event11并入Tx queue；队列失败释放由查询文档精确窗口覆盖。不借用OS stdout或host buffer。 |
| Busy clear | 完成 `0x8726a0→0x8637c0` 仅清handler+44；传入correlation在该busyclear函数没有比较。因此必须在host回包接收端匹配ID，不能以busy本身作为身份认证或完成对应关系。 |

只有完整末片说明原厂命令调用已经返回；文字“失败”/“未知命令”也可以有完整末片。shell-handler最后的bool=true不等于 OS exit0。EEPROM完整原件仍需单独校验固定输出编码、范围、字节数量、双读一致与私有哈希；production dump字段不满足这个要求。

## 断开与取消的实际止点

Incoming receiver `0x862d5c..0x863028` 处理event16的有限分支仅在busy非零时记录日志并 `0x862fcc` 清busy，然后reset event。该分支没有字符设备state清零、popen进程句柄、kill/wait或OS取消参数。它不能证明通道关闭会终止已进入SYS的同步popen；也不能证明再次开通道后旧命令已消失。这里是正向完整有限分支，仍没有穷尽其他线程或owner析构行为。

字符设备的 Putb/XModem send/receive窗口 `0x872708..0x872828` 给出未实现日志或false，不能将其作为raw binary备份/恢复接口。停止host线程与停止设备subprocess应分开验收。下一次经Root授权的验证先使用已闭合描述query；shell只用经parser验证、输出有限、不等待交互的只读命令，等待完整末片后再Stop/cleanup，并记录身份/idle前后。若没有完整末片或出现callback/状态异常，该次不算原件备份，暂停依赖它的安全record修改。

本项允许精确逆向继续恢复原厂调用，不要求私有header或support为永久前提；当前具体未证是实际User版本、开发Open结果、Windows sender/receiver/Stop ABI、原厂输入pool寿命及有限shell真实回包。所有相机操作由Root协调的唯一Windows执行者完成，本项仅保存可复核静态合同。
