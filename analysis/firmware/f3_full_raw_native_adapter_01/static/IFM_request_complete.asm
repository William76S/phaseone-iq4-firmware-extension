  496ab0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  496ab4: 910003fd     	mov	x29, sp
  496ab8: f9000fe0     	str	x0, [sp, #0x18]
  496abc: b90017e1     	str	w1, [sp, #0x14]
  496ac0: f9400fe1     	ldr	x1, [sp, #0x18]
  496ac4: d2980000     	mov	x0, #0xc000             // =49152
  496ac8: f2a0fe80     	movk	x0, #0x7f4, lsl #16
  496acc: 8b000020     	add	x0, x1, x0
  496ad0: b94c4000     	ldr	w0, [x0, #0xc40]
  496ad4: 7100041f     	cmp	w0, #0x1
  496ad8: 540001c0     	b.eq	0x496b10
  496adc: f9400fe1     	ldr	x1, [sp, #0x18]
  496ae0: d2980000     	mov	x0, #0xc000             // =49152
  496ae4: f2a0fe80     	movk	x0, #0x7f4, lsl #16
  496ae8: 8b000020     	add	x0, x1, x0
  496aec: b94c4000     	ldr	w0, [x0, #0xc40]
  496af0: 2a0003e4     	mov	w4, w0
  496af4: b0003740     	adrp	x0, 0xb7f000
  496af8: 9117e003     	add	x3, x0, #0x5f8
  496afc: 52802f42     	mov	w2, #0x17a              // =378
  496b00: b0003740     	adrp	x0, 0xb7f000
  496b04: 91166001     	add	x1, x0, #0x598
  496b08: 52800040     	mov	w0, #0x2                // =2
  496b0c: 940abe90     	bl	0x74654c
  496b10: f9400fe0     	ldr	x0, [sp, #0x18]
  496b14: f947d405     	ldr	x5, [x0, #0xfa8]
  496b18: f9400fe1     	ldr	x1, [sp, #0x18]
  496b1c: d28dc200     	mov	x0, #0x6e10             // =28176
  496b20: f2a07f40     	movk	x0, #0x3fa, lsl #16
  496b24: 8b000022     	add	x2, x1, x0
  496b28: f9400fe1     	ldr	x1, [sp, #0x18]
  496b2c: d2998500     	mov	x0, #0xcc28             // =52264
  496b30: f2a0fe80     	movk	x0, #0x7f4, lsl #16
  496b34: 8b000020     	add	x0, x1, x0
  496b38: aa0003e4     	mov	x4, x0
  496b3c: 528bc003     	mov	w3, #0x5e00             // =24064
  496b40: 72a07f43     	movk	w3, #0x3fa, lsl #16
  496b44: b94017e1     	ldr	w1, [sp, #0x14]
  496b48: aa0503e0     	mov	x0, x5
  496b4c: 97ffd612     	bl	0x48c394
  496b50: d503201f     	nop
  496b54: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  496b58: d65f03c0     	ret
