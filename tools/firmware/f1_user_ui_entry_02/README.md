# User 固件 UI02：Grid 开启时仍可找到按钮入口

这是冻结 UI01 的独立有限派生；原件全部保持。源码与实际九个 AArch64 ET_REL 交给固件 append 后端，默认请求 OFF，未运行目标、未安装固件，也没有 SDK、Windows、ptrace、设备或网络入口。五档选择的真实 native 按钮/popup/queue callback→mode→原全 LV invalidate 调用链继承 UI01；机内入口和遮罩显示尚未验收。

UI01 将每个 visible child 的视觉 Rect 视为按钮占位。原 Grid 打开时 Rect 为整张 viewport，虽然原 click/longpress hit selector 在 Grid 与五条 line 的 flags41/42 为零时均不返回这些节点，UI01 仍会 failure11。UI02 两个真实调用点（runtime 的首次空位搜索、Binding 的创建前复核）共用 `display_grid.hpp`，仅把验证通过的原 Grid 视觉矩形排除按钮占位。其它 visible child 保持原严格矩形规则，原按钮 tag1/8 不变。

排除需要实际读取 `*(LV+0xd48)==node`，Grid VT `0xba6540`、parent=LV、VT+0x140=`0x4ac32c`、flags+41/+42 都零、observer+60 零。随后读 Grid+0xa0/+a8/+b0/+b8/+c0 的五个不同 line 指针，核它们 VT `0xba6880`、parent=Grid、同一继承 handler、零 click/longpress flags、零 observer、无子树；真实 first(+10)→prev(+18)/next(+20) 链必须恰好遍历这五个节点且末尾为空，再读回 first 与 LV Grid 指针。不调用 unknown getter；检查失败时仍把 visible Grid 计为占位。

原完整 hit selector `4ac32c..4ac590` 在 mode0 只在+41非零时返回 self，在 mode1 只在+42非零时返回 self；**mode2仍可返回 self**。本修正没有改变任何 hit handler，不声称全部 pointer 类型 pass through，不关闭或改写 ShowGrid、Grid visibility/geometry/flags/observer/parent。证据是冻结 `analysis/sdk_reference/f1_user_ui_entry_01_independent_review/manifest.json`（SHA `ba3799f3832561affd776b0965685b4be8f6d2ca2546a508c451589de8f21406`）及其完整 constructor/hit-selection 字节窗口。

`test_grid.py` 只编译/运行自有 memory fixture。实际 runtime finder 完整函数体及实际 Binding.free_placement 都进入测试：Grid on/off、旁边真实占位按钮与全屏其它控件、active click/longpress、observer、错误 VT/owner 指针、未知第六子节点/孙子节点、坏双向链/重复 line/handler/读取失败共16例，normal 和 ASan/UBSan 都 PASS。Module/持久 Binding 的 cap/Hold/Detached 回归没有重复；相关源码与冻结 UI01 完全同字节，保留其已有回归证据。

`materialize.py` 只核本派生来源与生成窄 diff；读回 UI01 的798冻结行，绝不改写旧件。`build_objects.py` 编译九个真实 ET_REL，`OBJECTS_AND_BINDINGS.json` 列完整 object/source/import 身份。保持全部 unwind/EH/LSDA，不用 GC；无新增 TLS/outline atomics。依赖列表仍与 UI01 相同：只 `_ZSt9terminatev` 需后端真实 GLIBCXX_3.4 动态绑定，不能将它猜成另一函数。

共享 `state.h` 保持原64B/schema1与 `_01` C符号，SHA `5219328b04dd33c4e455830d196eb9fd0e55964a284bf22591e0aa752285188a`，因此冻结 DisplayPayload12 可原样消费。三个原 BL、原340 init-array顺序/最后追加 initializer、原代码窗口和独立 mapped libpthread 绑定、exactly-once 原 ctor/unlock、实际 recursive registry mutex、持久 TLS/listener、64观察 cap、Hold/Detached 拒绝、OFF与原 invalidate 均保持 UI01。Ready/request/OFF不是 Surface lease、像素清洁或五档已可用的证明；未知 owner/layout 仍保持原界面。
