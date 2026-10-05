# F1 原厂显示 Surface 与网格接口：静态候选

本报告仅针对 F1 机内 LV 构图遮罩。没有连接、控制、读取或写入设备，没有制作注入代码、修改固件或运行任何地址。本文所有地址均为下述 ELF 的 linked VA，证据级别为**静态分析**；这不是可部署 ABI 或机内验收结果。主机 DisplayCanvas 核心由另一执行者维护。

## 版本绑定与结论

- 外层：`Firmware-BP-IQ4-IQ4_6.03.18.fwr`，SHA256 `a52758ffb163023e5323297e450450f91002175b69bed7590fe2cd037c2ab300`。
- 内层：`analysis/firmware/extracted/P1Linux_6.03.21.bin`，11874544 bytes，SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`，ELF64 AArch64 little-endian ET_EXEC，BuildID `1f451370d713ae1f341e9d5de5615717f9fb36ed`。包版本与内部 LinuxApp 版本不同；不能把 6.03.21 当成设备固件版本。
- 本文 `.text/.rodata` 的 file offset = VA − `0x400000`；未使用其他固件、GR4 或 X2D 地址。

可复用候选是原厂的矩形填充 `0x46f370 / 0x46f430`，经原厂 UI paint 调用，并写入 Surface 的 32 位显示缓冲。标准 quarter-turn 旋转下，四个遮罩带仍是轴对齐矩形，不必先寻找原始 polygon API。机内 Surface 来源、生命周期、LV viewport、输出隔离及安全临时执行入口仍未经过设备验证。

原厂 `ShowGrid / GridMode / GridCustomCenterX / Y` 是网格显示与单条中心线位置控制。已追踪的 handler 没有自定义宽高比或 `65:24` 遮罩分支。ASCII 未命中 ratio 名称只是辅助搜索结果，不能证明整份固件不存在其他机制。

## 矩形填充与调用点

| VA / file offset | 静态角色 | 实际 AAPCS 参数 |
|---|---|---|
| `0x46f370 / 0x6f370` | Rectangle wrapper | x0=Surface*, x1=Rectangle* drawRect, x2=Rectangle* clip, x3=4-byte Color* |
| `0x46f430 / 0x6f430` | 坐标版填充矩形 | x0=Surface*, w1=left, w2=top, w3=right inclusive, w4=bottom inclusive, x5=mutable Rectangle* clip, x6=4-byte Color* |
| `0x46d524 / 0x6d524` | 水平扫描线 | x0=Surface*, w1=xStart, w2=xEnd inclusive, w3=y, x4=mutable clip, x5=Color* |
| `0x4af054 / 0xaf054` | 原厂 Control paint 候选调用者 | x0=control, x1=Surface*, x2=drawRect, x3=clip，x8=Rectangle 返回对象；在 `0x4af0c4` 调 wrapper |

`0x46f430` 在 `0x46f554..0x46f5bc` 逐行循环，`0x46f5a4` 调水平扫描线。因此不是只画边框。`0x46f458..0x46f464` 先检查 Color[0]，为 0 则返回。它会交换反向的 x/y 端点（`0x46f468..0x46f4b4`），而不是将反向端点当成空区域。

Wrapper 的全部参数转换指令如下：

```text
46f394  bl 47e3c8       ; rect.left = +8
46f398  mov w19,w0
46f3a0  bl 47e3e0       ; rect.top = +c
46f3a4  mov w20,w0
46f3ac  bl 464484       ; right = x+width-1
46f3b0  mov w21,w0
46f3b8  bl 4644ac       ; bottom = y+height-1
46f3bc  mov w22,w0
46f3c8  bl 457d54       ; local Rectangle copy of caller clip
46f3d4  bl 457940       ; local four-byte Color copy
46f3d8  add x1,sp,#68   ; address of local Color
46f3dc  add x0,sp,#50   ; address of local Rectangle clip
46f3e0  mov x6,x1
46f3e4  mov x5,x0
46f3e8  mov w4,w22      ; bottom
46f3ec  mov w3,w21      ; right
46f3f0  mov w2,w20      ; top
46f3f4  mov w1,w19      ; left
46f3f8  ldr x0,[sp,#48] ; caller Surface
46f3fc  bl 46f430
```

Wrapper 会克隆调用者 clip；坐标版不会。`0x46f370` 的 x2 可视为输入 clip，但它不是有公开 C++ 声明的 API。若选用坐标版，必须自己克隆真实原厂 Rectangle。独立小整数矩形不能冒充带 vtable 的 Rectangle。

原厂 control 调用 wrapper 的关键寄存器链：

```text
4af094  bl 457d54       ; clone incoming x3 clip to sp+40
4af0a8  bl 457940       ; clone native UI Color to sp+58
4af0ac  add x1,sp,#58
4af0b0  add x0,sp,#40
4af0b4  mov x3,x1       ; color
4af0b8  mov x2,x0       ; cloned clip
4af0bc  ldr x1,[sp,#28] ; incoming drawRect (paint x2)
4af0c0  ldr x0,[sp,#30] ; incoming Surface (paint x1)
4af0c4  bl 46f370
```

这证明原厂 UI 会把收到的显示 Surface 交给填充函数；不能证明我们的 adapter 已经能注册新 control 或取得该对象。

### Rectangle 精确布局、size 与 clip mutation

`0x457cf0` ctor 写入 vtable `0xb73b98`，随后写入 x/y/width/height。`0x457cc8` deleting destructor 向 delete 传 size `0x18`（`0x457cdc`），证实本二进制对象为 24 bytes。

| offset | 字段 |
|---|---|
| `+0x00` | 8-byte vtable pointer |
| `+0x08` | signed i32 x |
| `+0x0c` | signed i32 y |
| `+0x10` | signed i32 width |
| `+0x14` | signed i32 height |

`0x464484` 返回 x+width−1；`0x4644ac` 返回 y+height−1。因此调用坐标版需要从主机 half-open band `[x,x+w) × [y,y+h)` 转成 `[x,x+w−1] × [y,y+h−1]`。

`0x46f4b8..0x46f4c8` 将 clip 和 `Surface+0x20` 相交。被调函数 `0x47e31c` 通过临时结果计算交集，然后在 `0x47e368/378/384/390` **回写调用者 clip 的 +8/+c/+10/+14**。随后原函数通过 max/min 将请求边界限制到交集；横线会再次相交。调用者应给坐标版传独占的原厂 Rectangle clone。Wrapper 已有局部 clone，但若 clip 是空/无效对象，不能依赖它自动修正。

调用前必须跳过 width<=0 或 height<=0、空交集，并检查 x+w−1 / y+h−1 算术溢出。否则 width=0 会产生 right=x−1，再被交换成两列；原函数没有“空 band”语义。此项是 adapter 约束，不是已运行修补。

### Color：黑色与 alpha 的确切字节语义

Color 是四个字节；`0x4123cc` ctor 按 w1,w2,w3,w4 顺序写 +0,+1,+2,+3；复制函数 `0x457940` / `0x457998` 原样复制这四字节。**字节 +0 为 alpha**，+1/+2/+3 为三个颜色通道。本次为黑色不需依赖三通道的具体 R/G/B 排列。

不透明黑色为内存字节 `ff 00 00 00`，半透明黑色为 `a 00 00 00`（a=1..254）。原厂初始化 `0x47d8d0..0x47d8e8` 直接构造 `{255,0,0,0}`。

- 矩形 alpha=0：`0x46f460..464` 返回，不写像素。
- 横线 alpha=255：`0x46d648..654` 选择 Draw vtable slot+0。
- 其他 alpha：`0x46d6f8..734` 选择 Draw vtable slot+8。
- Draw vtable `0xb7b7d8`（file `0x77b7d8`）首项 `0x47e798`，+8 项 `0x47f378`。
- `0x47e798` 将 Color 的整 32-bit 值交给 fill 后端 `0x9e9320`；颜色未进行 RAW/JPEG processing。
- `0x47f388..3ac` 读取 alpha a、三个源通道 c，计算 255−a 及 c*a。标量尾部 `0x47f6e4..720` 实际计算每通道 floor((src*c_alpha + dst*(255−a))/255)，并更新 destAlpha = oldAlpha + floor((255−oldAlpha)*a/255)。这是 alpha blend 证据，不是从函数名猜测。

此处 alpha 混合针对显示 Surface；不能将捕获 RGB24、RAW 或编码输入缓冲替换成它。

## Surface bounds / pitch / owner

Surface ctor `0x46cc8c` 实际参数是 x0=this, x1=pixels, w2=physical width/pixel pitch, w3=height, x4=Draw*, w5=u8 flag（flag 精确用途未追踪）。

| offset | 从 ctor 与横线确认的意义 |
|---|---|
| `+0x00` | base Surface vtable `0xb7b780` |
| `+0x08` | Draw backend pointer；间接 vtable 调用 |
| `+0x10` | u8 ctor flag，未验证语义 |
| `+0x14` | signed i32 pixel pitch/physical width；不是 bytes |
| `+0x18` | signed i32 physical height |
| `+0x20` | 24-byte Rectangle bounds，ctor 为 (0,0,pitch,height) |
| `+0x38` | 32-bit display pixels pointer |

`0x46ccd4..0x46cce8` 存 w2/w3，`0x46ccf0..0x46cd0c` 构造 bounds，`0x46cd14..18` 存 pixels。横线 `0x46d65c..0x46d680` 的目标地址为 `pixels + 4*(y*pitch+x)`，与捕获 RGB24 的 3*W 明确不同。

Adapter 应从真实已获授权的显示 compositor callback 接收 Surface，读取当前 Surface+0x20 的 bounds，与真实 LV 显示 viewport 求交。不能仅用 physical width/height 当作 LV 的矩形，也不能伪造 Surface、复用已释放对象、在非 UI 所属线程写入或从 RAW/RGB24 descriptor 构建它。Surface 的运行时所有权、锁、失效/重绘规则仍需设备确认。

## 原厂网格、事件与旋转

UiEventGroup ctor `0x64270c` 的属性命名与 owner-relative offset 已由同一指令链确认：

| 属性 | UiEventGroup offset | 构造调用 VA |
|---|---|---|
| ShowGrid | `0x1f20` | `0x642c68 -> 0x415354`（初始bool=0） |
| GridMode | `0x1ff8` | `0x642c8c -> 0x644560`（初始enum=1） |
| GridCustomCenterX | `0x20d8` | `0x642cb0 -> 0x4325cc`（初始float=.5） |
| GridCustomCenterY | `0x21b8` | `0x642cd4 -> 0x4325cc`（初始float=.5） |
| GridCustomReset | `0x2298` | `0x642cf0 -> 0x70f12c` |

这些是内部对象偏移，**不是 CameraSDK property ID、IQP 参数、可发送命令或文件配置键**。UiGridControl ctor `0x5473e4` 的 EventGroup owner 在 +0x98；property handler `0x547c60` 针对以上对象通知作比较。

`0x547ca0..0x547cec` 先隐藏五个既有 child；`0x547d04..98` 对 GridMode 0/1/2/3/6 选择 +a0/+a8/+b0/+b8/+c0 child，并调用 `0x4ac144` 显示。其他值在这条 handler 链没有自定义比例分支。现有语言表有 Square、Golden Ratio、Center Cross、Fibonacci Spiral、Rectangular、Custom Center（file `0x80b558..0x80b5b0`），但本报告不把所有名称与整数值强行一一绑定；Square 网格名称不等于 1:1 遮罩。

CustomCenterX/Y `0x547e04/84` 读取 float，要求 [0,1]，再调用 `0x54739c` 设置单条线位置；它没有四 band 填充。ShowGrid 对应检查见 `0x548150..178`。现有 GridLine paint `0x546568` 调竖向交替色线 `0x46d754` 与横向交替色线 `0x46d960`；这些是用于虚线/双色线的扫描函数，不是矩形填充。

原厂 UI 拓展的静态登记候选：AddControl `0x4ab898`、Show/Hide `0x4ac144`；control paint vtable slot +0xa0，touch/event slot +0x108。LV dialog 的 slot +0xa0 是 `0x51da0c`，**`0x51ea88` 是输入/property event 路径，不是 render**。UiGridControl paint `0x548714` 自身仅返回 Rectangle，具体线由 children 绘制。新菜单点击/enum 绑定、control 生命周期及 adapter 注册入口仍未被机内确认；本报告没有提供未知触摸/协议命令。

Rotation setter `0x54803c` 在 `0x548064..9c` 只接受 0/90/180/270；写入自身 +0xe8 并在 `0x5480b8/c8/d8/e8/f8` 转发给各原厂 child `0x548b78`。这证明已追踪网格旋转控制是 quarter-turns。坐标版 FillRectangle 完全不处理旋转。对于 90/180/270 的旋转以及轴向缩放/平移，四 band 数学上仍轴对齐，可把 DisplayCanvas 已变换几何转换为矩形；必须验证 native callback 的坐标系、viewport 和 orientation 后再决定。不应从此推断整个显示系统无其他任意角度变换。

## F1 接入与恢复的明确阻塞

只读原件/恢复研究见 `DEVICE_FILE_CHANNEL.md`：FileManagerIqpClient 能按白名单完整二进制读取 User p1linux（内部ID5、编程参数候选405）与 Factory p1linux（ID15、候选415），但主机 documented outer framing、会话与权限路径、设备可达性未验证。没有发送这些候选值。autostart/late-autostart 不在该文件白名单；普通厂商回退不会自动绕过全局 hook。boot shell 有静态独立启动候选，但实际激活、可控 console 与恢复后校验未验证。

因此本阶段不能声称已经备份真机原件、能恢复任意全局 hook、具备临时执行/注入入口或完成 F1 机内功能。后续由唯一设备执行者完成已授权的原厂读取、版本/哈希备份、恢复路线可执行性，再以真实 UI Surface 和 LV viewport 验证最小临时显示修改。F1 临时修改不需要先部署持久 hook。可直接用既有原厂网格做行为/恢复基线，但其可达读取与配置保存/恢复同样要先确认。

F1 的机内验收需检查五项选择、旋转/缩放/重绘、退出回原厂以及 RAW/JPEG/视频未受到遮罩。仅显示 Surface 的静态地址不能证明这些输出隔离。

## 实际 mask 接入前必须验证的坐标与恢复前置

1. **源坐标**：确认当前 LV 有效图像宽高、源 ROI、裁切/缩放与 zoom 状态；输入只需这些几何量，不传捕获像素 pointer。传感器全幅比例、RAW 尺寸和当前 LV 内容的比例不能相互代替。
2. **显示 viewport**：确认原厂 paint 提供的 Surface / drawRect / clip 对象及当前 LV 实际 destination Rectangle；区分屏幕 bounds、菜单、黑边和 LV 内容。quarter-turn 是否已应用、坐标是否为旋转前/后以及缩放/平移需实际核验。只有已变换 band 仍轴对齐时才使用 rectangle primitive。
3. **所有权与重绘**：Surface 必须来自显示 compositor 的存活 callback；确认线程、锁、paint 次序和帧间有效期。绘制在原厂 LV 图像之后，不能把 Address+0x38 保存并在 callback 外继续写。新 control 的 AddControl/注销、触摸事件及 invalidation ABI 还未验证。
4. **边界与 alpha**：跳过零面积/空交集并验证有符号加法；保持半开区域到 inclusive 区域的精确转换；坐标版每次用独立 clip clone；不透明黑色四字节 ff000000，alpha blend 要以屏幕结果实际检查。
5. **退出/禁用/恢复**：临时改动前先保存真实被改配置的原值与原件哈希，并确认能用原厂通道读回、还原、校验。在未知执行入口与独立恢复尚未验证时，不安装持久 hook。退出 LV、切换页面、停止测试及禁用 mask 必须移除 custom control/callback 并触发原厂重绘，不能仅留一个可能失效的内存撤销计划。
6. **输出隔离**：用机内实际样本验证遮罩只改变显示；RAW/JPEG 输出像素及视频输入不得受到修改。静态 Surface buffer 与 RGB24 descriptor 不同只是必要证据，不能替代机内验收。

## 可复现证据

- `f1_surface_primitives.disasm.txt`：Rectangle、Surface、fill wrapper、填充扫描、clip mutation、Draw fill/blend、原厂黑色初始化。
- `f1_overlay_properties.disasm.txt`：内部属性命名绑定、handler、ShowGrid、quarter-turn rotation。
- `f1_ui_fill_callsite.disasm.txt`：实际 UI caller 的寄存器链。
- `f1_static_abi.json`：从确切 ELF 提取的布局、表项与内部 property offset；不构成运行时 FFI。
- `F1_STATIC_EVIDENCE_SHA256.json`：输入/报告/独立证据的 SHA256。

只读复核例（工作目录 IQ4_Codex_Handoff_v2）：

```sh
shasum -a 256 analysis/firmware/extracted/P1Linux_6.03.21.bin
/Library/Developer/CommandLineTools/usr/bin/llvm-objdump -d --start-address=0x46f370 --stop-address=0x46f5e4 analysis/firmware/extracted/P1Linux_6.03.21.bin
/Library/Developer/CommandLineTools/usr/bin/llvm-objdump -d --start-address=0x46cc8c --stop-address=0x46cd34 analysis/firmware/extracted/P1Linux_6.03.21.bin
/Library/Developer/CommandLineTools/usr/bin/llvm-objdump -d --start-address=0x54803c --stop-address=0x548134 analysis/firmware/extracted/P1Linux_6.03.21.bin
```

llvm-objdump 的 nearest exported-symbol 名称经常落到无关 std:: 函数；本证据省略这些名称，只使用实际函数边界、地址、原始指令、寄存器与绑定哈希。
