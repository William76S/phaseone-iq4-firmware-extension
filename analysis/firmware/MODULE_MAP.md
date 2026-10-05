# IQ4 6.03.18 固件模块地图与入口证据

记录日期：2026-10-04，Asia/Shanghai。此目录工作只读取本地原件，不连接、控制或修改相机。所有函数与能力结论均为静态分析；主机校验仅验证解包工具和本地内容，未作任何临时机内或持久验收。

## 输入、已有研究与完整性

| 输入 | SHA-256 | 大小 |
| --- | --- | ---: |
| Firmware-BP-IQ4-IQ4_6.03.18.fwr | a52758ffb163023e5323297e450450f91002175b69bed7590fe2cd037c2ab300 | 78,351,289 |
| Boot_4.00.13.bin | 7a3a3d6f62c61e7d627a9f55d844d74be9111b26eb7a7fa42f5bdd7be7dabe9e | 71,874,288 |
| P1Linux_6.03.21.bin | 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb | 11,874,544 |
| Boot ramdisk ext2 | 2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb | 134,217,728 |

已优先检查 `/Users/william76/Documents/Codex/2026-07-16/w-2`。其 `iq4_fw` 的20个提取成员全部与本次包哈希一致；旧ramdisk解压镜像也完全一致。旧 `work/export_sensor_profiles.py` 和 `outputs/sensor_profiles_README.md` 可复用为49³原厂sensor transform格式参考；README明确该表不可直接当作sRGB显示风格，也不可直接写回固件。完整路径、哈希和匹配记录见 `prior_research.json`。

原始.fwr是标准ZIP，20个成员、无ZIP注释，成员未设置ZIP加密位；ZIP条目CRC32全部验证通过。`manifest.xml` 声明 release 6.03.18、LinuxApp 6.03.21、兼容版本5、model_ids 0x125/0x126/0x122、hw_revisions 1/2/3、minimum_update_version 2.00.14。成员在压缩流中的精确位置见 `inventory.json`。没有把CRC或MD5当作密码学真实性验证。

P1Linux的固件验证日志与`ComponentSignature`内容涉及MD5（例如文件偏移0x83a508的`MD5 check failed for %s`）。Boot FSBL存在RSA/eFUSE/SHA3认证错误代码与字符串（如Boot偏移0x35c12、0x35bd3）。本次没有验证Boot partition authentication flags、目标机secure boot状态或修改版包接收条件，因此**固件真实性检查、修改版固件安装和恢复仍未验证**。

## 容器、系统与地址规则

P1Linux是真实 ELF64 little-endian AArch64 ET_EXEC（e_machine 183），动态解释器 `/lib/ld-linux-aarch64.so.1`，stripped，GNU BuildID `1f451370d713ae1f341e9d5de5615717f9fb36ed`，entry 0x40b38c。`.text` 文件偏移0xb230、linked VA 0x40b230，`.rodata` 偏移0x5ef170、VA 0x9ef170。第一LOAD的代码/只读数据 VA = file offset + 0x400000；第二LOAD的数据 VA = file offset + 0x410000。不要把这一转换应用到Boot、压缩流或任何运行时ASLR/搬运地址。

链接依赖是 libfreetype、z、drm、aio、stdc++、m、gcc_s、pthread、c。无Qt/QML动态依赖证据；保留的C++类型与源路径指向原厂 `UiIQ4`、`Ui/Framework`，仅凭这些不能确定可注入页的ABI。动态符号保留了部分stdc++导出，llvm-objdump会给其他私有函数附上最近导出符号的名字和巨大偏移；这些名字**不是该私有函数的身份**。本报告的函数起点依据`.eh_frame_hdr` unwind表（编码01 1b 03 3b）与逐指令确认，命名来自附近明确日志/RTTI，仍需进一步恢复签名。

Boot的静态结构：

