# 本地 UI 与 RAW→JPEG 接入的静态证据

输入仅为原厂P1Linux_6.03.21.bin，SHA-256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`，来源IQ4 release6.03.18固件包。此阶段没有设备操作，没有临时或持久机内验收。地址均为linked VA；本文件所述code/rodata文件偏移为VA减0x400000。不能把地址或字段移植到其他固件、X2D或GR4。

## 解释限制与命名更正

91个选定函数通过Ghidra12/Java21导入本ELF并在`-noanalysis`下产生伪C。名称是研究者给出的静态角色描述，不是原厂导出符号。部分函数的tail branches和未恢复的C++/PLT原型会使伪C扩展共享代码或错推参数/返回值。尤其返回Rectangle等小结构的C++回调可能使用AAPCS64隐藏x8指针。**这里只给静态字段和指令依据，不提供可执行函数指针或已验证ABI。**

| 地址 | 已纠正角色 | 早期命名为何不采用 |
| --- | --- | --- |
| 0x5175b8 | LV dialog构造器 | 安装多个vtable、构造controls/timers并注册LV client |
| 0x51b768 | property/event回调 | 比较事件对象后改变状态；不是构造器 |
| 0x51ea88 | touch/input回调 | 判断输入type1/2/4/8/0x10并更新zoom/pan；不是render |
| 0x51da0c | 实际LV绘制回调 | 锁LV、构造Image并调用SurfaceDrawImage |
| 0x5202a0 | LV start | 取得owner、设engine/crop并启动timer |
| 0x520590 | LV stop | 释放持有帧、停止engine、释放owner、停止timer |
| 0x520684 | 暂时overlay显示开关 | char开关和1500ms timer；不是LV stop |
| 0x4959ec | IFM对象构造器 | RequestImageForJpeg是被构造字段的名称 |
| 0x496ab0 | IFM RAW→JPEG生成请求 | 最后直接调用0x48c394；不是release |
| 0x4979d0 / 0x497a9c | JPEG buffer lock / unlock | mutex和锁计数实质代码 |
| 0x7b6314 | Image→IC像素格式映射 | enum映射并非RGB色域映射 |
| 0x964b10 | RAW区域白平衡取样候选 | 读取Bayer、累计RGB均值，不能当作ProcessRGBPreview |

被纠正的旧伪C文件已删除；`decompile_targets_all.txt`与`ENTRYPOINTS.json`使用更正角色。

## UI、事件与显示层候选

构造器0x5175b8安装LV dialog vtable0xb9a9d8（file0x79a9d8）：+0xa0→0x51da0c，+0x108→0x51ea88，+0x1c8→0x51b768，生命周期+0x170/+0x178→0x51d884/0x51d9bc。0x6b58e0注册LV client，client id保存在dialog+0x100，access指针在+0x108，运行状态在+0x104，持有pixel指针在+0x188。

本地paint链为：

```text
0x51da0c (LV paint)
  → 0x6b618c (owner检查后的LockVideoBuffer)
  → 0x6b61fc / 0x6b621c (locked size / rect)
  → 0x45fe8c (Image描述符，format0，stride=width×3)
  → BL@0x51ddcc → 0x477038 (SurfaceDrawImage)
  → 0x6b6250 (owner检查后的release)
