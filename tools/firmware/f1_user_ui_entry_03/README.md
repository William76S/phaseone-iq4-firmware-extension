# User 固件 UI03：原厂 csu 初始化表修订兼容

这是 UI02 的独立极窄派生。原 UI02 所有冻结件保持；九个实际 AArch64 ET_REL 的运行代码、共享64B状态、原31个入口签名、菜单/按钮/队列、exactly-once 原 ctor/unlock、持久 Binding 和64条观测上限、Hold/Detached 退回 OFF 均与 UI02 同字节。默认请求 OFF，机内按钮和五档显示仍需新候选实机验收。本次不执行目标、SDK、Windows、网络或相机。

已定位上一版没有按钮的具体静态启动缺陷：原 `_start` 把非零原 csu 回调 `0x9ef0b0` 传给 libc；原回调以固定 `0xf41da0..0xf42840` 遍历原340个 initializer。只扩 `DT_INIT_ARRAY` 到341项不会改变该回调所读范围。后端02需把 csu 的两组 ADRP+ADD 共四条原指令重定位到**本次实际链接的**新341项表 start/end；这里不填任何上一版地址。

UI03 `stock_windows.hpp` 只在 UI02 的原代码保护集合中排除两个八字节区间 `[0x9ef0bc,0x9ef0c4)` 与 `[0x9ef0c8,0x9ef0d0)`，使后端这四条有依据的指令修订不被自己的不可变 RX 哈希拒绝。中间 `0x9ef0c4` 指令和前后所有原保护字节仍参与哈希。原四条 LE 字节分别为 `942a00f0`、`94022191`、`952a00d0`、`b5823691`，均直接核对固定 stock User SHA `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`。原 header/三个 BL/版本字段例外均保持。

`materialize.py` 在本版是**只读 validator**：核 UI02 源清单、13份运行/继承测试文件字节一致、四原词和七段互补原 RX 窗口，不生成或改写源码。`test_windows.py` 针对四可变词与前/中/后三个必须保护词测试实际 predicate；原 Grid16例和既有 cap/Hold/ABI证据继承其同字节来源，不重新标记成 UI03 实测。`build_objects.py` 使用固定 Zig/toolchain.lock，仅交叉编译九 ET_REL、保留原 unwind/LSDA 并静态核 imports/bindings；新对象路径为 `analysis/firmware/f1_user_ui_entry_03`。

共享 state.h 与 `_01` API保持 UI02/Display12 ABI。最终卡包应绑定 UI03、修订后的 Display13 和 backend02，而不能拿未验证的旧 Surface 类型保护或旧340表消费者当完成条件。版本规划 app6.03.23/release6.03.20/system8.02.2 属后端包装元数据，不是 UI 源内伪造的运行身份。

复现本版的纯主机阶段（生成冻结前；完整最终源码ZIP另给独立11对象 replay，不调用历史 materialize）：

```sh
python3 -B tools/firmware/f1_user_ui_entry_03/materialize.py
python3 -B tools/firmware/f1_user_ui_entry_03/test_windows.py
python3 -B tools/firmware/f1_user_ui_entry_03/build_objects.py
python3 -B tools/firmware/f1_user_ui_entry_03/freeze.py
```

新候选的 ELF 启动、真实 UI owner、Surface/geometry、原厂返回、五档选择、OFF 和恢复路径均不能由本地主机通过代替实机验收。
