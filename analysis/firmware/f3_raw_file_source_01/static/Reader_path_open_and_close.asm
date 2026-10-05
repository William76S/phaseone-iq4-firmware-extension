  7d9988: a9ab7bfd     	stp	x29, x30, [sp, #-0x150]!
  7d998c: 910003fd     	mov	x29, sp
  7d9990: a90153f3     	stp	x19, x20, [sp, #0x10]
  7d9994: aa0003f3     	mov	x19, x0
  7d9998: f9400c00     	ldr	x0, [x0, #0x18]
  7d999c: b4000800     	cbz	x0, 0x7d9a9c
  7d99a0: 91418a74     	add	x20, x19, #0x62, lsl #12 // =0x62000
  7d99a4: a9025bf5     	stp	x21, x22, [sp, #0x20]
  7d99a8: 91304294     	add	x20, x20, #0xc10
  7d99ac: aa0103f5     	mov	x21, x1
  7d99b0: aa1403e0     	mov	x0, x20
  7d99b4: a90363f7     	stp	x23, x24, [sp, #0x30]
  7d99b8: 12001c78     	and	w24, w3, #0xff
  7d99bc: 12001c97     	and	w23, w4, #0xff
  7d99c0: f90027e2     	str	x2, [sp, #0x48]
  7d99c4: 94012ff9     	bl	0x8259a8
  7d99c8: 72001c1f     	tst	w0, #0xff
  7d99cc: f94027e2     	ldr	x2, [sp, #0x48]
  7d99d0: 540004a1     	b.ne	0x7d9a64
  7d99d4: 910143f6     	add	x22, sp, #0x50
  7d99d8: b4000555     	cbz	x21, 0x7d9a80
  7d99dc: aa0203e4     	mov	x4, x2
  7d99e0: aa1503e3     	mov	x3, x21
  7d99e4: 90002d62     	adrp	x2, 0xd85000
  7d99e8: aa1603e0     	mov	x0, x22
  7d99ec: d2802001     	mov	x1, #0x100              // =256
  7d99f0: 911fc042     	add	x2, x2, #0x7f0
  7d99f4: 97f0c14f     	bl	0x409f30
  7d99f8: f9400e60     	ldr	x0, [x19, #0x18]
  7d99fc: aa1603e2     	mov	x2, x22
  7d9a00: 52800005     	mov	w5, #0x0                // =0
  7d9a04: 52800024     	mov	w4, #0x1                // =1
  7d9a08: f9400001     	ldr	x1, [x0]
  7d9a0c: f9401426     	ldr	x6, [x1, #0x28]
  7d9a10: 35000057     	cbnz	w23, 0x7d9a18
  7d9a14: 52800004     	mov	w4, #0x0                // =0
  7d9a18: 52800003     	mov	w3, #0x0                // =0
  7d9a1c: aa1403e1     	mov	x1, x20
  7d9a20: d63f00c0     	blr	x6
  7d9a24: 72001c1f     	tst	w0, #0xff
  7d9a28: 540001e0     	b.eq	0x7d9a64
  7d9a2c: 9140e260     	add	x0, x19, #0x38, lsl #12 // =0x38000
  7d9a30: 2a1803e3     	mov	w3, w24
  7d9a34: 91028000     	add	x0, x0, #0xa0
  7d9a38: 52800022     	mov	w2, #0x1                // =1
  7d9a3c: aa1403e1     	mov	x1, x20
  7d9a40: 97ffb5bb     	bl	0x7c712c
  7d9a44: 72001c13     	ands	w19, w0, #0xff
  7d9a48: 54000420     	b.eq	0x7d9acc
  7d9a4c: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  7d9a50: a94363f7     	ldp	x23, x24, [sp, #0x30]
  7d9a54: 2a1303e0     	mov	w0, w19
  7d9a58: a94153f3     	ldp	x19, x20, [sp, #0x10]
  7d9a5c: a8d57bfd     	ldp	x29, x30, [sp], #0x150
  7d9a60: d65f03c0     	ret
  7d9a64: 52800013     	mov	w19, #0x0               // =0
  7d9a68: 2a1303e0     	mov	w0, w19
  7d9a6c: a94153f3     	ldp	x19, x20, [sp, #0x10]
  7d9a70: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  7d9a74: a94363f7     	ldp	x23, x24, [sp, #0x30]
  7d9a78: a8d57bfd     	ldp	x29, x30, [sp], #0x150
  7d9a7c: d65f03c0     	ret
  7d9a80: aa0203e3     	mov	x3, x2
  7d9a84: aa1603e0     	mov	x0, x22
  7d9a88: 90002fc2     	adrp	x2, 0xdd1000
  7d9a8c: d2802001     	mov	x1, #0x100              // =256
  7d9a90: 911c6042     	add	x2, x2, #0x718
  7d9a94: 97f0c127     	bl	0x409f30
  7d9a98: 17ffffd8     	b	0x7d99f8
  7d9a9c: 528005a2     	mov	w2, #0x2d               // =45
  7d9aa0: 52800040     	mov	w0, #0x2                // =2
  7d9aa4: 52800013     	mov	w19, #0x0               // =0
  7d9aa8: b0002d63     	adrp	x3, 0xd86000
  7d9aac: b0002d61     	adrp	x1, 0xd86000
  7d9ab0: 911fc063     	add	x3, x3, #0x7f0
  7d9ab4: 911e4021     	add	x1, x1, #0x790
  7d9ab8: 97fdb2a5     	bl	0x74654c
  7d9abc: 2a1303e0     	mov	w0, w19
  7d9ac0: a94153f3     	ldp	x19, x20, [sp, #0x10]
  7d9ac4: a8d57bfd     	ldp	x29, x30, [sp], #0x150
  7d9ac8: d65f03c0     	ret
  7d9acc: aa1403e0     	mov	x0, x20
  7d9ad0: 94012f4f     	bl	0x82580c
  7d9ad4: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  7d9ad8: a94363f7     	ldp	x23, x24, [sp, #0x30]
  7d9adc: 17ffffde     	b	0x7d9a54
  7d9ae0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7d9ae4: 910003fd     	mov	x29, sp
  7d9ae8: f9000bf3     	str	x19, [sp, #0x10]
  7d9aec: aa0003f3     	mov	x19, x0
  7d9af0: 9140e000     	add	x0, x0, #0x38, lsl #12  // =0x38000
  7d9af4: 91028000     	add	x0, x0, #0xa0
  7d9af8: 97ffb5b5     	bl	0x7c71cc
  7d9afc: 91418a60     	add	x0, x19, #0x62, lsl #12 // =0x62000
  7d9b00: f9400bf3     	ldr	x19, [sp, #0x10]
  7d9b04: 91304000     	add	x0, x0, #0xc10
  7d9b08: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7d9b0c: 14012f40     	b	0x82580c
