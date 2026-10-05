# F4 原厂页面状态桥 01

这是独立最小适配源码阶段，不是实际原厂页面安装物。生产 `permitted()` 硬返回false：即使传入全部true booleans，也不会调用UIPort/current-thread/Recorder。没有constructor、钩子、设备/SDK或实际地址调用。只有单独host synthetic macro测试有限状态桥；target仅无main/constructor的AArch64 ET_REL，不加载运行。

```sh
python3 tools/firmware/f4_native_page_bridge_01/freeze.py
python3 tools/firmware/f4_native_page_bridge_01/validate.py
```

`native_abi.hpp` 只声明已冻结的原厂Dialog/paint/Control/KeyHandler静态参数形态及精确User绑定，供后续实际binder复核。它不分配原对象、不复制vtable、不调用候选地址。原厂simpleButton完整size、标题/resource/render、新derivedPage布局、touch/key映射、菜单undo和完整生存期仍未闭合，因此没有以猜测对象替代真实UI。

`Session` 提供固定start/stop/back/reset动作与owned快照。UI只向有界SPSC发布命令/读回，不等待、不编码、不写卡、不保存borrowed Surface/touch/frame指针。唯一Recorder线程复用现有 `src/runtime/Recorder`；Stop/Back先经外部已验证source-owner租约解除与owned-pool排空Fence，Pending不阻塞/不pop，Unknown保持Hold，Ready后才收尾。同一Fence也用于UI失效路径：Pending逐tick观察，不pop旧Start；Unknown固定保留context且不finalize、不重试；Ready才最多一次stop，Idle标记QuiescedNoRecording而非成功录像收尾。收到成功Back ack后UI才允许原厂returnLV；Closed始终保留native context，不作为hot-unload证明。

模式、RGB布局/颜色、编码、实际卡lease/publish/recovery和worker全部独立验证后才可start；默认能力均false，显示Unavailable。software completion通知计数单独显示，不换算fps；fps字段仅在独立实测distinct capture frames条件成立时提供。新页面的实际文本/控件渲染由未来原厂adapter实现，当前没有桌面GUI、机内截图或实测1080p60。

22组normal、ASan/UBSan、TSan host测试及production零调用测试复用真实Recorder和mock后端，验证非阻塞交接、首帧才亮灯、收尾前不返回、fence Pending/Unknown、源丢失/失败收尾/abort后返回、重复按钮、背压、native UI失效时先停源/排池、Pending→Ready或Unknown保留、未消费Start禁运行、finalize失败、严格gates、notification≠fps、20次启停、双线程UI Hold交接与20000次并发SPSC。详细边界见 [交付记录](../../../analysis/firmware/F4_NATIVE_PAGE_BRIDGE_IMPLEMENTATION_01.md)。
