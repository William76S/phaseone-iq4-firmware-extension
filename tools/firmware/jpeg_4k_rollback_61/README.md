# 6.03.61：原厂4K JPEG回退

用户取消50%与Sensor+试验，仅保留4K；继续XQD JPEG及现有存储格式、SD策略、Ratio Mask和Dual EXP。本目录是60的局部撤回，不把整机逻辑回退到53。

- `runtime.cpp`：删除Half事务、专用等待、末级替换、编解码绑定和旧Half配置加载；所有新JPEG请求固定原厂4K。原厂4K处理、Quality100编码、checked XQD/SD发布和精确失败收尾保留。
- `menu.c`、`size.h`：JPEG Size只提供4K，仍显示Quality100与状态；保留原有XQD Storage附加入口。
- `prepare.py`：原件SHA及旧INPUTS固定，移除7个Half专用对象，恢复6处原指令与2个无用alias。完整原厂RAW链未替换。
- 同一照片的XQD JPEG配对删除审查／补丁独立放在`../jpeg_pair_delete_61/`，仅用户原厂删除路径，不能混入JPEG Only自动RAW退休。

旧源码、配置和安装物是历史证据，不代表仍链接在61；旧Half配置不再读写。升级后无需改变原厂RAW格式，无需选择Sensor+。初次有效4K XQD输出的实机依据来自53用户报告；61自身仍须单独验收。

复现命令和精确安装物hash见`deploy/iq4_6.03.61/README.md`。编译／原字节／主机验证不等于相机验收。本轮不连接或刷写相机。
