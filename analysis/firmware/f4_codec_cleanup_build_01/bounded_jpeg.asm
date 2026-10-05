
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f4_codec_cleanup_build_01/bounded_jpeg_1.o:	file format elf64-littleaarch64

Disassembly of section .text.iq4_jpeg_encode_bounded:

0000000000000000 <iq4_jpeg_encode_bounded>:
       0: b40001e4     	cbz	x4, 0x3c <iq4_jpeg_encode_bounded+0x3c>
       4: b4000220     	cbz	x0, 0x48 <iq4_jpeg_encode_bounded+0x48>
       8: 52800025     	mov	w5, #0x1                // =1
       c: b101641f     	cmn	x0, #0x59
      10: 54000128     	b.hi	0x34 <iq4_jpeg_encode_bounded+0x34>
      14: b103849f     	cmn	x4, #0xe1
      18: 540000e8     	b.hi	0x34 <iq4_jpeg_encode_bounded+0x34>
      1c: 91016008     	add	x8, x0, #0x58
      20: eb04011f     	cmp	x8, x4
      24: 54000129     	b.ls	0x48 <iq4_jpeg_encode_bounded+0x48>
      28: 91038088     	add	x8, x4, #0xe0
      2c: eb00011f     	cmp	x8, x0
      30: 540000c9     	b.ls	0x48 <iq4_jpeg_encode_bounded+0x48>
      34: 2a0503e0     	mov	w0, w5
      38: d65f03c0     	ret
      3c: 52800025     	mov	w5, #0x1                // =1
      40: 2a0503e0     	mov	w0, w5
      44: d65f03c0     	ret
      48: b40002e1     	cbz	x1, 0xa4 <iq4_jpeg_encode_bounded+0xa4>
      4c: 52800025     	mov	w5, #0x1                // =1
      50: b100a43f     	cmn	x1, #0x29
      54: 54ffff08     	b.hi	0x34 <iq4_jpeg_encode_bounded+0x34>
      58: b103849f     	cmn	x4, #0xe1
      5c: 54fffec8     	b.hi	0x34 <iq4_jpeg_encode_bounded+0x34>
      60: 9100a028     	add	x8, x1, #0x28
      64: eb04011f     	cmp	x8, x4
      68: 91038088     	add	x8, x4, #0xe0
      6c: 54000069     	b.ls	0x78 <iq4_jpeg_encode_bounded+0x78>
      70: eb01011f     	cmp	x8, x1
      74: 54fffe08     	b.hi	0x34 <iq4_jpeg_encode_bounded+0x34>
      78: f9400029     	ldr	x9, [x1]
      7c: b4000149     	cbz	x9, 0xa4 <iq4_jpeg_encode_bounded+0xa4>
      80: f940042a     	ldr	x10, [x1, #0x8]
      84: b400010a     	cbz	x10, 0xa4 <iq4_jpeg_encode_bounded+0xa4>
      88: ab0a013f     	cmn	x9, x10
      8c: 54fffd42     	b.hs	0x34 <iq4_jpeg_encode_bounded+0x34>
      90: eb09011f     	cmp	x8, x9
      94: 54000089     	b.ls	0xa4 <iq4_jpeg_encode_bounded+0xa4>
      98: 8b090148     	add	x8, x10, x9
      9c: eb04011f     	cmp	x8, x4
      a0: 54fffca8     	b.hi	0x34 <iq4_jpeg_encode_bounded+0x34>
      a4: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
      a8: f9000bf9     	str	x25, [sp, #0x10]
      ac: a9025ff8     	stp	x24, x23, [sp, #0x20]
      b0: a90357f6     	stp	x22, x21, [sp, #0x30]
      b4: a9044ff4     	stp	x20, x19, [sp, #0x40]
      b8: 910003fd     	mov	x29, sp
      bc: 6f00e400     	movi	v0.2d, #0000000000000000
      c0: 90000008     	adrp	x8, 0x0 <iq4_jpeg_encode_bounded>
		00000000000000c0:  R_AARCH64_ADR_PREL_PG_HI21	.bss.retained_contexts
      c4: 91000108     	add	x8, x8, #0x0
		00000000000000c4:  R_AARCH64_ADD_ABS_LO12_NC	.bss.retained_contexts
      c8: ad000080     	stp	q0, q0, [x4]
      cc: ad010080     	stp	q0, q0, [x4, #0x20]
      d0: ad020080     	stp	q0, q0, [x4, #0x40]
      d4: ad030080     	stp	q0, q0, [x4, #0x60]
      d8: ad040080     	stp	q0, q0, [x4, #0x80]
      dc: ad050080     	stp	q0, q0, [x4, #0xa0]
      e0: ad060080     	stp	q0, q0, [x4, #0xc0]
      e4: c8dffd08     	ldar	x8, [x8]
      e8: b4000108     	cbz	x8, 0x108 <iq4_jpeg_encode_bounded+0x108>
      ec: 528000d3     	mov	w19, #0x6               // =6
      f0: aa0403e0     	mov	x0, x4
      f4: 528018e8     	mov	w8, #0xc7               // =199
      f8: b8018413     	str	w19, [x0], #0x18
      fc: 90000001     	adrp	x1, 0x0 <iq4_jpeg_encode_bounded>
		00000000000000fc:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x198
     100: 91000021     	add	x1, x1, #0x0
		0000000000000100:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x198
     104: 1400002f     	b	0x1c0 <iq4_jpeg_encode_bounded+0x1c0>
     108: b4000182     	cbz	x2, 0x138 <iq4_jpeg_encode_bounded+0x138>
     10c: b4000163     	cbz	x3, 0x138 <iq4_jpeg_encode_bounded+0x138>
     110: ab03005f     	cmn	x2, x3
     114: 540004a2     	b.hs	0x1a8 <iq4_jpeg_encode_bounded+0x1a8>
     118: b103849f     	cmn	x4, #0xe1
     11c: 54000468     	b.hi	0x1a8 <iq4_jpeg_encode_bounded+0x1a8>
     120: 8b020068     	add	x8, x3, x2
     124: eb04011f     	cmp	x8, x4
     128: 54000089     	b.ls	0x138 <iq4_jpeg_encode_bounded+0x138>
     12c: 91038088     	add	x8, x4, #0xe0
     130: eb02011f     	cmp	x8, x2
     134: 540003a8     	b.hi	0x1a8 <iq4_jpeg_encode_bounded+0x1a8>
     138: b40001c3     	cbz	x3, 0x170 <iq4_jpeg_encode_bounded+0x170>
     13c: b40001a0     	cbz	x0, 0x170 <iq4_jpeg_encode_bounded+0x170>
     140: b4000182     	cbz	x2, 0x170 <iq4_jpeg_encode_bounded+0x170>
     144: ab03005f     	cmn	x2, x3
     148: 1a9f37e8     	cset	w8, hs
     14c: b101641f     	cmn	x0, #0x59
     150: 540002c8     	b.hi	0x1a8 <iq4_jpeg_encode_bounded+0x1a8>
     154: 370002a8     	tbnz	w8, #0x0, 0x1a8 <iq4_jpeg_encode_bounded+0x1a8>
     158: 91016008     	add	x8, x0, #0x58
     15c: eb02011f     	cmp	x8, x2
     160: 54000089     	b.ls	0x170 <iq4_jpeg_encode_bounded+0x170>
     164: 8b020068     	add	x8, x3, x2
     168: eb00011f     	cmp	x8, x0
     16c: 540001e8     	b.hi	0x1a8 <iq4_jpeg_encode_bounded+0x1a8>
     170: b40003c3     	cbz	x3, 0x1e8 <iq4_jpeg_encode_bounded+0x1e8>
     174: b40003a1     	cbz	x1, 0x1e8 <iq4_jpeg_encode_bounded+0x1e8>
     178: b4000382     	cbz	x2, 0x1e8 <iq4_jpeg_encode_bounded+0x1e8>
     17c: ab03005f     	cmn	x2, x3
     180: 1a9f37e8     	cset	w8, hs
     184: b100a43f     	cmn	x1, #0x29
     188: 54000108     	b.hi	0x1a8 <iq4_jpeg_encode_bounded+0x1a8>
     18c: 370000e8     	tbnz	w8, #0x0, 0x1a8 <iq4_jpeg_encode_bounded+0x1a8>
     190: 9100a028     	add	x8, x1, #0x28
     194: eb02011f     	cmp	x8, x2
     198: 54000289     	b.ls	0x1e8 <iq4_jpeg_encode_bounded+0x1e8>
     19c: 8b020068     	add	x8, x3, x2
     1a0: eb01011f     	cmp	x8, x1
     1a4: 54000229     	b.ls	0x1e8 <iq4_jpeg_encode_bounded+0x1e8>
     1a8: 52800033     	mov	w19, #0x1               // =1
     1ac: aa0403e0     	mov	x0, x4
     1b0: 528018e8     	mov	w8, #0xc7               // =199
     1b4: b8018413     	str	w19, [x0], #0x18
     1b8: 90000001     	adrp	x1, 0x0 <iq4_jpeg_encode_bounded>
		00000000000001b8:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xeb
     1bc: 91000021     	add	x1, x1, #0x0
		00000000000001bc:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xeb
     1c0: 2a0803e2     	mov	w2, w8
     1c4: 94000000     	bl	0x1c4 <iq4_jpeg_encode_bounded+0x1c4>
		00000000000001c4:  R_AARCH64_CALL26	strncpy
     1c8: 2a1303e5     	mov	w5, w19
     1cc: a9444ff4     	ldp	x20, x19, [sp, #0x40]
     1d0: f9400bf9     	ldr	x25, [sp, #0x10]
     1d4: a94357f6     	ldp	x22, x21, [sp, #0x30]
     1d8: a9425ff8     	ldp	x24, x23, [sp, #0x20]
     1dc: a8c57bfd     	ldp	x29, x30, [sp], #0x50
     1e0: 2a0503e0     	mov	w0, w5
     1e4: d65f03c0     	ret
     1e8: aa0203f9     	mov	x25, x2
     1ec: aa0303f5     	mov	x21, x3
     1f0: aa0103f8     	mov	x24, x1
     1f4: aa0403f6     	mov	x22, x4
     1f8: aa0003f7     	mov	x23, x0
     1fc: 94000000     	bl	0x1fc <iq4_jpeg_encode_bounded+0x1fc>
		00000000000001fc:  R_AARCH64_CALL26	.text.api_valid
     200: 34000440     	cbz	w0, 0x288 <iq4_jpeg_encode_bounded+0x288>
     204: aa1603e0     	mov	x0, x22
     208: b4000358     	cbz	x24, 0x270 <iq4_jpeg_encode_bounded+0x270>
     20c: 92a10009     	mov	x9, #-0x8000001         // =-134217729
     210: b26593eb     	mov	x11, #-0x8000000        // =-134217728
     214: aa1503e8     	mov	x8, x21
     218: 8b0902a9     	add	x9, x21, x9
     21c: eb0b013f     	cmp	x9, x11
     220: 54000283     	b.lo	0x270 <iq4_jpeg_encode_bounded+0x270>
     224: b4000279     	cbz	x25, 0x270 <iq4_jpeg_encode_bounded+0x270>
     228: f9400309     	ldr	x9, [x24]
     22c: aa1803ea     	mov	x10, x24
     230: b4000209     	cbz	x9, 0x270 <iq4_jpeg_encode_bounded+0x270>
     234: b940114b     	ldr	w11, [x10, #0x10]
     238: 340001cb     	cbz	w11, 0x270 <iq4_jpeg_encode_bounded+0x270>
     23c: 529ffb8d     	mov	w13, #0xffdc            // =65500
     240: 6b0d017f     	cmp	w11, w13
     244: 54000168     	b.hi	0x270 <iq4_jpeg_encode_bounded+0x270>
     248: b940154d     	ldr	w13, [x10, #0x14]
     24c: 129ffb8c     	mov	w12, #-0xffdd           // =-65501
     250: 129ffb6e     	mov	w14, #-0xffdc           // =-65500
     254: 0b0c01ac     	add	w12, w13, w12
     258: 6b0e019f     	cmp	w12, w14
     25c: 540000a3     	b.lo	0x270 <iq4_jpeg_encode_bounded+0x270>
     260: b940214c     	ldr	w12, [x10, #0x20]
     264: 5101958c     	sub	w12, w12, #0x65
     268: 3101959f     	cmn	w12, #0x65
     26c: 540001c8     	b.hi	0x2a4 <iq4_jpeg_encode_bounded+0x2a4>
     270: 52800033     	mov	w19, #0x1               // =1
     274: 528018e8     	mov	w8, #0xc7               // =199
     278: 90000001     	adrp	x1, 0x0 <iq4_jpeg_encode_bounded>
		0000000000000278:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1
     27c: 91000021     	add	x1, x1, #0x0
		000000000000027c:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1
     280: b8018413     	str	w19, [x0], #0x18
     284: 17ffffcf     	b	0x1c0 <iq4_jpeg_encode_bounded+0x1c0>
     288: 52800053     	mov	w19, #0x2               // =2
     28c: aa1603e0     	mov	x0, x22
     290: 528018e8     	mov	w8, #0xc7               // =199
     294: b8018413     	str	w19, [x0], #0x18
     298: 90000001     	adrp	x1, 0x0 <iq4_jpeg_encode_bounded>
		0000000000000298:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x2f
     29c: 91000021     	add	x1, x1, #0x0
		000000000000029c:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x2f
     2a0: 17ffffc8     	b	0x1c0 <iq4_jpeg_encode_bounded+0x1c0>
     2a4: 8b0b056b     	add	x11, x11, x11, lsl #1
     2a8: f9400d4c     	ldr	x12, [x10, #0x18]
     2ac: eb0b019f     	cmp	x12, x11
     2b0: 540000e2     	b.hs	0x2cc <iq4_jpeg_encode_bounded+0x2cc>
     2b4: 52800033     	mov	w19, #0x1               // =1
     2b8: 528018e8     	mov	w8, #0xc7               // =199
     2bc: 90000001     	adrp	x1, 0x0 <iq4_jpeg_encode_bounded>
		00000000000002bc:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x178
     2c0: 91000021     	add	x1, x1, #0x0
		00000000000002c0:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x178
     2c4: b8018413     	str	w19, [x0], #0x18
     2c8: 17ffffbe     	b	0x1c0 <iq4_jpeg_encode_bounded+0x1c0>
     2cc: 710005ad     	subs	w13, w13, #0x1
     2d0: 54000061     	b.ne	0x2dc <iq4_jpeg_encode_bounded+0x2dc>
     2d4: aa1f03ed     	mov	x13, xzr
     2d8: 14000005     	b	0x2ec <iq4_jpeg_encode_bounded+0x2ec>
     2dc: aa2b03ee     	mvn	x14, x11
     2e0: 9acd09ce     	udiv	x14, x14, x13
     2e4: eb0e019f     	cmp	x12, x14
     2e8: 54fffe68     	b.hi	0x2b4 <iq4_jpeg_encode_bounded+0x2b4>
     2ec: 9b0d2d8b     	madd	x11, x12, x13, x11
     2f0: f940054a     	ldr	x10, [x10, #0x8]
     2f4: eb0a017f     	cmp	x11, x10
     2f8: 540000e9     	b.ls	0x314 <iq4_jpeg_encode_bounded+0x314>
     2fc: 52800033     	mov	w19, #0x1               // =1
     300: 528018e8     	mov	w8, #0xc7               // =199
     304: 90000001     	adrp	x1, 0x0 <iq4_jpeg_encode_bounded>
		0000000000000304:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x69
     308: 91000021     	add	x1, x1, #0x0
		0000000000000308:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x69
     30c: b8018413     	str	w19, [x0], #0x18
     310: 17ffffac     	b	0x1c0 <iq4_jpeg_encode_bounded+0x1c0>
     314: ab0a013f     	cmn	x9, x10
     318: 1a9f37ec     	cset	w12, hs
     31c: ab08033f     	cmn	x25, x8
     320: 54000122     	b.hs	0x344 <iq4_jpeg_encode_bounded+0x344>
     324: 3700010c     	tbnz	w12, #0x0, 0x344 <iq4_jpeg_encode_bounded+0x344>
     328: 8b190108     	add	x8, x8, x25
     32c: aa1903eb     	mov	x11, x25
     330: eb09011f     	cmp	x8, x9
     334: 54000149     	b.ls	0x35c <iq4_jpeg_encode_bounded+0x35c>
     338: 8b090148     	add	x8, x10, x9
     33c: eb0b011f     	cmp	x8, x11
     340: 540000e9     	b.ls	0x35c <iq4_jpeg_encode_bounded+0x35c>
     344: 52800033     	mov	w19, #0x1               // =1
     348: 528018e8     	mov	w8, #0xc7               // =199
     34c: 90000001     	adrp	x1, 0x0 <iq4_jpeg_encode_bounded>
		000000000000034c:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xbc
     350: 91000021     	add	x1, x1, #0x0
		0000000000000350:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xbc
     354: b8018413     	str	w19, [x0], #0x18
     358: 17ffff9a     	b	0x1c0 <iq4_jpeg_encode_bounded+0x1c0>
     35c: 52800028     	mov	w8, #0x1                // =1
     360: 5280ae09     	mov	w9, #0x570              // =1392
     364: 2a0803e0     	mov	w0, w8
     368: 2a0903e1     	mov	w1, w9
     36c: 94000000     	bl	0x36c <iq4_jpeg_encode_bounded+0x36c>
		000000000000036c:  R_AARCH64_CALL26	calloc
     370: b4000c40     	cbz	x0, 0x4f8 <iq4_jpeg_encode_bounded+0x4f8>
     374: aa0003f4     	mov	x20, x0
     378: 90000008     	adrp	x8, 0x0 <iq4_jpeg_encode_bounded>
		0000000000000378:  R_AARCH64_ADR_PREL_PG_HI21	.text.init_destination
     37c: 91000108     	add	x8, x8, #0x0
		000000000000037c:  R_AARCH64_ADD_ABS_LO12_NC	.text.init_destination
     380: f9022288     	str	x8, [x20, #0x440]
     384: 90000008     	adrp	x8, 0x0 <iq4_jpeg_encode_bounded>
		0000000000000384:  R_AARCH64_ADR_PREL_PG_HI21	.text.empty_output_buffer
     388: 91000108     	add	x8, x8, #0x0
		0000000000000388:  R_AARCH64_ADD_ABS_LO12_NC	.text.empty_output_buffer
     38c: aa0003f3     	mov	x19, x0
     390: f9022688     	str	x8, [x20, #0x448]
     394: 90000008     	adrp	x8, 0x0 <iq4_jpeg_encode_bounded>
		0000000000000394:  R_AARCH64_ADR_PREL_PG_HI21	.text.term_destination
     398: 91000108     	add	x8, x8, #0x0
		0000000000000398:  R_AARCH64_ADD_ABS_LO12_NC	.text.term_destination
     39c: 910bc000     	add	x0, x0, #0x2f0
     3a0: f9023e97     	str	x23, [x20, #0x478]
     3a4: f9021694     	str	x20, [x20, #0x428]
     3a8: f9023a94     	str	x20, [x20, #0x470]
     3ac: f9022e99     	str	x25, [x20, #0x458]
     3b0: f9023295     	str	x21, [x20, #0x460]
     3b4: f9022a88     	str	x8, [x20, #0x450]
     3b8: 94000000     	bl	0x3b8 <iq4_jpeg_encode_bounded+0x3b8>
		00000000000003b8:  R_AARCH64_CALL26	_setjmp
     3bc: 35000d60     	cbnz	w0, 0x568 <iq4_jpeg_encode_bounded+0x568>
     3c0: f94002e8     	ldr	x8, [x23]
     3c4: 91092280     	add	x0, x20, #0x248
     3c8: 9110c299     	add	x25, x20, #0x430
     3cc: d63f0100     	blr	x8
     3d0: 90000008     	adrp	x8, 0x0 <iq4_jpeg_encode_bounded>
		00000000000003d0:  R_AARCH64_ADR_PREL_PG_HI21	.text.error_exit
     3d4: 91000108     	add	x8, x8, #0x0
		00000000000003d4:  R_AARCH64_ADD_ABS_LO12_NC	.text.error_exit
     3d8: b94042e1     	ldr	w1, [x23, #0x40]
     3dc: f9012668     	str	x8, [x19, #0x248]
     3e0: f94006e8     	ldr	x8, [x23, #0x8]
     3e4: f94026e2     	ldr	x2, [x23, #0x48]
     3e8: f9000260     	str	x0, [x19]
     3ec: aa1303e0     	mov	x0, x19
     3f0: f9000e73     	str	x19, [x19, #0x18]
     3f4: d63f0100     	blr	x8
     3f8: 90000008     	adrp	x8, 0x0 <iq4_jpeg_encode_bounded>
		00000000000003f8:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8
     3fc: fd400b00     	ldr	d0, [x24, #0x10]
     400: aa1303e0     	mov	x0, x19
     404: fd400101     	ldr	d1, [x8]
		0000000000000404:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8
     408: f9400ae8     	ldr	x8, [x23, #0x10]
     40c: f9001679     	str	x25, [x19, #0x28]
     410: 6d030660     	stp	d0, d1, [x19, #0x30]
     414: d63f0100     	blr	x8
     418: f9400ee8     	ldr	x8, [x23, #0x18]
     41c: b9402301     	ldr	w1, [x24, #0x20]
     420: aa1303e0     	mov	x0, x19
     424: 52800022     	mov	w2, #0x1                // =1
     428: d63f0100     	blr	x8
     42c: f94012e8     	ldr	x8, [x23, #0x20]
     430: aa1303e0     	mov	x0, x19
     434: 52800021     	mov	w1, #0x1                // =1
     438: d63f0100     	blr	x8
     43c: b9415668     	ldr	w8, [x19, #0x154]
     440: b9403669     	ldr	w9, [x19, #0x34]
     444: eb09011f     	cmp	x8, x9
     448: 540002a2     	b.hs	0x49c <iq4_jpeg_encode_bounded+0x49c>
     44c: 910063b5     	add	x21, x29, #0x18
     450: f9400f0a     	ldr	x10, [x24, #0x18]
     454: aa0803f9     	mov	x25, x8
     458: f9400308     	ldr	x8, [x24]
     45c: f94016e9     	ldr	x9, [x23, #0x28]
     460: aa1303e0     	mov	x0, x19
     464: aa1503e1     	mov	x1, x21
     468: 9b192148     	madd	x8, x10, x25, x8
     46c: 52800022     	mov	w2, #0x1                // =1
     470: f9000fa8     	str	x8, [x29, #0x18]
     474: d63f0120     	blr	x9
     478: 7100041f     	cmp	w0, #0x1
     47c: 54000641     	b.ne	0x544 <iq4_jpeg_encode_bounded+0x544>
     480: b9415668     	ldr	w8, [x19, #0x154]
     484: 91000729     	add	x9, x25, #0x1
     488: eb09011f     	cmp	x8, x9
     48c: 540005c1     	b.ne	0x544 <iq4_jpeg_encode_bounded+0x544>
     490: b9403669     	ldr	w9, [x19, #0x34]
     494: eb09011f     	cmp	x8, x9
     498: 54fffdc3     	b.lo	0x450 <iq4_jpeg_encode_bounded+0x450>
     49c: f9401ae8     	ldr	x8, [x23, #0x30]
     4a0: aa1303e0     	mov	x0, x19
     4a4: d63f0100     	blr	x8
     4a8: f9423668     	ldr	x8, [x19, #0x468]
     4ac: f100111f     	cmp	x8, #0x4
     4b0: 54000323     	b.lo	0x514 <iq4_jpeg_encode_bounded+0x514>
     4b4: f9422e69     	ldr	x9, [x19, #0x458]
     4b8: 3940012a     	ldrb	w10, [x9]
     4bc: 7103fd5f     	cmp	w10, #0xff
     4c0: 540002a1     	b.ne	0x514 <iq4_jpeg_encode_bounded+0x514>
     4c4: 3940052a     	ldrb	w10, [x9, #0x1]
     4c8: 7103615f     	cmp	w10, #0xd8
     4cc: 54000241     	b.ne	0x514 <iq4_jpeg_encode_bounded+0x514>
     4d0: 8b080129     	add	x9, x9, x8
     4d4: 385fe12a     	ldurb	w10, [x9, #-0x2]
     4d8: 7103fd5f     	cmp	w10, #0xff
     4dc: 540001c1     	b.ne	0x514 <iq4_jpeg_encode_bounded+0x514>
     4e0: 385ff129     	ldurb	w9, [x9, #-0x1]
     4e4: 7103653f     	cmp	w9, #0xd9
     4e8: 54000161     	b.ne	0x514 <iq4_jpeg_encode_bounded+0x514>
     4ec: b904827f     	str	wzr, [x19, #0x480]
     4f0: f9024668     	str	x8, [x19, #0x488]
     4f4: 1400001d     	b	0x568 <iq4_jpeg_encode_bounded+0x568>
     4f8: 528000b3     	mov	w19, #0x5               // =5
     4fc: aa1603e0     	mov	x0, x22
     500: 528018e8     	mov	w8, #0xc7               // =199
     504: b8018413     	str	w19, [x0], #0x18
     508: 90000001     	adrp	x1, 0x0 <iq4_jpeg_encode_bounded>
		0000000000000508:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x1d6
     50c: 91000021     	add	x1, x1, #0x0
		000000000000050c:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x1d6
     510: 17ffff2c     	b	0x1c0 <iq4_jpeg_encode_bounded+0x1c0>
     514: 90000009     	adrp	x9, 0x0 <iq4_jpeg_encode_bounded>
		0000000000000514:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x86
     518: 91000129     	add	x9, x9, #0x0
		0000000000000518:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x86
     51c: 52800088     	mov	w8, #0x4                // =4
     520: ad400520     	ldp	q0, q1, [x9]
     524: b9048268     	str	w8, [x19, #0x480]
     528: 3dc00922     	ldr	q2, [x9, #0x20]
     52c: f842e128     	ldur	x8, [x9, #0x2e]
     530: 9112628a     	add	x10, x20, #0x498
     534: ad000540     	stp	q0, q1, [x10]
     538: 3d800942     	str	q2, [x10, #0x20]
     53c: f802e148     	stur	x8, [x10, #0x2e]
     540: 1400000a     	b	0x568 <iq4_jpeg_encode_bounded+0x568>
     544: 90000009     	adrp	x9, 0x0 <iq4_jpeg_encode_bounded>
		0000000000000544:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x151
     548: 91000129     	add	x9, x9, #0x0
		0000000000000548:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x151
     54c: 528000e8     	mov	w8, #0x7                // =7
     550: ad400520     	ldp	q0, q1, [x9]
     554: b9048268     	str	w8, [x19, #0x480]
     558: f841f128     	ldur	x8, [x9, #0x1f]
     55c: 9112628a     	add	x10, x20, #0x498
     560: ad000540     	stp	q0, q1, [x10]
     564: f801f148     	stur	x8, [x10, #0x1f]
     568: f9400668     	ldr	x8, [x19, #0x8]
     56c: b4000168     	cbz	x8, 0x598 <iq4_jpeg_encode_bounded+0x598>
     570: b9456268     	ldr	w8, [x19, #0x560]
     574: 35000128     	cbnz	w8, 0x598 <iq4_jpeg_encode_bounded+0x598>
     578: b9449668     	ldr	w8, [x19, #0x494]
     57c: 52800029     	mov	w9, #0x1                // =1
     580: aa1303e0     	mov	x0, x19
     584: b9056269     	str	w9, [x19, #0x560]
     588: f9401ee9     	ldr	x9, [x23, #0x38]
     58c: 11000508     	add	w8, w8, #0x1
     590: b9049668     	str	w8, [x19, #0x494]
     594: d63f0120     	blr	x9
     598: b9448269     	ldr	w9, [x19, #0x480]
     59c: 91120288     	add	x8, x20, #0x480
     5a0: 34000469     	cbz	w9, 0x62c <iq4_jpeg_encode_bounded+0x62c>
     5a4: f902467f     	str	xzr, [x19, #0x488]
     5a8: 7100193f     	cmp	w9, #0x6
     5ac: ad450500     	ldp	q0, q1, [x8, #0xa0]
     5b0: ad0506c0     	stp	q0, q1, [x22, #0xa0]
     5b4: ad460900     	ldp	q0, q2, [x8, #0xc0]
     5b8: ad060ac0     	stp	q0, q2, [x22, #0xc0]
     5bc: ad430101     	ldp	q1, q0, [x8, #0x60]
     5c0: ad0302c1     	stp	q1, q0, [x22, #0x60]
     5c4: ad440102     	ldp	q2, q0, [x8, #0x80]
     5c8: ad0402c2     	stp	q2, q0, [x22, #0x80]
     5cc: ad410101     	ldp	q1, q0, [x8, #0x20]
     5d0: ad0102c1     	stp	q1, q0, [x22, #0x20]
     5d4: ad420102     	ldp	q2, q0, [x8, #0x40]
     5d8: ad0202c2     	stp	q2, q0, [x22, #0x40]
     5dc: ad400101     	ldp	q1, q0, [x8]
     5e0: ad0002c1     	stp	q1, q0, [x22]
     5e4: 54000401     	b.ne	0x664 <iq4_jpeg_encode_bounded+0x664>
     5e8: 90000008     	adrp	x8, 0x0 <iq4_jpeg_encode_bounded>
		00000000000005e8:  R_AARCH64_ADR_PREL_PG_HI21	.bss.retained_contexts
     5ec: 91000108     	add	x8, x8, #0x0
		00000000000005ec:  R_AARCH64_ADD_ABS_LO12_NC	.bss.retained_contexts
     5f0: c8dffd0a     	ldar	x10, [x8]
     5f4: 14000006     	b	0x60c <iq4_jpeg_encode_bounded+0x60c>
     5f8: 2a1f03ea     	mov	w10, wzr
     5fc: d5033f5f     	clrex
     600: 2a0a03eb     	mov	w11, w10
     604: aa0903ea     	mov	x10, x9
     608: 3500032b     	cbnz	w11, 0x66c <iq4_jpeg_encode_bounded+0x66c>
     60c: f902b66a     	str	x10, [x19, #0x568]
     610: c85ffd09     	ldaxr	x9, [x8]
     614: eb0a013f     	cmp	x9, x10
     618: 54ffff01     	b.ne	0x5f8 <iq4_jpeg_encode_bounded+0x5f8>
     61c: c80bfd13     	stlxr	w11, x19, [x8]
     620: 35ffff8b     	cbnz	w11, 0x610 <iq4_jpeg_encode_bounded+0x610>
     624: 5280002a     	mov	w10, #0x1               // =1
     628: 17fffff6     	b	0x600 <iq4_jpeg_encode_bounded+0x600>
     62c: ad450500     	ldp	q0, q1, [x8, #0xa0]
     630: ad0506c0     	stp	q0, q1, [x22, #0xa0]
     634: ad460900     	ldp	q0, q2, [x8, #0xc0]
     638: ad060ac0     	stp	q0, q2, [x22, #0xc0]
     63c: ad430101     	ldp	q1, q0, [x8, #0x60]
     640: ad0302c1     	stp	q1, q0, [x22, #0x60]
     644: ad440102     	ldp	q2, q0, [x8, #0x80]
     648: ad0402c2     	stp	q2, q0, [x22, #0x80]
     64c: ad410101     	ldp	q1, q0, [x8, #0x20]
     650: ad0102c1     	stp	q1, q0, [x22, #0x20]
     654: ad420102     	ldp	q2, q0, [x8, #0x40]
     658: ad0202c2     	stp	q2, q0, [x22, #0x40]
     65c: ad400101     	ldp	q1, q0, [x8]
     660: ad0002c1     	stp	q1, q0, [x22]
     664: aa1303e0     	mov	x0, x19
     668: 94000000     	bl	0x668 <iq4_jpeg_encode_bounded+0x668>
		0000000000000668:  R_AARCH64_CALL26	free
     66c: b94002c5     	ldr	w5, [x22]
     670: 17fffed7     	b	0x1cc <iq4_jpeg_encode_bounded+0x1cc>

Disassembly of section .text.api_valid:

0000000000000000 <api_valid>:
       0: b4000380     	cbz	x0, 0x70 <api_valid+0x70>
       4: b9405008     	ldr	w8, [x0, #0x50]
       8: 7100051f     	cmp	w8, #0x1
       c: 54000341     	b.ne	0x74 <api_valid+0x74>
      10: b9404008     	ldr	w8, [x0, #0x40]
      14: 321f0108     	orr	w8, w8, #0x2
      18: 7101491f     	cmp	w8, #0x52
      1c: 540002c1     	b.ne	0x74 <api_valid+0x74>
      20: f9402408     	ldr	x8, [x0, #0x48]
      24: f109211f     	cmp	x8, #0x248
      28: 54000261     	b.ne	0x74 <api_valid+0x74>
      2c: f9400008     	ldr	x8, [x0]
      30: b4000228     	cbz	x8, 0x74 <api_valid+0x74>
      34: f9400408     	ldr	x8, [x0, #0x8]
      38: b40001e8     	cbz	x8, 0x74 <api_valid+0x74>
      3c: f9400808     	ldr	x8, [x0, #0x10]
      40: b40001a8     	cbz	x8, 0x74 <api_valid+0x74>
      44: f9400c08     	ldr	x8, [x0, #0x18]
      48: b4000168     	cbz	x8, 0x74 <api_valid+0x74>
      4c: f9401008     	ldr	x8, [x0, #0x20]
      50: b4000128     	cbz	x8, 0x74 <api_valid+0x74>
      54: f9401408     	ldr	x8, [x0, #0x28]
      58: b40000e8     	cbz	x8, 0x74 <api_valid+0x74>
      5c: f9401808     	ldr	x8, [x0, #0x30]
      60: b40000a8     	cbz	x8, 0x74 <api_valid+0x74>
      64: f9401c08     	ldr	x8, [x0, #0x38]
      68: f100011f     	cmp	x8, #0x0
      6c: 1a9f07e0     	cset	w0, ne
      70: d65f03c0     	ret
      74: 2a1f03e0     	mov	w0, wzr
      78: d65f03c0     	ret

Disassembly of section .text.init_destination:

0000000000000000 <init_destination>:
       0: f9401408     	ldr	x8, [x0, #0x28]
       4: a942a909     	ldp	x9, x10, [x8, #0x28]
       8: f9001d1f     	str	xzr, [x8, #0x38]
       c: a9002909     	stp	x9, x10, [x8]
      10: d65f03c0     	ret

Disassembly of section .text.empty_output_buffer:

0000000000000000 <empty_output_buffer>:
       0: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
       4: 910003fd     	mov	x29, sp
       8: f9401409     	ldr	x9, [x0, #0x28]
       c: 90000008     	adrp	x8, 0x0 <empty_output_buffer>
		000000000000000c:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x1f5
      10: 91000108     	add	x8, x8, #0x0
		0000000000000010:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x1f5
      14: ad400500     	ldp	q0, q1, [x8]
      18: 3dc00902     	ldr	q2, [x8, #0x20]
      1c: f9402129     	ldr	x9, [x9, #0x40]
      20: 9112612a     	add	x10, x9, #0x498
      24: ad000540     	stp	q0, q1, [x10]
      28: 3cc29100     	ldur	q0, [x8, #0x29]
      2c: 3d800942     	str	q2, [x10, #0x20]
      30: 3c829140     	stur	q0, [x10, #0x29]
      34: 5280006a     	mov	w10, #0x3               // =3
      38: f9400008     	ldr	x8, [x0]
      3c: b904812a     	str	w10, [x9, #0x480]
      40: f9400108     	ldr	x8, [x8]
      44: d63f0100     	blr	x8
      48: 2a1f03e0     	mov	w0, wzr
      4c: a8c17bfd     	ldp	x29, x30, [sp], #0x10
      50: d65f03c0     	ret

Disassembly of section .text.term_destination:

0000000000000000 <term_destination>:
       0: f9401408     	ldr	x8, [x0, #0x28]
       4: f9401909     	ldr	x9, [x8, #0x30]
       8: f940050a     	ldr	x10, [x8, #0x8]
       c: cb0a0129     	sub	x9, x9, x10
      10: f9001d09     	str	x9, [x8, #0x38]
      14: d65f03c0     	ret

Disassembly of section .text.error_exit:

0000000000000000 <error_exit>:
       0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
       4: f9000bf3     	str	x19, [sp, #0x10]
       8: 910003fd     	mov	x29, sp
       c: f9400013     	ldr	x19, [x0]
      10: f940f268     	ldr	x8, [x19, #0x1e0]
      14: b9456109     	ldr	w9, [x8, #0x560]
      18: 35000269     	cbnz	w9, 0x64 <error_exit+0x64>
      1c: b9448109     	ldr	w9, [x8, #0x480]
      20: 71000d3f     	cmp	w9, #0x3
      24: 54000320     	b.eq	0x88 <error_exit+0x88>
      28: b9402a6b     	ldr	w11, [x19, #0x28]
      2c: f9400e69     	ldr	x9, [x19, #0x18]
      30: 5280008a     	mov	w10, #0x4               // =4
      34: 91126101     	add	x1, x8, #0x498
      38: b904810a     	str	w10, [x8, #0x480]
      3c: b904910b     	str	w11, [x8, #0x490]
      40: b50002a9     	cbnz	x9, 0x94 <error_exit+0x94>
      44: 90000009     	adrp	x9, 0x0 <error_exit>
		0000000000000044:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x117
      48: 91000129     	add	x9, x9, #0x0
		0000000000000048:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x117
      4c: 528dee48     	mov	w8, #0x6f72             // =28530
      50: 3dc00120     	ldr	q0, [x9]
      54: 72a00e48     	movk	w8, #0x72, lsl #16
      58: b9001028     	str	w8, [x1, #0x10]
      5c: 3d800020     	str	q0, [x1]
      60: 1400000a     	b	0x88 <error_exit+0x88>
      64: 9000000a     	adrp	x10, 0x0 <error_exit>
		0000000000000064:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x12b
      68: 9100014a     	add	x10, x10, #0x0
		0000000000000068:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x12b
      6c: 528000c9     	mov	w9, #0x6                // =6
      70: ad400540     	ldp	q0, q1, [x10]
      74: 9112610b     	add	x11, x8, #0x498
      78: b9048109     	str	w9, [x8, #0x480]
      7c: f841e148     	ldur	x8, [x10, #0x1e]
      80: ad000560     	stp	q0, q1, [x11]
      84: f801e168     	stur	x8, [x11, #0x1e]
      88: 9102a260     	add	x0, x19, #0xa8
      8c: 52800021     	mov	w1, #0x1                // =1
      90: 94000000     	bl	0x90 <error_exit+0x90>
		0000000000000090:  R_AARCH64_CALL26	longjmp
      94: d63f0120     	blr	x9
      98: 17fffffc     	b	0x88 <error_exit+0x88>
