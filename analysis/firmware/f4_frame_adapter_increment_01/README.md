# F4 原厂帧适配器增量 01

这是对既有 `F4_NATIVE_RECORDING.md`、`F4_NATIVE_UI.md`、source event 和 dimension 研究的窄链补充。新增正证据为：原厂合法 LV owner 的取得/释放线程限制、生产者之后的原厂通知和既有消费回调、同一视频槽的三组紧密三字节行布局消费者，以及生产者缓存维护的实际指令。没有执行相机 API、原厂命令、固件函数或扩展；不是临时或持久机内验收。原研究文件与输入原件保持不动。

## 精确输入和复现

模块 `analysis/firmware/extracted/P1Linux_6.03.21.bin`：11,874,544 字节，SHA-256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`，来自 release 6.03.18 包。地址均为 linked VA；本增量代码/rodata 文件偏移为 VA−`0x400000`。不能据此给另一固件版本绑定函数，也不能把文件名当作相机实际运行版本。

在工程根运行 `python3 tools/firmware/f4_frame_adapter_increment_collect.py`。工具先核对模块大小和哈希，用已有 unwind 起点界定完整 C++ 函数，单独标明少量局部调用窗口及两个无 unwind 的汇编叶函数；输出原始字节、逐窗反汇编、字节/文件哈希及原研究引用哈希。`exact_bytes.json` 保留全部 hex。`SHA256.json` 同时绑定本说明、`adapter_contract.json` 和 collector。反汇编显示的最近 C++ 符号不能作为 stripped 私有函数名。

## 合法 owner 及对象来源

| 路径 | 完整函数或精确窗口 | 指令结论 |
| --- | --- | --- |
| Access 构造 | `0x6b56ec..0x6b5884` | `x1` engine 存 `+0x8`；owner `+0xb0=-1`；五个 client name pointer 槽 `+0xb8..+0xd8` 清零；storage client IDs 在 `+0xa8/+0xac`。 |
| 原厂 Access 创建 | `0x41ef48..0x41efe8` 调用窗口 | `new(0xf8)` 对象传给 Access 构造。这里保存上层传参，不把 main 栈槽当成可运行的全局定位法。 |
| UI Access 来源 | `0x517698..0x5176b8` | LV dialog 的 manager `+0xb0` 经 `0x4e1a2c` 得 UiData；UiData `+0x118` 存 LV dialog `+0x108`。 |
| UI 注册 | `0x517b68..0x517b8c` | 上述 Access 注册名 `0xb9a4e0`，返回 client ID 存 LV dialog `+0x100`。 |
| RegisterClient | `0x6b58e0..0x6b5998` | 扫描 ID 0..4，首空槽保存调用者 `const char*`，**不复制字符串**；满槽报错后返回 0。0 同时是有效 ID，不能仅以返回 0 判断成败。 |
| AcquireOwner | `0x6b5a6c..0x6b5c44` | 检查两项 gate、已注册 ID、当前 owner；相同 ID 已持有 owner 也返回 false。只有原厂 mutex trylock 成功才写 `+0xb0` 和更新原厂 property；随后原厂 storage 协调调用返回值未在此检查。 |
| ReleaseOwner | `0x6b5c44..0x6b5d3c` | ID 必须等于当前 owner；调用原厂 stop `0x6b5ec8`，owner 置 −1，更新 property，解 mutex。**不会清注册 name 槽。** |

Owner mutex 的完整链为 `0x71208c → 0x712464 → 0x7123f4 → 0x712360 → pthread_mutex_trylock@0x40ae80`；成功保存 `0x710b0c` 返回的原厂当前线程对象。解锁 `0x712204` 会将该对象与当前线程对象比较，不匹配会诊断/断言。因此同一原厂控制线程应完成 owner 获取、启动、停止、释放；不让 JPEG worker 调 owner 起停。

全代码直接 BL 检索发现五个原厂 `RegisterClient` 调用点：`0x517b7c`、`0x57aa64`、`0x82b828`、`0x869830`、`0x8ce200`。其中 `0x82b828` 在条件分支内；此检索不证明运行时五槽均占用，也不排除间接调用。但是现有五槽上限与无 unregister 证据已足够要求扩展避免反复注册或假定第六个空位。若确需独立 client，必须在运行中核对实际空位、返回 ID 所属名称指针与持久字符串生命周期；不能盗用 ID 0、写 owner 字段或手工清注册表。

最小候选优先协调**已有原厂 LV 页面和它的合法 owner**，让同一个源锁同时服务页面显示与独占拷贝；不启动一个竞争的第二客户端。原厂 start `0x5202a0..0x520590` 和 stop `0x520590..0x520684` 保留原厂入口。对象来源与线程契约仍待合法目标运行入口确认。

## 生产者后的原厂通知及消费回调

新增补齐的是**生产后**帧 property；既有 source event 文档记录的是上游 PL/UIO 通知，两者不能混用。

`LiveViewAccess` getter `0x6b612c..0x6b614c → engine getter 0x6b6d04..0x6b6d1c` 返回 engine `+0x638` property。原厂通过该 property 的 VT `+0x10` 得到事件。生产 dispatch 完整函数 `0x797278..0x797390` 在 `0x7972e0` 调 frame producer `0x787578`；正常后处理分支 `0x797340..0x79736c` 调 `0x796b58` 后，把 property `+0xc0` 置 1，再以 engine `+0x640` 调 `0x70f2f8`。

存在明确的通知跳过条件：engine `+0x47d0!=0` 的路径不通知；property mode `+0xc4==1` 且其值已是 1 时，也跳过重复通知。既有 OsEvent pending 队列会合并通知。因此每次 callback 仅意味着“检查当前最新有效完成槽”，**不是每次一个新帧**，不能拿通知次数填报 fps。

原厂 IQP client 构造窗口 `0x869810..0x869874` 先注册自己的 ID，再从上述 property 的 VT `+0x10` 取事件，以 `0x70fed8` 注册 observer。对应完整 callback `0x869ce4..0x86a188` 首先比较来事件与同一 property event，再检查自身 ready 状态并通知原厂上层。Register `0x70fed8..0x70ff08` 与 unregister `0x70ff08..0x70ff38` 均转入 observer 所属事件管理器。此原厂配对给出可复用候选；扩展 observer 对象构造、回调所属线程、注销时正在排队事件的寿命仍未验证，不直接调用或占用既有 IQP client。

原厂 IQP 锁帧完整函数 `0x86b690..0x86b894` 使用自己的真实 Access/client ID 调 `0x6b618c`；随后 `0x6b62c0` 取锁定软件 ID，与上次 ID 比较，相同便立即解锁并返回失败。header 无数据也释放锁。完成函数 `0x86c288..0x86c390` 再以真实 ID 解锁并清本对象像素指针。可复用的是“有效槽/去重/配对释放”的契约，不是远程 IQP 的传输/压缩后端。

## 原始视频槽的行布局正证据

现有四槽元数据、生产者槽复用和 overlay 分离直接沿用。新增三条**消费端**独立支持当前原厂三字节分支的 source pitch=`3*actualWidth`：

1. **本地 LV**：完整 paint `0x51da0c..0x51df64` 在 `0x51dad4` 从合法 owner 锁 CPU video buffer，`0x51db58` 取锁定实际 W/H，`0x51db80` 取同槽 crop，`0x51db98..0x51dbac` 用原像素指针构造 Image(format=0, explicitStride=0)。完整 Image constructor `0x45fe8c..0x4600e0` 的 format 0 默认 rowBytes=`3*width`；后续 Surface format 0 路径从 Image `+0xc` 读此字节行距，按 `base+y*rowBytes+3*x` 算 source 地址，而不是读 overlay Surface pitch。
2. **独立 SaveLvFrame**：原厂 command ID25 的名称和完整 dispatcher `0x7b2610..0x7b4fa0` 一并保存；28项 signed16 jump table 验证 ID25→`0x7b3d44`。case `0x7b3d44..0x7b3ddc` 直接取同一 engine `+0x2170` VideoBuffer 完成槽及槽 W/H，调用完整 BMP writer `0x7b2488..0x7b2610`。writer source 起始行 `(H−1)*3W`，每次 fwrite `size=3,count=W`，下一源行减 `3W`；仅写出的 BMP 行额外补 `(-3W)&3` 个零。**文件对齐 padding 不在源槽内。** 正常结束回 `0x7b2944` 解源锁。BMP bottom-up 遍历是文件格式处理，不证明原视频本身上下翻转；未换通道也不能仅按 BMP 应有颜色推断 RGB/BGR。
3. **原厂 IQP header**：完整 `0x86bd58..0x86c24c` 对输出代码1取 bpp=3，代码2取 bpp=4，代码4取 bpp=1，代码`0x10000`为 JPEG（header stride/bpp置0）。W/H 来自同一 locked size；未压缩的 rowBytes=`W*bpp`，length=`rowBytes*H`，写 header `+0x24/+0x28`。这不是外部SDK声明或缓冲预算推算；它是机内消费者实际编写 metadata 的指令。

这推进了旧文档“只有 wrapper 要求3W、video pitch仍缺证据”的状态到**三组原厂消费者静态一致**。尚不证明 DMA 当前每种模式都遵守此契约、当前 active channel config 正确或映射权限/缓存属性有效。运行适配器首轮应只接受已核对的三字节模式、逐帧实际 W/H，检查整数溢出、容量和槽有效性；动态确认行末、相邻行和红绿蓝目标后再开放该 mode。

通道链新增完整指令：format0→display format2 的变换/缩放分支 `0x47fbe8..0x47fc44` 选择 wrapper `0x47e930`；完整 dispatcher 也保留同尺寸零旋转及其他特定状态的分支，不能把这一 wrapper 当作所有显示模式的唯一入口。wrapper 尾调 leaf `0x9e9598..0x9e9700` 用 `LD3` 读 source 的连续 `c0,c1,c2`，用 `ST4` 写显示字节 `255,c0,c1,c2`，无重排、无颜色变换。该映射支持原厂三字节与独立四字节显示层的关系；输入 c0/c1/c2 的颜色语义、transfer/range/sRGB仍需实际色块核对。它不把 RGBA overlay 当录像源。

## 缓存维护闭环

原厂 producer 已有 W×H×4 长度的调用，不能据此改像素格式。本增量把被调函数追到实际指令：

```text
0x78bd64(pointer,length) → 0x78bdb4(pointer,length)
  → 0x9ef058(pointer,pointer+length)
      CTR_EL0[19:16] 推导 data cache line bytes
      首尾不对齐边界及循环每条 cache line：DC CIVAC
      DSB SY
      RET
