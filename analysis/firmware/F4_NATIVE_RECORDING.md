# F4 原厂机内录像接入：静态证据与执行边界

本文件只记录本地固件的离线指令分析。没有执行目标函数、相机控制、写卡、注入或部署；没有通过机内录像验收。主机录像源码的通过结果由根执行者另行记录，不能提升本文件的证据层级。F2/F3 暂缓。

## 输入及复现

| 项目 | 精确绑定 |
| --- | --- |
| 原始包 | `Firmware-BP-IQ4-IQ4_6.03.18.fwr`，78,351,289 字节 |
| 原始包 SHA-256 | `a52758ffb163023e5323297e450450f91002175b69bed7590fe2cd037c2ab300` |
| 分析模块 | `analysis/firmware/extracted/P1Linux_6.03.21.bin`，11,874,544 字节 |
| 模块 SHA-256 | `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb` |
| 模块 | ELF64 little-endian AArch64 ET_EXEC；Build ID `1f451370d713ae1f341e9d5de5615717f9fb36ed` |
| 地址 | 表中为链接 VA，不是经运行验证的对象地址；代码/rodata 文件偏移 = VA − `0x400000`，初始化 data 偏移 = VA − `0x410000` |

现有工程的模块名 6.03.21 与包显示版本 6.03.18 同时记录，不能跨版本移植地址。原件未修改。复现：在工程根运行 `python3 tools/firmware/f4_collect_static.py`。它先拒绝未知模块哈希，再保存原始字节、独立反汇编窗口及哈希清单，不执行固件。`f4_static/exact_bytes.json` 包含每个窗口的完整 hex 字节和原始文件偏移。反汇编器最近的 C++ 符号名不是 stripped 私有函数的真实名字；以下角色按调用与内存访问推导。

`decompiled_f4*` 是辅助伪代码，明确保留未知类型。Ghidra 在尾跳转、间接调用和未分析结构上可能漏流；指令窗口是本阶段结论依据。复现伪代码可用已有 `tools/firmware/DecompileIQ4.java` 和三个 `f4*_decompile_targets.txt`，新输出目录与已有成果分开。

## 最短候选路径及当前门槛

同一个合法 LV owner → 原厂锁取得合成前视频 CPU buffer 和对应元数据 → 在锁内快速拷贝到独占、有上限的池 → 立即释放原厂锁 → 工作线程作已验证裁切/缩放和独立 JPEG 编码 → MJPEG 容器 → 经原厂存储 lease 协调的实际卡后端 → 原厂页面事件启动/停止/退出收尾。

此路线是静态候选，不是已存在的可执行扩展。它不读取 UI `Surface` 像素，不开启第二个争用 LV 的客户端。候选优先 MJPEG 是因为找到 RGB24 JPEG 编码器；本阶段没有证明 H.264 编码入口可达，没有证明任意机内分辨率/帧率，尤其没有证明 1080p60。

进入临时机内实现尚需同时满足：合法目标执行入口；实际将修改文件的原件读回与哈希；退出/watchdog及独立不加载扩展的恢复路线；合法 LV owner/回调/线程上下文；实测 buffer 格式、stride、尺寸、缓存同步与复用；安全有界编码器；真实卡挂载和 lease；短写/满卡/缺卡、fsync/close及独占发布；原厂页面创建/销毁事件；实测帧率与温度。原厂函数的存在不能代替这些运行前置。

## 合成前帧：owner、锁、元数据和生产者

