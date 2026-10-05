# FileId405 原件路径与 open 失败折叠

这是对 Windows 执行者单次官方 SDK read405 返回 generic kError、无文件结果的**离线条件分析**，不是当前相机错误原因的判定。没有再次调用 SDK、访问设备、查询/改变认证、读写相机文件或执行恢复操作。执行入口及 F4 源事件冻结材料未修改。

## 405 的精确目标

模块 SHA-256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`，链接 VA 绑定本包 Linux ELF。初始化 data 的 offset=VA−`0x410000`；code/rodata offset=VA−`0x400000`。

| 公开/外部 ID 候选 | 固定 entry VA | internal ID / folder / basename | 静态用途 |
| --- | --- | --- | --- |
| 405 | `0xf56030` | 5 / 4 / **p1linux**，flags3 | User 应用原件 |
| 406 | `0xf56058` | 6 / 4 / **p1linux.bin**，flags3 | User 安装触发文件 |
| 415 | `0xf56288` | 15 / 5 / **p1linux**，flags3 | Factory 应用原件 |
| 416 | `0xf562b0` | 16 / 5 / **p1linux.bin**，flags3 | Factory 安装触发文件 |

**405 不指向 p1linux.bin。** `0x750fdc` 将 fileId 减400，`0x74e120` 找固定表。folder4/5 表分别是 `/run/media/storage/User/`、`/run/media/storage/Factory/`；`0x74d928..0x74d940` 为每个默认 folder 构造/保存 LinuxFileSystem owner。mode1 在 `0x751074` 传 resolver 的 w2=1，`0x74e4b0..0x74e4d8` 取缓存 owner；basename 未添加 `.bin` 后缀。Linux vtable `0xd91450+0x28` 指向 open `0x825ed4`。

rootfs 的 `p1-link-to-user-storage.sh:24–39` 正常 boot 执行 `/run/media/storage → /mnt/qspi` 的 symlink；只有 cmdline 含 `modeboot=sdboot` 才链接 SD mmc 路径。这是**启动脚本的路径解析条件**，不是 C++ file-table override，也不是已读取当前设备 mount。`boot_run_p1linux.sh:53–65` 从该 alias 的 User/Factory **p1linux** 启动；`98–119` 将存在的 `.bin` 升级文件解压/移动覆盖 p1linux。因此正常 User boot 的405候选实际 inode 路径为 `/mnt/qspi/User/p1linux`。当前启动模式、symlink、mount、实际 `/proc/self/exe` 均缺只读运行证据。

## 设备拒绝在何处丢失 errno

| 分支 | 精确指令 | 可见的返回 |
| --- | --- | --- |
| 超出本 client 范围 / 未找到 fixedFileId | `0x750fc0..0x750fcc`、`0x750ff4..0x751000` | client2：继续寻找其他 client。405 在精确表中存在，不是静态白名单缺失。 |
| client 仍有活动文件 | client+`0x30` 非0，`0x751004..0x751030` | client1：拒绝。当前值未知。 |
| mode1 无 read flag | `0x751048..0x751060` 失败，最终 `0x751208` | client1；本固定表 flags3 含 read bit，不能由表静态推导为当前配置拒绝。 |
| 相对路径构造失败 | `0x825f04..0x825f40` 失败 | false，再折 client1。正常短 basename/path 仍未在当前对象验证。 |
| Linux open 失败 | `0x825fcc` 调 OS open；负 fd 到 `0x825ff8..0x826004` 转 boolfalse | `0x7510b8..0x7510d0` 返回 client1。此分支没有把 errno放入返回字段，也没有 open errno日志。 |
| 上层 read-open client1 | `0x870594..0x870598`、`0x87061c..0x870620` | read-open result2；failure transferId `0xffffffff`。busy也可产生result2。 |
| 所有 client 未处理 | `0x8705d8..0x8705e4` 后 `0x870628..0x87062c` | read-open result1。 |

这与通道 open authentication result6 是不同枚举。host generic−1 也不是设备 errno；是否已到上述 client，必须用原厂 SDK 日志/内部响应路径证明。SDK侧 host gate、channel open、协商和 transport 错误折叠由 SDK代理独立核对。

成功 client 取得 FileStream size 写 expectedSize，并返回client0。expectedSize=0 时上层 `0x870564..0x87058c` 记录日志仍走成功分支；不能将没有备份文件直接认定为零长度被设备立刻拒绝。旧记录这一点已由冻结 `FILE_READ_TRANSPORT.md` 更正。

## O_RDWR 与当前运行应用：候选原因及边界

设备 mode1 的实际调用 `0x75109c..0x7510b4` 是 `(writeFlag=0,rwFlag=1,syncFlag=0)`。`0x825f88..0x825fa4` 选择 flags **0x80002 = O_CLOEXEC | O_RDWR**；不是 O_RDONLY，也没有进入 writeFlag=true 的 create/truncate分支。

如果405 inode就是当前正在执行的 User ELF，**Linux 的可写打开执行文件限制（ETXTBSY）是应优先排查的候选**。这解释为什么“功能只读”仍可能无法读当前原件。它不能被当前静态应用指令独立证明：未恢复该固件 kernel 的 open/exec deny-write实现，未取得当前exec inode或errno，也未证明 Windows错误已经到设备open。这里没有运行别的平台试验来替代IQ4。

其他仍可折成同一 false/client1/result2 的候选包括不存在/路径alias错误、只读挂载、Unix权限拒绝、fd资源耗尽；本函数不会把这些 errno区分给主机。不得凭一次kError改权限、改mount为rw、停止原厂应用、切换User/Factory或换成安装文件试写。Factory静态原件存在并不证明实机可读或恢复已通过。

能区分原因的下一份必要证据是原厂日志显示是否发送并收到Programming read-open、收到的精确result/transferId、transport/channel状态。若合法临时只读诊断入口以后成立，再记录当前 executable真实路径/inode、User文件状态、mount/uid/mode及原厂open失败errno；在此之前，405备份仍未完成。没有本阶段生成的设备重试/线路包/注入安装物。

## 复现

工程根运行 `python3 tools/firmware/file405_open_failure_collect_static.py`：校验精确ELF，保存3个新增窄窗口、6个原字节表、4个不改写冻结引用与3个启动脚本摘要。独立 `FILE405_OPEN_FAILURE_SHA256.json`；旧 manifest 与根文档均保持不变。
