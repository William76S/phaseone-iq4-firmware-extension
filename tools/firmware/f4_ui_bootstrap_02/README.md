# F4 UI bootstrap02 — 未部署的有限原线程计数器

默认关闭；仅用于固定 IQ4 User 的可恢复一次 RAM preload准备。源码不是相机安装器，也不含可传入假 owner 的 ready API。完整边界及原指令见 `analysis/sdk_reference/F4_UI_BOOTSTRAP_02.md`。

主机验证/仅交叉构建：

```sh
python3 tools/firmware/f4_ui_bootstrap_02/build_validate.py
python3 tools/sdk/collect_f4_ui_bootstrap_02.py
```

不会执行 SDK、原厂目标代码或目标 `.so`。normal及ASan/UBSan34项、production guard2项区分合成主机与尚未完成的目标 ABI/实机验收。构建复用不变的 Counter01源码；target只 export真实 public pthread_mutex_unlock，一个 dormant prepare constructor，无新 C++runtime。

有限流程是实际 self TLS+exact original stack+双读owner链发现原 UiIQ4Configurator → Native control-event/observer排队 → 原UI回调 attach Counter01 → 第二原UI回调detach/撤销controlobserver → 实际后续原dispatch证明 observer quiescence。只计合并通知，不能当源FPS/录像/自有页面完成。

原 OsEvent destructor未移除两个全局registry节点，所以 native事件、名称和SO保留到正常stock进程退出。没有dlclose、原地址free或私有注销猜测。unknown/native exception/no callback/no later boundary都保留，不重试/强制收尾。

固定libpthreadprovider不能解析时不伪造rc/errno/重复unlock；进程Hold。任何装载前必须验证实际原件/映射/read权限/恢复路线；默认关闭不是跨版本兼容承诺。此增量不消费loader02的FD198 marker，不自动改变其角色/白名单；ready/detached实际观测及独立supervision还需另行集成。

目前normal User-only退出入口未证，RAM arm仍不可启用。RequestGracefulReboot清RAM，不能用它触发armedpreload；旧Quit/Restart/debug/signal分支未验收。本包绝无部署、相机控制、编码、持久写或解锁指令。
