# F4 LV 尺寸协商：1024 上限、回传字段与实际帧尺寸

本精确原厂 ELF 的 `IqpLiveViewHandler` **存在显式 1024 配置上限**：配置请求的尺寸值取 `min(request,1024)`，进入 LV engine，配置响应返回同一个协商值。实际输出帧宽高另从已锁完成槽读取。这个静态结果支持“原厂配置协商将1920限制为1024”的解释，强于仅凭运行结果猜测动态带宽降级；尚未证明本次设备收到1920请求，或 SDK getter 的更新恰好来自这个响应。不能把它写成1080p、源 FPS 或机内录像的验收。

根执行者报告 JPEG Prefix0：订阅前 PreferredMaxDimension=1024，setter1920后以及 Subscribe(JPEG)刚结束时 getter=1920；采集结束前 getter=1024，主要输出1024×764。此运行观察与下述异步协商路径相容，但请求/响应日志、SDK字段映射及设备正在运行的 ELF 身份仍由独立证据确认。161次交付也不能提升为161张新源帧。

全部为离线静态指令/原字节分析。未加载或初始化 SDK、连接相机、调用设备 API、发送命令、写寄存器、改变属性、安装代码或生成设备封包。

## 输入与复现

仅使用 `analysis/firmware/extracted/P1Linux_6.03.21.bin`：11,874,544字节，SHA-256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`，来源包显示6.03.18、内部模块名6.03.21。全部地址为本模块链接 VA，代码/rodata 文件偏移=VA−`0x400000`。新读取的另一份 Factory ELF 没有混入本文；这些地址不能跨 Factory/User 版本使用。

工程根运行 `python3 tools/firmware/f4_dimension_collect_static.py`。collector 验证精确输入及3份冻结引用，生成25个窄指令窗口、3个原字节表与独立 `F4_DIMENSION_NEGOTIATION_SHA256.json`；不更新已有 manifest。`f4_dimension_static/exact_bytes.json` 保存每个窗口的完整原始hex、偏移及哈希。objdump 的最近符号标签不用于命名 stripped 私有函数。本文函数名来自已有来源字符串/链条或明确的描述性候选名，均非可调用 ABI 的动态验收。

## 1. 三种 header 不可混用

下表偏移都是相应 header 的起点，不是整个 USB 包、设备传输对象或 SDK C++ 对象的起点。外层 framing、路由与端点契约不由这些偏移构成。

| 本地解析/构造结构 | 字段 | 对应 handler 存储/来源 | 意义及限制 |
| --- | --- | --- | --- |
| LV capabilities Common | `+0x04` U8 / `+0x05` U8 | class `0x69` / response type `0x81` | `0x86d1dc..0x86d1e8` 构造。 |
| LV capabilities Common | **`+0x1c` U32** | `handler+0xd6c`，capabilities base=`handler+0xd50` | ctor写1024；是本路径的最大尺寸上限。不是 configuration `+0x24`。 |
| LV configuration Common | `+0x04` / `+0x05` | class `0x69`；request type3 / response type`0x83` | dispatcher与response ctor分别确认。 |
| LV configuration Common | `+0x14/+0x18/+0x1c/+0x20` U32 | `handler+0xd9c/+0xda0/+0xda4/+0xda8` | crop x/y/width/height。不是输出像素宽高。 |
| LV configuration Common | **`+0x24` U32** | `handler+0xdac`，configuration base=`handler+0xd88` | 请求尺寸及协商后尺寸；响应copy同字段。 |
| LiveViewImageHeader | **`+0x1c/+0x20` U32** | `LiveViewAccess::locked-size` 返回二元组 | 当前已锁完成槽的有效width/height；与上两种 header 中同偏移不同义。 |

原厂入口在 `0x84c178` 返回 Common 指针后先检查 class`0x69`（`0x86a290..0x86a2b0`），再进入 dispatcher。response Common构造器`0x84b73c`对传入class/type使用byte存取，`0x84b768/0x84b774`分别写Common+4/+5，故上游w2负数立即数的低8位明确成为`0x81/0x83`。本文不复建任何未知外层报文。

## 2. 请求接收、显式 clamp 与回传

| 步骤 | 本版指令证据 | 确认范围 |
| --- | --- | --- |
| 分派 | `0x86a3a8..0x86a3b4` 检查Common+4=`0x69`。Common+5为1→`0x86a588`能力响应，2→`0x86a7d4`配置响应，3→`0x86ab10`配置请求；type3返回true时在`0x86a47c`再次发送配置。 | 内部parsed Common契约；不是 `Subscribe()` 公共API原型。 |
| 初始化上限 | `0x8699a8: mov w1,#1024`；`0x8699ac: str w1,[this,#0xd6c]`。 | 本 handler 固定能力值。 |
| 初始化配置 | `0x86aa2c..0x86aa30` 默认 `handler+0xdac=1024`；不支持LV的分支`0x86aaeC..0x86aaf0`将该配置置0。 | 默认值也是1024；不是先640再由带宽增加。 |
| 前置验证 | `0x86ab28..0x86ab40`检查cameraCapabilities+8；`0x86ab7c..0x86abe8`检查crop末端不超过source bounds且width/height>9；`0x86ac24..0x86ac94`检查format和component支持mask。 | 这些验证通过后才进入尺寸clamp；仍需正常LV owner，不能盗用client。 |
| 请求clamp | `0x86acf0`取Common+`0x24`；`0x86acf8`取handler+`0xd6c`；`0x86ad04`调`0x4335e8`；`0x86ad10`存结果到`+0xdac`。 | 无JPEG/RGB格式分支，也没有本窗口带宽测量输入。 |
| min语义 | `0x4335f8/0x433600`加载两个U32；`0x433604`比较；`0x433608 b.ls`返回第一指针，否则返回第二。 | 严格unsigned-min reference helper；无需依赖错误的最近符号名。 |
| 发给engine | `0x86bc68`读取`+0xdac`；`0x86bc70 w4=0`、`0x86bc74 w3=value`，`0x86bc78 x2=Rectangle`、`0x86bc7c w1=client`、`0x86bc80 x0=access`；`0x86bc84`调`0x6b639c`。 | dimension是SetConfig第四参数w3，不是Surface尺寸。 |
| access转交 | `0x6b63bc..0x6b63cc`验证owner/client；`0x6b641c`将bool传w3，`0x6b6420`将dimension传w2；`0x6b642c`调engine`0x7975d0`。 | 不绕过owner gate。 |
| 配置响应 | `0x86a8e4`构造class69/type83；`0x86a8f0`取handler+`0xd88`，`0x86a8fc`调copy`0x86d52c`；`0x86d57c..0x86d588`逐字复制Common+`0x24`。 | 该返回值是 `min(request,1024)`，并非反读当前width。 |
| 能力响应 | `0x86a698`构造class69/type81；`0x86a6a4`取handler+`0xd50`，`0x86a6b0`调copy`0x86d434`；`0x86d474..0x86d480`逐字复制Common+`0x1c`。 | 同一1024上限可由能力响应传播。 |

