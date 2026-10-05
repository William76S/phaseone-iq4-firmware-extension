# F1 原厂几何 / 绘制有限观察源码 03

已交付可链接 C++ 只读探针、几何纯模型和生产禁用 port。冻结 overlay01/UI02 未修改；本增量未接相机、未打开 SDK、未调用原厂函数、未写文件/指针/事件，也未读取捕获或显示像素。它是静态分析、主机验证和 AArch64 仅构建结果，不能记为临时实机或机内遮罩验收。

精确 User 输入为 11,874,544B、SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`。所有地址仅属于该 User；代码/rodata file offset=VA−0x400000。`f1_geometry_probe_03/static/exact_bytes.json` 保存28个完整函数/函数组或注明的局部窗口、5个表的精确 bytes/offset/hash。没有使用 Factory、GR/X2D 地址或公开私有反编译文件。

## 本轮闭合与更正

1. `0x51f55c` 将 **LV+0x110 对象**传给 `0x4c4a54`；后者读对象+0x20 的 animation，其 bool 在+8，故对应 LV+0x138。活动时 `0x4c4a98` 调计算，`0x4c4a9c` 向对象+8写新 Point8，`0x4c4aa4` 返回对象+8。因此 cached pan 是 **LV+0x118**，不能把 LV+0x110 前8字节当 pan，不能调用这个 getter 后声称纯读。新 probe 读取 cache/animation，旧冻结资料的候选错误没有就地修改。
2. `0x4ab9d8..4abac8` 的 recursive bounds 经 parent VT+0x18（默认 `0x70c4c0` 读 Control+8）、VT+0xb8，再调 self VT+0x130=`0x4abac8`。alignment flags 为 Control+0x44、padding +0x48；左右 stretch 会在 `0x4abb94` 写 Control+0x38，上下 stretch 在 `0x4abc40` 写+0x3c。新源码只对自己的 Rectangle 做同运算，16层上限，未知 helper/循环拒绝候选；不调用这个 getter。
3. `0x51db58/68/80` 获取 locked size、LV metadata、ROI；具体是 Access `0x6b61fc/614c/621c`→engine `0x6b6d44/6dec/6d68`。VideoBuffer 为 engine+0x2170，locked index+0xe8，slot size+0x50+8*i、ROI24+0x70+24*i。index4是无锁，native getter返回零/错误路径；probe不读这一槽的大小/ROI/ID。metadata 为 engine+0x4760，+4/+8 对应配置宽高。这里没有足够证据把它命名成 RAW/传感器全幅。
4. 源点原链 `0x51f50c..0x51f690` 使用 recursive rectangle、source/scale 的整数截断、cached pan、矩形原点，再按 metadata/scale 居中。原 paint 以 ROI 宽高/scale 形成 destination rectangle，`0x4dec34` 对 drawRect 左上角做**减法**；`0x477038` 再用 source slot size 与 quarter-turn 的 fit 矩形。probe 的纯 point/fit 模型分开输出；完整配置/ROI/源帧/viewport/focuszoom 语义仍待实际比较，未输出猜测 affine。

## 真实 paint 上下文可检查的参数

原 `Control::Draw 0x4abd24` frame=SP、size0x140；保存 this/LV+0x48、Surface+0x40。`0x4abe90` 的 VT+0xa0 调用传 x0=LV,x1=Surface,x2=FP+0xb8 的变换 drawRect,x3=FP+0xd0 clip,x8=FP+0x50 的24B输出，caller LR=`0x4abe94`。`Manager::Draw 0x4e32d4` frame size0x160，manager在+0x28、provider getter得到 Surface存+0x148、当前 LV存+0x150；在 `0x4e33b8` 调 LV VT+0x98，返回 LR=`0x4e33bc`。

`collect_paint_scope` 要求调用者在**自己的真实 paint wrapper**捕获 FP/TP/LR和 incoming args，再精确核这些保存字段、两个向上且有界的 saved-frame、同一 UI owner/current primary LV，以及 Surface/Draw VT和有限 bounds/pitch。只有普通 primary LV直接 manager→Control→paint 形态可通过；idle UI boundary、子 control、未知 caller、不同 Surface均拒绝。源码没有安装这个 wrapper，当前 Observe SO可以直接接 `collect_boundary`，没有 paint hook 时不能伪造 paint input。

Surface ctor `0x46cc8c..0x46cd34` 完整函数证明+0 VT b7b780、+8 Draw、+0x14 pitch pixels、+0x18 height、+0x20 Rectangle24、+0x38像素指针。probe只读+0x38之前及 Draw的VT，不读这个指针或像素。实际 provider从 manager+0x108 取得，`0x4e3330` 调其VT+0x18；当前 callee/type/lifetime 未闭合。通过保存栈和 bounds只证明词法上下文一致，不证明可借用显示 lease、更不证明独立于捕获像素。

## full repaint 的明确反例与最窄止点

`0x51dd40..74` countdown非零时跳过 image blit，却仍在 `0x51ded0..d8` 返回输入 drawRect。countdown0路径 `0x51ddcc` 才调用 `0x477038`。新 frame的软件 ID、非空 rectangle、dirty union、invalidate/UiIQ4Redraw通知都不能证明完整底图已恢复。

`0x477038..0x477384` 首先 `0x476e6c` 写 fit rectangle，然后分0/90/180/270调用 pixel dispatch，但会丢弃内层返回 Rectangle；输出仍为fit。`0x47552c..0x475a7c` 的zero-degree路径先裁 source copy 再写 pixels，最后从**原始未裁 source**构造返回矩形。因此两个 blit返回都不能充当 actual clipped coverage。

正向静态 RGB24 display-write 路线为 `0x47583c..0x475904 → 0x47f910`：从source格式0、stride和3字节索引计算源，从Surface+0x38、4字节显示像素和pitch计算目标，Draw owner是Surface+8。`0x47f910` 在 `0x47fa18` 读 Draw VT+0x18：等于默认 `0x47e9d0` 则走inline row/memcpy fastpath，否则到 `0x47fb34` 的通用虚调用。默认 row wrapper `0x47e930`→`0x9e9598` 的有限 leaf 用 ST4 写 `[255,c0,c1,c2]`。同尺寸、带options及其余旋转尚有其它 row分支，不能从这一分支宣称所有 paint已完成。

直接换 Draw VT+0x18 为观察器会改变上述 fastpath，且共享 Draw owner范围未实测，不是已证明透明的观察 hook。此次只提供完整相关函数窗，不制作其注入或参数转发接口。要取得 fresh receipt，下一增量需 actual inner branch/normal-return/Surface identity/有效source descriptor/clipped coverage/request-generation 的同次证据；计数或返回 rectangle仍不够。provider VT+0x18的有限实际类型/target读取是显示 lease的下一止点。

## 最小实际观察清单与启用边界

Root的唯一设备执行者在已完成恢复前置下，可先用新的 source链接其 Observe-only模块，实际只读取得：

1. runtime User全 hash、load bias/segments、真实original-firstUI TP/frame/mutex/current LV chain。必须仍是原LV VT；shadow需要新完整该实例table/phase receipt，不伪装旧VT。
2. `README.md` 有限字段表：local rect、pan cache/animation、scale/normalfit、rotation/countdown、LV/Access owner aliases、config/locked size/ROI和software ID，至少两个相同快照；changing/unknown保留。比较原厂正常/焦点放大/平移/旋转时的实际可见viewport，才能决定完整源语义。
3. 在实际已有可恢复 paint wrapper后，用 `collect_paint_scope` 核真实 frames/args及Surface。另有限读取 manager+0x108 provider 的actual VT/VT+0x18 target并绑定其静态body，不调用 getter。
4. 跟踪原厂实际 clipped display-write 和同次Surface lifetime，包括 partial/no-frame/countdown 与异常反例；从完整源→屏幕得到verified映射，而非local bounds猜测。
5. 之后才在新的 enabled increment里将真正证据接 overlay01的geometry/fresh/lease ports。OFF/退出必须覆盖旧、新 viewport及原 image，再还原同一instance vptr；所有 observer/module保留直到真实无在途回调/队列边界，恢复不得依赖 SDK在线。

`Facts` 与 `PaintScope` 的 full-source/fresh/lease全部固定false；`unavailable_geometry_port` 清 ViewMapping/epoch且返回false；`fresh_receipt_unavailable`清Receipt且返回false，caller提供成功booleans也拒绝。因此本源码可先做真实有限观测，不能把记录里的consistent条件升级为生产放行。

## 可复现验证

normal与ASan/UBSan各30组实际通过，覆盖owner/VT/Access aliases、pan cache变化、无锁slot4、借用保留不授lease、非法scale/rotation/尺寸、parent循环/未知helper/布局写候选、有限读取区域、paint wrongcaller/frame/args/Surface、quarterturn fit和居中纯模型。独立生产3组验证Selector保持Disabled且零native读/调用，fabricated geometry/fresh receipt不能通过。

使用现有锁定 Zig0.15.2构建 own AArch64 ET_REL与link-only SO，未在目标执行。own probe object无init/fini数组，无安装/信号/exec/SDK入口；SO不自动链接默认C++runtime，其未解析符号与依赖据实记录，不证明相机loader/原厂C++库ABI兼容。collector/manifest/source ZIP均能通过 `tools/firmware/f1_geometry_probe_03/freeze.py` 与 `validate.py`复核。目标实际所有权、完整映射、freshblit、lease、安装与验收仍全部false。
