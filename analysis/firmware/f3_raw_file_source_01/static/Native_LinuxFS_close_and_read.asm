  826ca8: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  826cac: 910003fd     	mov	x29, sp
  826cb0: f9000fe0     	str	x0, [sp, #0x18]
  826cb4: f9000be1     	str	x1, [sp, #0x10]
  826cb8: 52800020     	mov	w0, #0x1                // =1
  826cbc: 3900bfe0     	strb	w0, [sp, #0x2f]
  826cc0: f9400be0     	ldr	x0, [sp, #0x10]
  826cc4: f9400000     	ldr	x0, [x0]
  826cc8: 91010000     	add	x0, x0, #0x40
  826ccc: f9400001     	ldr	x1, [x0]
  826cd0: f9400be0     	ldr	x0, [sp, #0x10]
  826cd4: d63f0020     	blr	x1
  826cd8: 12001c00     	and	w0, w0, #0xff
  826cdc: 7100001f     	cmp	w0, #0x0
  826ce0: 54000140     	b.eq	0x826d08
  826ce4: f9400fe0     	ldr	x0, [sp, #0x18]
  826ce8: f9400000     	ldr	x0, [x0]
  826cec: 9104a000     	add	x0, x0, #0x128
  826cf0: f9400002     	ldr	x2, [x0]
  826cf4: f9400be1     	ldr	x1, [sp, #0x10]
  826cf8: f9400fe0     	ldr	x0, [sp, #0x18]
  826cfc: d63f0040     	blr	x2
  826d00: 12001c00     	and	w0, w0, #0xff
  826d04: 3900bfe0     	strb	w0, [sp, #0x2f]
  826d08: f9400be0     	ldr	x0, [sp, #0x10]
  826d0c: 97f11114     	bl	0x46b15c
  826d10: 97ef8f60     	bl	0x40aa90
  826d14: 7100001f     	cmp	w0, #0x0
  826d18: 540000cb     	b.lt	0x826d30
  826d1c: 3940bfe0     	ldrb	w0, [sp, #0x2f]
  826d20: 7100001f     	cmp	w0, #0x0
  826d24: 54000060     	b.eq	0x826d30
  826d28: 52800020     	mov	w0, #0x1                // =1
  826d2c: 14000002     	b	0x826d34
  826d30: 52800000     	mov	w0, #0x0                // =0
  826d34: 7100001f     	cmp	w0, #0x0
  826d38: 54000060     	b.eq	0x826d44
  826d3c: 52800020     	mov	w0, #0x1                // =1
  826d40: 14000009     	b	0x826d64
  826d44: d0002b40     	adrp	x0, 0xd90000
  826d48: 91378003     	add	x3, x0, #0xde0
  826d4c: 52803ea2     	mov	w2, #0x1f5              // =501
  826d50: d0002b40     	adrp	x0, 0xd90000
  826d54: 911ee001     	add	x1, x0, #0x7b8
  826d58: 52800080     	mov	w0, #0x4                // =4
  826d5c: 97fc7dfc     	bl	0x74654c
  826d60: 52800000     	mov	w0, #0x0                // =0
  826d64: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  826d68: d65f03c0     	ret
  826d6c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  826d70: 910003fd     	mov	x29, sp
  826d74: f90017e0     	str	x0, [sp, #0x28]
  826d78: f90013e1     	str	x1, [sp, #0x20]
  826d7c: b9001fe2     	str	w2, [sp, #0x1c]
  826d80: f9000be3     	str	x3, [sp, #0x10]
  826d84: f9400be0     	ldr	x0, [sp, #0x10]
  826d88: f9400000     	ldr	x0, [x0]
  826d8c: 9100e000     	add	x0, x0, #0x38
  826d90: f9400001     	ldr	x1, [x0]
  826d94: f9400be0     	ldr	x0, [sp, #0x10]
  826d98: d63f0020     	blr	x1
  826d9c: 12001c00     	and	w0, w0, #0xff
  826da0: 7100001f     	cmp	w0, #0x0
  826da4: 540002a0     	b.eq	0x826df8
  826da8: f9400be0     	ldr	x0, [sp, #0x10]
  826dac: 97f110ec     	bl	0x46b15c
  826db0: 2a0003e3     	mov	w3, w0
  826db4: b9401fe0     	ldr	w0, [sp, #0x1c]
  826db8: aa0003e2     	mov	x2, x0
  826dbc: f94013e1     	ldr	x1, [sp, #0x20]
  826dc0: 2a0303e0     	mov	w0, w3
  826dc4: 97ef8de7     	bl	0x40a560
  826dc8: b9003fe0     	str	w0, [sp, #0x3c]
  826dcc: b9403fe0     	ldr	w0, [sp, #0x3c]
  826dd0: 7100001f     	cmp	w0, #0x0
  826dd4: 5400006b     	b.lt	0x826de0
  826dd8: b9403fe0     	ldr	w0, [sp, #0x3c]
  826ddc: 14000008     	b	0x826dfc
  826de0: 97ef8dc0     	bl	0x40a4e0
  826de4: b9400000     	ldr	w0, [x0]
  826de8: 2a0003e1     	mov	w1, w0
  826dec: d0002b40     	adrp	x0, 0xd90000
  826df0: 91388000     	add	x0, x0, #0xe20
  826df4: 97ef8de3     	bl	0x40a580
  826df8: 52800000     	mov	w0, #0x0                // =0
  826dfc: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  826e00: d65f03c0     	ret
