# Actual LV 投影、完整构图中心与 native 写入交集

Root 提供的设备字段：configuration/ROI 14204×10652、RGB 640×480、scale/normal `41B00000`=22、rotation 0、animation 0、countdown 0；projected `(77,0,645,483)`；clip/LCD `(0,0,800,480)`；format 0。本代理没有读取设备。以下分别是这些回执的 binary32 复算、原字节静态写入计数和纯矩形主机验证；没有 pixel canvas、目标执行或机内验收。

原 LV paint `51dbd0..51dc0c` 用 ROI/scale 的正数截断生成目标尺寸：`trunc32(14204/22)=645`、`trunc32(10652/22)=484`。原 `476e6c` rotation0 的两个 fit 候选为 `645/640=1.0078125` 和 `484/480≈1.0083333`；选最小值 `1.0078125`（binary32 `3f810000`）。完整投影宽 645、高 `trunc32(480*1.0078125)=483`；未截断高度是 483.75。目标与投影的内部中心偏移为 `(0,(484−483)/2)=(0,0)`。800 宽控制区对 645 宽源区的 integer center 是 `(800−645)/2=77`。这与回执 `(77,0,645,483)` 完全一致，不需要推断新的图像比例。

**几何交集高度 480 不等于原厂实际写入高度。** `P∩clip∩LCD=(77,0,645,480)`，仅表示被裁掉 projected 最底三行的矩形。SDK reviewer 完整闭合 original rotation0 forward arm 后确认：`4756fc..475718` 把 clip bottom 所允许的源高度算为 `trunc32(480/1.0078125)=476`；`4758a4..4758b4` 再生成 output H `trunc32(476*1.0078125)=479`。`47f938` 取得 output H，`47fa40` 放入 row count；`47fab0/47fab4` 每输出或复制一行减一并在零时退出。故本合同的 native write rectangle 是 `(77,0,645,479)`，**LCD row y=479 不能因几何交集而被假定是这一帧的新像素**。

本目录保存了三个独立原字节窗口；row-loop 来源同时复用冻结 `analysis/firmware/f1_stock_display_payload_build_13/Scaler_dispatch_complete.txt` 与 SDK 的 `analysis/sdk_reference/display15_clip_write_contract_review_01/RESULT.json`。原始 User SHA `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`。有限 read/write 合同的完整性由 SDK reviewer 负责；本目录的主机矩形测试不冒充 native 像素写入证据。

四个遮罩首先以**完整 projected 645×483** 居中生成 keep/bands，然后逐 band 与已证明的 native write rectangle、clip、LCD 做 half-open intersection。不能先缩小到 645×479/480 再重新构图，否则遮罩中心或正方形宽度发生变化。

| mode | 完整 projected 中的 keep `(x,y,w,h)` | 交集后的绘制 bands `(x,y,w,h)` |
|---|---|---|
| Off | 无 | 无 |
| XPan65:24 | `(77,122,645,238)` | `(77,0,645,122)`；`(77,360,645,119)` |
| 16:9 | `(77,60,645,362)` | `(77,0,645,60)`；`(77,422,645,57)` |
| 3:2 | `(77,26,645,430)` | `(77,0,645,26)`；`(77,456,645,23)` |
| 1:1 | `(158,0,483,483)` | `(77,0,81,479)`；`(641,0,81,479)` |

上述 bands 都止于 y=479 的**开端点**，最多触及真实行 478；无命令触及第 479 行。mask 与 keep 的可见交集互不重叠，且面积合计为 native rectangle 的 645×479。用完整 projected 中心整数舍入时，keep center 相对 full frame 最多偏半个 pixel；它不改成 crop 后的可见中心。

`geometry_tests.c` 以 binary32 直接复算上述 projection 和两阶段 clipping counts；它同时保留“480 行几何交集，非 fresh”对照组与“479 行静态 native write 合同”组。Off+四档各两组，normal 与 ASan/UBSan 各 **10 mode cases + projection + clipping counts PASS**。每组检查正尺寸、band containment、不重叠、不触及 keep、面积分割、正确 full-frame center；479 组额外检查所有 y+h≤479。源码没有读写 pixel pointer，没有 software canvas，也没有修改 production payload。

最小 production 修正应保留 locked/Image/配置输出 pair、完整 ROI、normalScale、rotation0、exact LCD、源/显示 allocation 隔离；把完整 projected 构图参考与 native 实际写入覆盖分开。仅针对已经闭合的原厂 clipping/write arm 计算允许区域，未知或越界 arm 继续隐藏。原 write rectangle 必须通过原始 source clipping 的整数计数计算，不能用 `P∩clip` 代替；然后才允许对原 fullProjected bands 做交集。不能为掩盖原厂未写入行而扩大 mask 到 stale row。

`RUN.json` 包含实际 compile/run/disassembly argv 和 exit；`HOST_normal.json` / `HOST_asan_ubsan.json` 保存每个矩形结果；`REVIEW.json` 区分设备字段来源、静态计数与 host geometry；`SHA256.json` 固定本目录文件。host executable 只在独立 `build/f1_actual_projection_review_01`。