| Boot文件偏移 | 内容 | 验证 |
| --- | --- | --- |
| 0x86430 | 第一个FDT，root model `ZynqMP Magnar` | FDT token解析 |
| 0x88d400 | 嵌入ELF64候选 | binwalk静态识别 |
| 0x891de0 | gzip内核.config | 正常解压115,842 bytes |
| 0xdd4440 | FDT，root model `P1 IQ4`，compatible `xlnx,zynqmp` | FDT token解析 |
| 0xddc0c0 | uImage头，名称P1 ramdisk | 头CRC32 94d64018通过 |
| 0xddc100 | gzip ext2 ramdisk，16,062,154 bytes | 数据CRC32 15ccf0f8通过 |
| 0x1d441c0 | SquashFS，41,173,245 bytes | 7z清单只含中文/日文/韩文字体及md5sums |
| 0x44891c0 | 原厂ASCII启动环境段 | `boot_environment.static.txt` |

ramdisk中内核模块目录为 `4.19.0-p1-iq4-82477-gff46069`，libc文件为2.28，libstdc++为6.0.25。`boot_inventory.json` 保存3047个路径的inode、mode、uid/gid、数据block列表和SHA-256；`rootfs_static`只提取必要的普通脚本文件，未执行、挂载、创建设备节点或恢复symlink。66个文件与旧镜像的7z提取结果独立比对完全一致。

## 可恢复执行入口与重要门控

下述为**静态入口**，没有证明实机上可通过USB/Capture One操作，也没有证明物理恢复模式能启动。

1. `rootfs_static/etc/init.d/p1-link-to-user-storage.sh:24–39`：正常启动将`/run/media/storage`链接到`/mnt/qspi`。仅`/proc/cmdline`包含`modeboot=sdboot`时才链接`/var/run/media/mmc*`。正常照片卡上的hook文件不会自然执行。
2. `p1-mount-qspi-partitions.sh:8–15`：`ubiattach ... -m 1`后挂载`/dev/ubi0_0`至`/mnt/qspi`。这是内部持久存储，不是普通照片卡目录。
3. `etc/inittab:7,20`运行`p1-rcS`和respawn的`/p1/scripts/boot_run_p1linux.sh`。`S40userhook.sh`→`userhook.sh:10–13`执行`/run/media/storage/autostart.sh`；`S95p1-late-userhook.sh`→`p1-late-userhook.sh:7–10`执行`late-autostart.sh`。两者无debug文件门控，均同步执行，任何hook必须很快返回并自行限制后台任务。
4. `p1-create-user-or-factory-state.sh:31–34`根据cmdline `user_or_factory=factory`写`/run/boot_is_factory`，否则写user标志。`boot_run_p1linux.sh:53–65`据此选择内部`Factory/p1linux`或`User/p1linux`。
5. `boot_run_p1linux.sh:77–87`在`p1linux=skip`或内部`debug`文件存在时不启动原厂应用；`p1-enable-dev-services-if-debug-board.sh:11–18`还会启动SSH/inetd。**创建debug不是无害开关，会改变正常相机启动行为。**
6. 静态boot env支持`boot_method=qspi/shell/nfs`，`bootargs.shell`追加`init=/sbin/init_shell`。`init_shell:25–27`可挂载qspi并运行`init_shell-autostart.sh`。物理按键/启动加载如何激活这些分支尚未知；不得将它们描述为已验证恢复步骤。
7. `boot_run_p1linux.sh:98–119`会把User/Factory `p1linux.bin`更新原件。没有备份或恢复验证时，**不可投放这个文件**。Factory模式仍共享storage下的早/晚hook；故仅“能进Factory”也不必然保证坏hook被禁用。

`tools/firmware/minimal_late_hook_candidate.sh`是未安装候选：只在volatile `/run/iq4-extension-probe`写内核/架构/运行时内存和storage symlink诊断并退出，不启动服务、不改原厂应用、配置、校准、密钥或引导选择。主机仅通过`sh -n`和临时目录执行后退出测试；macOS无Linux /proc，本机字段未验证。此候选不是任何已部署功能。安装前仍需独立验证内部文件传输、备份、禁用和恢复路线。

## IQP shell与原厂文件操作候选

