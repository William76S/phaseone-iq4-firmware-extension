# F1 原厂 LV post-paint 接入源码阶段 01

本阶段已经实现并验证四矩形遮罩适配源码，复用原有 `src/display`；生产绑定固定禁用。没有连接设备、启动 SDK、调用原厂函数、写入相机或修改任何已冻结版本。F4 页面 adapter02 已暂停并保留 WIP。本报告属于静态分析、主机验证与目标仅编译，不是临时实机或持久验收。

## 精确版本与可复核窗口

外层固件 `Firmware-BP-IQ4-IQ4_6.03.18.fwr` SHA256 为 `a52758ffb163023e5323297e450450f91002175b69bed7590fe2cd037c2ab300`。内层 User ELF `analysis/firmware/extracted/P1Linux_6.03.21.bin` 为 11,874,544 bytes，SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`，BuildID `1f451370d713ae1f341e9d5de5615717f9fb36ed`，ELF64 little-endian AArch64 ET_EXEC。内部程序版本不能代替设备固件版本，也不能把本地包当作真机原件备份。

`f1_native_overlay_01/static/exact_bytes.json` 保存 15 个完整函数/有限窗口和 5 个原表/边界的精确 bytes、file offset、SHA256、反汇编哈希。捕获代码和 rodata 的 file offset 为 VA−0x400000。没有使用 Factory、GR 或 X2D 地址。

## 最短原厂挂入候选

原厂 LV primary address point 是 `0xb9a9d8`；slot `+0xa0` 指向 `0x51da0c`。原表前的 ABI header 在 `0xb9a9c8`：offset-to-top=0，RTTI=`0xb9ae20`。header16B 加 primary59 slots 共 `0x1e8` bytes；紧接 `0xb9abb0` 出现 offset-to-top=−0x80 与同一 RTTI，证明下一 secondary 表边界。候选仅复制这块表到私有 RAM，改 paint 一项，再替换**当前已证明 LV 实例的 primary vptr**。不要修改全局 `.rodata` 表，不改源缓冲或文件。本阶段没有写表/安装器或目标启用产物。

`0x4abd24..0x4ac06c` 的完整 Control draw 路径在 `0x4abe48..90` 取 parent VT+0xa0，再传 x0=control/LV、x1=Surface、x2=drawRect、x3=clip、x8=24-byte Rectangle 输出对象。parent paint 完成后才在 `0x4abf38..7c` 调各 child VT+0x98。因此 original-first 的 LV paint wrapper 可在原厂图像之后、原厂 grid/toolbar child 之前绘制四 band，保留原厂 UI。这个顺序是静态证明，实际 UI 线程及该实例边界仍待验证。

候选原型是 `Rectangle24 paint(LV*,Surface*,const Rectangle24*,Rectangle24*)`，Rectangle24 含 native address point +四个 i32。`0x51da18` 保存 incoming x8；`0x51ded0..d8` 将 drawRect 复制到该输出对象。自有 compile-only C++ forwarder 的 AArch64 反汇编只重排 x0..x3 然后 `br x5`，x8 不变。这仅证明自有类型的 AAPCS 转发；原厂 C++ 生命周期、返回对象析构、异常 unwind 与真实 callback 路径未验收，不能凭编译探针开启注入。

原 paint 必须且只能调用一次，并保持输入/返回和异常语义。overlay 不重新调用原厂 blit，不传原 RGB24 descriptor，不读取 capture pixel pointer，不抢解 source lock。配置/select 在原 UI owner 上进行；paint 内使用最多四个预先计算矩形与局部 Color/clip，没有分配、文件/编码/等待操作。

## 新闭合的 paint 与恢复反例

| 地址 / 实际证据 | 对接约束 |
|---|---|
| `0x51da30..5c` LV+0x104=false 返回零矩形；`0x51dab0..51db4c` LV+0x188 无有效 lease 也返回零矩形 | 正常 paint 返回与当前 LV/display owner lease 都必须实际核验 |
| `0x51dd40..74` LV+0x1b8 非零时，不论 ID 相同或递减都跳过 image blit；后面仍可返回非空 drawRect | 不能把非空返回、原软件 completion ID 或 dirty 标记当新底图已恢复 |
| 只有 countdown=0 的 `0x51dd78..e4` 路径在 `0x51ddcc` 调 `0x477038` 原厂图像 blit | pre-countdown=0+正常正面积返回仅是静态 branch 候选；actual blit 完成与覆盖区域需要真实 receipt |
| `0x51ddf8..51de2c` 只有 LV+0x1c0=false 调 `0x6b6250` 解锁，true 保留 LV+0x188 借用 lease | original paint 后并非总已解锁；overlay 不读 lease 或调用 unlock |
| `0x4abecc` 调 `0x46ce24..a4`，仅将返回矩形合并到 Surface+0x40 dirty rectangle | dirty union 不是 clear；OFF/退出必须观察完整原厂像素重绘 |

适配器要求 caller 提供 `actual_native_image_blit_completed`、实际 `actual_stock_repaint_coverage`、clip、configuration generation 和 geometry epoch。同一次 serial 不会重复应用 alpha。切换 viewport 先等待旧/新 union 完整恢复；成功后清理要求收敛至当前 viewport，避免已清理旧区域永久阻止绘制。移位/缩窄后的这个反例已加入主机测试。

## 可复用填充 ABI 与坐标止点

`0x46f370..430` wrapper 的参数 x0=Surface、x1=draw Rectangle、x2=input clip、x3=Color；内部复制 clip，将 draw 的 right/bottom 转为 inclusive 坐标并调用 `0x46f430`。Rectangle 为 24B：+0 address point=`0xb73b98`，+8 x，+c y，+10 width，+14 height。Color 为4B，+0 alpha；黑色为 `[alpha,0,0,0]`，本阶段65%对应166。坐标版会交换反向端点，零宽会扩大为两列，因此源码先拒绝无正面积区域。

Surface ctor `0x46cc8c..4c` 与扫描线 `0x46d524..754` 证明 +0 VT=`0xb7b780`、+8 Draw owner、+14 pixel pitch、+18 height、+20 Rectangle bounds，+38 是32位显示像素 pointer。Draw VT=`0xb7b7d8` 的前两项为 fill/blend。源码有限读取 `[Surface,Surface+0x38)` 与 Draw 的8B address point，**不读取 +0x38 或像素**。它只把当前 callback 的 Surface 交给已绑定 fill port；这不代替 runtime display owner/隔离验证。

`0x6b61fc→0x6b6d44` 提供当前 LV width/height pair，`0x6b621c→0x6b6d68` 返回 Rectangle ROI。`0x51f50c..690` 读 metadata+4/+8、LV+0x190 scale、LV+0x110 pan 及 LV VT+0xb8 的矩形，做源点到屏幕位置并在缩小图像时居中；原 paint w5 rotation 来自 LV+0x1b0。这些字段证明原厂已有几何链，但尚未证明 full-source/ROI/zoom/rotation 的实际语义，不能称其 RAW 全幅尺寸或直接拼一个猜测 affine。

既有 quarter-turn 证据允许四个带在轴向缩放/平移及90/180/270度时仍为矩形。新源码要求四个角精确位于 bbox 角点，不用浮点 epsilon 将真实 shear 当矩形；1e−12 shear 越过画幅保留区的反例已拒绝。非轴 geometry 仍交回隐藏/拒绝，不调用矩形填充。

## 最小下一步事实与恢复契约

1. 唯一设备执行者先证明实际 User hash、映射段、原 UI owner/current LV primary-vptr，以及 callback Surface/bounds/Draw，观察本轮原图是否真正 blit 与 clip 覆盖。第一次 probe 只有限元数据/计数，禁止像素和 RAW/JPEG 入口。主机 gate bool 不能冒充这些事实。
2. 同场景核对当前源尺寸/ROI/缩放/焦点放大/旋转与目标 viewport，再将**几何量**绑定已有 ViewMapping。未知时隐藏，不猜传感器画幅。原厂 grid 比例候选仍未给出65:24四band接口；`0x51ea88` 是输入/event slot，不能当 render。
3. 正向落实现存原厂 menu/action 的五项选择与 OFF 绑定；本源码只实现页内 select port，没有新 GUI、未知属性写或按键命令。`0x4ac06c` invalidate 只是标记/转发，还不能保证下一回 full blit，`request_stock_repaint` 仍是待闭合 port。
4. 若采用 RAM private-vtable，一次 UI boundary 安装前保全 instance 原 vptr、表原 bytes、被修改 runner/config 双原件与实际 RAM mount；不修改 User 文件的 RAM probe 不要求人为增加 User12MB双导出门。任何持久 User 写另需真机完整原件与独立恢复。
5. disable 先停止新 band/select，要求原厂当前/未清旧 viewport 完整恢复；只有对应 actual repaint receipt 才标记像素恢复。随后在实际 UI owner/no-inflight callback 边界比较 own table、还原同一实例原 vptr并确认 stock repaint。callback/module retain，直到 independently proved quiescence；对象离开/析构、未知 owner 或异常进入 Hold，不盲写失效指针或卸载。
6. 监督退出/stock fallback必须不依赖 SDK 活跃连接，现有 RAM loader/Bootstrap03 仅可复用源码前置，不把未实机验收的加载、stock respawn、detach 升格为恢复证明。由 Root 串行验证临时修改→禁用→原厂返回及同场景 RAW/JPEG 隔离后，再决定持久部署。

## 源码与主机验证

`tools/firmware/f1_native_overlay_01` 提供 adapter、固定计划转矩形、compile-only ABI forwarder、host raster/fault tests、15窗口/5表 collector、构建/冻结/验证工具。复用原 `src/core`/`src/display`，不改 frozen 版本。OFF/native、65:24、16:9、3:2、1:1 均有源码状态与主机几何覆盖。

normal 与 ASan/UBSan 各19组通过；4比例×4quarter-turn累计1,048,576独立逆仿射逐像素比较，工具条/框内不变、65%黑只应用一次、输入素材不变。覆盖重复 serial、无fresh receipt、partial repaint、OFF/disable full repaint、旧epoch、错误线程/owner、Surface布局、零area、native fill异常、未知 zoom隐藏、微小 shear及历史viewport收敛反例。production run 返回零 native read/call。

锁定现有 Zig0.15.2 仅构建两份 AArch64 ET_REL，没有 target main/constructor/installer、SDK imports或运行。目标 overlay.o SHA256=`eb7a1592011ec539af79e496c8e1bc3ce6c6f160e72c44cb75206f956786dc81`，ABI probe.o=`5f737b9f39d00bf07dbc7edf1d28e936f2d0cd345949616294850777b80e0c29`。实际 binding、实例hook/恢复、Surface geometry/fresh repaint、RAW/JPEG隔离和安装均为 false；测试的120×80源与256²Surface均为合成素材，不是相机能力或实测尺寸。
