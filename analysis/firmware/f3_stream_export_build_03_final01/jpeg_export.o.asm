
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_stream_export_build_03_final01/jpeg_export.o:	file format elf64-littleaarch64

Disassembly of section .text.iq4_jpeg_stream_export_rgb32_01:

0000000000000000 <iq4_jpeg_stream_export_rgb32_01>:
       0: d10243ff     	sub	sp, sp, #0x90
       4: a9057bfd     	stp	x29, x30, [sp, #0x50]
       8: a9065ff8     	stp	x24, x23, [sp, #0x60]
       c: a90757f6     	stp	x22, x21, [sp, #0x70]
      10: a9084ff4     	stp	x20, x19, [sp, #0x80]
      14: 910143fd     	add	x29, sp, #0x50
      18: b40006c3     	cbz	x3, 0xf0 <iq4_jpeg_stream_export_rgb32_01+0xf0>
      1c: b4000180     	cbz	x0, 0x4c <iq4_jpeg_stream_export_rgb32_01+0x4c>
      20: b101641f     	cmn	x0, #0x59
      24: 52800028     	mov	w8, #0x1                // =1
      28: 54000668     	b.hi	0xf4 <iq4_jpeg_stream_export_rgb32_01+0xf4>
      2c: b100e47f     	cmn	x3, #0x39
      30: 54000628     	b.hi	0xf4 <iq4_jpeg_stream_export_rgb32_01+0xf4>
      34: 91016008     	add	x8, x0, #0x58
      38: eb03011f     	cmp	x8, x3
      3c: 54000089     	b.ls	0x4c <iq4_jpeg_stream_export_rgb32_01+0x4c>
      40: 9100e068     	add	x8, x3, #0x38
      44: eb00011f     	cmp	x8, x0
      48: 54000548     	b.hi	0xf0 <iq4_jpeg_stream_export_rgb32_01+0xf0>
      4c: b4000181     	cbz	x1, 0x7c <iq4_jpeg_stream_export_rgb32_01+0x7c>
      50: b100c43f     	cmn	x1, #0x31
      54: 52800028     	mov	w8, #0x1                // =1
      58: 540004e8     	b.hi	0xf4 <iq4_jpeg_stream_export_rgb32_01+0xf4>
      5c: b100e47f     	cmn	x3, #0x39
      60: 540004a8     	b.hi	0xf4 <iq4_jpeg_stream_export_rgb32_01+0xf4>
      64: 9100c028     	add	x8, x1, #0x30
      68: eb03011f     	cmp	x8, x3
      6c: 54000089     	b.ls	0x7c <iq4_jpeg_stream_export_rgb32_01+0x7c>
      70: 9100e068     	add	x8, x3, #0x38
      74: eb01011f     	cmp	x8, x1
      78: 540003c8     	b.hi	0xf0 <iq4_jpeg_stream_export_rgb32_01+0xf0>
      7c: b4000182     	cbz	x2, 0xac <iq4_jpeg_stream_export_rgb32_01+0xac>
      80: b100645f     	cmn	x2, #0x19
      84: 52800028     	mov	w8, #0x1                // =1
      88: 54000368     	b.hi	0xf4 <iq4_jpeg_stream_export_rgb32_01+0xf4>
      8c: b100e47f     	cmn	x3, #0x39
      90: 54000328     	b.hi	0xf4 <iq4_jpeg_stream_export_rgb32_01+0xf4>
      94: 91006048     	add	x8, x2, #0x18
      98: eb03011f     	cmp	x8, x3
      9c: 54000089     	b.ls	0xac <iq4_jpeg_stream_export_rgb32_01+0xac>
      a0: 9100e068     	add	x8, x3, #0x38
      a4: eb02011f     	cmp	x8, x2
      a8: 54000248     	b.hi	0xf0 <iq4_jpeg_stream_export_rgb32_01+0xf0>
      ac: b4000321     	cbz	x1, 0x110 <iq4_jpeg_stream_export_rgb32_01+0x110>
      b0: f9400029     	ldr	x9, [x1]
      b4: b40002e9     	cbz	x9, 0x110 <iq4_jpeg_stream_export_rgb32_01+0x110>
      b8: f940042a     	ldr	x10, [x1, #0x8]
      bc: b40002aa     	cbz	x10, 0x110 <iq4_jpeg_stream_export_rgb32_01+0x110>
      c0: ab0a013f     	cmn	x9, x10
      c4: 52800028     	mov	w8, #0x1                // =1
      c8: 1a9f37eb     	cset	w11, hs
      cc: b100e47f     	cmn	x3, #0x39
      d0: 54000128     	b.hi	0xf4 <iq4_jpeg_stream_export_rgb32_01+0xf4>
      d4: 3700010b     	tbnz	w11, #0x0, 0xf4 <iq4_jpeg_stream_export_rgb32_01+0xf4>
      d8: 9100e068     	add	x8, x3, #0x38
      dc: eb09011f     	cmp	x8, x9
      e0: 54000189     	b.ls	0x110 <iq4_jpeg_stream_export_rgb32_01+0x110>
      e4: 8b090148     	add	x8, x10, x9
      e8: eb03011f     	cmp	x8, x3
      ec: 54000129     	b.ls	0x110 <iq4_jpeg_stream_export_rgb32_01+0x110>
      f0: 52800028     	mov	w8, #0x1                // =1
      f4: a9484ff4     	ldp	x20, x19, [sp, #0x80]
      f8: 2a0803e0     	mov	w0, w8
      fc: a94757f6     	ldp	x22, x21, [sp, #0x70]
     100: a9465ff8     	ldp	x24, x23, [sp, #0x60]
     104: a9457bfd     	ldp	x29, x30, [sp, #0x50]
     108: 910243ff     	add	sp, sp, #0x90
     10c: d65f03c0     	ret
     110: aa0203f4     	mov	x20, x2
     114: aa0103f6     	mov	x22, x1
     118: aa0003f7     	mov	x23, x0
     11c: aa0303e0     	mov	x0, x3
     120: 2a1f03e1     	mov	w1, wzr
     124: 52800702     	mov	w2, #0x38               // =56
     128: aa0303f5     	mov	x21, x3
     12c: 94000000     	bl	0x12c <iq4_jpeg_stream_export_rgb32_01+0x12c>
		000000000000012c:  R_AARCH64_CALL26	memset
     130: b40015f7     	cbz	x23, 0x3ec <iq4_jpeg_stream_export_rgb32_01+0x3ec>
     134: b94052e9     	ldr	w9, [x23, #0x50]
     138: aa1703e8     	mov	x8, x23
     13c: 7100053f     	cmp	w9, #0x1
     140: 54001561     	b.ne	0x3ec <iq4_jpeg_stream_export_rgb32_01+0x3ec>
     144: b9404109     	ldr	w9, [x8, #0x40]
     148: 321f0129     	orr	w9, w9, #0x2
     14c: 7101493f     	cmp	w9, #0x52
     150: 540014e1     	b.ne	0x3ec <iq4_jpeg_stream_export_rgb32_01+0x3ec>
     154: f9402509     	ldr	x9, [x8, #0x48]
     158: f109213f     	cmp	x9, #0x248
     15c: 54001481     	b.ne	0x3ec <iq4_jpeg_stream_export_rgb32_01+0x3ec>
     160: f9400109     	ldr	x9, [x8]
     164: b4001449     	cbz	x9, 0x3ec <iq4_jpeg_stream_export_rgb32_01+0x3ec>
     168: f9400509     	ldr	x9, [x8, #0x8]
     16c: b4001409     	cbz	x9, 0x3ec <iq4_jpeg_stream_export_rgb32_01+0x3ec>
     170: f9400909     	ldr	x9, [x8, #0x10]
     174: b40013c9     	cbz	x9, 0x3ec <iq4_jpeg_stream_export_rgb32_01+0x3ec>
     178: f9400d09     	ldr	x9, [x8, #0x18]
     17c: b4001389     	cbz	x9, 0x3ec <iq4_jpeg_stream_export_rgb32_01+0x3ec>
     180: f9401109     	ldr	x9, [x8, #0x20]
     184: b4001349     	cbz	x9, 0x3ec <iq4_jpeg_stream_export_rgb32_01+0x3ec>
     188: f9401509     	ldr	x9, [x8, #0x28]
     18c: b4001309     	cbz	x9, 0x3ec <iq4_jpeg_stream_export_rgb32_01+0x3ec>
     190: f9401909     	ldr	x9, [x8, #0x30]
     194: b40012c9     	cbz	x9, 0x3ec <iq4_jpeg_stream_export_rgb32_01+0x3ec>
     198: f9401d08     	ldr	x8, [x8, #0x38]
     19c: b4001288     	cbz	x8, 0x3ec <iq4_jpeg_stream_export_rgb32_01+0x3ec>
     1a0: b40012d6     	cbz	x22, 0x3f8 <iq4_jpeg_stream_export_rgb32_01+0x3f8>
     1a4: aa1403e9     	mov	x9, x20
     1a8: b4001294     	cbz	x20, 0x3f8 <iq4_jpeg_stream_export_rgb32_01+0x3f8>
     1ac: f94002c1     	ldr	x1, [x22]
     1b0: aa1603e8     	mov	x8, x22
     1b4: b4001221     	cbz	x1, 0x3f8 <iq4_jpeg_stream_export_rgb32_01+0x3f8>
     1b8: f940052a     	ldr	x10, [x9, #0x8]
     1bc: b40011ea     	cbz	x10, 0x3f8 <iq4_jpeg_stream_export_rgb32_01+0x3f8>
     1c0: f9400929     	ldr	x9, [x9, #0x10]
     1c4: b40011a9     	cbz	x9, 0x3f8 <iq4_jpeg_stream_export_rgb32_01+0x3f8>
     1c8: b9401904     	ldr	w4, [x8, #0x18]
     1cc: 34001164     	cbz	w4, 0x3f8 <iq4_jpeg_stream_export_rgb32_01+0x3f8>
     1d0: 529ffb89     	mov	w9, #0xffdc             // =65500
     1d4: 6b09009f     	cmp	w4, w9
     1d8: 54001108     	b.hi	0x3f8 <iq4_jpeg_stream_export_rgb32_01+0x3f8>
     1dc: b9401d05     	ldr	w5, [x8, #0x1c]
     1e0: 129ffb89     	mov	w9, #-0xffdd            // =-65501
     1e4: 129ffb6a     	mov	w10, #-0xffdc           // =-65500
     1e8: 0b0900a9     	add	w9, w5, w9
     1ec: 6b0a013f     	cmp	w9, w10
     1f0: 54001043     	b.lo	0x3f8 <iq4_jpeg_stream_export_rgb32_01+0x3f8>
     1f4: b9402909     	ldr	w9, [x8, #0x28]
     1f8: 51019529     	sub	w9, w9, #0x65
     1fc: 3101953f     	cmn	w9, #0x65
     200: 54000fc9     	b.ls	0x3f8 <iq4_jpeg_stream_export_rgb32_01+0x3f8>
     204: a9408d02     	ldp	x2, x3, [x8, #0x8]
     208: 910043e0     	add	x0, sp, #0x10
     20c: 29441d06     	ldp	w6, w7, [x8, #0x20]
     210: 94000000     	bl	0x210 <iq4_jpeg_stream_export_rgb32_01+0x210>
		0000000000000210:  R_AARCH64_CALL26	iq4_export_pixels_init
     214: 34000f20     	cbz	w0, 0x3f8 <iq4_jpeg_stream_export_rgb32_01+0x3f8>
     218: 52800020     	mov	w0, #0x1                // =1
     21c: 5288a301     	mov	w1, #0x4518             // =17688
     220: 94000000     	bl	0x220 <iq4_jpeg_stream_export_rgb32_01+0x220>
		0000000000000220:  R_AARCH64_CALL26	calloc
     224: b4000f00     	cbz	x0, 0x404 <iq4_jpeg_stream_export_rgb32_01+0x404>
     228: ad4106e0     	ldp	q0, q1, [x23, #0x20]
     22c: 52889709     	mov	w9, #0x44b8             // =17592
     230: f9402ae8     	ldr	x8, [x23, #0x50]
     234: aa0003f3     	mov	x19, x0
     238: 91401278     	add	x24, x19, #0x4, lsl #12 // =0x4000
     23c: f9021673     	str	x19, [x19, #0x428]
     240: 3d912000     	str	q0, [x0, #0x4480]
     244: 3dc012e0     	ldr	q0, [x23, #0x40]
     248: 3d912401     	str	q1, [x0, #0x4490]
     24c: 3d912800     	str	q0, [x0, #0x44a0]
     250: ad4002e1     	ldp	q1, q0, [x23]
     254: f9225808     	str	x8, [x0, #0x44b0]
     258: f9400a88     	ldr	x8, [x20, #0x10]
     25c: 91134317     	add	x23, x24, #0x4d0
     260: f9022e73     	str	x19, [x19, #0x458]
     264: 3d911c00     	str	q0, [x0, #0x4470]
     268: 3dc00280     	ldr	q0, [x20]
     26c: 3ca96800     	str	q0, [x0, x9]
     270: b9403be9     	ldr	w9, [sp, #0x38]
     274: 3d911801     	str	q1, [x0, #0x4460]
     278: f9226408     	str	x8, [x0, #0x44c8]
     27c: 8b090520     	add	x0, x9, x9, lsl #1
     280: 52880008     	mov	w8, #0x4000             // =16384
     284: f9227e68     	str	x8, [x19, #0x44f8]
     288: f9227a60     	str	x0, [x19, #0x44f0]
     28c: 94000000     	bl	0x28c <iq4_jpeg_stream_export_rgb32_01+0x28c>
		000000000000028c:  R_AARCH64_CALL26	malloc
     290: f9228660     	str	x0, [x19, #0x4508]
     294: b4000be0     	cbz	x0, 0x410 <iq4_jpeg_stream_export_rgb32_01+0x410>
     298: 90000008     	adrp	x8, 0x0 <iq4_jpeg_stream_export_rgb32_01>
		0000000000000298:  R_AARCH64_ADR_PREL_PG_HI21	.text.start_destination
     29c: 91000108     	add	x8, x8, #0x0
		000000000000029c:  R_AARCH64_ADD_ABS_LO12_NC	.text.start_destination
     2a0: 910bc260     	add	x0, x19, #0x2f0
     2a4: f9022268     	str	x8, [x19, #0x440]
     2a8: 90000008     	adrp	x8, 0x0 <iq4_jpeg_stream_export_rgb32_01>
		00000000000002a8:  R_AARCH64_ADR_PREL_PG_HI21	.text.empty_destination
     2ac: 91000108     	add	x8, x8, #0x0
		00000000000002ac:  R_AARCH64_ADD_ABS_LO12_NC	.text.empty_destination
     2b0: f9022668     	str	x8, [x19, #0x448]
     2b4: 90000008     	adrp	x8, 0x0 <iq4_jpeg_stream_export_rgb32_01>
		00000000000002b4:  R_AARCH64_ADR_PREL_PG_HI21	.text.finish_destination
     2b8: 91000108     	add	x8, x8, #0x0
		00000000000002b8:  R_AARCH64_ADD_ABS_LO12_NC	.text.finish_destination
     2bc: f9022a68     	str	x8, [x19, #0x450]
     2c0: 94000000     	bl	0x2c0 <iq4_jpeg_stream_export_rgb32_01+0x2c0>
		00000000000002c0:  R_AARCH64_CALL26	_setjmp
     2c4: 35000aa0     	cbnz	w0, 0x418 <iq4_jpeg_stream_export_rgb32_01+0x418>
     2c8: f9623268     	ldr	x8, [x19, #0x4460]
     2cc: 91092274     	add	x20, x19, #0x248
     2d0: aa1403e0     	mov	x0, x20
     2d4: d63f0100     	blr	x8
     2d8: eb14001f     	cmp	x0, x20
     2dc: f9000260     	str	x0, [x19]
     2e0: 54000e61     	b.ne	0x4ac <iq4_jpeg_stream_export_rgb32_01+0x4ac>
     2e4: f9623668     	ldr	x8, [x19, #0x4468]
     2e8: b944a301     	ldr	w1, [x24, #0x4a0]
     2ec: 90000009     	adrp	x9, 0x0 <iq4_jpeg_stream_export_rgb32_01>
		00000000000002ec:  R_AARCH64_ADR_PREL_PG_HI21	.text.library_error
     2f0: 91000129     	add	x9, x9, #0x0
		00000000000002f0:  R_AARCH64_ADD_ABS_LO12_NC	.text.library_error
     2f4: f9625662     	ldr	x2, [x19, #0x44a8]
     2f8: aa1303e0     	mov	x0, x19
     2fc: 9110c274     	add	x20, x19, #0x430
     300: f9012669     	str	x9, [x19, #0x248]
     304: d63f0100     	blr	x8
     308: 90000008     	adrp	x8, 0x0 <iq4_jpeg_stream_export_rgb32_01>
		0000000000000308:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8
     30c: fd401fe0     	ldr	d0, [sp, #0x38]
     310: aa1303e0     	mov	x0, x19
     314: fd400101     	ldr	d1, [x8]
		0000000000000314:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8
     318: f9623a68     	ldr	x8, [x19, #0x4470]
     31c: f9001674     	str	x20, [x19, #0x28]
     320: 6d030660     	stp	d0, d1, [x19, #0x30]
     324: d63f0100     	blr	x8
     328: f9623e68     	ldr	x8, [x19, #0x4478]
     32c: b9402ac1     	ldr	w1, [x22, #0x28]
     330: aa1303e0     	mov	x0, x19
     334: 52800022     	mov	w2, #0x1                // =1
     338: b9012a7f     	str	wzr, [x19, #0x128]
     33c: b901127f     	str	wzr, [x19, #0x110]
     340: f9008e7f     	str	xzr, [x19, #0x118]
     344: d63f0100     	blr	x8
     348: f9624268     	ldr	x8, [x19, #0x4480]
     34c: aa1303e0     	mov	x0, x19
     350: 52800021     	mov	w1, #0x1                // =1
     354: d63f0100     	blr	x8
     358: b9415674     	ldr	w20, [x19, #0x154]
     35c: b9403668     	ldr	w8, [x19, #0x34]
     360: 6b08029f     	cmp	w20, w8
     364: 54000342     	b.hs	0x3cc <iq4_jpeg_stream_export_rgb32_01+0x3cc>
     368: f9628662     	ldr	x2, [x19, #0x4508]
     36c: f9627a63     	ldr	x3, [x19, #0x44f0]
     370: 910043e0     	add	x0, sp, #0x10
     374: 2a1403e1     	mov	w1, w20
     378: f90007e2     	str	x2, [sp, #0x8]
     37c: 94000000     	bl	0x37c <iq4_jpeg_stream_export_rgb32_01+0x37c>
		000000000000037c:  R_AARCH64_CALL26	iq4_export_pixels_row
     380: 340008c0     	cbz	w0, 0x498 <iq4_jpeg_stream_export_rgb32_01+0x498>
     384: f9624668     	ldr	x8, [x19, #0x4488]
     388: 910023e1     	add	x1, sp, #0x8
     38c: aa1303e0     	mov	x0, x19
     390: 52800022     	mov	w2, #0x1                // =1
     394: d63f0100     	blr	x8
     398: 7100041f     	cmp	w0, #0x1
     39c: 540007a1     	b.ne	0x490 <iq4_jpeg_stream_export_rgb32_01+0x490>
     3a0: b9415668     	ldr	w8, [x19, #0x154]
     3a4: 11000689     	add	w9, w20, #0x1
     3a8: 6b09011f     	cmp	w8, w9
     3ac: 54000721     	b.ne	0x490 <iq4_jpeg_stream_export_rgb32_01+0x490>
     3b0: b944eb09     	ldr	w9, [x24, #0x4e8]
     3b4: b940366a     	ldr	w10, [x19, #0x34]
     3b8: 2a0803f4     	mov	w20, w8
     3bc: 11000529     	add	w9, w9, #0x1
     3c0: 6b0a011f     	cmp	w8, w10
     3c4: b904eb09     	str	w9, [x24, #0x4e8]
     3c8: 54fffd03     	b.lo	0x368 <iq4_jpeg_stream_export_rgb32_01+0x368>
     3cc: f9624a68     	ldr	x8, [x19, #0x4490]
     3d0: aa1303e0     	mov	x0, x19
     3d4: d63f0100     	blr	x8
     3d8: f9627268     	ldr	x8, [x19, #0x44e0]
     3dc: f1000d1f     	cmp	x8, #0x3
     3e0: 540006a9     	b.ls	0x4b4 <iq4_jpeg_stream_export_rgb32_01+0x4b4>
     3e4: 2a1f03e8     	mov	w8, wzr
     3e8: 1400000b     	b	0x414 <iq4_jpeg_stream_export_rgb32_01+0x414>
     3ec: 52800048     	mov	w8, #0x2                // =2
     3f0: b90002a8     	str	w8, [x21]
     3f4: 17ffff40     	b	0xf4 <iq4_jpeg_stream_export_rgb32_01+0xf4>
     3f8: 52800028     	mov	w8, #0x1                // =1
     3fc: b90002a8     	str	w8, [x21]
     400: 17ffff3d     	b	0xf4 <iq4_jpeg_stream_export_rgb32_01+0xf4>
     404: 52800068     	mov	w8, #0x3                // =3
     408: b90002a8     	str	w8, [x21]
     40c: 17ffff3a     	b	0xf4 <iq4_jpeg_stream_export_rgb32_01+0xf4>
     410: 52800068     	mov	w8, #0x3                // =3
     414: b90002e8     	str	w8, [x23]
     418: f9400668     	ldr	x8, [x19, #0x8]
     41c: b4000168     	cbz	x8, 0x448 <iq4_jpeg_stream_export_rgb32_01+0x448>
     420: b9451308     	ldr	w8, [x24, #0x510]
     424: 35000128     	cbnz	w8, 0x448 <iq4_jpeg_stream_export_rgb32_01+0x448>
     428: b944ef08     	ldr	w8, [x24, #0x4ec]
     42c: 52800029     	mov	w9, #0x1                // =1
     430: aa1303e0     	mov	x0, x19
     434: b9051309     	str	w9, [x24, #0x510]
     438: f9624e69     	ldr	x9, [x19, #0x4498]
     43c: 11000508     	add	w8, w8, #0x1
     440: b904ef08     	str	w8, [x24, #0x4ec]
     444: d63f0120     	blr	x9
     448: b94002e8     	ldr	w8, [x23]
     44c: 34000068     	cbz	w8, 0x458 <iq4_jpeg_stream_export_rgb32_01+0x458>
     450: aa1f03e8     	mov	x8, xzr
     454: 14000002     	b	0x45c <iq4_jpeg_stream_export_rgb32_01+0x45c>
     458: f9627268     	ldr	x8, [x19, #0x44e0]
     45c: f9226e68     	str	x8, [x19, #0x44d8]
     460: f9628660     	ldr	x0, [x19, #0x4508]
     464: ad4006e0     	ldp	q0, q1, [x23]
     468: 3dc00ae2     	ldr	q2, [x23, #0x20]
     46c: f9401ae8     	ldr	x8, [x23, #0x30]
     470: 3d800aa2     	str	q2, [x21, #0x20]
     474: ad0006a0     	stp	q0, q1, [x21]
     478: f9001aa8     	str	x8, [x21, #0x30]
     47c: 94000000     	bl	0x47c <iq4_jpeg_stream_export_rgb32_01+0x47c>
		000000000000047c:  R_AARCH64_CALL26	free
     480: aa1303e0     	mov	x0, x19
     484: 94000000     	bl	0x484 <iq4_jpeg_stream_export_rgb32_01+0x484>
		0000000000000484:  R_AARCH64_CALL26	free
     488: b94002a8     	ldr	w8, [x21]
     48c: 17ffff1a     	b	0xf4 <iq4_jpeg_stream_export_rgb32_01+0xf4>
     490: 528000e8     	mov	w8, #0x7                // =7
     494: 14000002     	b	0x49c <iq4_jpeg_stream_export_rgb32_01+0x49c>
     498: 52800028     	mov	w8, #0x1                // =1
     49c: 910bc260     	add	x0, x19, #0x2f0
     4a0: 52800021     	mov	w1, #0x1                // =1
     4a4: b90002e8     	str	w8, [x23]
     4a8: 94000000     	bl	0x4a8 <iq4_jpeg_stream_export_rgb32_01+0x4a8>
		00000000000004a8:  R_AARCH64_CALL26	longjmp
     4ac: 52800048     	mov	w8, #0x2                // =2
     4b0: 17fffffb     	b	0x49c <iq4_jpeg_stream_export_rgb32_01+0x49c>
     4b4: 528000c8     	mov	w8, #0x6                // =6
     4b8: 17fffff9     	b	0x49c <iq4_jpeg_stream_export_rgb32_01+0x49c>

Disassembly of section .text.start_destination:

0000000000000000 <start_destination>:
       0: f9401409     	ldr	x9, [x0, #0x28]
       4: 52880008     	mov	w8, #0x4000             // =16384
       8: 9100c12a     	add	x10, x9, #0x30
       c: a900212a     	stp	x10, x8, [x9]
      10: d65f03c0     	ret

Disassembly of section .text.empty_destination:

0000000000000000 <empty_destination>:
       0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
       4: a9014ff4     	stp	x20, x19, [sp, #0x10]
       8: 910003fd     	mov	x29, sp
       c: f9401414     	ldr	x20, [x0, #0x28]
      10: f9401693     	ldr	x19, [x20, #0x28]
      14: f9627268     	ldr	x8, [x19, #0x44e0]
      18: f9626669     	ldr	x9, [x19, #0x44c8]
      1c: eb080128     	subs	x8, x9, x8
      20: d34efd08     	lsr	x8, x8, #14
      24: fa402904     	ccmp	x8, #0x0, #0x4, hs
      28: 540002e0     	b.eq	0x84 <empty_destination+0x84>
      2c: f9626268     	ldr	x8, [x19, #0x44c0]
      30: f9625e60     	ldr	x0, [x19, #0x44b8]
      34: 91118261     	add	x1, x19, #0x460
      38: 52880002     	mov	w2, #0x4000             // =16384
      3c: d63f0100     	blr	x8
      40: f140101f     	cmp	x0, #0x4, lsl #12       // =0x4000
      44: 540001a8     	b.hi	0x78 <empty_destination+0x78>
      48: f9627268     	ldr	x8, [x19, #0x44e0]
      4c: f140101f     	cmp	x0, #0x4, lsl #12       // =0x4000
      50: 8b000108     	add	x8, x8, x0
      54: f9227268     	str	x8, [x19, #0x44e0]
      58: 54000101     	b.ne	0x78 <empty_destination+0x78>
      5c: 9100c288     	add	x8, x20, #0x30
      60: 52880009     	mov	w9, #0x4000             // =16384
      64: 52800020     	mov	w0, #0x1                // =1
      68: a9002688     	stp	x8, x9, [x20]
      6c: a9414ff4     	ldp	x20, x19, [sp, #0x10]
      70: a8c27bfd     	ldp	x29, x30, [sp], #0x20
      74: d65f03c0     	ret
      78: 52889a08     	mov	w8, #0x44d0             // =17616
      7c: 528000a9     	mov	w9, #0x5                // =5
      80: 14000003     	b	0x8c <empty_destination+0x8c>
      84: 52889a08     	mov	w8, #0x44d0             // =17616
      88: 52800089     	mov	w9, #0x4                // =4
      8c: 910bc260     	add	x0, x19, #0x2f0
      90: 52800021     	mov	w1, #0x1                // =1
      94: b8286a69     	str	w9, [x19, x8]
      98: 94000000     	bl	0x98 <empty_destination+0x98>
		0000000000000098:  R_AARCH64_CALL26	longjmp

Disassembly of section .text.finish_destination:

0000000000000000 <finish_destination>:
       0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
       4: a9014ff4     	stp	x20, x19, [sp, #0x10]
       8: 910003fd     	mov	x29, sp
       c: f9401409     	ldr	x9, [x0, #0x28]
      10: f9400528     	ldr	x8, [x9, #0x8]
      14: f9401534     	ldr	x20, [x9, #0x28]
      18: f140111f     	cmp	x8, #0x4, lsl #12       // =0x4000
      1c: 54000348     	b.hi	0x84 <finish_destination+0x84>
      20: f140111f     	cmp	x8, #0x4, lsl #12       // =0x4000
      24: 540002a0     	b.eq	0x78 <finish_destination+0x78>
      28: f9627289     	ldr	x9, [x20, #0x44e0]
      2c: f962668a     	ldr	x10, [x20, #0x44c8]
      30: eb090149     	subs	x9, x10, x9
      34: 540002e3     	b.lo	0x90 <finish_destination+0x90>
      38: 5288000a     	mov	w10, #0x4000            // =16384
      3c: cb080153     	sub	x19, x10, x8
      40: eb09027f     	cmp	x19, x9
      44: 54000268     	b.hi	0x90 <finish_destination+0x90>
      48: f9626288     	ldr	x8, [x20, #0x44c0]
      4c: f9625e80     	ldr	x0, [x20, #0x44b8]
      50: 91118281     	add	x1, x20, #0x460
      54: aa1303e2     	mov	x2, x19
      58: d63f0100     	blr	x8
      5c: eb13001f     	cmp	x0, x19
      60: 54000088     	b.hi	0x70 <finish_destination+0x70>
      64: f9627288     	ldr	x8, [x20, #0x44e0]
      68: 8b000108     	add	x8, x8, x0
      6c: f9227288     	str	x8, [x20, #0x44e0]
      70: eb13001f     	cmp	x0, x19
      74: 54000141     	b.ne	0x9c <finish_destination+0x9c>
      78: a9414ff4     	ldp	x20, x19, [sp, #0x10]
      7c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
      80: d65f03c0     	ret
      84: 52889a08     	mov	w8, #0x44d0             // =17616
      88: 528000c9     	mov	w9, #0x6                // =6
      8c: 14000006     	b	0xa4 <finish_destination+0xa4>
      90: 52889a08     	mov	w8, #0x44d0             // =17616
      94: 52800089     	mov	w9, #0x4                // =4
      98: 14000003     	b	0xa4 <finish_destination+0xa4>
      9c: 52889a08     	mov	w8, #0x44d0             // =17616
      a0: 528000a9     	mov	w9, #0x5                // =5
      a4: 910bc280     	add	x0, x20, #0x2f0
      a8: 52800021     	mov	w1, #0x1                // =1
      ac: b8286a89     	str	w9, [x20, x8]
      b0: 94000000     	bl	0xb0 <finish_destination+0xb0>
		00000000000000b0:  R_AARCH64_CALL26	longjmp

Disassembly of section .text.library_error:

0000000000000000 <library_error>:
       0: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
       4: 910003fd     	mov	x29, sp
       8: f9400009     	ldr	x9, [x0]
       c: 52800108     	mov	w8, #0x8                // =8
      10: 52800021     	mov	w1, #0x1                // =1
      14: f940f12a     	ldr	x10, [x9, #0x1e0]
      18: b9402929     	ldr	w9, [x9, #0x28]
      1c: 9140114b     	add	x11, x10, #0x4, lsl #12 // =0x4000
      20: 910bc140     	add	x0, x10, #0x2f0
      24: b945116c     	ldr	w12, [x11, #0x510]
      28: b9050169     	str	w9, [x11, #0x500]
      2c: 7100019f     	cmp	w12, #0x0
      30: 528000cc     	mov	w12, #0x6               // =6
      34: 1a880188     	csel	w8, w12, w8, eq
      38: b904d168     	str	w8, [x11, #0x4d0]
      3c: 94000000     	bl	0x3c <library_error+0x3c>
		000000000000003c:  R_AARCH64_CALL26	longjmp
