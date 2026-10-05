  7c712c: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  7c7130: 910003fd     	mov	x29, sp
  7c7134: f90017e0     	str	x0, [sp, #0x28]
  7c7138: f90013e1     	str	x1, [sp, #0x20]
  7c713c: 39007fe2     	strb	w2, [sp, #0x1f]
  7c7140: 39007be3     	strb	w3, [sp, #0x1e]
  7c7144: f94017e0     	ldr	x0, [sp, #0x28]
  7c7148: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c714c: f9681400     	ldr	x0, [x0, #0x5028]
  7c7150: f100001f     	cmp	x0, #0x0
  7c7154: 54000140     	b.eq	0x7c717c
  7c7158: 528006a3     	mov	w3, #0x35               // =53
  7c715c: d0002de0     	adrp	x0, 0xd85000
  7c7160: 912c0002     	add	x2, x0, #0xb00
  7c7164: d0002de0     	adrp	x0, 0xd85000
  7c7168: 912ca001     	add	x1, x0, #0xb28
  7c716c: d0002de0     	adrp	x0, 0xd85000
  7c7170: 912ce000     	add	x0, x0, #0xb38
  7c7174: 97f10d03     	bl	0x40a580
  7c7178: 97fe9564     	bl	0x76c708
  7c717c: f94017e0     	ldr	x0, [sp, #0x28]
  7c7180: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7184: f94013e1     	ldr	x1, [sp, #0x20]
  7c7188: f9281401     	str	x1, [x0, #0x5028]
  7c718c: 39407be2     	ldrb	w2, [sp, #0x1e]
  7c7190: 39407fe1     	ldrb	w1, [sp, #0x1f]
  7c7194: f94017e0     	ldr	x0, [sp, #0x28]
  7c7198: 94000020     	bl	0x7c7218
  7c719c: 12001c00     	and	w0, w0, #0xff
  7c71a0: 52000000     	eor	w0, w0, #0x1
  7c71a4: 12001c00     	and	w0, w0, #0xff
  7c71a8: 7100001f     	cmp	w0, #0x0
  7c71ac: 540000a0     	b.eq	0x7c71c0
  7c71b0: f94017e0     	ldr	x0, [sp, #0x28]
  7c71b4: 94000006     	bl	0x7c71cc
  7c71b8: 52800000     	mov	w0, #0x0                // =0
  7c71bc: 14000002     	b	0x7c71c4
  7c71c0: 52800020     	mov	w0, #0x1                // =1
  7c71c4: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  7c71c8: d65f03c0     	ret
  7c71cc: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  7c71d0: 910003fd     	mov	x29, sp
  7c71d4: f9000fe0     	str	x0, [sp, #0x18]
  7c71d8: f9400fe0     	ldr	x0, [sp, #0x18]
  7c71dc: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c71e0: f9681400     	ldr	x0, [x0, #0x5028]
  7c71e4: f100001f     	cmp	x0, #0x0
  7c71e8: 1a9f07e0     	cset	w0, ne
  7c71ec: 3900bfe0     	strb	w0, [sp, #0x2f]
  7c71f0: f9400fe1     	ldr	x1, [sp, #0x18]
  7c71f4: d2849f00     	mov	x0, #0x24f8             // =9464
  7c71f8: 8b000020     	add	x0, x1, x0
  7c71fc: 97ffe546     	bl	0x7c0714
  7c7200: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7204: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7208: f928141f     	str	xzr, [x0, #0x5028]
  7c720c: 3940bfe0     	ldrb	w0, [sp, #0x2f]
  7c7210: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  7c7214: d65f03c0     	ret
  7c7218: a9b97bfd     	stp	x29, x30, [sp, #-0x70]!
  7c721c: 910003fd     	mov	x29, sp
  7c7220: f9000fe0     	str	x0, [sp, #0x18]
  7c7224: 39005fe1     	strb	w1, [sp, #0x17]
  7c7228: 39005be2     	strb	w2, [sp, #0x16]
  7c722c: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7230: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7234: f9681400     	ldr	x0, [x0, #0x5028]
  7c7238: f100001f     	cmp	x0, #0x0
  7c723c: 54000141     	b.ne	0x7c7264
  7c7240: 52800a63     	mov	w3, #0x53               // =83
  7c7244: d0002de0     	adrp	x0, 0xd85000
  7c7248: 912c0002     	add	x2, x0, #0xb00
  7c724c: d0002de0     	adrp	x0, 0xd85000
  7c7250: 912d8001     	add	x1, x0, #0xb60
  7c7254: d0002de0     	adrp	x0, 0xd85000
  7c7258: 912ce000     	add	x0, x0, #0xb38
  7c725c: 97f10cc9     	bl	0x40a580
  7c7260: 97fe952a     	bl	0x76c708
  7c7264: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7268: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c726c: f9681404     	ldr	x4, [x0, #0x5028]
  7c7270: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7274: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7278: f9681400     	ldr	x0, [x0, #0x5028]
  7c727c: f9400000     	ldr	x0, [x0]
  7c7280: 91006000     	add	x0, x0, #0x18
  7c7284: f9400003     	ldr	x3, [x0]
  7c7288: 9100c3e0     	add	x0, sp, #0x30
  7c728c: 52800082     	mov	w2, #0x4                // =4
  7c7290: aa0003e1     	mov	x1, x0
  7c7294: aa0403e0     	mov	x0, x4
  7c7298: d63f0060     	blr	x3
  7c729c: 7100101f     	cmp	w0, #0x4
  7c72a0: 1a9f07e0     	cset	w0, ne
  7c72a4: 12001c00     	and	w0, w0, #0xff
  7c72a8: 7100001f     	cmp	w0, #0x0
  7c72ac: 540000c0     	b.eq	0x7c72c4
  7c72b0: f9400fe0     	ldr	x0, [sp, #0x18]
  7c72b4: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c72b8: b910301f     	str	wzr, [x0, #0x1030]
  7c72bc: 52800000     	mov	w0, #0x0                // =0
  7c72c0: 140001f4     	b	0x7c7a90
  7c72c4: b94033e1     	ldr	w1, [sp, #0x30]
  7c72c8: 52892920     	mov	w0, #0x4949             // =18761
  7c72cc: 72a92920     	movk	w0, #0x4949, lsl #16
  7c72d0: 6b00003f     	cmp	w1, w0
  7c72d4: 540000c0     	b.eq	0x7c72ec
  7c72d8: b94033e1     	ldr	w1, [sp, #0x30]
  7c72dc: 5289a9a0     	mov	w0, #0x4d4d             // =19789
  7c72e0: 72a9a9a0     	movk	w0, #0x4d4d, lsl #16
  7c72e4: 6b00003f     	cmp	w1, w0
  7c72e8: 54000961     	b.ne	0x7c7414
  7c72ec: f9400fe0     	ldr	x0, [sp, #0x18]
  7c72f0: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c72f4: 52800061     	mov	w1, #0x3                // =3
  7c72f8: b9103001     	str	w1, [x0, #0x1030]
  7c72fc: f9400fe1     	ldr	x1, [sp, #0x18]
  7c7300: d29a0b00     	mov	x0, #0xd058             // =53336
  7c7304: 8b000020     	add	x0, x1, x0
  7c7308: 52800002     	mov	w2, #0x0                // =0
  7c730c: 52800001     	mov	w1, #0x0                // =0
  7c7310: 94004a0e     	bl	0x7d9b48
  7c7314: f9400fe1     	ldr	x1, [sp, #0x18]
  7c7318: d29bb400     	mov	x0, #0xdda0             // =56736
  7c731c: 8b000020     	add	x0, x1, x0
  7c7320: 52800002     	mov	w2, #0x0                // =0
  7c7324: 52800001     	mov	w1, #0x0                // =0
  7c7328: 94004a08     	bl	0x7d9b48
  7c732c: f9400fe1     	ldr	x1, [sp, #0x18]
  7c7330: d29a0b00     	mov	x0, #0xd058             // =53336
  7c7334: 8b000023     	add	x3, x1, x0
  7c7338: f9400fe0     	ldr	x0, [sp, #0x18]
  7c733c: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7340: f9681400     	ldr	x0, [x0, #0x5028]
  7c7344: 52800002     	mov	w2, #0x0                // =0
  7c7348: aa0003e1     	mov	x1, x0
  7c734c: aa0303e0     	mov	x0, x3
  7c7350: 94004d0e     	bl	0x7da788
  7c7354: 12001c00     	and	w0, w0, #0xff
  7c7358: 52000000     	eor	w0, w0, #0x1
  7c735c: 12001c00     	and	w0, w0, #0xff
  7c7360: 7100001f     	cmp	w0, #0x0
  7c7364: 540001c0     	b.eq	0x7c739c
  7c7368: d0002de0     	adrp	x0, 0xd85000
  7c736c: 912dc002     	add	x2, x0, #0xb70
  7c7370: 52800dc1     	mov	w1, #0x6e               // =110
  7c7374: d0002de0     	adrp	x0, 0xd85000
  7c7378: 912c0000     	add	x0, x0, #0xb00
  7c737c: 97fdfc48     	bl	0x74649c
  7c7380: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7384: 97ffff92     	bl	0x7c71cc
  7c7388: f9400fe0     	ldr	x0, [sp, #0x18]
  7c738c: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7390: f928141f     	str	xzr, [x0, #0x5028]
  7c7394: 52800000     	mov	w0, #0x0                // =0
  7c7398: 140001be     	b	0x7c7a90
  7c739c: f9400fe0     	ldr	x0, [sp, #0x18]
  7c73a0: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c73a4: b95d9800     	ldr	w0, [x0, #0x1d98]
  7c73a8: 7100001f     	cmp	w0, #0x0
  7c73ac: 54003060     	b.eq	0x7c79b8
  7c73b0: f9400fe1     	ldr	x1, [sp, #0x18]
  7c73b4: d29bb400     	mov	x0, #0xdda0             // =56736
  7c73b8: 8b000023     	add	x3, x1, x0
  7c73bc: f9400fe0     	ldr	x0, [sp, #0x18]
  7c73c0: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c73c4: f9681401     	ldr	x1, [x0, #0x5028]
  7c73c8: f9400fe0     	ldr	x0, [sp, #0x18]
  7c73cc: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c73d0: b95d9800     	ldr	w0, [x0, #0x1d98]
  7c73d4: 2a0003e2     	mov	w2, w0
  7c73d8: aa0303e0     	mov	x0, x3
  7c73dc: 94004ceb     	bl	0x7da788
  7c73e0: 12001c00     	and	w0, w0, #0xff
  7c73e4: 52000000     	eor	w0, w0, #0x1
  7c73e8: 12001c00     	and	w0, w0, #0xff
  7c73ec: 7100001f     	cmp	w0, #0x0
  7c73f0: 54002e40     	b.eq	0x7c79b8
  7c73f4: d0002de0     	adrp	x0, 0xd85000
  7c73f8: 912e2002     	add	x2, x0, #0xb88
  7c73fc: 52800f41     	mov	w1, #0x7a               // =122
  7c7400: d0002de0     	adrp	x0, 0xd85000
  7c7404: 912c0000     	add	x0, x0, #0xb00
  7c7408: 97fdfc25     	bl	0x74649c
  7c740c: 52800000     	mov	w0, #0x0                // =0
  7c7410: 140001a0     	b	0x7c7a90
  7c7414: b94033e0     	ldr	w0, [sp, #0x30]
  7c7418: 12003c01     	and	w1, w0, #0xffff
  7c741c: 52892920     	mov	w0, #0x4949             // =18761
  7c7420: 6b00003f     	cmp	w1, w0
  7c7424: 540000c0     	b.eq	0x7c743c
  7c7428: b94033e0     	ldr	w0, [sp, #0x30]
  7c742c: 12003c01     	and	w1, w0, #0xffff
  7c7430: 5289a9a0     	mov	w0, #0x4d4d             // =19789
  7c7434: 6b00003f     	cmp	w1, w0
  7c7438: 54002bc1     	b.ne	0x7c79b0
  7c743c: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7440: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c7444: 528000a1     	mov	w1, #0x5                // =5
  7c7448: b9103001     	str	w1, [x0, #0x1030]
  7c744c: f9400fe1     	ldr	x1, [sp, #0x18]
  7c7450: d2849f00     	mov	x0, #0x24f8             // =9464
  7c7454: 8b000022     	add	x2, x1, x0
  7c7458: f9400fe0     	ldr	x0, [sp, #0x18]
  7c745c: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7460: f9681400     	ldr	x0, [x0, #0x5028]
  7c7464: aa0003e1     	mov	x1, x0
  7c7468: aa0203e0     	mov	x0, x2
  7c746c: 97ffe49b     	bl	0x7c06d8
  7c7470: f9400fe1     	ldr	x1, [sp, #0x18]
  7c7474: d2849f00     	mov	x0, #0x24f8             // =9464
  7c7478: 8b000020     	add	x0, x1, x0
  7c747c: 39405fe1     	ldrb	w1, [sp, #0x17]
  7c7480: 97ffefac     	bl	0x7c3330
  7c7484: 12001c00     	and	w0, w0, #0xff
  7c7488: 52000000     	eor	w0, w0, #0x1
  7c748c: 12001c00     	and	w0, w0, #0xff
  7c7490: 7100001f     	cmp	w0, #0x0
  7c7494: 54000060     	b.eq	0x7c74a0
  7c7498: 52800000     	mov	w0, #0x0                // =0
  7c749c: 1400017d     	b	0x7c7a90
  7c74a0: f9400fe1     	ldr	x1, [sp, #0x18]
  7c74a4: d2849f00     	mov	x0, #0x24f8             // =9464
  7c74a8: 8b000020     	add	x0, x1, x0
  7c74ac: 128db061     	mov	w1, #-0x6d84            // =-28036
  7c74b0: 97fff19f     	bl	0x7c3b2c
  7c74b4: f90033e0     	str	x0, [sp, #0x60]
  7c74b8: f94033e0     	ldr	x0, [sp, #0x60]
  7c74bc: f100001f     	cmp	x0, #0x0
  7c74c0: 54000ce0     	b.eq	0x7c765c
  7c74c4: 39405be0     	ldrb	w0, [sp, #0x16]
  7c74c8: 7100001f     	cmp	w0, #0x0
  7c74cc: 54000c80     	b.eq	0x7c765c
  7c74d0: f9400fe0     	ldr	x0, [sp, #0x18]
  7c74d4: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c74d8: 52800081     	mov	w1, #0x4                // =4
  7c74dc: b9103001     	str	w1, [x0, #0x1030]
  7c74e0: f9400fe1     	ldr	x1, [sp, #0x18]
  7c74e4: d29a0b00     	mov	x0, #0xd058             // =53336
  7c74e8: 8b000023     	add	x3, x1, x0
  7c74ec: f94033e0     	ldr	x0, [sp, #0x60]
  7c74f0: f9400c00     	ldr	x0, [x0, #0x18]
  7c74f4: 2a0003e1     	mov	w1, w0
  7c74f8: f94033e0     	ldr	x0, [sp, #0x60]
  7c74fc: b9401400     	ldr	w0, [x0, #0x14]
  7c7500: 2a0003e2     	mov	w2, w0
  7c7504: aa0303e0     	mov	x0, x3
  7c7508: 94004990     	bl	0x7d9b48
  7c750c: f9400fe1     	ldr	x1, [sp, #0x18]
  7c7510: d29a0b00     	mov	x0, #0xd058             // =53336
  7c7514: 8b000023     	add	x3, x1, x0
  7c7518: f9400fe0     	ldr	x0, [sp, #0x18]
  7c751c: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7520: f9681400     	ldr	x0, [x0, #0x5028]
  7c7524: 52800002     	mov	w2, #0x0                // =0
  7c7528: aa0003e1     	mov	x1, x0
  7c752c: aa0303e0     	mov	x0, x3
  7c7530: 94004c96     	bl	0x7da788
  7c7534: 12001c00     	and	w0, w0, #0xff
  7c7538: 52000000     	eor	w0, w0, #0x1
  7c753c: 12001c00     	and	w0, w0, #0xff
  7c7540: 7100001f     	cmp	w0, #0x0
  7c7544: 54000300     	b.eq	0x7c75a4
  7c7548: f9400fe1     	ldr	x1, [sp, #0x18]
  7c754c: d2849f00     	mov	x0, #0x24f8             // =9464
  7c7550: 8b000020     	add	x0, x1, x0
  7c7554: 12873da1     	mov	w1, #-0x39ee            // =-14830
  7c7558: 97fff175     	bl	0x7c3b2c
  7c755c: f100001f     	cmp	x0, #0x0
  7c7560: 1a9f07e0     	cset	w0, ne
  7c7564: 12001c00     	and	w0, w0, #0xff
  7c7568: 7100001f     	cmp	w0, #0x0
  7c756c: 540000c0     	b.eq	0x7c7584
  7c7570: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7574: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c7578: 528000c1     	mov	w1, #0x6                // =6
  7c757c: b9103001     	str	w1, [x0, #0x1030]
  7c7580: 14000007     	b	0x7c759c
  7c7584: d0002de0     	adrp	x0, 0xd85000
  7c7588: 912ec002     	add	x2, x0, #0xbb0
  7c758c: 528013a1     	mov	w1, #0x9d               // =157
  7c7590: d0002de0     	adrp	x0, 0xd85000
  7c7594: 912c0000     	add	x0, x0, #0xb00
  7c7598: 97fdfbc1     	bl	0x74649c
  7c759c: 52800000     	mov	w0, #0x0                // =0
  7c75a0: 1400013c     	b	0x7c7a90
  7c75a4: f9400fe0     	ldr	x0, [sp, #0x18]
  7c75a8: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c75ac: b9503000     	ldr	w0, [x0, #0x1030]
  7c75b0: 7100101f     	cmp	w0, #0x4
  7c75b4: 54001fa1     	b.ne	0x7c79a8
  7c75b8: f9400fe0     	ldr	x0, [sp, #0x18]
  7c75bc: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c75c0: b95d9800     	ldr	w0, [x0, #0x1d98]
  7c75c4: 7100001f     	cmp	w0, #0x0
  7c75c8: 54001f00     	b.eq	0x7c79a8
  7c75cc: f9400fe1     	ldr	x1, [sp, #0x18]
  7c75d0: d29bb400     	mov	x0, #0xdda0             // =56736
  7c75d4: 8b000023     	add	x3, x1, x0
  7c75d8: f94033e0     	ldr	x0, [sp, #0x60]
  7c75dc: f9400c00     	ldr	x0, [x0, #0x18]
  7c75e0: 2a0003e1     	mov	w1, w0
  7c75e4: f94033e0     	ldr	x0, [sp, #0x60]
  7c75e8: b9401400     	ldr	w0, [x0, #0x14]
  7c75ec: 2a0003e2     	mov	w2, w0
  7c75f0: aa0303e0     	mov	x0, x3
  7c75f4: 94004955     	bl	0x7d9b48
  7c75f8: f9400fe1     	ldr	x1, [sp, #0x18]
  7c75fc: d29bb400     	mov	x0, #0xdda0             // =56736
  7c7600: 8b000023     	add	x3, x1, x0
  7c7604: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7608: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c760c: f9681401     	ldr	x1, [x0, #0x5028]
  7c7610: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7614: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c7618: b95d9800     	ldr	w0, [x0, #0x1d98]
  7c761c: 2a0003e2     	mov	w2, w0
  7c7620: aa0303e0     	mov	x0, x3
  7c7624: 94004c59     	bl	0x7da788
  7c7628: 12001c00     	and	w0, w0, #0xff
  7c762c: 52000000     	eor	w0, w0, #0x1
  7c7630: 12001c00     	and	w0, w0, #0xff
  7c7634: 7100001f     	cmp	w0, #0x0
  7c7638: 54001b80     	b.eq	0x7c79a8
  7c763c: d0002de0     	adrp	x0, 0xd85000
  7c7640: 912e2002     	add	x2, x0, #0xb88
  7c7644: 52801521     	mov	w1, #0xa9               // =169
  7c7648: d0002de0     	adrp	x0, 0xd85000
  7c764c: 912c0000     	add	x0, x0, #0xb00
  7c7650: 97fdfb93     	bl	0x74649c
  7c7654: 52800000     	mov	w0, #0x0                // =0
  7c7658: 1400010e     	b	0x7c7a90
  7c765c: f9400fe1     	ldr	x1, [sp, #0x18]
  7c7660: d2849f00     	mov	x0, #0x24f8             // =9464
  7c7664: 8b000020     	add	x0, x1, x0
  7c7668: 12873da1     	mov	w1, #-0x39ee            // =-14830
  7c766c: 97fff130     	bl	0x7c3b2c
  7c7670: f100001f     	cmp	x0, #0x0
  7c7674: 1a9f07e0     	cset	w0, ne
  7c7678: 12001c00     	and	w0, w0, #0xff
  7c767c: 7100001f     	cmp	w0, #0x0
  7c7680: 540000c0     	b.eq	0x7c7698
  7c7684: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7688: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c768c: 528000c1     	mov	w1, #0x6                // =6
  7c7690: b9103001     	str	w1, [x0, #0x1030]
  7c7694: 140000cb     	b	0x7c79c0
  7c7698: f9400fe0     	ldr	x0, [sp, #0x18]
  7c769c: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c76a0: 52800041     	mov	w1, #0x2                // =2
  7c76a4: b9103001     	str	w1, [x0, #0x1030]
  7c76a8: 3901bfff     	strb	wzr, [sp, #0x6f]
  7c76ac: b94033e0     	ldr	w0, [sp, #0x30]
  7c76b0: 12003c01     	and	w1, w0, #0xffff
  7c76b4: 5289a9a0     	mov	w0, #0x4d4d             // =19789
  7c76b8: 6b00003f     	cmp	w1, w0
  7c76bc: 1a9f17e0     	cset	w0, eq
  7c76c0: 39017fe0     	strb	w0, [sp, #0x5f]
  7c76c4: b94033e0     	ldr	w0, [sp, #0x30]
  7c76c8: 53107c00     	lsr	w0, w0, #16
  7c76cc: 7900bbe0     	strh	w0, [sp, #0x5c]
  7c76d0: 39417fe0     	ldrb	w0, [sp, #0x5f]
  7c76d4: 7100001f     	cmp	w0, #0x0
  7c76d8: 540000a0     	b.eq	0x7c76ec
  7c76dc: 7940bbe1     	ldrh	w1, [sp, #0x5c]
  7c76e0: 52854000     	mov	w0, #0x2a00             // =10752
  7c76e4: 6b00003f     	cmp	w1, w0
  7c76e8: 54000120     	b.eq	0x7c770c
  7c76ec: 39417fe0     	ldrb	w0, [sp, #0x5f]
  7c76f0: 52000000     	eor	w0, w0, #0x1
  7c76f4: 12001c00     	and	w0, w0, #0xff
  7c76f8: 7100001f     	cmp	w0, #0x0
  7c76fc: 54000240     	b.eq	0x7c7744
  7c7700: 7940bbe0     	ldrh	w0, [sp, #0x5c]
  7c7704: 7100a81f     	cmp	w0, #0x2a
  7c7708: 540001e1     	b.ne	0x7c7744
  7c770c: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7710: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7714: f9681404     	ldr	x4, [x0, #0x5028]
  7c7718: f9400fe0     	ldr	x0, [sp, #0x18]
  7c771c: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7720: f9681400     	ldr	x0, [x0, #0x5028]
  7c7724: f9400000     	ldr	x0, [x0]
  7c7728: 91012000     	add	x0, x0, #0x48
  7c772c: f9400003     	ldr	x3, [x0]
  7c7730: 52800002     	mov	w2, #0x0                // =0
  7c7734: 52800101     	mov	w1, #0x8                // =8
  7c7738: aa0403e0     	mov	x0, x4
  7c773c: d63f0060     	blr	x3
  7c7740: 1400000e     	b	0x7c7778
  7c7744: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7748: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c774c: f9681404     	ldr	x4, [x0, #0x5028]
  7c7750: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7754: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7758: f9681400     	ldr	x0, [x0, #0x5028]
  7c775c: f9400000     	ldr	x0, [x0]
  7c7760: 91012000     	add	x0, x0, #0x48
  7c7764: f9400003     	ldr	x3, [x0]
  7c7768: 52800002     	mov	w2, #0x0                // =0
  7c776c: 52800001     	mov	w1, #0x0                // =0
  7c7770: aa0403e0     	mov	x0, x4
  7c7774: d63f0060     	blr	x3
  7c7778: 5289a9a0     	mov	w0, #0x4d4d             // =19789
  7c777c: 72a9a9a0     	movk	w0, #0x4d4d, lsl #16
  7c7780: b9005be0     	str	w0, [sp, #0x58]
  7c7784: 52892920     	mov	w0, #0x4949             // =18761
  7c7788: 72a92920     	movk	w0, #0x4949, lsl #16
  7c778c: b90057e0     	str	w0, [sp, #0x54]
  7c7790: 528ee900     	mov	w0, #0x7748             // =30536
  7c7794: 72aa4c20     	movk	w0, #0x5261, lsl #16
  7c7798: b90053e0     	str	w0, [sp, #0x50]
  7c779c: 528eea80     	mov	w0, #0x7754             // =30548
  7c77a0: 72aa4c20     	movk	w0, #0x5261, lsl #16
  7c77a4: b9004fe0     	str	w0, [sp, #0x4c]
  7c77a8: 528ee840     	mov	w0, #0x7742             // =30530
  7c77ac: 72aa4c20     	movk	w0, #0x5261, lsl #16
  7c77b0: b9004be0     	str	w0, [sp, #0x48]
  7c77b4: 528ee860     	mov	w0, #0x7743             // =30531
  7c77b8: 72aa4c20     	movk	w0, #0x5261, lsl #16
  7c77bc: b90047e0     	str	w0, [sp, #0x44]
  7c77c0: 528c2a40     	mov	w0, #0x6152             // =24914
  7c77c4: 72a90ee0     	movk	w0, #0x4877, lsl #16
  7c77c8: b90043e0     	str	w0, [sp, #0x40]
  7c77cc: 528c2a40     	mov	w0, #0x6152             // =24914
  7c77d0: 72aa8ee0     	movk	w0, #0x5477, lsl #16
  7c77d4: b9003fe0     	str	w0, [sp, #0x3c]
  7c77d8: 528c2a40     	mov	w0, #0x6152             // =24914
  7c77dc: 72a84ee0     	movk	w0, #0x4277, lsl #16
  7c77e0: b9003be0     	str	w0, [sp, #0x38]
  7c77e4: 528c2a40     	mov	w0, #0x6152             // =24914
  7c77e8: 72a86ee0     	movk	w0, #0x4377, lsl #16
  7c77ec: b90037e0     	str	w0, [sp, #0x34]
  7c77f0: f9400fe0     	ldr	x0, [sp, #0x18]
  7c77f4: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c77f8: f9681404     	ldr	x4, [x0, #0x5028]
  7c77fc: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7800: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7804: f9681400     	ldr	x0, [x0, #0x5028]
  7c7808: f9400000     	ldr	x0, [x0]
  7c780c: 91006000     	add	x0, x0, #0x18
  7c7810: f9400003     	ldr	x3, [x0]
  7c7814: 9100b3e0     	add	x0, sp, #0x2c
  7c7818: 52800082     	mov	w2, #0x4                // =4
  7c781c: aa0003e1     	mov	x1, x0
  7c7820: aa0403e0     	mov	x0, x4
  7c7824: d63f0060     	blr	x3
  7c7828: 7100101f     	cmp	w0, #0x4
  7c782c: 1a9f07e0     	cset	w0, ne
  7c7830: 12001c00     	and	w0, w0, #0xff
  7c7834: 7100001f     	cmp	w0, #0x0
  7c7838: 540000c0     	b.eq	0x7c7850
  7c783c: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7840: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c7844: b910301f     	str	wzr, [x0, #0x1030]
  7c7848: 52800000     	mov	w0, #0x0                // =0
  7c784c: 14000091     	b	0x7c7a90
  7c7850: b9402fe1     	ldr	w1, [sp, #0x2c]
  7c7854: 5289a9a0     	mov	w0, #0x4d4d             // =19789
  7c7858: 72a9a9a0     	movk	w0, #0x4d4d, lsl #16
  7c785c: 6b00003f     	cmp	w1, w0
  7c7860: 540000c0     	b.eq	0x7c7878
  7c7864: b9402fe1     	ldr	w1, [sp, #0x2c]
  7c7868: 52892920     	mov	w0, #0x4949             // =18761
  7c786c: 72a92920     	movk	w0, #0x4949, lsl #16
  7c7870: 6b00003f     	cmp	w1, w0
  7c7874: 54000861     	b.ne	0x7c7980
  7c7878: f9400fe0     	ldr	x0, [sp, #0x18]
  7c787c: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7880: f9681404     	ldr	x4, [x0, #0x5028]
  7c7884: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7888: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c788c: f9681400     	ldr	x0, [x0, #0x5028]
  7c7890: f9400000     	ldr	x0, [x0]
  7c7894: 91006000     	add	x0, x0, #0x18
  7c7898: f9400003     	ldr	x3, [x0]
  7c789c: 9100a3e0     	add	x0, sp, #0x28
  7c78a0: 52800082     	mov	w2, #0x4                // =4
  7c78a4: aa0003e1     	mov	x1, x0
  7c78a8: aa0403e0     	mov	x0, x4
  7c78ac: d63f0060     	blr	x3
  7c78b0: 7100101f     	cmp	w0, #0x4
  7c78b4: 1a9f07e0     	cset	w0, ne
  7c78b8: 12001c00     	and	w0, w0, #0xff
  7c78bc: 7100001f     	cmp	w0, #0x0
  7c78c0: 540000c0     	b.eq	0x7c78d8
  7c78c4: f9400fe0     	ldr	x0, [sp, #0x18]
  7c78c8: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c78cc: b910301f     	str	wzr, [x0, #0x1030]
  7c78d0: 52800000     	mov	w0, #0x0                // =0
  7c78d4: 1400006f     	b	0x7c7a90
  7c78d8: b9402be1     	ldr	w1, [sp, #0x28]
  7c78dc: 528ee900     	mov	w0, #0x7748             // =30536
  7c78e0: 72aa4c20     	movk	w0, #0x5261, lsl #16
  7c78e4: 6b00003f     	cmp	w1, w0
  7c78e8: 54000480     	b.eq	0x7c7978
  7c78ec: b9402be1     	ldr	w1, [sp, #0x28]
  7c78f0: 528eea80     	mov	w0, #0x7754             // =30548
  7c78f4: 72aa4c20     	movk	w0, #0x5261, lsl #16
  7c78f8: 6b00003f     	cmp	w1, w0
  7c78fc: 540003e0     	b.eq	0x7c7978
  7c7900: b9402be1     	ldr	w1, [sp, #0x28]
  7c7904: 528ee840     	mov	w0, #0x7742             // =30530
  7c7908: 72aa4c20     	movk	w0, #0x5261, lsl #16
  7c790c: 6b00003f     	cmp	w1, w0
  7c7910: 54000340     	b.eq	0x7c7978
  7c7914: b9402be1     	ldr	w1, [sp, #0x28]
  7c7918: 528ee860     	mov	w0, #0x7743             // =30531
  7c791c: 72aa4c20     	movk	w0, #0x5261, lsl #16
  7c7920: 6b00003f     	cmp	w1, w0
  7c7924: 540002a0     	b.eq	0x7c7978
  7c7928: b9402be1     	ldr	w1, [sp, #0x28]
  7c792c: 528c2a40     	mov	w0, #0x6152             // =24914
  7c7930: 72a90ee0     	movk	w0, #0x4877, lsl #16
  7c7934: 6b00003f     	cmp	w1, w0
  7c7938: 54000200     	b.eq	0x7c7978
  7c793c: b9402be1     	ldr	w1, [sp, #0x28]
  7c7940: 528c2a40     	mov	w0, #0x6152             // =24914
  7c7944: 72aa8ee0     	movk	w0, #0x5477, lsl #16
  7c7948: 6b00003f     	cmp	w1, w0
  7c794c: 54000160     	b.eq	0x7c7978
  7c7950: b9402be1     	ldr	w1, [sp, #0x28]
  7c7954: 528c2a40     	mov	w0, #0x6152             // =24914
  7c7958: 72a84ee0     	movk	w0, #0x4277, lsl #16
  7c795c: 6b00003f     	cmp	w1, w0
  7c7960: 540000c0     	b.eq	0x7c7978
  7c7964: b9402be1     	ldr	w1, [sp, #0x28]
  7c7968: 528c2a40     	mov	w0, #0x6152             // =24914
  7c796c: 72a86ee0     	movk	w0, #0x4377, lsl #16
  7c7970: 6b00003f     	cmp	w1, w0
  7c7974: 54000061     	b.ne	0x7c7980
  7c7978: 52800020     	mov	w0, #0x1                // =1
  7c797c: 3901bfe0     	strb	w0, [sp, #0x6f]
  7c7980: 3941bfe0     	ldrb	w0, [sp, #0x6f]
  7c7984: 52000000     	eor	w0, w0, #0x1
  7c7988: 12001c00     	and	w0, w0, #0xff
  7c798c: 7100001f     	cmp	w0, #0x0
  7c7990: 54000180     	b.eq	0x7c79c0
  7c7994: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7998: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c799c: b910301f     	str	wzr, [x0, #0x1030]
  7c79a0: 52800000     	mov	w0, #0x0                // =0
  7c79a4: 1400003b     	b	0x7c7a90
  7c79a8: d503201f     	nop
  7c79ac: 14000005     	b	0x7c79c0
  7c79b0: 52800000     	mov	w0, #0x0                // =0
  7c79b4: 14000037     	b	0x7c7a90
  7c79b8: d503201f     	nop
  7c79bc: 14000002     	b	0x7c79c4
  7c79c0: d503201f     	nop
  7c79c4: f9400fe0     	ldr	x0, [sp, #0x18]
  7c79c8: 9400058e     	bl	0x7c9000
  7c79cc: f9400fe0     	ldr	x0, [sp, #0x18]
  7c79d0: 94000032     	bl	0x7c7a98
  7c79d4: 12001c00     	and	w0, w0, #0xff
  7c79d8: 52000000     	eor	w0, w0, #0x1
  7c79dc: 12001c00     	and	w0, w0, #0xff
  7c79e0: 7100001f     	cmp	w0, #0x0
  7c79e4: 54000060     	b.eq	0x7c79f0
  7c79e8: 52800000     	mov	w0, #0x0                // =0
  7c79ec: 14000029     	b	0x7c7a90
  7c79f0: f9400fe0     	ldr	x0, [sp, #0x18]
  7c79f4: 940001e9     	bl	0x7c8198
  7c79f8: 12001c00     	and	w0, w0, #0xff
  7c79fc: 52000000     	eor	w0, w0, #0x1
  7c7a00: 12001c00     	and	w0, w0, #0xff
  7c7a04: 7100001f     	cmp	w0, #0x0
  7c7a08: 54000060     	b.eq	0x7c7a14
  7c7a0c: 52800000     	mov	w0, #0x0                // =0
  7c7a10: 14000020     	b	0x7c7a90
  7c7a14: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7a18: 940003d4     	bl	0x7c8968
  7c7a1c: 12001c00     	and	w0, w0, #0xff
  7c7a20: 52000000     	eor	w0, w0, #0x1
  7c7a24: 12001c00     	and	w0, w0, #0xff
  7c7a28: 7100001f     	cmp	w0, #0x0
  7c7a2c: 54000060     	b.eq	0x7c7a38
  7c7a30: 52800000     	mov	w0, #0x0                // =0
  7c7a34: 14000017     	b	0x7c7a90
  7c7a38: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7a3c: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c7a40: b9503000     	ldr	w0, [x0, #0x1030]
  7c7a44: 7100101f     	cmp	w0, #0x4
  7c7a48: 54000221     	b.ne	0x7c7a8c
  7c7a4c: 39405be0     	ldrb	w0, [sp, #0x16]
  7c7a50: 7100001f     	cmp	w0, #0x0
  7c7a54: 540001c0     	b.eq	0x7c7a8c
  7c7a58: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7a5c: 94000428     	bl	0x7c8afc
  7c7a60: f9400fe0     	ldr	x0, [sp, #0x18]
  7c7a64: b9428000     	ldr	w0, [x0, #0x280]
  7c7a68: 7100001f     	cmp	w0, #0x0
  7c7a6c: 54000101     	b.ne	0x7c7a8c
  7c7a70: d0002de0     	adrp	x0, 0xd85000
  7c7a74: 912f2003     	add	x3, x0, #0xbc8
  7c7a78: 528021a2     	mov	w2, #0x10d              // =269
  7c7a7c: d0002de0     	adrp	x0, 0xd85000
  7c7a80: 912c0001     	add	x1, x0, #0xb00
  7c7a84: 52800040     	mov	w0, #0x2                // =2
  7c7a88: 97fdfab1     	bl	0x74654c
  7c7a8c: 52800020     	mov	w0, #0x1                // =1
  7c7a90: a8c77bfd     	ldp	x29, x30, [sp], #0x70
  7c7a94: d65f03c0     	ret