| 候选 | VA | 指令证据和边界 |
| --- | --- | --- |
| LiveViewAccess 锁 | `0x6b618c` | 使用 access `+0x8` engine 和 `+0xb0` owner/client；进入 engine lock 前检查匹配关系。不是任意对象可直接调用。 |
| LiveViewAccess 解锁 | `0x6b6250` | 对应释放路径，异步编码前须完成拷贝或经验证的引用机制。 |
| engine lock | `0x6b6d1c` | `x0=engine+0x2170`、`w1=1` 调用 VideoBuffer lock。 |
| VideoBuffer lock | `0x6b6a3c` | `+0xe8 ← +0xe4` 锁定完成槽，`+0xf4 ← +0xf0` 锁定 ID；`w1=1` 返回 CPU 表 `+0x10+8*index`，`w1=0` 返回物理表 `+0x30+8*index`。已有锁会进入诊断断言。 |
| VideoBuffer unlock | `0x6b6b30` | 锁定槽 `+0xe8` 置 4；记录低32位锁持有耗时到 `+0x104`。 |
| 锁定尺寸 | `0x6b6b70` | 从 `+0x50+8*lockedIndex` 返回 width/height 二元组；不得用默认常量代替逐帧实际尺寸。 |
| 锁定 crop | `0x6b6be0` | AArch64 C++ 非平凡返回使用隐藏 `x8` destination；复制 `+0x70+24*lockedIndex` 的 Rectangle。不是简单 `x0` 指针返回 ABI。 |
| 锁定 ID | `0x6b6c80` | 锁存在时返回 `+0xf4`；未锁返回0。是软件完成序号，尚非经证明的传感器硬件计数。 |
| LV 生产者 | `0x787578` | `PlFunctions` 生产逻辑；正常调用链 `0x797278 → 0x787578`，上游 `0x79e208` 在 `0x79e730` 调度 `0x797278`。未证明该上游的完整 ISR/事件 ABI。 |

生产者 `0x787728..0x787758` 的寄存器与字段：`x24=VideoBuffer`，`x23=LV pending config`（engine `+0x4760`），`x20=LV setup`（engine `+0x4808`）；`ldp w4,w1,[x24,#0xe8]` 取得 lockedIndex 与旧 `+0xec` counter。它排除锁定槽 `+0xe8`、前完成槽 `+0xe0` 与正在写槽 `+0xdc`，选择下一写槽；`+0xec` 加1，`+0xdc=next`、`+0xe0=previousWrite`、`+0xe4=previousFinished`、`+0xf0=oldCounter−1`。因此 ID 是有管线延迟的软件完成序列。buffer 不足分支有 “sacrificing last finished” 诊断，不能把不锁/延迟解锁视为无成本。

`0x787838..0x78786c` 将下一写槽的尺寸写至 `VideoBuffer+0x50+8*index`：width 来自 FPGA field ID `0x1a6` 读回值；height 为 field ID `0x1a7` 与 pending config `+0x5c` 的较小值。`0x787870..0x787880` 将 pending config `+0x18` 起16字节复制到该槽 Rectangle `+0x8`（x/y/width/height）。字段 ID 是静态读操作标识，尚未恢复寄存器的官方语义名称。

`0x7877c4..0x7877f8` 对已完成 CPU buffer 调用 `0x78bd64`，区域大小按 W×H×4 计算；该例程缓存操作的精确方向/屏障还需核对和运行验证。不能因为总线区域大就把 RGB24 改标为 RGBA32。

### 视频与 overlay 分离

`0x793540` SharedHighMemoryLayout 给出独立分配表，CPU getter `0x7805c0`、物理 getter `0x780468`：

| 区域 | 分配 ID | engine 字段 | 字节预算 |
| --- | --- | --- | --- |
| 四个视频槽 | 4、5、6、7 | CPU `+0x2180/+0x2188/+0x2190/+0x2198`；物理 `+0x21a0/+0x21a8/+0x21b0/+0x21b8` | VideoBuffer channel count `+0xfc=3`；默认 1920×1080×3 = 6,220,800，写入 `+0xd8` |
| 两个显示 overlay | 8、9 | CPU `+0x2140/+0x2148`；物理 `+0x2150/+0x2158` | `+0x2168=0x7e9000` = 1920×1080×4 |

VideoBuffer 默认 dimensions `+0xd0/+0xd4={1920,1080}`；通道映射 `+0/+4/+8/+0xc={0,1,2,255}`，静态常量 `0xd732f8` bytes `02000000ff000000` 支持最后两项。视频 DMA 区域保留空间约64MiB每槽，与有效帧尺寸不同。此分离是比“LV字符串”更强的静态证据，仍需真机动态内容与像素检查证明文件不会混入遮罩、菜单或对焦提示。

stride 仍未完成闭环：JPEG wrapper 要求紧密 RGB24 的 `3*width` 行距；本阶段没有证明原厂 video 每个模式都以 `3*actualWidth` 排行，也没证明 color space/transfer/range。适配器必须逐帧得到或验证实际 pitch，不能把 Surface `+0x14` 的32bit显示 pitch 当作捕获 stride。zoom/pan 与输出固定16:9构图的独立性亦未验收。

### 计数与时间