有一个**配置应用 debounce**：`0x86af80..0x86afb0`将软件clock与handler+`0xc58`相减，elapsed≤99时arm handler+`0xb68`，参数100，返回false；否则stop该timer，调用`0x86bb64`并返回true。它可能影响配置响应/应用时序，不能解释成“JPEG源帧10fps”或动态dimension降级。本阶段不恢复整个timer事件重试状态机。

collector 附带仅限 `0x869584..0x86dbb0` 的直接U32/float load/store立即数模式清点：`+0xd6c`仅在ctor出现直接store；`+0xdac`见默认1024、unsupported置0、min结果store及engine参数load。该扫描不覆盖别名、按指针copy或间接写入，不能用来声称运行时值永远不可改变。

## 3. dimension与实际像素尺寸不是一回事

engine `0x7975d0` 保存w2为w25，读取Rectangle width/height计算aspect。在横向分支`0x797630..0x797640`先取width=maxDimension、height=floor(maxDimension/aspect)；纵向分支`0x7977b4..0x7977c0`取height=maxDimension、width=floor(maxDimension×aspect)。随后进行原厂sensor mode/rect变换。Iqp传入bool=0时，`0x797744..0x797750`以变换后的crop尺寸再次取较小值，`0x797754/0x797758`用`AND #0xfffc`限制U16范围并向下对齐4，保存pending width/height到engine+`0x47b8/+0x47bc`。输入maxDimension单独保留在`0x797770`的engine+`0x47c4`。

