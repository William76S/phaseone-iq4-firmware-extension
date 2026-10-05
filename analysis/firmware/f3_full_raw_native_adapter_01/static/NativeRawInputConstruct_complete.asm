  7bbac0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7bbac4: 910003fd     	mov	x29, sp
  7bbac8: f9000fe0     	str	x0, [sp, #0x18]
  7bbacc: f9400fe0     	ldr	x0, [sp, #0x18]
  7bbad0: b900001f     	str	wzr, [x0]
  7bbad4: f9400fe0     	ldr	x0, [sp, #0x18]
  7bbad8: 91002000     	add	x0, x0, #0x8
  7bbadc: 94000209     	bl	0x7bc300
  7bbae0: f9400fe0     	ldr	x0, [sp, #0x18]
  7bbae4: f900101f     	str	xzr, [x0, #0x20]
  7bbae8: f9400fe0     	ldr	x0, [sp, #0x18]
  7bbaec: b900281f     	str	wzr, [x0, #0x28]
  7bbaf0: d503201f     	nop
  7bbaf4: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7bbaf8: d65f03c0     	ret
