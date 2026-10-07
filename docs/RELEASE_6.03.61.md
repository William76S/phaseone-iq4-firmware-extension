# IQ4 6.03.61

P1Linux **6.03.61** / IQ **6.03.58** / System **8.02.40**。固件构建日期2026-10-07；GitHub发布2026-10-08。

## 改动

- JPEG仅保留原厂4K，质量100；撤除50%渲染与专用等待，取消Sensor+试验。RAW仍由用户选择原厂格式。
- 保留XQD的JPEG Only / IIQ Only / IIQ+JPEG，以及现有SD策略联动、Ratio Mask和Dual Exposure；录像仍移除。
- 机内删除IIQ+JPEG照片时，在原厂本次删除范围内处理同卡、同目录、同名JPG，再删除RAW。JPG缺失不阻止删RAW；JPG删除被拒绝时不继续主动删除该RAW。
- JPEG Only按图库记录的真实主卡和路径删除；不因另一张卡有同名文件而额外删除，Archive保留原厂备份语义。

## 下载和校验

`IQ4_6.03.61.fwp`，13,177,819字节。

```text
b13655cba725d07d4a4b4b605ebd4a6ec98b058dfa4e813122b19760d5c29243  IQ4_6.03.61.fwp
```

包内User SHA256：`61182e9eced80a5e1b7b1d1eb3d0b2b508873dd0d11fb7970009d755ad7fcb67`。

**6.03.61尚未完成实机验收。** 原厂4K XQD成功反馈来自53；61的静态、主机文件与局部原指令验证不能替代本版机内验收。XQD开机Ready慢仍未解决。

## 使用与恢复范围

适用输入基线为本项目绑定的IQ4 6.03.18包 / User 6.03.21；不保证其他型号或其他基线兼容。使用此前已验证可进入的原厂卡升级流程，安装前保留照片、原安装包及XFSystem.set。更新后核对P1Linux 6.03.61。Storage Setup → XQD Storage选择IIQ+JPEG，JPEG Size为4K；IIQ Only停用新增JPEG输出。

先用可丢弃测试照片验证同目录IIQ+JPG保存、机内配对删除、其他照片保留和正常关机，再分别核对JPEG Only/双卡。

原厂删除不是跨文件事务：图库先移除，后续删除失败不能保证热图库回滚。普通可启动状态可沿原升级入口使用保留版本；降级及失败User独立恢复尚未验证，不能承诺失败可救回。

## 源码构建

GitHub自动提供的Source code包是源码快照，**不能从干净克隆直接重建完整FWP**；历史对象和生成依赖尚未闭合。详见[BUILD.md](../BUILD.md)与[构建缺项](BUILD_GAPS_6.03.61.md)。

This software is based in part on the work of the Independent JPEG Group. 第三方许可见`src/codec/vendor/libjpeg-turbo-1.5.3/LICENSE.md`和`README.ijg`。
