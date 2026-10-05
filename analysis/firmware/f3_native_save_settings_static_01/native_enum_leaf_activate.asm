  4e6dc0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4e6dc4: 910003fd     	mov	x29, sp
  4e6dc8: f9000fe0     	str	x0, [sp, #0x18]
  4e6dcc: f9400fe0     	ldr	x0, [sp, #0x18]
  4e6dd0: f9400c03     	ldr	x3, [x0, #0x18]
  4e6dd4: f9400fe0     	ldr	x0, [sp, #0x18]
  4e6dd8: f9400c00     	ldr	x0, [x0, #0x18]
  4e6ddc: f9400000     	ldr	x0, [x0]
  4e6de0: 91028000     	add	x0, x0, #0xa0
  4e6de4: f9400002     	ldr	x2, [x0]
  4e6de8: f9400fe0     	ldr	x0, [sp, #0x18]
  4e6dec: b9402000     	ldr	w0, [x0, #0x20]
  4e6df0: 2a0003e1     	mov	w1, w0
  4e6df4: aa0303e0     	mov	x0, x3
  4e6df8: d63f0040     	blr	x2
  4e6dfc: 52800020     	mov	w0, #0x1                // =1
  4e6e00: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4e6e04: d65f03c0     	ret
