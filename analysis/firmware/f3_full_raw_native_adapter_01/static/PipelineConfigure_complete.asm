  916fa8: a9b87bfd     	stp	x29, x30, [sp, #-0x80]!
  916fac: 910003fd     	mov	x29, sp
  916fb0: a90153f3     	stp	x19, x20, [sp, #0x10]
  916fb4: aa0003f3     	mov	x19, x0
  916fb8: f0002560     	adrp	x0, 0xdc5000
  916fbc: a90363f7     	stp	x23, x24, [sp, #0x30]
  916fc0: aa1303f8     	mov	x24, x19
  916fc4: 913d6000     	add	x0, x0, #0xf58
  916fc8: a9025bf5     	stp	x21, x22, [sp, #0x20]
  916fcc: 91008275     	add	x21, x19, #0x20
  916fd0: 91014277     	add	x23, x19, #0x50
  916fd4: a9046bf9     	stp	x25, x26, [sp, #0x40]
  916fd8: 9100e27a     	add	x26, x19, #0x38
  916fdc: aa0103f9     	mov	x25, x1
  916fe0: f9002bfb     	str	x27, [sp, #0x50]
  916fe4: f8008700     	str	x0, [x24], #0x8
  916fe8: aa0203e0     	mov	x0, x2
  916fec: f900067f     	str	xzr, [x19, #0x8]
  916ff0: a900ff1f     	stp	xzr, xzr, [x24, #0x8]
  916ff4: f900127f     	str	xzr, [x19, #0x20]
  916ff8: a900febf     	stp	xzr, xzr, [x21, #0x8]
  916ffc: f9001e7f     	str	xzr, [x19, #0x38]
  917000: a900ff5f     	stp	xzr, xzr, [x26, #0x8]
  917004: f9002a7f     	str	xzr, [x19, #0x50]
  917008: a900feff     	stp	xzr, xzr, [x23, #0x8]
  91700c: a906fe7f     	stp	xzr, xzr, [x19, #0x68]
  917010: 97ffb4e4     	bl	0x9043a0
  917014: 7100341f     	cmp	w0, #0xd
  917018: bd400320     	ldr	s0, [x25]
  91701c: 54005bc0     	b.eq	0x917b94
  917020: 1e2c1001     	fmov	s1, #0.50000000
  917024: d2800700     	mov	x0, #0x38               // =56
  917028: 1e212010     	fcmpe	s0, s1
  91702c: 540016e8     	b.hi	0x917308
  917030: 97ebcb8c     	bl	0x409e60
  917034: 0f000420     	movi	v0.2s, #0x1
  917038: f0002561     	adrp	x1, 0xdc6000
  91703c: 91008021     	add	x1, x1, #0x20
  917040: aa0003f6     	mov	x22, x0
  917044: fd000400     	str	d0, [x0, #0x8]
  917048: f8010401     	str	x1, [x0], #0x10
  91704c: 97ffcef1     	bl	0x90ac10
  917050: f94002c2     	ldr	x2, [x22]
  917054: b0001814     	adrp	x20, 0xc18000
  917058: 91154294     	add	x20, x20, #0x550
  91705c: aa1603e0     	mov	x0, x22
  917060: aa1403e1     	mov	x1, x20
  917064: f9401042     	ldr	x2, [x2, #0x20]
  917068: d63f0040     	blr	x2
  91706c: a9075be0     	stp	x0, x22, [sp, #0x70]
  917070: a9408b01     	ldp	x1, x2, [x24, #0x8]
  917074: eb02003f     	cmp	x1, x2
  917078: 54009f20     	b.eq	0x91845c
  91707c: a9007c20     	stp	x0, xzr, [x1]
  917080: 91004022     	add	x2, x1, #0x10
  917084: f9403fe0     	ldr	x0, [sp, #0x78]
  917088: f9003fff     	str	xzr, [sp, #0x78]
  91708c: f9000420     	str	x0, [x1, #0x8]
  917090: f9000702     	str	x2, [x24, #0x8]
  917094: f9003bff     	str	xzr, [sp, #0x70]
  917098: f9403ff6     	ldr	x22, [sp, #0x78]
  91709c: b4000376     	cbz	x22, 0x917108
  9170a0: f0002560     	adrp	x0, 0xdc6000
  9170a4: f941a01b     	ldr	x27, [x0, #0x340]
  9170a8: b4009bbb     	cbz	x27, 0x91841c
  9170ac: 910022c1     	add	x1, x22, #0x8
  9170b0: 885ffc20     	ldaxr	w0, [x1]
  9170b4: 51000402     	sub	w2, w0, #0x1
  9170b8: 8803fc22     	stlxr	w3, w2, [x1]
  9170bc: 35ffffa3     	cbnz	w3, 0x9170b0
  9170c0: 7100041f     	cmp	w0, #0x1
  9170c4: 54000221     	b.ne	0x917108
  9170c8: f94002c1     	ldr	x1, [x22]
  9170cc: aa1603e0     	mov	x0, x22
  9170d0: f9400821     	ldr	x1, [x1, #0x10]
  9170d4: d63f0020     	blr	x1
  9170d8: b400a89b     	cbz	x27, 0x9185e8
  9170dc: 910032c1     	add	x1, x22, #0xc
  9170e0: 885ffc20     	ldaxr	w0, [x1]
  9170e4: 51000402     	sub	w2, w0, #0x1
  9170e8: 8803fc22     	stlxr	w3, w2, [x1]
  9170ec: 35ffffa3     	cbnz	w3, 0x9170e0
  9170f0: 7100041f     	cmp	w0, #0x1
  9170f4: 540000a1     	b.ne	0x917108
  9170f8: f94002c1     	ldr	x1, [x22]
  9170fc: aa1603e0     	mov	x0, x22
  917100: f9400c21     	ldr	x1, [x1, #0x18]
  917104: d63f0020     	blr	x1
  917108: bd419321     	ldr	s1, [x25, #0x190]
  91710c: 52824de0     	mov	w0, #0x126f             // =4719
  917110: 72a75060     	movk	w0, #0x3a83, lsl #16
  917114: 1e270000     	fmov	s0, w0
  917118: 1e20c021     	fabs	s1, s1
  91711c: 1e202030     	fcmpe	s1, s0
  917120: 540089ec     	b.gt	0x91825c
  917124: 52824de0     	mov	w0, #0x126f             // =4719
  917128: bd419721     	ldr	s1, [x25, #0x194]
  91712c: 72a75060     	movk	w0, #0x3a83, lsl #16
  917130: 1e270000     	fmov	s0, w0
  917134: 1e202030     	fcmpe	s1, s0
  917138: 5400358c     	b.gt	0x9177e8
  91713c: bd419b21     	ldr	s1, [x25, #0x198]
  917140: 1e202030     	fcmpe	s1, s0
  917144: 5400352c     	b.gt	0x9177e8
  917148: 394a4720     	ldrb	w0, [x25, #0x291]
  91714c: 340062c0     	cbz	w0, 0x917da4
  917150: a9408262     	ldp	x2, x0, [x19, #0x8]
  917154: a9421267     	ldp	x7, x4, [x19, #0x20]
  917158: cb020000     	sub	x0, x0, x2
  91715c: cb070081     	sub	x1, x4, x7
  917160: 9344fc03     	asr	x3, x0, #4
  917164: aa0303e6     	mov	x6, x3
  917168: 9344fc21     	asr	x1, x1, #4
  91716c: eb01007f     	cmp	x3, x1
  917170: 54005f88     	b.hi	0x917d60
  917174: 540000a2     	b.hs	0x917188
  917178: 8b0000e0     	add	x0, x7, x0
  91717c: eb00009f     	cmp	x4, x0
  917180: 54000040     	b.eq	0x917188
  917184: f9001660     	str	x0, [x19, #0x28]
  917188: bd400322     	ldr	s2, [x25]
  91718c: 1e2c1000     	fmov	s0, #0.50000000
  917190: 5100047b     	sub	w27, w3, #0x1
  917194: 2a0303f5     	mov	w21, w3
  917198: b942bb24     	ldr	w4, [x25, #0x2b8]
  91719c: 1e202050     	fcmpe	s2, s0
  9171a0: 93407f76     	sxtw	x22, w27
  9171a4: b942bf21     	ldr	w1, [x25, #0x2bc]
  9171a8: d37ceed4     	lsl	x20, x22, #4
  9171ac: b942c725     	ldr	w5, [x25, #0x2c4]
  9171b0: 8b1400e8     	add	x8, x7, x20
  9171b4: bd42c320     	ldr	s0, [x25, #0x2c0]
  9171b8: 540048e8     	b.hi	0x917ad4
  9171bc: 0e040c81     	dup	v1.2s, w4
  9171c0: 0e040400     	dup	v0.2s, v0.s[0]
  9171c4: 0e040442     	dup	v2.2s, v2.s[0]
  9171c8: a9438264     	ldp	x4, x0, [x19, #0x38]
  9171cc: 4e0c1c21     	mov	v1.s[1], w1
  9171d0: 4e0c1ca0     	mov	v0.s[1], w5
  9171d4: 0e21d821     	scvtf	v1.2s, v1.2s
  9171d8: 0e21d800     	scvtf	v0.2s, v0.2s
  9171dc: cb040001     	sub	x1, x0, x4
  9171e0: 9342fc21     	asr	x1, x1, #2
  9171e4: 2e22dc21     	fmul	v1.2s, v1.2s, v2.2s
  9171e8: 2e22dc00     	fmul	v0.2s, v0.2s, v2.2s
  9171ec: eb01007f     	cmp	x3, x1
  9171f0: 0e21b821     	fcvtms	v1.2s, v1.2s
  9171f4: 0ea1a800     	fcvtps	v0.2s, v0.2s
  9171f8: fc3468e1     	str	d1, [x7, x20]
  9171fc: fd000500     	str	d0, [x8, #0x8]
  917200: 54004908     	b.hi	0x917b20
  917204: 540000a2     	b.hs	0x917218
  917208: 8b030883     	add	x3, x4, x3, lsl #2
  91720c: eb03001f     	cmp	x0, x3
  917210: 54000040     	b.eq	0x917218
  917214: f9002263     	str	x3, [x19, #0x40]
  917218: a9450e60     	ldp	x0, x3, [x19, #0x50]
  91721c: b900009f     	str	wzr, [x4]
  917220: cb000061     	sub	x1, x3, x0
  917224: 9342fc21     	asr	x1, x1, #2
  917228: eb0100df     	cmp	x6, x1
  91722c: 54004948     	b.hi	0x917b54
  917230: 540000a2     	b.hs	0x917244
  917234: 8b060806     	add	x6, x0, x6, lsl #2
  917238: eb06007f     	cmp	x3, x6
  91723c: 54000040     	b.eq	0x917244
  917240: f9002e66     	str	x6, [x19, #0x58]
  917244: b900001f     	str	wzr, [x0]
  917248: 7100037f     	cmp	w27, #0x0
  91724c: 5400494d     	b.le	0x917b74
  917250: 51000ab5     	sub	w21, w21, #0x2
  917254: 9101c3f7     	add	x23, sp, #0x70
  917258: cb1502d6     	sub	x22, x22, x21
  91725c: f000257a     	adrp	x26, 0xdc6000
  917260: d37ceed6     	lsl	x22, x22, #4
  917264: 1400001b     	b	0x9172d0
  917268: 910022a1     	add	x1, x21, #0x8
  91726c: 885ffc22     	ldaxr	w2, [x1]
  917270: 11000442     	add	w2, w2, #0x1
  917274: 8803fc22     	stlxr	w3, w2, [x1]
  917278: 35ffffa3     	cbnz	w3, 0x91726c
  91727c: f9400002     	ldr	x2, [x0]
  917280: aa1703e1     	mov	x1, x23
  917284: f9401842     	ldr	x2, [x2, #0x30]
  917288: d63f0040     	blr	x2
  91728c: f9401262     	ldr	x2, [x19, #0x20]
  917290: 8b140042     	add	x2, x2, x20
  917294: a93f0440     	stp	x0, x1, [x2, #-0x10]
  917298: b4000155     	cbz	x21, 0x9172c0
  91729c: f941a35b     	ldr	x27, [x26, #0x340]
  9172a0: b400311b     	cbz	x27, 0x9178c0
  9172a4: 910022a1     	add	x1, x21, #0x8
  9172a8: 885ffc20     	ldaxr	w0, [x1]
  9172ac: 51000402     	sub	w2, w0, #0x1
  9172b0: 8803fc22     	stlxr	w3, w2, [x1]
  9172b4: 35ffffa3     	cbnz	w3, 0x9172a8
  9172b8: 7100041f     	cmp	w0, #0x1
  9172bc: 540030c0     	b.eq	0x9178d4
  9172c0: eb16029f     	cmp	x20, x22
  9172c4: d1004294     	sub	x20, x20, #0x10
  9172c8: 540032c0     	b.eq	0x917920
  9172cc: f9400662     	ldr	x2, [x19, #0x8]
  9172d0: 8b140043     	add	x3, x2, x20
  9172d4: f9401261     	ldr	x1, [x19, #0x20]
  9172d8: f9400475     	ldr	x21, [x3, #0x8]
  9172dc: 8b140021     	add	x1, x1, x20
  9172e0: f8746840     	ldr	x0, [x2, x20]
  9172e4: a9400c22     	ldp	x2, x3, [x1]
  9172e8: a9070fe2     	stp	x2, x3, [sp, #0x70]
  9172ec: b4fffc95     	cbz	x21, 0x91727c
  9172f0: f941a341     	ldr	x1, [x26, #0x340]
  9172f4: b5fffba1     	cbnz	x1, 0x917268
  9172f8: b9400aa1     	ldr	w1, [x21, #0x8]
  9172fc: 11000421     	add	w1, w1, #0x1
  917300: b9000aa1     	str	w1, [x21, #0x8]
  917304: 17ffffde     	b	0x91727c
  917308: 97ebcad6     	bl	0x409e60
  91730c: 0f000420     	movi	v0.2s, #0x1
  917310: f0002561     	adrp	x1, 0xdc6000
  917314: 91032021     	add	x1, x1, #0xc8
  917318: aa0003f6     	mov	x22, x0
  91731c: fd000400     	str	d0, [x0, #0x8]
  917320: f8010401     	str	x1, [x0], #0x10
  917324: 94001449     	bl	0x91c448
  917328: f94002c2     	ldr	x2, [x22]
  91732c: b0001814     	adrp	x20, 0xc18000
  917330: 91154294     	add	x20, x20, #0x550
  917334: aa1603e0     	mov	x0, x22
  917338: aa1403e1     	mov	x1, x20
  91733c: f9401042     	ldr	x2, [x2, #0x20]
  917340: d63f0040     	blr	x2
  917344: a9075be0     	stp	x0, x22, [sp, #0x70]
  917348: a9408b01     	ldp	x1, x2, [x24, #0x8]
  91734c: eb02003f     	cmp	x1, x2
  917350: 54008760     	b.eq	0x91843c
  917354: a9007c20     	stp	x0, xzr, [x1]
  917358: 91004022     	add	x2, x1, #0x10
  91735c: f9403fe0     	ldr	x0, [sp, #0x78]
  917360: f9003fff     	str	xzr, [sp, #0x78]
  917364: f9000420     	str	x0, [x1, #0x8]
  917368: f9000702     	str	x2, [x24, #0x8]
  91736c: f9003bff     	str	xzr, [sp, #0x70]
  917370: f9403ff6     	ldr	x22, [sp, #0x78]
  917374: b4000376     	cbz	x22, 0x9173e0
  917378: f0002560     	adrp	x0, 0xdc6000
  91737c: f941a01b     	ldr	x27, [x0, #0x340]
  917380: b400857b     	cbz	x27, 0x91842c
  917384: 910022c1     	add	x1, x22, #0x8
  917388: 885ffc20     	ldaxr	w0, [x1]
  91738c: 51000402     	sub	w2, w0, #0x1
  917390: 8803fc22     	stlxr	w3, w2, [x1]
  917394: 35ffffa3     	cbnz	w3, 0x917388
  917398: 7100041f     	cmp	w0, #0x1
  91739c: 54000221     	b.ne	0x9173e0
  9173a0: f94002c1     	ldr	x1, [x22]
  9173a4: aa1603e0     	mov	x0, x22
  9173a8: f9400821     	ldr	x1, [x1, #0x10]
  9173ac: d63f0020     	blr	x1
  9173b0: b400915b     	cbz	x27, 0x9185d8
  9173b4: 910032c1     	add	x1, x22, #0xc
  9173b8: 885ffc20     	ldaxr	w0, [x1]
  9173bc: 51000402     	sub	w2, w0, #0x1
  9173c0: 8803fc22     	stlxr	w3, w2, [x1]
  9173c4: 35ffffa3     	cbnz	w3, 0x9173b8
  9173c8: 7100041f     	cmp	w0, #0x1
  9173cc: 540000a1     	b.ne	0x9173e0
  9173d0: f94002c1     	ldr	x1, [x22]
  9173d4: aa1603e0     	mov	x0, x22
  9173d8: f9400c21     	ldr	x1, [x1, #0x18]
  9173dc: d63f0020     	blr	x1
  9173e0: b9404320     	ldr	w0, [x25, #0x40]
  9173e4: 7100001f     	cmp	w0, #0x0
  9173e8: 540004cd     	b.le	0x917480
  9173ec: d2800700     	mov	x0, #0x38               // =56
  9173f0: 97ebca9c     	bl	0x409e60
  9173f4: 0f000420     	movi	v0.2s, #0x1
  9173f8: f0002561     	adrp	x1, 0xdc6000
  9173fc: 91040021     	add	x1, x1, #0x100
  917400: aa0003f6     	mov	x22, x0
  917404: fd000400     	str	d0, [x0, #0x8]
  917408: f8010401     	str	x1, [x0], #0x10
  91740c: 940015e7     	bl	0x91cba8
  917410: f94002c2     	ldr	x2, [x22]
  917414: aa1403e1     	mov	x1, x20
  917418: aa1603e0     	mov	x0, x22
  91741c: f9401042     	ldr	x2, [x2, #0x20]
  917420: d63f0040     	blr	x2
  917424: a9075be0     	stp	x0, x22, [sp, #0x70]
  917428: a9408b01     	ldp	x1, x2, [x24, #0x8]
  91742c: eb02003f     	cmp	x1, x2
  917430: 54009600     	b.eq	0x9186f0
  917434: a9007c20     	stp	x0, xzr, [x1]
  917438: 91004022     	add	x2, x1, #0x10
  91743c: f9403fe0     	ldr	x0, [sp, #0x78]
  917440: f9003fff     	str	xzr, [sp, #0x78]
  917444: f9000420     	str	x0, [x1, #0x8]
  917448: f9000702     	str	x2, [x24, #0x8]
  91744c: f9003bff     	str	xzr, [sp, #0x70]
  917450: f9403ff6     	ldr	x22, [sp, #0x78]
  917454: b4000176     	cbz	x22, 0x917480
  917458: f0002560     	adrp	x0, 0xdc6000
  91745c: f941a01b     	ldr	x27, [x0, #0x340]
  917460: b4008e5b     	cbz	x27, 0x918628
  917464: 910022c1     	add	x1, x22, #0x8
  917468: 885ffc20     	ldaxr	w0, [x1]
  91746c: 51000402     	sub	w2, w0, #0x1
  917470: 8803fc22     	stlxr	w3, w2, [x1]
  917474: 35ffffa3     	cbnz	w3, 0x917468
  917478: 7100041f     	cmp	w0, #0x1
  91747c: 54008840     	b.eq	0x918584
  917480: d2800700     	mov	x0, #0x38               // =56
  917484: 97ebca77     	bl	0x409e60
  917488: 0f000420     	movi	v0.2s, #0x1
  91748c: f0002561     	adrp	x1, 0xdc6000
  917490: 9104e021     	add	x1, x1, #0x138
  917494: aa0003f6     	mov	x22, x0
  917498: fd000400     	str	d0, [x0, #0x8]
  91749c: f8010401     	str	x1, [x0], #0x10
  9174a0: 9400838c     	bl	0x9382d0
  9174a4: f94002c2     	ldr	x2, [x22]
  9174a8: aa1403e1     	mov	x1, x20
  9174ac: aa1603e0     	mov	x0, x22
  9174b0: f9401042     	ldr	x2, [x2, #0x20]
  9174b4: d63f0040     	blr	x2
  9174b8: a9075be0     	stp	x0, x22, [sp, #0x70]
  9174bc: a9408b01     	ldp	x1, x2, [x24, #0x8]
  9174c0: eb02003f     	cmp	x1, x2
  9174c4: 54007c40     	b.eq	0x91844c
  9174c8: a9007c20     	stp	x0, xzr, [x1]
  9174cc: 91004022     	add	x2, x1, #0x10
  9174d0: f9403fe0     	ldr	x0, [sp, #0x78]
  9174d4: f9003fff     	str	xzr, [sp, #0x78]
  9174d8: f9000420     	str	x0, [x1, #0x8]
  9174dc: f9000702     	str	x2, [x24, #0x8]
  9174e0: f9003bff     	str	xzr, [sp, #0x70]
  9174e4: f9403ff6     	ldr	x22, [sp, #0x78]
  9174e8: b4000396     	cbz	x22, 0x917558
  9174ec: f0002560     	adrp	x0, 0xdc6000
  9174f0: f941a01b     	ldr	x27, [x0, #0x340]
  9174f4: b40078db     	cbz	x27, 0x91840c
  9174f8: 910022c1     	add	x1, x22, #0x8
  9174fc: 885ffc20     	ldaxr	w0, [x1]
  917500: 51000402     	sub	w2, w0, #0x1
  917504: 8803fc22     	stlxr	w3, w2, [x1]
  917508: 35ffffa3     	cbnz	w3, 0x9174fc
  91750c: 7100041f     	cmp	w0, #0x1
  917510: 54000241     	b.ne	0x917558
  917514: f94002c1     	ldr	x1, [x22]
  917518: aa1603e0     	mov	x0, x22
  91751c: f9400821     	ldr	x1, [x1, #0x10]
  917520: d63f0020     	blr	x1
  917524: b400853b     	cbz	x27, 0x9185c8
  917528: 910032c1     	add	x1, x22, #0xc
  91752c: 885ffc20     	ldaxr	w0, [x1]
  917530: 51000402     	sub	w2, w0, #0x1
  917534: 8803fc22     	stlxr	w3, w2, [x1]
  917538: 35ffffa3     	cbnz	w3, 0x91752c
  91753c: 7100041f     	cmp	w0, #0x1
  917540: 540000c1     	b.ne	0x917558
  917544: f94002c1     	ldr	x1, [x22]
  917548: aa1603e0     	mov	x0, x22
  91754c: f9400c21     	ldr	x1, [x1, #0x18]
  917550: d63f0020     	blr	x1
  917554: d503201f     	nop
  917558: 39411320     	ldrb	w0, [x25, #0x44]
  91755c: 34005ae0     	cbz	w0, 0x9180b8
  917560: d2800700     	mov	x0, #0x38               // =56
  917564: 97ebca3f     	bl	0x409e60
  917568: 0f000420     	movi	v0.2s, #0x1
  91756c: f0002561     	adrp	x1, 0xdc6000
  917570: 9105c021     	add	x1, x1, #0x170
  917574: aa0003f6     	mov	x22, x0
  917578: fd000400     	str	d0, [x0, #0x8]
  91757c: f8010401     	str	x1, [x0], #0x10
  917580: 940014b4     	bl	0x91c850
  917584: f94002c2     	ldr	x2, [x22]
  917588: aa1403e1     	mov	x1, x20
  91758c: aa1603e0     	mov	x0, x22
  917590: f9401042     	ldr	x2, [x2, #0x20]
  917594: d63f0040     	blr	x2
  917598: a9075be0     	stp	x0, x22, [sp, #0x70]
  91759c: a9408b01     	ldp	x1, x2, [x24, #0x8]
  9175a0: eb02003f     	cmp	x1, x2
  9175a4: 54008c60     	b.eq	0x918730
  9175a8: a9007c20     	stp	x0, xzr, [x1]
  9175ac: 91004022     	add	x2, x1, #0x10
  9175b0: f9403fe0     	ldr	x0, [sp, #0x78]
  9175b4: f9003fff     	str	xzr, [sp, #0x78]
  9175b8: f9000420     	str	x0, [x1, #0x8]
  9175bc: f9000702     	str	x2, [x24, #0x8]
  9175c0: f9003bff     	str	xzr, [sp, #0x70]
  9175c4: f9403ff6     	ldr	x22, [sp, #0x78]
  9175c8: b4000396     	cbz	x22, 0x917638
  9175cc: f0002560     	adrp	x0, 0xdc6000
  9175d0: f941a01b     	ldr	x27, [x0, #0x340]
  9175d4: b4007b9b     	cbz	x27, 0x918544
  9175d8: 910022c1     	add	x1, x22, #0x8
  9175dc: 885ffc20     	ldaxr	w0, [x1]
  9175e0: 51000402     	sub	w2, w0, #0x1
  9175e4: 8803fc22     	stlxr	w3, w2, [x1]
  9175e8: 35ffffa3     	cbnz	w3, 0x9175dc
  9175ec: 7100041f     	cmp	w0, #0x1
  9175f0: 54000241     	b.ne	0x917638
  9175f4: f94002c1     	ldr	x1, [x22]
  9175f8: aa1603e0     	mov	x0, x22
  9175fc: f9400821     	ldr	x1, [x1, #0x10]
  917600: d63f0020     	blr	x1
  917604: b4008b7b     	cbz	x27, 0x918770
  917608: 910032c1     	add	x1, x22, #0xc
  91760c: 885ffc20     	ldaxr	w0, [x1]
  917610: 51000402     	sub	w2, w0, #0x1
  917614: 8803fc22     	stlxr	w3, w2, [x1]
  917618: 35ffffa3     	cbnz	w3, 0x91760c
  91761c: 7100041f     	cmp	w0, #0x1
  917620: 540000c1     	b.ne	0x917638
  917624: f94002c1     	ldr	x1, [x22]
  917628: aa1603e0     	mov	x0, x22
  91762c: f9400c21     	ldr	x1, [x1, #0x18]
  917630: d63f0020     	blr	x1
  917634: d503201f     	nop
  917638: bd419321     	ldr	s1, [x25, #0x190]
  91763c: 52824de0     	mov	w0, #0x126f             // =4719
  917640: 72a75060     	movk	w0, #0x3a83, lsl #16
  917644: 1e270000     	fmov	s0, w0
  917648: 1e20c021     	fabs	s1, s1
  91764c: 1e202030     	fcmpe	s1, s0
  917650: 5400672c     	b.gt	0x918334
  917654: 52824de0     	mov	w0, #0x126f             // =4719
  917658: bd419721     	ldr	s1, [x25, #0x194]
  91765c: 72a75060     	movk	w0, #0x3a83, lsl #16
  917660: 1e270000     	fmov	s0, w0
  917664: 1e202030     	fcmpe	s1, s0
  917668: 5400008c     	b.gt	0x917678
  91766c: bd419b21     	ldr	s1, [x25, #0x198]
  917670: 1e202030     	fcmpe	s1, s0
  917674: 540004cd     	b.le	0x91770c
  917678: d2802000     	mov	x0, #0x100              // =256
  91767c: 97ebc9f9     	bl	0x409e60
  917680: 0f000420     	movi	v0.2s, #0x1
  917684: f0002561     	adrp	x1, 0xdc6000
  917688: 91024021     	add	x1, x1, #0x90
  91768c: aa0003f6     	mov	x22, x0
  917690: fd000400     	str	d0, [x0, #0x8]
  917694: f8010401     	str	x1, [x0], #0x10
  917698: 940196de     	bl	0x97d210
  91769c: f94002c2     	ldr	x2, [x22]
  9176a0: aa1403e1     	mov	x1, x20
  9176a4: aa1603e0     	mov	x0, x22
  9176a8: f9401042     	ldr	x2, [x2, #0x20]
  9176ac: d63f0040     	blr	x2
  9176b0: a9075be0     	stp	x0, x22, [sp, #0x70]
  9176b4: a9408b01     	ldp	x1, x2, [x24, #0x8]
  9176b8: eb02003f     	cmp	x1, x2
  9176bc: 540080a0     	b.eq	0x9186d0
  9176c0: a9007c20     	stp	x0, xzr, [x1]
  9176c4: 91004022     	add	x2, x1, #0x10
  9176c8: f9403fe0     	ldr	x0, [sp, #0x78]
  9176cc: f9003fff     	str	xzr, [sp, #0x78]
  9176d0: f9000420     	str	x0, [x1, #0x8]
  9176d4: f9000702     	str	x2, [x24, #0x8]
  9176d8: f9003bff     	str	xzr, [sp, #0x70]
  9176dc: f9403ff6     	ldr	x22, [sp, #0x78]
  9176e0: b4000176     	cbz	x22, 0x91770c
  9176e4: f0002560     	adrp	x0, 0xdc6000
  9176e8: f941a01b     	ldr	x27, [x0, #0x340]
  9176ec: b4006c1b     	cbz	x27, 0x91846c
  9176f0: 910022c1     	add	x1, x22, #0x8
  9176f4: 885ffc20     	ldaxr	w0, [x1]
  9176f8: 51000402     	sub	w2, w0, #0x1
  9176fc: 8803fc22     	stlxr	w3, w2, [x1]
  917700: 35ffffa3     	cbnz	w3, 0x9176f4
  917704: 7100041f     	cmp	w0, #0x1
  917708: 54007a00     	b.eq	0x918648
  91770c: bd418721     	ldr	s1, [x25, #0x184]
  917710: 52824de0     	mov	w0, #0x126f             // =4719
  917714: 72a75060     	movk	w0, #0x3a83, lsl #16
  917718: 1e270000     	fmov	s0, w0
  91771c: 1e20c021     	fabs	s1, s1
  917720: 1e202030     	fcmpe	s1, s0
  917724: 54ffd12d     	b.le	0x917148
  917728: d2800700     	mov	x0, #0x38               // =56
  91772c: 97ebc9cd     	bl	0x409e60
  917730: 0f000420     	movi	v0.2s, #0x1
  917734: f0002561     	adrp	x1, 0xdc6000
  917738: 91086021     	add	x1, x1, #0x218
  91773c: aa0003f6     	mov	x22, x0
  917740: fd000400     	str	d0, [x0, #0x8]
  917744: f8010401     	str	x1, [x0], #0x10
  917748: 940040a4     	bl	0x9279d8
  91774c: f94002c2     	ldr	x2, [x22]
  917750: aa1403e1     	mov	x1, x20
  917754: aa1603e0     	mov	x0, x22
  917758: f9401042     	ldr	x2, [x2, #0x20]
  91775c: d63f0040     	blr	x2
  917760: a9075be0     	stp	x0, x22, [sp, #0x70]
  917764: a9408b01     	ldp	x1, x2, [x24, #0x8]
  917768: eb02003f     	cmp	x1, x2
  91776c: 54008120     	b.eq	0x918790
  917770: a9007c20     	stp	x0, xzr, [x1]
  917774: 91004022     	add	x2, x1, #0x10
  917778: f9403fe0     	ldr	x0, [sp, #0x78]
  91777c: f9003fff     	str	xzr, [sp, #0x78]
  917780: f9000420     	str	x0, [x1, #0x8]
  917784: f9000702     	str	x2, [x24, #0x8]
  917788: f9003bff     	str	xzr, [sp, #0x70]
  91778c: f9403ff6     	ldr	x22, [sp, #0x78]
  917790: b4ffcdd6     	cbz	x22, 0x917148
  917794: f0002560     	adrp	x0, 0xdc6000
  917798: f941a01b     	ldr	x27, [x0, #0x340]
  91779c: b40072fb     	cbz	x27, 0x9185f8
  9177a0: 910022c1     	add	x1, x22, #0x8
  9177a4: 885ffc20     	ldaxr	w0, [x1]
  9177a8: 51000402     	sub	w2, w0, #0x1
  9177ac: 8803fc22     	stlxr	w3, w2, [x1]
  9177b0: 35ffffa3     	cbnz	w3, 0x9177a4
  9177b4: 7100041f     	cmp	w0, #0x1
  9177b8: 54ffcc81     	b.ne	0x917148
  9177bc: f94002c1     	ldr	x1, [x22]
  9177c0: aa1603e0     	mov	x0, x22
  9177c4: f9400821     	ldr	x1, [x1, #0x10]
  9177c8: d63f0020     	blr	x1
  9177cc: b4007cbb     	cbz	x27, 0x918760
  9177d0: 910032c1     	add	x1, x22, #0xc
  9177d4: 885ffc20     	ldaxr	w0, [x1]
  9177d8: 51000402     	sub	w2, w0, #0x1
  9177dc: 8803fc22     	stlxr	w3, w2, [x1]
  9177e0: 34000623     	cbz	w3, 0x9178a4
  9177e4: 17fffffc     	b	0x9177d4
  9177e8: d2802000     	mov	x0, #0x100              // =256
  9177ec: 97ebc99d     	bl	0x409e60
  9177f0: 0f000420     	movi	v0.2s, #0x1
  9177f4: f0002561     	adrp	x1, 0xdc6000
  9177f8: 91024021     	add	x1, x1, #0x90
  9177fc: aa0003f6     	mov	x22, x0
  917800: fd000400     	str	d0, [x0, #0x8]
  917804: f8010401     	str	x1, [x0], #0x10
  917808: 94019682     	bl	0x97d210
  91780c: f94002c2     	ldr	x2, [x22]
  917810: aa1403e1     	mov	x1, x20
  917814: aa1603e0     	mov	x0, x22
  917818: f9401042     	ldr	x2, [x2, #0x20]
  91781c: d63f0040     	blr	x2
  917820: a9075be0     	stp	x0, x22, [sp, #0x70]
  917824: a9408b01     	ldp	x1, x2, [x24, #0x8]
  917828: eb02003f     	cmp	x1, x2
  91782c: 54006a40     	b.eq	0x918574
  917830: a9007c20     	stp	x0, xzr, [x1]
  917834: 91004022     	add	x2, x1, #0x10
  917838: f9403fe0     	ldr	x0, [sp, #0x78]
  91783c: f9003fff     	str	xzr, [sp, #0x78]
  917840: f9000420     	str	x0, [x1, #0x8]
  917844: f9000702     	str	x2, [x24, #0x8]
  917848: f9003bff     	str	xzr, [sp, #0x70]
  91784c: f9403ff6     	ldr	x22, [sp, #0x78]
  917850: b4ffc7d6     	cbz	x22, 0x917148
  917854: f0002560     	adrp	x0, 0xdc6000
  917858: f941a01b     	ldr	x27, [x0, #0x340]
  91785c: b400619b     	cbz	x27, 0x91848c
  917860: 910022c1     	add	x1, x22, #0x8
  917864: 885ffc20     	ldaxr	w0, [x1]
  917868: 51000402     	sub	w2, w0, #0x1
  91786c: 8803fc22     	stlxr	w3, w2, [x1]
  917870: 35ffffa3     	cbnz	w3, 0x917864
  917874: 7100041f     	cmp	w0, #0x1
  917878: 54ffc681     	b.ne	0x917148
  91787c: f94002c1     	ldr	x1, [x22]
  917880: aa1603e0     	mov	x0, x22
  917884: f9400821     	ldr	x1, [x1, #0x10]
  917888: d63f0020     	blr	x1
  91788c: b40076bb     	cbz	x27, 0x918760
  917890: 910032c1     	add	x1, x22, #0xc
  917894: 885ffc20     	ldaxr	w0, [x1]
  917898: 51000402     	sub	w2, w0, #0x1
  91789c: 8803fc22     	stlxr	w3, w2, [x1]
  9178a0: 35ffffa3     	cbnz	w3, 0x917894
  9178a4: 7100041f     	cmp	w0, #0x1
  9178a8: 54ffc501     	b.ne	0x917148
  9178ac: f94002c1     	ldr	x1, [x22]
  9178b0: aa1603e0     	mov	x0, x22
  9178b4: f9400c21     	ldr	x1, [x1, #0x18]
  9178b8: d63f0020     	blr	x1
  9178bc: 17fffe23     	b	0x917148
  9178c0: b9400aa0     	ldr	w0, [x21, #0x8]
  9178c4: 51000401     	sub	w1, w0, #0x1
  9178c8: b9000aa1     	str	w1, [x21, #0x8]
  9178cc: 7100041f     	cmp	w0, #0x1
  9178d0: 54ffcf81     	b.ne	0x9172c0
  9178d4: f94002a1     	ldr	x1, [x21]
  9178d8: aa1503e0     	mov	x0, x21
  9178dc: f9400821     	ldr	x1, [x1, #0x10]
  9178e0: d63f0020     	blr	x1
  9178e4: b4000f1b     	cbz	x27, 0x917ac4
  9178e8: 910032a1     	add	x1, x21, #0xc
  9178ec: 885ffc20     	ldaxr	w0, [x1]
  9178f0: 51000402     	sub	w2, w0, #0x1
  9178f4: 8803fc22     	stlxr	w3, w2, [x1]
  9178f8: 35ffffa3     	cbnz	w3, 0x9178ec
  9178fc: 7100041f     	cmp	w0, #0x1
  917900: 54ffce01     	b.ne	0x9172c0
  917904: f94002a1     	ldr	x1, [x21]
  917908: aa1503e0     	mov	x0, x21
  91790c: f9400c21     	ldr	x1, [x1, #0x18]
  917910: d63f0020     	blr	x1
  917914: eb16029f     	cmp	x20, x22
  917918: d1004294     	sub	x20, x20, #0x10
  91791c: 54ffcd81     	b.ne	0x9172cc
  917920: bd400321     	ldr	s1, [x25]
  917924: 1e2c1000     	fmov	s0, #0.50000000
  917928: 1e202030     	fcmpe	s1, s0
  91792c: 540022c9     	b.ls	0x917d84
  917930: f9400662     	ldr	x2, [x19, #0x8]
  917934: f9400a60     	ldr	x0, [x19, #0x10]
  917938: cb020000     	sub	x0, x0, x2
  91793c: 9344fc00     	asr	x0, x0, #4
  917940: 7100041f     	cmp	w0, #0x1
  917944: 54000aad     	b.le	0x917a98
  917948: 9101c3f7     	add	x23, sp, #0x70
  91794c: d2800094     	mov	x20, #0x4               // =4
  917950: 52800036     	mov	w22, #0x1               // =1
  917954: f0002579     	adrp	x25, 0xdc6000
  917958: 14000024     	b	0x9179e8
  91795c: 910022a1     	add	x1, x21, #0x8
  917960: 885ffc22     	ldaxr	w2, [x1]
  917964: 11000442     	add	w2, w2, #0x1
  917968: 8803fc22     	stlxr	w3, w2, [x1]
  91796c: 35ffffa3     	cbnz	w3, 0x917960
  917970: f9400003     	ldr	x3, [x0]
  917974: aa1703e2     	mov	x2, x23
  917978: 9101b3e1     	add	x1, sp, #0x6c
  91797c: f9401c63     	ldr	x3, [x3, #0x38]
  917980: d63f0060     	blr	x3
  917984: f9401e62     	ldr	x2, [x19, #0x38]
  917988: b9406fe0     	ldr	w0, [sp, #0x6c]
  91798c: f9402a61     	ldr	x1, [x19, #0x50]
  917990: 0b1b0000     	add	w0, w0, w27
  917994: b8346840     	str	w0, [x2, x20]
  917998: b94073e0     	ldr	w0, [sp, #0x70]
  91799c: 0b1a0000     	add	w0, w0, w26
  9179a0: b8346820     	str	w0, [x1, x20]
  9179a4: b4000155     	cbz	x21, 0x9179cc
  9179a8: f941a33b     	ldr	x27, [x25, #0x340]
  9179ac: b40003fb     	cbz	x27, 0x917a28
  9179b0: 910022a1     	add	x1, x21, #0x8
  9179b4: 885ffc20     	ldaxr	w0, [x1]
  9179b8: 51000402     	sub	w2, w0, #0x1
  9179bc: 8803fc22     	stlxr	w3, w2, [x1]
  9179c0: 35ffffa3     	cbnz	w3, 0x9179b4
  9179c4: 7100041f     	cmp	w0, #0x1
  9179c8: 540003a0     	b.eq	0x917a3c
  9179cc: a9408262     	ldp	x2, x0, [x19, #0x8]
  9179d0: 110006d6     	add	w22, w22, #0x1
  9179d4: 91001294     	add	x20, x20, #0x4
  9179d8: cb020000     	sub	x0, x0, x2
  9179dc: 9344fc00     	asr	x0, x0, #4
  9179e0: 6b0002df     	cmp	w22, w0
  9179e4: 540005aa     	b.ge	0x917a98
  9179e8: d37ef680     	lsl	x0, x20, #2
  9179ec: d1001281     	sub	x1, x20, #0x4
  9179f0: 8b000043     	add	x3, x2, x0
  9179f4: f9401e64     	ldr	x4, [x19, #0x38]
  9179f8: f9400475     	ldr	x21, [x3, #0x8]
  9179fc: f9402a63     	ldr	x3, [x19, #0x50]
  917a00: b861689b     	ldr	w27, [x4, x1]
  917a04: f8606840     	ldr	x0, [x2, x0]
  917a08: b861687a     	ldr	w26, [x3, x1]
  917a0c: b4fffb35     	cbz	x21, 0x917970
  917a10: f941a321     	ldr	x1, [x25, #0x340]
  917a14: b5fffa41     	cbnz	x1, 0x91795c
  917a18: b9400aa1     	ldr	w1, [x21, #0x8]
  917a1c: 11000421     	add	w1, w1, #0x1
  917a20: b9000aa1     	str	w1, [x21, #0x8]
  917a24: 17ffffd3     	b	0x917970
  917a28: b9400aa0     	ldr	w0, [x21, #0x8]
  917a2c: 51000401     	sub	w1, w0, #0x1
  917a30: b9000aa1     	str	w1, [x21, #0x8]
  917a34: 7100041f     	cmp	w0, #0x1
  917a38: 54fffca1     	b.ne	0x9179cc
  917a3c: f94002a1     	ldr	x1, [x21]
  917a40: aa1503e0     	mov	x0, x21
  917a44: f9400821     	ldr	x1, [x1, #0x10]
  917a48: d63f0020     	blr	x1
  917a4c: b400035b     	cbz	x27, 0x917ab4
  917a50: 910032a1     	add	x1, x21, #0xc
  917a54: 885ffc20     	ldaxr	w0, [x1]
  917a58: 51000402     	sub	w2, w0, #0x1
  917a5c: 8803fc22     	stlxr	w3, w2, [x1]
  917a60: 35ffffa3     	cbnz	w3, 0x917a54
  917a64: 7100041f     	cmp	w0, #0x1
  917a68: 54fffb21     	b.ne	0x9179cc
  917a6c: f94002a1     	ldr	x1, [x21]
  917a70: aa1503e0     	mov	x0, x21
  917a74: 110006d6     	add	w22, w22, #0x1
  917a78: 91001294     	add	x20, x20, #0x4
  917a7c: f9400c21     	ldr	x1, [x1, #0x18]
  917a80: d63f0020     	blr	x1
  917a84: a9408262     	ldp	x2, x0, [x19, #0x8]
  917a88: cb020000     	sub	x0, x0, x2
  917a8c: 9344fc00     	asr	x0, x0, #4
  917a90: 6b0002df     	cmp	w22, w0
  917a94: 54fffaab     	b.lt	0x9179e8
  917a98: a94153f3     	ldp	x19, x20, [sp, #0x10]
  917a9c: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  917aa0: a94363f7     	ldp	x23, x24, [sp, #0x30]
  917aa4: a9446bf9     	ldp	x25, x26, [sp, #0x40]
  917aa8: f9402bfb     	ldr	x27, [sp, #0x50]
  917aac: a8c87bfd     	ldp	x29, x30, [sp], #0x80
  917ab0: d65f03c0     	ret
  917ab4: b9400ea0     	ldr	w0, [x21, #0xc]
  917ab8: 51000401     	sub	w1, w0, #0x1
  917abc: b9000ea1     	str	w1, [x21, #0xc]
  917ac0: 17ffffe9     	b	0x917a64
  917ac4: b9400ea0     	ldr	w0, [x21, #0xc]
  917ac8: 51000401     	sub	w1, w0, #0x1
  917acc: b9000ea1     	str	w1, [x21, #0xc]
  917ad0: 17ffff8b     	b	0x9178fc
  917ad4: 1e260000     	fmov	w0, s0
  917ad8: 0b050085     	add	w5, w4, w5
  917adc: 121f7884     	and	w4, w4, #0xfffffffe
  917ae0: b83468e4     	str	w4, [x7, x20]
  917ae4: 4b0400a5     	sub	w5, w5, w4
  917ae8: 110004a5     	add	w5, w5, #0x1
  917aec: 0b000020     	add	w0, w1, w0
  917af0: 121f7821     	and	w1, w1, #0xfffffffe
  917af4: 4b010000     	sub	w0, w0, w1
  917af8: 121f78a4     	and	w4, w5, #0xfffffffe
  917afc: 11000400     	add	w0, w0, #0x1
  917b00: b9000d04     	str	w4, [x8, #0xc]
  917b04: 121f7800     	and	w0, w0, #0xfffffffe
  917b08: 29008101     	stp	w1, w0, [x8, #0x4]
  917b0c: a9438264     	ldp	x4, x0, [x19, #0x38]
  917b10: cb040001     	sub	x1, x0, x4
  917b14: 9342fc21     	asr	x1, x1, #2
  917b18: eb01007f     	cmp	x3, x1
  917b1c: 54ffb749     	b.ls	0x917204
  917b20: cb010061     	sub	x1, x3, x1
  917b24: aa1a03e0     	mov	x0, x26
  917b28: 9400066c     	bl	0x9194d8
  917b2c: a9409a62     	ldp	x2, x6, [x19, #0x8]
  917b30: a9450e60     	ldp	x0, x3, [x19, #0x50]
  917b34: f9401e64     	ldr	x4, [x19, #0x38]
  917b38: cb0200c6     	sub	x6, x6, x2
  917b3c: cb000061     	sub	x1, x3, x0
  917b40: b900009f     	str	wzr, [x4]
  917b44: 9344fcc6     	asr	x6, x6, #4
  917b48: 9342fc21     	asr	x1, x1, #2
  917b4c: eb0100df     	cmp	x6, x1
  917b50: 54ffb709     	b.ls	0x917230
  917b54: cb0100c1     	sub	x1, x6, x1
  917b58: aa1703e0     	mov	x0, x23
  917b5c: 9400065f     	bl	0x9194d8
  917b60: f9402a60     	ldr	x0, [x19, #0x50]
  917b64: 7100037f     	cmp	w27, #0x0
  917b68: f9400662     	ldr	x2, [x19, #0x8]
  917b6c: b900001f     	str	wzr, [x0]
  917b70: 54ffb70c     	b.gt	0x917250
  917b74: bd400321     	ldr	s1, [x25]
  917b78: 1e2c1000     	fmov	s0, #0.50000000
  917b7c: 1e202030     	fcmpe	s1, s0
  917b80: 54ffeda8     	b.hi	0x917934
  917b84: fd416320     	ldr	d0, [x25, #0x2c0]
  917b88: f900367f     	str	xzr, [x19, #0x68]
  917b8c: fd003a60     	str	d0, [x19, #0x70]
  917b90: 17ffff69     	b	0x917934
  917b94: f0002560     	adrp	x0, 0xdc6000
  917b98: 1e22c000     	fcvt	d0, s0
  917b9c: fd41a401     	ldr	d1, [x0, #0x348]
  917ba0: d2800700     	mov	x0, #0x38               // =56
  917ba4: 1e612010     	fcmpe	d0, d1
  917ba8: 5400228d     	b.le	0x917ff8
  917bac: 97ebc8ad     	bl	0x409e60
  917bb0: 0f000420     	movi	v0.2s, #0x1
  917bb4: d0002561     	adrp	x1, 0xdc5000
  917bb8: 913de021     	add	x1, x1, #0xf78
  917bbc: aa0003f6     	mov	x22, x0
  917bc0: fd000400     	str	d0, [x0, #0x8]
  917bc4: f8010401     	str	x1, [x0], #0x10
  917bc8: 9400122c     	bl	0x91c478
  917bcc: f94002c2     	ldr	x2, [x22]
  917bd0: b0001814     	adrp	x20, 0xc18000
  917bd4: 91154294     	add	x20, x20, #0x550
  917bd8: aa1603e0     	mov	x0, x22
  917bdc: aa1403e1     	mov	x1, x20
  917be0: f9401042     	ldr	x2, [x2, #0x20]
  917be4: d63f0040     	blr	x2
  917be8: a9075be0     	stp	x0, x22, [sp, #0x70]
  917bec: a9408b01     	ldp	x1, x2, [x24, #0x8]
  917bf0: eb02003f     	cmp	x1, x2
  917bf4: 54005960     	b.eq	0x918720
  917bf8: a9007c20     	stp	x0, xzr, [x1]
  917bfc: 91004022     	add	x2, x1, #0x10
  917c00: f9403fe0     	ldr	x0, [sp, #0x78]
  917c04: f9003fff     	str	xzr, [sp, #0x78]
  917c08: f9000420     	str	x0, [x1, #0x8]
  917c0c: f9000702     	str	x2, [x24, #0x8]
  917c10: f9003bff     	str	xzr, [sp, #0x70]
  917c14: f9403ff6     	ldr	x22, [sp, #0x78]
  917c18: b4000396     	cbz	x22, 0x917c88
  917c1c: f0002560     	adrp	x0, 0xdc6000
  917c20: f941a01b     	ldr	x27, [x0, #0x340]
  917c24: b400479b     	cbz	x27, 0x918514
  917c28: 910022c1     	add	x1, x22, #0x8
  917c2c: 885ffc20     	ldaxr	w0, [x1]
  917c30: 51000402     	sub	w2, w0, #0x1
  917c34: 8803fc22     	stlxr	w3, w2, [x1]
  917c38: 35ffffa3     	cbnz	w3, 0x917c2c
  917c3c: 7100041f     	cmp	w0, #0x1
  917c40: 54000241     	b.ne	0x917c88
  917c44: f94002c1     	ldr	x1, [x22]
  917c48: aa1603e0     	mov	x0, x22
  917c4c: f9400821     	ldr	x1, [x1, #0x10]
  917c50: d63f0020     	blr	x1
  917c54: b4005cfb     	cbz	x27, 0x9187f0
  917c58: 910032c1     	add	x1, x22, #0xc
  917c5c: 885ffc20     	ldaxr	w0, [x1]
  917c60: 51000402     	sub	w2, w0, #0x1
  917c64: 8803fc22     	stlxr	w3, w2, [x1]
  917c68: 35ffffa3     	cbnz	w3, 0x917c5c
  917c6c: 7100041f     	cmp	w0, #0x1
  917c70: 540000c1     	b.ne	0x917c88
  917c74: f94002c1     	ldr	x1, [x22]
  917c78: aa1603e0     	mov	x0, x22
  917c7c: f9400c21     	ldr	x1, [x1, #0x18]
  917c80: d63f0020     	blr	x1
  917c84: d503201f     	nop
  917c88: d2800700     	mov	x0, #0x38               // =56
  917c8c: 97ebc875     	bl	0x409e60
  917c90: 0f000420     	movi	v0.2s, #0x1
  917c94: d0002561     	adrp	x1, 0xdc5000
  917c98: 913ec021     	add	x1, x1, #0xfb0
  917c9c: aa0003f6     	mov	x22, x0
  917ca0: fd000400     	str	d0, [x0, #0x8]
  917ca4: f8010401     	str	x1, [x0], #0x10
  917ca8: 94014b0a     	bl	0x96a8d0
  917cac: f94002c2     	ldr	x2, [x22]
  917cb0: aa1403e1     	mov	x1, x20
  917cb4: aa1603e0     	mov	x0, x22
  917cb8: f9401042     	ldr	x2, [x2, #0x20]
  917cbc: d63f0040     	blr	x2
  917cc0: a9075be0     	stp	x0, x22, [sp, #0x70]
  917cc4: a9408b01     	ldp	x1, x2, [x24, #0x8]
  917cc8: eb02003f     	cmp	x1, x2
  917ccc: 54005220     	b.eq	0x918710
  917cd0: a9007c20     	stp	x0, xzr, [x1]
  917cd4: 91004022     	add	x2, x1, #0x10
  917cd8: f9403fe0     	ldr	x0, [sp, #0x78]
  917cdc: f9003fff     	str	xzr, [sp, #0x78]
  917ce0: f9000420     	str	x0, [x1, #0x8]
  917ce4: f9000702     	str	x2, [x24, #0x8]
  917ce8: f9003bff     	str	xzr, [sp, #0x70]
  917cec: f9403ff4     	ldr	x20, [sp, #0x78]
  917cf0: b4ffa314     	cbz	x20, 0x917150
  917cf4: f0002560     	adrp	x0, 0xdc6000
  917cf8: f941a01b     	ldr	x27, [x0, #0x340]
  917cfc: b400405b     	cbz	x27, 0x918504
  917d00: 91002281     	add	x1, x20, #0x8
  917d04: 885ffc20     	ldaxr	w0, [x1]
  917d08: 51000402     	sub	w2, w0, #0x1
  917d0c: 8803fc22     	stlxr	w3, w2, [x1]
  917d10: 35ffffa3     	cbnz	w3, 0x917d04
  917d14: 7100041f     	cmp	w0, #0x1
  917d18: 54ffa1c1     	b.ne	0x917150
  917d1c: f9400281     	ldr	x1, [x20]
  917d20: aa1403e0     	mov	x0, x20
  917d24: f9400821     	ldr	x1, [x1, #0x10]
  917d28: d63f0020     	blr	x1
  917d2c: b400487b     	cbz	x27, 0x918638
  917d30: 91003281     	add	x1, x20, #0xc
  917d34: 885ffc20     	ldaxr	w0, [x1]
  917d38: 51000402     	sub	w2, w0, #0x1
  917d3c: 8803fc22     	stlxr	w3, w2, [x1]
  917d40: 35ffffa3     	cbnz	w3, 0x917d34
  917d44: 7100041f     	cmp	w0, #0x1
  917d48: 54ffa041     	b.ne	0x917150
  917d4c: f9400281     	ldr	x1, [x20]
  917d50: aa1403e0     	mov	x0, x20
  917d54: f9400c21     	ldr	x1, [x1, #0x18]
  917d58: d63f0020     	blr	x1
  917d5c: 17fffcfd     	b	0x917150
  917d60: cb010061     	sub	x1, x3, x1
  917d64: aa1503e0     	mov	x0, x21
  917d68: 9400058c     	bl	0x919398
  917d6c: a9408e62     	ldp	x2, x3, [x19, #0x8]
  917d70: f9401267     	ldr	x7, [x19, #0x20]
  917d74: cb020063     	sub	x3, x3, x2
  917d78: 9344fc63     	asr	x3, x3, #4
  917d7c: aa0303e6     	mov	x6, x3
  917d80: 17fffd02     	b	0x917188
  917d84: f9401260     	ldr	x0, [x19, #0x20]
  917d88: fd416320     	ldr	d0, [x25, #0x2c0]
  917d8c: f900367f     	str	xzr, [x19, #0x68]
  917d90: f9400662     	ldr	x2, [x19, #0x8]
  917d94: fd003a60     	str	d0, [x19, #0x70]
  917d98: f900001f     	str	xzr, [x0]
  917d9c: fd000400     	str	d0, [x0, #0x8]
  917da0: 17fffee5     	b	0x917934
  917da4: d2800700     	mov	x0, #0x38               // =56
  917da8: 97ebc82e     	bl	0x409e60
  917dac: 0f000420     	movi	v0.2s, #0x1
  917db0: f0002561     	adrp	x1, 0xdc6000
  917db4: 91094021     	add	x1, x1, #0x250
  917db8: aa0003f6     	mov	x22, x0
  917dbc: fd000400     	str	d0, [x0, #0x8]
  917dc0: f8010401     	str	x1, [x0], #0x10
  917dc4: 97ffbca9     	bl	0x907068
  917dc8: f94002c2     	ldr	x2, [x22]
  917dcc: aa1403e1     	mov	x1, x20
  917dd0: aa1603e0     	mov	x0, x22
  917dd4: f9401042     	ldr	x2, [x2, #0x20]
  917dd8: d63f0040     	blr	x2
  917ddc: a9075be0     	stp	x0, x22, [sp, #0x70]
  917de0: a9408b01     	ldp	x1, x2, [x24, #0x8]
  917de4: eb02003f     	cmp	x1, x2
  917de8: 54003be0     	b.eq	0x918564
  917dec: a9007c20     	stp	x0, xzr, [x1]
  917df0: 91004022     	add	x2, x1, #0x10
  917df4: f9403fe0     	ldr	x0, [sp, #0x78]
  917df8: f9003fff     	str	xzr, [sp, #0x78]
  917dfc: f9000420     	str	x0, [x1, #0x8]
  917e00: f9000702     	str	x2, [x24, #0x8]
  917e04: f9003bff     	str	xzr, [sp, #0x70]
  917e08: f9403ff6     	ldr	x22, [sp, #0x78]
  917e0c: b4000176     	cbz	x22, 0x917e38
  917e10: f0002560     	adrp	x0, 0xdc6000
  917e14: f941a01b     	ldr	x27, [x0, #0x340]
  917e18: b400343b     	cbz	x27, 0x91849c
  917e1c: 910022c1     	add	x1, x22, #0x8
  917e20: 885ffc20     	ldaxr	w0, [x1]
  917e24: 51000402     	sub	w2, w0, #0x1
  917e28: 8803fc22     	stlxr	w3, w2, [x1]
  917e2c: 35ffffa3     	cbnz	w3, 0x917e20
  917e30: 7100041f     	cmp	w0, #0x1
  917e34: 540042c0     	b.eq	0x91868c
  917e38: f940db20     	ldr	x0, [x25, #0x1b0]
  917e3c: b4000060     	cbz	x0, 0x917e48
  917e40: b941bb20     	ldr	w0, [x25, #0x1b8]
  917e44: 35003340     	cbnz	w0, 0x9184ac
  917e48: b9402720     	ldr	w0, [x25, #0x24]
  917e4c: 7100001f     	cmp	w0, #0x0
  917e50: 5400008c     	b.gt	0x917e60
  917e54: b9402b20     	ldr	w0, [x25, #0x28]
  917e58: 7100001f     	cmp	w0, #0x0
  917e5c: 540006ed     	b.le	0x917f38
  917e60: d2800700     	mov	x0, #0x38               // =56
  917e64: 97ebc7ff     	bl	0x409e60
  917e68: 0f000420     	movi	v0.2s, #0x1
  917e6c: f0002561     	adrp	x1, 0xdc6000
  917e70: 910b0021     	add	x1, x1, #0x2c0
  917e74: aa0003f6     	mov	x22, x0
  917e78: fd000400     	str	d0, [x0, #0x8]
  917e7c: f8010401     	str	x1, [x0], #0x10
  917e80: 94007f3a     	bl	0x937b68
  917e84: f94002c2     	ldr	x2, [x22]
  917e88: aa1403e1     	mov	x1, x20
  917e8c: aa1603e0     	mov	x0, x22
  917e90: f9401042     	ldr	x2, [x2, #0x20]
  917e94: d63f0040     	blr	x2
  917e98: a9075be0     	stp	x0, x22, [sp, #0x70]
  917e9c: a9408b01     	ldp	x1, x2, [x24, #0x8]
  917ea0: eb02003f     	cmp	x1, x2
  917ea4: 54004560     	b.eq	0x918750
  917ea8: a9007c20     	stp	x0, xzr, [x1]
  917eac: 91004022     	add	x2, x1, #0x10
  917eb0: f9403fe0     	ldr	x0, [sp, #0x78]
  917eb4: f9003fff     	str	xzr, [sp, #0x78]
  917eb8: f9000420     	str	x0, [x1, #0x8]
  917ebc: f9000702     	str	x2, [x24, #0x8]
  917ec0: f9003bff     	str	xzr, [sp, #0x70]
  917ec4: f9403ff6     	ldr	x22, [sp, #0x78]
  917ec8: b4000396     	cbz	x22, 0x917f38
  917ecc: f0002560     	adrp	x0, 0xdc6000
  917ed0: f941a01b     	ldr	x27, [x0, #0x340]
  917ed4: b400331b     	cbz	x27, 0x918534
  917ed8: 910022c1     	add	x1, x22, #0x8
  917edc: 885ffc20     	ldaxr	w0, [x1]
  917ee0: 51000402     	sub	w2, w0, #0x1
  917ee4: 8803fc22     	stlxr	w3, w2, [x1]
  917ee8: 35ffffa3     	cbnz	w3, 0x917edc
  917eec: 7100041f     	cmp	w0, #0x1
  917ef0: 54000241     	b.ne	0x917f38
  917ef4: f94002c1     	ldr	x1, [x22]
  917ef8: aa1603e0     	mov	x0, x22
  917efc: f9400821     	ldr	x1, [x1, #0x10]
  917f00: d63f0020     	blr	x1
  917f04: b400487b     	cbz	x27, 0x918810
  917f08: 910032c1     	add	x1, x22, #0xc
  917f0c: 885ffc20     	ldaxr	w0, [x1]
  917f10: 51000402     	sub	w2, w0, #0x1
  917f14: 8803fc22     	stlxr	w3, w2, [x1]
  917f18: 35ffffa3     	cbnz	w3, 0x917f0c
  917f1c: 7100041f     	cmp	w0, #0x1
  917f20: 540000c1     	b.ne	0x917f38
  917f24: f94002c1     	ldr	x1, [x22]
  917f28: aa1603e0     	mov	x0, x22
  917f2c: f9400c21     	ldr	x1, [x1, #0x18]
  917f30: d63f0020     	blr	x1
  917f34: d503201f     	nop
  917f38: d2800700     	mov	x0, #0x38               // =56
  917f3c: 97ebc7c9     	bl	0x409e60
  917f40: 0f000420     	movi	v0.2s, #0x1
  917f44: f0002561     	adrp	x1, 0xdc6000
  917f48: 910be021     	add	x1, x1, #0x2f8
  917f4c: aa0003f6     	mov	x22, x0
  917f50: fd000400     	str	d0, [x0, #0x8]
  917f54: f8010401     	str	x1, [x0], #0x10
  917f58: 97ffc57c     	bl	0x909548
  917f5c: f94002c2     	ldr	x2, [x22]
  917f60: aa1403e1     	mov	x1, x20
  917f64: aa1603e0     	mov	x0, x22
  917f68: f9401042     	ldr	x2, [x2, #0x20]
  917f6c: d63f0040     	blr	x2
  917f70: a9075be0     	stp	x0, x22, [sp, #0x70]
  917f74: a9408b01     	ldp	x1, x2, [x24, #0x8]
  917f78: eb02003f     	cmp	x1, x2
  917f7c: 54003b20     	b.eq	0x9186e0
  917f80: a9007c20     	stp	x0, xzr, [x1]
  917f84: 91004022     	add	x2, x1, #0x10
  917f88: f9403fe0     	ldr	x0, [sp, #0x78]
  917f8c: f9003fff     	str	xzr, [sp, #0x78]
  917f90: f9000420     	str	x0, [x1, #0x8]
  917f94: f9000702     	str	x2, [x24, #0x8]
  917f98: f9003bff     	str	xzr, [sp, #0x70]
  917f9c: f9403ff4     	ldr	x20, [sp, #0x78]
  917fa0: b4ff8d94     	cbz	x20, 0x917150
  917fa4: f0002560     	adrp	x0, 0xdc6000
  917fa8: f941a01b     	ldr	x27, [x0, #0x340]
  917fac: b400269b     	cbz	x27, 0x91847c
  917fb0: 91002281     	add	x1, x20, #0x8
  917fb4: 885ffc20     	ldaxr	w0, [x1]
  917fb8: 51000402     	sub	w2, w0, #0x1
  917fbc: 8803fc22     	stlxr	w3, w2, [x1]
  917fc0: 35ffffa3     	cbnz	w3, 0x917fb4
  917fc4: 7100041f     	cmp	w0, #0x1
  917fc8: 54ff8c41     	b.ne	0x917150
  917fcc: f9400281     	ldr	x1, [x20]
  917fd0: aa1403e0     	mov	x0, x20
  917fd4: f9400821     	ldr	x1, [x1, #0x10]
  917fd8: d63f0020     	blr	x1
  917fdc: b40032fb     	cbz	x27, 0x918638
  917fe0: 91003281     	add	x1, x20, #0xc
  917fe4: 885ffc20     	ldaxr	w0, [x1]
  917fe8: 51000402     	sub	w2, w0, #0x1
  917fec: 8803fc22     	stlxr	w3, w2, [x1]
  917ff0: 34ffeaa3     	cbz	w3, 0x917d44
  917ff4: 17fffffc     	b	0x917fe4
  917ff8: 97ebc79a     	bl	0x409e60
  917ffc: 0f000420     	movi	v0.2s, #0x1
  918000: b0002561     	adrp	x1, 0xdc5000
  918004: 913fa021     	add	x1, x1, #0xfe8
  918008: aa0003f6     	mov	x22, x0
  91800c: fd000400     	str	d0, [x0, #0x8]
  918010: f8010401     	str	x1, [x0], #0x10
  918014: 9401510f     	bl	0x96c450
  918018: f94002c2     	ldr	x2, [x22]
  91801c: 90001801     	adrp	x1, 0xc18000
  918020: aa1603e0     	mov	x0, x22
  918024: 91154021     	add	x1, x1, #0x550
  918028: f9401042     	ldr	x2, [x2, #0x20]
  91802c: d63f0040     	blr	x2
  918030: a9075be0     	stp	x0, x22, [sp, #0x70]
  918034: a9408b01     	ldp	x1, x2, [x24, #0x8]
  918038: eb02003f     	cmp	x1, x2
  91803c: 54003620     	b.eq	0x918700
  918040: a9007c20     	stp	x0, xzr, [x1]
  918044: 91004022     	add	x2, x1, #0x10
  918048: f9403fe0     	ldr	x0, [sp, #0x78]
  91804c: f9003fff     	str	xzr, [sp, #0x78]
  918050: f9000420     	str	x0, [x1, #0x8]
  918054: f9000702     	str	x2, [x24, #0x8]
  918058: f9003bff     	str	xzr, [sp, #0x70]
  91805c: f9403ff4     	ldr	x20, [sp, #0x78]
  918060: b4ff8794     	cbz	x20, 0x917150
  918064: d0002560     	adrp	x0, 0xdc6000
  918068: f941a01b     	ldr	x27, [x0, #0x340]
  91806c: b40025db     	cbz	x27, 0x918524
  918070: 91002281     	add	x1, x20, #0x8
  918074: 885ffc20     	ldaxr	w0, [x1]
  918078: 51000402     	sub	w2, w0, #0x1
  91807c: 8803fc22     	stlxr	w3, w2, [x1]
  918080: 35ffffa3     	cbnz	w3, 0x918074
  918084: 7100041f     	cmp	w0, #0x1
  918088: 54ff8641     	b.ne	0x917150
  91808c: f9400281     	ldr	x1, [x20]
  918090: aa1403e0     	mov	x0, x20
  918094: f9400821     	ldr	x1, [x1, #0x10]
  918098: d63f0020     	blr	x1
  91809c: b4002cfb     	cbz	x27, 0x918638
  9180a0: 91003281     	add	x1, x20, #0xc
  9180a4: 885ffc20     	ldaxr	w0, [x1]
  9180a8: 51000402     	sub	w2, w0, #0x1
  9180ac: 8803fc22     	stlxr	w3, w2, [x1]
  9180b0: 34ffe4a3     	cbz	w3, 0x917d44
  9180b4: 17fffffc     	b	0x9180a4
  9180b8: d2800900     	mov	x0, #0x48               // =72
  9180bc: 97ebc769     	bl	0x409e60
  9180c0: 0f000420     	movi	v0.2s, #0x1
  9180c4: d0002561     	adrp	x1, 0xdc6000
  9180c8: 9106a021     	add	x1, x1, #0x1a8
  9180cc: aa0003f6     	mov	x22, x0
  9180d0: fd000400     	str	d0, [x0, #0x8]
  9180d4: f8010401     	str	x1, [x0], #0x10
  9180d8: 94002f24     	bl	0x923d68
  9180dc: f94002c2     	ldr	x2, [x22]
  9180e0: aa1403e1     	mov	x1, x20
  9180e4: aa1603e0     	mov	x0, x22
  9180e8: f9401042     	ldr	x2, [x2, #0x20]
  9180ec: d63f0040     	blr	x2
  9180f0: a9075be0     	stp	x0, x22, [sp, #0x70]
  9180f4: a9408b01     	ldp	x1, x2, [x24, #0x8]
  9180f8: eb02003f     	cmp	x1, x2
  9180fc: 54003220     	b.eq	0x918740
  918100: a9007c20     	stp	x0, xzr, [x1]
  918104: 91004022     	add	x2, x1, #0x10
  918108: f9403fe0     	ldr	x0, [sp, #0x78]
  91810c: f9003fff     	str	xzr, [sp, #0x78]
  918110: f9000420     	str	x0, [x1, #0x8]
  918114: f9000702     	str	x2, [x24, #0x8]
  918118: f9003bff     	str	xzr, [sp, #0x70]
  91811c: f9403ff6     	ldr	x22, [sp, #0x78]
  918120: b4000396     	cbz	x22, 0x918190
  918124: d0002560     	adrp	x0, 0xdc6000
  918128: f941a01b     	ldr	x27, [x0, #0x340]
  91812c: b400215b     	cbz	x27, 0x918554
  918130: 910022c1     	add	x1, x22, #0x8
  918134: 885ffc20     	ldaxr	w0, [x1]
  918138: 51000402     	sub	w2, w0, #0x1
  91813c: 8803fc22     	stlxr	w3, w2, [x1]
  918140: 35ffffa3     	cbnz	w3, 0x918134
  918144: 7100041f     	cmp	w0, #0x1
  918148: 54000241     	b.ne	0x918190
  91814c: f94002c1     	ldr	x1, [x22]
  918150: aa1603e0     	mov	x0, x22
  918154: f9400821     	ldr	x1, [x1, #0x10]
  918158: d63f0020     	blr	x1
  91815c: b400353b     	cbz	x27, 0x918800
  918160: 910032c1     	add	x1, x22, #0xc
  918164: 885ffc20     	ldaxr	w0, [x1]
  918168: 51000402     	sub	w2, w0, #0x1
  91816c: 8803fc22     	stlxr	w3, w2, [x1]
  918170: 35ffffa3     	cbnz	w3, 0x918164
  918174: 7100041f     	cmp	w0, #0x1
  918178: 540000c1     	b.ne	0x918190
  91817c: f94002c1     	ldr	x1, [x22]
  918180: aa1603e0     	mov	x0, x22
  918184: f9400c21     	ldr	x1, [x1, #0x18]
  918188: d63f0020     	blr	x1
  91818c: d503201f     	nop
  918190: b9418b20     	ldr	w0, [x25, #0x188]
  918194: 7100001f     	cmp	w0, #0x0
  918198: 54ffa50d     	b.le	0x917638
  91819c: d2800800     	mov	x0, #0x40               // =64
  9181a0: 97ebc730     	bl	0x409e60
  9181a4: 0f000420     	movi	v0.2s, #0x1
  9181a8: d0002561     	adrp	x1, 0xdc6000
  9181ac: 91078021     	add	x1, x1, #0x1e0
  9181b0: aa0003f6     	mov	x22, x0
  9181b4: fd000400     	str	d0, [x0, #0x8]
  9181b8: f8010401     	str	x1, [x0], #0x10
  9181bc: 9400867f     	bl	0x939bb8
  9181c0: f94002c2     	ldr	x2, [x22]
  9181c4: aa1403e1     	mov	x1, x20
  9181c8: aa1603e0     	mov	x0, x22
  9181cc: f9401042     	ldr	x2, [x2, #0x20]
  9181d0: d63f0040     	blr	x2
  9181d4: a9075be0     	stp	x0, x22, [sp, #0x70]
  9181d8: a9408b01     	ldp	x1, x2, [x24, #0x8]
  9181dc: eb02003f     	cmp	x1, x2
  9181e0: 54003200     	b.eq	0x918820
  9181e4: a9007c20     	stp	x0, xzr, [x1]
  9181e8: 91004022     	add	x2, x1, #0x10
  9181ec: f9403fe0     	ldr	x0, [sp, #0x78]
  9181f0: f9003fff     	str	xzr, [sp, #0x78]
  9181f4: f9000420     	str	x0, [x1, #0x8]
  9181f8: f9000702     	str	x2, [x24, #0x8]
  9181fc: f9003bff     	str	xzr, [sp, #0x70]
  918200: f9403ff6     	ldr	x22, [sp, #0x78]
  918204: b4ffa1b6     	cbz	x22, 0x917638
  918208: d0002560     	adrp	x0, 0xdc6000
  91820c: f941a01b     	ldr	x27, [x0, #0x340]
  918210: b4002e1b     	cbz	x27, 0x9187d0
  918214: 910022c1     	add	x1, x22, #0x8
  918218: 885ffc20     	ldaxr	w0, [x1]
  91821c: 51000402     	sub	w2, w0, #0x1
  918220: 8803fc22     	stlxr	w3, w2, [x1]
  918224: 35ffffa3     	cbnz	w3, 0x918218
  918228: 7100041f     	cmp	w0, #0x1
  91822c: 54ffa061     	b.ne	0x917638
  918230: f94002c1     	ldr	x1, [x22]
  918234: aa1603e0     	mov	x0, x22
  918238: f9400821     	ldr	x1, [x1, #0x10]
  91823c: d63f0020     	blr	x1
  918240: b400299b     	cbz	x27, 0x918770
  918244: 910032c1     	add	x1, x22, #0xc
  918248: 885ffc20     	ldaxr	w0, [x1]
  91824c: 51000402     	sub	w2, w0, #0x1
  918250: 8803fc22     	stlxr	w3, w2, [x1]
  918254: 34ff9e43     	cbz	w3, 0x91761c
  918258: 17fffffc     	b	0x918248
  91825c: d2800a00     	mov	x0, #0x50               // =80
  918260: 97ebc700     	bl	0x409e60
  918264: 0f000420     	movi	v0.2s, #0x1
  918268: d0002561     	adrp	x1, 0xdc6000
  91826c: 91016021     	add	x1, x1, #0x58
  918270: aa0003f6     	mov	x22, x0
  918274: fd000400     	str	d0, [x0, #0x8]
  918278: f8010401     	str	x1, [x0], #0x10
  91827c: 9401c2d5     	bl	0x988dd0
  918280: f94002c2     	ldr	x2, [x22]
  918284: aa1403e1     	mov	x1, x20
  918288: aa1603e0     	mov	x0, x22
  91828c: f9401042     	ldr	x2, [x2, #0x20]
  918290: d63f0040     	blr	x2
  918294: a9075be0     	stp	x0, x22, [sp, #0x70]
  918298: a9408b01     	ldp	x1, x2, [x24, #0x8]
  91829c: eb02003f     	cmp	x1, x2
  9182a0: 54002800     	b.eq	0x9187a0
  9182a4: a9007c20     	stp	x0, xzr, [x1]
  9182a8: 91004022     	add	x2, x1, #0x10
  9182ac: f9403fe0     	ldr	x0, [sp, #0x78]
  9182b0: f9003fff     	str	xzr, [sp, #0x78]
  9182b4: f9000420     	str	x0, [x1, #0x8]
  9182b8: f9000702     	str	x2, [x24, #0x8]
  9182bc: f9003bff     	str	xzr, [sp, #0x70]
  9182c0: f9403ff6     	ldr	x22, [sp, #0x78]
  9182c4: b4ff7316     	cbz	x22, 0x917124
  9182c8: d0002560     	adrp	x0, 0xdc6000
  9182cc: f941a01b     	ldr	x27, [x0, #0x340]
  9182d0: b4001a5b     	cbz	x27, 0x918618
  9182d4: 910022c1     	add	x1, x22, #0x8
  9182d8: 885ffc20     	ldaxr	w0, [x1]
  9182dc: 51000402     	sub	w2, w0, #0x1
  9182e0: 8803fc22     	stlxr	w3, w2, [x1]
  9182e4: 35ffffa3     	cbnz	w3, 0x9182d8
  9182e8: 7100041f     	cmp	w0, #0x1
  9182ec: 54ff71c1     	b.ne	0x917124
  9182f0: f94002c1     	ldr	x1, [x22]
  9182f4: aa1603e0     	mov	x0, x22
  9182f8: f9400821     	ldr	x1, [x1, #0x10]
  9182fc: d63f0020     	blr	x1
  918300: b400299b     	cbz	x27, 0x918830
  918304: 910032c1     	add	x1, x22, #0xc
  918308: 885ffc20     	ldaxr	w0, [x1]
  91830c: 51000402     	sub	w2, w0, #0x1
  918310: 8803fc22     	stlxr	w3, w2, [x1]
  918314: 35ffffa3     	cbnz	w3, 0x918308
  918318: 7100041f     	cmp	w0, #0x1
  91831c: 54ff7041     	b.ne	0x917124
  918320: f94002c1     	ldr	x1, [x22]
  918324: aa1603e0     	mov	x0, x22
  918328: f9400c21     	ldr	x1, [x1, #0x18]
  91832c: d63f0020     	blr	x1
  918330: 17fffb7d     	b	0x917124
  918334: d2800a00     	mov	x0, #0x50               // =80
  918338: 97ebc6ca     	bl	0x409e60
  91833c: 0f000420     	movi	v0.2s, #0x1
  918340: d0002561     	adrp	x1, 0xdc6000
  918344: 91016021     	add	x1, x1, #0x58
  918348: aa0003f6     	mov	x22, x0
  91834c: fd000400     	str	d0, [x0, #0x8]
  918350: f8010401     	str	x1, [x0], #0x10
  918354: 9401c29f     	bl	0x988dd0
  918358: f94002c2     	ldr	x2, [x22]
  91835c: aa1403e1     	mov	x1, x20
  918360: aa1603e0     	mov	x0, x22
  918364: f9401042     	ldr	x2, [x2, #0x20]
  918368: d63f0040     	blr	x2
  91836c: a9075be0     	stp	x0, x22, [sp, #0x70]
  918370: a9408b01     	ldp	x1, x2, [x24, #0x8]
  918374: eb02003f     	cmp	x1, x2
  918378: 54002040     	b.eq	0x918780
  91837c: a9007c20     	stp	x0, xzr, [x1]
  918380: 91004022     	add	x2, x1, #0x10
  918384: f9403fe0     	ldr	x0, [sp, #0x78]
  918388: f9003fff     	str	xzr, [sp, #0x78]
  91838c: f9000420     	str	x0, [x1, #0x8]
  918390: f9000702     	str	x2, [x24, #0x8]
  918394: f9003bff     	str	xzr, [sp, #0x70]
  918398: f9403ff6     	ldr	x22, [sp, #0x78]
  91839c: b4ff95d6     	cbz	x22, 0x917654
  9183a0: d0002560     	adrp	x0, 0xdc6000
  9183a4: f941a01b     	ldr	x27, [x0, #0x340]
  9183a8: b400131b     	cbz	x27, 0x918608
  9183ac: 910022c1     	add	x1, x22, #0x8
  9183b0: 885ffc20     	ldaxr	w0, [x1]
  9183b4: 51000402     	sub	w2, w0, #0x1
  9183b8: 8803fc22     	stlxr	w3, w2, [x1]
  9183bc: 35ffffa3     	cbnz	w3, 0x9183b0
  9183c0: 7100041f     	cmp	w0, #0x1
  9183c4: 54ff9481     	b.ne	0x917654
  9183c8: f94002c1     	ldr	x1, [x22]
  9183cc: aa1603e0     	mov	x0, x22
  9183d0: f9400821     	ldr	x1, [x1, #0x10]
  9183d4: d63f0020     	blr	x1
  9183d8: b400235b     	cbz	x27, 0x918840
  9183dc: 910032c1     	add	x1, x22, #0xc
  9183e0: 885ffc20     	ldaxr	w0, [x1]
  9183e4: 51000402     	sub	w2, w0, #0x1
  9183e8: 8803fc22     	stlxr	w3, w2, [x1]
  9183ec: 35ffffa3     	cbnz	w3, 0x9183e0
  9183f0: 7100041f     	cmp	w0, #0x1
  9183f4: 54ff9301     	b.ne	0x917654
  9183f8: f94002c1     	ldr	x1, [x22]
  9183fc: aa1603e0     	mov	x0, x22
  918400: f9400c21     	ldr	x1, [x1, #0x18]
  918404: d63f0020     	blr	x1
  918408: 17fffc93     	b	0x917654
  91840c: b9400ac0     	ldr	w0, [x22, #0x8]
  918410: 51000401     	sub	w1, w0, #0x1
  918414: b9000ac1     	str	w1, [x22, #0x8]
  918418: 17fffc3d     	b	0x91750c
  91841c: b9400ac0     	ldr	w0, [x22, #0x8]
  918420: 51000401     	sub	w1, w0, #0x1
  918424: b9000ac1     	str	w1, [x22, #0x8]
  918428: 17fffb26     	b	0x9170c0
  91842c: b9400ac0     	ldr	w0, [x22, #0x8]
  918430: 51000401     	sub	w1, w0, #0x1
  918434: b9000ac1     	str	w1, [x22, #0x8]
  918438: 17fffbd8     	b	0x917398
  91843c: 9101c3e2     	add	x2, sp, #0x70
  918440: aa1803e0     	mov	x0, x24
  918444: 9400046b     	bl	0x9195f0
  918448: 17fffbca     	b	0x917370
  91844c: 9101c3e2     	add	x2, sp, #0x70
  918450: aa1803e0     	mov	x0, x24
  918454: 94000467     	bl	0x9195f0
  918458: 17fffc23     	b	0x9174e4
  91845c: 9101c3e2     	add	x2, sp, #0x70
  918460: aa1803e0     	mov	x0, x24
  918464: 94000463     	bl	0x9195f0
  918468: 17fffb0c     	b	0x917098
  91846c: b9400ac0     	ldr	w0, [x22, #0x8]
  918470: 51000401     	sub	w1, w0, #0x1
  918474: b9000ac1     	str	w1, [x22, #0x8]
  918478: 17fffca3     	b	0x917704
  91847c: b9400a80     	ldr	w0, [x20, #0x8]
  918480: 51000401     	sub	w1, w0, #0x1
  918484: b9000a81     	str	w1, [x20, #0x8]
  918488: 17fffecf     	b	0x917fc4
  91848c: b9400ac0     	ldr	w0, [x22, #0x8]
  918490: 51000401     	sub	w1, w0, #0x1
  918494: b9000ac1     	str	w1, [x22, #0x8]
  918498: 17fffcf7     	b	0x917874
  91849c: b9400ac0     	ldr	w0, [x22, #0x8]
  9184a0: 51000401     	sub	w1, w0, #0x1
  9184a4: b9000ac1     	str	w1, [x22, #0x8]
  9184a8: 17fffe62     	b	0x917e30
  9184ac: d2800700     	mov	x0, #0x38               // =56
  9184b0: 97ebc66c     	bl	0x409e60
  9184b4: 0f000420     	movi	v0.2s, #0x1
  9184b8: d0002561     	adrp	x1, 0xdc6000
  9184bc: 910a2021     	add	x1, x1, #0x288
  9184c0: aa0003f6     	mov	x22, x0
  9184c4: fd000400     	str	d0, [x0, #0x8]
  9184c8: f8010401     	str	x1, [x0], #0x10
  9184cc: 94000b7d     	bl	0x91b2c0
  9184d0: f94002c2     	ldr	x2, [x22]
  9184d4: aa1403e1     	mov	x1, x20
  9184d8: aa1603e0     	mov	x0, x22
  9184dc: f9401042     	ldr	x2, [x2, #0x20]
  9184e0: d63f0040     	blr	x2
  9184e4: a9075be0     	stp	x0, x22, [sp, #0x70]
  9184e8: 9101c3e1     	add	x1, sp, #0x70
  9184ec: aa1803e0     	mov	x0, x24
  9184f0: 940004d8     	bl	0x919850
  9184f4: f9403fe0     	ldr	x0, [sp, #0x78]
  9184f8: b4ffca80     	cbz	x0, 0x917e48
  9184fc: 97f6c3b0     	bl	0x6c93bc
  918500: 17fffe52     	b	0x917e48
  918504: b9400a80     	ldr	w0, [x20, #0x8]
  918508: 51000401     	sub	w1, w0, #0x1
  91850c: b9000a81     	str	w1, [x20, #0x8]
  918510: 17fffe01     	b	0x917d14
  918514: b9400ac0     	ldr	w0, [x22, #0x8]
  918518: 51000401     	sub	w1, w0, #0x1
  91851c: b9000ac1     	str	w1, [x22, #0x8]
  918520: 17fffdc7     	b	0x917c3c
  918524: b9400a80     	ldr	w0, [x20, #0x8]
  918528: 51000401     	sub	w1, w0, #0x1
  91852c: b9000a81     	str	w1, [x20, #0x8]
  918530: 17fffed5     	b	0x918084
  918534: b9400ac0     	ldr	w0, [x22, #0x8]
  918538: 51000401     	sub	w1, w0, #0x1
  91853c: b9000ac1     	str	w1, [x22, #0x8]
  918540: 17fffe6b     	b	0x917eec
  918544: b9400ac0     	ldr	w0, [x22, #0x8]
  918548: 51000401     	sub	w1, w0, #0x1
  91854c: b9000ac1     	str	w1, [x22, #0x8]
  918550: 17fffc27     	b	0x9175ec
  918554: b9400ac0     	ldr	w0, [x22, #0x8]
  918558: 51000401     	sub	w1, w0, #0x1
  91855c: b9000ac1     	str	w1, [x22, #0x8]
  918560: 17fffef9     	b	0x918144
  918564: 9101c3e2     	add	x2, sp, #0x70
  918568: aa1803e0     	mov	x0, x24
  91856c: 94000421     	bl	0x9195f0
  918570: 17fffe26     	b	0x917e08
  918574: 9101c3e2     	add	x2, sp, #0x70
  918578: aa1803e0     	mov	x0, x24
  91857c: 9400041d     	bl	0x9195f0
  918580: 17fffcb3     	b	0x91784c
  918584: f94002c1     	ldr	x1, [x22]
  918588: aa1603e0     	mov	x0, x22
  91858c: f9400821     	ldr	x1, [x1, #0x10]
  918590: d63f0020     	blr	x1
  918594: b400127b     	cbz	x27, 0x9187e0
  918598: 910032c1     	add	x1, x22, #0xc
  91859c: 885ffc20     	ldaxr	w0, [x1]
  9185a0: 51000402     	sub	w2, w0, #0x1
  9185a4: 8803fc22     	stlxr	w3, w2, [x1]
  9185a8: 35ffffa3     	cbnz	w3, 0x91859c
  9185ac: 7100041f     	cmp	w0, #0x1
  9185b0: 54ff7681     	b.ne	0x917480
  9185b4: f94002c1     	ldr	x1, [x22]
  9185b8: aa1603e0     	mov	x0, x22
  9185bc: f9400c21     	ldr	x1, [x1, #0x18]
  9185c0: d63f0020     	blr	x1
  9185c4: 17fffbaf     	b	0x917480
  9185c8: b9400ec0     	ldr	w0, [x22, #0xc]
  9185cc: 51000401     	sub	w1, w0, #0x1
  9185d0: b9000ec1     	str	w1, [x22, #0xc]
  9185d4: 17fffbda     	b	0x91753c
  9185d8: b9400ec0     	ldr	w0, [x22, #0xc]
  9185dc: 51000401     	sub	w1, w0, #0x1
  9185e0: b9000ec1     	str	w1, [x22, #0xc]
  9185e4: 17fffb79     	b	0x9173c8
  9185e8: b9400ec0     	ldr	w0, [x22, #0xc]
  9185ec: 51000401     	sub	w1, w0, #0x1
  9185f0: b9000ec1     	str	w1, [x22, #0xc]
  9185f4: 17fffabf     	b	0x9170f0
  9185f8: b9400ac0     	ldr	w0, [x22, #0x8]
  9185fc: 51000401     	sub	w1, w0, #0x1
  918600: b9000ac1     	str	w1, [x22, #0x8]
  918604: 17fffc6c     	b	0x9177b4
  918608: b9400ac0     	ldr	w0, [x22, #0x8]
  91860c: 51000401     	sub	w1, w0, #0x1
  918610: b9000ac1     	str	w1, [x22, #0x8]
  918614: 17ffff6b     	b	0x9183c0
  918618: b9400ac0     	ldr	w0, [x22, #0x8]
  91861c: 51000401     	sub	w1, w0, #0x1
  918620: b9000ac1     	str	w1, [x22, #0x8]
  918624: 17ffff31     	b	0x9182e8
  918628: b9400ac0     	ldr	w0, [x22, #0x8]
  91862c: 51000401     	sub	w1, w0, #0x1
  918630: b9000ac1     	str	w1, [x22, #0x8]
  918634: 17fffb91     	b	0x917478
  918638: b9400e80     	ldr	w0, [x20, #0xc]
  91863c: 51000401     	sub	w1, w0, #0x1
  918640: b9000e81     	str	w1, [x20, #0xc]
  918644: 17fffdc0     	b	0x917d44
  918648: f94002c1     	ldr	x1, [x22]
  91864c: aa1603e0     	mov	x0, x22
  918650: f9400821     	ldr	x1, [x1, #0x10]
  918654: d63f0020     	blr	x1
  918658: b4000b5b     	cbz	x27, 0x9187c0
  91865c: 910032c1     	add	x1, x22, #0xc
  918660: 885ffc20     	ldaxr	w0, [x1]
  918664: 51000402     	sub	w2, w0, #0x1
  918668: 8803fc22     	stlxr	w3, w2, [x1]
  91866c: 35ffffa3     	cbnz	w3, 0x918660
  918670: 7100041f     	cmp	w0, #0x1
  918674: 54ff84c1     	b.ne	0x91770c
  918678: f94002c1     	ldr	x1, [x22]
  91867c: aa1603e0     	mov	x0, x22
  918680: f9400c21     	ldr	x1, [x1, #0x18]
  918684: d63f0020     	blr	x1
  918688: 17fffc21     	b	0x91770c
  91868c: f94002c1     	ldr	x1, [x22]
  918690: aa1603e0     	mov	x0, x22
  918694: f9400821     	ldr	x1, [x1, #0x10]
  918698: d63f0020     	blr	x1
  91869c: b40008bb     	cbz	x27, 0x9187b0
  9186a0: 910032c1     	add	x1, x22, #0xc
  9186a4: 885ffc20     	ldaxr	w0, [x1]
  9186a8: 51000402     	sub	w2, w0, #0x1
  9186ac: 8803fc22     	stlxr	w3, w2, [x1]
  9186b0: 35ffffa3     	cbnz	w3, 0x9186a4
  9186b4: 7100041f     	cmp	w0, #0x1
  9186b8: 54ffbc01     	b.ne	0x917e38
  9186bc: f94002c1     	ldr	x1, [x22]
  9186c0: aa1603e0     	mov	x0, x22
  9186c4: f9400c21     	ldr	x1, [x1, #0x18]
  9186c8: d63f0020     	blr	x1
  9186cc: 17fffddb     	b	0x917e38
  9186d0: 9101c3e2     	add	x2, sp, #0x70
  9186d4: aa1803e0     	mov	x0, x24
  9186d8: 940003c6     	bl	0x9195f0
  9186dc: 17fffc00     	b	0x9176dc
  9186e0: 9101c3e2     	add	x2, sp, #0x70
  9186e4: aa1803e0     	mov	x0, x24
  9186e8: 940003c2     	bl	0x9195f0
  9186ec: 17fffe2c     	b	0x917f9c
  9186f0: 9101c3e2     	add	x2, sp, #0x70
  9186f4: aa1803e0     	mov	x0, x24
  9186f8: 940003be     	bl	0x9195f0
  9186fc: 17fffb55     	b	0x917450
  918700: 9101c3e2     	add	x2, sp, #0x70
  918704: aa1803e0     	mov	x0, x24
  918708: 940003ba     	bl	0x9195f0
  91870c: 17fffe54     	b	0x91805c
  918710: 9101c3e2     	add	x2, sp, #0x70
  918714: aa1803e0     	mov	x0, x24
  918718: 940003b6     	bl	0x9195f0
  91871c: 17fffd74     	b	0x917cec
  918720: 9101c3e2     	add	x2, sp, #0x70
  918724: aa1803e0     	mov	x0, x24
  918728: 940003b2     	bl	0x9195f0
  91872c: 17fffd3a     	b	0x917c14
  918730: 9101c3e2     	add	x2, sp, #0x70
  918734: aa1803e0     	mov	x0, x24
  918738: 940003ae     	bl	0x9195f0
  91873c: 17fffba2     	b	0x9175c4
  918740: 9101c3e2     	add	x2, sp, #0x70
  918744: aa1803e0     	mov	x0, x24
  918748: 940003aa     	bl	0x9195f0
  91874c: 17fffe74     	b	0x91811c
  918750: 9101c3e2     	add	x2, sp, #0x70
  918754: aa1803e0     	mov	x0, x24
  918758: 940003a6     	bl	0x9195f0
  91875c: 17fffdda     	b	0x917ec4
  918760: b9400ec0     	ldr	w0, [x22, #0xc]
  918764: 51000401     	sub	w1, w0, #0x1
  918768: b9000ec1     	str	w1, [x22, #0xc]
  91876c: 17fffc4e     	b	0x9178a4
  918770: b9400ec0     	ldr	w0, [x22, #0xc]
  918774: 51000401     	sub	w1, w0, #0x1
  918778: b9000ec1     	str	w1, [x22, #0xc]
  91877c: 17fffba8     	b	0x91761c
  918780: 9101c3e2     	add	x2, sp, #0x70
  918784: aa1803e0     	mov	x0, x24
  918788: 9400039a     	bl	0x9195f0
  91878c: 17ffff03     	b	0x918398
  918790: 9101c3e2     	add	x2, sp, #0x70
  918794: aa1803e0     	mov	x0, x24
  918798: 94000396     	bl	0x9195f0
  91879c: 17fffbfc     	b	0x91778c
  9187a0: 9101c3e2     	add	x2, sp, #0x70
  9187a4: aa1803e0     	mov	x0, x24
  9187a8: 94000392     	bl	0x9195f0
  9187ac: 17fffec5     	b	0x9182c0
  9187b0: b9400ec0     	ldr	w0, [x22, #0xc]
  9187b4: 51000401     	sub	w1, w0, #0x1
  9187b8: b9000ec1     	str	w1, [x22, #0xc]
  9187bc: 17ffffbe     	b	0x9186b4
  9187c0: b9400ec0     	ldr	w0, [x22, #0xc]
  9187c4: 51000401     	sub	w1, w0, #0x1
  9187c8: b9000ec1     	str	w1, [x22, #0xc]
  9187cc: 17ffffa9     	b	0x918670
  9187d0: b9400ac0     	ldr	w0, [x22, #0x8]
  9187d4: 51000401     	sub	w1, w0, #0x1
  9187d8: b9000ac1     	str	w1, [x22, #0x8]
  9187dc: 17fffe93     	b	0x918228
  9187e0: b9400ec0     	ldr	w0, [x22, #0xc]
  9187e4: 51000401     	sub	w1, w0, #0x1
  9187e8: b9000ec1     	str	w1, [x22, #0xc]
  9187ec: 17ffff70     	b	0x9185ac
  9187f0: b9400ec0     	ldr	w0, [x22, #0xc]
  9187f4: 51000401     	sub	w1, w0, #0x1
  9187f8: b9000ec1     	str	w1, [x22, #0xc]
  9187fc: 17fffd1c     	b	0x917c6c
  918800: b9400ec0     	ldr	w0, [x22, #0xc]
  918804: 51000401     	sub	w1, w0, #0x1
  918808: b9000ec1     	str	w1, [x22, #0xc]
  91880c: 17fffe5a     	b	0x918174
  918810: b9400ec0     	ldr	w0, [x22, #0xc]
  918814: 51000401     	sub	w1, w0, #0x1
  918818: b9000ec1     	str	w1, [x22, #0xc]
  91881c: 17fffdc0     	b	0x917f1c
  918820: 9101c3e2     	add	x2, sp, #0x70
  918824: aa1803e0     	mov	x0, x24
  918828: 94000372     	bl	0x9195f0
  91882c: 17fffe75     	b	0x918200
  918830: b9400ec0     	ldr	w0, [x22, #0xc]
  918834: 51000401     	sub	w1, w0, #0x1
  918838: b9000ec1     	str	w1, [x22, #0xc]
  91883c: 17fffeb7     	b	0x918318
  918840: b9400ec0     	ldr	w0, [x22, #0xc]
  918844: 51000401     	sub	w1, w0, #0x1
  918848: b9000ec1     	str	w1, [x22, #0xc]
  91884c: 17fffee9     	b	0x9183f0
  918850: f9403fe1     	ldr	x1, [sp, #0x78]
  918854: aa0003f4     	mov	x20, x0
  918858: b40000e1     	cbz	x1, 0x918874
  91885c: aa0103e0     	mov	x0, x1
  918860: 97f6c2d7     	bl	0x6c93bc
  918864: 14000004     	b	0x918874
  918868: aa0003f4     	mov	x20, x0
  91886c: aa1603e0     	mov	x0, x22
  918870: 97ebc750     	bl	0x40a5b0
  918874: f9402a60     	ldr	x0, [x19, #0x50]
  918878: b4000040     	cbz	x0, 0x918880
  91887c: 97ebc74d     	bl	0x40a5b0
  918880: f9401e60     	ldr	x0, [x19, #0x38]
  918884: b4000040     	cbz	x0, 0x91888c
  918888: 97ebc74a     	bl	0x40a5b0
  91888c: f9401260     	ldr	x0, [x19, #0x20]
  918890: b4000040     	cbz	x0, 0x918898
  918894: 97ebc747     	bl	0x40a5b0
  918898: aa1803e0     	mov	x0, x24
  91889c: 94000271     	bl	0x919260
  9188a0: aa1403e0     	mov	x0, x20
  9188a4: 97ebc7ab     	bl	0x40a750
  9188a8: 17fffff0     	b	0x918868
  9188ac: 17ffffef     	b	0x918868
  9188b0: 17ffffe8     	b	0x918850
  9188b4: 17ffffe7     	b	0x918850
  9188b8: 17ffffec     	b	0x918868
  9188bc: 17ffffe5     	b	0x918850
  9188c0: 17ffffe4     	b	0x918850
  9188c4: 17ffffe9     	b	0x918868
  9188c8: 17ffffe2     	b	0x918850
  9188cc: 17ffffe7     	b	0x918868
  9188d0: 17ffffe0     	b	0x918850
  9188d4: 17ffffe5     	b	0x918868
  9188d8: 17ffffde     	b	0x918850
  9188dc: 17ffffdd     	b	0x918850
  9188e0: 17ffffdc     	b	0x918850
  9188e4: 17ffffe1     	b	0x918868
  9188e8: 17ffffda     	b	0x918850
  9188ec: 17ffffdf     	b	0x918868
  9188f0: 17ffffd8     	b	0x918850
  9188f4: 17ffffdd     	b	0x918868
  9188f8: 17ffffd6     	b	0x918850
  9188fc: 17ffffd5     	b	0x918850
  918900: 17ffffd4     	b	0x918850
  918904: 17ffffd9     	b	0x918868
  918908: 17ffffd2     	b	0x918850
  91890c: 17ffffd7     	b	0x918868
  918910: 17ffffd0     	b	0x918850
  918914: aa0003f4     	mov	x20, x0
  918918: 17ffffd7     	b	0x918874
  91891c: 17ffffd3     	b	0x918868
  918920: 17ffffd2     	b	0x918868
  918924: 17ffffcb     	b	0x918850
  918928: 17ffffd0     	b	0x918868
  91892c: 17ffffc9     	b	0x918850
  918930: 17ffffce     	b	0x918868
  918934: aa0003f4     	mov	x20, x0
  918938: b4fff9f5     	cbz	x21, 0x918874
  91893c: aa1503e0     	mov	x0, x21
  918940: 97f6c29f     	bl	0x6c93bc
  918944: 17ffffcc     	b	0x918874
  918948: 17ffffc8     	b	0x918868
  91894c: 17fffffa     	b	0x918934
  918950: 17ffffc6     	b	0x918868
  918954: 17ffffc5     	b	0x918868