原厂 `0x717284` 调用 PLT `0x40ada0` 的 `std::chrono::_V2::steady_clock::now`，经 `0x717398 → 0x71737c → 0x717464` 转换为64bit微秒（有符号除1000的 magic multiply 指令）。VideoBuffer `+0x100/+0x104` 仅保存该时钟的低32位，约71.6分钟回绕，是锁开始/耗时，不能当采集时间戳。

生产者 dispatch `0x797278` 在 `0x7972a4` 取时钟，低32bit写入40字节一项、2048项统计环（VA `0x3fa9938`，index VA `0x3fa5110`）；`+4` 开始、`+0x14` 结束，生产者另写 cache/process/interval 字段。统计环与每帧 ID 的一一对应还未确认，时间是处理/完成测量，不是传感器曝光时间。扩展 PTS 应来自经验证生产回调的64bit单调时间，并保留序号缺口与丢帧记录。UI paint 的消费时间不能证明源60fps。

## RGB24 JPEG 编码器：可复用候选及容量陷阱

模块含静态 libjpeg-turbo **1.5.3** 字符串（file `0x9d27d0`）；Jpeg.cpp source string file `0x9ce010`。不能按桌面现装库版本推断机内实现。

| 接口 | VA/虚表 | 经指令支持的候选参数 |
| --- | --- | --- |
| factory | `0x98cf48` | 分配 `0x480` 字节，调用 ctor `0x98d0d8`；返回对象。 |
| RGB24 wrapper | VT `0xdce100` slot `+0x20` = `0x98d8a8` | `x0=encoder*`, `x1=RGB24*`, `w2=width`, `w3=height`, `w4=quality`, `x5=outBytes*`, `w6=outCapacityU32`；正常返回 `w0=encodedLength`，fatal路径0。完整 C++ 类型、例外、线程安全及 allocator 匹配未运行验证。 |
| full encode | `0x98d680` | wrapper 设置 components=3、colorspace=2、默认 row stride=3W；同步扫描每行，finish 后返回字节数。输入不得在调用结束前被复用。 |
| libjpeg destination | `0x9a28d0` | 接收本地 out pointer 地址及长度变量，不是硬上限型 destination。 |
| base destructor | `0x98ddd0` | 可见 destroy 链，但对象完整销毁/释放方式须按原厂 VT 和分配器验证，不能直接假定 `free`。 |

原厂任务 `0x8e1d70` 从 JpegStorage `+0x1f0` 取 encoder，通过 VT+0x20 调用；输出放在 owner `+0x1f8` 的100MiB内联区（capacity `0x6400000`）。它随后写文件并关闭，不执行“释放编码输出”的外部回调；输出原本由 owner 拥有。

**明确阻塞：原厂 wrapper 不能直接当有界输出接口。** Destination init `0x9a2658`、overflow `0x9a26e8`、term `0x9a2660`。overflow 分配两倍容量（malloc PLT `0x40a5e0`）、拷贝旧输出（memcpy `0x40a530`），只释放先前由该 destination 自分配的旧区（free `0x40b120`），并更改输出 base。term 将新 pointer/usedLength 写回传入的指针地址。但是 `0x98d680` 传的是它的栈内 output pointer 副本，wrapper 只向外返回 length，没有将换址 pointer 返回调用者；输出超过容量后，调用者原地址可能是不完整JPEG，新地址不可按该返回接口取到。这是静态确定的数据流，不是实测触发。

原厂100MiB大缓冲掩盖了这个风险，不能证明任意高纹理图的硬上界。F4须使用经验证的真正有界 destination/独立有界 JPEG 库，或完整恢复并验证 pointer-return/释放契约，才可向录像容器交付完整 packet。需要每次验证 `0 < length <= ownedCapacity` 和 JPEG 完整性，性能以实机编码耗时决定；软件库存在不证明1080p60。

## 真正卡后端：原厂 SD 路径、XQD 候选和 lease

### 对象来源与路径

此前名称需更正：`0x8e0b18` 是 JpegStorageDevice 事件循环；真正构造函数为 **`0x8e0928`**。main `0x424b80..0x424bcc` 以 `w1=10,w2=1` 调用 FileManager `0x74e454`，返回值送 ctor `x5`；ctor `0x8e0988..0x8e098c` 存到 owner `+0x1b0`。因此本版本原厂 JPEG 后端明确取 **folder 10 / SD**。

