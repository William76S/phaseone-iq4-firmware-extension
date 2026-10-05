# 诊断素材

本目录为原创测试素材，不含相机固件和用户照片。

identity_17、33、65.cube应保持约定域中的RGB值；invert_17.cube输出1减输入；swap_rg_17.cube互换红绿。domain_17.cube把0.1到0.9的输入域映射到0到1，用于检查DOMAIN解析。invalid_truncated.cube与invalid_nan.cube必须被拒绝。

test_chart_srgb.png含通道与灰阶渐变、色块，不能代替相机实拍的肤色和高频细节样本。geometry_4x3.png提供居中和边界参考。dynamic_pattern.html可离线打开作动态观测，显示浏览器实际动画节奏；显示器刷新和浏览器计时并不证明相机帧率，真60fps仍需源计数/时间戳及动态证据。

这些文件用于接手实现的诊断与验收，不代表IQ4功能已经完成。