```

这明确是 data cache clean+invalidate 与末尾屏障；不是 instruction cache flush，也不是只凭名称推断。`W*H*4` 可能包括原厂保守范围，不是 row pitch；为什么视频实际有效3W却维护更大范围仍需 active allocation/mapping/PL模式验证。适配器应消费原厂已完成同步的同一锁槽，不自行添加未知 DMA 缓存操作或改变源映射。

## 不持源锁编码的最小接口候选

`adapter_contract.json` 是静态约束数据，**没有把 linked VA 转成可执行函数指针**。拟议接口接受已验证的原厂控制线程/owner上下文和一个预分配独占 frame pool；失败或队列满时丢帧并记计数，源锁内不分配、不编码、不写文件、不等待磁盘。

流程为：生产后事件排队请求 owner-thread capture → 同一 owner 取得有效源锁（或使用该 UI 已持的同一槽）→ 一次快照 ID/W/H/crop，去掉重复软件ID → 检查 mode/layout 与 W×H×3 有界长度 → 拷贝到独占池 → 原厂 owner 尽快配对解锁一次 → codec worker 仅使用池拷贝 → 已有真正有界 JPEG 编码器产生 packet → recorder 经真实 card lease 写完整文件。

原厂 paint 在 LV `+0x188!=null` 时会复用已锁指针；`+0x1c0!=0` 时正常 paint **保留锁**，`+0x1c0==0` 才在 `0x51de24` 解锁并清指针。故 capture 不能见事件就第二次 Lock，不能擅自释放 UI retain 的锁，也不能复用同一软件ID填60fps。与 UI retain/pause/退出契约协调后，才可选择原厂单 consumer 的 capture 时点；锁持有和 copy 延迟必须实测。

SaveLvFrame 的 direct-lock/写 BMP 仅用于静态佐证，**不作为执行候选**：它绕过 Access owner 检查，且在源锁内 fopen/fwrite；路径、错误清理及 thread 合约不满足新录像接口。原厂 JPEG wrapper 的换址/容量问题沿用既有阻塞及独立 bounded codec 方案，不因本增量而消失。

下一阶段仍须补目标执行入口、实际改动原件备份和独立 disable/recovery；运行 UI控制线程和 observer lifetime；active mode 的尺寸/行布局/颜色/缓存映射；真实新帧计数与64bit完成时钟；copy/编码/卡写带宽和卡 lease。没有声称1080p、60fps、机内写卡或持久安装已通过。
