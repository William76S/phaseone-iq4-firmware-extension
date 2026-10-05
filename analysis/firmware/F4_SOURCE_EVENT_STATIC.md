# F4 源帧事件、计数与时钟：窄范围静态结论

本阶段闭合了原厂 `LiveViewFrame` 的 PL 事件注册与生产者线程链。`0x79e208` 是用户态 `LiveViewManager` 线程；上游用户态 `PlInterruptHandler` 通过原厂 `/dev/uio0` handler 等待，然后按状态 bit `0x4` 通知该事件。**这证明生产者由原厂 PL 状态事件触发，尚不证明一次事件就是一次新曝光、一次完整 DMA 或一张可交付新帧。**原厂通知队列会合并 pending 事件，生产者还存在不发布完成槽的分支。没有找到已可采用的硬件逐帧计数或硬件捕获时间戳。

全部为本地静态指令/原字节证据；没有连接相机、执行目标代码、读取寄存器、加载 SDK、生成设备包或安装探针。根执行者给出的 60 秒 / 3695 次 SDK 交付及主图 1024×764，是另一层运行证据；这些数值不能经本文升级为源 FPS 或 1080p60。

## 输入与复现

精确模块 `analysis/firmware/extracted/P1Linux_6.03.21.bin`，11,874,544 字节，SHA-256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`。来源包显示 6.03.18，模块名 6.03.21；不跨版本使用地址。链接 VA 与代码/rodata 文件偏移差为 `0x400000`。下文均为链接 VA，实际对象指针与当前设备字节未验证。

工程根运行 `python3 tools/firmware/f4_source_event_collect_static.py`。它核验精确模块及三个冻结证据文件，保存 21 个窄指令窗口、8 个字节表、独立 `F4_SOURCE_EVENT_SHA256.json`；不改变先前 manifest。`f4_source_event_static/exact_bytes.json` 给出完整原始 hex、偏移及哈希。最近符号标签可能覆盖多个 stripped 私有函数，不是命名依据。`f4_source_event_decompile_targets.txt` 的起点/终点均与既有 unwind 表相符，仅供辅助离线阅读。

## PL 事件到生产者的闭合链

| 链条 | 指令及字节证据 | 可证实的范围 |
| --- | --- | --- |
| 事件对象与 owner | `0x798084` 算出 manager+`0x1b0`；`0x798094..0x798098` 传名称 `0xd739f0="LiveViewFrame"` 给事件 ctor。`0x7980ec` 保存 engine 至 manager+`0x280`。 | manager+`0x1a8` 是含事件的 value object，+`0x1b0` 是嵌入事件 core；不能把它当 pixel buffer。 |
| engine 绑定 | `0x7995d0` 创建 manager；`0x7995d4` 保存到 engine+`0x8120`；`0x7995dc` 启动原厂线程。 | 对象实际生存期仍由原厂负责。 |
| 事件 getter | `0x42fbd8..0x42fbdc` 取 engine+`0x8120`，`0x42fbe0` 调 `0x42fa84`，后者 `0x42fa90` 返回 manager+`0x1a8`。 | 指针关系闭合，未验证公开 ABI。 |
| PL 注册 | main `0x422614..0x42263c` 调该 getter，对非空结果加8，将 x2=manager+`0x1b0`、w1=2、x0=PL handler 传 `0x789a8c`。`0x789ab8` 将事件指针存入 handler+`0x18` 的按索引数组。 | event index2 明确注册到 LiveViewFrame。 |
| 状态 bit | `0x789944..0x789948` index2 分支 → `0x7899fc` 返回 `w0=0x4`。 | bit 值来自原厂 switch，不是照搬另一相机。 |
| UIO 等待 | main `0x42257c..0x42258c` 构造路径 `0x9f5708="/dev/uio0"`；handler ctor `0x789700/0x78970c` 保存 UIO owner / register-interface owner。`0x789740..0x789758` 调 UIO owner VT+0。VT `0xc40b58` 的首指针是 `0x76e7c0`。 | 是本机用户态等待，未获得 kernel ISR/驱动源代码。 |
| 读状态及写回 | `0x789760..0x789788` 调 register-interface VT+8，w1=8、w2=6，取得32-bit status；非零时 `0x789798..0x7897c0` 将原 status 以同两参数写至 VT+0，随后才通知各事件。 | `(8,6)` 是原厂设备/字段选择参数，**不能当 MMIO 物理地址或偏移**；写回表现符合清除/应答用途，但 W1C、电平/边沿及 FPGA 语义未闭合。不得为了诊断再读写一次。 |
| 通知 | `0x7897dc..0x789800` 检查 status & event mask；`0x789810..0x789818` 取已注册 event；`0x7898dc..0x7898e0` 调 `0x70f2f8`。 | 一次 status 快照可含多 bit。无法从单 bit 恢复同 bit 在服务前发生了几次。 |
| manager listener | ctor `0x79812c..0x798150` 用 x1=manager+`0x1b0`、x2=manager 建 listener，再保存 manager+`0x2a0`。 | 关联与 PL 注册的事件 core 完全一致。 |
| manager 分派 | `0x79e240..0x79e250` 等原厂队列 `0x71384c` 并保存返回 listener；`0x79e2c8..0x79e2d4` 比较 manager+`0x2a0`；相等且 LV 状态 gate 允许时，`0x79e710..0x79e730` 调 `0x797278`，后者 `0x7972e0` 调 `0x787578`。 | 帧事件走这个 producer 链；LV 状态 gate 可以忽略通知，其他事件也会唤醒该线程。 |

线程身份也有独立字节证据：manager VT `0xd73060` 的 +`0x10` 为 `0x79e208`，RTTI `0xd72fb0` 指向 `0xd72f98="15LiveViewManager"`。PL main 在 `0x422764..0x422784` 把 `0x789728` 包入 delegate，`0x4227c4` 用 `PlInterruptHandler` 名称创建原厂线程，随后启动；它不是 kernel ISR。

UIO 原函数 `0x76e7c0` 在 `0x76e7e4..0x76e7fc` 写四字节值1，再于 `0x76e85c..0x76e86c` 读四字节到自身 stack+`0x2c`；它只检查 read 长度，`0x76e8b0..0x76e8b8` 返回且未交付该值。**尚不能将此值称为每帧硬件 counter**：当前材料没有驱动对 read payload 的定义、计数单位、复位/溢出规则或它与 bit0x4 的一一关系。

## 合并与不发布的确定反例

`0x70f494` 调 observer VT+`0x10`；listener VT `0xc23c90` 的该 slot 是 `0x710820`，它在 `0x710854` 把 listener+`0x48` 交给 owner 队列 `0x713c6c`。这条链存在明确合并：

- `0x713cd4` 调 `0x7144a8`。后者 `0x7144b4` 读 listener+`0x38` 旧 pending bool，`0x7144c4` 设置1，返回旧值；只有旧值为0，`0x713cf8` 才入队。重复 pending 通知不再排一个独立元素。
- `0x713958..0x71395c` 弹出时调 `0x710864`，`0x710870` 清 pending；通知并非携带独立源帧序号或累计发生次数。owner+`0x90` 特殊路径也只保存通知对象指针（`0x713cb4..0x713cc4`）。
- `0x79e71c..0x79e724` engine+`0x480c` 自增，随后才检查 engine+`0x8113` 并决定是否调 producer；这个值会包含未执行 producer 的线程通知，且 watchdog 会归零。它不是硬件帧数。
- 冻结 producer 字节：预热 `0x7875cc/0x7875dc → 0x7875e0 → 0x787654..0x7876c8` 可重新编程 DMA 后返回而不执行 `0x787728..0x787758` 完成发布；调用者仍推进统计环。
- 完成槽不足分支 `0x787b40..0x787b64` 有诊断和 counter 自增后跳转，可能不更新 `+0xe4/+0xf0`。诊断函数是否中止当前运行尚未验证；至少不能忽略该分支以 counter 自增判定完成发布。

正常发布 `0x787728..0x787758` 的 `VideoBuffer+0xec` 是软件 counter；正常关系为 `ec_after=ec_before+1`、`f0_after=ec_before−1=ec_after−2`（mod 2³²）。`+0xe4` 是完成槽，`+0xf0` 是软件完成 ID；原厂锁 `0x6b6a7c..0x6b6a94` 把它们快照到 `+0xe8/+0xf4`。ID 需要同时有锁有效标志；返回0也可能是未锁，不能单独把0视为无帧。冻结旧材料保持不变，本文件补齐其上游和计数边界。

## 时间字段的精确层级

| 字段/函数 | 来源 | 可以使用的语义 |
| --- | --- | --- |
| `0x71728c` | 原厂 `steady_clock::now` 链；`0x717398 → 0x71737c → 0x717464` 保持 signed64，`0x717478..0x717494` 作 signed /1000 转换。 | 主机 CPU 单调时钟的原厂微秒候选，可用64位记录**观察/处理时间**；不是曝光起始或传感器捕获时间。clock 的 kernel 实现/休眠行为未闭合。 |
| PL 通知 ring row+`0x24` | event index2 分支 `0x78989c..0x7898d8` 取该软件时钟低32位，写当前 `0x3fa5110` 指定的40-byte row（base `0x3fa9938`）。 | 用户态处理状态后、通知前的时间。IRQ 线程和 producer 使用同一滚动 index；缺少稳定原子配对，不能按 row 直接绑定某完成槽。 |
| row+`0x4` / +`0x14` | `0x7972bc` dispatch 起始；`0x797330` dispatch 结束；环在 `0x797318..0x797324` 模2048推进。 | producer 调度与处理观测。预热等分支照样推进；环不是硬件帧计数。 |
| VideoBuffer+`0x100/+0x104` | `0x6b6b14..0x6b6b20` 锁起始低32位；`0x6b6b3c..0x6b6b54` 记锁持有差值。 | 锁持有时间；约71.58分钟回绕，不是每槽 capture timestamp。 |

尚未闭合的止点是 FPGA bit0x4 的真实产生条件及完整帧/DMA完成边界、kernel UIO read 值定义、单个 bit 的合并/丢失规律、DMA 槽与观测 event 的一一关联。以上用户态链没有读取已定义的逐帧硬件 timestamp/counter。其他模块的 timestamp 名称不能证明与此 LV 槽关联；本轮没有以字符串或软件数字填补这个缺口。

## 后续只观测探针契约（尚无执行安装物）

必须先通过当前项目的合法临时执行、原件备份、停止/退出恢复及单执行者门槛。以下只规定未来探针的记录内容，不能据此调用私有 ABI 或开启第二个 UIO/LV owner：

1. 在**原厂已经完成的** UIO read / register read 返回点旁观记录 payload、长度、原 status、观察64位时间及独立64位日志序号；不另 open `/dev/uio0`，不重读状态，不额外 ack，不改变 bit/mask。UIO payload 先保留为无语义 raw U32。
2. 记录 event index、真实 listener/core 指针的会话内 ID、pending 旧值、入队/合并/弹出和 LV gate 结果；每会话单独 reset ID、丢失记录数及环覆盖数。异步 ring row 不能作为唯一关联键。
3. 在同一个合法 engine/线程上下文，记录 producer 前后 `ec/f0/e4/dc/e0/e8/f4`、预热/正常发布/牺牲槽/错误分支以及64位处理时间。每次有效锁内读实际尺寸/crop/slot/ID，记录拷贝起止与 unlock；不延长锁等待编码。
4. 只在经过证明的完成发布且有效锁的内容进入独占池后计一份录像输入。分别报告原状态事件、排队通知、完成发布、成功拷贝、编码/写卡各层计数及丢帧。相同图像 hash 不能单独证明重复帧，静态画面可能本来相同。
5. 要声明真实源60fps，仍需硬件语义或可对照的拍摄时钟/运动靶证据，结合曝光设置、帧内容和全部层级计数证明60秒内约3600份独立完成的新帧及其时间间隔；声明1080p还需逐帧真实有效尺寸。软件观测日志或 AVI 标称 fps 均不足。

本阶段可直接指导的是观测点与拒绝误计数的条件。源 FPS、硬件捕获时间、机内1080p60、执行入口和恢复门槛仍未通过实机验证。
