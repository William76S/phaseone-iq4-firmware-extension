# 固定 User 的本地 LV 显示 payload 12

这是实际 AArch64 ET_REL 汇编+C payload，不是 SO、安装器或可直接刷入的固件。只针对 release 6.03.18 包内 User `P1Linux_6.03.21.bin`（11874544 B，SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`）。所有旧冻结件保持原样。

唯一补丁入口是原 LV `BL@0x51ddcc`，旧 LE bytes `9b64fd97`，替换为 `iq4_f1_lv_draw_wrapper_12`。它保持原 x0..x7 与 hidden x8，恰一次调用原 `0x477038`。正常返回后才检查 active native caller stack，借同一 Surface 在四个互不相交带中调用原 `0x46f370`。原回调的源图、返回 Rectangle、clip、owner、source lock 和原 Grid/toolbar children 不被改写；没有 crop/RAW/JPEG/video/EEPROM setter。

`payload.h` 直接引用 UI 作者的 `../f1_user_ui_entry_01/state.h`。display 只调用小 C 接口 `iq4_f1_mode_get_01()`；mode=0 默认 OFF、1=65:24、2=16:9、3=3:2、4=1:1。UI 尚未真实绑定/Hold时 getter 返回0。此模块没有 UI 初始化、TLS、线程、配置或 logger。

具体执行门全部由当前原回调字段生成：原 returnPC `51ddd0`、callerSP=callerFP、原四个 on-stack descriptor 地址、真实 LV vptr、全 ROI 与 locked/engine/image W/H 一致、RGB24 stride=3W、source/Surface backing 不重叠、当前 scale=normal-fit scale、动画与 skip-blit countdown 为0、原 base Surface/Draw VT、合法 pixel pitch/height。还用原 `476e6c` 的 binary32 公式核对投影和 clip 的未截断浮点端点，才知道原 `47552c` 不进入源 ROI 裁切而实际选择支持的 RGB24→32bpp 写分支。仅“非空返回矩形”不会放行。

首版支持 native rotation0 的五档；90/180/270及未知角度继续原厂显示，遮罩隐藏，其 reverse-anchor clip contract尚未完整关闭。zoom、局部源、动画、无法完整覆盖的 clip 或不匹配 Surface 也隐藏。不能把这个首版标成横竖旋转全部支持，不能把静态分支约束标成实机覆盖验收。

原 skip-blit 分支跳到 `51dde8`，根本不调用这个 BL wrapper。没有保留上帧的 paint callback；不会每次 children redraw都重复 alpha。黑色字节为 `{166,0,0,0}`，alpha在 byte0，不猜非黑通道顺序。Surface+14为 pixel pitch，native地址用4倍步长；不把源 RGB24 当32bpp目的。

OFF 仍先走原 image draw；下一次实际完整 draw 会覆盖旧带。UI必须原 invalidate 请求整个 LV 重绘。没有把 requested mode0 立即当 pixels clean，也未写 native countdown 或构造假的 PaintReceipt。

汇编恢复原厂调用正常返回后的 x0..x18、q0..q31、NZCV/FPCR/FPSR，并保存 callee-saved x29/x30。其他 callee-saved寄存器由原方法和标准 C ABI保持。wrapper及 C 有真实 `.eh_frame`；最终 ELF后端必须把新 FDE合并进原 GNU EH lookup，保留原 frame/TLS/initarray/动态信息。不能丢新EH或用没有 CFI 的版本声称 native异常可恢复。原异常跨新增 frame 的实际运行仍未验收。

构建和主机验证：

```sh
python3 tools/firmware/f1_stock_display_payload_12/build_validate.py
```

它使用既有固定 Zig0.15.2/`aarch64-linux-gnu.2.28`；只产生自己的 `payload.o` 和 `wrapper.o`，不运行目标。主机执行自己的12组 normal 和 ASan/UBSan fixtures：四比例的分区面积/无重叠、OFF无fill且原返回不改、全ROI/stride/Surface区分、zoom/动画/旋转拒绝、浮点端点反例、真实 descriptor parser shape反例、skip/countdown防御及空带不交给 inclusive native fill。host native fill被自有 fixture替换；这些不是相机调用或 native绘制实测。

产物位于 `analysis/firmware/f1_stock_display_payload_build_12`。真正链接时两个 objects与 UI objects共同闭合 `iq4_f1_mode_get_01`；可按后端 RX起始 `0x4240000`（在旧BL±128MiB内）排布。新增 display没有 mutable RW全局。alloc reloc仅 CALL26/PREL32，未定义 libc/atomic/TLS/动态 imports。具体绑定在 `LINK_INPUT.json`。

完整 User/卡载 package、签名/加载接受、菜单实际进入、显示宽高/完整覆盖、OFF恢复、RAW/JPEG不含遮罩和原厂回退均由最终版本候选和实机验收给出；本目录没有执行上述步骤。
