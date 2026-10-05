# 真实 User 固件 UI 入口 01

这是固定链接的实际 ET_REL 生产载荷源，不是 SO、Windows/SDK/ptrace loader 或仅观察端口。只在主机编译/静态读取，未生成/安装 User/FWR/FWP，未执行目标。默认请求模式 OFF；机内五档可用性尚未验收。

`build_objects.py` 交给 append 后端九件实际 `.o` 和 `OBJECTS_AND_BINDINGS.json`。保持全部异常/CFI/EH/LSDA；不使用 GC 丢弃 unwind。只有编译器 `_ZSt9terminatev` 需要新增正确的动态符号/版本/GLOB_DAT，原库唯一默认 export 为 GLIBCXX_3.4，来源在 `TERMINATE_ORIGINAL_EXPORT.json`。不能伪装成另一个异常函数或 abort。`bcmp` 是自有完整等价零/非零比较体，无新的库依赖。无 outline-atomic helper、own TLS、动态 loader、SDK、设备或网络入口。

## 后端固定接线

- 原340个 INIT_ARRAY 函数保持原顺序，最后追加 `iq4_f1_firmware_initialize_01`；原 DT_INIT 保留。initializer 打开只读自进程 memory，验证五个原代码区间、对应原 User inode 的非写 RX 映射及完整原 libpthread/实际映射字节，再构造仅自有 BSS 对象。
- 原 `BL 4eef2c→5175b8` 改到 `iq4_f1_lv_ctor_wrapper_01`。汇编保留 x0..7、hidden x8 和实际原 caller SP 的第九个8 B参数，原 constructor恰一次。完整原函数 `5175b8..519f00` 只有 `5178c8` 从 `oldSP+0` 读取栈参数；prologue/epilogue只一次 `SP±0x290`。原正常返回后才发布原 x0 的 LV、原 x2 manager、保存的真实 caller LR，后者须 `4eef30`。保持原整数/FP返回寄存器、FPCR/FPSR和完整CFI；异常不发行来源收据。
- 只有原 `BL 6be8a8→40a730` 改到 `iq4_f1_firmware_unlock_01`。该 body 先调用原 PLT恰一次、保 rc/errno，之后仅实际 LR `6be8ac`且rc0采样真实 FP/TLS/mutex。其它原厂 unlock 调用均保持原路径。初始化失败仍返回原厂 rc/errno，不把进程挂起。
- SDK reference 的独立 `iq4_f1_lv_draw_wrapper_12` 替换原 `BL 51ddcc→477038`，消费此 `state.h` getter；这里不替它发行 Surface lease/clean receipt。

## 实际 UI 创建和五项选择

新 `module.cpp` 与 `entry_binding_10.cpp` 从冻结源窄派生，原件未动。保留原有限64次观察 cap，之后已绑定的真实持久 TLS/listener 端口继续工作；Hold/DetachedRetained 的已捕获端口仍拒绝。

在实际已证 UI dispatch stack 上，ctor来源须与当前 queue→manager→LV链一致；双次原 native list/layout 检查仍保留。放置位置由真实 LV bounds 与最多512个 sibling visible rectangles确定，只在一个实际空闲128×128槽建按钮，不覆盖已有可见控件。若全屏 visible rectangle/布局不留空槽，failure11维持原界面，不能承诺按钮已经存在或用人工 x/y 绕过。

创建前读取原全局递归 registry mutex 的 kind1/active-threads字段，实际 try-lock `0xf553c0` 成功后才建立原 TextButton、独立 popup、5 event items 与6 subscriptions；内部的原 subscribe/inspect可在同一递归 mutex下工作，之后释放原锁。所有 admission字段由真实代码/映射/持锁状态、自有静态寿命和原厂正常路径计算；没有 Root人工 provider/lease/restore flags、FD198、env marker或候选整件等于stock9b的循环要求。部分 native mutation失败进入Hold并保留所有对象直到正常User退出，不重新构造或重试。

五项真实 queue callback依次映射 OFF/XPan65:24/16:9/3:2/1:1到 mode0..4。恢复自己的 popup/menu后回到 Ready，调用实际 mode setter；setter再次核持久UI owner/TLS，更新请求并调用原 `invalidate(lv,false)`。此 Ready表示菜单状态，绝不表示像素恢复。native invalidate异常回滚 mode且不增加 generation；显示wrapper仍独立判断真实 surface/几何/写分支。

## 64 B共享 C状态

`state.h` SHA `5219328b04dd33c4e455830d196eb9fd0e55964a284bf22591e0aa752285188a`。schema1/bytes64，queue offset32、manager40、lv48、generation56。`iq4_f1_mode_get_01()`只返回已建立UI请求0..4；未初始化/未bound/Hold/Detached返回0。`iq4_f1_firmware_disable_on_ui_01()`是实际UI owner上的OFF请求与原全LV重绘请求；不卸载对象、不声称画面立即清除。

startup3仅代表初始化/原代码绑定通过；ui_phase与actual native callback决定是否有菜单。请求、Ready、版本号、构建成功与mode0都不是Surface租期、完整源、新传感器帧或已清旧罩的证明。

原代码五个hash区间仅排除：header/PHDR元数据、三条精确 BL，以及 `.imageHeader` appversion file `0x9da880` 的四个字节。其它 imageHeader和全部原代码/table仍比原stock9b真实字节；新PHDR表在旧RXextent之后零padding内由后端精确记录。候选整件哈希由外部最终manifest绑定，不嵌入候选自身。

新 owned host state测试一组七例：五mode真实API提交、非法mode、错误owner、原 invalidate throw回滚、captured Hold隐藏/拒setter、OFF请求、未bound拒绝。另一个新派生 Module/Binding 单组实际编译回归保留 cap→Module port0，同时 captured persistent Binding端口仍有效，Hold/Detached及wrongTLS都拒绝。只执行自有fake ports，不执行原厂函数；原SDK/UI/几何大套件未重复。完整实际 nine-object relocs/disasm 和原 constructor窗口保存用于后端核实，功能仍需机内验收。