FileManager 全19项表 VA `0xf55cb8`（file `0xb45cb8`），19×32字节，id/path/缓存FS/flag。精确路径：folder9、10 `/run/media/sdcard/`；folder11 `/run/media/xqdcard/`；folder12 `/var/tmp/`。FileManager ctor `0x74d888` 在 `0x74d928` 用 `LinuxFileSystem` ctor `0x825c0c` 创建各表项并在 `0x74d940` 填 cached FS 指针。FS VT=`0xd91450`。这已确认照片原厂 JPEG 是 LinuxFileSystem 包装对象，并非仅凭路径字符串猜测；仍没有验证相机当前 SD/XQD挂载、CFexpress是否映射XQD、文件系统格式、权限及容量。

`FileSystemResolver` ctor `0x6aff60`；acquire `0x6b0290` 区分 storage ID0=XQD、1=SD、2=internal/tmp；检查可用状态并请求对应管理器写权。wait `0x6b0f84` → acquire → wait response → `0x6b0dec`，state2/3时返回 FileManager cached FS：XQD folder11、SD folder10、internal folder12；失败返回null。release `0x6b015c` 释放storage manager注册client并state归零；事件 `0x6b0814/0x6b0be0` 处理超时、卡写权丢失与auto-release。参数2/3的具体超时语义与单位、线程/事件泵约束仍应通过构造调用者闭环，不能直接拿一个裸管理器指针。

JpegStorage ctor 参数 `x3/x4` 存 `+0x1d8/+0x1e0`，向各 StorageManager `0x8ca3ec` 注册名“JpegStorage”，client IDs 存 `+0x1e8/+0x1ec`。task `0x8e17c8` 先 `0x8ca598` 请求另一管理器，再 `0x8ca888(manager,clientId,6000)` 等待本 SD 写权；失败日志明确 “Unable to get SD into writing mode - no Jpeg created”。处理完成/失败需 `0x8ca708` 释放，不能仅 open 文件绕过原厂卡切换/拔卡状态机。StorageManager 使用最多32个registered clients的bitset（`0x8ca5ac..0x8ca6a8`），未知扩展不得盗用原厂client ID。

### 文件接口和安全发布边界

| FS VT slot | VA | 指令支持行为 |
| --- | --- | --- |
| `+0x28` | `0x825ed4` | open(fs,FileStream*,relativePath,writeFlag,rwFlag,syncFlag)，返回bool；拼接根路径 `0x827348` → `open@0x40a4d0`。原厂JPEG参数(1,1,0)是flags `0x80241`（O_CLOEXEC|O_WRONLY|O_CREAT|O_TRUNC）、mode `0x180`=0600，**没有O_EXCL**。 |
| `+0xf8` | `0x826e04` | write(fs,source,lenU32,stream) → `write@0x40a930`；返回实际U32字节数；负错误记录诊断后返回0。调用者必须处理短写。 |
| `+0xe8` | `0x826ca8` | close(fs,stream)，dirty时调用VT+0x128 fsync，随后 `close@0x40aa90`；返回bool。 |
| `+0x128` | `0x82721c` | fsync(fs,stream) → fd getter `0x46b15c` → `fsync@0x40ad90`；失败false，成功true。 |
| `+0x50` | `0x8267dc` | rename(fs,oldRelative,newRelative) → 两个规范路径 → libc `rename@0x409e10`；**不保证no-replace**。 |
| `+0x58` | `0x826a8c` | remove path，`remove@0x40b180`，不是rename。 |
| `+0x108` | `0x826ea4` | 删除打开文件：由/proc fd路径→realpath→关闭→remove；**不是flush**。 |
| `+0x110` | `0x827044` | seek候选，参数offset/whence为U32；精确大文件语义仍需验证。 |

FileStream 24字节：VT+0、FileSystem*+8、fd/handle+0x10、open flag+0x14、dirty flag+0x15。ctor `0x825770`；write wrapper `0x8258b8` 置dirty再调用FS+0xf8，指令完整保留返回值；close wrapper `0x82580c` **在调用FS close之前先清open flag**，所以close失败后不能通过同一wrapper简单重试。

原厂 `0x8e1f7c` 在FS中创建 DCIM，并按folder计数/碰撞追加后缀选择文件名；实际 open/write/fsync/close 链存在。但JPEG task `0x8e1d70` 的实现没有完成F4要求的安全策略：它不严格检查编码0/短写/close失败，也没有原子no-replace发布。不能以“原厂函数可调用”继承这些错误语义。

