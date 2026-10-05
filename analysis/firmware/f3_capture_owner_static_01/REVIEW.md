# F3 原厂资源引用与拍摄源边界

限定静态证据，原User 11,874,544B / SHA `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`。`EXACT.json`保存14个实际反汇编窗口、5个原字符串及对应偏移/前字节/hash。没有调用原函数、打开相机、加载SDK或部署。

原node资源字段在断言字符串中分别命名：+88=`mTestBuffer`，+90=`mFrameBuffer`，+a0=`mPreviewBuffer`。这些名字不能单独证明或否定完整RAW；原ICE JPEG worker在7b7810调用8c25c0取得+88 pool，7b781c调用495094取得payload；7b7834调用8c2750取得+90 pool，再由7b784c→4950ac取得meta，随后7b78f8→7baadc以payload/meta构造tags。需进一步闭合payload生产者、有效extent、完整row offsets、capture身份与owned tags map，不能把任一非零指针或字段名变成`complete_payload_verified=1`。

原Main指针位于41fc268。8c25c0从Main+2d8 pool调用6f07cc(pool, node+88)，保存返回值并设置resource+10=node。8c2750从Main+2e0 pool调用8c36c0(pool, node+90)，同样保存返回值并设置resource+10=node。两pool acquire入口既能从空闲列表取得新resource，也能对传入的existing resource在原锁内增加+18计数。应在既有源尚被真正持有时借用这种原厂引用接口；不能在退休后的可复用node上补引用。

6f0988与8c387c是decrement接口。8c27e0调用8c387c，但该wrapper不清node+90。8c2850调用8c3990后清node+90；8c3990在count>1时仅decrement，<=1时将count置0，调用resource VT+10并移到pool+30列表。因此把8c387c当retain或把调用次数当生命周期证据都会错误。原acquire/释放还有EH和锁路径；任意异常后必须由实际checked shim判定状态，不能由C函数指针cast吞掉未知结果。

RawManager旧退休链8dc1a4→8c5990包含IFM4966f4(index)→8c27e0(node)→检查+a0→8c2958→8c709c(NodeManager+248,node+78)。持有某个子resource不自动持有整个node，也不防止node字段被下一拍复用。新事务应取得实际源lease、独立capture snapshot和metadata对象，再允许原node退休。

8c5a18等待+88计数降到1的现有路径循环最多1000次，每次710a38(10)；超时会记录后继续。它不是无期限所有权保证，也不是新的F3 worker join证明。不能把增加+88引用后继续原等待路线作为可靠的JPEG-only保全方案。

当前仅提交可供真实binder复用的精确原厂输入。完整源构建、checked retain/release、producer/worker join及独立事务仍未绑定；没有新增机内RAW/JPEG保存模式或完整RAW渲染成功声明。
