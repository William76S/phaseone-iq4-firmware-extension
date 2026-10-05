# Display14 SOURCE 精确比例条件：实际尺寸与原厂整数采样

Root 提供的本轮实机回执为：E34、N775、F0，RGB 640×480，configuration 14204×10652，ROI `(0,0,14204,10652)`，rotation/animation/countdown 均为 0。本代理没有读取相机；这些数字的来源是 Root 的设备回执。本轮仅执行主机整数数学测试、读取原固件字节；没有修改 Display14 或其它冻结源。

**现有 exact-aspect 条件对此回执必然返回 SOURCE。** `payload.c:64` 的两乘积为 6,817,920 和 6,817,280，差 640。按配置宽度归一至 640，理论高度为 479.954941；实际高度 480 仅差约 0.045059 输出 pixel，但整数交叉乘完全相等仍为假。

**原厂有更直接的输出尺寸来源，优先用它替代比例猜测。** 原 `520364..520378` 构造 640×480 Rectangle，metadata getter `520384` 返回 engine+4760。`52038c/390` 提取该 Rectangle 的 W/H，`52039c` 经 `431760` 打包，`5203a4` (`212c00f9`) 把 pair 写到 metadata+58，即 engine+47b8/+47bc。随后 `52040c` 设置 configuration，boolean 为 1；`7976f4..797740` 选择 fit helper，跳过 `797744..797760` 修改 configured output pair 的截断/四对齐 arm。因此 local Start 保存的 640×480 是独立请求，原厂没有在这里要求它与完整配置尺寸严格等比例。

原 SetConfig 的其它中间步骤明确存在整数采样：`797640/7977c0` FCVTZU；`7976c8..7976d4` FCVTZS；另一 arm `797754/758` 四对齐。mode descriptor 和 configuration 之间又分别按宽、高变换 ROI。producer `787838..787880` 单独从 FPGA field 0x1a6/0x1a7 获得实际 slot W/H，height 受 metadata+5c 上限约束。仅从这些片段不能重建一个适用于所有模式的单一 nearest、floor、ceil 或固定 width-anchor 规则。

建议最小且来源最强的 SOURCE 合同：保留 RGB format、packed stride、实际 locked W/H==Image W/H；保留 ROI 原点 0 且完整覆盖当前 configuration W/H；增加读取并独立校验 metadata+58/+5c configured-output W/H（正数且≤65535），要求它们也等于 actual locked/Image W/H；删除 config/RGB 精确宽高比相等条件。它绑定原厂具体输出配置，不自行设定采样率，也不允许任意 pixel 尺寸。若 producer 实际 slot 与 configured output pair 不同，继续隐藏，待该模式有独立合同。其它原厂调用、LCD exact type、source/display 隔离、normal-scale、rotation0 与 fresh coverage 条件均保持。

若暂不增加两个字段，可采用**有限准入策略**：存在共同正 scale，使两个整数输出都可由该 scale 的正数 floor/截断得到，即 `[PW/CW,(PW+1)/CW)` 与 `[PH/CH,(PH+1)/CH)` 相交。完全使用 int64 交叉乘的充要式为：

```c
(int64_t)PW * CH < (int64_t)(PH + 1) * CW &&
(int64_t)PH * CW < (int64_t)(PW + 1) * CH
```

先验证所有尺寸在 1..65535；上端是开区间，必须使用严格 `<`。本 actual pair 通过；1280×1024→640×480 拒绝；1280×960→640×479 的排他边界也拒绝。这比百分比容差有明确的 `<1 output pixel` 界限，但它证明的是存在一个量化比例，**不是**原厂实际采用那个 scale 或统一 floor 规则。共同 nearest±0.5 pixel 的 interval 也能接受本 actual pair，但没有直接的 nearest 指令依据；不建议把它写成已验证的原厂舍入规则。

主机 `sampling_policy_tests.c` 两次实际构建（normal、ASan/UBSan）各 19/19 通过：actual strict ratio 拒绝、bounded floor 与 exact configured-pair 接受；明显非等比和排他区间边界拒绝；65535² 大于 int32 的乘积通过 int64 正确处理；partial/offset ROI、locked mismatch、configured pair mismatch、stride/format、非法尺寸均拒绝。仅测试新增数学/准入合同，没有执行 payload/native fill，也没有声称机内通过。

下一版本几何回归应使用 **actual source 640×480** 计算正常投影与四档 band，并与已有 source640×480 baseline 比较；config14204×10652/fullROI 保持独立，不能把 source rectangle 换成 configuration 大小。还需保留 partial clip、负 origin、source/display overlap、未知 LCD、旋转和 zoom 的拒绝用例。Root 仍需取得实际 scale bits、destination/projected/clip 的后续回执：若 native normalScale 是整数 22，ROI/scale 将生成 645×484，完整 480 高 LCD 上的 fresh-coverage 条件可能继续拒绝；这是有限数学预测，未收到实际几何，不作为设备现状断言，更不能据此放宽覆盖保护。

`RUN.json` 固定三个原始窗口、实际 host argv/exit 和前后 frozen hash；`HOST_normal.json`、`HOST_asan_ubsan.json` 是实际用例结果；`REVIEW.json` 分开记录设备回执来源、静态结论和主机结果；`SHA256.json` 固定本目录内容。输出 binary 只在独立 `build/f1_display14_sampling_review_01`。
