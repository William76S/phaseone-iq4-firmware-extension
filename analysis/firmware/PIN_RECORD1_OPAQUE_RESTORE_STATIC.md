# 原 record1 opaque16B 恢复：原厂下层 ABI 与缓存边界

**现有原厂 backend 有不解码 PIN 的16B payload Write/Read ABI；尚未闭合 shell 可达的专用 raw-record setter或PinHandler reload入口，不能直接执行恢复。** 本增量不改已经冻结的 clear 合同，不读设备、实际 PIN或算法，不生成写入命令/载荷。新增主机工具只审计已有私有本地完整快照的差异。

输入 ELF、链接地址与当前 User 同一性限制同冻结 `SECURITY_PIN_CLEAR_NATIVE_STATIC.md`（SHA `445fe1bf0e4e78d5e7f50cc14d7bf326260dbe801bd98936a262b9ac25f9d38f`）。不是可运行私有地址表。

## 1. 原厂 raw-record 方法的窄 ABI

固定 backend vtable `0xc292f0`，System owner来自PinHandler `+0x18`，Main array[1]。只在实际对象、完整 vtable、当前 User SHA/映射/lifetime被核验后，下述寄存器证据才能指导本进程 adapter；本轮不制作万能内存调用。

| 方法 | AArch64 寄存器合同 | 已证边界 |
| --- | --- | --- |
| Open `+0x48→0x720e00` | `x0=System storage owner, w1=key, w2=requestLength, x3=U32*outHandle`，bool `w0` | key1/length16。outHandle先清0，读 cached offset table `owner+0x78` 与length table `+0x80`。存储长度不等只设errorflag，读取 record key低字节必须相等才返回原 offset。不是字符串值接口。 |
| Write `+0x50→0x72104c` | `x0=owner, w1=handle, w2=length, x3=const opaque bytes*`，bool `w0` | 检查 `handle+length+2 <= owner+0x88`，handle非0；读handle+1 stored length，再取min(storedLength,requestedLength)，写handle+2 payload。**不更新key/length/header/cached tables，但自身无条件return true。** |
| Write helper `0x7214c4` | `x0=owner, w1=relativeOffset, w2=length, x3=bytes*`，bool `w0` | 边界后取owner+0x50 EepromPartition，转换参数并调用`0x71e97c`；把status==0转bool。上层Write丢弃它。 |
| Partition Write `0x71e97c` | `x0=partition, x1=bytes*, w2=relativeOffset, w3=length`，status `w0` | relative范围不能超过partition+0x14。加partition+0x10起点，转U16地址，调用EEP device vtable+0x18。System分区起点0x400/size0x800已独立冻结。 |
| Device Write `0x71f21c` | `x0=EEP device owner, x1=bytes*, w2=U16 absoluteOffset, w3=length`，status `w0` | owner+0x18 mutex覆盖open/lseek/单write/close；打开owner+0x10实际动态sysfs路径为O_RDWR；地址+length<=0x4000；失败status2，完整单write后status0。未见本方法fsync或短写循环。 |
| Read `+0x58→0x721328` | `x0=owner, w1=handle, w2=length, x3=out opaque bytes*` | helper低层status存在，但top Read与Pin loader忽略；不能以bool作为全16B读回证明。 |

Partition Write在底层status0后仅读回`min(length,15)`字节（`0x71eac8..0x71eaf4`），16B最后一字节不核对；`0x71ebb0..0x71ec40`不一致仅日志，未将返回status改成失败。top Write、terminal回复或记录日志不足以完成恢复验收。mutex使一次device文件IO串行，并不覆盖partition“写后读回”整段，也不证明所有配置线程已暂停或存储持久完成。

为了只恢复原existing16B，必须拒绝Create、Format、Erase、header重建、缺record、非16长度、offset变化和其他EEP变化。独立全原件比较负责检测record23/24以及所有其他字节，不凭这段直接call列表排除通知/异步线程。

## 2. payload 恢复不会自动恢复 PinHandler 的加载缓存

完整ctor `0x6aa228..0x6aa3b8`：`0x6aa2cc→0x6aa620`加载结果存handler+0x48，随后发布EncodedPinCode，判定undefined并可能clear Locked，最后订阅PinCode与SetPinCode事件。SetPinCode callback `0x6aa520..0x6aa620`更新cache后写record；backend raw Write只写payload，不发这个PinHandler事件、不重新解码cache。

已记录的**直接BL图**只有ctor `0x6aa2cc`调用loader、ctor `0x6aa2e0`调用Encoded发布；这不是间接调用/其他路径的全局不存在证明。KeyStorage Refresh/CopyFromRam走逻辑配置列表，也未建立本raw-record的reload合同。当前正向重载路线是PinHandler正常重建（原厂启动），但原厂正常restart方法、服务argv/owner、重连与恢复验收需单独闭合。不得把写回16B、输入event current、内存cache和重启后有效状态混成一个动作。

新授权的私有“现有已加载cache一次提交原厂PinCode事件”恢复备选另行审计；它不需要改record1，既有纯只读工具仍禁止PIN族文本读取。

## 3. 本地主机精确范围审计工具

`tools/firmware/audit_security_record1_range.py`只读取三个既有私有正规文件：两次原件A/B，以及独立action后candidate。固定candidate EepromDevice兼容形状0x4000 B，System区[0x400,0xc00)；**形状不是实际source extent或完整采集证明**，那些前置仍由Sys原件采集合同和实际metadata/EOF/双读负责。拒绝symlink、长度不合、输入文件在读时改变、原件不一致、非法结构、缺record1、非16B、record移动。

两个有限phase：`native-clear`要求仅原record1 payload可变，candidate该payload必须匹配原厂undefined分支，剩余整0x4000原件字节完全一致；`exact-restore`要求整份candidate逐字节回到原件。不存在写入/替换文件/设备/SDK/transport/解码功能。

输出为固定布尔schema。没有实际路径、record offset、载荷、单值/片段hash、PIN/等级/计数值或异常细节；`device_write_authorized/source_extent_independently_verified/runtime_owner_or_reload_verified`固定false，避免把主机差异审计升格为设备授权与恢复完成。退出0仅为该phase差异契约通过，退出2为不通过。Python文件mode不能证明Windows DACL；私有原件由Root的单用户目录/ACL流程保全，本工具不修改ACL。

测试仅合成快照，覆盖原件不一致、counter/Level/其他区/未用区变化、缺或移动记录、非法长度、精确恢复、未知phase、失败脱敏和不修改文件。运行`python3 tools/firmware/test_audit_security_record1_range.py`。collector只记录确定摘要，不保存随机temp路径/时间。

## 4. 重现与实际止点

`python3 tools/firmware/pin_record1_opaque_restore_collect_static.py`：12个exact code windows、直接BL caller图及原始VA/file offset/bytes SHA；12个合成测试，所有引用冻件哈希固定。重复collector必须相同。

原厂opaque Write接口、payload-only条件和readback弱点已静态闭合。尚无可调用专用shell恢复命令、runtime同一owner、完整原件、前后差异实机结果或独立reload/退出恢复验收；因此无安装物或设备写入。未改旧clear/readonly冻结工具。
