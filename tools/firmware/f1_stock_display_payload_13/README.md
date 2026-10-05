# 原厂生产 LCD 显示 payload 13

本目录是新的 AArch64 ET_REL 汇编/C 对象及主机验证，不是可直接刷入固件。旧 display12、UI02 和全部旧证据保持冻结。固定输入为 User `P1Linux_6.03.21.bin`，11874544 B，SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`。不运行目标，不访问 SDK、网络、设备或卡。

13 修复一个静态确定的类型拒绝：12 只允许 `Surface` 基类 vtable `b7b780`，但原厂生产 LCD 构造函数 `485b34..485e54` 调基类 ctor 后安装 `IQ4DisplaySurface` 主 vtable `b7cf90` 与 +58 的 `IScreen` vtable `b7cfc0`。LCD 初始分配 0x177000 字节，基类构造参数为 800×480 与原 Draw；这给出实际显示 32bpp 和 pixel pitch 800。它不说明 LV 源图像尺寸。

完整供应链有 exact bytes 记录：main `419544` 构造 Draw（vtable `b7b7d8`），`419568` 构造 LCD；`419574` 保存 LCD+58 到 main SP+1de0，`4270d4` 把该 IScreen 作为 x1 传 Configurator；`4ed5d4` 存 queue+1a8，`4edc00` 把同值作为 x2 传 Manager ctor；`4e1c88` 存 manager+108。Manager `4e3330` 调这个 IScreen 的 slot+18；精确 thunk `486db8` 减58后到 `486da4` 返回完整 LCD THIS，再在 `4e33b8` 交给实际 LV paint。12 在这个 LCD 上的 `F1_SURFACE12` 门会拒绝；该门与按钮构造独立，不能解释按钮不存在。

13 仅允许这个生产 LCD：主 vtable、+58 IScreen vtable、Manager vtable及 manager+108=LCD+58、LCD pitch/height/bounds 800×480、Draw vtable与原图/显示范围隔离全部匹配。运行时另核完整 LCD 的96B主/次 vtable，包括两个 ABI header 与所有8个方法，以及 Draw48B完整表。未知 vtable 在读取 +58 前拒绝。`HdmiSurface` 的主/次 vtable 为 `b7c990/b7c9c0`；尽管 getter 具有相似 thunk，其完整输出合同不在本版范围，明确拒绝。基类和其他 Surface 也拒绝，不按“有相同字段”放行。

唯一 hook 是原 LV `BL@51ddcc`，原 LE bytes `9b64fd97`，entry `iq4_f1_lv_draw_wrapper_13`。保持原 x0..x7/hidden x8，恰一次调用原 `477038`；正常返回后才进入 `iq4_f1_after_stock_draw_13`。它继续使用原 on-stack destination/projected/clip/Image/ROI 和全源尺寸、source lock、engine、scale、动画、countdown；仅同一次完成 draw 的当前 Surface 可被填充。原先独立验证的 binary32 full-coverage 与未截断浮点端点门保持原样，不把返回矩形当作写入凭据。

支持五档 OFF/65:24/16:9/3:2/1:1 的 native rotation0、全 ROI、normal fit 分支；90/180/270、zoom、动画、skip、局部源或未覆盖完整 viewport 时继续原厂绘制并隐藏遮罩。原 skip 分支不进入 wrapper，没有保存上帧 callback。四个不重叠半开 band 转为正宽高 native Rectangle，再借原 `46f370` 填充；其 wrapper 克隆 clip 并转 inclusive endpoints，横线地址为 display pixels+4*(y*pitch+x)，原黑色 Color 为 `{166,0,0,0}`。不写源 RGB24、RAW/JPEG/video、校准、密钥、EEPROM或持久配置。OFF 后像素恢复依赖 UI 请求及下一次真实原厂完整重绘，未把 mode0 当作已清除遮罩。

mode getter 保持 UI03 的准确 C ABI `iq4_f1_mode_get_01()`；它由已绑定 UI 模块提供，default/unready 返回0。13 不初始化 UI/线程/TLS/logger，没有新增 mutable RW 全局。wrapper 保留正常返回后的原 x0..x18、q0..q31、NZCV/FPCR/FPSR与callee-saved寄存器。两个对象有有限 `.eh_frame`；后端必须将新 FDE 合入真正 EH 查找表，实际目标异常遍历尚未运行。

重建命令：

```sh
build/host-venv/bin/python tools/firmware/f1_stock_display_payload_13/build_validate.py
```

固定 Zig0.15.2/target `aarch64-linux-gnu.2.28`，actual argv、ELF section/symbol/relocation、24个 pinned original 区间写入 `analysis/firmware/f1_stock_display_payload_build_13/BUILD.json` 和 `EXACT_NATIVE.json`；`payload.d/wrapper.d` 记录真实 include 闭包。新 entry 与 after/plan 均为 `_13`，payload 唯一 undefined 是 `iq4_f1_mode_get_01`，wrapper 唯一 undefined 是 `iq4_f1_after_stock_draw_13`。alloc relocation 为261/283/275/299，后两项是编译器16B只读常量的 ADRP/LDST128；现有 append 后端支持。

主机 normal 与 ASan/UBSan 各17组通过：延续12组源、比例、覆盖、fresh/OFF、旋转和边界反例；新增生产 LCD 与 base/HDMI/未知类型区分、pitch/height/provider/table门、18个完整表项逐项损坏拒绝、8B未知对象在 +58读取前拒绝，以及 800×480 自有软件 canvas 检查投影外像素不变、band覆盖准确、RGB24素材全字节不变。Host fill/table reader 替换为自有内存 fixture，不调用任何原厂地址；这些不是机内验收或硬件吞吐证明。

实际 source/object hash 在 `SOURCE_SHA256.json` 与 `LINK_INPUT.json`。本目录没有创建完整 User/package，没有安装或验收。启动器、UI入口、原厂接受、五档切换、OFF恢复、RAW/JPEG隔离和故障恢复由根任务以实际候选与实机证据逐项确认。
