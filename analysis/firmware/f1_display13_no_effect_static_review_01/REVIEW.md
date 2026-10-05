# Candidate 03 / Display13 无效果：离线窄审查

核对对象是原 User `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb` 和候选 User `c2ee83dcad9529e1fb61af5a989b8a1f8f3f6c07c1ec2d2742a662d032404443`。本轮没有连接相机、调用 SDK、执行目标 ELF、修改冻结源。用户已观察到菜单出现但无比例效果；本审查没有取得运行时字段，不能把下述静态缺陷认定为这台相机此次失败的原因。

**确认一个 SOURCE 域逻辑缺陷：配置尺寸、ROI 配置坐标尺寸与 RGB 像素尺寸被强制相等。** Display13 `payload.c:57..62` 要求 `engineW/H == imageW/H`，并要求 `ROI=(0,0,imageW,imageH)`。原厂 producer `787838..787880` 的 locked width 来自 FPGA field `0x1a6`，locked height 来自 `min(FPGA field 0x1a7,pending+5c)`，而 ROI 的 x/y/w/h 从 pending/config `+18` 直接复制。LiveViewAccess metadata getter 经 `6b6dec` 单独返回 engine `+4760`。没有在该生产/锁定/绘制链证明三个域必须数值相等。

原厂 LV paint `51db50..51dc0c` 使用 locked dimensions 构造 RGB Image，同时把 ROI 的配置坐标尺寸除以 LV scale 生成绘制目标框。`51f50c` 的位置计算也使用 metadata config dimensions / scale。随后 `477038` 独立从实际 Image 的 W/H 构造 `(0,0,W,H)` 完整输入框，再由 `476e6c` 做 fit 投影。这些原始字节允许在配置域与采样像素域不同的情况下完成正常完整帧投影。producer 不把 ROI 重新写成 locked dimensions。

独立主机反例使用**假设** config/fullROI 1280×960、normalScale=scale 2、实际 RGB fixture 640×480、零 pan、旋转 0。原厂有限投影公式生成 destination/projected `(80,0,640,480)`，覆盖完整 RGB 帧且在 800×480 LCD 范围内。冻结 Display13 四个比例全部返回 `SOURCE13=4`，没有任何 band。同域 baseline 四个比例全部返回 DRAW。normal 与 ASan/UBSan 两次实际主机构建各 11/11 用例通过；这是 guard 行为和公式反例，不是设备分辨率或硬件吞吐证明。

**未发现 mode 状态链接分裂。** 候选实际 getter `4240000` 读 private BSS `4290000`；公开 setter `424000c` 和菜单 leaf activate `424092c` 均写同址，after-stock `424145c` 明确 BL 到该 getter。两个菜单入口共享这一状态，没有链接旧 UI03 的独立 state。源码 callback 识别两组真实自有 item，设置 0..4 后返回 1，由原 Navigator 返回路径处理；本轮没有确认一个必然吞掉 selection 的静态分支。

| 检查 | 原厂合同 / Display13 条件 | 本轮结果 |
|---|---|---|
| caller provenance | BL 51ddcc / return51ddd0，FP=SP，原 SP+110/+c0/+128/+f8，零 x2/x3/x7 | 静态一致；是否实机进入未收到计数 |
| locked / Image | SP+b8/bc 用来构造 SP+c0 Image | `locked==RGB` 条件有正向依据，应保留 |
| engine / ROI / RGB | 配置与 ROI 单独传递；actual slot 从 FPGA 来 | 无三域相等保证；上述 SOURCE 缺陷已证明可触发 |
| scale | LV+190、normal+194 读取 binary32 | 原厂实际字段正确；设备实际两值未知 |
| animation | Pan at LV+110，Animation+20 active byte+8 → LV+138 | byte 偏移/宽度正确；设备当前值未知 |
| LCD / Draw / provider | 生产 LCD primary b7cf90、secondary b7cfc0，manager+108 是同一 IScreen | 精确静态表和来源闭合；未证明此次对象/表 gate 实际通过 |
| geometry / clipping | native binary32 min fit、truncation、center；完整 projected/clip containment | 有限 normal rotation0 公式一致；partial clip、负坐标、旋转仍有意隐藏 |
| fresh coverage / buffers | 实际 projected 必须吻合，untruncated ends 必须完全在 clip/LCD，源与显示 buffer 分离 | 不放宽；设备实际 reason/字段未知 |

建议下一版本修正 SOURCE 合同为：actual locked size 仍等于实际 RGB Image；engine dimensions 独立校验 1..65535；ROI 原点为零且尺寸等于 engine config dimensions；config 与 RGB 宽高比通过 **int64 交叉乘** 相等。其它原厂调用、normal-scale、fresh-coverage、LCD、source/destination 隔离条件保持。这修复确认的域混同缺陷；仍需 observer 记录 mode、hook count、第一拒绝点 / plan reason 以及上述少量几何字段，才能解释此次设备无效果。不能仅修改 guard 然后宣称验收成功。

必须回归：同域四比例；上述 full-config/scale2 四比例 DRAW 且 band 与同域 baseline 一致；ROI 非零、ROI 只覆盖 pixel 域而没有覆盖完整 config、config 与 RGB 不等宽高比、engine 0/负/65536、locked 与 RGB 不等、非 packed stride均拒绝；partial clip、rotation、zoom、LCD unknown、源/显示重叠仍拒绝。交叉乘必须在乘法前提升为 int64；65535² 已超过 int32 正数范围。

运行 `build/host-venv/bin/python analysis/firmware/f1_display13_no_effect_static_review_01/run_review.py` 可重建离线窗口和两组主机验证。`RUN.json` 包含实际 argv/exit、前后冻结输入 hash、窗口 identity；`REVIEW.json` 保存精确机器字和结论分级；`SHA256.json` 固定本审查文件。所有构建产物在独立 `build/f1_display13_no_effect_static_review_01`，没有相机持久写入。
