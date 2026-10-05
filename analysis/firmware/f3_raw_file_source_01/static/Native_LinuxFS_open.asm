  825ed4: a9ac7bfd     	stp	x29, x30, [sp, #-0x140]!
  825ed8: 910003fd     	mov	x29, sp
  825edc: f90017e0     	str	x0, [sp, #0x28]
  825ee0: f90013e1     	str	x1, [sp, #0x20]
  825ee4: f9000fe2     	str	x2, [sp, #0x18]
  825ee8: 39005fe3     	strb	w3, [sp, #0x17]
  825eec: 39005be4     	strb	w4, [sp, #0x16]
  825ef0: 390057e5     	strb	w5, [sp, #0x15]
  825ef4: 9100c3e0     	add	x0, sp, #0x30
  825ef8: aa0003e2     	mov	x2, x0
  825efc: f9400fe1     	ldr	x1, [sp, #0x18]
  825f00: f94017e0     	ldr	x0, [sp, #0x28]
  825f04: 94000511     	bl	0x827348
  825f08: 12001c00     	and	w0, w0, #0xff
  825f0c: 52000000     	eor	w0, w0, #0x1
  825f10: 12001c00     	and	w0, w0, #0xff
  825f14: 7100001f     	cmp	w0, #0x0
  825f18: 54000160     	b.eq	0x825f44
  825f1c: f9400fe4     	ldr	x4, [sp, #0x18]
  825f20: f0002b40     	adrp	x0, 0xd90000
  825f24: 9124c003     	add	x3, x0, #0x930
  825f28: 52800ea2     	mov	w2, #0x75               // =117
  825f2c: f0002b40     	adrp	x0, 0xd90000
  825f30: 911ee001     	add	x1, x0, #0x7b8
  825f34: 52800040     	mov	w0, #0x2                // =2
  825f38: 97fc8185     	bl	0x74654c
  825f3c: 52800000     	mov	w0, #0x0                // =0
  825f40: 14000032     	b	0x826008
  825f44: 52a00100     	mov	w0, #0x80000            // =524288
  825f48: b9013be0     	str	w0, [sp, #0x138]
  825f4c: 52a00100     	mov	w0, #0x80000            // =524288
  825f50: b9013fe0     	str	w0, [sp, #0x13c]
  825f54: 39405fe0     	ldrb	w0, [sp, #0x17]
  825f58: 7100001f     	cmp	w0, #0x0
  825f5c: 54000160     	b.eq	0x825f88
  825f60: 52804820     	mov	w0, #0x241              // =577
  825f64: 72a00100     	movk	w0, #0x8, lsl #16
  825f68: b9013fe0     	str	w0, [sp, #0x13c]
  825f6c: 394057e0     	ldrb	w0, [sp, #0x15]
  825f70: 7100001f     	cmp	w0, #0x0
  825f74: 54000260     	b.eq	0x825fc0
  825f78: b9413fe0     	ldr	w0, [sp, #0x13c]
  825f7c: 32100000     	orr	w0, w0, #0x10000
  825f80: b9013fe0     	str	w0, [sp, #0x13c]
  825f84: 1400000f     	b	0x825fc0
  825f88: 52a00100     	mov	w0, #0x80000            // =524288
  825f8c: b9013fe0     	str	w0, [sp, #0x13c]
  825f90: 39405be0     	ldrb	w0, [sp, #0x16]
  825f94: 7100001f     	cmp	w0, #0x0
  825f98: 54000140     	b.eq	0x825fc0
  825f9c: 52800040     	mov	w0, #0x2                // =2
  825fa0: 72a00100     	movk	w0, #0x8, lsl #16
  825fa4: b9013fe0     	str	w0, [sp, #0x13c]
  825fa8: 394057e0     	ldrb	w0, [sp, #0x15]
  825fac: 7100001f     	cmp	w0, #0x0
  825fb0: 54000080     	b.eq	0x825fc0
  825fb4: b9413fe0     	ldr	w0, [sp, #0x13c]
  825fb8: 32100000     	orr	w0, w0, #0x10000
  825fbc: b9013fe0     	str	w0, [sp, #0x13c]
  825fc0: 9100c3e0     	add	x0, sp, #0x30
  825fc4: 52803002     	mov	w2, #0x180              // =384
  825fc8: b9413fe1     	ldr	w1, [sp, #0x13c]
  825fcc: 97ef9141     	bl	0x40a4d0
  825fd0: b90137e0     	str	w0, [sp, #0x134]
  825fd4: b94137e0     	ldr	w0, [sp, #0x134]
  825fd8: 7100001f     	cmp	w0, #0x0
  825fdc: 540000eb     	b.lt	0x825ff8
  825fe0: f94017e0     	ldr	x0, [sp, #0x28]
  825fe4: b94137e1     	ldr	w1, [sp, #0x134]
  825fe8: 52800023     	mov	w3, #0x1                // =1
  825fec: 2a0103e2     	mov	w2, w1
  825ff0: f94013e1     	ldr	x1, [sp, #0x20]
  825ff4: 97fffdcc     	bl	0x825724
  825ff8: b94137e0     	ldr	w0, [sp, #0x134]
  825ffc: 2a2003e0     	mvn	w0, w0
  826000: 531f7c00     	lsr	w0, w0, #31
  826004: 12001c00     	and	w0, w0, #0xff
  826008: a8d47bfd     	ldp	x29, x30, [sp], #0x140
  82600c: d65f03c0     	ret