因此，即使协商dimension=1024，实际width可以小于1024，height取决于crop/aspect及模式变换。1024×764与这种缩放/四像素对齐方式相容；没有恢复本次设备crop输入，不能据此精确反推传感器aspect或断言一定得到764。

实际发送帧头走独立已锁缓冲链：`0x86b728`先经`0x6b618c`锁住合法owner的完成槽；`0x86be44`调用`0x6b61fc`取得尺寸，返回packed二元组，在`0x86be4c/0x86be54`拆出width/height；`0x86c088..0x86c098`分别写LiveViewImageHeader+`0x1c/+0x20`。`0x6b61fc→0x6b6d44→0x6b6b70`最终从VideoBuffer+`0x50+8*lockedIndex`返回二元组。没有从handler+`0xdac`直接填这两个实际帧字段。

原厂生产者写槽的元数据来源已冻结：`0x787838..0x78786c`读取field ID `0x1a6`得到width，height取field`0x1a7`与pending config+`0x5c`较小值，写对应槽。field ID不是物理寄存器地址或已恢复的硬件官方名称。锁与元数据、warmup/未发布分支、软件ID不能冒充硬件新帧证明，继续适用 `F4_SOURCE_EVENT_STATIC.md`。

## 4. 640路径与发送等待边界

冻结原厂UI证据 `f4_ui_static/lv_start_stop.disasm.txt` 中，**本地LV control** start`0x5202a0`的`0x520364..0x520378`构造640×480临时Rectangle；`0x5203ec..0x52040c`把其width=640作为SetConfig w3，bool w4=1，传给同一LiveViewAccess。这是已有本地显示consumer的配置来源，**不是**本文IQP请求中的1024cap字段，也不能仅凭共享engine推出SDK一定受640限制。哪个owner活跃、实际配置是否相互切换，需运行证据。

窄查顺路确认一个普通发送等待属性：ctor`0x8696e8..0x869704`在handler+`0x890`构造名 `IqpLiveViewHandlerWaitingTime`（rodata`0xda5ce0`），参数w2=0、w3=1；handler+`0x970`是名 `IqpLiveViewHandlerWaiting` 的timer。frame事件分支`0x86c6f8..0x86c71c`读timer state，值1则本次不送；若其他原厂发送gate允许且属性getter`0x414b28`非零，`0x86c754..0x86c770`将属性值传timer arm`0x715948`，再于`0x86c780..0x86c7a0`调用原厂发送状态虚方法。此处未按JPEG格式区分，也未发现固定12、83或84的参数；属性当前配置、timer单位和完整重试/transport backpressure状态未验收。不能由默认参数0推断真机无节流，更不能推断真实JPEG源帧率超过官方说明。

## 5. 最小验证契约及止点

下一步应继续使用原厂SDK允许的日志/返回读取，把同一次连接中的 **请求dimension、capabilities dimension、配置响应dimension、SDK getter更新时间、每帧实际width/height** 分开记录；需要同时保留订阅前/后及清理状态。SDK代理负责公共API getter/缓存的host字段映射，本材料不重复host研究，也没有提供未知wire packet。

若日志确认本次请求1920、设备class69/type83的Common+24回应1024、host随后将PreferredMaxDimension缓存更新1024，就可将本次行为判定为这条显式协商clamp。若请求根本没发1920或host被别的响应刷新，原因要按日志修正；不能凭静态链删除动态降级等尚未排除的解释。

F4机内实现若走原生producer接口，应独立协商自己的合法owner与配置，读取逐帧实际尺寸/stride并验证源内容和新帧，而不能将SDK1024 cap当作传感器/编码器绝对硬件上限。提高该cap、改原厂函数或盗用本地owner都没有在本阶段授权为已可部署方案。临时实机和持久验收均未进行；仅静态协商、回传与尺寸字段的数据流完成。
