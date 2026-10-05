# 录像控制与输出核心

验证层级：主机 C++17，mock 后端、合成帧和本机临时目录。未接入 IQ4 帧生产者、原厂 UI、编码器或存储卡；不是可安装机内功能。

`sh src/runtime/build_host.sh` 使用 AddressSanitizer/UndefinedBehaviorSanitizer，测试有界队列、拥有输入缓冲、严格递增 PTS、未知源丢帧保留 unknown、队列丢弃计数、重复按钮、20 次启停、源中断、准备/编码/收尾失败、文件名碰撞、符号链接和中断临时文件。

`Backend` 必须由经实测的 IQ4 适配器提供。`prepare/encode/finalize/abort` 全部由一个事件执行线程串行调用，页面退出调用 `exit_page()`，不得让 UI 和工作线程并发调用同一 Recorder。`start()` 初始化完成且第一帧成功编码后才亮录制指示；`submit()` 只接收自身拥有的字节，SDK借用内存需在上层及时复制/归还。PTS 由真实采集来源提供，此层不会补帧或把接收计数当传感器帧数。

`AtomicOutput` 在同目录创建独占 `.iq4ext.partial`、同步数据后以 POSIX hardlink 发布独占最终名、同步目录、删除临时名称再同步。失败保留临时材料，不覆写既有文件。目录符号链接、叶名称路径穿越均拒绝。

**目标适配限制**：FAT/exFAT不支持hardlink，本实现必须拒绝该文件系统上的publish；不得把主机APFS通过当作IQ4卡验收。目标卡需实现并测试其实际支持的独占 rename/publish、断电/截断恢复语义，再接入。发布后目录同步失败有可能留下最终文件和临时硬链接，该状态会报错而不会报告成功。这里只完成文件事务控制；视频索引、MP4修复、编码和15分钟实测仍未完成。
