# F4 原厂页面接入：静态调用契约

本文件仅记录本版 IQ4 固件的指令、常量、调用链。没有连接相机、执行目标函数、安装页面、修改固件或验证实际按键。`static` 不等于机内接口已经可用。本次仅新增 UI 材料；`F4_NATIVE_RECORDING.md`、`FILE_READ_TRANSPORT.md` 和先前 F1 材料冻结。

## 1. 版本与复现

- FWR：`Firmware-BP-IQ4-IQ4_6.03.18.fwr`，SHA256 `a52758ffb163023e5323297e450450f91002175b69bed7590fe2cd037c2ab300`。
- 分析 ELF：`analysis/firmware/extracted/P1Linux_6.03.21.bin`，11,874,544 bytes，SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`，BuildID `1f451370d713ae1f341e9d5de5615717f9fb36ed`。
- ELF64 LE AArch64 ET_EXEC。本文代码/rodata 文件偏移均为 `VA - 0x400000`。包版本 6.03.18 与 ELF 名称 6.03.21 并存，不能据文件名推断真机主程序精确版本。
- `python3 tools/firmware/f4_ui_collect_static.py` 校验输入后生成 `f4_ui_static/*.disasm.txt`、`exact_bytes.json` 和 `F4_UI_STATIC_EVIDENCE_SHA256.json`。确切指令 bytes、窗口偏移及 vtable bytes 均在 JSON 中。
- `f4_ui_decompile_targets.txt` 与 `decompiled_f4_ui/*.c` 可通过已有 `DecompileIQ4.java` 重新生成。反编译类型、函数名是研究标签，遇到隐藏返回值和次级基类必须以指令为准。

## 2. 最短原厂 UI 路线及边界

已经连通原厂 `UiDialogMenuItem → UiDialog → UiDialogManager → 页面 enter/exit`；原厂 `Control/UiIconButtonControl → observer callback` 与硬件键 `KeyHandler → 页面 handler` 也已分别定位。可以据此继续写**机内** adapter 的调用封装、事件转换和销毁顺序；这不是桌面页面替代。

尚不能直接安装：运行时 `UiDialogManager`、原厂 LV 对象、资源对象和 UI 线程执行入口未取得；现有菜单项移除/事件解绑契约没有完整确认；机内执行、原件备份和独立恢复未验收。新页面与已有 LV 的所有权/刷新关系必须观察，不能因静态栈行为便宣称可录制。

建议的 adapter 分层是：原厂 Dialog/Control/Surface 只负责页面和输入；触摸、硬件键分别转换为同一个 `start/stop/back` 动作；录像后端独立管理 producer、encoder、卡文件与收尾。地址只绑定上述 ELF，不能移植 GR4/X2D 地址或重用其 ABI。

## 3. 原厂 LV 对象、基类和生命周期

原厂源路径字符串 VA `0xb9a598`（file `0x79a598`）包含 `UiIQ4LiveViewDialog`。名称字符串 `0xb918a0` 是 `LiveView`。`0x4eeee0..0x4eef30` 分配 **0x1310** bytes 后调用构造函数 `0x5175b8`；`0x4eef64..0x4eef6c` 将对象保存在 `UiIQ4Data` 主对象 `+0x8c0`。传给 Dialog 基类的 manager 是该主对象 `+0x1c8`，因此二者不是同一对象地址。

LV 主 vtable `0xb9a9d8`，次级基类/观察者如下。这里只证明静态偏移，不能把任意内存套成 C++ 对象。

| 相对 LV this | vtable | 静态用途 |
|---|---|---|
| `+0x00` | `0xb9a9d8` | Dialog/Control 主接口 |
| `+0x80` | `0xb9abc0` | 硬件键 KeyHandler |
| `+0x88` | `0xb9abf8` | Dialog 栈节点；保存回指 Dialog |
| `+0xd0` | `0xb9ac58` | 原厂属性/event observer |
| `+0xe8` | `0xb9ac80` | Control 事件 observer |

主 vtable 关键槽：

| 槽位 | 本版 VA | 契约/限制 |
|---|---|---|
| `+0x00 / +0x08` | `0x521118 / 0x52125c` | 非删除/删除析构；后者 delete size=0x1310 |
| `+0xa0` | `0x51da0c` | paint，24-byte Rectangle 隐藏返回 `x8` |
| `+0xa8` | `0x4e1270` | invalidate；可能触发关闭请求，不能当纯画面刷新无条件调用 |
| `+0xc8` | `0x4ab898` | 添加 Control 子节点与定位 |
| `+0xf0 / +0xf8` | `0x51e1f8 / 0x51e2c0` | 指针按下/抬起候选，**不是**这里的硬件键接口 |
| `+0x108` | `0x51ea88` | 原厂触摸事件；不是 render |
| `+0x110 / +0x118` | `0x4ac660 / 0x4ac6a0` | observer / filter+observer 绑定 |
| `+0x128` | `0x4e14bc` | 关闭请求，含 event 通知 |
| `+0x148 / +0x150` | `0x4e12c8 / 0x4e1320` | manager Show / Close |
| `+0x160 / +0x168` | `0x4e18b8 / 0x4e18ec` | OnCloseDelegate 通知 / 注册，**不是 open / close** |
| `+0x170 / +0x178` | `0x51d884 / 0x51d9bc` | 页面 enter / exit |

`UiDialog` 基类构造 `0x4e10c4`：`x0=this, x1=持久 name 字符串指针, x2=UiDialogManager*`；调用 `Control(this,800,480,0)`，构造 `+0x80` KeyHandler 和 `+0x88` 栈节点，保存 manager 到 `+0xb0`，name 到 `+0xc8`，OnCloseDelegate 到 `+0xc0`。基类删除析构 `0x4e1238` 传 delete size **0xd0**。这不证明自定义派生类总大小或 vtable 复制范围。

LV 本体已明确字段：owner U32 `+0x100`；owned U8 `+0x104`；LiveViewAccess* `+0x108`；锁住的帧指针 `+0x188`；timer `+0xd70`；活跃 flag U8 `+0xd69`。这些字段不允许由 adapter 猜值写入。

`enter 0x51d884` 当 owned 不为1时调用 `start 0x5202a0`，之后调整原厂 Controls。`start(this)` 返回 bool：取得 native owner 后配置/启动 LV；被别的 owner 占用时返回0；已经 owned 时走 resume。不能通过改 owned flag 假装成功。

`exit 0x51d9bc(this)` 直接调用真正的 `stop 0x520590(this)`，再更新原厂显示属性和 flag。stop 在 owned 时先 release `+0x188` 的锁并清零，停止 image interface，停止 LV、release owner、清 owned；停止 timer 并清 active。`0x521118` 析构只销毁成员和基类，**没有调用 stop**。若销毁实际 LV 对象，必须先走 exit/stop，确保 producer/录像回调不再使用该对象；不能直接删除原厂长期驻留的 LV 对象。

## 4. Show / Close / 返回链

`DialogShow 0x4e12c8(this)` 从 `+0xb0` 取得 manager，调用其主 vtable `+0x28(manager,this)`。本版 manager vtable `0xb8f358`，该槽为 `0x4e28f8`；正常分支调用 `0x4e27bc(manager,dialog,manager+0x68)`。

`0x4e27bc` 比较当前页与目标页。目标不同则：旧当前页 `VT+0x160` OnCloseDelegate 通知 → 将目标的 `+0x88` 栈节点压入 → 目标 `VT+0x170` enter → `VT+0x158` 布局/更新 → 更新显示 bounds → `VT+0xa8` invalidate → manager event 通知。**此函数没有调用旧当前页 exit**。因此新 F4 页盖在 LV 上时是否继续产帧、是否仍刷新、是否保留锁，需要运行时验证；不能假定第二页能重复 acquire 同一个 LV owner。

`DialogClose 0x4e1320(this)` 调用 manager `VT+0x30(manager,this)`，本版是 `0x4e2bdc`。当前页关闭分支：`VT+0x160` notify → `VT+0x178` exit → `0x70ba84(dialog+0x88)` 脱栈 → 获取返回页并布局/invalidate。关闭非当前页分支会记录告警、调用该页 exit 并移除节点。关闭不删除 Dialog 内存。

`DialogRequestClose 0x4e14bc(this,w1=delay)` 与上述直接 Close 不同：调用 `0x4e4820(manager,delay)` 设置通知/可选时间，然后置页 `+0xa8` flag 并发 manager event。`0x4e1270` invalidate 检测关闭条件后可转调用 `VT+0x128`。adapter 首版不得把该延迟请求与录像 drain/finalize 混为同步完成。

`0x4e18ec(this,event*)` 只注册 `+0xc0` 的 OnCloseDelegate（已有时记录警告）；`0x4e18b8` 只对其 `0x70f2f8` 通知。它可能在切页之前触发，不是析构回调，也不保证已释放 LV 或文件。F4 exit 应在后端完成停止/收尾后返回；不要先弹页再后台使用已释放 observer。

## 5. 菜单项注册

原厂 `UiDialogMenuItem` vtable `0xb901d8`，源路径 `0xb90158`；RTTI `0xb90278`，名称 `0xb90290`。其构造 `0x4e8400` 的调用寄存器确认为：

```
x0 = MenuItem storage
w1 = title/resource identifier (U32; 类型名未恢复)
x2 = Dialog* (保存到 item+0x28)
w3 = activation return bool (保存到 item+0xf0)
x4 = enabled property/event* (保存到 item+0xf8)
x5 = visible property/event* (保存到 item+0x100)
```

原厂 `0x4f1f08..0x4f1f3c` 明确 allocate **0x108**，设置 `x4=x5=0,w3=0,w1=0x3a5,x2=既有Dialog`，构造后 `0x4e58b8(parentSubMenu,item)`。该调用证明注册形态，不说明该资源 ID 或 Dialog 是录像入口。新 F4 标题、图标和资源 ID 不能按其他相机猜测。

激活槽 `MenuItem VT+0x50 = 0x4e8538(item)` 调用保存的 Dialog `VT+0x148`，之后返回 `item+0xf0` bool。菜单调用可复用 manager 的标准 Show 链。

`0x4e58b8(submenu,item)` allocate 0x20 原厂列表节点，追加至 submenu+0x18；取得 item `VT+0x70` change event 时建立 event listener，并通知 submenu+0x60。实际 `UiSubMenuItem` 构造是 **0x4e5744**；`0x4e5718` 是共同 MenuItem 基类初始化，不能拿它初始化 SubMenu。

`0x4e8578(item,source16bytes)` 会复制**完整16 bytes**到 `item+0x18`，强制 `item+0x27=0`；`0x4e85b0` 可用 `%s` 读该缓冲。它是候选短标签 setter，调用方至少提供16可读 bytes，不能传只有字符串长度的 buffer。它是否覆盖/参与实际资源标题绘制尚未确认。

visible/enabled 可由原厂 property `VT+0x40` 获取；没有 property 时用 byte `item+0x30 / +0x31`。setter `0x4e86a0 / 0x4e8700` 会发 change event，有 property 时告警不能由手动值控制。菜单移除与 listener 注销完整契约仍未确认；这是可恢复临时菜单接入的必要门槛，禁止只删列表指针或直接 free。

## 6. 原厂按钮、触摸事件、硬件键

`ControlBindObserver 0x4ac660(control,observer,w2=tag)` 保存 observer `+0x60`、U32 tag `+0x68` 并置 flag `+0x42`。`ControlBindEvents 0x4ac6a0(control,observer,x2=8byte过滤值,w3=tag)` 先调用 Control `VT+0x120` 配过滤值，再 `VT+0x110` 配 observer。

注意两种 ABI：filter 是 **8 bytes 按值**，`0x4ac700` 保存至不对齐 `control+0x72`；触摸事件是 **指针**。`0x4acc5c(event*)` 指令 `ldr w0,[x0]` 只读首 U32 种类。`0x4ac590` 通过 observer `VT+0x10` 调用：

```
x0 = observer subobject
x1 = sender Control*
x2 = event*               // 首U32 kind；其余布局/大小未确认
w3 = control tag
```

native callback 中出现 kind `1 / 8 / 0x20`，不能据此命名所有手势，也不能只分配4 bytes 伪造完整 event。event 生命周期只可借用本次回调；不可把裸指针排到编码线程。

LV observer 必须传 **LV+0xe8**。该处 `VT+0x10=0x520298`，指令 `sub x0,x0,#0xe8; b 0x51f9fc` 把次级 this 转主对象。native ctor `0x518f3c..0x518f54` 就这样绑定 tag9。tag9 的 kind1 分支调用另一 Dialog 的 `VT+0x148`，**没有证据说明它是“关闭按钮”**，不得沿用此前误称或将原厂 tag9 改作录像。

可复用普通 `UiButtonControl` ctor `0x4cf9f8(this,w1=width,w2=height)`，VT `0xb8b260`。颜色字段至+0x8c，不能据此推断完整分配大小。其 down/up 会改变颜色、发 invalidate。`UiIconButtonControl` ctor `0x4d3ef0` 确有原厂分配 **0xc8**，继承 `0x4aee7c` 初始化的另一 Control 基类，**不是**上述 simple Button ctor。

IconButton 调用 ABI：`x0=this,w1=W,w2=H,x3=resource*,w4=iconID,w5=alternateIconID,w6=mode,x7=Color*/value-wrapper*`，第9个 U8 参数位于调用方 `[sp]`。原厂 callsite 518ef4..518f20 给 W150,H100,icons0x562,mode0,第9参数0。资源与 Color 的语义仍需现有对象核验，不制作 guessed icon。

原厂 Control child 挂接 `0x4ab898(parent,child,w2=X,w3=Y,w4=flagA,w5=flagB)`，两个 flag 的名称未恢复；`0x4ab984` 将其写入 child+0x30/34/44/48，随后调用 parent `VT+0x50` → `0x70c6c8` intrusive child list。`0x70c9bc` 为 node detach（改 parent/prev/next links），不会 delete child。不要假定 AddChild 接管所有内存或 destructor 自动清 children；应先解绑回调、脱树、确认无 pending UI event，再由实际所有者释放。

硬件键走独立接口：manager `0x4e3b78` 选择当前 Dialog 的 **+0x80**；接口 `VT+0` down、`+8` up、`+0x10` repeat。LV thunks `0x51f244 / 0x51f270 / 0x51f330` 均减 this 0x80，分别到 `0x51f184 / 0x51f24c / 0x51f278`。

- down：`x0=KeyHandler*,w1=keyID,x2=8byteKeyState`，返回 bool consumed。
- up/repeat：同前，再 `w3=repeatCount,w4=elapsedMs`，返回 bool consumed。
- 原厂处理0..3；具体物理按键名称、布局/方向对应未证。manager 默认 keyID5 作 none，首次重复600ms、后续100ms。
- 首版 F4 应只在其页为 current 时消费指定键；触摸与硬件输入统一到录像动作，但不要用 TouchEvent* 替代8byte KeyState，亦不要直接把 pointer-down 槽当 hardware down。

## 7. Paint / Surface 契约

`0x51da18 mov x19,x8` 与 prologue 分别保存 `x0,x1,x2,x3`，证明 native paint ABI 是 `Rectangle24 paint(this,Surface*,renderRect*,clipRect*)`，使用 **AAPCS64 隐藏返回 x8**。Ghidra 显示多出的首参是恢复误差。手写调用时不能当 `void paint(...)`；C/C++ 对象 ABI 与24-byte struct return须与本版匹配。

显示绘制仅用原厂 compositor Surface。Surface rectangle 填充、mutable clip 和 Color 的静态证据已在 `F1_DISPLAY_ADAPTER.md`，本次不修改该材料。原厂 LV raw frame buffer 与 UI compositor 分开，F4 encoder 不能把含页面文字/构图遮罩的 Surface 当源；反过来 UI 也不应写 capture plane。

新页面初次验收应先证实 native Controls/Surface 与指针点击、硬件键、退出回原厂能够正常运行；然后接 producer/encoder/file backend。当前没有目标页面截图、实际触摸或文件关闭证据，不计临时实机或持久完成。

## 8. 必须由唯一设备执行者验证的最小清单

1. 精确主 ELF 读回/比对、原件与配置备份；独立恢复路线和写入能力，按 `FILE_READ_TRANSPORT.md` 的认证/SDK gate 原样处理。
2. 有效 UI 线程执行入口与 manager/LV/resource runtime pointers；vtable bytes 与当前机固件匹配，按一次native event验证对象生命周期。
3. 先无录像操作地显示原厂页和新 Controls：点击一次只发一个动作，硬件 keyID有正确映射，能够返回原厂，无悬挂事件/脱栈失败。
4. 完整菜单 undo/listener detach、Control observer解绑、callback停用，再释放 adapter自有内存；原厂驻留 LV 和资源不删除。
5. 新页面覆盖/退出时 LV owner、producer、锁、timer、帧刷新是否保留；只有 owner/锁生命周期确认后才能录制。不能同时让两个consumer猜同一个锁。
6. 录像 stop/error/back 都先停接帧、drain/finish/flush/close并确认结果，再按native Close返回；禁止在UI handler持LV锁同步长时间编码或卡写。
7. 帧真实尺寸/stride/counter/timestamp，1080p60唯一帧与卡速由实测决定；卡路径存在和恢复、专属页能力显示必须引用实测结果。

当前与 native codec 的关联风险仍独立存在：其他代理正在核对 `jpeg_CreateCompress` 的 version/struct-size 参数82/584；本UI材料没有验证其 ABI，不因找到原厂页面而解除 codec、buffer、卡文件或执行/恢复门槛。

## 9. 证据层级

| 项目 | 本阶段结论 |
|---|---|
| Native Dialog/Menu/Control/KeyHandler call chains | 静态指令+bytes confirmed |
| 类型名、部分字段/动作语义、完整 C++ vtableABI | 静态候选；未知字段明确保留 |
| 主机 UI / target函数执行 | 未执行；没有桌面替代完成声明 |
| 真实 IQ4 新页面/开始停止/返回/错误恢复 | 未验收 |
| 相机持久部署/禁用/恢复 | 未制作或安装，本文件不提供注入安装物 |
