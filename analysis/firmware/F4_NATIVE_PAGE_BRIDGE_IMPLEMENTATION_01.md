# F4 专属原厂页面适配最小阶段 01

本阶段完成无原厂调用的有限页面状态桥与可构建ABI声明。证据层级是已有静态指令、own-code主机验证和AArch64 ET_REL编译。没有真实对象构造、原厂菜单/页面注册、设备/SDK、触摸或按键验收、截图、卡lease、现场worker、模式或持久部署。生产binding硬禁用；静态候选未当作可用接口。

## 复用与原厂契约

项目内没有字面`native_page_static_evidence`路径；对应已有效材料为冻结 `F4_NATIVE_UI.md`、`f4_ui_static/exact_bytes.json` / `F4_UI_STATIC_EVIDENCE_SHA256.json`，以及 Bootstrap03原UI队列边界/counter和 `src/runtime/recording.hpp/.cpp`。本阶段不修改这些材料，不重复worker、copy pool、codec或container，也不制作桌面UI。

所有native labels只绑定User ELF 11874544B/SHA `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`。未使用Factory、GR4、X2D地址，未将包内6.03.21名称当成当前runtime固件身份。`native_abi.hpp` 将已有指令契约编译为静态类型，保留未知部分：

| 冻结证据窗口 | 有限形态 | 仍未证明 |
|---|---|---|
| Dialog ctor0x4e10c4、base0xd0 | this、持久name、manager | 新derived对象size/vtable全范围、真实allocator/placement/生命周期 |
| Show0x4e12c8、Close0x4e1320及manager栈链 | this单参数 | 新页current、LV继续产帧/保留锁、实际return/undo |
| LV paint0x51da0c、F1 Rectangle24布局 | this/Surface/renderRect/clip，24B x8隐藏返回 | 调用方C++复制/析构、有效native vptr、真实Surface生命周期；不能用四整数或void-return paint |
| Control observer0x4ac590 | observer/sender/borrowed event*/U32 tag | event其余layout、touch动作语义；kind1不能直接当任意“点击” |
| KeyHandler down/up/repeat | handler/keyID/8B按值KeyState，up/repeat额外count/elapsed | 物理键0..3名称/映射；不能用TouchEvent*冒充KeyState |
| MenuLabel0x4e8578 | item、完整16可读bytes | 实际resource标题/render、菜单注销及listener撤销 |

IconButton0xc8分配已知，但resource/Color/第9stack参数和实际对象owner仍待核，未实例化。simple Button完整size未确认，未猜定长度。原LV驻留对象0x1310、enter0x51d884、exit0x51d9bc→真实stop0x520590的已有链保留；51ea88仍为touch，不是paint。新页Show不会自动调用旧页exit的静态反例同样保留。bootstrap constructor不能拿UI模型指针假冒queue，页面adapter只能在Bootstrap03真正UI dispatch回调/后来边界上运行；counter通知可能合并，不是源新帧证明。

## 有限状态桥实现

`tools/firmware/f4_native_page_bridge_01/page_bridge.cpp` 是own-code ports层，没有将port函数指针冒称原厂ABI。未来原厂binder须完整实现UIPort的enter/render/return，以及WorkerFence；当前生产permitted无条件false。全部bindings true也先返回Disabled，不调用current-thread或backend。synthetic宏仅出现在host测试编译，target ET_REL没有该宏。

binding要求当前完整User身份、真实Bootstrap03 UI边界、page ctor/vtable ABI、compositor Surface/resource、实际touch→action映射、current/returnLV、完整undo/lifetime及source stop/drain fence绑定。UI和Recorder owner token非零且不同，每个方法核当前线程。未复用Bootstrap03的真实UI owner地址作为未注册的worker身份；真实thread getter/worker绑定仍须独立证明。

UI事件只统一为Start/Stop/Back/ResetError，不保存原TouchEvent、Frame、Surface或像素pointer。原触摸/硬件handler的实际映射尚未写入；不能把未知tag9改成录像。UI最多一个pending动作，通过4-slot SPSC到唯一Recorder executor；拒绝重复start/stop和跨线程调用。16-slot返向队列为owned、固定快照，单个poll最多16条，不等待，不分配UI工作对象，不编码/写卡。普通status队满可丢并计数，控制ack没有槽时不pop/不运行Recorder，防止收尾结果丢失。

