# F4 JPEG packet 容器与写入生命周期后端 0.2

验证层级：主机。复用 `src/runtime/Recorder`，实现严格 CFR MJPEG AVI、真实间隔 VFR MJPEG Matroska、独占临时写入/发布、错误与中止恢复。未连接相机、调用私有编码器、取得机内 LV、写入真实相机存储卡或完成机内安装。主机 JPEG 测试素材与人工时间戳不能证明 IQ4 分辨率、新帧率或编码性能。

## 接入边界

`MjpegAviBackend`、`MjpegMatroskaBackend` 实现原有 `runtime::Backend`。`encode(Frame)` 只接受自有字节中的完整 8bit baseline JPEG；检查 SOI/EOI、SOF0、尺寸、单包/帧数/文件预算、PTS 严格递增和已提供源序号递增。结构检查不替代 JPEG 解码校验；本次实际解码由 FFmpeg 独立完成。调用者负责真实编码、图像完整性、色彩、源计数可信性和 SDK/原厂 buffer 生命周期。

容器层没有 RGB 编码、缩放、补帧、音轨、UI 合成或相机控制。相同 JPEG 内容可来自静止场景，允许保存；既不靠内容 hash 宣称重复，也不自动制造额外 packet。借用 LV 缓冲须先在生产者仍拥有时完成消费/复制并及时释放，后端仅持有 `Frame` 自有数据。

所有方法按既有 Recorder 契约在一个执行者串行运行。正常 Stop 排空已拥有队列并收尾；源丢失排空和发布后由 Recorder 进入 Error；准备、编码、写入或收尾失败调用幂等 `abort()`，保留 partial。backend 对象可重复 prepare，命名计数继续；重新启动遇到既有输出/partial 自动跳过，最多搜索1024个候选，始终不覆盖。

## 时间轴

AVI 无逐包独立 PTS。默认 `ptsToleranceNs=0`，逐包要求真实输入 PTS 匹配首帧起的 rational CFR 时间格，正值半入到纳秒；任何不规则间隔、丢帧后的时间缺口或重复/回退立即拒绝，保留已写前缀，不偷偷变成帧数/rate。可显式设置不超过1/4帧间隔的小容差；偏差与原始 PTS 仍保存在记录中，必须声明该 CFR 兼容策略。`rateNumerator/rateDenominator` 只定义播放时间格，绝不是源新帧率证据。

