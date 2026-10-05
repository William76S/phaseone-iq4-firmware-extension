# F1 menu04 / display16 有限独立复核

仅核当前候选 e5938d916a3e33dbe62110b8ce9ef5ffd5717baebc64b824a49fd7a4bb188efd 的离线源码与原件字节，不执行固件、SDK、设备或重复已有 host 测试。

- 原 Grid SetMenu `4ee780` 的 `f9320094` 完全保留；新增菜单仅改 `4eea58`（`43320094` → `1c4df594`），显示仅改 `51ddcc`（`9b64fd97` → `7f94f494`）。完整允许改动仍包含 ELF 元数据、CSU 四指令和版本，不能把“两 BL”说成整文件只有两处改动。
- 新 SubMenu 与 EventItem 复制原 vtable 的负头和完整既有槽，SubMenu copy index16 为 `4e6004`、EventItem index16 为 `4ea2fc`，均未替换；只有标题、值和叶 activate 槽被替换。Opacity 对象仍原 `4e5744` 构造的 SubMenu，并保留原 RTTI/type 槽。
- 原 Navigator `4e7d7c` 读 item `VT+40` 的子对象，`4e7dd0` 用原 SubMenu RTTI dynamic_cast，随后 `4e7dfc -> 4e73b4` 进入子菜单；叶 action 在 `4e7e04..4e7e18` 调 `VT+50`，返回 bool 后走原通知/返回逻辑。这支持 nested Opacity 21 叶沿原 native Navigator，不证明实际显示或手势已验收。
- 八比例 indices 0..7 与显示 mode getter 同一静态 state；诊断 indices 8..16 共九项；透明度 0..100、步长5共21叶。诊断 activate 不改 mode，透明度 activate 只改自身值。格式化接口维持原 count/NUL 边界。
- 明确 heap null 行为：`building[k]=1` 后任何 native_new 返回 null 均直接 return，不清 building，不 append 新 root；已构造部分可能泄漏，之后同次开机不重试。这是 fail-closed，不是恢复成功。原 throwing new 的异常沿真实 EH 传播，不能据 null 路径声称会捕获 OOM。冷启动重新构造属于后续实际恢复事项。

当前有限审查未发现正常路径的确定失效。未扩展到全部原厂菜单实现或实际透明度验收。精确 source / candidate / link-report SHA 与三处字节列在 REVIEW.json。