native pending UI render成功后才发布动作，render失败不能发布新Start。UI未知进入Hold，在下个真实worker tick上请求同一非阻塞WorkerFence停源/排池。Pending逐tick观察同一幂等请求，不pop此前已入队但未消费的Start，也不关闭容器；Unknown固定为终止性Hold，保留所有context/open session，不finalize、不重试；只有Ready确认源已停、租约解除、池排空且不会继续投递后，才最多一次stop当前Recording的Recorder。Idle标记QuiescedNoRecording，Error标记QuiescedError；都不称成功文件收尾。Recording的stop返回成功才记录Finalized，失败/异常记录FinalizeFailed，均不自动returnLV、detach或hot-unload。typed atomic HoldProgress可读回固定状态，无需跨线程读取Recorder。若原厂UI入口或owner丢失、worker本身未运行，实际停止/恢复仍属独立实机条件；此源码不能保证故障线程被调度。

worker复用原Recorder的start/stop/reset_error/exit_page，codec/card/owned-frame交接未重写。外部WorkerFence须非阻塞地向原source owner请求停止接帧，并实际确认native租约已解除、owned pool排空；Pending保留命令等待下次tick，Unknown拒绝/保持Hold，只有Ready才允许Stop/Back drain/finalize。Ready还须维持禁止本session后续源投递，直到验证过的Start明确重新arm；终止性UI Hold不会重新arm。外部worker必须按原source owner协议停止新接帧并排空既有owned copy，不能在返回Ready之后继续向已关闭容器投递。没有从Recorder Idle、queue长度估计或cached bool推断Fence。Back成功ack之后才在UI线程调用returnOriginalLV；文件finalize失败留在Error，Back可在worker上abort/reset该失败session、保留后端恢复材料后返回，不冒称成功文件。返回原厂接口失败保持Hold，不再调用第二次。

native context始终retained，Closed仅表示own-code页面返回port成功，不表示native observer/menu节点/global event/SO可free。实际bindings必须保留所有context与module，结合Bootstrap03后来UI边界、actual pending/triple及原厂对象owner另行验证；没有hot-unload或自动删除原对象。所有new-source GUI/field操作仍不得碰捕获plane、UI保留锁或RAW/JPEG像素。

## 能力与错误字段

能力默认全false，Unavailable。仅actual clean源、真实布局/颜色、encoder、卡lease、publish/recovery、worker和实际mode全证明后才提供actualW/H并允许Start。保留rate未知时仍可显示已验证mode；software completion通知数是独立字段，从不换算FPS，也不会将3695次通知或SDK标称速率变成1080p60。

fps字段需rate basis为独立测得distinct capture frames、独立验证旗标和非零实测分子/分母，才进入View。所有host gates/sample60都是合成fixture，绝不写actual结果。停止/错误/准备阶段按实际Recorder状态显示；录制指示只在Recorder Recording且至少一包成功encode之后亮。固定ErrorCode区分RecorderFailure、WorkerException、SourceFenceUnknown和NativeUIUnknown，不复制backend路径或把匹配错误字符串当特殊成功证明。

## 验证与下一步

22组host normal/ASan+UBSan/TSan，独立production guard证明零ports/backend/native调用。测试使用真实原Recorder和mock后端，覆盖：UI先发布/worker才prepare、first encoded packet指示、跨线程拒绝、completion count不变FPS、未证卡Unavailable、Back先Fence Pending/Ready再finalize/return、failed finalize/prepare与error reset/abort后返回、ack背压、render失败禁Start、UI Hold Pending→Ready先停源/排池再收尾、Unknown不收尾不重试、旧未消费Start保持未执行、Hold收尾失败固定记录、FenceUnknown不返回、notify倒退Hold、20次启停、各binding bool缺失拒绝、source_lost状态、rate独立验证gate、return失败不重试、双线程UI→worker Start/Hold/Pending→Ready与20000次并发SPSC。这不是实际native widget渲染、原厂线程时序或卡恢复测试。

目标为生产禁用AArch64 ET_REL，无main/init_array/fini_array，未链接/加载SO或运行目标。imports没有SDK、device、signal、filewrite、dlopen/exec或新线程。它对现有Recorder类型与C++17 ABI的编译兼容不等于原厂C++ runtime可调用；实际module全依赖/ABI仍须原loader/原User上下文验证。

最短下一步：闭合原厂新Dialog/Control实际构造storage/vtable/resource与退出detach，沿Bootstrap03真实UI dispatch做只读render/Unavailable-page probe；记录一次真实输入与returnLV/undo，再让actual source/worker/card adapter提供Fence，最后按实测mode接Recorder。当前既无enabled generator/安装物，也无临时实机或持久验收，1080p60保持未证明。此阶段交付完整有限桥源码与可复核static type契约，不宣称机内专属页面已完成。
