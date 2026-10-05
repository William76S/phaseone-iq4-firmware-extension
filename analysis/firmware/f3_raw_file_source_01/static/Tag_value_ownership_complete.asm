  7bb8e0: d10043ff     	sub	sp, sp, #0x10
  7bb8e4: f90007e0     	str	x0, [sp, #0x8]
  7bb8e8: b90007e1     	str	w1, [sp, #0x4]
  7bb8ec: f94007e0     	ldr	x0, [sp, #0x8]
  7bb8f0: 52800021     	mov	w1, #0x1                // =1
  7bb8f4: b9000001     	str	w1, [x0]
  7bb8f8: f94007e0     	ldr	x0, [sp, #0x8]
  7bb8fc: b94007e1     	ldr	w1, [sp, #0x4]
  7bb900: b9000801     	str	w1, [x0, #0x8]
  7bb904: d503201f     	nop
  7bb908: 910043ff     	add	sp, sp, #0x10
  7bb90c: d65f03c0     	ret
  7bb910: d10043ff     	sub	sp, sp, #0x10
  7bb914: f90007e0     	str	x0, [sp, #0x8]
  7bb918: bd0007e0     	str	s0, [sp, #0x4]
  7bb91c: f94007e0     	ldr	x0, [sp, #0x8]
  7bb920: 52800021     	mov	w1, #0x1                // =1
  7bb924: b9000001     	str	w1, [x0]
  7bb928: f94007e0     	ldr	x0, [sp, #0x8]
  7bb92c: b94007e1     	ldr	w1, [sp, #0x4]
  7bb930: b9000801     	str	w1, [x0, #0x8]
  7bb934: d503201f     	nop
  7bb938: 910043ff     	add	sp, sp, #0x10
  7bb93c: d65f03c0     	ret
  7bb940: d10083ff     	sub	sp, sp, #0x20
  7bb944: f9000fe0     	str	x0, [sp, #0x18]
  7bb948: f9000be1     	str	x1, [sp, #0x10]
  7bb94c: b9000fe2     	str	w2, [sp, #0xc]
  7bb950: f9400fe0     	ldr	x0, [sp, #0x18]
  7bb954: 52800041     	mov	w1, #0x2                // =2
  7bb958: b9000001     	str	w1, [x0]
  7bb95c: f9400fe0     	ldr	x0, [sp, #0x18]
  7bb960: f9400be1     	ldr	x1, [sp, #0x10]
  7bb964: f9000801     	str	x1, [x0, #0x10]
  7bb968: f9400fe0     	ldr	x0, [sp, #0x18]
  7bb96c: b9400fe1     	ldr	w1, [sp, #0xc]
  7bb970: b9000801     	str	w1, [x0, #0x8]
  7bb974: d503201f     	nop
  7bb978: 910083ff     	add	sp, sp, #0x20
  7bb97c: d65f03c0     	ret