```

frame指针由原厂LV缓冲来，Surface作为独立绘图参数传递。可供后续adapter验证的最小候选是原厂paint之后的本地control/Surface遮罩；其前置条件为display bounds、坐标旋转、叠加顺序和原厂退出状态已确认。静态分层支持“只显示”的实现方向，尚不能替代RAW/JPEG/录像中没有mask的实际验收。

现有overlay control在0x5473e4创建（vtable0xba6540），LV dialog的control指针在+0xd48。它通过0x4ab898增加grid子control，0x548b08构造grid（vtable0xba6880）。0x547c60监听model事件并切换grid；0x54803c仅接受0/90/180/270°，表示旋转。0x4ac144根据control+0x6f更改显示状态并触发invalidate。

这里已定位原厂control树、显示开关和事件通路；没有确认向model注册新的枚举值、新页面构造签名或安全对象分配。`UiLiveViewOverlayLayout`字段现有值不能直接解释为XPan/16:9/3:2/1:1。HDMI的独立overlay controller也没有被当成本地Surface或编码源。

## JPEG请求范围与专用队列

输入与输出的静态关系为：

```text
JpegStorage event worker 0x8e0b18
  → 4K task 0x8e17c8
  → RequestImageForJpeg data event
  → IFM background worker 0x49d7c0
  → BL@0x49ddec → 0x496ab0
  → BL@0x496b4c → 0x48c394 (RAW JPEG request)
  → enqueue 0x48fff8
  → ICE JPEG worker 0x7b749c
  → PreviewProcess 0x963a28
  → BL@0x7b8250 → RGB32→RGB24 copy 0x7b982c
  → completed JPEG buffer → encoder 0x8e1d70