| 入口 | P1Linux linked VA / 文件偏移 | 静态调用关系与限制 |
| --- | --- | --- |
| IqpDevelopmentHandler的队列事件 | 0x862ce4 / 0x462ce4 | 收队列事件后调用0x862d5c |
| 接收development应用消息 | 0x862d5c / 0x462d5c | 校验CommonMessage字段class=0xff/type=1，按header相对偏移取payload后调用0x8637e0；这些仅是本版本代码字段，完整wire包/通道权限未证明 |
| development shell分发 | 0x863028 / 0x463028 | 检查消息+6为3、忙标志，shell type +4为1时调用0x871e24 |
| 原厂development shell command对象 | 0x872828 / 0x472828 | 注册说明`Runs an IQP devel command directly as on the main-shell`，vtable 0xda7d48，执行slot 0xda7d90→0x8728c8 |
| command执行handler | 0x8728c8 / 0x4728c8 | 命令类型参数仅0进入解析，最后通过其shell对象vtable +0xa8执行；调用者/主机API门控仍未知 |
| LinuxCommands注册 | 0x6c300c / 0x2c300c | 注册sys/system诊断命令；strings包括系统命令、目录清单、Debug/Restart/Quit |
| FileManager命令help | 0x6f25ec / 0x2f25ec | 静态help仅承诺list/md5/signature；不能据此认定可读写任意文件 |

静态字符串有`sys cat /mnt/qspi/ethdebug.cfg`示例（file0x5f61e8），BootBin `dump user/factory`路径（file0x815e98）与`/var/volatile/ftp/boot_dump.bin`（file0x815c70）。若串行执行者取得已确认原厂命令会话，可先限于help/list、readlink、cat /proc、原件哈希/读回；不用遍历写未知property、debug/quit、签名修改或BootBin install/clone。当前C1界面和公开CameraSDK是否暴露这些development协议尚未验证，故未发送任何协议。

## F1：UI与遮罩候选

`UiIQ4LiveViewDialog` source字符串位于file0x79a598。本次逐指令/反编译纠正早期按字符串命名的候选：**0x51ea88是触摸/输入事件，不是渲染；0x51b768是property/event回调，不是构造器；0x520684是短暂overlay显示开关，不是LV停止。**构造器是0x5175b8，实际本地LV绘制回调0x51da0c，LV启动0x5202a0，LV停止0x520590。

构造器安装vtable 0xb9a9d8；slot +0xa0→0x51da0c、+0x108→0x51ea88、+0x1c8→0x51b768，dialog生命周期slot +0x170/+0x178→0x51d884/0x51d9bc。函数与文件偏移的固定差0x400000仅适用于本ELF上述LOAD。私有回调使用C++返回结构时可能含AAPCS64隐藏x8参数，**Ghidra伪C签名不是可调用ABI**。

0x51da0c先通过0x6b618c合法锁LV，调用0x6b61fc/0x6b621c取得尺寸/rect，再用0x45fe8c构造format=0、stride=width×3的Image；0x51ddcc通过0x477038将图像绘至独立Surface，最后通过0x6b6250释放。此顺序支持在本地Surface或子control中绘构图遮罩的候选；没有把mask写入RAW/JPEG源buffer的必要，但仍须实机验证显示层、录像输入与编码帧彼此隔离。

原厂overlay control构造器0x5473e4安装vtable 0xba6540，在LV dialog +0xd48保存该control，构造多个grid子control（0x548b08、vtable 0xba6880），并用0x4ab898添加到control树。0x547c60处理grid/property事件，0x54803c只处理0/90/180/270°旋转；它不是宽高比选择函数。0x4ac144按control+0x6f显示状态触发invalidate。`UiLiveViewOverlayTimer`/`UiLiveViewZoomOverlayTimer`在file0x79a470/0x79a488，refs指向0x5175b8；`UiLiveViewOverlayEnable/Layout`在file0x7e4110/0x7e4128，refs指向0x64270c的数据事件组构造器。这些现有enum/layout只证明grid框架存在，尚未恢复可注册新页或五个遮罩选项的受验证ABI。

HDMI另有 `HdmiOverlayController` 0x45ae84（file0x774500来源路径），说明本地/HDMI不能未经跟踪就假设共享叠加层。静态boot env配置LCD480×800，真实显示区域与方向仍由实机测量。具体逐指令证据、对象布局与更正记录见 `UI_JPEG_ABI.md`、`adapter_evidence.json` 和 `adapter_*.disasm.txt`。

## F2/F3：JPEG真实RAW入口和缩放上限

