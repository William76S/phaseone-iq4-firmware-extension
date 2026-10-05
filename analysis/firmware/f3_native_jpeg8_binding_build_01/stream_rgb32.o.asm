
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_native_jpeg8_binding_build_01/stream_rgb32.o:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000000000 <iq4_jpeg_stream_rgb32>:
       0: d10143ff     	sub	sp, sp, #0x50
       4: a9017bfd     	stp	x29, x30, [sp, #0x10]
       8: a9025ff8     	stp	x24, x23, [sp, #0x20]
       c: a90357f6     	stp	x22, x21, [sp, #0x30]
      10: a9044ff4     	stp	x20, x19, [sp, #0x40]
      14: 910043fd     	add	x29, sp, #0x10
      18: b40006c3     	cbz	x3, 0xf0 <iq4_jpeg_stream_rgb32+0xf0>
      1c: b4000180     	cbz	x0, 0x4c <iq4_jpeg_stream_rgb32+0x4c>
      20: b101641f     	cmn	x0, #0x59
      24: 52800028     	mov	w8, #0x1                // =1
      28: 54000668     	b.hi	0xf4 <iq4_jpeg_stream_rgb32+0xf4>
      2c: b100e47f     	cmn	x3, #0x39
      30: 54000628     	b.hi	0xf4 <iq4_jpeg_stream_rgb32+0xf4>
      34: 91016008     	add	x8, x0, #0x58
      38: eb03011f     	cmp	x8, x3
      3c: 54000089     	b.ls	0x4c <iq4_jpeg_stream_rgb32+0x4c>
      40: 9100e068     	add	x8, x3, #0x38
      44: eb00011f     	cmp	x8, x0
      48: 54000548     	b.hi	0xf0 <iq4_jpeg_stream_rgb32+0xf0>
      4c: b4000181     	cbz	x1, 0x7c <iq4_jpeg_stream_rgb32+0x7c>
      50: b100a43f     	cmn	x1, #0x29
      54: 52800028     	mov	w8, #0x1                // =1
      58: 540004e8     	b.hi	0xf4 <iq4_jpeg_stream_rgb32+0xf4>
      5c: b100e47f     	cmn	x3, #0x39
      60: 540004a8     	b.hi	0xf4 <iq4_jpeg_stream_rgb32+0xf4>
      64: 9100a028     	add	x8, x1, #0x28
      68: eb03011f     	cmp	x8, x3
      6c: 54000089     	b.ls	0x7c <iq4_jpeg_stream_rgb32+0x7c>
      70: 9100e068     	add	x8, x3, #0x38
      74: eb01011f     	cmp	x8, x1
      78: 540003c8     	b.hi	0xf0 <iq4_jpeg_stream_rgb32+0xf0>
      7c: b4000182     	cbz	x2, 0xac <iq4_jpeg_stream_rgb32+0xac>
      80: b100645f     	cmn	x2, #0x19
      84: 52800028     	mov	w8, #0x1                // =1
      88: 54000368     	b.hi	0xf4 <iq4_jpeg_stream_rgb32+0xf4>
      8c: b100e47f     	cmn	x3, #0x39
      90: 54000328     	b.hi	0xf4 <iq4_jpeg_stream_rgb32+0xf4>
      94: 91006048     	add	x8, x2, #0x18
      98: eb03011f     	cmp	x8, x3
      9c: 54000089     	b.ls	0xac <iq4_jpeg_stream_rgb32+0xac>
      a0: 9100e068     	add	x8, x3, #0x38
      a4: eb02011f     	cmp	x8, x2
      a8: 54000248     	b.hi	0xf0 <iq4_jpeg_stream_rgb32+0xf0>
      ac: b4000321     	cbz	x1, 0x110 <iq4_jpeg_stream_rgb32+0x110>
      b0: f9400029     	ldr	x9, [x1]
      b4: b40002e9     	cbz	x9, 0x110 <iq4_jpeg_stream_rgb32+0x110>
      b8: f940042a     	ldr	x10, [x1, #0x8]
      bc: b40002aa     	cbz	x10, 0x110 <iq4_jpeg_stream_rgb32+0x110>
      c0: ab0a013f     	cmn	x9, x10
      c4: 52800028     	mov	w8, #0x1                // =1
      c8: 1a9f37eb     	cset	w11, hs
      cc: b100e47f     	cmn	x3, #0x39
      d0: 54000128     	b.hi	0xf4 <iq4_jpeg_stream_rgb32+0xf4>
      d4: 3700010b     	tbnz	w11, #0x0, 0xf4 <iq4_jpeg_stream_rgb32+0xf4>
      d8: 9100e068     	add	x8, x3, #0x38
      dc: eb09011f     	cmp	x8, x9
      e0: 54000189     	b.ls	0x110 <iq4_jpeg_stream_rgb32+0x110>
      e4: 8b090148     	add	x8, x10, x9
      e8: eb03011f     	cmp	x8, x3
      ec: 54000129     	b.ls	0x110 <iq4_jpeg_stream_rgb32+0x110>
      f0: 52800028     	mov	w8, #0x1                // =1
      f4: a9444ff4     	ldp	x20, x19, [sp, #0x40]
      f8: 2a0803e0     	mov	w0, w8
      fc: a94357f6     	ldp	x22, x21, [sp, #0x30]
     100: a9425ff8     	ldp	x24, x23, [sp, #0x20]
     104: a9417bfd     	ldp	x29, x30, [sp, #0x10]
     108: 910143ff     	add	sp, sp, #0x50
     10c: d65f03c0     	ret
     110: aa0203f4     	mov	x20, x2
     114: aa0103f6     	mov	x22, x1
     118: aa0003f7     	mov	x23, x0
     11c: aa0303e0     	mov	x0, x3
     120: 2a1f03e1     	mov	w1, wzr
     124: 52800702     	mov	w2, #0x38               // =56
     128: aa0303f5     	mov	x21, x3
     12c: 94000000     	bl	0x12c <iq4_jpeg_stream_rgb32+0x12c>
		000000000000012c:  R_AARCH64_CALL26	memset
     130: b4000797     	cbz	x23, 0x220 <iq4_jpeg_stream_rgb32+0x220>
     134: b94052e9     	ldr	w9, [x23, #0x50]
     138: aa1703e8     	mov	x8, x23
     13c: 7100053f     	cmp	w9, #0x1
     140: 54000701     	b.ne	0x220 <iq4_jpeg_stream_rgb32+0x220>
     144: b9404109     	ldr	w9, [x8, #0x40]
     148: 321f0129     	orr	w9, w9, #0x2
     14c: 7101493f     	cmp	w9, #0x52
     150: 54000681     	b.ne	0x220 <iq4_jpeg_stream_rgb32+0x220>
     154: f9402509     	ldr	x9, [x8, #0x48]
     158: f109213f     	cmp	x9, #0x248
     15c: 54000621     	b.ne	0x220 <iq4_jpeg_stream_rgb32+0x220>
     160: f9400109     	ldr	x9, [x8]
     164: b40005e9     	cbz	x9, 0x220 <iq4_jpeg_stream_rgb32+0x220>
     168: f9400509     	ldr	x9, [x8, #0x8]
     16c: b40005a9     	cbz	x9, 0x220 <iq4_jpeg_stream_rgb32+0x220>
     170: f9400909     	ldr	x9, [x8, #0x10]
     174: b4000569     	cbz	x9, 0x220 <iq4_jpeg_stream_rgb32+0x220>
     178: f9400d09     	ldr	x9, [x8, #0x18]
     17c: b4000529     	cbz	x9, 0x220 <iq4_jpeg_stream_rgb32+0x220>
     180: f9401109     	ldr	x9, [x8, #0x20]
     184: b40004e9     	cbz	x9, 0x220 <iq4_jpeg_stream_rgb32+0x220>
     188: f9401509     	ldr	x9, [x8, #0x28]
     18c: b40004a9     	cbz	x9, 0x220 <iq4_jpeg_stream_rgb32+0x220>
     190: f9401909     	ldr	x9, [x8, #0x30]
     194: b4000469     	cbz	x9, 0x220 <iq4_jpeg_stream_rgb32+0x220>
     198: f9401d08     	ldr	x8, [x8, #0x38]
     19c: b4000428     	cbz	x8, 0x220 <iq4_jpeg_stream_rgb32+0x220>
     1a0: b40003b6     	cbz	x22, 0x214 <iq4_jpeg_stream_rgb32+0x214>
     1a4: aa1403ea     	mov	x10, x20
     1a8: b4000374     	cbz	x20, 0x214 <iq4_jpeg_stream_rgb32+0x214>
     1ac: f94002c8     	ldr	x8, [x22]
     1b0: aa1603e9     	mov	x9, x22
     1b4: b4000308     	cbz	x8, 0x214 <iq4_jpeg_stream_rgb32+0x214>
     1b8: f940054b     	ldr	x11, [x10, #0x8]
     1bc: b40002cb     	cbz	x11, 0x214 <iq4_jpeg_stream_rgb32+0x214>
     1c0: f940094a     	ldr	x10, [x10, #0x10]
     1c4: b400028a     	cbz	x10, 0x214 <iq4_jpeg_stream_rgb32+0x214>
     1c8: b940192a     	ldr	w10, [x9, #0x18]
     1cc: 3400024a     	cbz	w10, 0x214 <iq4_jpeg_stream_rgb32+0x214>
     1d0: 529ffb8b     	mov	w11, #0xffdc            // =65500
     1d4: 6b0b015f     	cmp	w10, w11
     1d8: 540001e8     	b.hi	0x214 <iq4_jpeg_stream_rgb32+0x214>
     1dc: b9401d2b     	ldr	w11, [x9, #0x1c]
     1e0: 129ffb8c     	mov	w12, #-0xffdd           // =-65501
     1e4: 129ffb6d     	mov	w13, #-0xffdc           // =-65500
     1e8: 0b0c016c     	add	w12, w11, w12
     1ec: 6b0d019f     	cmp	w12, w13
     1f0: 54000123     	b.lo	0x214 <iq4_jpeg_stream_rgb32+0x214>
     1f4: b940212c     	ldr	w12, [x9, #0x20]
     1f8: 5101958c     	sub	w12, w12, #0x65
     1fc: 3101959f     	cmn	w12, #0x65
     200: 540000a9     	b.ls	0x214 <iq4_jpeg_stream_rgb32+0x214>
     204: d37ef54a     	lsl	x10, x10, #2
     208: f9400929     	ldr	x9, [x9, #0x10]
     20c: eb0a013f     	cmp	x9, x10
     210: 540000e2     	b.hs	0x22c <iq4_jpeg_stream_rgb32+0x22c>
     214: 52800028     	mov	w8, #0x1                // =1
     218: b90002a8     	str	w8, [x21]
     21c: 17ffffb6     	b	0xf4 <iq4_jpeg_stream_rgb32+0xf4>
     220: 52800048     	mov	w8, #0x2                // =2
     224: b90002a8     	str	w8, [x21]
     228: 17ffffb3     	b	0xf4 <iq4_jpeg_stream_rgb32+0xf4>
     22c: 7100056b     	subs	w11, w11, #0x1
     230: 54000061     	b.ne	0x23c <iq4_jpeg_stream_rgb32+0x23c>
     234: aa1f03eb     	mov	x11, xzr
     238: 14000005     	b	0x24c <iq4_jpeg_stream_rgb32+0x24c>
     23c: aa2a03ec     	mvn	x12, x10
     240: 9acb098c     	udiv	x12, x12, x11
     244: eb0c013f     	cmp	x9, x12
     248: 54fffe68     	b.hi	0x214 <iq4_jpeg_stream_rgb32+0x214>
     24c: 9b0b2929     	madd	x9, x9, x11, x10
     250: f94006ca     	ldr	x10, [x22, #0x8]
     254: ab0a011f     	cmn	x8, x10
     258: 1a9f37e8     	cset	w8, hs
     25c: eb0a013f     	cmp	x9, x10
     260: 54fffda8     	b.hi	0x214 <iq4_jpeg_stream_rgb32+0x214>
     264: 35fffd88     	cbnz	w8, 0x214 <iq4_jpeg_stream_rgb32+0x214>
     268: 52800020     	mov	w0, #0x1                // =1
     26c: 5288a301     	mov	w1, #0x4518             // =17688
     270: 94000000     	bl	0x270 <iq4_jpeg_stream_rgb32+0x270>
		0000000000000270:  R_AARCH64_CALL26	calloc
     274: b4001120     	cbz	x0, 0x498 <iq4_jpeg_stream_rgb32+0x498>
     278: ad4106e0     	ldp	q0, q1, [x23, #0x20]
     27c: 52889709     	mov	w9, #0x44b8             // =17592
     280: f9402ae8     	ldr	x8, [x23, #0x50]
     284: aa0003f3     	mov	x19, x0
     288: 91401278     	add	x24, x19, #0x4, lsl #12 // =0x4000
     28c: f9021673     	str	x19, [x19, #0x428]
     290: 3d912000     	str	q0, [x0, #0x4480]
     294: 3dc012e0     	ldr	q0, [x23, #0x40]
     298: 3d912401     	str	q1, [x0, #0x4490]
     29c: 3d912800     	str	q0, [x0, #0x44a0]
     2a0: ad4002e1     	ldp	q1, q0, [x23]
     2a4: f9225808     	str	x8, [x0, #0x44b0]
     2a8: f9400a88     	ldr	x8, [x20, #0x10]
     2ac: 91134317     	add	x23, x24, #0x4d0
     2b0: f9022e73     	str	x19, [x19, #0x458]
     2b4: 3d911c00     	str	q0, [x0, #0x4470]
     2b8: 3dc00280     	ldr	q0, [x20]
     2bc: 3ca96800     	str	q0, [x0, x9]
     2c0: b9401ac9     	ldr	w9, [x22, #0x18]
     2c4: 3d911801     	str	q1, [x0, #0x4460]
     2c8: f9226408     	str	x8, [x0, #0x44c8]
     2cc: 8b090520     	add	x0, x9, x9, lsl #1
     2d0: 52880008     	mov	w8, #0x4000             // =16384
     2d4: f9227e68     	str	x8, [x19, #0x44f8]
     2d8: f9227a60     	str	x0, [x19, #0x44f0]
     2dc: 94000000     	bl	0x2dc <iq4_jpeg_stream_rgb32+0x2dc>
		00000000000002dc:  R_AARCH64_CALL26	malloc
     2e0: f9228660     	str	x0, [x19, #0x4508]
     2e4: b4000e00     	cbz	x0, 0x4a4 <iq4_jpeg_stream_rgb32+0x4a4>
     2e8: 90000008     	adrp	x8, 0x0 <iq4_jpeg_stream_rgb32>
		00000000000002e8:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x548
     2ec: 91000108     	add	x8, x8, #0x0
		00000000000002ec:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x548
     2f0: 910bc260     	add	x0, x19, #0x2f0
     2f4: f9022268     	str	x8, [x19, #0x440]
     2f8: 90000008     	adrp	x8, 0x0 <iq4_jpeg_stream_rgb32>
		00000000000002f8:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x55c
     2fc: 91000108     	add	x8, x8, #0x0
		00000000000002fc:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x55c
     300: f9022668     	str	x8, [x19, #0x448]
     304: 90000008     	adrp	x8, 0x0 <iq4_jpeg_stream_rgb32>
		0000000000000304:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x5f8
     308: 91000108     	add	x8, x8, #0x0
		0000000000000308:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x5f8
     30c: f9022a68     	str	x8, [x19, #0x450]
     310: 94000000     	bl	0x310 <iq4_jpeg_stream_rgb32+0x310>
		0000000000000310:  R_AARCH64_CALL26	_setjmp
     314: 35000cc0     	cbnz	w0, 0x4ac <iq4_jpeg_stream_rgb32+0x4ac>
     318: f9623268     	ldr	x8, [x19, #0x4460]
     31c: 91092274     	add	x20, x19, #0x248
     320: aa1403e0     	mov	x0, x20
     324: d63f0100     	blr	x8
     328: eb14001f     	cmp	x0, x20
     32c: f9000260     	str	x0, [x19]
     330: 54001041     	b.ne	0x538 <iq4_jpeg_stream_rgb32+0x538>
     334: f9623668     	ldr	x8, [x19, #0x4468]
     338: b944a301     	ldr	w1, [x24, #0x4a0]
     33c: 90000009     	adrp	x9, 0x0 <iq4_jpeg_stream_rgb32>
		000000000000033c:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x6ac
     340: 91000129     	add	x9, x9, #0x0
		0000000000000340:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x6ac
     344: f9625662     	ldr	x2, [x19, #0x44a8]
     348: aa1303e0     	mov	x0, x19
     34c: 9110c274     	add	x20, x19, #0x430
     350: f9012669     	str	x9, [x19, #0x248]
     354: d63f0100     	blr	x8
     358: 90000008     	adrp	x8, 0x0 <iq4_jpeg_stream_rgb32>
		0000000000000358:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8
     35c: fd400ec0     	ldr	d0, [x22, #0x18]
     360: aa1303e0     	mov	x0, x19
     364: fd400101     	ldr	d1, [x8]
		0000000000000364:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8
     368: f9623a68     	ldr	x8, [x19, #0x4470]
     36c: f9001674     	str	x20, [x19, #0x28]
     370: 6d030660     	stp	d0, d1, [x19, #0x30]
     374: d63f0100     	blr	x8
     378: f9623e68     	ldr	x8, [x19, #0x4478]
     37c: b94022c1     	ldr	w1, [x22, #0x20]
     380: aa1303e0     	mov	x0, x19
     384: 52800022     	mov	w2, #0x1                // =1
     388: b9012a7f     	str	wzr, [x19, #0x128]
     38c: b901127f     	str	wzr, [x19, #0x110]
     390: f9008e7f     	str	xzr, [x19, #0x118]
     394: d63f0100     	blr	x8
     398: f9624268     	ldr	x8, [x19, #0x4480]
     39c: aa1303e0     	mov	x0, x19
     3a0: 52800021     	mov	w1, #0x1                // =1
     3a4: d63f0100     	blr	x8
     3a8: b9415674     	ldr	w20, [x19, #0x154]
     3ac: b9403668     	ldr	w8, [x19, #0x34]
     3b0: 6b08029f     	cmp	w20, w8
     3b4: 54000622     	b.hs	0x478 <iq4_jpeg_stream_rgb32+0x478>
     3b8: f9628668     	ldr	x8, [x19, #0x4508]
     3bc: b9401ac9     	ldr	w9, [x22, #0x18]
     3c0: f90007e8     	str	x8, [sp, #0x8]
     3c4: 34000369     	cbz	w9, 0x430 <iq4_jpeg_stream_rgb32+0x430>
     3c8: f9400aca     	ldr	x10, [x22, #0x10]
     3cc: 2a1403eb     	mov	w11, w20
     3d0: f94002c9     	ldr	x9, [x22]
     3d4: aa1f03e8     	mov	x8, xzr
     3d8: 9b0b2549     	madd	x9, x10, x11, x9
     3dc: 5280004a     	mov	w10, #0x2               // =2
     3e0: 5280006b     	mov	w11, #0x3               // =3
     3e4: 5100096c     	sub	w12, w11, #0x2
     3e8: f962866d     	ldr	x13, [x19, #0x4508]
     3ec: 5100094e     	sub	w14, w10, #0x2
     3f0: 386c492c     	ldrb	w12, [x9, w12, uxtw]
     3f4: 91000508     	add	x8, x8, #0x1
     3f8: 382e49ac     	strb	w12, [x13, w14, uxtw]
     3fc: 5100056c     	sub	w12, w11, #0x1
     400: 5100054e     	sub	w14, w10, #0x1
     404: f962866d     	ldr	x13, [x19, #0x4508]
     408: 386c492c     	ldrb	w12, [x9, w12, uxtw]
     40c: 382e49ac     	strb	w12, [x13, w14, uxtw]
     410: f962866c     	ldr	x12, [x19, #0x4508]
     414: 386b492d     	ldrb	w13, [x9, w11, uxtw]
     418: 1100116b     	add	w11, w11, #0x4
     41c: 382a498d     	strb	w13, [x12, w10, uxtw]
     420: 11000d4a     	add	w10, w10, #0x3
     424: b9401acc     	ldr	w12, [x22, #0x18]
     428: eb0c011f     	cmp	x8, x12
     42c: 54fffdc3     	b.lo	0x3e4 <iq4_jpeg_stream_rgb32+0x3e4>
     430: f9624668     	ldr	x8, [x19, #0x4488]
     434: 910023e1     	add	x1, sp, #0x8
     438: aa1303e0     	mov	x0, x19
     43c: 52800022     	mov	w2, #0x1                // =1
     440: d63f0100     	blr	x8
     444: 7100041f     	cmp	w0, #0x1
     448: 540006e1     	b.ne	0x524 <iq4_jpeg_stream_rgb32+0x524>
     44c: b9415668     	ldr	w8, [x19, #0x154]
     450: 11000689     	add	w9, w20, #0x1
     454: 6b09011f     	cmp	w8, w9
     458: 54000661     	b.ne	0x524 <iq4_jpeg_stream_rgb32+0x524>
     45c: b944eb09     	ldr	w9, [x24, #0x4e8]
     460: b940366a     	ldr	w10, [x19, #0x34]
     464: 2a0803f4     	mov	w20, w8
     468: 11000529     	add	w9, w9, #0x1
     46c: 6b0a011f     	cmp	w8, w10
     470: b904eb09     	str	w9, [x24, #0x4e8]
     474: 54fffa23     	b.lo	0x3b8 <iq4_jpeg_stream_rgb32+0x3b8>
     478: f9624a68     	ldr	x8, [x19, #0x4490]
     47c: aa1303e0     	mov	x0, x19
     480: d63f0100     	blr	x8
     484: f9627268     	ldr	x8, [x19, #0x44e0]
     488: f1000d1f     	cmp	x8, #0x3
     48c: 540005a9     	b.ls	0x540 <iq4_jpeg_stream_rgb32+0x540>
     490: 2a1f03e8     	mov	w8, wzr
     494: 14000005     	b	0x4a8 <iq4_jpeg_stream_rgb32+0x4a8>
     498: 52800068     	mov	w8, #0x3                // =3
     49c: b90002a8     	str	w8, [x21]
     4a0: 17ffff15     	b	0xf4 <iq4_jpeg_stream_rgb32+0xf4>
     4a4: 52800068     	mov	w8, #0x3                // =3
     4a8: b90002e8     	str	w8, [x23]
     4ac: f9400668     	ldr	x8, [x19, #0x8]
     4b0: b4000168     	cbz	x8, 0x4dc <iq4_jpeg_stream_rgb32+0x4dc>
     4b4: b9451308     	ldr	w8, [x24, #0x510]
     4b8: 35000128     	cbnz	w8, 0x4dc <iq4_jpeg_stream_rgb32+0x4dc>
     4bc: b944ef08     	ldr	w8, [x24, #0x4ec]
     4c0: 52800029     	mov	w9, #0x1                // =1
     4c4: aa1303e0     	mov	x0, x19
     4c8: b9051309     	str	w9, [x24, #0x510]
     4cc: f9624e69     	ldr	x9, [x19, #0x4498]
     4d0: 11000508     	add	w8, w8, #0x1
     4d4: b904ef08     	str	w8, [x24, #0x4ec]
     4d8: d63f0120     	blr	x9
     4dc: b94002e8     	ldr	w8, [x23]
     4e0: 34000068     	cbz	w8, 0x4ec <iq4_jpeg_stream_rgb32+0x4ec>
     4e4: aa1f03e8     	mov	x8, xzr
     4e8: 14000002     	b	0x4f0 <iq4_jpeg_stream_rgb32+0x4f0>
     4ec: f9627268     	ldr	x8, [x19, #0x44e0]
     4f0: f9226e68     	str	x8, [x19, #0x44d8]
     4f4: f9628660     	ldr	x0, [x19, #0x4508]
     4f8: ad4006e0     	ldp	q0, q1, [x23]
     4fc: 3dc00ae2     	ldr	q2, [x23, #0x20]
     500: f9401ae8     	ldr	x8, [x23, #0x30]
     504: 3d800aa2     	str	q2, [x21, #0x20]
     508: ad0006a0     	stp	q0, q1, [x21]
     50c: f9001aa8     	str	x8, [x21, #0x30]
     510: 94000000     	bl	0x510 <iq4_jpeg_stream_rgb32+0x510>
		0000000000000510:  R_AARCH64_CALL26	free
     514: aa1303e0     	mov	x0, x19
     518: 94000000     	bl	0x518 <iq4_jpeg_stream_rgb32+0x518>
		0000000000000518:  R_AARCH64_CALL26	free
     51c: b94002a8     	ldr	w8, [x21]
     520: 17fffef5     	b	0xf4 <iq4_jpeg_stream_rgb32+0xf4>
     524: 528000e8     	mov	w8, #0x7                // =7
     528: 910bc260     	add	x0, x19, #0x2f0
     52c: 52800021     	mov	w1, #0x1                // =1
     530: b90002e8     	str	w8, [x23]
     534: 94000000     	bl	0x534 <iq4_jpeg_stream_rgb32+0x534>
		0000000000000534:  R_AARCH64_CALL26	longjmp
     538: 52800048     	mov	w8, #0x2                // =2
     53c: 17fffffb     	b	0x528 <iq4_jpeg_stream_rgb32+0x528>
     540: 528000c8     	mov	w8, #0x6                // =6
     544: 17fffff9     	b	0x528 <iq4_jpeg_stream_rgb32+0x528>

0000000000000548 <start_destination>:
     548: f9401409     	ldr	x9, [x0, #0x28]
     54c: 52880008     	mov	w8, #0x4000             // =16384
     550: 9100c12a     	add	x10, x9, #0x30
     554: a900212a     	stp	x10, x8, [x9]
     558: d65f03c0     	ret

000000000000055c <empty_destination>:
     55c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
     560: a9014ff4     	stp	x20, x19, [sp, #0x10]
     564: 910003fd     	mov	x29, sp
     568: f9401414     	ldr	x20, [x0, #0x28]
     56c: f9401693     	ldr	x19, [x20, #0x28]
     570: f9627268     	ldr	x8, [x19, #0x44e0]
     574: f9626669     	ldr	x9, [x19, #0x44c8]
     578: eb080128     	subs	x8, x9, x8
     57c: d34efd08     	lsr	x8, x8, #14
     580: fa402904     	ccmp	x8, #0x0, #0x4, hs
     584: 540002e0     	b.eq	0x5e0 <empty_destination+0x84>
     588: f9626268     	ldr	x8, [x19, #0x44c0]
     58c: f9625e60     	ldr	x0, [x19, #0x44b8]
     590: 91118261     	add	x1, x19, #0x460
     594: 52880002     	mov	w2, #0x4000             // =16384
     598: d63f0100     	blr	x8
     59c: f140101f     	cmp	x0, #0x4, lsl #12       // =0x4000
     5a0: 540001a8     	b.hi	0x5d4 <empty_destination+0x78>
     5a4: f9627268     	ldr	x8, [x19, #0x44e0]
     5a8: f140101f     	cmp	x0, #0x4, lsl #12       // =0x4000
     5ac: 8b000108     	add	x8, x8, x0
     5b0: f9227268     	str	x8, [x19, #0x44e0]
     5b4: 54000101     	b.ne	0x5d4 <empty_destination+0x78>
     5b8: 9100c288     	add	x8, x20, #0x30
     5bc: 52880009     	mov	w9, #0x4000             // =16384
     5c0: 52800020     	mov	w0, #0x1                // =1
     5c4: a9002688     	stp	x8, x9, [x20]
     5c8: a9414ff4     	ldp	x20, x19, [sp, #0x10]
     5cc: a8c27bfd     	ldp	x29, x30, [sp], #0x20
     5d0: d65f03c0     	ret
     5d4: 52889a08     	mov	w8, #0x44d0             // =17616
     5d8: 528000a9     	mov	w9, #0x5                // =5
     5dc: 14000003     	b	0x5e8 <empty_destination+0x8c>
     5e0: 52889a08     	mov	w8, #0x44d0             // =17616
     5e4: 52800089     	mov	w9, #0x4                // =4
     5e8: 910bc260     	add	x0, x19, #0x2f0
     5ec: 52800021     	mov	w1, #0x1                // =1
     5f0: b8286a69     	str	w9, [x19, x8]
     5f4: 94000000     	bl	0x5f4 <empty_destination+0x98>
		00000000000005f4:  R_AARCH64_CALL26	longjmp

00000000000005f8 <finish_destination>:
     5f8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
     5fc: a9014ff4     	stp	x20, x19, [sp, #0x10]
     600: 910003fd     	mov	x29, sp
     604: f9401409     	ldr	x9, [x0, #0x28]
     608: f9400528     	ldr	x8, [x9, #0x8]
     60c: f9401534     	ldr	x20, [x9, #0x28]
     610: f140111f     	cmp	x8, #0x4, lsl #12       // =0x4000
     614: 54000348     	b.hi	0x67c <finish_destination+0x84>
     618: f140111f     	cmp	x8, #0x4, lsl #12       // =0x4000
     61c: 540002a0     	b.eq	0x670 <finish_destination+0x78>
     620: f9627289     	ldr	x9, [x20, #0x44e0]
     624: f962668a     	ldr	x10, [x20, #0x44c8]
     628: eb090149     	subs	x9, x10, x9
     62c: 540002e3     	b.lo	0x688 <finish_destination+0x90>
     630: 5288000a     	mov	w10, #0x4000            // =16384
     634: cb080153     	sub	x19, x10, x8
     638: eb09027f     	cmp	x19, x9
     63c: 54000268     	b.hi	0x688 <finish_destination+0x90>
     640: f9626288     	ldr	x8, [x20, #0x44c0]
     644: f9625e80     	ldr	x0, [x20, #0x44b8]
     648: 91118281     	add	x1, x20, #0x460
     64c: aa1303e2     	mov	x2, x19
     650: d63f0100     	blr	x8
     654: eb13001f     	cmp	x0, x19
     658: 54000088     	b.hi	0x668 <finish_destination+0x70>
     65c: f9627288     	ldr	x8, [x20, #0x44e0]
     660: 8b000108     	add	x8, x8, x0
     664: f9227288     	str	x8, [x20, #0x44e0]
     668: eb13001f     	cmp	x0, x19
     66c: 54000141     	b.ne	0x694 <finish_destination+0x9c>
     670: a9414ff4     	ldp	x20, x19, [sp, #0x10]
     674: a8c27bfd     	ldp	x29, x30, [sp], #0x20
     678: d65f03c0     	ret
     67c: 52889a08     	mov	w8, #0x44d0             // =17616
     680: 528000c9     	mov	w9, #0x6                // =6
     684: 14000006     	b	0x69c <finish_destination+0xa4>
     688: 52889a08     	mov	w8, #0x44d0             // =17616
     68c: 52800089     	mov	w9, #0x4                // =4
     690: 14000003     	b	0x69c <finish_destination+0xa4>
     694: 52889a08     	mov	w8, #0x44d0             // =17616
     698: 528000a9     	mov	w9, #0x5                // =5
     69c: 910bc280     	add	x0, x20, #0x2f0
     6a0: 52800021     	mov	w1, #0x1                // =1
     6a4: b8286a89     	str	w9, [x20, x8]
     6a8: 94000000     	bl	0x6a8 <finish_destination+0xb0>
		00000000000006a8:  R_AARCH64_CALL26	longjmp

00000000000006ac <library_error>:
     6ac: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
     6b0: 910003fd     	mov	x29, sp
     6b4: f9400009     	ldr	x9, [x0]
     6b8: 52800108     	mov	w8, #0x8                // =8
     6bc: 52800021     	mov	w1, #0x1                // =1
     6c0: f940f12a     	ldr	x10, [x9, #0x1e0]
     6c4: b9402929     	ldr	w9, [x9, #0x28]
     6c8: 9140114b     	add	x11, x10, #0x4, lsl #12 // =0x4000
     6cc: 910bc140     	add	x0, x10, #0x2f0
     6d0: b945116c     	ldr	w12, [x11, #0x510]
     6d4: b9050169     	str	w9, [x11, #0x500]
     6d8: 7100019f     	cmp	w12, #0x0
     6dc: 528000cc     	mov	w12, #0x6               // =6
     6e0: 1a880188     	csel	w8, w12, w8, eq
     6e4: b904d168     	str	w8, [x11, #0x4d0]
     6e8: 94000000     	bl	0x6e8 <library_error+0x3c>
		00000000000006e8:  R_AARCH64_CALL26	longjmp
