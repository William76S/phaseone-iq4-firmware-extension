  7bbc54: a9b87bfd     	stp	x29, x30, [sp, #-0x80]!
  7bbc58: 910003fd     	mov	x29, sp
  7bbc5c: a90153f3     	stp	x19, x20, [sp, #0x10]
  7bbc60: a9025bf5     	stp	x21, x22, [sp, #0x20]
  7bbc64: f9001bf7     	str	x23, [sp, #0x30]
  7bbc68: f90027e0     	str	x0, [sp, #0x48]
  7bbc6c: f94027e0     	ldr	x0, [sp, #0x48]
  7bbc70: 1e2e1000     	fmov	s0, #1.00000000
  7bbc74: bd000000     	str	s0, [x0]
  7bbc78: f94027e0     	ldr	x0, [sp, #0x48]
  7bbc7c: 91001000     	add	x0, x0, #0x4
  7bbc80: 97f34c1c     	bl	0x48ecf0
  7bbc84: f94027e0     	ldr	x0, [sp, #0x48]
  7bbc88: b900201f     	str	wzr, [x0, #0x20]
  7bbc8c: f94027e0     	ldr	x0, [sp, #0x48]
  7bbc90: 12800001     	mov	w1, #-0x1               // =-1
  7bbc94: b9002401     	str	w1, [x0, #0x24]
  7bbc98: f94027e0     	ldr	x0, [sp, #0x48]
  7bbc9c: 12800001     	mov	w1, #-0x1               // =-1
  7bbca0: b9002801     	str	w1, [x0, #0x28]
  7bbca4: f94027e0     	ldr	x0, [sp, #0x48]
  7bbca8: 12800001     	mov	w1, #-0x1               // =-1
  7bbcac: b9002c01     	str	w1, [x0, #0x2c]
  7bbcb0: f94027e0     	ldr	x0, [sp, #0x48]
  7bbcb4: b900301f     	str	wzr, [x0, #0x30]
  7bbcb8: f94027e0     	ldr	x0, [sp, #0x48]
  7bbcbc: 9100d000     	add	x0, x0, #0x34
  7bbcc0: 1e2e1002     	fmov	s2, #1.00000000
  7bbcc4: 1e2e1001     	fmov	s1, #1.00000000
  7bbcc8: 1e2e1000     	fmov	s0, #1.00000000
  7bbccc: 97fffe52     	bl	0x7bb614
  7bbcd0: f94027e0     	ldr	x0, [sp, #0x48]
  7bbcd4: b900401f     	str	wzr, [x0, #0x40]
  7bbcd8: f94027e0     	ldr	x0, [sp, #0x48]
  7bbcdc: 3901101f     	strb	wzr, [x0, #0x44]
  7bbce0: f94027e0     	ldr	x0, [sp, #0x48]
  7bbce4: 91012000     	add	x0, x0, #0x48
  7bbce8: 1e2e1001     	fmov	s1, #1.00000000
  7bbcec: 1e229000     	fmov	s0, #5.00000000
  7bbcf0: 97fffe8d     	bl	0x7bb724
  7bbcf4: f94027e0     	ldr	x0, [sp, #0x48]
  7bbcf8: 1e2e1000     	fmov	s0, #1.00000000
  7bbcfc: bd005000     	str	s0, [x0, #0x50]
  7bbd00: f94027e0     	ldr	x0, [sp, #0x48]
  7bbd04: 91016017     	add	x23, x0, #0x58
  7bbd08: d0002e40     	adrp	x0, 0xd85000
  7bbd0c: 910de013     	add	x19, x0, #0x378
  7bbd10: d2800134     	mov	x20, #0x9               // =9
  7bbd14: 910143e0     	add	x0, sp, #0x50
  7bbd18: 940000e6     	bl	0x7bc0b0
  7bbd1c: 910143e0     	add	x0, sp, #0x50
  7bbd20: aa0003e3     	mov	x3, x0
  7bbd24: aa1303e1     	mov	x1, x19
  7bbd28: aa1403e2     	mov	x2, x20
  7bbd2c: aa1703e0     	mov	x0, x23
  7bbd30: 94000104     	bl	0x7bc140
  7bbd34: 910143e0     	add	x0, sp, #0x50
  7bbd38: 940000e6     	bl	0x7bc0d0
  7bbd3c: f94027e0     	ldr	x0, [sp, #0x48]
  7bbd40: 9101c013     	add	x19, x0, #0x70
  7bbd44: 910163e0     	add	x0, sp, #0x58
  7bbd48: 2f00e401     	movi	d1, #0000000000000000
  7bbd4c: 2f00e400     	movi	d0, #0000000000000000
  7bbd50: 97f346b8     	bl	0x48d830
  7bbd54: 910163e0     	add	x0, sp, #0x58
  7bbd58: 91004000     	add	x0, x0, #0x10
  7bbd5c: 1e6e1001     	fmov	d1, #1.00000000
  7bbd60: 1e6e1000     	fmov	d0, #1.00000000
  7bbd64: 97f346b3     	bl	0x48d830
  7bbd68: 910163e0     	add	x0, sp, #0x58
  7bbd6c: aa0003f5     	mov	x21, x0
  7bbd70: d2800056     	mov	x22, #0x2               // =2
  7bbd74: 9101e3e0     	add	x0, sp, #0x78
  7bbd78: 9400010e     	bl	0x7bc1b0
  7bbd7c: 9101e3e0     	add	x0, sp, #0x78
  7bbd80: aa0003e3     	mov	x3, x0
  7bbd84: aa1503e1     	mov	x1, x21
  7bbd88: aa1603e2     	mov	x2, x22
  7bbd8c: aa1303e0     	mov	x0, x19
  7bbd90: 9400012c     	bl	0x7bc240
  7bbd94: 9101e3e0     	add	x0, sp, #0x78
  7bbd98: 9400010e     	bl	0x7bc1d0
  7bbd9c: f94027e0     	ldr	x0, [sp, #0x48]
  7bbda0: 91022000     	add	x0, x0, #0x88
  7bbda4: 97fffe53     	bl	0x7bb6f0
  7bbda8: f94027e0     	ldr	x0, [sp, #0x48]
  7bbdac: 91026000     	add	x0, x0, #0x98
  7bbdb0: 97fffe50     	bl	0x7bb6f0
  7bbdb4: f94027e0     	ldr	x0, [sp, #0x48]
  7bbdb8: 9102a000     	add	x0, x0, #0xa8
  7bbdbc: 1e2e1000     	fmov	s0, #1.00000000
  7bbdc0: 97fffe2f     	bl	0x7bb67c
  7bbdc4: f94027e0     	ldr	x0, [sp, #0x48]
  7bbdc8: 9102e000     	add	x0, x0, #0xb8
  7bbdcc: 0f000400     	movi	v0.2s, #0x0
  7bbdd0: 97fffe2b     	bl	0x7bb67c
  7bbdd4: f94027e0     	ldr	x0, [sp, #0x48]
  7bbdd8: 91032000     	add	x0, x0, #0xc8
  7bbddc: 1e2e1000     	fmov	s0, #1.00000000
  7bbde0: 97fffe27     	bl	0x7bb67c
  7bbde4: f94027e0     	ldr	x0, [sp, #0x48]
  7bbde8: 91036000     	add	x0, x0, #0xd8
  7bbdec: 940003dc     	bl	0x7bcd5c
  7bbdf0: f94027e0     	ldr	x0, [sp, #0x48]
  7bbdf4: 9103c000     	add	x0, x0, #0xf0
  7bbdf8: 940003d9     	bl	0x7bcd5c
  7bbdfc: f94027e0     	ldr	x0, [sp, #0x48]
  7bbe00: 91042000     	add	x0, x0, #0x108
  7bbe04: 940003d6     	bl	0x7bcd5c
  7bbe08: f94027e0     	ldr	x0, [sp, #0x48]
  7bbe0c: 91048000     	add	x0, x0, #0x120
  7bbe10: 940003d3     	bl	0x7bcd5c
  7bbe14: f94027e0     	ldr	x0, [sp, #0x48]
  7bbe18: 9104e000     	add	x0, x0, #0x138
  7bbe1c: 940003d0     	bl	0x7bcd5c
  7bbe20: f94027e0     	ldr	x0, [sp, #0x48]
  7bbe24: b901501f     	str	wzr, [x0, #0x150]
  7bbe28: f94027e0     	ldr	x0, [sp, #0x48]
  7bbe2c: b901541f     	str	wzr, [x0, #0x154]
  7bbe30: f94027e0     	ldr	x0, [sp, #0x48]
  7bbe34: b901581f     	str	wzr, [x0, #0x158]
  7bbe38: f94027e0     	ldr	x0, [sp, #0x48]
  7bbe3c: b9015c1f     	str	wzr, [x0, #0x15c]
  7bbe40: f94027e0     	ldr	x0, [sp, #0x48]
  7bbe44: 91058000     	add	x0, x0, #0x160
  7bbe48: 1e2e1002     	fmov	s2, #1.00000000
  7bbe4c: 1e2e1001     	fmov	s1, #1.00000000
  7bbe50: 1e2e1000     	fmov	s0, #1.00000000
  7bbe54: 97fffdf0     	bl	0x7bb614
  7bbe58: f94027e0     	ldr	x0, [sp, #0x48]
  7bbe5c: 9105b000     	add	x0, x0, #0x16c
  7bbe60: 1e2e1002     	fmov	s2, #1.00000000
  7bbe64: 1e2e1001     	fmov	s1, #1.00000000
  7bbe68: 1e2e1000     	fmov	s0, #1.00000000
  7bbe6c: 97fffdea     	bl	0x7bb614
  7bbe70: f94027e0     	ldr	x0, [sp, #0x48]
  7bbe74: 9105e000     	add	x0, x0, #0x178
  7bbe78: 1e2e1002     	fmov	s2, #1.00000000
  7bbe7c: 1e2e1001     	fmov	s1, #1.00000000
  7bbe80: 1e2e1000     	fmov	s0, #1.00000000
  7bbe84: 97fffde4     	bl	0x7bb614
  7bbe88: f94027e0     	ldr	x0, [sp, #0x48]
  7bbe8c: b901841f     	str	wzr, [x0, #0x184]
  7bbe90: f94027e0     	ldr	x0, [sp, #0x48]
  7bbe94: b901881f     	str	wzr, [x0, #0x188]
  7bbe98: f94027e0     	ldr	x0, [sp, #0x48]
  7bbe9c: b9018c1f     	str	wzr, [x0, #0x18c]
  7bbea0: f94027e0     	ldr	x0, [sp, #0x48]
  7bbea4: b901901f     	str	wzr, [x0, #0x190]
  7bbea8: f94027e0     	ldr	x0, [sp, #0x48]
  7bbeac: b901941f     	str	wzr, [x0, #0x194]
  7bbeb0: f94027e0     	ldr	x0, [sp, #0x48]
  7bbeb4: b901981f     	str	wzr, [x0, #0x198]
  7bbeb8: f94027e0     	ldr	x0, [sp, #0x48]
  7bbebc: b9019c1f     	str	wzr, [x0, #0x19c]
  7bbec0: f94027e0     	ldr	x0, [sp, #0x48]
  7bbec4: b901a01f     	str	wzr, [x0, #0x1a0]
  7bbec8: f94027e0     	ldr	x0, [sp, #0x48]
  7bbecc: b901a41f     	str	wzr, [x0, #0x1a4]
  7bbed0: f94027e0     	ldr	x0, [sp, #0x48]
  7bbed4: b901a81f     	str	wzr, [x0, #0x1a8]
  7bbed8: f94027e0     	ldr	x0, [sp, #0x48]
  7bbedc: b901ac1f     	str	wzr, [x0, #0x1ac]
  7bbee0: f94027e0     	ldr	x0, [sp, #0x48]
  7bbee4: 9106c000     	add	x0, x0, #0x1b0
  7bbee8: 97fffe20     	bl	0x7bb768
  7bbeec: f94027e0     	ldr	x0, [sp, #0x48]
  7bbef0: 91072000     	add	x0, x0, #0x1c8
  7bbef4: 97ffff15     	bl	0x7bbb48
  7bbef8: 1400000e     	b	0x7bbf30
  7bbefc: aa0003f3     	mov	x19, x0
  7bbf00: 910143e0     	add	x0, sp, #0x50
  7bbf04: 94000073     	bl	0x7bc0d0
  7bbf08: aa1303e0     	mov	x0, x19
  7bbf0c: 97f13a11     	bl	0x40a750
  7bbf10: aa0003f3     	mov	x19, x0
  7bbf14: 9101e3e0     	add	x0, sp, #0x78
  7bbf18: 940000ae     	bl	0x7bc1d0
  7bbf1c: f94027e0     	ldr	x0, [sp, #0x48]
  7bbf20: 91016000     	add	x0, x0, #0x58
  7bbf24: 9400004f     	bl	0x7bc060
  7bbf28: aa1303e0     	mov	x0, x19
  7bbf2c: 97f13a09     	bl	0x40a750
  7bbf30: a94153f3     	ldp	x19, x20, [sp, #0x10]
  7bbf34: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  7bbf38: f9401bf7     	ldr	x23, [sp, #0x30]
  7bbf3c: a8c87bfd     	ldp	x29, x30, [sp], #0x80
  7bbf40: d65f03c0     	ret