`jpeg_image_from_raw.disasm.txt`函数0x48c394（file0x8c394）是ImageForJpeg原厂路径：原始RAW可用性在0x48c65c–0x48c670检查；源尺寸来自对象+0x38/+0x3c，请求尺寸来自传入对象+4/+8；比值在0x48c71c–0x48c75c计算。

**实质限制已确认：**0x48c768–0x48c7dc用IEEE754常量0x3efae148（0.49）和0x3c23d70a（0.01）把scale限制为[0.01,0.49]，辅助0x48f390逐指令是clamp。file0x77daa0日志明确`Using different scale factor ... See ST-2449`。取向另行变换后，0x48c880将clamped scale写入ICE任务结构；0x48c938→0x48fff8排队处理，最多两个10秒等待窗口，超时日志说明缓冲不可释放。因而只改UI/JPEG尺寸常量不足以保证50%、75%、8K或原生输出，直接放大也不能满足需求。

4K JPEG后台任务候选0x8e17c8（file0x4e17c8），后续调用0x8e1d70编码；后者通过编码对象vtable+0x20接收RGB、width/height、质量常量90和100MiB输出缓冲预算，并计算未压缩字节width×height×3。另有JPEG压缩候选0x6b135c。原厂`P1::IC` RAW处理、PreviewGenerator、StyleManager、Resampler都静态编进应用（具体refs见string_references.json），但完整RAW全尺寸可达性、最高中间尺寸、色域/transfer及分块接口仍未知。

**缓冲与入口更正：**0x4959ec是IFM对象构造器，并非RequestImageForJpeg实际方法；0x496ab0才是向0x48c394发送RAW→JPEG请求的方法，并非release。真正JPEG输出锁/释放在0x4979d0/0x497a9c。构造器在IFM+0x3fa6e10和+0x7f4cc28建立两份Image描述符，初始都是3840×3840、format0/RGB24、stride11520；两份分别引用IFM+0x1010和+0x3fa6e28的内联backing区域。专用JPEG请求同时传容量0x3fa5e00（66,739,712 bytes）。这只是本版本静态对象契约，不是实测可用内存或完整RAW渲染能力。

直接BL证据：0x48f390只有0x48c7d4一个调用；0x48c394只有0x496b4c一个调用；0x496ab0则由0x49ddec后台事件和0x701f70原厂shell `loadJpeg`调用。自动JPEG存储事件0x8e0b18→0x8e17c8→IFM RequestImageForJpeg事件→0x49d7c0→0x496ab0→0x48c394。因此只改此request的clamp不会直接改zoom/pan等其他请求，但**会影响原厂自动与shell手动JPEG两者**，不能称为只修改新增manual导出。新的manual导出必须有独立请求身份、输出容量、有效尺寸、owner和超时取消/释放契约；没有运行时验证前，禁止将修改clamp作为全尺寸实现。

ICE专用请求worker0x7b749c→原厂预览处理0x963a28→0x7b982c，将渲染后的四字节像素中bytes[1,2,3]复制为独立RGB24输出。0x7b982c按传入source stride逐行读取，而目标为width×3紧密排列，是新增JPEG LUT候选点；它不修改原始RAW载荷。完整有效尺寸须从CImageBuffer+0x14/+0x18取得，+4/+8是含border的总尺寸。CImageBuffer+0x24为row stride、+0x28为backing base、plane getter0x9043c8会另加x/y border；owner/reference flag+0决定析构是否释放内存。详细字段及RAW pool引用计数见 `UI_JPEG_ABI.md`。

原厂数学上存在sRGB transfer：0x975558的0.003130805/12.92/1.055/0.055和0x975648的0.04045/12.92/2.4；RGB2RGB变换0x9756a0中enum0对应这些函数和D50适配的sRGB矩阵，这是静态数学识别，不是正式恢复的enum名称。**JPEG候选RGB24节点的真实输入色域/transfer仍未确认**。通用RGB线程入口0x962ee8没有发现直接BL调用，不能据此宣称当前RAW→JPEG链已完成sRGB转换。worker的局部设置+0x20数值5不足以独立判定色域，必须跟踪其与ColorProfile预先生成的变换/输出格式语义。此阶段没有将任何JPEG像素标为已验证sRGB。