Matroska 使用 `V_MJPEG`、`TimestampScale=1ns`、每包独立 Cluster/SimpleBlock，逐包 PTS 为输入值减首帧，原始间隔精确保留。不写 nominal FPS、DefaultDuration、伪音轨或猜测最后一帧的显示时长；最后画面结束持有时长未知，未伪造。收尾写入已知 Segment 长度、同步并独占发布；当前没有 Cues seek 索引，已经过 FFmpeg 顺序读取、解码与精确 PTS 验证，其他播放器/长视频 seek 仍待验证。[Matroska 元素规范](https://www.matroska.org/technical/elements.html)、[V_MJPEG 映射](https://www.matroska.org/technical/codec_specs.html#v_mjpeg)。

每个 packet 后附允许被解码器忽略的 `IQ4T` 记录：AVI 的 JUNK 或 Matroska 的 Void，保留原始绝对 PTS、可选源序号/有效标记、JPEG 长度和 CRC32。CRC覆盖JPEG与时间记录；它用于识别中断/损坏，不是密码学真实性证明。

**FFprobe 陷阱**：1ns Matroska 时基使本次 `r_frame_rate` 被猜成 `1000000000/1`，`avg_frame_rate` 为 `0/0`。这些字段不能作为源FPS或 UI 能力；实际证明是 packet PTS 与输入逐个精确匹配。AVI 的 `30/1` 同样只是 nominal playback rate。本组件不声明任何 IQ4 录像模式可用。

## FAT/exFAT 所需写入路线

`ExclusiveFile` 在实际目录 fd 内以 O_EXCL/O_NOFOLLOW 创建 `<唯一名>.iq4rec.partial`，受控 write/pwrite、同步完成数据、关闭文件，然后用系统提供的 **exclusive no-replace rename** 发布：macOS `renameatx_np(RENAME_EXCL)`、Linux `renameat2(RENAME_NOREPLACE)`。没有 `link/linkat`、没有“先检查后普通rename”的覆写窗口，也不把预先创建的空最终名当作完成文件。

文件状态为 Temporary → Sealed → FinalNameVisible → Complete。一旦收尾开始或最终名可见，就拒绝后续 append/patch/publish；最终 rename 成功但目录同步失败，会明确报告“可见但持久性未确认”，不能宣称完成，也不再修改该文件。缺 no-replace rename、文件系统不支持、满卡/EIO、同步失败等均报错并保留具体阶段。临时文件可能保留已完整编码包或部分尾包，必须按下面恢复入口处理。

这消除了对 APFS 硬链接的依赖；**并未证明目标 IQ4 的内核/挂载支持该 rename 或目录 fsync，更未验收 FAT/exFAT 卡**。实际目标还要验证挂载、剩余空间、rename原语、同步、最大文件与断电语义。代码默认1GiB段上限，最大允许小于等于 FAT32 的 `0xffffffff` 字节；达到段预算停止报错，不擅自无限写入。当前未自动轮换下一段；接入层应在预算耗尽前停止当前段，再用新文件开始，或实现并验证分段协调器。

## 可控中止与恢复

`recoverPartial`（AVI）和 `recoverMatroskaPartial` 只读打开本后端可识别的 `.iq4rec.partial`，验证头、尺寸/配置和每个完整 packet+时间记录+CRC。遇到截断、损坏或不完整尾部停止扫描，将完整前缀重新写入**新独占文件**并正常收尾。原始 partial 始终保留不改；没有完整 packet 时拒绝成功。

恢复仅适用于本后端格式和已知配置，不声称修复任意 AVI/MKV、任意断电损坏或丢失未同步数据。默认录制不逐帧 fsync，任意断电可能丢失缓存中的已写数据。第一次上机须先做受控停止/故障实验，再决定同步频率和断电测试，保留原厂热保护。

## 主机与 CTest 入口

直接构建：

```sh
sh src/recording/build_host.sh
build/host-venv/bin/python tests/recording/run_host_validation.py \
  --test-executable evidence/recording/build/iq4_recording_tests \
  --evidence-root evidence/recording/runs
```

runner 每次使用 `mkdtemp` 创建全新测试目录，Pillow 生成96×64合成JPEG；没有Pillow时由stdlib解码随附host合成baseline JPEG，用相同静态素材测试包数与时间轴。测试从不访问设备或用户照片。随后调用 FFmpeg/FFprobe 检查真实解码、完整帧数、每个 JPEG packet 与输入字节相同及 VFR PTS 精确匹配；缺解码工具明确失败，不跳过。

根 CMake 加 `add_subdirectory(src/recording)`，配置 `-DPython3_EXECUTABLE=<绝对路径>/build/host-venv/bin/python`。子目录注册 `iq4_recording_media_host_validation`；host CTest 调同一入口。目标交叉构建只应编译库，host 测试需要真实宿主执行，不能把未执行的目标 ELF 当作通过测试。没有修改根 CMake、STATUS 或能力主记录。

## 最终冻结源码的实测证据

2026-10-04 08:41（Asia/Shanghai）：优化 C++17 构建24/24通过；ASan+UBSan冻结源码24/24通过。两轮各对10个正常/恢复文件完整解码52帧，JPEG packet逐字节一致，Matroska不规则时间轴逐纳秒精确。LeakSanitizer在本平台不支持，未宣称完成。

覆盖：正常Stop/第二次开始、重启既有文件跳过、AVI不规则PTS明确拒绝、小容差显式记录、静止同内容包、中止前缀恢复、短write与ENOSPC尾包、pwrite EIO、file fsync EIO、rename不支持、发布碰撞/符号链接、rename后目录sync失败与拒绝再写、CRC损坏、非法JPEG/尺寸/PTS、段容量、输入路径/配置拒绝、VFR原始时间轴、VFR中止/满卡、源丢失收尾和reset。

冻结实现 SHA-256：

- `mjpeg_avi.cpp`: `0d9a5e2b2a0713d88288a9723ee71b12badfad67af35db9f7270da8608b04826`
- `mjpeg_avi.hpp`: `d1942e97c029f706a86e60ea02fa6fde3b7669a289f37e83151b393ef325180e`

完整源码/依赖/host产物哈希见 `evidence/recording/SHA256SUMS.txt`。主机记录 `host_verification.json`、`sanitizer_verification.json`、`MEDIA_VALIDATION.json`；实际日志 `build/ctest_runner_validation.log`、`build/sanitizer_test.log`。机内 RGB→JPEG、真实帧源、UI、写卡、持续性能和持久部署均未接入。