```

原厂shell `loadJpeg`通过BL@0x701f70同样调用0x496ab0。0x48c394和clamp辅助0x48f390分别仅有一个直接BL来源（0x496b4c、0x48c7d4）；虚调用和未解析传递仍可能存在。原厂automatic JPEG与shell手动JPEG因此共用路径。局部改变此request的clamp不会直接修改zoom/pan等其他请求，却会影响这两个JPEG消费者。

0x48c768–0x48c7dc把scale限制到[0.01,0.49]，日志直接提及ST-2449。该路径使用原始RAW memory或从文件读取，缺RAW直接失败，不是thumbnail放大。原厂最大中间render、full-size方法、有效crop一致性、取消和RAM预算仍未验证。不得把“能从RAW读取”写成“能安全原生全尺寸输出”。

新增manual导出应独立持有请求身份/范围，明确容量与owner，并在原厂RAW保存完后进行。修改原厂共享常数、压缩质量常数或全局CImageBuffer析构都不是已验证方案。本阶段没有制作任何修改版固件。

## 两种不同图像描述符及所有权

### 原厂Image（0x45fe8c构造）

| 相对偏移 | 字段 | 静态依据 |
| --- | --- | --- |
| +0x0 | format代码 | 0为RGB24，1为RGB16，2为四字节像素 |
| +0x4 / +0x8 | width / height | constructor和JPEG encoder读取 |
| +0xc | row stride，bytes | format0默认width×3；显式参数可覆盖 |
| +0x10 | pixel pointer | constructor保留/写入pointer |

IFM构造器0x4959ec在IFM+0x3fa6e10及+0x7f4cc28初始化**两份3840×3840描述符**，格式0，stride11520，分别引用IFM+0x1010、+0x3fa6e28的内联backing。此“3840²”是初始描述符状态，不是通过实测得出的硬件最高分辨率。

RAW JPEG request收到66,739,712-byte容量常量（0x3fa5e00）。输出锁0x4979d0尝试IFM+0xfb8的mutex，增加+0x7f4cc40锁计数，返回+0x3fa6e10描述符；unlock0x497a9c减少计数并释放mutex。生成请求0x496ab0检查计数是否为1。0x48c394最多等待两个10秒窗口，超时日志警告buffer不能释放，否则UI可能损坏。**现有尺寸常量、capacity和超时限制不能通过任意改clamp消除。**

### P1::IC CImageBuffer（静态0x58-byte对象候选）

| 相对偏移 | 字段/含义 | 读取/构造函数 |
| --- | --- | --- |
| +0x0 | isReference；为0时析构释放base | 0x903f70 / 0x903ca8 |
| +0x4 / +0x8 | 含border总width / totalheight | 0x904478 / 0x904480 |
| +0xc / +0x10 | top / left border | 0x9043c8计算plane |
| +0x14 / +0x18 | **有效width / height** | 0x904448 / 0x904450 |
| +0x1c | EPixelFormat代码候选 | 0x903f70与bpp表0xdc4628 |
| +0x20 | 对齐参数 | 0x903f70 |
| +0x24 | row stride，bytes | 0x904468 |
| +0x28 | backing base pointer | 0x9043c0 / 0x9043c8 |
| +0x30 | total byte size（总height×stride） | 0x904470 |

plane getter0x9043c8返回`base + top*stride + left*bytesPerPixel`。后续adapter必须用有效尺寸与这一plane，不能把+4/+8含border尺寸当作有效RAW输出。reference生命周期须沿原厂析构协议保持，不自行free原厂base。

RAW节点+0x38/+0x3c用于源尺寸，+0x70用于取向。节点+0x88持有pool item，0x8c25c0通过RawPoolAcquire0x6f07cc获取后把pool+0x10指回RAW node；pool+0x18是引用计数。0x8c2668→0x6f0988配对释放，零计数回空闲队列。pool+0x40指向raw payload结构（0x495094读取）；其中payload+0是源载荷指针、+0x10为tags、+0x2d888为源长度字段候选。此载荷尚未确认是压缩IIQ、解压Bayer或哪种缓存，**不把它直接当作可写plane**。

PreviewSource getter的tagID为0x108/0x109（源width/height候选）、0x10a/0x10b（offset候选）、0x10c/0x10d（有效width/height候选），来源0x943378/0x9431f8/0x943078/0x9437f8/0x943978/0x943c88及ICE BuildTags0x7baadc。plane/stride只在实际decode后的CImageBuffer节点恢复；全部仍需实机只读样本确认。

## JPEG LUT节点与sRGB状态

0x7b982c逐行读取source stride，每个四字节像素只复制bytes[1,2,3]至独立、紧密RGB24输出，按width/height循环。这个节点供新增JPEG LUT接入研究，不修改RAW源载荷。但它的输入/输出是否为sRGB尚未证明。

0x975558编码函数的常量为0.003130805、12.92、1.055、-0.055、1/2.4；0x975648解码函数为0.04045、1/12.92、0.055、1/1.055、2.4。数学特征识别为sRGB transfer。0x9756a0从输入/输出enum表读取这些函数，enum0对应这对transfer和D50适配的sRGB矩阵。正式enum名称没有恢复；矩阵与pointer表原值保存在adapter_evidence.json。

通用`ProcessRGBPreview`线程分发0x962ee8有明确RTTI候选，输入CImageBuffer并调用0x962ac8→0x9756a0，但未找到直接BL调用。它并不能证明RAW→JPEG路径经过此转换。JPEG worker里设置局部参数+0x20为5与之前ColorProfile生成变换的关系还未恢复；仅这个数字不足以证明或排除sRGB。LUT只能在后续测量确认/显式转换为sRGB后接入，并限制在新增JPEG范围。

## 复现和机内阻塞

在交接包目录执行：

```sh
python3 tools/firmware/record_adapter_evidence.py analysis/firmware/extracted/P1Linux_6.03.21.bin --out analysis/firmware
/Users/william76/Desktop/ghidra_12.0_PUBLIC/support/analyzeHeadless analysis/firmware/ghidra iq4_static -process P1Linux_6.03.21.bin -noanalysis -scriptPath tools/firmware -postScript DecompileIQ4.java analysis/firmware/decompile_targets_all.txt analysis/firmware/decompiled
```

首次Ghidra导入可把`-process P1Linux_6.03.21.bin`替换为`-import analysis/firmware/extracted/P1Linux_6.03.21.bin`。脚本先验证SHA-256，保留原件。adapter工具保存15份逐指令片段和42个正确命名入口，并检查关键vtable/direct BL来源。

精确阻塞是内部原件/配置只读回收与独立hook禁用/恢复尚未验证、私有C++ABI未实测、full RAW有效crop/渲染容量/取消契约未实测、JPEG sRGB节点未确认、本地Surface与录像源隔离未实测。普通照片卡不自动执行内部hooks；Factory与User共享全局hook，因此Factory可启动也不足以证明坏hook可被禁用。主执行者具备这些证据后才能进行最小临时接入。本离线阶段没有扩大到相机控制，也没有把静态地址当作完成四项机内功能。
