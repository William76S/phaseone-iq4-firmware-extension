  7b982c: d10143ff     	sub	sp, sp, #0x50
  7b9830: f90017e0     	str	x0, [sp, #0x28]
  7b9834: f90013e1     	str	x1, [sp, #0x20]
  7b9838: f9000fe2     	str	x2, [sp, #0x18]
  7b983c: b90017e3     	str	w3, [sp, #0x14]
  7b9840: b90013e4     	str	w4, [sp, #0x10]
  7b9844: b9000fe5     	str	w5, [sp, #0xc]
  7b9848: f9400fe0     	ldr	x0, [sp, #0x18]
  7b984c: f90027e0     	str	x0, [sp, #0x48]
  7b9850: f94013e0     	ldr	x0, [sp, #0x20]
  7b9854: f90023e0     	str	x0, [sp, #0x40]
  7b9858: b9003fff     	str	wzr, [sp, #0x3c]
  7b985c: b9403fe1     	ldr	w1, [sp, #0x3c]
  7b9860: b94013e0     	ldr	w0, [sp, #0x10]
  7b9864: 6b00003f     	cmp	w1, w0
  7b9868: 540006aa     	b.ge	0x7b993c
  7b986c: f94023e0     	ldr	x0, [sp, #0x40]
  7b9870: f9001be0     	str	x0, [sp, #0x30]
  7b9874: b9003bff     	str	wzr, [sp, #0x38]
  7b9878: b9403be1     	ldr	w1, [sp, #0x38]
  7b987c: b94017e0     	ldr	w0, [sp, #0x14]
  7b9880: 6b00003f     	cmp	w1, w0
  7b9884: 540004ca     	b.ge	0x7b991c
  7b9888: f94023e0     	ldr	x0, [sp, #0x40]
  7b988c: 91000400     	add	x0, x0, #0x1
  7b9890: f90023e0     	str	x0, [sp, #0x40]
  7b9894: f94023e0     	ldr	x0, [sp, #0x40]
  7b9898: 91000401     	add	x1, x0, #0x1
  7b989c: f90023e1     	str	x1, [sp, #0x40]
  7b98a0: 39400000     	ldrb	w0, [x0]
  7b98a4: 12001c02     	and	w2, w0, #0xff
  7b98a8: f94027e0     	ldr	x0, [sp, #0x48]
  7b98ac: 91000401     	add	x1, x0, #0x1
  7b98b0: f90027e1     	str	x1, [sp, #0x48]
  7b98b4: 2a0203e1     	mov	w1, w2
  7b98b8: 39000001     	strb	w1, [x0]
  7b98bc: f94023e0     	ldr	x0, [sp, #0x40]
  7b98c0: 91000401     	add	x1, x0, #0x1
  7b98c4: f90023e1     	str	x1, [sp, #0x40]
  7b98c8: 39400000     	ldrb	w0, [x0]
  7b98cc: 12001c02     	and	w2, w0, #0xff
  7b98d0: f94027e0     	ldr	x0, [sp, #0x48]
  7b98d4: 91000401     	add	x1, x0, #0x1
  7b98d8: f90027e1     	str	x1, [sp, #0x48]
  7b98dc: 2a0203e1     	mov	w1, w2
  7b98e0: 39000001     	strb	w1, [x0]
  7b98e4: f94023e0     	ldr	x0, [sp, #0x40]
  7b98e8: 91000401     	add	x1, x0, #0x1
  7b98ec: f90023e1     	str	x1, [sp, #0x40]
  7b98f0: 39400000     	ldrb	w0, [x0]
  7b98f4: 12001c02     	and	w2, w0, #0xff
  7b98f8: f94027e0     	ldr	x0, [sp, #0x48]
  7b98fc: 91000401     	add	x1, x0, #0x1
  7b9900: f90027e1     	str	x1, [sp, #0x48]
  7b9904: 2a0203e1     	mov	w1, w2
  7b9908: 39000001     	strb	w1, [x0]
  7b990c: b9403be0     	ldr	w0, [sp, #0x38]
  7b9910: 11000400     	add	w0, w0, #0x1
  7b9914: b9003be0     	str	w0, [sp, #0x38]
  7b9918: 17ffffd8     	b	0x7b9878
  7b991c: b9800fe0     	ldrsw	x0, [sp, #0xc]
  7b9920: f9401be1     	ldr	x1, [sp, #0x30]
  7b9924: 8b000020     	add	x0, x1, x0
  7b9928: f90023e0     	str	x0, [sp, #0x40]
  7b992c: b9403fe0     	ldr	w0, [sp, #0x3c]
  7b9930: 11000400     	add	w0, w0, #0x1
  7b9934: b9003fe0     	str	w0, [sp, #0x3c]
  7b9938: 17ffffc9     	b	0x7b985c
  7b993c: d503201f     	nop
  7b9940: 910143ff     	add	sp, sp, #0x50
  7b9944: d65f03c0     	ret