LUT需要置于新增JPEG的已确认sRGB RGB节点；49³SensorProfile或costyle入口不能代替sRGB cube导入。此次未修改sensor profiles、RAW Bayer数据或RAW元数据。

## F4：未合成LV缓冲与编码候选

原厂`LiveViewAccess`锁/释放函数0x6b618c（file0x2b618c）和0x6b6250（file0x2b6250）都先比较client id与access对象+0xb0的owner；不匹配返回空/false。owner满足才从access对象+8取得底层engine并转入0x6b6d1c / 0x6b6da0。内层engine+0x2170作为PlFunctions VideoBuffer对象。

`lv_video_buffer_lock.disasm.txt`包含0x6b6a3c锁：当前index+0xe4复制至锁index+0xe8；+0xf0复制至锁ID+0xf4；从指针表[index+2]返回数据指针。0x6b6b30释放，将锁index置4；0x6b6c80读取locked ID，未锁时返回0；0x6b6b70/0x6b6be0读取锁尺寸。日志明示double lock不支持。locked ID的单位、是否每个传感器新帧递增、wrap行为、pixel布局/stride、缓存同步都未实测，不能直接把此ID标为传感器计数器。

IQP LV控制实际函数0x86a390，SetEngineConfiguration 0x86bb64。其日志明确crop配置与buffer锁失败；最终机内录制应接到同一个合法owner或原厂消费者调用链中，不能让第二客户端并发抢锁。未确认video buffer未叠加UI及HDMI路径的像素一致性。

`kernel.config.txt`（Boot0x891de0 gzip）line3380明确`# CONFIG_XILINX_VCU is not set`；存在V4L2、xilinx framebuffer/scaler/rgb2yuv等驱动支持。3047路径rootfs清单未发现ffmpeg、libavcodec或x264库；应用也无H.264编解码符号证据。不能凭ZynqMP名称认定硬件编码器。这里的static encoder unknown不是断言硬件永远无编码能力。MJPEG仍需要真实LV性能、单帧JPEG编码耗时、写卡和收尾实测，SDK JPEG LV12fps不等于机内编码性能上限。

## 复现与下一步

在交接包目录执行：

```sh
python3 tools/firmware/inspect_firmware.py ../Firmware-BP-IQ4-IQ4_6.03.18.fwr --out analysis/firmware
python3 tools/firmware/inspect_boot.py analysis/firmware/extracted/Boot_4.00.13.bin --out analysis/firmware
python3 tools/firmware/map_p1linux.py analysis/firmware/extracted/P1Linux_6.03.21.bin --out analysis/firmware
python3 tools/firmware/record_adapter_evidence.py analysis/firmware/extracted/P1Linux_6.03.21.bin --out analysis/firmware
```

这些生成器绑定精确输入SHA256，不制作修改版固件，也不执行相机部署。`string_references.json`保守记录ADRP+ADD候选，候选存在不等于控制流可达；逐指令确认的重要区间保存在`*.disasm.txt`。`unwind_functions.json`包含函数边界和直接BL候选调用，不包含全部虚调用。可逐区间用本机llvm-objdump复现反汇编。

`tools/firmware/DecompileIQ4.java`与`decompile_targets_all.txt`可在本地Ghidra12/Java21复现91个指定函数的伪C；输入SHA-256检查在输出前执行。使用`-noanalysis`保留有限范围；未恢复完整C++类型和所有函数/PLT原型，部分tail branch会被反编译器扩展为共享代码。所有需要支持行为结论的字段、constant和调用点均回到llvm逐指令证据，而不是按伪C的函数名/签名调用。`EVIDENCE_SHA256.json`记录源码、JSON、脚本和反汇编/伪C证据哈希，原始.fwr哈希复核不变。

当前优先阻塞是已确认内部只读文件传输/主机development通道和独立恢复入口，缺这两项不能安装hook或修改User p1linux。可以继续原厂SDK/C1 LV基线、完整RAW主机对照、UI/RAW/编码链离线签名恢复。取得入口后先读回实际目标配置和原件，再验证不加载扩展的恢复流程；不要预设Factory模式自动屏蔽全局hook。
