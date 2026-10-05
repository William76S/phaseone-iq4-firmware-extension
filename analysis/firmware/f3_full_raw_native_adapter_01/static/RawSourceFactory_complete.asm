  944e88: a9ac7bfd     	stp	x29, x30, [sp, #-0x140]!
  944e8c: 910003fd     	mov	x29, sp
  944e90: f9400801     	ldr	x1, [x0, #0x10]
  944e94: a9025bf5     	stp	x21, x22, [sp, #0x20]
  944e98: aa0803f6     	mov	x22, x8
  944e9c: b4002121     	cbz	x1, 0x9452c0
  944ea0: 91002015     	add	x21, x0, #0x8
  944ea4: a90153f3     	stp	x19, x20, [sp, #0x10]
  944ea8: aa1503e4     	mov	x4, x21
  944eac: aa0003f4     	mov	x20, x0
  944eb0: aa0103e0     	mov	x0, x1
  944eb4: d503201f     	nop
  944eb8: b9402002     	ldr	w2, [x0, #0x20]
  944ebc: 7104085f     	cmp	w2, #0x102
  944ec0: 540020a9     	b.ls	0x9452d4
  944ec4: aa0003e4     	mov	x4, x0
  944ec8: f9400800     	ldr	x0, [x0, #0x10]
  944ecc: b5ffff60     	cbnz	x0, 0x944eb8
  944ed0: eb0402bf     	cmp	x21, x4
  944ed4: 54001f40     	b.eq	0x9452bc
  944ed8: b9402080     	ldr	w0, [x4, #0x20]
  944edc: 71040c1f     	cmp	w0, #0x103
  944ee0: 54001ee8     	b.hi	0x9452bc
  944ee4: aa1503f3     	mov	x19, x21
  944ee8: a90363f7     	stp	x23, x24, [sp, #0x30]
  944eec: d503201f     	nop
  944ef0: b9402020     	ldr	w0, [x1, #0x20]
  944ef4: 7104081f     	cmp	w0, #0x102
  944ef8: 54001f49     	b.ls	0x9452e0
  944efc: aa0103f3     	mov	x19, x1
  944f00: f9400821     	ldr	x1, [x1, #0x10]
  944f04: b5ffff61     	cbnz	x1, 0x944ef0
  944f08: eb1302bf     	cmp	x21, x19
  944f0c: 54000080     	b.eq	0x944f1c
  944f10: b9402260     	ldr	w0, [x19, #0x20]
  944f14: 71040c1f     	cmp	w0, #0x103
  944f18: 54000369     	b.ls	0x944f84
  944f1c: d2800800     	mov	x0, #0x40               // =64
  944f20: f9002ff3     	str	x19, [sp, #0x58]
  944f24: 97eb13cf     	bl	0x409e60
  944f28: aa0003f3     	mov	x19, x0
  944f2c: f9402fe1     	ldr	x1, [sp, #0x58]
  944f30: 52802063     	mov	w3, #0x103              // =259
  944f34: b9002263     	str	w3, [x19, #0x20]
  944f38: 91008002     	add	x2, x0, #0x20
  944f3c: a902fe7f     	stp	xzr, xzr, [x19, #0x28]
  944f40: aa1403e0     	mov	x0, x20
  944f44: f9001e7f     	str	xzr, [x19, #0x38]
  944f48: 97f9e5c0     	bl	0x7be648
  944f4c: aa0003f7     	mov	x23, x0
  944f50: b4001ce1     	cbz	x1, 0x9452ec
  944f54: eb0102bf     	cmp	x21, x1
  944f58: 1a9f17e0     	cset	w0, eq
  944f5c: f10002ff     	cmp	x23, #0x0
  944f60: 1a9f0400     	csinc	w0, w0, wzr, eq
  944f64: 34005840     	cbz	w0, 0x945a6c
  944f68: aa0103e2     	mov	x2, x1
  944f6c: aa1503e3     	mov	x3, x21
  944f70: aa1303e1     	mov	x1, x19
  944f74: 97eb182b     	bl	0x40b020
  944f78: f9401680     	ldr	x0, [x20, #0x28]
  944f7c: 91000400     	add	x0, x0, #0x1
  944f80: f9001680     	str	x0, [x20, #0x28]
  944f84: b9402a60     	ldr	w0, [x19, #0x28]
  944f88: 7100041f     	cmp	w0, #0x1
  944f8c: 5400c961     	b.ne	0x9468b8
  944f90: b9403260     	ldr	w0, [x19, #0x30]
  944f94: 7100641f     	cmp	w0, #0x19
  944f98: 54002da0     	b.eq	0x94554c
  944f9c: 71006c1f     	cmp	w0, #0x1b
  944fa0: 54003a60     	b.eq	0x9456ec
  944fa4: 7100701f     	cmp	w0, #0x1c
  944fa8: 540045a0     	b.eq	0x94585c
  944fac: 7100741f     	cmp	w0, #0x1d
  944fb0: 54001ac0     	b.eq	0x945308
  944fb4: 7100781f     	cmp	w0, #0x1e
  944fb8: 54005880     	b.eq	0x945ac8
  944fbc: 71007c1f     	cmp	w0, #0x1f
  944fc0: 540068e0     	b.eq	0x945cdc
  944fc4: 7100801f     	cmp	w0, #0x20
  944fc8: 540079e0     	b.eq	0x945f04
  944fcc: 7100841f     	cmp	w0, #0x21
  944fd0: 54009000     	b.eq	0x9461d0
  944fd4: 7100881f     	cmp	w0, #0x22
  944fd8: 5400a660     	b.eq	0x9464a4
  944fdc: 71008c1f     	cmp	w0, #0x23
  944fe0: 540018e1     	b.ne	0x9452fc
  944fe4: d2800d00     	mov	x0, #0x68               // =104
  944fe8: 97eb139e     	bl	0x409e60
  944fec: aa0003f8     	mov	x24, x0
  944ff0: 9102c3f7     	add	x23, sp, #0xb0
  944ff4: f9400a81     	ldr	x1, [x20, #0x10]
  944ff8: 910022e2     	add	x2, x23, #0x8
  944ffc: b20003e3     	mov	x3, #0x100000001        // =4294967297
  945000: f0002400     	adrp	x0, 0xdc8000
  945004: 913ce000     	add	x0, x0, #0xf38
  945008: a9000f00     	stp	x0, x3, [x24]
  94500c: b900bbff     	str	wzr, [sp, #0xb8]
  945010: a90c0bff     	stp	xzr, x2, [sp, #0xc0]
  945014: a90d7fe2     	stp	x2, xzr, [sp, #0xd0]
  945018: b400c061     	cbz	x1, 0x946824
  94501c: 9101a3e3     	add	x3, sp, #0x68
  945020: aa1703e0     	mov	x0, x23
  945024: f90037f7     	str	x23, [sp, #0x68]
  945028: 94000c3c     	bl	0x948118
  94502c: aa0003e4     	mov	x4, x0
  945030: 14000002     	b	0x945038
  945034: aa0203e4     	mov	x4, x2
  945038: f9400882     	ldr	x2, [x4, #0x10]
  94503c: b5ffffc2     	cbnz	x2, 0x945034
  945040: aa0003e3     	mov	x3, x0
  945044: f90067e4     	str	x4, [sp, #0xc8]
  945048: 14000002     	b	0x945050
  94504c: aa0203e3     	mov	x3, x2
  945050: f9400c62     	ldr	x2, [x3, #0x18]
  945054: b5ffffc2     	cbnz	x2, 0x94504c
  945058: 910383f5     	add	x21, sp, #0xe0
  94505c: f90063e0     	str	x0, [sp, #0xc0]
  945060: f9401681     	ldr	x1, [x20, #0x28]
  945064: 910022a2     	add	x2, x21, #0x8
  945068: a90d07e3     	stp	x3, x1, [sp, #0xd0]
  94506c: b900ebff     	str	wzr, [sp, #0xe8]
  945070: a90f0bff     	stp	xzr, x2, [sp, #0xf0]
  945074: a9107fe2     	stp	x2, xzr, [sp, #0x100]
  945078: b400c140     	cbz	x0, 0x9468a0
  94507c: aa0003e1     	mov	x1, x0
  945080: 9101c3e3     	add	x3, sp, #0x70
  945084: aa1503e0     	mov	x0, x21
  945088: f9003bf5     	str	x21, [sp, #0x70]
  94508c: 94000c23     	bl	0x948118
  945090: aa0003e1     	mov	x1, x0
  945094: aa0003e4     	mov	x4, x0
  945098: 14000002     	b	0x9450a0
  94509c: aa0203e4     	mov	x4, x2
  9450a0: f9400882     	ldr	x2, [x4, #0x10]
  9450a4: b5ffffc2     	cbnz	x2, 0x94509c
  9450a8: aa0103e3     	mov	x3, x1
  9450ac: f9007fe4     	str	x4, [sp, #0xf8]
  9450b0: 14000002     	b	0x9450b8
  9450b4: aa0003e3     	mov	x3, x0
  9450b8: f9400c60     	ldr	x0, [x3, #0x18]
  9450bc: b5ffffc0     	cbnz	x0, 0x9450b4
  9450c0: 910443f3     	add	x19, sp, #0x110
  9450c4: f9007be1     	str	x1, [sp, #0xf0]
  9450c8: f9406fe4     	ldr	x4, [sp, #0xd8]
  9450cc: 91002262     	add	x2, x19, #0x8
  9450d0: a91013e3     	stp	x3, x4, [sp, #0x100]
  9450d4: b9011bff     	str	wzr, [sp, #0x118]
  9450d8: a9120bff     	stp	xzr, x2, [sp, #0x120]
  9450dc: a9137fe2     	stp	x2, xzr, [sp, #0x130]
  9450e0: b400be41     	cbz	x1, 0x9468a8
  9450e4: 9101e3e3     	add	x3, sp, #0x78
  9450e8: aa1303e0     	mov	x0, x19
  9450ec: f9003ff3     	str	x19, [sp, #0x78]
  9450f0: 94000c0a     	bl	0x948118
  9450f4: aa0003e3     	mov	x3, x0
  9450f8: a9046bf9     	stp	x25, x26, [sp, #0x40]
  9450fc: 14000002     	b	0x945104
  945100: aa0103e3     	mov	x3, x1
  945104: f9400861     	ldr	x1, [x3, #0x10]
  945108: b5ffffc1     	cbnz	x1, 0x945100
  94510c: aa0003e2     	mov	x2, x0
  945110: f90097e3     	str	x3, [sp, #0x128]
  945114: 14000002     	b	0x94511c
  945118: aa0103e2     	mov	x2, x1
  94511c: f9400c41     	ldr	x1, [x2, #0x18]
  945120: b5ffffc1     	cbnz	x1, 0x945118
  945124: f94087e1     	ldr	x1, [sp, #0x108]
  945128: f90093e0     	str	x0, [sp, #0x120]
  94512c: a91307e2     	stp	x2, x1, [sp, #0x130]
  945130: 91008302     	add	x2, x24, #0x20
  945134: 4f000400     	movi	v0.4s, #0x0
  945138: f0002401     	adrp	x1, 0xdc8000
  94513c: 912e4021     	add	x1, x1, #0xb90
  945140: f9000b01     	str	x1, [x24, #0x10]
  945144: b900231f     	str	wzr, [x24, #0x20]
  945148: aa1803e1     	mov	x1, x24
  94514c: a900885f     	stp	xzr, x2, [x2, #0x8]
  945150: 91006319     	add	x25, x24, #0x18
  945154: a901fc42     	stp	x2, xzr, [x2, #0x18]
  945158: 3901231f     	strb	wzr, [x24, #0x48]
  94515c: f9004bf9     	str	x25, [sp, #0x90]
  945160: 3c850c20     	str	q0, [x1, #0x50]!
  945164: f900083f     	str	xzr, [x1, #0x10]
  945168: 3d8023e0     	str	q0, [sp, #0x80]
  94516c: b4000580     	cbz	x0, 0x94521c
  945170: aa0003e1     	mov	x1, x0
  945174: 910203e3     	add	x3, sp, #0x80
  945178: aa1903e0     	mov	x0, x25
  94517c: 94000b1d     	bl	0x947df0
  945180: aa0003e3     	mov	x3, x0
  945184: 14000002     	b	0x94518c
  945188: aa0103e3     	mov	x3, x1
  94518c: f9400861     	ldr	x1, [x3, #0x10]
  945190: b5ffffc1     	cbnz	x1, 0x945188
  945194: aa0003e2     	mov	x2, x0
  945198: f9001b03     	str	x3, [x24, #0x30]
  94519c: 14000002     	b	0x9451a4
  9451a0: aa0103e2     	mov	x2, x1
  9451a4: f9400c41     	ldr	x1, [x2, #0x18]
  9451a8: b5ffffc1     	cbnz	x1, 0x9451a0
  9451ac: f9001f02     	str	x2, [x24, #0x38]
  9451b0: f94043f4     	ldr	x20, [sp, #0x80]
  9451b4: f9409fe1     	ldr	x1, [sp, #0x138]
  9451b8: f9001721     	str	x1, [x25, #0x28]
  9451bc: f9001700     	str	x0, [x24, #0x28]
  9451c0: f9404bfa     	ldr	x26, [sp, #0x90]
  9451c4: b4000134     	cbz	x20, 0x9451e8
  9451c8: f9400e81     	ldr	x1, [x20, #0x18]
  9451cc: aa1a03e0     	mov	x0, x26
  9451d0: 97f9e013     	bl	0x7bd21c
  9451d4: f9400a99     	ldr	x25, [x20, #0x10]
  9451d8: aa1403e0     	mov	x0, x20
  9451dc: 97eb14f5     	bl	0x40a5b0
  9451e0: aa1903f4     	mov	x20, x25
  9451e4: b5ffff39     	cbnz	x25, 0x9451c8
  9451e8: f94093f4     	ldr	x20, [sp, #0x120]
  9451ec: f0002400     	adrp	x0, 0xdc8000
  9451f0: 91308000     	add	x0, x0, #0xc20
  9451f4: f9000b00     	str	x0, [x24, #0x10]
  9451f8: b4000134     	cbz	x20, 0x94521c
  9451fc: f9400e81     	ldr	x1, [x20, #0x18]
  945200: aa1303e0     	mov	x0, x19
  945204: 97f9e006     	bl	0x7bd21c
  945208: f9400a99     	ldr	x25, [x20, #0x10]
  94520c: aa1403e0     	mov	x0, x20
  945210: 97eb14e8     	bl	0x40a5b0
  945214: aa1903f4     	mov	x20, x25
  945218: b5ffff39     	cbnz	x25, 0x9451fc
  94521c: f9407bf3     	ldr	x19, [sp, #0xf0]
  945220: f0002400     	adrp	x0, 0xdc8000
  945224: 9131a000     	add	x0, x0, #0xc68
  945228: f9000b00     	str	x0, [x24, #0x10]
  94522c: b4000133     	cbz	x19, 0x945250
  945230: f9400e61     	ldr	x1, [x19, #0x18]
  945234: aa1503e0     	mov	x0, x21
  945238: 97f9dff9     	bl	0x7bd21c
  94523c: f9400a74     	ldr	x20, [x19, #0x10]
  945240: aa1303e0     	mov	x0, x19
  945244: 97eb14db     	bl	0x40a5b0
  945248: aa1403f3     	mov	x19, x20
  94524c: b5ffff34     	cbnz	x20, 0x945230
  945250: f94063f3     	ldr	x19, [sp, #0xc0]
  945254: f0002400     	adrp	x0, 0xdc8000
  945258: 912d2000     	add	x0, x0, #0xb48
  94525c: f9000b00     	str	x0, [x24, #0x10]
  945260: b4000133     	cbz	x19, 0x945284
  945264: f9400e61     	ldr	x1, [x19, #0x18]
  945268: aa1703e0     	mov	x0, x23
  94526c: 97f9dfec     	bl	0x7bd21c
  945270: f9400a74     	ldr	x20, [x19, #0x10]
  945274: aa1303e0     	mov	x0, x19
  945278: 97eb14ce     	bl	0x40a5b0
  94527c: aa1403f3     	mov	x19, x20
  945280: b5ffff34     	cbnz	x20, 0x945264
  945284: f9400302     	ldr	x2, [x24]
  945288: aa1803e0     	mov	x0, x24
  94528c: f0001681     	adrp	x1, 0xc18000
  945290: 91154021     	add	x1, x1, #0x550
  945294: f9401042     	ldr	x2, [x2, #0x20]
  945298: d63f0040     	blr	x2
  94529c: a94153f3     	ldp	x19, x20, [sp, #0x10]
  9452a0: a9446bf9     	ldp	x25, x26, [sp, #0x40]
  9452a4: a90062c0     	stp	x0, x24, [x22]
  9452a8: aa1603e0     	mov	x0, x22
  9452ac: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  9452b0: a94363f7     	ldp	x23, x24, [sp, #0x30]
  9452b4: a8d47bfd     	ldp	x29, x30, [sp], #0x140
  9452b8: d65f03c0     	ret
  9452bc: a94153f3     	ldp	x19, x20, [sp, #0x10]
  9452c0: a9007edf     	stp	xzr, xzr, [x22]
  9452c4: aa1603e0     	mov	x0, x22
  9452c8: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  9452cc: a8d47bfd     	ldp	x29, x30, [sp], #0x140
  9452d0: d65f03c0     	ret
  9452d4: f9400c00     	ldr	x0, [x0, #0x18]
  9452d8: b5ffdf00     	cbnz	x0, 0x944eb8
  9452dc: 17fffefd     	b	0x944ed0
  9452e0: f9400c21     	ldr	x1, [x1, #0x18]
  9452e4: b5ffe061     	cbnz	x1, 0x944ef0
  9452e8: 17ffff08     	b	0x944f08
  9452ec: aa1303e0     	mov	x0, x19
  9452f0: 97eb14b0     	bl	0x40a5b0
  9452f4: b100a2ff     	cmn	x23, #0x28
  9452f8: 5400adc1     	b.ne	0x9468b0
  9452fc: a94153f3     	ldp	x19, x20, [sp, #0x10]
  945300: a94363f7     	ldp	x23, x24, [sp, #0x30]
  945304: 17ffffef     	b	0x9452c0
  945308: d2800d00     	mov	x0, #0x68               // =104
  94530c: 97eb12d5     	bl	0x409e60
  945310: aa0003f7     	mov	x23, x0
  945314: 910383f5     	add	x21, sp, #0xe0
  945318: f9400a81     	ldr	x1, [x20, #0x10]
  94531c: 910022a2     	add	x2, x21, #0x8
  945320: b20003e3     	mov	x3, #0x100000001        // =4294967297
  945324: f0002400     	adrp	x0, 0xdc8000
  945328: 9137a000     	add	x0, x0, #0xde8
  94532c: a9000ee0     	stp	x0, x3, [x23]
  945330: b900ebff     	str	wzr, [sp, #0xe8]
  945334: a90f0bff     	stp	xzr, x2, [sp, #0xf0]
  945338: a9107fe2     	stp	x2, xzr, [sp, #0x100]
  94533c: b4003b41     	cbz	x1, 0x945aa4
  945340: 9101e3e3     	add	x3, sp, #0x78
  945344: aa1503e0     	mov	x0, x21
  945348: f9003ff5     	str	x21, [sp, #0x78]
  94534c: 94000b73     	bl	0x948118
  945350: aa0003e1     	mov	x1, x0
  945354: aa0003e4     	mov	x4, x0
  945358: 14000002     	b	0x945360
  94535c: aa0203e4     	mov	x4, x2
  945360: f9400882     	ldr	x2, [x4, #0x10]
  945364: b5ffffc2     	cbnz	x2, 0x94535c
  945368: aa0103e3     	mov	x3, x1
  94536c: f9007fe4     	str	x4, [sp, #0xf8]
  945370: 14000002     	b	0x945378
  945374: aa0003e3     	mov	x3, x0
  945378: f9400c60     	ldr	x0, [x3, #0x18]
  94537c: b5ffffc0     	cbnz	x0, 0x945374
  945380: 910443f3     	add	x19, sp, #0x110
  945384: f9007be1     	str	x1, [sp, #0xf0]
  945388: f9401684     	ldr	x4, [x20, #0x28]
  94538c: 91002262     	add	x2, x19, #0x8
  945390: a91013e3     	stp	x3, x4, [sp, #0x100]
  945394: b9011bff     	str	wzr, [sp, #0x118]
  945398: a9120bff     	stp	xzr, x2, [sp, #0x120]
  94539c: a9137fe2     	stp	x2, xzr, [sp, #0x130]
  9453a0: b4000261     	cbz	x1, 0x9453ec
  9453a4: 910203e3     	add	x3, sp, #0x80
  9453a8: aa1303e0     	mov	x0, x19
  9453ac: f90043f3     	str	x19, [sp, #0x80]
  9453b0: 94000b5a     	bl	0x948118
  9453b4: aa0003e3     	mov	x3, x0
  9453b8: 14000002     	b	0x9453c0
  9453bc: aa0103e3     	mov	x3, x1
  9453c0: f9400861     	ldr	x1, [x3, #0x10]
  9453c4: b5ffffc1     	cbnz	x1, 0x9453bc
  9453c8: aa0003e2     	mov	x2, x0
  9453cc: f90097e3     	str	x3, [sp, #0x128]
  9453d0: 14000002     	b	0x9453d8
  9453d4: aa0103e2     	mov	x2, x1
  9453d8: f9400c41     	ldr	x1, [x2, #0x18]
  9453dc: b5ffffc1     	cbnz	x1, 0x9453d4
  9453e0: f94087e1     	ldr	x1, [sp, #0x108]
  9453e4: f90093e0     	str	x0, [sp, #0x120]
  9453e8: a91307e2     	stp	x2, x1, [sp, #0x130]
  9453ec: 910082e2     	add	x2, x23, #0x20
  9453f0: 4f000400     	movi	v0.4s, #0x0
  9453f4: f0002401     	adrp	x1, 0xdc8000
  9453f8: 912e4021     	add	x1, x1, #0xb90
  9453fc: f9000ae1     	str	x1, [x23, #0x10]
  945400: b90022ff     	str	wzr, [x23, #0x20]
  945404: aa1703e1     	mov	x1, x23
  945408: a900885f     	stp	xzr, x2, [x2, #0x8]
  94540c: 910062f8     	add	x24, x23, #0x18
  945410: a901fc42     	stp	x2, xzr, [x2, #0x18]
  945414: 390122ff     	strb	wzr, [x23, #0x48]
  945418: f90063f8     	str	x24, [sp, #0xc0]
  94541c: 3c850c20     	str	q0, [x1, #0x50]!
  945420: f900083f     	str	xzr, [x1, #0x10]
  945424: 3d802fe0     	str	q0, [sp, #0xb0]
  945428: b40005e0     	cbz	x0, 0x9454e4
  94542c: aa0003e1     	mov	x1, x0
  945430: 9102c3e3     	add	x3, sp, #0xb0
  945434: aa1803e0     	mov	x0, x24
  945438: 94000a6e     	bl	0x947df0
  94543c: aa0003e3     	mov	x3, x0
  945440: a9046bf9     	stp	x25, x26, [sp, #0x40]
  945444: 14000002     	b	0x94544c
  945448: aa0103e3     	mov	x3, x1
  94544c: f9400861     	ldr	x1, [x3, #0x10]
  945450: b5ffffc1     	cbnz	x1, 0x945448
  945454: aa0003e2     	mov	x2, x0
  945458: f9001ae3     	str	x3, [x23, #0x30]
  94545c: 14000002     	b	0x945464
  945460: aa0103e2     	mov	x2, x1
  945464: f9400c41     	ldr	x1, [x2, #0x18]
  945468: b5ffffc1     	cbnz	x1, 0x945460
  94546c: f9001ee2     	str	x2, [x23, #0x38]
  945470: f9405bf4     	ldr	x20, [sp, #0xb0]
  945474: f9409fe1     	ldr	x1, [sp, #0x138]
  945478: f9001701     	str	x1, [x24, #0x28]
  94547c: f90016e0     	str	x0, [x23, #0x28]
  945480: f94063f9     	ldr	x25, [sp, #0xc0]
  945484: b4000134     	cbz	x20, 0x9454a8
  945488: f9400e81     	ldr	x1, [x20, #0x18]
  94548c: aa1903e0     	mov	x0, x25
  945490: 97f9df63     	bl	0x7bd21c
  945494: f9400a98     	ldr	x24, [x20, #0x10]
  945498: aa1403e0     	mov	x0, x20
  94549c: 97eb1445     	bl	0x40a5b0
  9454a0: aa1803f4     	mov	x20, x24
  9454a4: b5ffff38     	cbnz	x24, 0x945488
  9454a8: f94093f4     	ldr	x20, [sp, #0x120]
  9454ac: f0002400     	adrp	x0, 0xdc8000
  9454b0: 91308000     	add	x0, x0, #0xc20
  9454b4: f9000ae0     	str	x0, [x23, #0x10]
  9454b8: b4000154     	cbz	x20, 0x9454e0
  9454bc: d503201f     	nop
  9454c0: f9400e81     	ldr	x1, [x20, #0x18]
  9454c4: aa1303e0     	mov	x0, x19
  9454c8: 97f9df55     	bl	0x7bd21c
  9454cc: f9400a98     	ldr	x24, [x20, #0x10]
  9454d0: aa1403e0     	mov	x0, x20
  9454d4: 97eb1437     	bl	0x40a5b0
  9454d8: aa1803f4     	mov	x20, x24
  9454dc: b5ffff38     	cbnz	x24, 0x9454c0
  9454e0: a9446bf9     	ldp	x25, x26, [sp, #0x40]
  9454e4: f0002400     	adrp	x0, 0xdc8000
  9454e8: f9407bf3     	ldr	x19, [sp, #0xf0]
  9454ec: 9129c000     	add	x0, x0, #0xa70
  9454f0: f9000ae0     	str	x0, [x23, #0x10]
  9454f4: b4000133     	cbz	x19, 0x945518
  9454f8: f9400e61     	ldr	x1, [x19, #0x18]
  9454fc: aa1503e0     	mov	x0, x21
  945500: 97f9df47     	bl	0x7bd21c
  945504: f9400a74     	ldr	x20, [x19, #0x10]
  945508: aa1303e0     	mov	x0, x19
  94550c: 97eb1429     	bl	0x40a5b0
  945510: aa1403f3     	mov	x19, x20
  945514: b5ffff34     	cbnz	x20, 0x9454f8
  945518: f94002e2     	ldr	x2, [x23]
  94551c: aa1703e0     	mov	x0, x23
  945520: f0001681     	adrp	x1, 0xc18000
  945524: 91154021     	add	x1, x1, #0x550
  945528: f9401042     	ldr	x2, [x2, #0x20]
  94552c: d63f0040     	blr	x2
  945530: a94153f3     	ldp	x19, x20, [sp, #0x10]
  945534: a9005ec0     	stp	x0, x23, [x22]
  945538: aa1603e0     	mov	x0, x22
  94553c: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  945540: a94363f7     	ldp	x23, x24, [sp, #0x30]
  945544: a8d47bfd     	ldp	x29, x30, [sp], #0x140
  945548: d65f03c0     	ret
  94554c: d2800d00     	mov	x0, #0x68               // =104
  945550: 97eb1244     	bl	0x409e60
  945554: aa0003f5     	mov	x21, x0
  945558: 910443f3     	add	x19, sp, #0x110
  94555c: f9400a81     	ldr	x1, [x20, #0x10]
  945560: 91002262     	add	x2, x19, #0x8
  945564: b20003e3     	mov	x3, #0x100000001        // =4294967297
  945568: f0002400     	adrp	x0, 0xdc8000
  94556c: 91350000     	add	x0, x0, #0xd40
  945570: a9000ea0     	stp	x0, x3, [x21]
  945574: b9011bff     	str	wzr, [sp, #0x118]
  945578: a9120bff     	stp	xzr, x2, [sp, #0x120]
  94557c: a9137fe2     	stp	x2, xzr, [sp, #0x130]
  945580: b4002a01     	cbz	x1, 0x945ac0
  945584: 9102c3e3     	add	x3, sp, #0xb0
  945588: aa1303e0     	mov	x0, x19
  94558c: f9005bf3     	str	x19, [sp, #0xb0]
  945590: 94000ae2     	bl	0x948118
  945594: aa0003e4     	mov	x4, x0
  945598: 14000002     	b	0x9455a0
  94559c: aa0203e4     	mov	x4, x2
  9455a0: f9400882     	ldr	x2, [x4, #0x10]
  9455a4: b5ffffc2     	cbnz	x2, 0x94559c
  9455a8: aa0003e3     	mov	x3, x0
  9455ac: f90097e4     	str	x4, [sp, #0x128]
  9455b0: 14000002     	b	0x9455b8
  9455b4: aa0203e3     	mov	x3, x2
  9455b8: f9400c62     	ldr	x2, [x3, #0x18]
  9455bc: b5ffffc2     	cbnz	x2, 0x9455b4
  9455c0: f9401681     	ldr	x1, [x20, #0x28]
  9455c4: f90093e0     	str	x0, [sp, #0x120]
  9455c8: a91307e3     	stp	x3, x1, [sp, #0x130]
  9455cc: 910082a2     	add	x2, x21, #0x20
  9455d0: 4f000400     	movi	v0.4s, #0x0
  9455d4: f0002401     	adrp	x1, 0xdc8000
  9455d8: 912e4021     	add	x1, x1, #0xb90
  9455dc: f9000aa1     	str	x1, [x21, #0x10]
  9455e0: b90022bf     	str	wzr, [x21, #0x20]
  9455e4: aa1503e1     	mov	x1, x21
  9455e8: a900885f     	stp	xzr, x2, [x2, #0x8]
  9455ec: 910062b7     	add	x23, x21, #0x18
  9455f0: a901fc42     	stp	x2, xzr, [x2, #0x18]
  9455f4: 390122bf     	strb	wzr, [x21, #0x48]
  9455f8: f9007bf7     	str	x23, [sp, #0xf0]
  9455fc: 3c850c20     	str	q0, [x1, #0x50]!
  945600: f900083f     	str	xzr, [x1, #0x10]
  945604: 3d803be0     	str	q0, [sp, #0xe0]
  945608: b4005dc0     	cbz	x0, 0x9461c0
  94560c: aa0003e1     	mov	x1, x0
  945610: 910383e3     	add	x3, sp, #0xe0
  945614: aa1703e0     	mov	x0, x23
  945618: 940009f6     	bl	0x947df0
  94561c: aa0003e3     	mov	x3, x0
  945620: 14000002     	b	0x945628
  945624: aa0103e3     	mov	x3, x1
  945628: f9400861     	ldr	x1, [x3, #0x10]
  94562c: b5ffffc1     	cbnz	x1, 0x945624
  945630: aa0003e2     	mov	x2, x0
  945634: f9001aa3     	str	x3, [x21, #0x30]
  945638: 14000002     	b	0x945640
  94563c: aa0103e2     	mov	x2, x1
  945640: f9400c41     	ldr	x1, [x2, #0x18]
  945644: b5ffffc1     	cbnz	x1, 0x94563c
  945648: f9001ea2     	str	x2, [x21, #0x38]
  94564c: f94073f4     	ldr	x20, [sp, #0xe0]
  945650: f9409fe1     	ldr	x1, [sp, #0x138]
  945654: f90016e1     	str	x1, [x23, #0x28]
  945658: f90016a0     	str	x0, [x21, #0x28]
  94565c: f9407bf8     	ldr	x24, [sp, #0xf0]
  945660: b4000134     	cbz	x20, 0x945684
  945664: f9400e81     	ldr	x1, [x20, #0x18]
  945668: aa1803e0     	mov	x0, x24
  94566c: 97f9deec     	bl	0x7bd21c
  945670: f9400a97     	ldr	x23, [x20, #0x10]
  945674: aa1403e0     	mov	x0, x20
  945678: 97eb13ce     	bl	0x40a5b0
  94567c: aa1703f4     	mov	x20, x23
  945680: b5ffff37     	cbnz	x23, 0x945664
  945684: f94093f4     	ldr	x20, [sp, #0x120]
  945688: f0002400     	adrp	x0, 0xdc8000
  94568c: 912f6000     	add	x0, x0, #0xbd8
  945690: f9000aa0     	str	x0, [x21, #0x10]
  945694: b4000134     	cbz	x20, 0x9456b8
  945698: f9400e81     	ldr	x1, [x20, #0x18]
  94569c: aa1303e0     	mov	x0, x19
  9456a0: 97f9dedf     	bl	0x7bd21c
  9456a4: f9400a97     	ldr	x23, [x20, #0x10]
  9456a8: aa1403e0     	mov	x0, x20
  9456ac: 97eb13c1     	bl	0x40a5b0
  9456b0: aa1703f4     	mov	x20, x23
  9456b4: b5ffff37     	cbnz	x23, 0x945698
  9456b8: f94002a2     	ldr	x2, [x21]
  9456bc: aa1503e0     	mov	x0, x21
  9456c0: f0001681     	adrp	x1, 0xc18000
  9456c4: 91154021     	add	x1, x1, #0x550
  9456c8: f9401042     	ldr	x2, [x2, #0x20]
  9456cc: d63f0040     	blr	x2
  9456d0: a94153f3     	ldp	x19, x20, [sp, #0x10]
  9456d4: a94363f7     	ldp	x23, x24, [sp, #0x30]
  9456d8: a90056c0     	stp	x0, x21, [x22]
  9456dc: aa1603e0     	mov	x0, x22
  9456e0: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  9456e4: a8d47bfd     	ldp	x29, x30, [sp], #0x140
  9456e8: d65f03c0     	ret
  9456ec: d2800d00     	mov	x0, #0x68               // =104
  9456f0: 97eb11dc     	bl	0x409e60
  9456f4: aa0003f5     	mov	x21, x0
  9456f8: 910443f3     	add	x19, sp, #0x110
  9456fc: f9400a81     	ldr	x1, [x20, #0x10]
  945700: 91002262     	add	x2, x19, #0x8
  945704: b20003e3     	mov	x3, #0x100000001        // =4294967297
  945708: f0002400     	adrp	x0, 0xdc8000
  94570c: 9135e000     	add	x0, x0, #0xd78
  945710: a9000ea0     	stp	x0, x3, [x21]
  945714: b9011bff     	str	wzr, [sp, #0x118]
  945718: a9120bff     	stp	xzr, x2, [sp, #0x120]
  94571c: a9137fe2     	stp	x2, xzr, [sp, #0x130]
  945720: b4001b01     	cbz	x1, 0x945a80
  945724: 9102c3e3     	add	x3, sp, #0xb0
  945728: aa1303e0     	mov	x0, x19
  94572c: f9005bf3     	str	x19, [sp, #0xb0]
  945730: 94000a7a     	bl	0x948118
  945734: aa0003e4     	mov	x4, x0
  945738: 14000002     	b	0x945740
  94573c: aa0203e4     	mov	x4, x2
  945740: f9400882     	ldr	x2, [x4, #0x10]
  945744: b5ffffc2     	cbnz	x2, 0x94573c
  945748: aa0003e3     	mov	x3, x0
  94574c: f90097e4     	str	x4, [sp, #0x128]
  945750: 14000002     	b	0x945758
  945754: aa0203e3     	mov	x3, x2
  945758: f9400c62     	ldr	x2, [x3, #0x18]
  94575c: b5ffffc2     	cbnz	x2, 0x945754
  945760: f9401681     	ldr	x1, [x20, #0x28]
  945764: f90093e0     	str	x0, [sp, #0x120]
  945768: a91307e3     	stp	x3, x1, [sp, #0x130]
  94576c: 910082a2     	add	x2, x21, #0x20
  945770: 4f000400     	movi	v0.4s, #0x0
  945774: f0002401     	adrp	x1, 0xdc8000
  945778: 912e4021     	add	x1, x1, #0xb90
  94577c: f9000aa1     	str	x1, [x21, #0x10]
  945780: b90022bf     	str	wzr, [x21, #0x20]
  945784: aa1503e1     	mov	x1, x21
  945788: a900885f     	stp	xzr, x2, [x2, #0x8]
  94578c: 910062b7     	add	x23, x21, #0x18
  945790: a901fc42     	stp	x2, xzr, [x2, #0x18]
  945794: 390122bf     	strb	wzr, [x21, #0x48]
  945798: f9007bf7     	str	x23, [sp, #0xf0]
  94579c: 3c850c20     	str	q0, [x1, #0x50]!
  9457a0: f900083f     	str	xzr, [x1, #0x10]
  9457a4: 3d803be0     	str	q0, [sp, #0xe0]
  9457a8: b4006760     	cbz	x0, 0x946494
  9457ac: aa0003e1     	mov	x1, x0
  9457b0: 910383e3     	add	x3, sp, #0xe0
  9457b4: aa1703e0     	mov	x0, x23
  9457b8: 9400098e     	bl	0x947df0
  9457bc: aa0003e3     	mov	x3, x0
  9457c0: 14000002     	b	0x9457c8
  9457c4: aa0103e3     	mov	x3, x1
  9457c8: f9400861     	ldr	x1, [x3, #0x10]
  9457cc: b5ffffc1     	cbnz	x1, 0x9457c4
  9457d0: aa0003e2     	mov	x2, x0
  9457d4: f9001aa3     	str	x3, [x21, #0x30]
  9457d8: 14000002     	b	0x9457e0
  9457dc: aa0103e2     	mov	x2, x1
  9457e0: f9400c41     	ldr	x1, [x2, #0x18]
  9457e4: b5ffffc1     	cbnz	x1, 0x9457dc
  9457e8: f9001ea2     	str	x2, [x21, #0x38]
  9457ec: f94073f4     	ldr	x20, [sp, #0xe0]
  9457f0: f9409fe1     	ldr	x1, [sp, #0x138]
  9457f4: f90016e1     	str	x1, [x23, #0x28]
  9457f8: f90016a0     	str	x0, [x21, #0x28]
  9457fc: f9407bf8     	ldr	x24, [sp, #0xf0]
  945800: b4000134     	cbz	x20, 0x945824
  945804: f9400e81     	ldr	x1, [x20, #0x18]
  945808: aa1803e0     	mov	x0, x24
  94580c: 97f9de84     	bl	0x7bd21c
  945810: f9400a97     	ldr	x23, [x20, #0x10]
  945814: aa1403e0     	mov	x0, x20
  945818: 97eb1366     	bl	0x40a5b0
  94581c: aa1703f4     	mov	x20, x23
  945820: b5ffff37     	cbnz	x23, 0x945804
  945824: f94093f4     	ldr	x20, [sp, #0x120]
  945828: f0002400     	adrp	x0, 0xdc8000
  94582c: 91308000     	add	x0, x0, #0xc20
  945830: f9000aa0     	str	x0, [x21, #0x10]
  945834: b4fff434     	cbz	x20, 0x9456b8
  945838: f9400e81     	ldr	x1, [x20, #0x18]
  94583c: aa1303e0     	mov	x0, x19
  945840: 97f9de77     	bl	0x7bd21c
  945844: f9400a97     	ldr	x23, [x20, #0x10]
  945848: aa1403e0     	mov	x0, x20
  94584c: 97eb1359     	bl	0x40a5b0
  945850: aa1703f4     	mov	x20, x23
  945854: b5ffff37     	cbnz	x23, 0x945838
  945858: 17ffff98     	b	0x9456b8
  94585c: d2800d00     	mov	x0, #0x68               // =104
  945860: 97eb1180     	bl	0x409e60
  945864: aa0003f7     	mov	x23, x0
  945868: 910383f5     	add	x21, sp, #0xe0
  94586c: f9400a81     	ldr	x1, [x20, #0x10]
  945870: 910022a2     	add	x2, x21, #0x8
  945874: b20003e3     	mov	x3, #0x100000001        // =4294967297
  945878: f0002400     	adrp	x0, 0xdc8000
  94587c: 9136c000     	add	x0, x0, #0xdb0
  945880: a9000ee0     	stp	x0, x3, [x23]
  945884: b900ebff     	str	wzr, [sp, #0xe8]
  945888: a90f0bff     	stp	xzr, x2, [sp, #0xf0]
  94588c: a9107fe2     	stp	x2, xzr, [sp, #0x100]
  945890: b4000fc1     	cbz	x1, 0x945a88
  945894: 9101e3e3     	add	x3, sp, #0x78
  945898: aa1503e0     	mov	x0, x21
  94589c: f9003ff5     	str	x21, [sp, #0x78]
  9458a0: 94000a1e     	bl	0x948118
  9458a4: aa0003e1     	mov	x1, x0
  9458a8: aa0003e4     	mov	x4, x0
  9458ac: 14000002     	b	0x9458b4
  9458b0: aa0203e4     	mov	x4, x2
  9458b4: f9400882     	ldr	x2, [x4, #0x10]
  9458b8: b5ffffc2     	cbnz	x2, 0x9458b0
  9458bc: aa0103e3     	mov	x3, x1
  9458c0: f9007fe4     	str	x4, [sp, #0xf8]
  9458c4: 14000002     	b	0x9458cc
  9458c8: aa0003e3     	mov	x3, x0
  9458cc: f9400c60     	ldr	x0, [x3, #0x18]
  9458d0: b5ffffc0     	cbnz	x0, 0x9458c8
  9458d4: 910443f3     	add	x19, sp, #0x110
  9458d8: f9007be1     	str	x1, [sp, #0xf0]
  9458dc: f9401684     	ldr	x4, [x20, #0x28]
  9458e0: 91002262     	add	x2, x19, #0x8
  9458e4: a91013e3     	stp	x3, x4, [sp, #0x100]
  9458e8: b9011bff     	str	wzr, [sp, #0x118]
  9458ec: a9120bff     	stp	xzr, x2, [sp, #0x120]
  9458f0: a9137fe2     	stp	x2, xzr, [sp, #0x130]
  9458f4: b4000261     	cbz	x1, 0x945940
  9458f8: 910203e3     	add	x3, sp, #0x80
  9458fc: aa1303e0     	mov	x0, x19
  945900: f90043f3     	str	x19, [sp, #0x80]
  945904: 94000a05     	bl	0x948118
  945908: aa0003e3     	mov	x3, x0
  94590c: 14000002     	b	0x945914
  945910: aa0103e3     	mov	x3, x1
  945914: f9400861     	ldr	x1, [x3, #0x10]
  945918: b5ffffc1     	cbnz	x1, 0x945910
  94591c: aa0003e2     	mov	x2, x0
  945920: f90097e3     	str	x3, [sp, #0x128]
  945924: 14000002     	b	0x94592c
  945928: aa0103e2     	mov	x2, x1
  94592c: f9400c41     	ldr	x1, [x2, #0x18]
  945930: b5ffffc1     	cbnz	x1, 0x945928
  945934: f94087e1     	ldr	x1, [sp, #0x108]
  945938: f90093e0     	str	x0, [sp, #0x120]
  94593c: a91307e2     	stp	x2, x1, [sp, #0x130]
  945940: 910082e2     	add	x2, x23, #0x20
  945944: 4f000400     	movi	v0.4s, #0x0
  945948: f0002401     	adrp	x1, 0xdc8000
  94594c: 912e4021     	add	x1, x1, #0xb90
  945950: f9000ae1     	str	x1, [x23, #0x10]
  945954: b90022ff     	str	wzr, [x23, #0x20]
  945958: aa1703e1     	mov	x1, x23
  94595c: a900885f     	stp	xzr, x2, [x2, #0x8]
  945960: 910062f8     	add	x24, x23, #0x18
  945964: a901fc42     	stp	x2, xzr, [x2, #0x18]
  945968: 390122ff     	strb	wzr, [x23, #0x48]
  94596c: f90063f8     	str	x24, [sp, #0xc0]
  945970: 3c850c20     	str	q0, [x1, #0x50]!
  945974: f900083f     	str	xzr, [x1, #0x10]
  945978: 3d802fe0     	str	q0, [sp, #0xb0]
  94597c: b40005c0     	cbz	x0, 0x945a34
  945980: aa0003e1     	mov	x1, x0
  945984: 9102c3e3     	add	x3, sp, #0xb0
  945988: aa1803e0     	mov	x0, x24
  94598c: 94000919     	bl	0x947df0
  945990: aa0003e3     	mov	x3, x0
  945994: a9046bf9     	stp	x25, x26, [sp, #0x40]
  945998: 14000002     	b	0x9459a0
  94599c: aa0103e3     	mov	x3, x1
  9459a0: f9400861     	ldr	x1, [x3, #0x10]
  9459a4: b5ffffc1     	cbnz	x1, 0x94599c
  9459a8: aa0003e2     	mov	x2, x0
  9459ac: f9001ae3     	str	x3, [x23, #0x30]
  9459b0: 14000002     	b	0x9459b8
  9459b4: aa0103e2     	mov	x2, x1
  9459b8: f9400c41     	ldr	x1, [x2, #0x18]
  9459bc: b5ffffc1     	cbnz	x1, 0x9459b4
  9459c0: f9001ee2     	str	x2, [x23, #0x38]
  9459c4: f9405bf4     	ldr	x20, [sp, #0xb0]
  9459c8: f9409fe1     	ldr	x1, [sp, #0x138]
  9459cc: f9001701     	str	x1, [x24, #0x28]
  9459d0: f90016e0     	str	x0, [x23, #0x28]
  9459d4: f94063f9     	ldr	x25, [sp, #0xc0]
  9459d8: b4000134     	cbz	x20, 0x9459fc
  9459dc: f9400e81     	ldr	x1, [x20, #0x18]
  9459e0: aa1903e0     	mov	x0, x25
  9459e4: 97f9de0e     	bl	0x7bd21c
  9459e8: f9400a98     	ldr	x24, [x20, #0x10]
  9459ec: aa1403e0     	mov	x0, x20
  9459f0: 97eb12f0     	bl	0x40a5b0
  9459f4: aa1803f4     	mov	x20, x24
  9459f8: b5ffff38     	cbnz	x24, 0x9459dc
  9459fc: f94093f4     	ldr	x20, [sp, #0x120]
  945a00: f0002400     	adrp	x0, 0xdc8000
  945a04: 91308000     	add	x0, x0, #0xc20
  945a08: f9000ae0     	str	x0, [x23, #0x10]
  945a0c: b4000134     	cbz	x20, 0x945a30
  945a10: f9400e81     	ldr	x1, [x20, #0x18]
  945a14: aa1303e0     	mov	x0, x19
  945a18: 97f9de01     	bl	0x7bd21c
  945a1c: f9400a98     	ldr	x24, [x20, #0x10]
  945a20: aa1403e0     	mov	x0, x20
  945a24: 97eb12e3     	bl	0x40a5b0
  945a28: aa1803f4     	mov	x20, x24
  945a2c: b5ffff38     	cbnz	x24, 0x945a10
  945a30: a9446bf9     	ldp	x25, x26, [sp, #0x40]
  945a34: f0002400     	adrp	x0, 0xdc8000
  945a38: f9407bf3     	ldr	x19, [sp, #0xf0]
  945a3c: 9128a000     	add	x0, x0, #0xa28
  945a40: f9000ae0     	str	x0, [x23, #0x10]
  945a44: b4ffd6b3     	cbz	x19, 0x945518
  945a48: f9400e61     	ldr	x1, [x19, #0x18]
  945a4c: aa1503e0     	mov	x0, x21
  945a50: 97f9ddf3     	bl	0x7bd21c
  945a54: f9400a74     	ldr	x20, [x19, #0x10]
  945a58: aa1303e0     	mov	x0, x19
  945a5c: 97eb12d5     	bl	0x40a5b0
  945a60: aa1403f3     	mov	x19, x20
  945a64: b5ffff34     	cbnz	x20, 0x945a48
  945a68: 17fffeac     	b	0x945518
  945a6c: b9402020     	ldr	w0, [x1, #0x20]
  945a70: b9402262     	ldr	w2, [x19, #0x20]
  945a74: 6b00005f     	cmp	w2, w0
  945a78: 1a9f27e0     	cset	w0, lo
  945a7c: 17fffd3b     	b	0x944f68
  945a80: d2800000     	mov	x0, #0x0                // =0
  945a84: 17ffff3a     	b	0x94576c
  945a88: 910443f3     	add	x19, sp, #0x110
  945a8c: d2800000     	mov	x0, #0x0                // =0
  945a90: 91002261     	add	x1, x19, #0x8
  945a94: b9011bff     	str	wzr, [sp, #0x118]
  945a98: a91207ff     	stp	xzr, x1, [sp, #0x120]
  945a9c: a9137fe1     	stp	x1, xzr, [sp, #0x130]
  945aa0: 17ffffa8     	b	0x945940
  945aa4: 910443f3     	add	x19, sp, #0x110
  945aa8: d2800000     	mov	x0, #0x0                // =0
  945aac: 91002261     	add	x1, x19, #0x8
  945ab0: b9011bff     	str	wzr, [sp, #0x118]
  945ab4: a91207ff     	stp	xzr, x1, [sp, #0x120]
  945ab8: a9137fe1     	stp	x1, xzr, [sp, #0x130]
  945abc: 17fffe4c     	b	0x9453ec
  945ac0: d2800000     	mov	x0, #0x0                // =0
  945ac4: 17fffec2     	b	0x9455cc
  945ac8: d2800d00     	mov	x0, #0x68               // =104
  945acc: 97eb10e5     	bl	0x409e60
  945ad0: aa0003f7     	mov	x23, x0
  945ad4: 910383f5     	add	x21, sp, #0xe0
  945ad8: f9400a81     	ldr	x1, [x20, #0x10]
  945adc: 910022a2     	add	x2, x21, #0x8
  945ae0: b20003e3     	mov	x3, #0x100000001        // =4294967297
  945ae4: f0002400     	adrp	x0, 0xdc8000
  945ae8: 91388000     	add	x0, x0, #0xe20
  945aec: a9000ee0     	stp	x0, x3, [x23]
  945af0: b900ebff     	str	wzr, [sp, #0xe8]
  945af4: a90f0bff     	stp	xzr, x2, [sp, #0xf0]
  945af8: a9107fe2     	stp	x2, xzr, [sp, #0x100]
  945afc: b4004be1     	cbz	x1, 0x946478
  945b00: 9101e3e3     	add	x3, sp, #0x78
  945b04: aa1503e0     	mov	x0, x21
  945b08: f9003ff5     	str	x21, [sp, #0x78]
  945b0c: 94000983     	bl	0x948118
  945b10: aa0003e1     	mov	x1, x0
  945b14: aa0003e4     	mov	x4, x0
  945b18: 14000002     	b	0x945b20
  945b1c: aa0203e4     	mov	x4, x2
  945b20: f9400882     	ldr	x2, [x4, #0x10]
  945b24: b5ffffc2     	cbnz	x2, 0x945b1c
  945b28: aa0103e3     	mov	x3, x1
  945b2c: f9007fe4     	str	x4, [sp, #0xf8]
  945b30: 14000002     	b	0x945b38
  945b34: aa0003e3     	mov	x3, x0
  945b38: f9400c60     	ldr	x0, [x3, #0x18]
  945b3c: b5ffffc0     	cbnz	x0, 0x945b34
  945b40: 910443f3     	add	x19, sp, #0x110
  945b44: f9007be1     	str	x1, [sp, #0xf0]
  945b48: f9401684     	ldr	x4, [x20, #0x28]
  945b4c: 91002262     	add	x2, x19, #0x8
  945b50: a91013e3     	stp	x3, x4, [sp, #0x100]
  945b54: b9011bff     	str	wzr, [sp, #0x118]
  945b58: a9120bff     	stp	xzr, x2, [sp, #0x120]
  945b5c: a9137fe2     	stp	x2, xzr, [sp, #0x130]
  945b60: b4000261     	cbz	x1, 0x945bac
  945b64: 910203e3     	add	x3, sp, #0x80
  945b68: aa1303e0     	mov	x0, x19
  945b6c: f90043f3     	str	x19, [sp, #0x80]
  945b70: 9400096a     	bl	0x948118
  945b74: aa0003e3     	mov	x3, x0
  945b78: 14000002     	b	0x945b80
  945b7c: aa0103e3     	mov	x3, x1
  945b80: f9400861     	ldr	x1, [x3, #0x10]
  945b84: b5ffffc1     	cbnz	x1, 0x945b7c
  945b88: aa0003e2     	mov	x2, x0
  945b8c: f90097e3     	str	x3, [sp, #0x128]
  945b90: 14000002     	b	0x945b98
  945b94: aa0103e2     	mov	x2, x1
  945b98: f9400c41     	ldr	x1, [x2, #0x18]
  945b9c: b5ffffc1     	cbnz	x1, 0x945b94
  945ba0: f94087e1     	ldr	x1, [sp, #0x108]
  945ba4: f90093e0     	str	x0, [sp, #0x120]
  945ba8: a91307e2     	stp	x2, x1, [sp, #0x130]
  945bac: 910082e2     	add	x2, x23, #0x20
  945bb0: 4f000400     	movi	v0.4s, #0x0
  945bb4: f0002401     	adrp	x1, 0xdc8000
  945bb8: 912e4021     	add	x1, x1, #0xb90
  945bbc: f9000ae1     	str	x1, [x23, #0x10]
  945bc0: b90022ff     	str	wzr, [x23, #0x20]
  945bc4: aa1703e1     	mov	x1, x23
  945bc8: a900885f     	stp	xzr, x2, [x2, #0x8]
  945bcc: 910062f8     	add	x24, x23, #0x18
  945bd0: a901fc42     	stp	x2, xzr, [x2, #0x18]
  945bd4: 390122ff     	strb	wzr, [x23, #0x48]
  945bd8: f90063f8     	str	x24, [sp, #0xc0]
  945bdc: 3c850c20     	str	q0, [x1, #0x50]!
  945be0: f900083f     	str	xzr, [x1, #0x10]
  945be4: 3d802fe0     	str	q0, [sp, #0xb0]
  945be8: b40005e0     	cbz	x0, 0x945ca4
  945bec: aa0003e1     	mov	x1, x0
  945bf0: 9102c3e3     	add	x3, sp, #0xb0
  945bf4: aa1803e0     	mov	x0, x24
  945bf8: 9400087e     	bl	0x947df0
  945bfc: aa0003e3     	mov	x3, x0
  945c00: a9046bf9     	stp	x25, x26, [sp, #0x40]
  945c04: 14000002     	b	0x945c0c
  945c08: aa0103e3     	mov	x3, x1
  945c0c: f9400861     	ldr	x1, [x3, #0x10]
  945c10: b5ffffc1     	cbnz	x1, 0x945c08
  945c14: aa0003e2     	mov	x2, x0
  945c18: f9001ae3     	str	x3, [x23, #0x30]
  945c1c: 14000002     	b	0x945c24
  945c20: aa0103e2     	mov	x2, x1
  945c24: f9400c41     	ldr	x1, [x2, #0x18]
  945c28: b5ffffc1     	cbnz	x1, 0x945c20
  945c2c: f9001ee2     	str	x2, [x23, #0x38]
  945c30: f9405bf4     	ldr	x20, [sp, #0xb0]
  945c34: f9409fe1     	ldr	x1, [sp, #0x138]
  945c38: f9001701     	str	x1, [x24, #0x28]
  945c3c: f90016e0     	str	x0, [x23, #0x28]
  945c40: f94063f9     	ldr	x25, [sp, #0xc0]
  945c44: b4000134     	cbz	x20, 0x945c68
  945c48: f9400e81     	ldr	x1, [x20, #0x18]
  945c4c: aa1903e0     	mov	x0, x25
  945c50: 97f9dd73     	bl	0x7bd21c
  945c54: f9400a98     	ldr	x24, [x20, #0x10]
  945c58: aa1403e0     	mov	x0, x20
  945c5c: 97eb1255     	bl	0x40a5b0
  945c60: aa1803f4     	mov	x20, x24
  945c64: b5ffff38     	cbnz	x24, 0x945c48
  945c68: f94093f4     	ldr	x20, [sp, #0x120]
  945c6c: f0002400     	adrp	x0, 0xdc8000
  945c70: 91308000     	add	x0, x0, #0xc20
  945c74: f9000ae0     	str	x0, [x23, #0x10]
  945c78: b4000154     	cbz	x20, 0x945ca0
  945c7c: d503201f     	nop
  945c80: f9400e81     	ldr	x1, [x20, #0x18]
  945c84: aa1303e0     	mov	x0, x19
  945c88: 97f9dd65     	bl	0x7bd21c
  945c8c: f9400a98     	ldr	x24, [x20, #0x10]
  945c90: aa1403e0     	mov	x0, x20
  945c94: 97eb1247     	bl	0x40a5b0
  945c98: aa1803f4     	mov	x20, x24
  945c9c: b5ffff38     	cbnz	x24, 0x945c80
  945ca0: a9446bf9     	ldp	x25, x26, [sp, #0x40]
  945ca4: f0002400     	adrp	x0, 0xdc8000
  945ca8: f9407bf3     	ldr	x19, [sp, #0xf0]
  945cac: 9131a000     	add	x0, x0, #0xc68
  945cb0: f9000ae0     	str	x0, [x23, #0x10]
  945cb4: b4ffc333     	cbz	x19, 0x945518
  945cb8: f9400e61     	ldr	x1, [x19, #0x18]
  945cbc: aa1503e0     	mov	x0, x21
  945cc0: 97f9dd57     	bl	0x7bd21c
  945cc4: f9400a74     	ldr	x20, [x19, #0x10]
  945cc8: aa1303e0     	mov	x0, x19
  945ccc: 97eb1239     	bl	0x40a5b0
  945cd0: aa1403f3     	mov	x19, x20
  945cd4: b5ffff34     	cbnz	x20, 0x945cb8
  945cd8: 17fffe10     	b	0x945518
  945cdc: d2800d00     	mov	x0, #0x68               // =104
  945ce0: 97eb1060     	bl	0x409e60
  945ce4: aa0003f8     	mov	x24, x0
  945ce8: 9102c3f7     	add	x23, sp, #0xb0
  945cec: f9400a81     	ldr	x1, [x20, #0x10]
  945cf0: 910022e2     	add	x2, x23, #0x8
  945cf4: b20003e3     	mov	x3, #0x100000001        // =4294967297
  945cf8: f0002400     	adrp	x0, 0xdc8000
  945cfc: 91396000     	add	x0, x0, #0xe58
  945d00: a9000f00     	stp	x0, x3, [x24]
  945d04: b900bbff     	str	wzr, [sp, #0xb8]
  945d08: a90c0bff     	stp	xzr, x2, [sp, #0xc0]
  945d0c: a90d7fe2     	stp	x2, xzr, [sp, #0xd0]
  945d10: b40051c1     	cbz	x1, 0x946748
  945d14: 9101c3e3     	add	x3, sp, #0x70
  945d18: aa1703e0     	mov	x0, x23
  945d1c: f9003bf7     	str	x23, [sp, #0x70]
  945d20: 940008fe     	bl	0x948118
  945d24: aa0003e4     	mov	x4, x0
  945d28: 14000002     	b	0x945d30
  945d2c: aa0203e4     	mov	x4, x2
  945d30: f9400882     	ldr	x2, [x4, #0x10]
  945d34: b5ffffc2     	cbnz	x2, 0x945d2c
  945d38: aa0003e3     	mov	x3, x0
  945d3c: f90067e4     	str	x4, [sp, #0xc8]
  945d40: 14000002     	b	0x945d48
  945d44: aa0203e3     	mov	x3, x2
  945d48: f9400c62     	ldr	x2, [x3, #0x18]
  945d4c: b5ffffc2     	cbnz	x2, 0x945d44
  945d50: 910383f5     	add	x21, sp, #0xe0
  945d54: f90063e0     	str	x0, [sp, #0xc0]
  945d58: f9401681     	ldr	x1, [x20, #0x28]
  945d5c: 910022a2     	add	x2, x21, #0x8
  945d60: a90d07e3     	stp	x3, x1, [sp, #0xd0]
  945d64: b900ebff     	str	wzr, [sp, #0xe8]
  945d68: a90f0bff     	stp	xzr, x2, [sp, #0xf0]
  945d6c: a9107fe2     	stp	x2, xzr, [sp, #0x100]
  945d70: b4005740     	cbz	x0, 0x946858
  945d74: aa0003e1     	mov	x1, x0
  945d78: 9101e3e3     	add	x3, sp, #0x78
  945d7c: aa1503e0     	mov	x0, x21
  945d80: f9003ff5     	str	x21, [sp, #0x78]
  945d84: 940008e5     	bl	0x948118
  945d88: aa0003e4     	mov	x4, x0
  945d8c: 14000002     	b	0x945d94
  945d90: aa0203e4     	mov	x4, x2
  945d94: f9400882     	ldr	x2, [x4, #0x10]
  945d98: b5ffffc2     	cbnz	x2, 0x945d90
  945d9c: aa0003e3     	mov	x3, x0
  945da0: f9007fe4     	str	x4, [sp, #0xf8]
  945da4: 14000002     	b	0x945dac
  945da8: aa0203e3     	mov	x3, x2
  945dac: f9400c62     	ldr	x2, [x3, #0x18]
  945db0: b5ffffc2     	cbnz	x2, 0x945da8
  945db4: 910443f3     	add	x19, sp, #0x110
  945db8: f9007be0     	str	x0, [sp, #0xf0]
  945dbc: f9406fe1     	ldr	x1, [sp, #0xd8]
  945dc0: 91002262     	add	x2, x19, #0x8
  945dc4: a91007e3     	stp	x3, x1, [sp, #0x100]
  945dc8: b9011bff     	str	wzr, [sp, #0x118]
  945dcc: a9120bff     	stp	xzr, x2, [sp, #0x120]
  945dd0: a9137fe2     	stp	x2, xzr, [sp, #0x130]
  945dd4: b4005460     	cbz	x0, 0x946860
  945dd8: aa0003e1     	mov	x1, x0
  945ddc: 910203e3     	add	x3, sp, #0x80
  945de0: aa1303e0     	mov	x0, x19
  945de4: f90043f3     	str	x19, [sp, #0x80]
  945de8: 940008cc     	bl	0x948118
  945dec: aa0003e3     	mov	x3, x0
  945df0: a9046bf9     	stp	x25, x26, [sp, #0x40]
  945df4: 14000002     	b	0x945dfc
  945df8: aa0103e3     	mov	x3, x1
  945dfc: f9400861     	ldr	x1, [x3, #0x10]
  945e00: b5ffffc1     	cbnz	x1, 0x945df8
  945e04: aa0003e2     	mov	x2, x0
  945e08: f90097e3     	str	x3, [sp, #0x128]
  945e0c: 14000002     	b	0x945e14
  945e10: aa0103e2     	mov	x2, x1
  945e14: f9400c41     	ldr	x1, [x2, #0x18]
  945e18: b5ffffc1     	cbnz	x1, 0x945e10
  945e1c: f94087e1     	ldr	x1, [sp, #0x108]
  945e20: f90093e0     	str	x0, [sp, #0x120]
  945e24: a91307e2     	stp	x2, x1, [sp, #0x130]
  945e28: 91008302     	add	x2, x24, #0x20
  945e2c: aa1803e3     	mov	x3, x24
  945e30: f0002400     	adrp	x0, 0xdc8000
  945e34: 912e4000     	add	x0, x0, #0xb90
  945e38: f9000b00     	str	x0, [x24, #0x10]
  945e3c: b900231f     	str	wzr, [x24, #0x20]
  945e40: 91006319     	add	x25, x24, #0x18
  945e44: a900885f     	stp	xzr, x2, [x2, #0x8]
  945e48: aa1303e1     	mov	x1, x19
  945e4c: aa1903e0     	mov	x0, x25
  945e50: a901fc42     	stp	x2, xzr, [x2, #0x18]
  945e54: 3901231f     	strb	wzr, [x24, #0x48]
  945e58: a9857c7f     	stp	xzr, xzr, [x3, #0x50]!
  945e5c: f900087f     	str	xzr, [x3, #0x10]
  945e60: 94000866     	bl	0x947ff8
  945e64: f94093f4     	ldr	x20, [sp, #0x120]
  945e68: f0002400     	adrp	x0, 0xdc8000
  945e6c: 91308000     	add	x0, x0, #0xc20
  945e70: f9000b00     	str	x0, [x24, #0x10]
  945e74: b4000134     	cbz	x20, 0x945e98
  945e78: f9400e81     	ldr	x1, [x20, #0x18]
  945e7c: aa1303e0     	mov	x0, x19
  945e80: 97f9dce7     	bl	0x7bd21c
  945e84: f9400a99     	ldr	x25, [x20, #0x10]
  945e88: aa1403e0     	mov	x0, x20
  945e8c: 97eb11c9     	bl	0x40a5b0
  945e90: aa1903f4     	mov	x20, x25
  945e94: b5ffff39     	cbnz	x25, 0x945e78
  945e98: f9407bf3     	ldr	x19, [sp, #0xf0]
  945e9c: f0002400     	adrp	x0, 0xdc8000
  945ea0: 9131a000     	add	x0, x0, #0xc68
  945ea4: f9000b00     	str	x0, [x24, #0x10]
  945ea8: b4000133     	cbz	x19, 0x945ecc
  945eac: f9400e61     	ldr	x1, [x19, #0x18]
  945eb0: aa1503e0     	mov	x0, x21
  945eb4: 97f9dcda     	bl	0x7bd21c
  945eb8: f9400a74     	ldr	x20, [x19, #0x10]
  945ebc: aa1303e0     	mov	x0, x19
  945ec0: 97eb11bc     	bl	0x40a5b0
  945ec4: aa1403f3     	mov	x19, x20
  945ec8: b5ffff34     	cbnz	x20, 0x945eac
  945ecc: f94063f3     	ldr	x19, [sp, #0xc0]
  945ed0: f0002400     	adrp	x0, 0xdc8000
  945ed4: 9132c000     	add	x0, x0, #0xcb0
  945ed8: f9000b00     	str	x0, [x24, #0x10]
  945edc: b4ff9d53     	cbz	x19, 0x945284
  945ee0: f9400e61     	ldr	x1, [x19, #0x18]
  945ee4: aa1703e0     	mov	x0, x23
  945ee8: 97f9dccd     	bl	0x7bd21c
  945eec: f9400a74     	ldr	x20, [x19, #0x10]
  945ef0: aa1303e0     	mov	x0, x19
  945ef4: 97eb11af     	bl	0x40a5b0
  945ef8: aa1403f3     	mov	x19, x20
  945efc: b5ffff34     	cbnz	x20, 0x945ee0
  945f00: 17fffce1     	b	0x945284
  945f04: d2800d00     	mov	x0, #0x68               // =104
  945f08: 97eb0fd6     	bl	0x409e60
  945f0c: aa0003f8     	mov	x24, x0
  945f10: 910223e2     	add	x2, sp, #0x88
  945f14: f9400a81     	ldr	x1, [x20, #0x10]
  945f18: b20003e3     	mov	x3, #0x100000001        // =4294967297
  945f1c: f0002400     	adrp	x0, 0xdc8000
  945f20: 913a4000     	add	x0, x0, #0xe90
  945f24: a9000f00     	stp	x0, x3, [x24]
  945f28: b9008bff     	str	wzr, [sp, #0x88]
  945f2c: a9090bff     	stp	xzr, x2, [sp, #0x90]
  945f30: a90a7fe2     	stp	x2, xzr, [sp, #0xa0]
  945f34: b4004221     	cbz	x1, 0x946778
  945f38: 910203e0     	add	x0, sp, #0x80
  945f3c: 910183e3     	add	x3, sp, #0x60
  945f40: f90033e0     	str	x0, [sp, #0x60]
  945f44: 94000875     	bl	0x948118
  945f48: aa0003e4     	mov	x4, x0
  945f4c: 14000002     	b	0x945f54
  945f50: aa0203e4     	mov	x4, x2
  945f54: f9400882     	ldr	x2, [x4, #0x10]
  945f58: b5ffffc2     	cbnz	x2, 0x945f50
  945f5c: aa0003e3     	mov	x3, x0
  945f60: f9004fe4     	str	x4, [sp, #0x98]
  945f64: 14000002     	b	0x945f6c
  945f68: aa0203e3     	mov	x3, x2
  945f6c: f9400c62     	ldr	x2, [x3, #0x18]
  945f70: b5ffffc2     	cbnz	x2, 0x945f68
  945f74: 9102c3f7     	add	x23, sp, #0xb0
  945f78: f9004be0     	str	x0, [sp, #0x90]
  945f7c: f9401681     	ldr	x1, [x20, #0x28]
  945f80: 910022e2     	add	x2, x23, #0x8
  945f84: a90a07e3     	stp	x3, x1, [sp, #0xa0]
  945f88: b900bbff     	str	wzr, [sp, #0xb8]
  945f8c: a90c0bff     	stp	xzr, x2, [sp, #0xc0]
  945f90: a90d7fe2     	stp	x2, xzr, [sp, #0xd0]
  945f94: b40046e0     	cbz	x0, 0x946870
  945f98: aa0003e1     	mov	x1, x0
  945f9c: 9101a3e3     	add	x3, sp, #0x68
  945fa0: aa1703e0     	mov	x0, x23
  945fa4: f90037f7     	str	x23, [sp, #0x68]
  945fa8: 9400085c     	bl	0x948118
  945fac: aa0003e4     	mov	x4, x0
  945fb0: 14000002     	b	0x945fb8
  945fb4: aa0203e4     	mov	x4, x2
  945fb8: f9400882     	ldr	x2, [x4, #0x10]
  945fbc: b5ffffc2     	cbnz	x2, 0x945fb4
  945fc0: aa0003e3     	mov	x3, x0
  945fc4: f90067e4     	str	x4, [sp, #0xc8]
  945fc8: 14000002     	b	0x945fd0
  945fcc: aa0203e3     	mov	x3, x2
  945fd0: f9400c62     	ldr	x2, [x3, #0x18]
  945fd4: b5ffffc2     	cbnz	x2, 0x945fcc
  945fd8: 910383f5     	add	x21, sp, #0xe0
  945fdc: f90063e0     	str	x0, [sp, #0xc0]
  945fe0: f94057e1     	ldr	x1, [sp, #0xa8]
  945fe4: 910022a2     	add	x2, x21, #0x8
  945fe8: a90d07e3     	stp	x3, x1, [sp, #0xd0]
  945fec: b900ebff     	str	wzr, [sp, #0xe8]
  945ff0: a90f0bff     	stp	xzr, x2, [sp, #0xf0]
  945ff4: a9107fe2     	stp	x2, xzr, [sp, #0x100]
  945ff8: b4004380     	cbz	x0, 0x946868
  945ffc: aa0003e1     	mov	x1, x0
  946000: 9101c3e3     	add	x3, sp, #0x70
  946004: aa1503e0     	mov	x0, x21
  946008: f9003bf5     	str	x21, [sp, #0x70]
  94600c: 94000843     	bl	0x948118
  946010: aa0003e4     	mov	x4, x0
  946014: 14000002     	b	0x94601c
  946018: aa0203e4     	mov	x4, x2
  94601c: f9400882     	ldr	x2, [x4, #0x10]
  946020: b5ffffc2     	cbnz	x2, 0x946018
  946024: aa0003e3     	mov	x3, x0
  946028: f9007fe4     	str	x4, [sp, #0xf8]
  94602c: 14000002     	b	0x946034
  946030: aa0203e3     	mov	x3, x2
  946034: f9400c62     	ldr	x2, [x3, #0x18]
  946038: b5ffffc2     	cbnz	x2, 0x946030
  94603c: 910443f3     	add	x19, sp, #0x110
  946040: f9007be0     	str	x0, [sp, #0xf0]
  946044: f9406fe1     	ldr	x1, [sp, #0xd8]
  946048: 91002262     	add	x2, x19, #0x8
  94604c: a91007e3     	stp	x3, x1, [sp, #0x100]
  946050: b9011bff     	str	wzr, [sp, #0x118]
  946054: a9120bff     	stp	xzr, x2, [sp, #0x120]
  946058: a9137fe2     	stp	x2, xzr, [sp, #0x130]
  94605c: b40040e0     	cbz	x0, 0x946878
  946060: aa0003e1     	mov	x1, x0
  946064: 9101e3e3     	add	x3, sp, #0x78
  946068: aa1303e0     	mov	x0, x19
  94606c: f9003ff3     	str	x19, [sp, #0x78]
  946070: 9400082a     	bl	0x948118
  946074: aa0003e3     	mov	x3, x0
  946078: a9046bf9     	stp	x25, x26, [sp, #0x40]
  94607c: 14000002     	b	0x946084
  946080: aa0103e3     	mov	x3, x1
  946084: f9400861     	ldr	x1, [x3, #0x10]
  946088: b5ffffc1     	cbnz	x1, 0x946080
  94608c: aa0003e2     	mov	x2, x0
  946090: f90097e3     	str	x3, [sp, #0x128]
  946094: 14000002     	b	0x94609c
  946098: aa0103e2     	mov	x2, x1
  94609c: f9400c41     	ldr	x1, [x2, #0x18]
  9460a0: b5ffffc1     	cbnz	x1, 0x946098
  9460a4: f94087e1     	ldr	x1, [sp, #0x108]
  9460a8: f90093e0     	str	x0, [sp, #0x120]
  9460ac: a91307e2     	stp	x2, x1, [sp, #0x130]
  9460b0: 91008302     	add	x2, x24, #0x20
  9460b4: aa1803e3     	mov	x3, x24
  9460b8: d0002400     	adrp	x0, 0xdc8000
  9460bc: 912e4000     	add	x0, x0, #0xb90
  9460c0: f9000b00     	str	x0, [x24, #0x10]
  9460c4: b900231f     	str	wzr, [x24, #0x20]
  9460c8: 91006319     	add	x25, x24, #0x18
  9460cc: a900885f     	stp	xzr, x2, [x2, #0x8]
  9460d0: aa1303e1     	mov	x1, x19
  9460d4: aa1903e0     	mov	x0, x25
  9460d8: a901fc42     	stp	x2, xzr, [x2, #0x18]
  9460dc: 3901231f     	strb	wzr, [x24, #0x48]
  9460e0: a9857c7f     	stp	xzr, xzr, [x3, #0x50]!
  9460e4: f900087f     	str	xzr, [x3, #0x10]
  9460e8: 940007c4     	bl	0x947ff8
  9460ec: f94093f4     	ldr	x20, [sp, #0x120]
  9460f0: d0002400     	adrp	x0, 0xdc8000
  9460f4: 91308000     	add	x0, x0, #0xc20
  9460f8: f9000b00     	str	x0, [x24, #0x10]
  9460fc: b4000134     	cbz	x20, 0x946120
  946100: f9400e81     	ldr	x1, [x20, #0x18]
  946104: aa1303e0     	mov	x0, x19
  946108: 97f9dc45     	bl	0x7bd21c
  94610c: f9400a99     	ldr	x25, [x20, #0x10]
  946110: aa1403e0     	mov	x0, x20
  946114: 97eb1127     	bl	0x40a5b0
  946118: aa1903f4     	mov	x20, x25
  94611c: b5ffff39     	cbnz	x25, 0x946100
  946120: f9407bf3     	ldr	x19, [sp, #0xf0]
  946124: d0002400     	adrp	x0, 0xdc8000
  946128: 9131a000     	add	x0, x0, #0xc68
  94612c: f9000b00     	str	x0, [x24, #0x10]
  946130: b4000133     	cbz	x19, 0x946154
  946134: f9400e61     	ldr	x1, [x19, #0x18]
  946138: aa1503e0     	mov	x0, x21
  94613c: 97f9dc38     	bl	0x7bd21c
  946140: f9400a74     	ldr	x20, [x19, #0x10]
  946144: aa1303e0     	mov	x0, x19
  946148: 97eb111a     	bl	0x40a5b0
  94614c: aa1403f3     	mov	x19, x20
  946150: b5ffff34     	cbnz	x20, 0x946134
  946154: f94063f3     	ldr	x19, [sp, #0xc0]
  946158: d0002400     	adrp	x0, 0xdc8000
  94615c: 9132c000     	add	x0, x0, #0xcb0
  946160: f9000b00     	str	x0, [x24, #0x10]
  946164: b4000133     	cbz	x19, 0x946188
  946168: f9400e61     	ldr	x1, [x19, #0x18]
  94616c: aa1703e0     	mov	x0, x23
  946170: 97f9dc2b     	bl	0x7bd21c
  946174: f9400a74     	ldr	x20, [x19, #0x10]
  946178: aa1303e0     	mov	x0, x19
  94617c: 97eb110d     	bl	0x40a5b0
  946180: aa1403f3     	mov	x19, x20
  946184: b5ffff34     	cbnz	x20, 0x946168
  946188: f9404bf3     	ldr	x19, [sp, #0x90]
  94618c: d0002400     	adrp	x0, 0xdc8000
  946190: 912ae000     	add	x0, x0, #0xab8
  946194: f9000b00     	str	x0, [x24, #0x10]
  946198: b4ff8773     	cbz	x19, 0x945284
  94619c: f9400e61     	ldr	x1, [x19, #0x18]
  9461a0: 910203e0     	add	x0, sp, #0x80
  9461a4: 97f9dc1e     	bl	0x7bd21c
  9461a8: f9400a74     	ldr	x20, [x19, #0x10]
  9461ac: aa1303e0     	mov	x0, x19
  9461b0: 97eb1100     	bl	0x40a5b0
  9461b4: aa1403f3     	mov	x19, x20
  9461b8: b5ffff34     	cbnz	x20, 0x94619c
  9461bc: 17fffc32     	b	0x945284
  9461c0: d0002400     	adrp	x0, 0xdc8000
  9461c4: 912f6000     	add	x0, x0, #0xbd8
  9461c8: f9000aa0     	str	x0, [x21, #0x10]
  9461cc: 17fffd3b     	b	0x9456b8
  9461d0: d2800d00     	mov	x0, #0x68               // =104
  9461d4: 97eb0f23     	bl	0x409e60
  9461d8: aa0003f8     	mov	x24, x0
  9461dc: 9102c3f7     	add	x23, sp, #0xb0
  9461e0: f9400a81     	ldr	x1, [x20, #0x10]
  9461e4: 910022e2     	add	x2, x23, #0x8
  9461e8: b20003e3     	mov	x3, #0x100000001        // =4294967297
  9461ec: d0002400     	adrp	x0, 0xdc8000
  9461f0: 913b2000     	add	x0, x0, #0xec8
  9461f4: a9000f00     	stp	x0, x3, [x24]
  9461f8: b900bbff     	str	wzr, [sp, #0xb8]
  9461fc: a90c0bff     	stp	xzr, x2, [sp, #0xc0]
  946200: a90d7fe2     	stp	x2, xzr, [sp, #0xd0]
  946204: b4002dc1     	cbz	x1, 0x9467bc
  946208: 9101a3e3     	add	x3, sp, #0x68
  94620c: 910022e2     	add	x2, x23, #0x8
  946210: aa1703e0     	mov	x0, x23
  946214: f90037f7     	str	x23, [sp, #0x68]
  946218: 940007c0     	bl	0x948118
  94621c: aa0003e4     	mov	x4, x0
  946220: 14000002     	b	0x946228
  946224: aa0203e4     	mov	x4, x2
  946228: f9400882     	ldr	x2, [x4, #0x10]
  94622c: b5ffffc2     	cbnz	x2, 0x946224
  946230: aa0003e3     	mov	x3, x0
  946234: f90067e4     	str	x4, [sp, #0xc8]
  946238: 14000002     	b	0x946240
  94623c: aa0203e3     	mov	x3, x2
  946240: f9400c62     	ldr	x2, [x3, #0x18]
  946244: b5ffffc2     	cbnz	x2, 0x94623c
  946248: 910383f5     	add	x21, sp, #0xe0
  94624c: f90063e0     	str	x0, [sp, #0xc0]
  946250: f9401681     	ldr	x1, [x20, #0x28]
  946254: 910022a2     	add	x2, x21, #0x8
  946258: a90d07e3     	stp	x3, x1, [sp, #0xd0]
  94625c: b900ebff     	str	wzr, [sp, #0xe8]
  946260: a90f0bff     	stp	xzr, x2, [sp, #0xf0]
  946264: a9107fe2     	stp	x2, xzr, [sp, #0x100]
  946268: b4003140     	cbz	x0, 0x946890
  94626c: aa0003e1     	mov	x1, x0
  946270: 9101c3e3     	add	x3, sp, #0x70
  946274: aa1503e0     	mov	x0, x21
  946278: f9003bf5     	str	x21, [sp, #0x70]
  94627c: 940007a7     	bl	0x948118
  946280: aa0003e1     	mov	x1, x0
  946284: aa0003e4     	mov	x4, x0
  946288: 14000002     	b	0x946290
  94628c: aa0203e4     	mov	x4, x2
  946290: f9400882     	ldr	x2, [x4, #0x10]
  946294: b5ffffc2     	cbnz	x2, 0x94628c
  946298: aa0103e3     	mov	x3, x1
  94629c: f9007fe4     	str	x4, [sp, #0xf8]
  9462a0: 14000002     	b	0x9462a8
  9462a4: aa0003e3     	mov	x3, x0
  9462a8: f9400c60     	ldr	x0, [x3, #0x18]
  9462ac: b5ffffc0     	cbnz	x0, 0x9462a4
  9462b0: 910443f3     	add	x19, sp, #0x110
  9462b4: f9007be1     	str	x1, [sp, #0xf0]
  9462b8: f9406fe4     	ldr	x4, [sp, #0xd8]
  9462bc: 91002262     	add	x2, x19, #0x8
  9462c0: a91013e3     	stp	x3, x4, [sp, #0x100]
  9462c4: b9011bff     	str	wzr, [sp, #0x118]
  9462c8: a9120bff     	stp	xzr, x2, [sp, #0x120]
  9462cc: a9137fe2     	stp	x2, xzr, [sp, #0x130]
  9462d0: b4002e41     	cbz	x1, 0x946898
  9462d4: 9101e3e3     	add	x3, sp, #0x78
  9462d8: aa1303e0     	mov	x0, x19
  9462dc: f9003ff3     	str	x19, [sp, #0x78]
  9462e0: 9400078e     	bl	0x948118
  9462e4: aa0003e3     	mov	x3, x0
  9462e8: a9046bf9     	stp	x25, x26, [sp, #0x40]
  9462ec: 14000002     	b	0x9462f4
  9462f0: aa0103e3     	mov	x3, x1
  9462f4: f9400861     	ldr	x1, [x3, #0x10]
  9462f8: b5ffffc1     	cbnz	x1, 0x9462f0
  9462fc: aa0003e2     	mov	x2, x0
  946300: f90097e3     	str	x3, [sp, #0x128]
  946304: 14000002     	b	0x94630c
  946308: aa0103e2     	mov	x2, x1
  94630c: f9400c41     	ldr	x1, [x2, #0x18]
  946310: b5ffffc1     	cbnz	x1, 0x946308
  946314: f94087e1     	ldr	x1, [sp, #0x108]
  946318: f90093e0     	str	x0, [sp, #0x120]
  94631c: a91307e2     	stp	x2, x1, [sp, #0x130]
  946320: 91008302     	add	x2, x24, #0x20
  946324: 4f000400     	movi	v0.4s, #0x0
  946328: d0002401     	adrp	x1, 0xdc8000
  94632c: 912e4021     	add	x1, x1, #0xb90
  946330: f9000b01     	str	x1, [x24, #0x10]
  946334: b900231f     	str	wzr, [x24, #0x20]
  946338: aa1803e1     	mov	x1, x24
  94633c: a900885f     	stp	xzr, x2, [x2, #0x8]
  946340: 91006319     	add	x25, x24, #0x18
  946344: a901fc42     	stp	x2, xzr, [x2, #0x18]
  946348: 3901231f     	strb	wzr, [x24, #0x48]
  94634c: f9004bf9     	str	x25, [sp, #0x90]
  946350: 3c850c20     	str	q0, [x1, #0x50]!
  946354: f900083f     	str	xzr, [x1, #0x10]
  946358: 3d8023e0     	str	q0, [sp, #0x80]
  94635c: b4000580     	cbz	x0, 0x94640c
  946360: aa0003e1     	mov	x1, x0
  946364: 910203e3     	add	x3, sp, #0x80
  946368: aa1903e0     	mov	x0, x25
  94636c: 940006a1     	bl	0x947df0
  946370: aa0003e3     	mov	x3, x0
  946374: 14000002     	b	0x94637c
  946378: aa0103e3     	mov	x3, x1
  94637c: f9400861     	ldr	x1, [x3, #0x10]
  946380: b5ffffc1     	cbnz	x1, 0x946378
  946384: aa0003e2     	mov	x2, x0
  946388: f9001b03     	str	x3, [x24, #0x30]
  94638c: 14000002     	b	0x946394
  946390: aa0103e2     	mov	x2, x1
  946394: f9400c41     	ldr	x1, [x2, #0x18]
  946398: b5ffffc1     	cbnz	x1, 0x946390
  94639c: f9001f02     	str	x2, [x24, #0x38]
  9463a0: f94043f4     	ldr	x20, [sp, #0x80]
  9463a4: f9409fe1     	ldr	x1, [sp, #0x138]
  9463a8: f9001721     	str	x1, [x25, #0x28]
  9463ac: f9001700     	str	x0, [x24, #0x28]
  9463b0: f9404bfa     	ldr	x26, [sp, #0x90]
  9463b4: b4000134     	cbz	x20, 0x9463d8
  9463b8: f9400e81     	ldr	x1, [x20, #0x18]
  9463bc: aa1a03e0     	mov	x0, x26
  9463c0: 97f9db97     	bl	0x7bd21c
  9463c4: f9400a99     	ldr	x25, [x20, #0x10]
  9463c8: aa1403e0     	mov	x0, x20
  9463cc: 97eb1079     	bl	0x40a5b0
  9463d0: aa1903f4     	mov	x20, x25
  9463d4: b5ffff39     	cbnz	x25, 0x9463b8
  9463d8: f94093f4     	ldr	x20, [sp, #0x120]
  9463dc: d0002400     	adrp	x0, 0xdc8000
  9463e0: 91308000     	add	x0, x0, #0xc20
  9463e4: f9000b00     	str	x0, [x24, #0x10]
  9463e8: b4000134     	cbz	x20, 0x94640c
  9463ec: f9400e81     	ldr	x1, [x20, #0x18]
  9463f0: aa1303e0     	mov	x0, x19
  9463f4: 97f9db8a     	bl	0x7bd21c
  9463f8: f9400a99     	ldr	x25, [x20, #0x10]
  9463fc: aa1403e0     	mov	x0, x20
  946400: 97eb106c     	bl	0x40a5b0
  946404: aa1903f4     	mov	x20, x25
  946408: b5ffff39     	cbnz	x25, 0x9463ec
  94640c: f9407bf3     	ldr	x19, [sp, #0xf0]
  946410: d0002400     	adrp	x0, 0xdc8000
  946414: 9131a000     	add	x0, x0, #0xc68
  946418: f9000b00     	str	x0, [x24, #0x10]
  94641c: b4000133     	cbz	x19, 0x946440
  946420: f9400e61     	ldr	x1, [x19, #0x18]
  946424: aa1503e0     	mov	x0, x21
  946428: 97f9db7d     	bl	0x7bd21c
  94642c: f9400a74     	ldr	x20, [x19, #0x10]
  946430: aa1303e0     	mov	x0, x19
  946434: 97eb105f     	bl	0x40a5b0
  946438: aa1403f3     	mov	x19, x20
  94643c: b5ffff34     	cbnz	x20, 0x946420
  946440: f94063f3     	ldr	x19, [sp, #0xc0]
  946444: d0002400     	adrp	x0, 0xdc8000
  946448: 912c0000     	add	x0, x0, #0xb00
  94644c: f9000b00     	str	x0, [x24, #0x10]
  946450: b4ff71b3     	cbz	x19, 0x945284
  946454: f9400e61     	ldr	x1, [x19, #0x18]
  946458: aa1703e0     	mov	x0, x23
  94645c: 97f9db70     	bl	0x7bd21c
  946460: f9400a74     	ldr	x20, [x19, #0x10]
  946464: aa1303e0     	mov	x0, x19
  946468: 97eb1052     	bl	0x40a5b0
  94646c: aa1403f3     	mov	x19, x20
  946470: b5ffff34     	cbnz	x20, 0x946454
  946474: 17fffb84     	b	0x945284
  946478: 910443f3     	add	x19, sp, #0x110
  94647c: d2800000     	mov	x0, #0x0                // =0
  946480: 91002261     	add	x1, x19, #0x8
  946484: b9011bff     	str	wzr, [sp, #0x118]
  946488: a91207ff     	stp	xzr, x1, [sp, #0x120]
  94648c: a9137fe1     	stp	x1, xzr, [sp, #0x130]
  946490: 17fffdc7     	b	0x945bac
  946494: d0002400     	adrp	x0, 0xdc8000
  946498: 91308000     	add	x0, x0, #0xc20
  94649c: f9000aa0     	str	x0, [x21, #0x10]
  9464a0: 17fffc86     	b	0x9456b8
  9464a4: d2800d00     	mov	x0, #0x68               // =104
  9464a8: 97eb0e6e     	bl	0x409e60
  9464ac: aa0003f8     	mov	x24, x0
  9464b0: 9102c3f7     	add	x23, sp, #0xb0
  9464b4: f9400a81     	ldr	x1, [x20, #0x10]
  9464b8: 910022e2     	add	x2, x23, #0x8
  9464bc: b20003e3     	mov	x3, #0x100000001        // =4294967297
  9464c0: d0002400     	adrp	x0, 0xdc8000
  9464c4: 913c0000     	add	x0, x0, #0xf00
  9464c8: a9000f00     	stp	x0, x3, [x24]
  9464cc: b900bbff     	str	wzr, [sp, #0xb8]
  9464d0: a90c0bff     	stp	xzr, x2, [sp, #0xc0]
  9464d4: a90d7fe2     	stp	x2, xzr, [sp, #0xd0]
  9464d8: b40018c1     	cbz	x1, 0x9467f0
  9464dc: 9101a3e3     	add	x3, sp, #0x68
  9464e0: aa1703e0     	mov	x0, x23
  9464e4: f90037f7     	str	x23, [sp, #0x68]
  9464e8: 9400070c     	bl	0x948118
  9464ec: aa0003e4     	mov	x4, x0
  9464f0: 14000002     	b	0x9464f8
  9464f4: aa0203e4     	mov	x4, x2
  9464f8: f9400882     	ldr	x2, [x4, #0x10]
  9464fc: b5ffffc2     	cbnz	x2, 0x9464f4
  946500: aa0003e3     	mov	x3, x0
  946504: f90067e4     	str	x4, [sp, #0xc8]
  946508: 14000002     	b	0x946510
  94650c: aa0203e3     	mov	x3, x2
  946510: f9400c62     	ldr	x2, [x3, #0x18]
  946514: b5ffffc2     	cbnz	x2, 0x94650c
  946518: 910383f5     	add	x21, sp, #0xe0
  94651c: f90063e0     	str	x0, [sp, #0xc0]
  946520: f9401681     	ldr	x1, [x20, #0x28]
  946524: 910022a2     	add	x2, x21, #0x8
  946528: a90d07e3     	stp	x3, x1, [sp, #0xd0]
  94652c: b900ebff     	str	wzr, [sp, #0xe8]
  946530: a90f0bff     	stp	xzr, x2, [sp, #0xf0]
  946534: a9107fe2     	stp	x2, xzr, [sp, #0x100]
  946538: b4001a40     	cbz	x0, 0x946880
  94653c: aa0003e1     	mov	x1, x0
  946540: 9101c3e3     	add	x3, sp, #0x70
  946544: aa1503e0     	mov	x0, x21
  946548: f9003bf5     	str	x21, [sp, #0x70]
  94654c: 940006f3     	bl	0x948118
  946550: aa0003e1     	mov	x1, x0
  946554: aa0003e4     	mov	x4, x0
  946558: 14000002     	b	0x946560
  94655c: aa0203e4     	mov	x4, x2
  946560: f9400882     	ldr	x2, [x4, #0x10]
  946564: b5ffffc2     	cbnz	x2, 0x94655c
  946568: aa0103e3     	mov	x3, x1
  94656c: f9007fe4     	str	x4, [sp, #0xf8]
  946570: 14000002     	b	0x946578
  946574: aa0003e3     	mov	x3, x0
  946578: f9400c60     	ldr	x0, [x3, #0x18]
  94657c: b5ffffc0     	cbnz	x0, 0x946574
  946580: 910443f3     	add	x19, sp, #0x110
  946584: f9007be1     	str	x1, [sp, #0xf0]
  946588: f9406fe4     	ldr	x4, [sp, #0xd8]
  94658c: 91002262     	add	x2, x19, #0x8
  946590: a91013e3     	stp	x3, x4, [sp, #0x100]
  946594: b9011bff     	str	wzr, [sp, #0x118]
  946598: a9120bff     	stp	xzr, x2, [sp, #0x120]
  94659c: a9137fe2     	stp	x2, xzr, [sp, #0x130]
  9465a0: b4001741     	cbz	x1, 0x946888
  9465a4: 9101e3e3     	add	x3, sp, #0x78
  9465a8: aa1303e0     	mov	x0, x19
  9465ac: f9003ff3     	str	x19, [sp, #0x78]
  9465b0: 940006da     	bl	0x948118
  9465b4: aa0003e3     	mov	x3, x0
  9465b8: a9046bf9     	stp	x25, x26, [sp, #0x40]
  9465bc: 14000002     	b	0x9465c4
  9465c0: aa0103e3     	mov	x3, x1
  9465c4: f9400861     	ldr	x1, [x3, #0x10]
  9465c8: b5ffffc1     	cbnz	x1, 0x9465c0
  9465cc: aa0003e2     	mov	x2, x0
  9465d0: f90097e3     	str	x3, [sp, #0x128]
  9465d4: 14000002     	b	0x9465dc
  9465d8: aa0103e2     	mov	x2, x1
  9465dc: f9400c41     	ldr	x1, [x2, #0x18]
  9465e0: b5ffffc1     	cbnz	x1, 0x9465d8
  9465e4: f94087e1     	ldr	x1, [sp, #0x108]
  9465e8: f90093e0     	str	x0, [sp, #0x120]
  9465ec: a91307e2     	stp	x2, x1, [sp, #0x130]
  9465f0: 91008302     	add	x2, x24, #0x20
  9465f4: 4f000400     	movi	v0.4s, #0x0
  9465f8: d0002401     	adrp	x1, 0xdc8000
  9465fc: 912e4021     	add	x1, x1, #0xb90
  946600: f9000b01     	str	x1, [x24, #0x10]
  946604: b900231f     	str	wzr, [x24, #0x20]
  946608: aa1803e1     	mov	x1, x24
  94660c: a900885f     	stp	xzr, x2, [x2, #0x8]
  946610: 91006319     	add	x25, x24, #0x18
  946614: a901fc42     	stp	x2, xzr, [x2, #0x18]
  946618: 3901231f     	strb	wzr, [x24, #0x48]
  94661c: f9004bf9     	str	x25, [sp, #0x90]
  946620: 3c850c20     	str	q0, [x1, #0x50]!
  946624: f900083f     	str	xzr, [x1, #0x10]
  946628: 3d8023e0     	str	q0, [sp, #0x80]
  94662c: b4000580     	cbz	x0, 0x9466dc
  946630: aa0003e1     	mov	x1, x0
  946634: 910203e3     	add	x3, sp, #0x80
  946638: aa1903e0     	mov	x0, x25
  94663c: 940005ed     	bl	0x947df0
  946640: aa0003e3     	mov	x3, x0
  946644: 14000002     	b	0x94664c
  946648: aa0103e3     	mov	x3, x1
  94664c: f9400861     	ldr	x1, [x3, #0x10]
  946650: b5ffffc1     	cbnz	x1, 0x946648
  946654: aa0003e2     	mov	x2, x0
  946658: f9001b03     	str	x3, [x24, #0x30]
  94665c: 14000002     	b	0x946664
  946660: aa0103e2     	mov	x2, x1
  946664: f9400c41     	ldr	x1, [x2, #0x18]
  946668: b5ffffc1     	cbnz	x1, 0x946660
  94666c: f9001f02     	str	x2, [x24, #0x38]
  946670: f94043f4     	ldr	x20, [sp, #0x80]
  946674: f9409fe1     	ldr	x1, [sp, #0x138]
  946678: f9001721     	str	x1, [x25, #0x28]
  94667c: f9001700     	str	x0, [x24, #0x28]
  946680: f9404bfa     	ldr	x26, [sp, #0x90]
  946684: b4000134     	cbz	x20, 0x9466a8
  946688: f9400e81     	ldr	x1, [x20, #0x18]
  94668c: aa1a03e0     	mov	x0, x26
  946690: 97f9dae3     	bl	0x7bd21c
  946694: f9400a99     	ldr	x25, [x20, #0x10]
  946698: aa1403e0     	mov	x0, x20
  94669c: 97eb0fc5     	bl	0x40a5b0
  9466a0: aa1903f4     	mov	x20, x25
  9466a4: b5ffff39     	cbnz	x25, 0x946688
  9466a8: f94093f4     	ldr	x20, [sp, #0x120]
  9466ac: d0002400     	adrp	x0, 0xdc8000
  9466b0: 91308000     	add	x0, x0, #0xc20
  9466b4: f9000b00     	str	x0, [x24, #0x10]
  9466b8: b4000134     	cbz	x20, 0x9466dc
  9466bc: f9400e81     	ldr	x1, [x20, #0x18]
  9466c0: aa1303e0     	mov	x0, x19
  9466c4: 97f9dad6     	bl	0x7bd21c
  9466c8: f9400a99     	ldr	x25, [x20, #0x10]
  9466cc: aa1403e0     	mov	x0, x20
  9466d0: 97eb0fb8     	bl	0x40a5b0
  9466d4: aa1903f4     	mov	x20, x25
  9466d8: b5ffff39     	cbnz	x25, 0x9466bc
  9466dc: f9407bf3     	ldr	x19, [sp, #0xf0]
  9466e0: d0002400     	adrp	x0, 0xdc8000
  9466e4: 9131a000     	add	x0, x0, #0xc68
  9466e8: f9000b00     	str	x0, [x24, #0x10]
  9466ec: b4000133     	cbz	x19, 0x946710
  9466f0: f9400e61     	ldr	x1, [x19, #0x18]
  9466f4: aa1503e0     	mov	x0, x21
  9466f8: 97f9dac9     	bl	0x7bd21c
  9466fc: f9400a74     	ldr	x20, [x19, #0x10]
  946700: aa1303e0     	mov	x0, x19
  946704: 97eb0fab     	bl	0x40a5b0
  946708: aa1403f3     	mov	x19, x20
  94670c: b5ffff34     	cbnz	x20, 0x9466f0
  946710: f94063f3     	ldr	x19, [sp, #0xc0]
  946714: d0002400     	adrp	x0, 0xdc8000
  946718: 9133e000     	add	x0, x0, #0xcf8
  94671c: f9000b00     	str	x0, [x24, #0x10]
  946720: b4ff5b33     	cbz	x19, 0x945284
  946724: f9400e61     	ldr	x1, [x19, #0x18]
  946728: aa1703e0     	mov	x0, x23
  94672c: 97f9dabc     	bl	0x7bd21c
  946730: f9400a74     	ldr	x20, [x19, #0x10]
  946734: aa1303e0     	mov	x0, x19
  946738: 97eb0f9e     	bl	0x40a5b0
  94673c: aa1403f3     	mov	x19, x20
  946740: b5ffff34     	cbnz	x20, 0x946724
  946744: 17fffad0     	b	0x945284
  946748: 910383f5     	add	x21, sp, #0xe0
  94674c: a9046bf9     	stp	x25, x26, [sp, #0x40]
  946750: 910022a0     	add	x0, x21, #0x8
  946754: b900ebff     	str	wzr, [sp, #0xe8]
  946758: a90f03ff     	stp	xzr, x0, [sp, #0xf0]
  94675c: a9107fe0     	stp	x0, xzr, [sp, #0x100]
  946760: 910443f3     	add	x19, sp, #0x110
  946764: 91002260     	add	x0, x19, #0x8
  946768: b9011bff     	str	wzr, [sp, #0x118]
  94676c: a91203ff     	stp	xzr, x0, [sp, #0x120]
  946770: a9137fe0     	stp	x0, xzr, [sp, #0x130]
  946774: 17fffdad     	b	0x945e28
  946778: 9102c3f7     	add	x23, sp, #0xb0
  94677c: a9046bf9     	stp	x25, x26, [sp, #0x40]
  946780: 910022e0     	add	x0, x23, #0x8
  946784: b900bbff     	str	wzr, [sp, #0xb8]
  946788: a90c03ff     	stp	xzr, x0, [sp, #0xc0]
  94678c: a90d7fe0     	stp	x0, xzr, [sp, #0xd0]
  946790: 910383f5     	add	x21, sp, #0xe0
  946794: 910022a0     	add	x0, x21, #0x8
  946798: b900ebff     	str	wzr, [sp, #0xe8]
  94679c: a90f03ff     	stp	xzr, x0, [sp, #0xf0]
  9467a0: a9107fe0     	stp	x0, xzr, [sp, #0x100]
  9467a4: 910443f3     	add	x19, sp, #0x110
  9467a8: 91002260     	add	x0, x19, #0x8
  9467ac: b9011bff     	str	wzr, [sp, #0x118]
  9467b0: a91203ff     	stp	xzr, x0, [sp, #0x120]
  9467b4: a9137fe0     	stp	x0, xzr, [sp, #0x130]
  9467b8: 17fffe3e     	b	0x9460b0
  9467bc: 910383f5     	add	x21, sp, #0xe0
  9467c0: a9046bf9     	stp	x25, x26, [sp, #0x40]
  9467c4: 910022a0     	add	x0, x21, #0x8
  9467c8: b900ebff     	str	wzr, [sp, #0xe8]
  9467cc: a90f03ff     	stp	xzr, x0, [sp, #0xf0]
  9467d0: a9107fe0     	stp	x0, xzr, [sp, #0x100]
  9467d4: 910443f3     	add	x19, sp, #0x110
  9467d8: 91002261     	add	x1, x19, #0x8
  9467dc: d2800000     	mov	x0, #0x0                // =0
  9467e0: b9011bff     	str	wzr, [sp, #0x118]
  9467e4: a91207ff     	stp	xzr, x1, [sp, #0x120]
  9467e8: a9137fe1     	stp	x1, xzr, [sp, #0x130]
  9467ec: 17fffecd     	b	0x946320
  9467f0: 910383f5     	add	x21, sp, #0xe0
  9467f4: a9046bf9     	stp	x25, x26, [sp, #0x40]
  9467f8: 910022a0     	add	x0, x21, #0x8
  9467fc: b900ebff     	str	wzr, [sp, #0xe8]
  946800: a90f03ff     	stp	xzr, x0, [sp, #0xf0]
  946804: a9107fe0     	stp	x0, xzr, [sp, #0x100]
  946808: 910443f3     	add	x19, sp, #0x110
  94680c: 91002261     	add	x1, x19, #0x8
  946810: d2800000     	mov	x0, #0x0                // =0
  946814: b9011bff     	str	wzr, [sp, #0x118]
  946818: a91207ff     	stp	xzr, x1, [sp, #0x120]
  94681c: a9137fe1     	stp	x1, xzr, [sp, #0x130]
  946820: 17ffff74     	b	0x9465f0
  946824: 910383f5     	add	x21, sp, #0xe0
  946828: a9046bf9     	stp	x25, x26, [sp, #0x40]
  94682c: 910022a0     	add	x0, x21, #0x8
  946830: b900ebff     	str	wzr, [sp, #0xe8]
  946834: a90f03ff     	stp	xzr, x0, [sp, #0xf0]
  946838: a9107fe0     	stp	x0, xzr, [sp, #0x100]
  94683c: 910443f3     	add	x19, sp, #0x110
  946840: 91002261     	add	x1, x19, #0x8
  946844: d2800000     	mov	x0, #0x0                // =0
  946848: b9011bff     	str	wzr, [sp, #0x118]
  94684c: a91207ff     	stp	xzr, x1, [sp, #0x120]
  946850: a9137fe1     	stp	x1, xzr, [sp, #0x130]
  946854: 17fffa37     	b	0x945130
  946858: a9046bf9     	stp	x25, x26, [sp, #0x40]
  94685c: 17ffffc1     	b	0x946760
  946860: a9046bf9     	stp	x25, x26, [sp, #0x40]
  946864: 17fffd71     	b	0x945e28
  946868: a9046bf9     	stp	x25, x26, [sp, #0x40]
  94686c: 17ffffce     	b	0x9467a4
  946870: a9046bf9     	stp	x25, x26, [sp, #0x40]
  946874: 17ffffc7     	b	0x946790
  946878: a9046bf9     	stp	x25, x26, [sp, #0x40]
  94687c: 17fffe0d     	b	0x9460b0
  946880: a9046bf9     	stp	x25, x26, [sp, #0x40]
  946884: 17ffffe1     	b	0x946808
  946888: a9046bf9     	stp	x25, x26, [sp, #0x40]
  94688c: 17ffff59     	b	0x9465f0
  946890: a9046bf9     	stp	x25, x26, [sp, #0x40]
  946894: 17ffffd0     	b	0x9467d4
  946898: a9046bf9     	stp	x25, x26, [sp, #0x40]
  94689c: 17fffea1     	b	0x946320
  9468a0: a9046bf9     	stp	x25, x26, [sp, #0x40]
  9468a4: 17ffffe6     	b	0x94683c
  9468a8: a9046bf9     	stp	x25, x26, [sp, #0x40]
  9468ac: 17fffa21     	b	0x945130
  9468b0: aa1703f3     	mov	x19, x23
  9468b4: 17fff9b4     	b	0x944f84
  9468b8: a9046bf9     	stp	x25, x26, [sp, #0x40]
  9468bc: 97ffed9d     	bl	0x941f30
  9468c0: aa0003f3     	mov	x19, x0
  9468c4: f94063e1     	ldr	x1, [sp, #0xc0]
  9468c8: aa1703e0     	mov	x0, x23
  9468cc: 97f9da54     	bl	0x7bd21c
  9468d0: aa1803e0     	mov	x0, x24
  9468d4: a9046bf9     	stp	x25, x26, [sp, #0x40]
  9468d8: 97eb0f36     	bl	0x40a5b0
  9468dc: aa1303e0     	mov	x0, x19
  9468e0: 97eb0f9c     	bl	0x40a750
  9468e4: aa0003f4     	mov	x20, x0
  9468e8: f9407be1     	ldr	x1, [sp, #0xf0]
  9468ec: aa1503e0     	mov	x0, x21
  9468f0: aa1403f3     	mov	x19, x20
  9468f4: 97f9da4a     	bl	0x7bd21c
  9468f8: 17fffff3     	b	0x9468c4
  9468fc: aa0003f3     	mov	x19, x0
  946900: 17fffff4     	b	0x9468d0
  946904: aa0003f3     	mov	x19, x0
  946908: 17ffffef     	b	0x9468c4
  94690c: aa0003f4     	mov	x20, x0
  946910: f94043e1     	ldr	x1, [sp, #0x80]
  946914: f9404be0     	ldr	x0, [sp, #0x90]
  946918: 97f9da41     	bl	0x7bd21c
  94691c: f9402b00     	ldr	x0, [x24, #0x50]
  946920: b4000040     	cbz	x0, 0x946928
  946924: 97eb0f23     	bl	0x40a5b0
  946928: f9401701     	ldr	x1, [x24, #0x28]
  94692c: aa1903e0     	mov	x0, x25
  946930: 97f9da3b     	bl	0x7bd21c
  946934: f94093e1     	ldr	x1, [sp, #0x120]
  946938: aa1303e0     	mov	x0, x19
  94693c: 97f9da38     	bl	0x7bd21c
  946940: a9446bf9     	ldp	x25, x26, [sp, #0x40]
  946944: 17ffffe9     	b	0x9468e8
  946948: aa0003f4     	mov	x20, x0
  94694c: 17ffffe7     	b	0x9468e8
  946950: f9402b01     	ldr	x1, [x24, #0x50]
  946954: aa0003f4     	mov	x20, x0
  946958: b4000061     	cbz	x1, 0x946964
  94695c: aa0103e0     	mov	x0, x1
  946960: 97eb0f14     	bl	0x40a5b0
  946964: f9401701     	ldr	x1, [x24, #0x28]
  946968: aa1903e0     	mov	x0, x25
  94696c: 97f9da2c     	bl	0x7bd21c
  946970: f94093e1     	ldr	x1, [sp, #0x120]
  946974: aa1303e0     	mov	x0, x19
  946978: 97f9da29     	bl	0x7bd21c
  94697c: a9446bf9     	ldp	x25, x26, [sp, #0x40]
  946980: aa1503e0     	mov	x0, x21
  946984: f9407be1     	ldr	x1, [sp, #0xf0]
  946988: aa1403f3     	mov	x19, x20
  94698c: 97f9da24     	bl	0x7bd21c
  946990: f94063e1     	ldr	x1, [sp, #0xc0]
  946994: aa1703e0     	mov	x0, x23
  946998: 97f9da21     	bl	0x7bd21c
  94699c: f9404be1     	ldr	x1, [sp, #0x90]
  9469a0: 910203e0     	add	x0, sp, #0x80
  9469a4: 97f9da1e     	bl	0x7bd21c
  9469a8: 17ffffca     	b	0x9468d0
  9469ac: aa0003f4     	mov	x20, x0
  9469b0: f94073e1     	ldr	x1, [sp, #0xe0]
  9469b4: f9407be0     	ldr	x0, [sp, #0xf0]
  9469b8: 97f9da19     	bl	0x7bd21c
  9469bc: f9402aa0     	ldr	x0, [x21, #0x50]
  9469c0: b5000180     	cbnz	x0, 0x9469f0
  9469c4: f94016a1     	ldr	x1, [x21, #0x28]
  9469c8: aa1703e0     	mov	x0, x23
  9469cc: 97f9da14     	bl	0x7bd21c
  9469d0: f94093e1     	ldr	x1, [sp, #0x120]
  9469d4: aa1303e0     	mov	x0, x19
  9469d8: 97f9da11     	bl	0x7bd21c
  9469dc: aa1503e0     	mov	x0, x21
  9469e0: a9046bf9     	stp	x25, x26, [sp, #0x40]
  9469e4: 97eb0ef3     	bl	0x40a5b0
  9469e8: aa1403e0     	mov	x0, x20
  9469ec: 97eb0f59     	bl	0x40a750
  9469f0: 97eb0ef0     	bl	0x40a5b0
  9469f4: 17fffff4     	b	0x9469c4
  9469f8: aa0003f4     	mov	x20, x0
  9469fc: f9405be1     	ldr	x1, [sp, #0xb0]
  946a00: f94063e0     	ldr	x0, [sp, #0xc0]
  946a04: 97f9da06     	bl	0x7bd21c
  946a08: f9402ae0     	ldr	x0, [x23, #0x50]
  946a0c: b5000220     	cbnz	x0, 0x946a50
  946a10: f94016e1     	ldr	x1, [x23, #0x28]
  946a14: aa1803e0     	mov	x0, x24
  946a18: 97f9da01     	bl	0x7bd21c
  946a1c: f94093e1     	ldr	x1, [sp, #0x120]
  946a20: aa1303e0     	mov	x0, x19
  946a24: 97f9d9fe     	bl	0x7bd21c
  946a28: f9407be1     	ldr	x1, [sp, #0xf0]
  946a2c: aa1503e0     	mov	x0, x21
  946a30: 97f9d9fb     	bl	0x7bd21c
  946a34: aa1703e0     	mov	x0, x23
  946a38: a9046bf9     	stp	x25, x26, [sp, #0x40]
  946a3c: 97eb0edd     	bl	0x40a5b0
  946a40: aa1403e0     	mov	x0, x20
  946a44: 97eb0f43     	bl	0x40a750
  946a48: aa0003f4     	mov	x20, x0
  946a4c: 17ffffe4     	b	0x9469dc
  946a50: 97eb0ed8     	bl	0x40a5b0
  946a54: 17ffffef     	b	0x946a10
  946a58: aa0003f3     	mov	x19, x0
  946a5c: 17ffffd0     	b	0x94699c
  946a60: aa0003f4     	mov	x20, x0
  946a64: 17ffffc7     	b	0x946980
  946a68: aa0003f4     	mov	x20, x0
  946a6c: 17ffffef     	b	0x946a28
  946a70: aa0003f4     	mov	x20, x0
  946a74: 17fffff0     	b	0x946a34
  946a78: 17ffffe0     	b	0x9469f8
  946a7c: 17ffffcc     	b	0x9469ac
  946a80: aa0003f4     	mov	x20, x0
  946a84: 17ffffe9     	b	0x946a28
  946a88: aa0003f4     	mov	x20, x0
  946a8c: 17ffffea     	b	0x946a34
  946a90: aa0003f3     	mov	x19, x0
  946a94: 17ffff8f     	b	0x9468d0
  946a98: aa0003f3     	mov	x19, x0
  946a9c: 17ffff8a     	b	0x9468c4
  946aa0: aa0003f3     	mov	x19, x0
  946aa4: 17ffff8b     	b	0x9468d0
  946aa8: aa0003f3     	mov	x19, x0
  946aac: 17ffff89     	b	0x9468d0
  946ab0: 17ffff97     	b	0x94690c
  946ab4: aa0003f4     	mov	x20, x0
  946ab8: 17ffffc9     	b	0x9469dc
  946abc: 17ffffcf     	b	0x9469f8
  946ac0: aa0003f4     	mov	x20, x0
  946ac4: 17ffffd9     	b	0x946a28
  946ac8: aa0003f3     	mov	x19, x0
  946acc: 17ffff81     	b	0x9468d0
  946ad0: aa0003f3     	mov	x19, x0
  946ad4: 17ffff7c     	b	0x9468c4
  946ad8: 17ffff8d     	b	0x94690c
  946adc: aa0003f4     	mov	x20, x0
  946ae0: 17ffff82     	b	0x9468e8
  946ae4: aa0003f4     	mov	x20, x0
  946ae8: 17ffff80     	b	0x9468e8
  946aec: aa0003f3     	mov	x19, x0
  946af0: 17ffffa8     	b	0x946990
  946af4: f9402b01     	ldr	x1, [x24, #0x50]
  946af8: aa0003f4     	mov	x20, x0
  946afc: b4fff161     	cbz	x1, 0x946928
  946b00: aa0103e0     	mov	x0, x1
  946b04: 97eb0eab     	bl	0x40a5b0
  946b08: 17ffff88     	b	0x946928
  946b0c: aa0003f4     	mov	x20, x0
  946b10: 17ffffc9     	b	0x946a34
  946b14: d503201f     	nop