根主机后端的 POSIX exclusive create/rename 构建结果不能证明相机支持对应syscall；本阶段只证明原厂程序本身有Linux open/write/fsync/rename导入和SD/XQD FileSystem路径。下一临时只读步骤应确认当前真实卡的根目录、挂载源/格式、权限、stat容量与 lease 对象状态；得到安全执行/恢复前置后，才可在扩展专属目录验证exclusive temporary create、短写、fsync、目录fsync、no-replace发布和受控中断收尾。不假设 `/mnt/cf` 或未知目录存在。

## 原厂 UI 接入范围

既有F1静态证据可复用：LiveViewScreen ctor `0x5175b8` 安装VT `0xb9a9d8`；paint slot+0xa0=`0x51da0c`，input slot+0x108=`0x51ea88`，property slot+0x1c8=`0x51b768`；生命周期候选 `0x51d884/0x51d9bc`；start=`0x5202a0`，真实stop=`0x520590`。**`0x51ea88` 是触摸输入，不能误作render；`0x520684` 不能误作stop。**

这些入口可辅助原厂LV专属录像页面的事件与退出链，但本阶段没有证明可安全注册新页面、owner对象layout、事件线程、重入控制或销毁ABI。录像状态机必须独立single-instance；退出、电源/LV暂停/休眠/热保护必须进入同一停止收尾链，然后恢复原厂LV。显示控件可以操作显示Surface，编码只能读视频槽。没有生成任何UI注入或安装物。

## 原件备份、执行与恢复

已有 `DEVICE_FILE_CHANNEL.md` 的原厂静态通道仍适用：main `0x425558` 创建 FileManagerIqpClient `0x750ee4`，`0x425578 → 0x871260` 注册ProgrammingAndLog；event `0x870318` 内部 class65/type1 → read-open `0x870418` →客户端Open `0x750f9c`。Read `0x75124c` → FileStream read `0x82586c` →FS VT+0xf0；Outgoing provider `0x870a2c` 调用客户端Read。白名单fileID405/415对应 User/Factory 的 `p1linux`（ELF原件），404/414 manifest；只读flags由 `0x74e058` 检查。405/415尚未通过原厂SDK实际读取，不能记为已有备份。

Autostart/late-autostart不在已验证FileId whitelist；development shell是文本popen/fgets通道，不能代替二进制原件下载，也不能认定可独立恢复。Factory启动还经过共享global hook；`init=/sbin/init_shell` 分支存在，但可达控制台和不加载扩展的真机启动方式均未验证。

下一离线优先研究ProgrammingAndLog outer framing、read-open应答/认证和USB endpoints；由SDK代理核对公开DownloadFile枚举能否合法read405/415，根执行者使用原厂接口实测。此文件不包含未知wire packet、发送脚本或安装方案。缺少原件备份及独立恢复时，具体目标写入仍不能通过部署门槛，其他源码与静态研究可继续。

## 当前结果分层

| 项目 | 静态分析 | 主机验证 | 临时实机 | 持久验收 |
| --- | --- | --- | --- | --- |
| 视频/overlay独立内存及owner锁 | 指令+字节已记录 | 无目标ABI执行 | 未验证 | 未通过 |
| producer、实际size/crop、软件ID | 已定位；stride/capture timestamp仍缺 | 无目标ABI执行 | 未验证 | 未通过 |
| RGB24 JPEG wrapper | 已定位；扩容换址陷阱已确认 | 目标库未执行 | 未验证 | 未通过 |
| 原厂SD JPEG写卡与XQD resolver | 已定位；flags/短写/fsync/rename已区分 | 目标库未执行 | 挂载/lease/卡接口未验证 | 未通过 |
| 原厂LV页面事件 | 已定位候选 | 不等于机内注册 | 未验证 | 未通过 |
| 405/415原件读回及独立恢复 | handler/whitelist静态证据 | 原厂API合法性由SDK代理核查 | 未取得原件/恢复验证 | 未通过 |
| 1920×1080真实60fps、持续编码写卡 | 默认预算存在，能力未证明 | 容器或主机测试不能证明 | 未测 | 未通过 |

本阶段交付可复现静态地址、字节、调用关系和准确阻塞；实际机内运行、帧率、色彩和存储可靠性不能由这些分析替代。
