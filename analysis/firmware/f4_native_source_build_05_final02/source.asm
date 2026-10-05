
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f4_native_source_build_05_final02/source.o:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000000000 <iq4_f4_source_storage_bytes_02>:
       0: 5280b000     	mov	w0, #0x580              // =1408
       4: d65f03c0     	ret

0000000000000008 <iq4_f4_source_init_02>:
       8: b4000fe0     	cbz	x0, 0x204 <iq4_f4_source_init_02+0x1fc>
       c: d103c3ff     	sub	sp, sp, #0xf0
      10: a9097bfd     	stp	x29, x30, [sp, #0x90]
      14: a90a6ffc     	stp	x28, x27, [sp, #0xa0]
      18: a90b67fa     	stp	x26, x25, [sp, #0xb0]
      1c: a90c5ff8     	stp	x24, x23, [sp, #0xc0]
      20: a90d57f6     	stp	x22, x21, [sp, #0xd0]
      24: a90e4ff4     	stp	x20, x19, [sp, #0xe0]
      28: 910243fd     	add	x29, sp, #0x90
      2c: aa0003f3     	mov	x19, x0
      30: 52800040     	mov	w0, #0x2                // =2
      34: b40010a2     	cbz	x2, 0x248 <iq4_f4_source_init_02+0x240>
      38: f116003f     	cmp	x1, #0x580
      3c: 54001063     	b.lo	0x248 <iq4_f4_source_init_02+0x240>
      40: 92400e68     	and	x8, x19, #0xf
      44: b5001028     	cbnz	x8, 0x248 <iq4_f4_source_init_02+0x240>
      48: b4001004     	cbz	x4, 0x248 <iq4_f4_source_init_02+0x240>
      4c: 510024c8     	sub	w8, w6, #0x9
      50: 31001d1f     	cmn	w8, #0x7
      54: 54000fa3     	b.lo	0x248 <iq4_f4_source_init_02+0x240>
      58: 12a02008     	mov	w8, #-0x1000001         // =-16777217
      5c: 0b0800e8     	add	w8, w7, w8
      60: 53187d08     	lsr	w8, w8, #24
      64: 7103fd1f     	cmp	w8, #0xff
      68: 54000f03     	b.lo	0x248 <iq4_f4_source_init_02+0x240>
      6c: 1b067ce8     	mul	w8, w7, w6
      70: eb0800bf     	cmp	x5, x8
      74: 54000ea3     	b.lo	0x248 <iq4_f4_source_init_02+0x240>
      78: ab0400bf     	cmn	x5, x4
      7c: 1a9f37e8     	cset	w8, hs
      80: b116067f     	cmn	x19, #0x581
      84: 54000e28     	b.hi	0x248 <iq4_f4_source_init_02+0x240>
      88: 37000e08     	tbnz	w8, #0x0, 0x248 <iq4_f4_source_init_02+0x240>
      8c: 91160268     	add	x8, x19, #0x580
      90: eb04011f     	cmp	x8, x4
      94: 54000089     	b.ls	0xa4 <iq4_f4_source_init_02+0x9c>
      98: 8b0400a8     	add	x8, x5, x4
      9c: eb13011f     	cmp	x8, x19
      a0: 54000d48     	b.hi	0x248 <iq4_f4_source_init_02+0x240>
      a4: aa1303e0     	mov	x0, x19
      a8: 2a1f03e1     	mov	w1, wzr
      ac: aa0203f4     	mov	x20, x2
      b0: 5280b002     	mov	w2, #0x580              // =1408
      b4: a90017e4     	stp	x4, x5, [sp]
      b8: aa0303f5     	mov	x21, x3
      bc: 29021fe6     	stp	w6, w7, [sp, #0x10]
      c0: 94000000     	bl	0xc0 <iq4_f4_source_init_02+0xb8>
		00000000000000c0:  R_AARCH64_CALL26	memset
      c4: aa1f03f9     	mov	x25, xzr
      c8: 9115a268     	add	x8, x19, #0x568
      cc: 52801909     	mov	w9, #0xc8               // =200
      d0: 5280030a     	mov	w10, #0x18              // =24
      d4: 9000001b     	adrp	x27, 0x0 <iq4_f4_source_storage_bytes_02>
		00000000000000d4:  R_AARCH64_ADR_PREL_PG_HI21	.data.rel.ro
      d8: 9100037b     	add	x27, x27, #0x0
		00000000000000d8:  R_AARCH64_ADD_ABS_LO12_NC	.data.rel.ro
      dc: 5280081c     	mov	w28, #0x40              // =64
      e0: a900d674     	stp	x20, x21, [x19, #0x8]
      e4: 889ffd09     	stlr	w9, [x8]
      e8: 9b0a6f35     	madd	x21, x25, x10, x27
      ec: f94006b6     	ldr	x22, [x21, #0x8]
      f0: b4000396     	cbz	x22, 0x160 <iq4_f4_source_init_02+0x158>
      f4: f94002b8     	ldr	x24, [x21]
      f8: aa1f03f7     	mov	x23, xzr
      fc: aa1603e8     	mov	x8, x22
     100: f101011a     	subs	x26, x8, #0x40
     104: 8b170301     	add	x1, x24, x23
     108: 9a9c3114     	csel	x20, x8, x28, lo
     10c: ab01029f     	cmn	x20, x1
     110: 1a9f37e8     	cset	w8, hs
     114: f140043f     	cmp	x1, #0x1, lsl #12       // =0x1000
     118: 540007a3     	b.lo	0x20c <iq4_f4_source_init_02+0x204>
     11c: 37000788     	tbnz	w8, #0x0, 0x20c <iq4_f4_source_init_02+0x204>
     120: a9408268     	ldp	x8, x0, [x19, #0x8]
     124: d10103a2     	sub	x2, x29, #0x40
     128: aa1403e3     	mov	x3, x20
     12c: d63f0100     	blr	x8
     130: 7100041f     	cmp	w0, #0x1
     134: 540006c1     	b.ne	0x20c <iq4_f4_source_init_02+0x204>
     138: f9400aa8     	ldr	x8, [x21, #0x10]
     13c: d10103a0     	sub	x0, x29, #0x40
     140: aa1403e2     	mov	x2, x20
     144: 8b170101     	add	x1, x8, x23
     148: 94000000     	bl	0x148 <iq4_f4_source_init_02+0x140>
		0000000000000148:  R_AARCH64_CALL26	memcmp
     14c: 35000600     	cbnz	w0, 0x20c <iq4_f4_source_init_02+0x204>
     150: 910102f7     	add	x23, x23, #0x40
     154: aa1a03e8     	mov	x8, x26
     158: eb1602ff     	cmp	x23, x22
     15c: 54fffd23     	b.lo	0x100 <iq4_f4_source_init_02+0xf8>
     160: 91000739     	add	x25, x25, #0x1
     164: 5280030a     	mov	w10, #0x18              // =24
     168: f1009f3f     	cmp	x25, #0x27
     16c: 54fffbe1     	b.ne	0xe8 <iq4_f4_source_init_02+0xe0>
     170: d10103a1     	sub	x1, x29, #0x40
     174: aa1303e0     	mov	x0, x19
     178: 9400003c     	bl	0x268 <owner>
     17c: 34000640     	cbz	w0, 0x244 <iq4_f4_source_init_02+0x23c>
     180: 910063e1     	add	x1, sp, #0x18
     184: aa1303e0     	mov	x0, x19
     188: 94000038     	bl	0x268 <owner>
     18c: 340005c0     	cbz	w0, 0x244 <iq4_f4_source_init_02+0x23c>
     190: d10103a0     	sub	x0, x29, #0x40
     194: 910063e1     	add	x1, sp, #0x18
     198: 52800702     	mov	w2, #0x38               // =56
     19c: 94000000     	bl	0x19c <iq4_f4_source_init_02+0x194>
		000000000000019c:  R_AARCH64_CALL26	memcmp
     1a0: 35000520     	cbnz	w0, 0x244 <iq4_f4_source_init_02+0x23c>
     1a4: 94000000     	bl	0x1a4 <iq4_f4_source_init_02+0x19c>
		00000000000001a4:  R_AARCH64_CALL26	iq4_f4_native_tid_02
     1a8: f9002a60     	str	x0, [x19, #0x50]
     1ac: b40004c0     	cbz	x0, 0x244 <iq4_f4_source_init_02+0x23c>
     1b0: f85f03a8     	ldur	x8, [x29, #-0x10]
     1b4: ad7e07a0     	ldp	q0, q1, [x29, #-0x40]
     1b8: 2a1f03e0     	mov	w0, wzr
     1bc: f9002668     	str	x8, [x19, #0x48]
     1c0: a94023e9     	ldp	x9, x8, [sp]
     1c4: 3c818260     	stur	q0, [x19, #0x18]
     1c8: 3cde03a0     	ldur	q0, [x29, #-0x20]
     1cc: 3c828261     	stur	q1, [x19, #0x28]
     1d0: a9062269     	stp	x9, x8, [x19, #0x60]
     1d4: 294223e9     	ldp	w9, w8, [sp, #0x10]
     1d8: 3c838260     	stur	q0, [x19, #0x38]
     1dc: 290e2269     	stp	w9, w8, [x19, #0x70]
     1e0: d28a4648     	mov	x8, #0x5232             // =21042
     1e4: 52801949     	mov	w9, #0xca               // =202
     1e8: f2a68a68     	movk	x8, #0x3453, lsl #16
     1ec: f2c688c8     	movk	x8, #0x3446, lsl #32
     1f0: f2e92a28     	movk	x8, #0x4951, lsl #48
     1f4: f9000268     	str	x8, [x19]
     1f8: 9115a268     	add	x8, x19, #0x568
     1fc: 889ffd09     	stlr	w9, [x8]
     200: 14000012     	b	0x248 <iq4_f4_source_init_02+0x240>
     204: 52800040     	mov	w0, #0x2                // =2
     208: d65f03c0     	ret
     20c: 9115a269     	add	x9, x19, #0x568
     210: 52801908     	mov	w8, #0xc8               // =200
     214: 889ffd28     	stlr	w8, [x9]
     218: 9115b269     	add	x9, x19, #0x56c
     21c: 885ffd2a     	ldaxr	w10, [x9]
     220: 3500010a     	cbnz	w10, 0x240 <iq4_f4_source_init_02+0x238>
     224: 880afd28     	stlxr	w10, w8, [x9]
     228: 35ffffaa     	cbnz	w10, 0x21c <iq4_f4_source_init_02+0x214>
     22c: 11000728     	add	w8, w25, #0x1
     230: 9115c269     	add	x9, x19, #0x570
     234: 52800040     	mov	w0, #0x2                // =2
     238: 889ffd28     	stlr	w8, [x9]
     23c: 14000003     	b	0x248 <iq4_f4_source_init_02+0x240>
     240: d5033f5f     	clrex
     244: 52800040     	mov	w0, #0x2                // =2
     248: a94e4ff4     	ldp	x20, x19, [sp, #0xe0]
     24c: a94d57f6     	ldp	x22, x21, [sp, #0xd0]
     250: a94c5ff8     	ldp	x24, x23, [sp, #0xc0]
     254: a94b67fa     	ldp	x26, x25, [sp, #0xb0]
     258: a94a6ffc     	ldp	x28, x27, [sp, #0xa0]
     25c: a9497bfd     	ldp	x29, x30, [sp, #0x90]
     260: 9103c3ff     	add	sp, sp, #0xf0
     264: d65f03c0     	ret

0000000000000268 <owner>:
     268: d10183ff     	sub	sp, sp, #0x60
     26c: a9047bfd     	stp	x29, x30, [sp, #0x40]
     270: a9054ff4     	stp	x20, x19, [sp, #0x50]
     274: 910103fd     	add	x29, sp, #0x40
     278: aa0003f3     	mov	x19, x0
     27c: d10023a0     	sub	x0, x29, #0x8
     280: aa0103f4     	mov	x20, x1
     284: 94000000     	bl	0x284 <owner+0x1c>
		0000000000000284:  R_AARCH64_CALL26	iq4_f4_native_current_02
     288: 34001d40     	cbz	w0, 0x630 <owner+0x3c8>
     28c: f85f83a1     	ldur	x1, [x29, #-0x8]
     290: 52920028     	mov	w8, #0x9001             // =36865
     294: 8b080028     	add	x8, x1, x8
     298: f140291f     	cmp	x8, #0xa, lsl #12       // =0xa000
     29c: 54001ca9     	b.ls	0x630 <owner+0x3c8>
     2a0: 92400828     	and	x8, x1, #0x7
     2a4: b5001c68     	cbnz	x8, 0x630 <owner+0x3c8>
     2a8: a9408268     	ldp	x8, x0, [x19, #0x8]
     2ac: d10043a2     	sub	x2, x29, #0x10
     2b0: 52800103     	mov	w3, #0x8                // =8
     2b4: d63f0100     	blr	x8
     2b8: 7100041f     	cmp	w0, #0x1
     2bc: 54001ba1     	b.ne	0x630 <owner+0x3c8>
     2c0: f85f03a8     	ldur	x8, [x29, #-0x10]
     2c4: d16e4508     	sub	x8, x8, #0xb91, lsl #12 // =0xb91000
     2c8: f13d211f     	cmp	x8, #0xf48
     2cc: 54001b21     	b.ne	0x630 <owner+0x3c8>
     2d0: f85f83a8     	ldur	x8, [x29, #-0x8]
     2d4: 91074109     	add	x9, x8, #0x1d0
     2d8: d343fd29     	lsr	x9, x9, #3
     2dc: f108053f     	cmp	x9, #0x201
     2e0: 54001c23     	b.lo	0x664 <owner+0x3fc>
     2e4: a9408269     	ldp	x9, x0, [x19, #0x8]
     2e8: 91072101     	add	x1, x8, #0x1c8
     2ec: d10063a2     	sub	x2, x29, #0x18
     2f0: 52800103     	mov	w3, #0x8                // =8
     2f4: d63f0120     	blr	x9
     2f8: 7100041f     	cmp	w0, #0x1
     2fc: 54001b41     	b.ne	0x664 <owner+0x3fc>
     300: f85e83a1     	ldur	x1, [x29, #-0x18]
     304: 52920028     	mov	w8, #0x9001             // =36865
     308: 8b080028     	add	x8, x1, x8
     30c: f140291f     	cmp	x8, #0xa, lsl #12       // =0xa000
     310: 54001aa9     	b.ls	0x664 <owner+0x3fc>
     314: 92400828     	and	x8, x1, #0x7
     318: b5001a68     	cbnz	x8, 0x664 <owner+0x3fc>
     31c: a9408268     	ldp	x8, x0, [x19, #0x8]
     320: d10043a2     	sub	x2, x29, #0x10
     324: 52800103     	mov	w3, #0x8                // =8
     328: d63f0100     	blr	x8
     32c: 7100041f     	cmp	w0, #0x1
     330: 540019a1     	b.ne	0x664 <owner+0x3fc>
     334: f85f03a8     	ldur	x8, [x29, #-0x10]
     338: d16e3d08     	sub	x8, x8, #0xb8f, lsl #12 // =0xb8f000
     33c: f10d611f     	cmp	x8, #0x358
     340: 54001921     	b.ne	0x664 <owner+0x3fc>
     344: f85e83a8     	ldur	x8, [x29, #-0x18]
     348: 91004109     	add	x9, x8, #0x10
     34c: d343fd29     	lsr	x9, x9, #3
     350: f108053f     	cmp	x9, #0x201
     354: 54001883     	b.lo	0x664 <owner+0x3fc>
     358: a9408269     	ldp	x9, x0, [x19, #0x8]
     35c: 91002101     	add	x1, x8, #0x8
     360: d10043a2     	sub	x2, x29, #0x10
     364: 52800103     	mov	w3, #0x8                // =8
     368: d63f0120     	blr	x9
     36c: 7100041f     	cmp	w0, #0x1
     370: 540017a1     	b.ne	0x664 <owner+0x3fc>
     374: a97f27a8     	ldp	x8, x9, [x29, #-0x10]
     378: eb09011f     	cmp	x8, x9
     37c: 54001741     	b.ne	0x664 <owner+0x3fc>
     380: 91270109     	add	x9, x8, #0x9c0
     384: d343fd29     	lsr	x9, x9, #3
     388: f108053f     	cmp	x9, #0x201
     38c: 54001823     	b.lo	0x690 <owner+0x428>
     390: a9408269     	ldp	x9, x0, [x19, #0x8]
     394: 9126e101     	add	x1, x8, #0x9b8
     398: 910083e2     	add	x2, sp, #0x20
     39c: 52800103     	mov	w3, #0x8                // =8
     3a0: d63f0120     	blr	x9
     3a4: 7100041f     	cmp	w0, #0x1
     3a8: 54001741     	b.ne	0x690 <owner+0x428>
     3ac: f94013e8     	ldr	x8, [sp, #0x20]
     3b0: 52920029     	mov	w9, #0x9001             // =36865
     3b4: 8b090109     	add	x9, x8, x9
     3b8: f140293f     	cmp	x9, #0xa, lsl #12       // =0xa000
     3bc: 540016a9     	b.ls	0x690 <owner+0x428>
     3c0: 92400908     	and	x8, x8, #0x7
     3c4: b5001668     	cbnz	x8, 0x690 <owner+0x428>
     3c8: f85e83a8     	ldur	x8, [x29, #-0x18]
     3cc: 911e6109     	add	x9, x8, #0x798
     3d0: d343fd29     	lsr	x9, x9, #3
     3d4: f108053f     	cmp	x9, #0x201
     3d8: 540015c3     	b.lo	0x690 <owner+0x428>
     3dc: a9408269     	ldp	x9, x0, [x19, #0x8]
     3e0: 911e4101     	add	x1, x8, #0x790
     3e4: d10043a2     	sub	x2, x29, #0x10
     3e8: 52800103     	mov	w3, #0x8                // =8
     3ec: d63f0120     	blr	x9
     3f0: 7100041f     	cmp	w0, #0x1
     3f4: 540014e1     	b.ne	0x690 <owner+0x428>
     3f8: f85f03a8     	ldur	x8, [x29, #-0x10]
     3fc: f94013e9     	ldr	x9, [sp, #0x20]
     400: eb09011f     	cmp	x8, x9
     404: 54001461     	b.ne	0x690 <owner+0x428>
     408: f85f83a8     	ldur	x8, [x29, #-0x8]
     40c: 91232109     	add	x9, x8, #0x8c8
     410: d343fd29     	lsr	x9, x9, #3
     414: f108053f     	cmp	x9, #0x201
     418: 54001523     	b.lo	0x6bc <owner+0x454>
     41c: a9408269     	ldp	x9, x0, [x19, #0x8]
     420: 91230101     	add	x1, x8, #0x8c0
     424: 910063e2     	add	x2, sp, #0x18
     428: 52800103     	mov	w3, #0x8                // =8
     42c: d63f0120     	blr	x9
     430: 7100041f     	cmp	w0, #0x1
     434: 54001441     	b.ne	0x6bc <owner+0x454>
     438: f9400fe1     	ldr	x1, [sp, #0x18]
     43c: 52920028     	mov	w8, #0x9001             // =36865
     440: 8b080028     	add	x8, x1, x8
     444: f140291f     	cmp	x8, #0xa, lsl #12       // =0xa000
     448: 540013a9     	b.ls	0x6bc <owner+0x454>
     44c: 92400828     	and	x8, x1, #0x7
     450: b5001368     	cbnz	x8, 0x6bc <owner+0x454>
     454: a9408268     	ldp	x8, x0, [x19, #0x8]
     458: d10043a2     	sub	x2, x29, #0x10
     45c: 52800103     	mov	w3, #0x8                // =8
     460: d63f0100     	blr	x8
     464: 7100041f     	cmp	w0, #0x1
     468: 540012a1     	b.ne	0x6bc <owner+0x454>
     46c: f85f03a8     	ldur	x8, [x29, #-0x10]
     470: d16e6908     	sub	x8, x8, #0xb9a, lsl #12 // =0xb9a000
     474: f127611f     	cmp	x8, #0x9d8
     478: 54001221     	b.ne	0x6bc <owner+0x454>
     47c: f94013e8     	ldr	x8, [sp, #0x20]
     480: 91048109     	add	x9, x8, #0x120
     484: d343fd29     	lsr	x9, x9, #3
     488: f108053f     	cmp	x9, #0x201
     48c: 540012e3     	b.lo	0x6e8 <owner+0x480>
     490: a9408269     	ldp	x9, x0, [x19, #0x8]
     494: 91046101     	add	x1, x8, #0x118
     498: 910043e2     	add	x2, sp, #0x10
     49c: 52800103     	mov	w3, #0x8                // =8
     4a0: d63f0120     	blr	x9
     4a4: 7100041f     	cmp	w0, #0x1
     4a8: 54001201     	b.ne	0x6e8 <owner+0x480>
     4ac: f9400be8     	ldr	x8, [sp, #0x10]
     4b0: 52920029     	mov	w9, #0x9001             // =36865
     4b4: 8b090109     	add	x9, x8, x9
     4b8: f140293f     	cmp	x9, #0xa, lsl #12       // =0xa000
     4bc: 54001169     	b.ls	0x6e8 <owner+0x480>
     4c0: 92400908     	and	x8, x8, #0x7
     4c4: b5001128     	cbnz	x8, 0x6e8 <owner+0x480>
     4c8: f9400fe8     	ldr	x8, [sp, #0x18]
     4cc: 91044109     	add	x9, x8, #0x110
     4d0: d343fd29     	lsr	x9, x9, #3
     4d4: f108053f     	cmp	x9, #0x201
     4d8: 54001083     	b.lo	0x6e8 <owner+0x480>
     4dc: a9408269     	ldp	x9, x0, [x19, #0x8]
     4e0: 91042101     	add	x1, x8, #0x108
     4e4: d10043a2     	sub	x2, x29, #0x10
     4e8: 52800103     	mov	w3, #0x8                // =8
     4ec: d63f0120     	blr	x9
     4f0: 7100041f     	cmp	w0, #0x1
     4f4: 54000fa1     	b.ne	0x6e8 <owner+0x480>
     4f8: f85f03a1     	ldur	x1, [x29, #-0x10]
     4fc: f9400be8     	ldr	x8, [sp, #0x10]
     500: eb08003f     	cmp	x1, x8
     504: 54000f21     	b.ne	0x6e8 <owner+0x480>
     508: 91002108     	add	x8, x8, #0x8
     50c: d343fd08     	lsr	x8, x8, #3
     510: f108051f     	cmp	x8, #0x201
     514: 54000ea3     	b.lo	0x6e8 <owner+0x480>
     518: a9408268     	ldp	x8, x0, [x19, #0x8]
     51c: d10043a2     	sub	x2, x29, #0x10
     520: 52800103     	mov	w3, #0x8                // =8
     524: d63f0100     	blr	x8
     528: 7100041f     	cmp	w0, #0x1
     52c: 54000de1     	b.ne	0x6e8 <owner+0x480>
     530: f85f03a8     	ldur	x8, [x29, #-0x10]
     534: d1701d08     	sub	x8, x8, #0xc07, lsl #12 // =0xc07000
     538: f136a11f     	cmp	x8, #0xda8
     53c: 54000d61     	b.ne	0x6e8 <owner+0x480>
     540: f9400be8     	ldr	x8, [sp, #0x10]
     544: 91004109     	add	x9, x8, #0x10
     548: d343fd29     	lsr	x9, x9, #3
     54c: f108053f     	cmp	x9, #0x201
     550: 54000e23     	b.lo	0x714 <owner+0x4ac>
     554: a9408269     	ldp	x9, x0, [x19, #0x8]
     558: 91002101     	add	x1, x8, #0x8
     55c: 910023e2     	add	x2, sp, #0x8
     560: 52800103     	mov	w3, #0x8                // =8
     564: d63f0120     	blr	x9
     568: 7100041f     	cmp	w0, #0x1
     56c: 54000d41     	b.ne	0x714 <owner+0x4ac>
     570: f94007e8     	ldr	x8, [sp, #0x8]
     574: 52920029     	mov	w9, #0x9001             // =36865
     578: 8b090109     	add	x9, x8, x9
     57c: f140293f     	cmp	x9, #0xa, lsl #12       // =0xa000
     580: 54000ca9     	b.ls	0x714 <owner+0x4ac>
     584: 92400909     	and	x9, x8, #0x7
     588: b5000c69     	cbnz	x9, 0x714 <owner+0x4ac>
     58c: a9408269     	ldp	x9, x0, [x19, #0x8]
     590: 91190101     	add	x1, x8, #0x640
     594: d10043a2     	sub	x2, x29, #0x10
     598: 52800103     	mov	w3, #0x8                // =8
     59c: d63f0120     	blr	x9
     5a0: 7100041f     	cmp	w0, #0x1
     5a4: 54000b81     	b.ne	0x714 <owner+0x4ac>
     5a8: f85f03a8     	ldur	x8, [x29, #-0x10]
     5ac: d1708d08     	sub	x8, x8, #0xc23, lsl #12 // =0xc23000
     5b0: f11e811f     	cmp	x8, #0x7a0
     5b4: 54000b01     	b.ne	0x714 <owner+0x4ac>
     5b8: f94007e8     	ldr	x8, [sp, #0x8]
     5bc: 911b8109     	add	x9, x8, #0x6e0
     5c0: d343fd29     	lsr	x9, x9, #3
     5c4: f108053f     	cmp	x9, #0x201
     5c8: 54000a63     	b.lo	0x714 <owner+0x4ac>
     5cc: a9408269     	ldp	x9, x0, [x19, #0x8]
     5d0: 911b6101     	add	x1, x8, #0x6d8
     5d4: d10043a2     	sub	x2, x29, #0x10
     5d8: 52800103     	mov	w3, #0x8                // =8
     5dc: d63f0120     	blr	x9
     5e0: 7100041f     	cmp	w0, #0x1
     5e4: 54000981     	b.ne	0x714 <owner+0x4ac>
     5e8: f85f03a8     	ldur	x8, [x29, #-0x10]
     5ec: 52920029     	mov	w9, #0x9001             // =36865
     5f0: 8b090109     	add	x9, x8, x9
     5f4: f140293f     	cmp	x9, #0xa, lsl #12       // =0xa000
     5f8: 540008e9     	b.ls	0x714 <owner+0x4ac>
     5fc: 92400908     	and	x8, x8, #0x7
     600: b50008a8     	cbnz	x8, 0x714 <owner+0x4ac>
     604: f85f83a8     	ldur	x8, [x29, #-0x8]
     608: f85e83a9     	ldur	x9, [x29, #-0x18]
     60c: 52800020     	mov	w0, #0x1                // =1
     610: a9002688     	stp	x8, x9, [x20]
     614: a941abe8     	ldp	x8, x10, [sp, #0x18]
     618: a901228a     	stp	x10, x8, [x20, #0x10]
     61c: a940a7ea     	ldp	x10, x9, [sp, #0x8]
     620: 91190148     	add	x8, x10, #0x640
     624: a9022a89     	stp	x9, x10, [x20, #0x20]
     628: f9001a88     	str	x8, [x20, #0x30]
     62c: 14000047     	b	0x748 <owner+0x4e0>
     630: 9115a269     	add	x9, x19, #0x568
     634: 52801928     	mov	w8, #0xc9               // =201
     638: 889ffd28     	stlr	w8, [x9]
     63c: 9115b269     	add	x9, x19, #0x56c
     640: 885ffd2a     	ldaxr	w10, [x9]
     644: 350007ea     	cbnz	w10, 0x740 <owner+0x4d8>
     648: 880afd28     	stlxr	w10, w8, [x9]
     64c: 35ffffaa     	cbnz	w10, 0x640 <owner+0x3d8>
     650: 9115c268     	add	x8, x19, #0x570
     654: 52800029     	mov	w9, #0x1                // =1
     658: 2a1f03e0     	mov	w0, wzr
     65c: 889ffd09     	stlr	w9, [x8]
     660: 1400003a     	b	0x748 <owner+0x4e0>
     664: 9115a269     	add	x9, x19, #0x568
     668: 52801928     	mov	w8, #0xc9               // =201
     66c: 889ffd28     	stlr	w8, [x9]
     670: 9115b269     	add	x9, x19, #0x56c
     674: 885ffd2a     	ldaxr	w10, [x9]
     678: 3500064a     	cbnz	w10, 0x740 <owner+0x4d8>
     67c: 880afd28     	stlxr	w10, w8, [x9]
     680: 35ffffaa     	cbnz	w10, 0x674 <owner+0x40c>
     684: 9115c268     	add	x8, x19, #0x570
     688: 52800049     	mov	w9, #0x2                // =2
     68c: 17fffff3     	b	0x658 <owner+0x3f0>
     690: 9115a269     	add	x9, x19, #0x568
     694: 52801928     	mov	w8, #0xc9               // =201
     698: 889ffd28     	stlr	w8, [x9]
     69c: 9115b269     	add	x9, x19, #0x56c
     6a0: 885ffd2a     	ldaxr	w10, [x9]
     6a4: 350004ea     	cbnz	w10, 0x740 <owner+0x4d8>
     6a8: 880afd28     	stlxr	w10, w8, [x9]
     6ac: 35ffffaa     	cbnz	w10, 0x6a0 <owner+0x438>
     6b0: 9115c268     	add	x8, x19, #0x570
     6b4: 52800069     	mov	w9, #0x3                // =3
     6b8: 17ffffe8     	b	0x658 <owner+0x3f0>
     6bc: 9115a269     	add	x9, x19, #0x568
     6c0: 52801928     	mov	w8, #0xc9               // =201
     6c4: 889ffd28     	stlr	w8, [x9]
     6c8: 9115b269     	add	x9, x19, #0x56c
     6cc: 885ffd2a     	ldaxr	w10, [x9]
     6d0: 3500038a     	cbnz	w10, 0x740 <owner+0x4d8>
     6d4: 880afd28     	stlxr	w10, w8, [x9]
     6d8: 35ffffaa     	cbnz	w10, 0x6cc <owner+0x464>
     6dc: 9115c268     	add	x8, x19, #0x570
     6e0: 52800089     	mov	w9, #0x4                // =4
     6e4: 17ffffdd     	b	0x658 <owner+0x3f0>
     6e8: 9115a269     	add	x9, x19, #0x568
     6ec: 52801928     	mov	w8, #0xc9               // =201
     6f0: 889ffd28     	stlr	w8, [x9]
     6f4: 9115b269     	add	x9, x19, #0x56c
     6f8: 885ffd2a     	ldaxr	w10, [x9]
     6fc: 3500022a     	cbnz	w10, 0x740 <owner+0x4d8>
     700: 880afd28     	stlxr	w10, w8, [x9]
     704: 35ffffaa     	cbnz	w10, 0x6f8 <owner+0x490>
     708: 9115c268     	add	x8, x19, #0x570
     70c: 528000a9     	mov	w9, #0x5                // =5
     710: 17ffffd2     	b	0x658 <owner+0x3f0>
     714: 9115a269     	add	x9, x19, #0x568
     718: 52801928     	mov	w8, #0xc9               // =201
     71c: 889ffd28     	stlr	w8, [x9]
     720: 9115b269     	add	x9, x19, #0x56c
     724: 885ffd2a     	ldaxr	w10, [x9]
     728: 350000ca     	cbnz	w10, 0x740 <owner+0x4d8>
     72c: 880afd28     	stlxr	w10, w8, [x9]
     730: 35ffffaa     	cbnz	w10, 0x724 <owner+0x4bc>
     734: 9115c268     	add	x8, x19, #0x570
     738: 528000c9     	mov	w9, #0x6                // =6
     73c: 17ffffc7     	b	0x658 <owner+0x3f0>
     740: 2a1f03e0     	mov	w0, wzr
     744: d5033f5f     	clrex
     748: a9454ff4     	ldp	x20, x19, [sp, #0x50]
     74c: a9447bfd     	ldp	x29, x30, [sp, #0x40]
     750: 910183ff     	add	sp, sp, #0x60
     754: d65f03c0     	ret

0000000000000758 <iq4_f4_source_attach_on_ui_02>:
     758: b4000180     	cbz	x0, 0x788 <iq4_f4_source_attach_on_ui_02+0x30>
     75c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
     760: a9014ff4     	stp	x20, x19, [sp, #0x10]
     764: 910003fd     	mov	x29, sp
     768: aa0003f3     	mov	x19, x0
     76c: 940000cb     	bl	0xa98 <on_ui>
     770: 340003a0     	cbz	w0, 0x7e4 <iq4_f4_source_attach_on_ui_02+0x8c>
     774: 91033268     	add	x8, x19, #0xcc
     778: 88dffd08     	ldar	w8, [x8]
     77c: 340000a8     	cbz	w8, 0x790 <iq4_f4_source_attach_on_ui_02+0x38>
     780: 528000a0     	mov	w0, #0x5                // =5
     784: 14000019     	b	0x7e8 <iq4_f4_source_attach_on_ui_02+0x90>
     788: 52800040     	mov	w0, #0x2                // =2
     78c: d65f03c0     	ret
     790: 91031268     	add	x8, x19, #0xc4
     794: 88dffd08     	ldar	w8, [x8]
     798: 350000c8     	cbnz	w8, 0x7b0 <iq4_f4_source_attach_on_ui_02+0x58>
     79c: f9402661     	ldr	x1, [x19, #0x48]
     7a0: 9101e262     	add	x2, x19, #0x78
     7a4: aa1303e0     	mov	x0, x19
     7a8: 9400015b     	bl	0xd14 <exact_triple>
     7ac: 34000240     	cbz	w0, 0x7f4 <iq4_f4_source_attach_on_ui_02+0x9c>
     7b0: 9115a269     	add	x9, x19, #0x568
     7b4: 52801a48     	mov	w8, #0xd2               // =210
     7b8: 889ffd28     	stlr	w8, [x9]
     7bc: 9115b269     	add	x9, x19, #0x56c
     7c0: 885ffd2a     	ldaxr	w10, [x9]
     7c4: 350000ea     	cbnz	w10, 0x7e0 <iq4_f4_source_attach_on_ui_02+0x88>
     7c8: 880afd28     	stlxr	w10, w8, [x9]
     7cc: 35ffffaa     	cbnz	w10, 0x7c0 <iq4_f4_source_attach_on_ui_02+0x68>
     7d0: 9115c268     	add	x8, x19, #0x570
     7d4: 52800029     	mov	w9, #0x1                // =1
     7d8: 889ffd09     	stlr	w9, [x8]
     7dc: 14000002     	b	0x7e4 <iq4_f4_source_attach_on_ui_02+0x8c>
     7e0: d5033f5f     	clrex
     7e4: 52800040     	mov	w0, #0x2                // =2
     7e8: a9414ff4     	ldp	x20, x19, [sp, #0x10]
     7ec: a8c27bfd     	ldp	x29, x30, [sp], #0x20
     7f0: d65f03c0     	ret
     7f4: 9115a274     	add	x20, x19, #0x568
     7f8: 52801a68     	mov	w8, #0xd3               // =211
     7fc: 889ffe88     	stlr	w8, [x20]
     800: b940c268     	ldr	w8, [x19, #0xc0]
     804: 340002e8     	cbz	w8, 0x860 <iq4_f4_source_attach_on_ui_02+0x108>
     808: 52801a88     	mov	w8, #0xd4               // =212
     80c: 889ffe88     	stlr	w8, [x20]
     810: b941e268     	ldr	w8, [x19, #0x1e0]
     814: 340006a8     	cbz	w8, 0x8e8 <iq4_f4_source_attach_on_ui_02+0x190>
     818: f9402661     	ldr	x1, [x19, #0x48]
     81c: 9101e260     	add	x0, x19, #0x78
     820: 94000000     	bl	0x820 <iq4_f4_source_attach_on_ui_02+0xc8>
		0000000000000820:  R_AARCH64_CALL26	iq4_f4_native_subscribe_02
     824: 34000500     	cbz	w0, 0x8c4 <iq4_f4_source_attach_on_ui_02+0x16c>
     828: f9402661     	ldr	x1, [x19, #0x48]
     82c: 9101e262     	add	x2, x19, #0x78
     830: aa1303e0     	mov	x0, x19
     834: 94000138     	bl	0xd14 <exact_triple>
     838: 7100041f     	cmp	w0, #0x1
     83c: 54000441     	b.ne	0x8c4 <iq4_f4_source_attach_on_ui_02+0x16c>
     840: 91031268     	add	x8, x19, #0xc4
     844: 52800029     	mov	w9, #0x1                // =1
     848: 9115a26a     	add	x10, x19, #0x568
     84c: 52801aeb     	mov	w11, #0xd7              // =215
     850: 2a1f03e0     	mov	w0, wzr
     854: 889ffd09     	stlr	w9, [x8]
     858: 889ffd4b     	stlr	w11, [x10]
     85c: 17ffffe3     	b	0x7e8 <iq4_f4_source_attach_on_ui_02+0x90>
     860: f9400e62     	ldr	x2, [x19, #0x18]
     864: 90000001     	adrp	x1, 0x0 <iq4_f4_source_storage_bytes_02>
		0000000000000864:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1
     868: 91000021     	add	x1, x1, #0x0
		0000000000000868:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1
     86c: 9101e260     	add	x0, x19, #0x78
     870: 94000000     	bl	0x870 <iq4_f4_source_attach_on_ui_02+0x118>
		0000000000000870:  R_AARCH64_CALL26	iq4_f4_native_construct_observer_02
     874: 34000a80     	cbz	w0, 0x9c4 <iq4_f4_source_attach_on_ui_02+0x26c>
     878: f9404268     	ldr	x8, [x19, #0x80]
     87c: f9400e69     	ldr	x9, [x19, #0x18]
     880: eb09011f     	cmp	x8, x9
     884: 54000b81     	b.ne	0x9f4 <iq4_f4_source_attach_on_ui_02+0x29c>
     888: 90000008     	adrp	x8, 0x0 <iq4_f4_source_storage_bytes_02>
		0000000000000888:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst16
     88c: 90000009     	adrp	x9, 0x0 <iq4_f4_source_storage_bytes_02>
		000000000000088c:  R_AARCH64_ADR_PREL_PG_HI21	.text+0xb44
     890: 91000129     	add	x9, x9, #0x0
		0000000000000890:  R_AARCH64_ADD_ABS_LO12_NC	.text+0xb44
     894: 3dc00100     	ldr	q0, [x8]
		0000000000000894:  R_AARCH64_LDST128_ABS_LO12_NC	.rodata.cst16
     898: 90000008     	adrp	x8, 0x0 <iq4_f4_source_storage_bytes_02>
		0000000000000898:  R_AARCH64_ADR_PREL_PG_HI21	.text+0xb68
     89c: 91000108     	add	x8, x8, #0x0
		000000000000089c:  R_AARCH64_ADD_ABS_LO12_NC	.text+0xb68
     8a0: aa1303ea     	mov	x10, x19
     8a4: a90b2269     	stp	x9, x8, [x19, #0xb0]
     8a8: 52800028     	mov	w8, #0x1                // =1
     8ac: f80a8d49     	str	x9, [x10, #0xa8]!
     8b0: 3c898260     	stur	q0, [x19, #0x98]
     8b4: f9003e6a     	str	x10, [x19, #0x78]
     8b8: f9004a73     	str	x19, [x19, #0x90]
     8bc: b900c268     	str	w8, [x19, #0xc0]
     8c0: 17ffffd2     	b	0x808 <iq4_f4_source_attach_on_ui_02+0xb0>
     8c4: 9115a269     	add	x9, x19, #0x568
     8c8: 52801ac8     	mov	w8, #0xd6               // =214
     8cc: 889ffd28     	stlr	w8, [x9]
     8d0: 9115b269     	add	x9, x19, #0x56c
     8d4: 885ffd2a     	ldaxr	w10, [x9]
     8d8: 35000b6a     	cbnz	w10, 0xa44 <iq4_f4_source_attach_on_ui_02+0x2ec>
     8dc: 880afd28     	stlxr	w10, w8, [x9]
     8e0: 35ffffaa     	cbnz	w10, 0x8d4 <iq4_f4_source_attach_on_ui_02+0x17c>
     8e4: 14000040     	b	0x9e4 <iq4_f4_source_attach_on_ui_02+0x28c>
     8e8: 90000001     	adrp	x1, 0x0 <iq4_f4_source_storage_bytes_02>
		00000000000008e8:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x16
     8ec: 91000021     	add	x1, x1, #0x0
		00000000000008ec:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x16
     8f0: 91038260     	add	x0, x19, #0xe0
     8f4: 94000000     	bl	0x8f4 <iq4_f4_source_attach_on_ui_02+0x19c>
		00000000000008f4:  R_AARCH64_CALL26	iq4_f4_native_event_construct_02
     8f8: 34000540     	cbz	w0, 0x9a0 <iq4_f4_source_attach_on_ui_02+0x248>
     8fc: f84e0268     	ldur	x8, [x19, #0xe0]
     900: 5286f414     	mov	w20, #0x37a0            // =14240
     904: 72a01854     	movk	w20, #0xc2, lsl #16
     908: eb14011f     	cmp	x8, x20
     90c: 540004a1     	b.ne	0x9a0 <iq4_f4_source_attach_on_ui_02+0x248>
     910: f9400e62     	ldr	x2, [x19, #0x18]
     914: 90000001     	adrp	x1, 0x0 <iq4_f4_source_storage_bytes_02>
		0000000000000914:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x30
     918: 91000021     	add	x1, x1, #0x0
		0000000000000918:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x30
     91c: 91066260     	add	x0, x19, #0x198
     920: 94000000     	bl	0x920 <iq4_f4_source_attach_on_ui_02+0x1c8>
		0000000000000920:  R_AARCH64_CALL26	iq4_f4_native_construct_observer_02
     924: 340003e0     	cbz	w0, 0x9a0 <iq4_f4_source_attach_on_ui_02+0x248>
     928: f940d268     	ldr	x8, [x19, #0x1a0]
     92c: f9400e69     	ldr	x9, [x19, #0x18]
     930: eb09011f     	cmp	x8, x9
     934: 54000761     	b.ne	0xa20 <iq4_f4_source_attach_on_ui_02+0x2c8>
     938: 910c4288     	add	x8, x20, #0x310
     93c: 90000009     	adrp	x9, 0x0 <iq4_f4_source_storage_bytes_02>
		000000000000093c:  R_AARCH64_ADR_PREL_PG_HI21	.text+0xb44
     940: 91000129     	add	x9, x9, #0x0
		0000000000000940:  R_AARCH64_ADD_ABS_LO12_NC	.text+0xb44
     944: a91c2668     	stp	x8, x9, [x19, #0x1c0]
     948: 90000008     	adrp	x8, 0x0 <iq4_f4_source_storage_bytes_02>
		0000000000000948:  R_AARCH64_ADR_PREL_PG_HI21	.text+0xc88
     94c: 91000108     	add	x8, x8, #0x0
		000000000000094c:  R_AARCH64_ADD_ABS_LO12_NC	.text+0xc88
     950: a91d2269     	stp	x9, x8, [x19, #0x1d0]
     954: 91072269     	add	x9, x19, #0x1c8
     958: 52800028     	mov	w8, #0x1                // =1
     95c: 91038261     	add	x1, x19, #0xe0
     960: 91066262     	add	x2, x19, #0x198
     964: aa1303e0     	mov	x0, x19
     968: f900ce69     	str	x9, [x19, #0x198]
     96c: a91b7e73     	stp	x19, xzr, [x19, #0x1b0]
     970: b901e268     	str	w8, [x19, #0x1e0]
     974: 940000e8     	bl	0xd14 <exact_triple>
     978: 34000760     	cbz	w0, 0xa64 <iq4_f4_source_attach_on_ui_02+0x30c>
     97c: 9115a269     	add	x9, x19, #0x568
     980: 52801aa8     	mov	w8, #0xd5               // =213
     984: 889ffd28     	stlr	w8, [x9]
     988: 9115b269     	add	x9, x19, #0x56c
     98c: 885ffd2a     	ldaxr	w10, [x9]
     990: 350005aa     	cbnz	w10, 0xa44 <iq4_f4_source_attach_on_ui_02+0x2ec>
     994: 880afd28     	stlxr	w10, w8, [x9]
     998: 35ffffaa     	cbnz	w10, 0x98c <iq4_f4_source_attach_on_ui_02+0x234>
     99c: 14000012     	b	0x9e4 <iq4_f4_source_attach_on_ui_02+0x28c>
     9a0: 9115a269     	add	x9, x19, #0x568
     9a4: 52801a88     	mov	w8, #0xd4               // =212
     9a8: 889ffd28     	stlr	w8, [x9]
     9ac: 9115b269     	add	x9, x19, #0x56c
     9b0: 885ffd2a     	ldaxr	w10, [x9]
     9b4: 3500048a     	cbnz	w10, 0xa44 <iq4_f4_source_attach_on_ui_02+0x2ec>
     9b8: 880afd28     	stlxr	w10, w8, [x9]
     9bc: 35ffffaa     	cbnz	w10, 0x9b0 <iq4_f4_source_attach_on_ui_02+0x258>
     9c0: 14000009     	b	0x9e4 <iq4_f4_source_attach_on_ui_02+0x28c>
     9c4: 9115a269     	add	x9, x19, #0x568
     9c8: 52801a68     	mov	w8, #0xd3               // =211
     9cc: 889ffd28     	stlr	w8, [x9]
     9d0: 9115b269     	add	x9, x19, #0x56c
     9d4: 885ffd2a     	ldaxr	w10, [x9]
     9d8: 3500036a     	cbnz	w10, 0xa44 <iq4_f4_source_attach_on_ui_02+0x2ec>
     9dc: 880afd28     	stlxr	w10, w8, [x9]
     9e0: 35ffffaa     	cbnz	w10, 0x9d4 <iq4_f4_source_attach_on_ui_02+0x27c>
     9e4: 9115c268     	add	x8, x19, #0x570
     9e8: 52800029     	mov	w9, #0x1                // =1
     9ec: 889ffd09     	stlr	w9, [x8]
     9f0: 14000016     	b	0xa48 <iq4_f4_source_attach_on_ui_02+0x2f0>
     9f4: 9115a269     	add	x9, x19, #0x568
     9f8: 52801a68     	mov	w8, #0xd3               // =211
     9fc: 889ffd28     	stlr	w8, [x9]
     a00: 9115b269     	add	x9, x19, #0x56c
     a04: 885ffd2a     	ldaxr	w10, [x9]
     a08: 350001ea     	cbnz	w10, 0xa44 <iq4_f4_source_attach_on_ui_02+0x2ec>
     a0c: 880afd28     	stlxr	w10, w8, [x9]
     a10: 35ffffaa     	cbnz	w10, 0xa04 <iq4_f4_source_attach_on_ui_02+0x2ac>
     a14: 9115c268     	add	x8, x19, #0x570
     a18: 52800049     	mov	w9, #0x2                // =2
     a1c: 17fffff4     	b	0x9ec <iq4_f4_source_attach_on_ui_02+0x294>
     a20: 9115a269     	add	x9, x19, #0x568
     a24: 52801a88     	mov	w8, #0xd4               // =212
     a28: 889ffd28     	stlr	w8, [x9]
     a2c: 9115b269     	add	x9, x19, #0x56c
     a30: 885ffd2a     	ldaxr	w10, [x9]
     a34: 3500008a     	cbnz	w10, 0xa44 <iq4_f4_source_attach_on_ui_02+0x2ec>
     a38: 880afd28     	stlxr	w10, w8, [x9]
     a3c: 35ffffaa     	cbnz	w10, 0xa30 <iq4_f4_source_attach_on_ui_02+0x2d8>
     a40: 17fffff5     	b	0xa14 <iq4_f4_source_attach_on_ui_02+0x2bc>
     a44: d5033f5f     	clrex
     a48: 91032268     	add	x8, x19, #0xc8
     a4c: 91033269     	add	x9, x19, #0xcc
     a50: 5280002a     	mov	w10, #0x1               // =1
     a54: 889ffd1f     	stlr	wzr, [x8]
     a58: 528000a0     	mov	w0, #0x5                // =5
     a5c: 889ffd2a     	stlr	w10, [x9]
     a60: 17ffff62     	b	0x7e8 <iq4_f4_source_attach_on_ui_02+0x90>
     a64: 91066260     	add	x0, x19, #0x198
     a68: 91038261     	add	x1, x19, #0xe0
     a6c: 94000000     	bl	0xa6c <iq4_f4_source_attach_on_ui_02+0x314>
		0000000000000a6c:  R_AARCH64_CALL26	iq4_f4_native_subscribe_02
     a70: 34fff860     	cbz	w0, 0x97c <iq4_f4_source_attach_on_ui_02+0x224>
     a74: 91038261     	add	x1, x19, #0xe0
     a78: 91066262     	add	x2, x19, #0x198
     a7c: aa1303e0     	mov	x0, x19
     a80: 940000a5     	bl	0xd14 <exact_triple>
     a84: 7100041f     	cmp	w0, #0x1
     a88: 54fff7a1     	b.ne	0x97c <iq4_f4_source_attach_on_ui_02+0x224>
     a8c: 52800028     	mov	w8, #0x1                // =1
     a90: b901e668     	str	w8, [x19, #0x1e4]
     a94: 17ffff61     	b	0x818 <iq4_f4_source_attach_on_ui_02+0xc0>

0000000000000a98 <on_ui>:
     a98: d28a4649     	mov	x9, #0x5232             // =21042
     a9c: f9400008     	ldr	x8, [x0]
     aa0: f2a68a69     	movk	x9, #0x3453, lsl #16
     aa4: f2c688c9     	movk	x9, #0x3446, lsl #32
     aa8: f2e92a29     	movk	x9, #0x4951, lsl #48
     aac: eb09011f     	cmp	x8, x9
     ab0: 54000381     	b.ne	0xb20 <on_ui+0x88>
     ab4: d10243ff     	sub	sp, sp, #0x90
     ab8: a9077bfd     	stp	x29, x30, [sp, #0x70]
     abc: f90043f3     	str	x19, [sp, #0x80]
     ac0: 9101c3fd     	add	x29, sp, #0x70
     ac4: aa0003f3     	mov	x19, x0
     ac8: 94000000     	bl	0xac8 <on_ui+0x30>
		0000000000000ac8:  R_AARCH64_CALL26	iq4_f4_native_tid_02
     acc: f9402a68     	ldr	x8, [x19, #0x50]
     ad0: eb08001f     	cmp	x0, x8
     ad4: 540001c1     	b.ne	0xb0c <on_ui+0x74>
     ad8: 9100e3e1     	add	x1, sp, #0x38
     adc: aa1303e0     	mov	x0, x19
     ae0: 97fffde2     	bl	0x268 <owner>
     ae4: 34000160     	cbz	w0, 0xb10 <on_ui+0x78>
     ae8: 910003e1     	mov	x1, sp
     aec: aa1303e0     	mov	x0, x19
     af0: 97fffdde     	bl	0x268 <owner>
     af4: 340000e0     	cbz	w0, 0xb10 <on_ui+0x78>
     af8: 9100e3e0     	add	x0, sp, #0x38
     afc: 910003e1     	mov	x1, sp
     b00: 52800702     	mov	w2, #0x38               // =56
     b04: 94000000     	bl	0xb04 <on_ui+0x6c>
		0000000000000b04:  R_AARCH64_CALL26	memcmp
     b08: 34000100     	cbz	w0, 0xb28 <on_ui+0x90>
     b0c: 2a1f03e0     	mov	w0, wzr
     b10: a9477bfd     	ldp	x29, x30, [sp, #0x70]
     b14: f94043f3     	ldr	x19, [sp, #0x80]
     b18: 910243ff     	add	sp, sp, #0x90
     b1c: d65f03c0     	ret
     b20: 2a1f03e0     	mov	w0, wzr
     b24: d65f03c0     	ret
     b28: 9100e3e0     	add	x0, sp, #0x38
     b2c: 91006261     	add	x1, x19, #0x18
     b30: 52800702     	mov	w2, #0x38               // =56
     b34: 94000000     	bl	0xb34 <on_ui+0x9c>
		0000000000000b34:  R_AARCH64_CALL26	memcmp
     b38: 7100001f     	cmp	w0, #0x0
     b3c: 1a9f17e0     	cset	w0, eq
     b40: 17fffff4     	b	0xb10 <on_ui+0x78>

0000000000000b44 <destroy>:
     b44: b4000100     	cbz	x0, 0xb64 <destroy+0x20>
     b48: f9400c08     	ldr	x8, [x0, #0x18]
     b4c: b40000c8     	cbz	x8, 0xb64 <destroy+0x20>
     b50: 91032109     	add	x9, x8, #0xc8
     b54: 91033108     	add	x8, x8, #0xcc
     b58: 5280002a     	mov	w10, #0x1               // =1
     b5c: 889ffd3f     	stlr	wzr, [x9]
     b60: 889ffd0a     	stlr	w10, [x8]
     b64: d65f03c0     	ret

0000000000000b68 <notified>:
     b68: b4000580     	cbz	x0, 0xc18 <notified+0xb0>
     b6c: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
     b70: f9000bf5     	str	x21, [sp, #0x10]
     b74: a9024ff4     	stp	x20, x19, [sp, #0x20]
     b78: 910003fd     	mov	x29, sp
     b7c: f9400c13     	ldr	x19, [x0, #0x18]
     b80: b4000473     	cbz	x19, 0xc0c <notified+0xa4>
     b84: 91034274     	add	x20, x19, #0xd0
     b88: 885ffe88     	ldaxr	w8, [x20]
     b8c: 11000508     	add	w8, w8, #0x1
     b90: 8809fe88     	stlxr	w9, w8, [x20]
     b94: 35ffffa9     	cbnz	w9, 0xb88 <notified+0x20>
     b98: d28a464a     	mov	x10, #0x5232            // =21042
     b9c: f9428268     	ldr	x8, [x19, #0x500]
     ba0: f9400269     	ldr	x9, [x19]
     ba4: f2a68a6a     	movk	x10, #0x3453, lsl #16
     ba8: f2c688ca     	movk	x10, #0x3446, lsl #32
     bac: 91000508     	add	x8, x8, #0x1
     bb0: f2e92a2a     	movk	x10, #0x4951, lsl #48
     bb4: f9028268     	str	x8, [x19, #0x500]
     bb8: eb0a013f     	cmp	x9, x10
     bbc: 54000101     	b.ne	0xbdc <notified+0x74>
     bc0: aa1303e0     	mov	x0, x19
     bc4: aa0103f5     	mov	x21, x1
     bc8: 97ffffb4     	bl	0xa98 <on_ui>
     bcc: 34000080     	cbz	w0, 0xbdc <notified+0x74>
     bd0: f9402669     	ldr	x9, [x19, #0x48]
     bd4: eb0902bf     	cmp	x21, x9
     bd8: 54000220     	b.eq	0xc1c <notified+0xb4>
     bdc: f9429e68     	ldr	x8, [x19, #0x538]
     be0: 91032269     	add	x9, x19, #0xc8
     be4: 5280002a     	mov	w10, #0x1               // =1
     be8: 91000508     	add	x8, x8, #0x1
     bec: f9029e68     	str	x8, [x19, #0x538]
     bf0: 91033268     	add	x8, x19, #0xcc
     bf4: 889ffd3f     	stlr	wzr, [x9]
     bf8: 889ffd0a     	stlr	w10, [x8]
     bfc: 885f7e88     	ldxr	w8, [x20]
     c00: 51000508     	sub	w8, w8, #0x1
     c04: 8809fe88     	stlxr	w9, w8, [x20]
     c08: 35ffffa9     	cbnz	w9, 0xbfc <notified+0x94>
     c0c: a9424ff4     	ldp	x20, x19, [sp, #0x20]
     c10: f9400bf5     	ldr	x21, [sp, #0x10]
     c14: a8c37bfd     	ldp	x29, x30, [sp], #0x30
     c18: d65f03c0     	ret
     c1c: 91032268     	add	x8, x19, #0xc8
     c20: 88dffd08     	ldar	w8, [x8]
     c24: 34fffec8     	cbz	w8, 0xbfc <notified+0x94>
     c28: 91033268     	add	x8, x19, #0xcc
     c2c: 88dffd08     	ldar	w8, [x8]
     c30: 35fffe68     	cbnz	w8, 0xbfc <notified+0x94>
     c34: f940fa68     	ldr	x8, [x19, #0x1f0]
     c38: b4000168     	cbz	x8, 0xc64 <notified+0xfc>
     c3c: f940fe60     	ldr	x0, [x19, #0x1f8]
     c40: d63f0100     	blr	x8
     c44: 340001c0     	cbz	w0, 0xc7c <notified+0x114>
     c48: 7100041f     	cmp	w0, #0x1
     c4c: 540000c1     	b.ne	0xc64 <notified+0xfc>
     c50: aa1303e0     	mov	x0, x19
     c54: 52800021     	mov	w1, #0x1                // =1
     c58: aa1f03e2     	mov	x2, xzr
     c5c: 94000116     	bl	0x10b4 <sample>
     c60: 17ffffe7     	b	0xbfc <notified+0x94>
     c64: 91032268     	add	x8, x19, #0xc8
     c68: 91033269     	add	x9, x19, #0xcc
     c6c: 5280002a     	mov	w10, #0x1               // =1
     c70: 889ffd1f     	stlr	wzr, [x8]
     c74: 889ffd2a     	stlr	w10, [x9]
     c78: 17ffffe1     	b	0xbfc <notified+0x94>
     c7c: aa1303e0     	mov	x0, x19
     c80: 94000000     	bl	0xc80 <notified+0x118>
		0000000000000c80:  R_AARCH64_CALL26	iq4_f4_source_request_stop_02
     c84: 17ffffde     	b	0xbfc <notified+0x94>

0000000000000c88 <control_notified>:
     c88: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
     c8c: a9014ff4     	stp	x20, x19, [sp, #0x10]
     c90: 910003fd     	mov	x29, sp
     c94: b40003a0     	cbz	x0, 0xd08 <control_notified+0x80>
     c98: f9400c13     	ldr	x19, [x0, #0x18]
     c9c: b4000373     	cbz	x19, 0xd08 <control_notified+0x80>
     ca0: aa1303e0     	mov	x0, x19
     ca4: aa0103f4     	mov	x20, x1
     ca8: 97ffff7c     	bl	0xa98 <on_ui>
     cac: 34000240     	cbz	w0, 0xcf4 <control_notified+0x6c>
     cb0: 91038268     	add	x8, x19, #0xe0
     cb4: eb08029f     	cmp	x20, x8
     cb8: 540001e1     	b.ne	0xcf4 <control_notified+0x6c>
     cbc: 9107a268     	add	x8, x19, #0x1e8
     cc0: 88dffd08     	ldar	w8, [x8]
     cc4: 34000068     	cbz	w8, 0xcd0 <control_notified+0x48>
     cc8: aa1303e0     	mov	x0, x19
     ccc: 94000000     	bl	0xccc <control_notified+0x44>
		0000000000000ccc:  R_AARCH64_CALL26	iq4_f4_source_stop_on_ui_02
     cd0: 91033268     	add	x8, x19, #0xcc
     cd4: 88dffd08     	ldar	w8, [x8]
     cd8: 35000188     	cbnz	w8, 0xd08 <control_notified+0x80>
     cdc: f9410661     	ldr	x1, [x19, #0x208]
     ce0: b4000141     	cbz	x1, 0xd08 <control_notified+0x80>
     ce4: f9410a60     	ldr	x0, [x19, #0x210]
     ce8: a9414ff4     	ldp	x20, x19, [sp, #0x10]
     cec: a8c27bfd     	ldp	x29, x30, [sp], #0x20
     cf0: d61f0020     	br	x1
     cf4: 91032268     	add	x8, x19, #0xc8
     cf8: 91033269     	add	x9, x19, #0xcc
     cfc: 5280002a     	mov	w10, #0x1               // =1
     d00: 889ffd1f     	stlr	wzr, [x8]
     d04: 889ffd2a     	stlr	w10, [x9]
     d08: a9414ff4     	ldp	x20, x19, [sp, #0x10]
     d0c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
     d10: d65f03c0     	ret

0000000000000d14 <exact_triple>:
     d14: d10303ff     	sub	sp, sp, #0xc0
     d18: a9067bfd     	stp	x29, x30, [sp, #0x60]
     d1c: a9076ffc     	stp	x28, x27, [sp, #0x70]
     d20: a90867fa     	stp	x26, x25, [sp, #0x80]
     d24: a9095ff8     	stp	x24, x23, [sp, #0x90]
     d28: a90a57f6     	stp	x22, x21, [sp, #0xa0]
     d2c: a90b4ff4     	stp	x20, x19, [sp, #0xb0]
     d30: 910183fd     	add	x29, sp, #0x60
     d34: aa0203f3     	mov	x19, x2
     d38: aa0103f4     	mov	x20, x1
     d3c: aa0003f5     	mov	x21, x0
     d40: 97ffff56     	bl	0xa98 <on_ui>
     d44: 34000560     	cbz	w0, 0xdf0 <exact_triple+0xdc>
     d48: a94082a8     	ldp	x8, x0, [x21, #0x8]
     d4c: 528a7816     	mov	w22, #0x53c0            // =21440
     d50: 72a01eb6     	movk	w22, #0xf5, lsl #16
     d54: 910013e2     	add	x2, sp, #0x4
     d58: 52800083     	mov	w3, #0x4                // =4
     d5c: b27c02c1     	orr	x1, x22, #0x10
     d60: d63f0100     	blr	x8
     d64: 7100041f     	cmp	w0, #0x1
     d68: 12800000     	mov	w0, #-0x1               // =-1
     d6c: 54000441     	b.ne	0xdf4 <exact_triple+0xe0>
     d70: b94007e8     	ldr	w8, [sp, #0x4]
     d74: 7100051f     	cmp	w8, #0x1
     d78: 540003e1     	b.ne	0xdf4 <exact_triple+0xe0>
     d7c: a94082a8     	ldp	x8, x0, [x21, #0x8]
     d80: d10062c1     	sub	x1, x22, #0x18
     d84: 910023e2     	add	x2, sp, #0x8
     d88: 52800103     	mov	w3, #0x8                // =8
     d8c: d63f0100     	blr	x8
     d90: 7100041f     	cmp	w0, #0x1
     d94: 12800000     	mov	w0, #-0x1               // =-1
     d98: 540002e1     	b.ne	0xdf4 <exact_triple+0xe0>
     d9c: f94007e8     	ldr	x8, [sp, #0x8]
     da0: b40002a8     	cbz	x8, 0xdf4 <exact_triple+0xe0>
     da4: 528a7800     	mov	w0, #0x53c0             // =21440
     da8: 72a01ea0     	movk	w0, #0xf5, lsl #16
     dac: 94000000     	bl	0xdac <exact_triple+0x98>
		0000000000000dac:  R_AARCH64_CALL26	iq4_f4_native_queue_lock_05
     db0: 34000200     	cbz	w0, 0xdf0 <exact_triple+0xdc>
     db4: f9400eb7     	ldr	x23, [x21, #0x18]
     db8: 910222f6     	add	x22, x23, #0x88
     dbc: d343fec8     	lsr	x8, x22, #3
     dc0: f108051f     	cmp	x8, #0x201
     dc4: 54000282     	b.hs	0xe14 <exact_triple+0x100>
     dc8: 1280001b     	mov	w27, #-0x1              // =-1
     dcc: 528a7800     	mov	w0, #0x53c0             // =21440
     dd0: 910003e1     	mov	x1, sp
     dd4: 72a01ea0     	movk	w0, #0xf5, lsl #16
     dd8: 94000000     	bl	0xdd8 <exact_triple+0xc4>
		0000000000000dd8:  R_AARCH64_CALL26	iq4_f4_native_mutex_unlock_02
     ddc: b94003e8     	ldr	w8, [sp]
     de0: 7100011f     	cmp	w8, #0x0
     de4: 7a400804     	ccmp	w0, #0x0, #0x4, eq
     de8: 5a9f1360     	csinv	w0, w27, wzr, ne
     dec: 14000002     	b	0xdf4 <exact_triple+0xe0>
     df0: 12800000     	mov	w0, #-0x1               // =-1
     df4: a94b4ff4     	ldp	x20, x19, [sp, #0xb0]
     df8: a94a57f6     	ldp	x22, x21, [sp, #0xa0]
     dfc: a9495ff8     	ldp	x24, x23, [sp, #0x90]
     e00: a94867fa     	ldp	x26, x25, [sp, #0x80]
     e04: a9476ffc     	ldp	x28, x27, [sp, #0x70]
     e08: a9467bfd     	ldp	x29, x30, [sp, #0x60]
     e0c: 910303ff     	add	sp, sp, #0xc0
     e10: d65f03c0     	ret
     e14: a94082a8     	ldp	x8, x0, [x21, #0x8]
     e18: 910202e1     	add	x1, x23, #0x80
     e1c: d10023a2     	sub	x2, x29, #0x8
     e20: 52800103     	mov	w3, #0x8                // =8
     e24: d63f0100     	blr	x8
     e28: 910242e8     	add	x8, x23, #0x90
     e2c: 1280001b     	mov	w27, #-0x1              // =-1
     e30: d343fd08     	lsr	x8, x8, #3
     e34: f108051f     	cmp	x8, #0x201
     e38: 54fffca3     	b.lo	0xdcc <exact_triple+0xb8>
     e3c: 7100041f     	cmp	w0, #0x1
     e40: 54fffc61     	b.ne	0xdcc <exact_triple+0xb8>
     e44: a94082a8     	ldp	x8, x0, [x21, #0x8]
     e48: d10043a2     	sub	x2, x29, #0x10
     e4c: aa1603e1     	mov	x1, x22
     e50: 52800103     	mov	w3, #0x8                // =8
     e54: d63f0100     	blr	x8
     e58: 7100041f     	cmp	w0, #0x1
     e5c: 54fffb81     	b.ne	0xdcc <exact_triple+0xb8>
     e60: f85f83a1     	ldur	x1, [x29, #-0x8]
     e64: 9101e2f7     	add	x23, x23, #0x78
     e68: eb17003f     	cmp	x1, x23
     e6c: 540000e1     	b.ne	0xe88 <exact_triple+0x174>
     e70: 2a1f03f6     	mov	w22, wzr
     e74: aa1703fc     	mov	x28, x23
     e78: f85f03a8     	ldur	x8, [x29, #-0x10]
     e7c: eb08039f     	cmp	x28, x8
     e80: 5a9f02db     	csinv	w27, w22, wzr, eq
     e84: 17ffffd2     	b	0xdcc <exact_triple+0xb8>
     e88: 5287971a     	mov	w26, #0x3cb8            // =15544
     e8c: 2a1f03f6     	mov	w22, wzr
     e90: 52820038     	mov	w24, #0x1001            // =4097
     e94: 52920039     	mov	w25, #0x9001            // =36865
     e98: 72a0185a     	movk	w26, #0xc2, lsl #16
     e9c: aa1703fc     	mov	x28, x23
     ea0: 8b190028     	add	x8, x1, x25
     ea4: 1280001b     	mov	w27, #-0x1              // =-1
     ea8: f140291f     	cmp	x8, #0xa, lsl #12       // =0xa000
     eac: 54fff909     	b.ls	0xdcc <exact_triple+0xb8>
     eb0: 92400828     	and	x8, x1, #0x7
     eb4: b5fff8c8     	cbnz	x8, 0xdcc <exact_triple+0xb8>
     eb8: 71000718     	subs	w24, w24, #0x1
     ebc: 54fff880     	b.eq	0xdcc <exact_triple+0xb8>
     ec0: a94082a8     	ldp	x8, x0, [x21, #0x8]
     ec4: 9100a3e2     	add	x2, sp, #0x28
     ec8: 52800403     	mov	w3, #0x20               // =32
     ecc: d63f0100     	blr	x8
     ed0: 7100041f     	cmp	w0, #0x1
     ed4: 54fff7c1     	b.ne	0xdcc <exact_triple+0xb8>
     ed8: f94017e8     	ldr	x8, [sp, #0x28]
     edc: eb1a011f     	cmp	x8, x26
     ee0: 54fff761     	b.ne	0xdcc <exact_triple+0xb8>
     ee4: f9401fe8     	ldr	x8, [sp, #0x38]
     ee8: eb1c011f     	cmp	x8, x28
     eec: 54fff701     	b.ne	0xdcc <exact_triple+0xb8>
     ef0: f9401be8     	ldr	x8, [sp, #0x30]
     ef4: 8b190109     	add	x9, x8, x25
     ef8: f140293f     	cmp	x9, #0xa, lsl #12       // =0xa000
     efc: 54fff689     	b.ls	0xdcc <exact_triple+0xb8>
     f00: 92400909     	and	x9, x8, #0x7
     f04: b5fff649     	cbnz	x9, 0xdcc <exact_triple+0xb8>
     f08: f94023e9     	ldr	x9, [sp, #0x40]
     f0c: 8b19012a     	add	x10, x9, x25
     f10: f140295f     	cmp	x10, #0xa, lsl #12      // =0xa000
     f14: 54fff5c9     	b.ls	0xdcc <exact_triple+0xb8>
     f18: 9240092a     	and	x10, x9, #0x7
     f1c: b5fff58a     	cbnz	x10, 0xdcc <exact_triple+0xb8>
     f20: f85f83aa     	ldur	x10, [x29, #-0x8]
     f24: 9101a129     	add	x9, x9, #0x68
     f28: eb09015f     	cmp	x10, x9
     f2c: 54fff501     	b.ne	0xdcc <exact_triple+0xb8>
     f30: a94082a9     	ldp	x9, x0, [x21, #0x8]
     f34: 91004101     	add	x1, x8, #0x10
     f38: d10063a2     	sub	x2, x29, #0x18
     f3c: 52800103     	mov	w3, #0x8                // =8
     f40: d63f0120     	blr	x9
     f44: 7100041f     	cmp	w0, #0x1
     f48: 54fff421     	b.ne	0xdcc <exact_triple+0xb8>
     f4c: f85e83a8     	ldur	x8, [x29, #-0x18]
     f50: f85f83a9     	ldur	x9, [x29, #-0x8]
     f54: eb09011f     	cmp	x8, x9
     f58: 54fff3a1     	b.ne	0xdcc <exact_triple+0xb8>
     f5c: f94023e8     	ldr	x8, [sp, #0x40]
     f60: 91004109     	add	x9, x8, #0x10
     f64: d343fd29     	lsr	x9, x9, #3
     f68: f108053f     	cmp	x9, #0x201
     f6c: 54fff303     	b.lo	0xdcc <exact_triple+0xb8>
     f70: a94082a9     	ldp	x9, x0, [x21, #0x8]
     f74: 91002101     	add	x1, x8, #0x8
     f78: 910083e2     	add	x2, sp, #0x20
     f7c: 52800103     	mov	w3, #0x8                // =8
     f80: d63f0120     	blr	x9
     f84: 7100041f     	cmp	w0, #0x1
     f88: 54fff221     	b.ne	0xdcc <exact_triple+0xb8>
     f8c: f94023e8     	ldr	x8, [sp, #0x40]
     f90: 9100e109     	add	x9, x8, #0x38
     f94: d343fd29     	lsr	x9, x9, #3
     f98: f108053f     	cmp	x9, #0x201
     f9c: 54fff183     	b.lo	0xdcc <exact_triple+0xb8>
     fa0: a94082a9     	ldp	x9, x0, [x21, #0x8]
     fa4: 9100c101     	add	x1, x8, #0x30
     fa8: 910063e2     	add	x2, sp, #0x18
     fac: 52800103     	mov	w3, #0x8                // =8
     fb0: d63f0120     	blr	x9
     fb4: 7100041f     	cmp	w0, #0x1
     fb8: 54fff0a1     	b.ne	0xdcc <exact_triple+0xb8>
     fbc: f9400fe8     	ldr	x8, [sp, #0x18]
     fc0: f9400ea9     	ldr	x9, [x21, #0x18]
     fc4: eb09011f     	cmp	x8, x9
     fc8: 54fff021     	b.ne	0xdcc <exact_triple+0xb8>
     fcc: f94023e8     	ldr	x8, [sp, #0x40]
     fd0: 91012109     	add	x9, x8, #0x48
     fd4: d343fd29     	lsr	x9, x9, #3
     fd8: f108053f     	cmp	x9, #0x201
     fdc: 54ffef83     	b.lo	0xdcc <exact_triple+0xb8>
     fe0: a94082a9     	ldp	x9, x0, [x21, #0x8]
     fe4: 91010101     	add	x1, x8, #0x40
     fe8: 910043e2     	add	x2, sp, #0x10
     fec: 52800103     	mov	w3, #0x8                // =8
     ff0: d63f0120     	blr	x9
     ff4: 7100041f     	cmp	w0, #0x1
     ff8: 54ffeea1     	b.ne	0xdcc <exact_triple+0xb8>
     ffc: f94013e8     	ldr	x8, [sp, #0x20]
    1000: eb14011f     	cmp	x8, x20
    1004: 540000c1     	b.ne	0x101c <exact_triple+0x308>
    1008: f9400be8     	ldr	x8, [sp, #0x10]
    100c: eb13011f     	cmp	x8, x19
    1010: 54000061     	b.ne	0x101c <exact_triple+0x308>
    1014: 35ffedd6     	cbnz	w22, 0xdcc <exact_triple+0xb8>
    1018: 52800036     	mov	w22, #0x1               // =1
    101c: f9401be1     	ldr	x1, [sp, #0x30]
    1020: f85f83bc     	ldur	x28, [x29, #-0x8]
    1024: eb17003f     	cmp	x1, x23
    1028: f81f83a1     	stur	x1, [x29, #-0x8]
    102c: 54fff3a1     	b.ne	0xea0 <exact_triple+0x18c>
    1030: 17ffff92     	b	0xe78 <exact_triple+0x164>

0000000000001034 <iq4_f4_source_measure_on_ui_02>:
    1034: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
    1038: a9014ff4     	stp	x20, x19, [sp, #0x10]
    103c: 910003fd     	mov	x29, sp
    1040: aa0003f3     	mov	x19, x0
    1044: 52800040     	mov	w0, #0x2                // =2
    1048: b4000253     	cbz	x19, 0x1090 <iq4_f4_source_measure_on_ui_02+0x5c>
    104c: b4000221     	cbz	x1, 0x1090 <iq4_f4_source_measure_on_ui_02+0x5c>
    1050: aa1303e0     	mov	x0, x19
    1054: aa0103f4     	mov	x20, x1
    1058: 97fffe90     	bl	0xa98 <on_ui>
    105c: 34000180     	cbz	w0, 0x108c <iq4_f4_source_measure_on_ui_02+0x58>
    1060: 91033268     	add	x8, x19, #0xcc
    1064: 88dffd08     	ldar	w8, [x8]
    1068: 34000068     	cbz	w8, 0x1074 <iq4_f4_source_measure_on_ui_02+0x40>
    106c: 528000a0     	mov	w0, #0x5                // =5
    1070: 14000008     	b	0x1090 <iq4_f4_source_measure_on_ui_02+0x5c>
    1074: 91032268     	add	x8, x19, #0xc8
    1078: 88dffd08     	ldar	w8, [x8]
    107c: 35000088     	cbnz	w8, 0x108c <iq4_f4_source_measure_on_ui_02+0x58>
    1080: 91034268     	add	x8, x19, #0xd0
    1084: 88dffd08     	ldar	w8, [x8]
    1088: 340000a8     	cbz	w8, 0x109c <iq4_f4_source_measure_on_ui_02+0x68>
    108c: 52800040     	mov	w0, #0x2                // =2
    1090: a9414ff4     	ldp	x20, x19, [sp, #0x10]
    1094: a8c27bfd     	ldp	x29, x30, [sp], #0x20
    1098: d65f03c0     	ret
    109c: aa1303e0     	mov	x0, x19
    10a0: aa1403e2     	mov	x2, x20
    10a4: 2a1f03e1     	mov	w1, wzr
    10a8: a9414ff4     	ldp	x20, x19, [sp, #0x10]
    10ac: a8c27bfd     	ldp	x29, x30, [sp], #0x20
    10b0: 14000001     	b	0x10b4 <sample>

00000000000010b4 <sample>:
    10b4: d10403ff     	sub	sp, sp, #0x100
    10b8: a90a7bfd     	stp	x29, x30, [sp, #0xa0]
    10bc: f9005bfb     	str	x27, [sp, #0xb0]
    10c0: a90c67fa     	stp	x26, x25, [sp, #0xc0]
    10c4: a90d5ff8     	stp	x24, x23, [sp, #0xd0]
    10c8: a90e57f6     	stp	x22, x21, [sp, #0xe0]
    10cc: a90f4ff4     	stp	x20, x19, [sp, #0xf0]
    10d0: 910283fd     	add	x29, sp, #0xa0
    10d4: 6f00e400     	movi	v0.2d, #0000000000000000
    10d8: aa0203f4     	mov	x20, x2
    10dc: 2a0103f5     	mov	w21, w1
    10e0: f9402016     	ldr	x22, [x0, #0x40]
    10e4: d10013a1     	sub	x1, x29, #0x4
    10e8: d10043a2     	sub	x2, x29, #0x10
    10ec: aa0003f3     	mov	x19, x0
    10f0: ad0083e0     	stp	q0, q0, [sp, #0x10]
    10f4: ad0183e0     	stp	q0, q0, [sp, #0x30]
    10f8: 940002ba     	bl	0x1be0 <live>
    10fc: 34000200     	cbz	w0, 0x113c <sample+0x88>
    1100: d10043b8     	sub	x24, x29, #0x10
    1104: f9400308     	ldr	x8, [x24]
    1108: b4000328     	cbz	x8, 0x116c <sample+0xb8>
    110c: 9115a269     	add	x9, x19, #0x568
    1110: 52801b88     	mov	w8, #0xdc               // =220
    1114: 889ffd28     	stlr	w8, [x9]
    1118: 9115b269     	add	x9, x19, #0x56c
    111c: 885ffd2a     	ldaxr	w10, [x9]
    1120: 3500048a     	cbnz	w10, 0x11b0 <sample+0xfc>
    1124: 880afd28     	stlxr	w10, w8, [x9]
    1128: 35ffffaa     	cbnz	w10, 0x111c <sample+0x68>
    112c: 9115c268     	add	x8, x19, #0x570
    1130: 52800049     	mov	w9, #0x2                // =2
    1134: 889ffd09     	stlr	w9, [x8]
    1138: 1400001f     	b	0x11b4 <sample+0x100>
    113c: 9115a269     	add	x9, x19, #0x568
    1140: 52801b88     	mov	w8, #0xdc               // =220
    1144: 889ffd28     	stlr	w8, [x9]
    1148: 9115b269     	add	x9, x19, #0x56c
    114c: 885ffd2a     	ldaxr	w10, [x9]
    1150: 350003ca     	cbnz	w10, 0x11c8 <sample+0x114>
    1154: 880afd28     	stlxr	w10, w8, [x9]
    1158: 35ffffaa     	cbnz	w10, 0x114c <sample+0x98>
    115c: 9115c268     	add	x8, x19, #0x570
    1160: 52800029     	mov	w9, #0x1                // =1
    1164: 889ffd09     	stlr	w9, [x8]
    1168: 14000019     	b	0x11cc <sample+0x118>
    116c: 52844b88     	mov	w8, #0x225c             // =8796
    1170: 8b0802c8     	add	x8, x22, x8
    1174: d342fd08     	lsr	x8, x8, #2
    1178: f110051f     	cmp	x8, #0x401
    117c: 54000322     	b.hs	0x11e0 <sample+0x12c>
    1180: 9115a269     	add	x9, x19, #0x568
    1184: 52801b88     	mov	w8, #0xdc               // =220
    1188: 889ffd28     	stlr	w8, [x9]
    118c: 9115b269     	add	x9, x19, #0x56c
    1190: 885ffd2a     	ldaxr	w10, [x9]
    1194: 3500248a     	cbnz	w10, 0x1624 <sample+0x570>
    1198: 880afd28     	stlxr	w10, w8, [x9]
    119c: 35ffffaa     	cbnz	w10, 0x1190 <sample+0xdc>
    11a0: 9115c268     	add	x8, x19, #0x570
    11a4: 52800069     	mov	w9, #0x3                // =3
    11a8: 889ffd09     	stlr	w9, [x8]
    11ac: 1400011f     	b	0x1628 <sample+0x574>
    11b0: d5033f5f     	clrex
    11b4: f9429a68     	ldr	x8, [x19, #0x530]
    11b8: 52800040     	mov	w0, #0x2                // =2
    11bc: 91000508     	add	x8, x8, #0x1
    11c0: f9029a68     	str	x8, [x19, #0x530]
    11c4: 1400011d     	b	0x1638 <sample+0x584>
    11c8: d5033f5f     	clrex
    11cc: f9429e68     	ldr	x8, [x19, #0x538]
    11d0: 52800040     	mov	w0, #0x2                // =2
    11d4: 91000508     	add	x8, x8, #0x1
    11d8: f9029e68     	str	x8, [x19, #0x538]
    11dc: 14000117     	b	0x1638 <sample+0x584>
    11e0: a9408268     	ldp	x8, x0, [x19, #0x8]
    11e4: 52844b17     	mov	w23, #0x2258            // =8792
    11e8: 8b1702c1     	add	x1, x22, x23
    11ec: d10093a2     	sub	x2, x29, #0x24
    11f0: 52800083     	mov	w3, #0x4                // =4
    11f4: d63f0100     	blr	x8
    11f8: 7100041f     	cmp	w0, #0x1
    11fc: 54fffc21     	b.ne	0x1180 <sample+0xcc>
    1200: b85dc3a8     	ldur	w8, [x29, #-0x24]
    1204: 7100111f     	cmp	w8, #0x4
    1208: 54fffbc1     	b.ne	0x1180 <sample+0xcc>
    120c: 52844a88     	mov	w8, #0x2254             // =8788
    1210: 8b0802c1     	add	x1, x22, x8
    1214: f140043f     	cmp	x1, #0x1, lsl #12       // =0x1000
    1218: 54fffb43     	b.lo	0x1180 <sample+0xcc>
    121c: a9408268     	ldp	x8, x0, [x19, #0x8]
    1220: d100e3a2     	sub	x2, x29, #0x38
    1224: 52800083     	mov	w3, #0x4                // =4
    1228: d63f0100     	blr	x8
    122c: 7100041f     	cmp	w0, #0x1
    1230: 54fffa81     	b.ne	0x1180 <sample+0xcc>
    1234: b85c83a8     	ldur	w8, [x29, #-0x38]
    1238: 7100111f     	cmp	w8, #0x4
    123c: 54fffa22     	b.hs	0x1180 <sample+0xcc>
    1240: f9401e60     	ldr	x0, [x19, #0x38]
    1244: b85fc3a1     	ldur	w1, [x29, #-0x4]
    1248: d10063a2     	sub	x2, x29, #0x18
    124c: 94000000     	bl	0x124c <sample+0x198>
		000000000000124c:  R_AARCH64_CALL26	iq4_f4_native_lock_02
    1250: 34002040     	cbz	w0, 0x1658 <sample+0x5a4>
    1254: a9408268     	ldp	x8, x0, [x19, #0x8]
    1258: 8b1702c1     	add	x1, x22, x23
    125c: d100a3a2     	sub	x2, x29, #0x28
    1260: 52800083     	mov	w3, #0x4                // =4
    1264: d63f0100     	blr	x8
    1268: 7100041f     	cmp	w0, #0x1
    126c: 54002cc1     	b.ne	0x1804 <sample+0x750>
    1270: b85d83a8     	ldur	w8, [x29, #-0x28]
    1274: 71000d1f     	cmp	w8, #0x3
    1278: 54002c68     	b.hi	0x1804 <sample+0x750>
    127c: 52844d08     	mov	w8, #0x2268             // =8808
    1280: 8b0802c8     	add	x8, x22, x8
    1284: d342fd08     	lsr	x8, x8, #2
    1288: f110051f     	cmp	x8, #0x401
    128c: 54002bc3     	b.lo	0x1804 <sample+0x750>
    1290: a9408268     	ldp	x8, x0, [x19, #0x8]
    1294: 52844c99     	mov	w25, #0x2264            // =8804
    1298: 8b1902c1     	add	x1, x22, x25
    129c: d100b3a2     	sub	x2, x29, #0x2c
    12a0: 52800083     	mov	w3, #0x4                // =4
    12a4: d63f0100     	blr	x8
    12a8: 7100041f     	cmp	w0, #0x1
    12ac: 54002ac1     	b.ne	0x1804 <sample+0x750>
    12b0: f9401e60     	ldr	x0, [x19, #0x38]
    12b4: d10103a1     	sub	x1, x29, #0x40
    12b8: 94000000     	bl	0x12b8 <sample+0x204>
		00000000000012b8:  R_AARCH64_CALL26	iq4_f4_native_size_02
    12bc: 34001ec0     	cbz	w0, 0x1694 <sample+0x5e0>
    12c0: f9401e60     	ldr	x0, [x19, #0x38]
    12c4: d100c3a1     	sub	x1, x29, #0x30
    12c8: 94000000     	bl	0x12c8 <sample+0x214>
		00000000000012c8:  R_AARCH64_CALL26	iq4_f4_native_id_02
    12cc: 34001e40     	cbz	w0, 0x1694 <sample+0x5e0>
    12d0: d10023a1     	sub	x1, x29, #0x8
    12d4: d10043a2     	sub	x2, x29, #0x10
    12d8: aa1303e0     	mov	x0, x19
    12dc: 94000241     	bl	0x1be0 <live>
    12e0: 34001da0     	cbz	w0, 0x1694 <sample+0x5e0>
    12e4: 297f27a8     	ldp	w8, w9, [x29, #-0x8]
    12e8: 6b09011f     	cmp	w8, w9
    12ec: 52800048     	mov	w8, #0x2                // =2
    12f0: 54001d41     	b.ne	0x1698 <sample+0x5e4>
    12f4: f9400309     	ldr	x9, [x24]
    12f8: b5001d09     	cbnz	x9, 0x1698 <sample+0x5e4>
    12fc: b85d83a8     	ldur	w8, [x29, #-0x28]
    1300: 52843009     	mov	w9, #0x2180             // =8576
    1304: 8b0902da     	add	x26, x22, x9
    1308: 531d7108     	lsl	w8, w8, #3
    130c: 8b080341     	add	x1, x26, x8
    1310: 91002028     	add	x8, x1, #0x8
    1314: d343fd08     	lsr	x8, x8, #3
    1318: f108051f     	cmp	x8, #0x201
    131c: 54001bc3     	b.lo	0x1694 <sample+0x5e0>
    1320: a9408268     	ldp	x8, x0, [x19, #0x8]
    1324: d10083a2     	sub	x2, x29, #0x20
    1328: 52800103     	mov	w3, #0x8                // =8
    132c: d63f0100     	blr	x8
    1330: 7100041f     	cmp	w0, #0x1
    1334: 54001b01     	b.ne	0x1694 <sample+0x5e0>
    1338: a97e27a8     	ldp	x8, x9, [x29, #-0x20]
    133c: eb09011f     	cmp	x8, x9
    1340: 54001aa1     	b.ne	0x1694 <sample+0x5e0>
    1344: 52800048     	mov	w8, #0x2                // =2
    1348: b4001a89     	cbz	x9, 0x1698 <sample+0x5e4>
    134c: b85d83a8     	ldur	w8, [x29, #-0x28]
    1350: 52843909     	mov	w9, #0x21c8             // =8648
    1354: 531d7108     	lsl	w8, w8, #3
    1358: 8b0802c8     	add	x8, x22, x8
    135c: 8b090109     	add	x9, x8, x9
    1360: d343fd29     	lsr	x9, x9, #3
    1364: f108053f     	cmp	x9, #0x201
    1368: 54001963     	b.lo	0x1694 <sample+0x5e0>
    136c: a9408269     	ldp	x9, x0, [x19, #0x8]
    1370: 5284380a     	mov	w10, #0x21c0            // =8640
    1374: 8b0a0101     	add	x1, x8, x10
    1378: d10123a2     	sub	x2, x29, #0x48
    137c: 52800103     	mov	w3, #0x8                // =8
    1380: d63f0120     	blr	x9
    1384: 7100041f     	cmp	w0, #0x1
    1388: 54001861     	b.ne	0x1694 <sample+0x5e0>
    138c: a97ba7a8     	ldp	x8, x9, [x29, #-0x48]
    1390: eb09011f     	cmp	x8, x9
    1394: 54001801     	b.ne	0x1694 <sample+0x5e0>
    1398: 297a27a8     	ldp	w8, w9, [x29, #-0x30]
    139c: 6b09011f     	cmp	w8, w9
    13a0: 540017a1     	b.ne	0x1694 <sample+0x5e0>
    13a4: a9408268     	ldp	x8, x0, [x19, #0x8]
    13a8: 8b1702c1     	add	x1, x22, x23
    13ac: d100d3a2     	sub	x2, x29, #0x34
    13b0: 52800083     	mov	w3, #0x4                // =4
    13b4: d63f0100     	blr	x8
    13b8: 7100041f     	cmp	w0, #0x1
    13bc: 540016c1     	b.ne	0x1694 <sample+0x5e0>
    13c0: b85cc3a8     	ldur	w8, [x29, #-0x34]
    13c4: b85d83a9     	ldur	w9, [x29, #-0x28]
    13c8: 6b09011f     	cmp	w8, w9
    13cc: 54001641     	b.ne	0x1694 <sample+0x5e0>
    13d0: a9408268     	ldp	x8, x0, [x19, #0x8]
    13d4: 8b1902c1     	add	x1, x22, x25
    13d8: d100d3a2     	sub	x2, x29, #0x34
    13dc: 52800083     	mov	w3, #0x4                // =4
    13e0: d63f0100     	blr	x8
    13e4: 7100041f     	cmp	w0, #0x1
    13e8: 54001561     	b.ne	0x1694 <sample+0x5e0>
    13ec: b85cc3a8     	ldur	w8, [x29, #-0x34]
    13f0: b85d43a9     	ldur	w9, [x29, #-0x2c]
    13f4: 6b09011f     	cmp	w8, w9
    13f8: 540014e1     	b.ne	0x1694 <sample+0x5e0>
    13fc: f85c03a9     	ldur	x9, [x29, #-0x40]
    1400: b85d83ac     	ldur	w12, [x29, #-0x28]
    1404: 129fffcb     	mov	w11, #-0xffff           // =-65535
    1408: d360fd2a     	lsr	x10, x9, #32
    140c: 5140412d     	sub	w13, w9, #0x10, lsl #12 // =0x10000
    1410: 290433e8     	stp	w8, w12, [sp, #0x20]
    1414: 6b0b01bf     	cmp	w13, w11
    1418: 29022be9     	stp	w9, w10, [sp, #0x10]
    141c: 540013c3     	b.lo	0x1694 <sample+0x5e0>
    1420: 51404148     	sub	w8, w10, #0x10, lsl #12 // =0x10000
    1424: 6b0b011f     	cmp	w8, w11
    1428: 52800048     	mov	w8, #0x2                // =2
    142c: 54001363     	b.lo	0x1698 <sample+0x5e4>
    1430: 1b097d48     	mul	w8, w10, w9
    1434: b940766b     	ldr	w11, [x19, #0x74]
    1438: 8b284508     	add	x8, x8, w8, uxtw #1
    143c: eb0b011f     	cmp	x8, x11
    1440: 540012a8     	b.hi	0x1694 <sample+0x5e0>
    1444: 0b090528     	add	w8, w9, w9, lsl #1
    1448: 1b0a7d09     	mul	w9, w8, w10
    144c: d344ff4a     	lsr	x10, x26, #4
    1450: f104055f     	cmp	x10, #0x101
    1454: 290327e8     	stp	w8, w9, [sp, #0x18]
    1458: 540011e3     	b.lo	0x1694 <sample+0x5e0>
    145c: a9408268     	ldp	x8, x0, [x19, #0x8]
    1460: 52842e09     	mov	w9, #0x2170             // =8560
    1464: 910043fa     	add	x26, sp, #0x10
    1468: 8b0902c1     	add	x1, x22, x9
    146c: 52800203     	mov	w3, #0x10               // =16
    1470: 91007342     	add	x2, x26, #0x1c
    1474: d63f0100     	blr	x8
    1478: 7100041f     	cmp	w0, #0x1
    147c: 540010c1     	b.ne	0x1694 <sample+0x5e0>
    1480: a9408268     	ldp	x8, x0, [x19, #0x8]
    1484: 52844809     	mov	w9, #0x2240             // =8768
    1488: 8b0902c1     	add	x1, x22, x9
    148c: 9100b342     	add	x2, x26, #0x2c
    1490: 52800083     	mov	w3, #0x4                // =4
    1494: d63f0100     	blr	x8
    1498: 7100041f     	cmp	w0, #0x1
    149c: 54000fc1     	b.ne	0x1694 <sample+0x5e0>
    14a0: a9408268     	ldp	x8, x0, [x19, #0x8]
    14a4: 910043fa     	add	x26, sp, #0x10
    14a8: 52844889     	mov	w9, #0x2244             // =8772
    14ac: 9100c342     	add	x2, x26, #0x30
    14b0: 52800083     	mov	w3, #0x4                // =4
    14b4: 8b0902c1     	add	x1, x22, x9
    14b8: d63f0100     	blr	x8
    14bc: 7100041f     	cmp	w0, #0x1
    14c0: 54000ea1     	b.ne	0x1694 <sample+0x5e0>
    14c4: a9408268     	ldp	x8, x0, [x19, #0x8]
    14c8: 52844909     	mov	w9, #0x2248             // =8776
    14cc: 8b0902c1     	add	x1, x22, x9
    14d0: 9100d342     	add	x2, x26, #0x34
    14d4: 52800083     	mov	w3, #0x4                // =4
    14d8: d63f0100     	blr	x8
    14dc: 7100041f     	cmp	w0, #0x1
    14e0: 54000da1     	b.ne	0x1694 <sample+0x5e0>
    14e4: 52844e08     	mov	w8, #0x2270             // =8816
    14e8: 8b0802c8     	add	x8, x22, x8
    14ec: d342fd08     	lsr	x8, x8, #2
    14f0: f110051f     	cmp	x8, #0x401
    14f4: 54000d03     	b.lo	0x1694 <sample+0x5e0>
    14f8: a9408268     	ldp	x8, x0, [x19, #0x8]
    14fc: 910043e9     	add	x9, sp, #0x10
    1500: 52844d8a     	mov	w10, #0x226c            // =8812
    1504: 91006122     	add	x2, x9, #0x18
    1508: 52800083     	mov	w3, #0x4                // =4
    150c: 8b0a02c1     	add	x1, x22, x10
    1510: d63f0100     	blr	x8
    1514: 7100041f     	cmp	w0, #0x1
    1518: 54000be1     	b.ne	0x1694 <sample+0x5e0>
    151c: 90000008     	adrp	x8, 0x1000 <exact_triple+0x2ec>
		000000000000151c:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst16+0x10
    1520: 3cc283e0     	ldur	q0, [sp, #0x28]
    1524: 3dc00101     	ldr	q1, [x8]
		0000000000001524:  R_AARCH64_LDST128_ABS_LO12_NC	.rodata.cst16+0x10
    1528: 6ea18c00     	cmeq	v0.4s, v0.4s, v1.4s
    152c: 6e205800     	mvn	v0.16b, v0.16b
    1530: 6eb0a800     	umaxv	s0, v0.4s
    1534: 1e260008     	fmov	w8, s0
    1538: 37000ae8     	tbnz	w8, #0x0, 0x1694 <sample+0x5e0>
    153c: b9403be8     	ldr	w8, [sp, #0x38]
    1540: 7103fd1f     	cmp	w8, #0xff
    1544: 54000a81     	b.ne	0x1694 <sample+0x5e0>
    1548: b9403fe9     	ldr	w9, [sp, #0x3c]
    154c: 34000a49     	cbz	w9, 0x1694 <sample+0x5e0>
    1550: b94043eb     	ldr	w11, [sp, #0x40]
    1554: 52800048     	mov	w8, #0x2                // =2
    1558: 34000a0b     	cbz	w11, 0x1698 <sample+0x5e4>
    155c: b94047ea     	ldr	w10, [sp, #0x44]
    1560: 529e0008     	mov	w8, #0xf000             // =61440
    1564: 72a07fa8     	movk	w8, #0x3fd, lsl #16
    1568: 6b08015f     	cmp	w10, w8
    156c: 54000948     	b.hi	0x1694 <sample+0x5e0>
    1570: 9ba97d68     	umull	x8, w11, w9
    1574: d37ff908     	lsl	x8, x8, #1
    1578: 9ba92168     	umaddl	x8, w11, w9, x8
    157c: eb0a011f     	cmp	x8, x10
    1580: 52800048     	mov	w8, #0x2                // =2
    1584: 540008a1     	b.ne	0x1698 <sample+0x5e4>
    1588: b9401fe9     	ldr	w9, [sp, #0x1c]
    158c: 6b0a013f     	cmp	w9, w10
    1590: 54000848     	b.hi	0x1698 <sample+0x5e4>
    1594: f85e83a8     	ldur	x8, [x29, #-0x18]
    1598: ab08013f     	cmn	x9, x8
    159c: 540007c2     	b.hs	0x1694 <sample+0x5e0>
    15a0: f940326a     	ldr	x10, [x19, #0x60]
    15a4: 8b090109     	add	x9, x8, x9
    15a8: eb0a013f     	cmp	x9, x10
    15ac: 540000a9     	b.ls	0x15c0 <sample+0x50c>
    15b0: f9403669     	ldr	x9, [x19, #0x68]
    15b4: 8b0a0129     	add	x9, x9, x10
    15b8: eb09011f     	cmp	x8, x9
    15bc: 540006c3     	b.lo	0x1694 <sample+0x5e0>
    15c0: 94000000     	bl	0x15c0 <sample+0x50c>
		00000000000015c0:  R_AARCH64_CALL26	iq4_f4_native_clock_02
    15c4: f90027e0     	str	x0, [sp, #0x48]
    15c8: b4000600     	cbz	x0, 0x1688 <sample+0x5d4>
    15cc: b9421e7b     	ldr	w27, [x19, #0x21c]
    15d0: 3400009b     	cbz	w27, 0x15e0 <sample+0x52c>
    15d4: f9411668     	ldr	x8, [x19, #0x228]
    15d8: eb08001f     	cmp	x0, x8
    15dc: 54000569     	b.ls	0x1688 <sample+0x5d4>
    15e0: 340013b5     	cbz	w21, 0x1854 <sample+0x7a0>
    15e4: b9422268     	ldr	w8, [x19, #0x220]
    15e8: 34000568     	cbz	w8, 0x1694 <sample+0x5e0>
    15ec: 910043e0     	add	x0, sp, #0x10
    15f0: 910a0261     	add	x1, x19, #0x280
    15f4: 94000373     	bl	0x23c0 <same_shape>
    15f8: 340004e0     	cbz	w0, 0x1694 <sample+0x5e0>
    15fc: b85d43a8     	ldur	w8, [x29, #-0x2c]
    1600: b9422669     	ldr	w9, [x19, #0x224]
    1604: 6b09011a     	subs	w26, w8, w9
    1608: 340012bb     	cbz	w27, 0x185c <sample+0x7a8>
    160c: 54001281     	b.ne	0x185c <sample+0x7a8>
    1610: f9428a68     	ldr	x8, [x19, #0x510]
    1614: 91000508     	add	x8, x8, #0x1
    1618: f9028a68     	str	x8, [x19, #0x510]
    161c: 52800068     	mov	w8, #0x3                // =3
    1620: 1400001e     	b	0x1698 <sample+0x5e4>
    1624: d5033f5f     	clrex
    1628: f9429668     	ldr	x8, [x19, #0x528]
    162c: 52800040     	mov	w0, #0x2                // =2
    1630: 91000508     	add	x8, x8, #0x1
    1634: f9029668     	str	x8, [x19, #0x528]
    1638: a94f4ff4     	ldp	x20, x19, [sp, #0xf0]
    163c: f9405bfb     	ldr	x27, [sp, #0xb0]
    1640: a94e57f6     	ldp	x22, x21, [sp, #0xe0]
    1644: a94d5ff8     	ldp	x24, x23, [sp, #0xd0]
    1648: a94c67fa     	ldp	x26, x25, [sp, #0xc0]
    164c: a94a7bfd     	ldp	x29, x30, [sp, #0xa0]
    1650: 910403ff     	add	sp, sp, #0x100
    1654: d65f03c0     	ret
    1658: 9115a269     	add	x9, x19, #0x568
    165c: 52801ba8     	mov	w8, #0xdd               // =221
    1660: 889ffd28     	stlr	w8, [x9]
    1664: 9115b269     	add	x9, x19, #0x56c
    1668: 885ffd2a     	ldaxr	w10, [x9]
    166c: 35000caa     	cbnz	w10, 0x1800 <sample+0x74c>
    1670: 880afd28     	stlxr	w10, w8, [x9]
    1674: 35ffffaa     	cbnz	w10, 0x1668 <sample+0x5b4>
    1678: 9115c268     	add	x8, x19, #0x570
    167c: 52800029     	mov	w9, #0x1                // =1
    1680: 889ffd09     	stlr	w9, [x8]
    1684: 14000060     	b	0x1804 <sample+0x750>
    1688: f942a268     	ldr	x8, [x19, #0x540]
    168c: 91000508     	add	x8, x8, #0x1
    1690: f902a268     	str	x8, [x19, #0x540]
    1694: 52800048     	mov	w8, #0x2                // =2
    1698: d10023a1     	sub	x1, x29, #0x8
    169c: d10043a2     	sub	x2, x29, #0x10
    16a0: aa1303e0     	mov	x0, x19
    16a4: 2a0803fa     	mov	w26, w8
    16a8: 9400014e     	bl	0x1be0 <live>
    16ac: 34000ac0     	cbz	w0, 0x1804 <sample+0x750>
    16b0: 297f27a8     	ldp	w8, w9, [x29, #-0x8]
    16b4: 6b09011f     	cmp	w8, w9
    16b8: 54000a61     	b.ne	0x1804 <sample+0x750>
    16bc: f9400308     	ldr	x8, [x24]
    16c0: b5000a28     	cbnz	x8, 0x1804 <sample+0x750>
    16c4: a9408268     	ldp	x8, x0, [x19, #0x8]
    16c8: 8b1702c1     	add	x1, x22, x23
    16cc: d100d3a2     	sub	x2, x29, #0x34
    16d0: 52800083     	mov	w3, #0x4                // =4
    16d4: d63f0100     	blr	x8
    16d8: 7100041f     	cmp	w0, #0x1
    16dc: 54000941     	b.ne	0x1804 <sample+0x750>
    16e0: b85cc3a8     	ldur	w8, [x29, #-0x34]
    16e4: b85d83a9     	ldur	w9, [x29, #-0x28]
    16e8: 6b09011f     	cmp	w8, w9
    16ec: 540008c1     	b.ne	0x1804 <sample+0x750>
    16f0: a9408268     	ldp	x8, x0, [x19, #0x8]
    16f4: 8b1902c1     	add	x1, x22, x25
    16f8: d100d3a2     	sub	x2, x29, #0x34
    16fc: 52800083     	mov	w3, #0x4                // =4
    1700: d63f0100     	blr	x8
    1704: 7100041f     	cmp	w0, #0x1
    1708: 540007e1     	b.ne	0x1804 <sample+0x750>
    170c: b85cc3a8     	ldur	w8, [x29, #-0x34]
    1710: b85d43a9     	ldur	w9, [x29, #-0x2c]
    1714: 6b09011f     	cmp	w8, w9
    1718: 54000761     	b.ne	0x1804 <sample+0x750>
    171c: f942a668     	ldr	x8, [x19, #0x548]
    1720: f9401e60     	ldr	x0, [x19, #0x38]
    1724: 910033e2     	add	x2, sp, #0xc
    1728: b85fc3a1     	ldur	w1, [x29, #-0x4]
    172c: 91000508     	add	x8, x8, #0x1
    1730: f902a668     	str	x8, [x19, #0x548]
    1734: 94000000     	bl	0x1734 <sample+0x680>
		0000000000001734:  R_AARCH64_CALL26	iq4_f4_native_unlock_02
    1738: 34000520     	cbz	w0, 0x17dc <sample+0x728>
    173c: b9400fe8     	ldr	w8, [sp, #0xc]
    1740: 340004e8     	cbz	w8, 0x17dc <sample+0x728>
    1744: a9408268     	ldp	x8, x0, [x19, #0x8]
    1748: 8b1702c1     	add	x1, x22, x23
    174c: d100d3a2     	sub	x2, x29, #0x34
    1750: 52800083     	mov	w3, #0x4                // =4
    1754: d63f0100     	blr	x8
    1758: 7100041f     	cmp	w0, #0x1
    175c: 54000401     	b.ne	0x17dc <sample+0x728>
    1760: b85cc3a8     	ldur	w8, [x29, #-0x34]
    1764: 7100111f     	cmp	w8, #0x4
    1768: 540003a1     	b.ne	0x17dc <sample+0x728>
    176c: 71000b5f     	cmp	w26, #0x2
    1770: 54fff5c0     	b.eq	0x1628 <sample+0x574>
    1774: 2a1a03e0     	mov	w0, w26
    1778: 35fff61a     	cbnz	w26, 0x1638 <sample+0x584>
    177c: 34000535     	cbz	w21, 0x1820 <sample+0x76c>
    1780: f9411a68     	ldr	x8, [x19, #0x230]
    1784: b9407269     	ldr	w9, [x19, #0x70]
    1788: 9ac9090a     	udiv	x10, x8, x9
    178c: 9b09a149     	msub	x9, x10, x9, x8
    1790: 5280090a     	mov	w10, #0x48              // =72
    1794: 9b0a4d29     	madd	x9, x9, x10, x19
    1798: b942c52a     	ldr	w10, [x9, #0x2c4]
    179c: 3100054a     	adds	w10, w10, #0x1
    17a0: b902c52a     	str	w10, [x9, #0x2c4]
    17a4: 54000302     	b.hs	0x1804 <sample+0x750>
    17a8: 910b0129     	add	x9, x9, #0x2c0
    17ac: 5280004a     	mov	w10, #0x2               // =2
    17b0: 889ffd2a     	stlr	w10, [x9]
    17b4: 9100050a     	add	x10, x8, #0x1
    17b8: f9428669     	ldr	x9, [x19, #0x508]
    17bc: f9410268     	ldr	x8, [x19, #0x200]
    17c0: f9011a6a     	str	x10, [x19, #0x230]
    17c4: 91000529     	add	x9, x9, #0x1
    17c8: f9028669     	str	x9, [x19, #0x508]
    17cc: b4000368     	cbz	x8, 0x1838 <sample+0x784>
    17d0: f9410a60     	ldr	x0, [x19, #0x210]
    17d4: d63f0100     	blr	x8
    17d8: 14000018     	b	0x1838 <sample+0x784>
    17dc: 9115a269     	add	x9, x19, #0x568
    17e0: 52801bc8     	mov	w8, #0xde               // =222
    17e4: 889ffd28     	stlr	w8, [x9]
    17e8: 9115b269     	add	x9, x19, #0x56c
    17ec: 885ffd2a     	ldaxr	w10, [x9]
    17f0: 3500008a     	cbnz	w10, 0x1800 <sample+0x74c>
    17f4: 880afd28     	stlxr	w10, w8, [x9]
    17f8: 35ffffaa     	cbnz	w10, 0x17ec <sample+0x738>
    17fc: 17ffff9f     	b	0x1678 <sample+0x5c4>
    1800: d5033f5f     	clrex
    1804: 91032268     	add	x8, x19, #0xc8
    1808: 91033269     	add	x9, x19, #0xcc
    180c: 5280002a     	mov	w10, #0x1               // =1
    1810: 889ffd1f     	stlr	wzr, [x8]
    1814: 528000a0     	mov	w0, #0x5                // =5
    1818: 889ffd2a     	stlr	w10, [x9]
    181c: 17ffff87     	b	0x1638 <sample+0x584>
    1820: ad4087e0     	ldp	q0, q1, [sp, #0x10]
    1824: 52800028     	mov	w8, #0x1                // =1
    1828: b9021a68     	str	w8, [x19, #0x218]
    182c: ad120660     	stp	q0, q1, [x19, #0x240]
    1830: ad418be0     	ldp	q0, q2, [sp, #0x30]
    1834: ad130a60     	stp	q0, q2, [x19, #0x260]
    1838: 2a1f03e0     	mov	w0, wzr
    183c: b4ffeff4     	cbz	x20, 0x1638 <sample+0x584>
    1840: ad4087e0     	ldp	q0, q1, [sp, #0x10]
    1844: ad000680     	stp	q0, q1, [x20]
    1848: ad418be0     	ldp	q0, q2, [sp, #0x30]
    184c: ad010a80     	stp	q0, q2, [x20, #0x20]
    1850: 17ffff7a     	b	0x1638 <sample+0x584>
    1854: 2a1f03e8     	mov	w8, wzr
    1858: 17ffff90     	b	0x1698 <sample+0x5e4>
    185c: 340000db     	cbz	w27, 0x1874 <sample+0x7c0>
    1860: 36f800ba     	tbz	w26, #0x1f, 0x1874 <sample+0x7c0>
    1864: f9428e68     	ldr	x8, [x19, #0x518]
    1868: 91000508     	add	x8, x8, #0x1
    186c: f9028e68     	str	x8, [x19, #0x518]
    1870: 17ffff89     	b	0x1694 <sample+0x5e0>
    1874: f9411a68     	ldr	x8, [x19, #0x230]
    1878: b9407269     	ldr	w9, [x19, #0x70]
    187c: 9ac9090a     	udiv	x10, x8, x9
    1880: 9b09a148     	msub	x8, x10, x9, x8
    1884: 52800909     	mov	w9, #0x48               // =72
    1888: 9b094d09     	madd	x9, x8, x9, x19
    188c: 910b013b     	add	x27, x9, #0x2c0
    1890: 88dfff69     	ldar	w9, [x27]
    1894: 340000c9     	cbz	w9, 0x18ac <sample+0x7f8>
    1898: f9429268     	ldr	x8, [x19, #0x520]
    189c: 91000508     	add	x8, x8, #0x1
    18a0: f9029268     	str	x8, [x19, #0x520]
    18a4: 52800088     	mov	w8, #0x4                // =4
    18a8: 1400000e     	b	0x18e0 <sample+0x82c>
    18ac: b9407669     	ldr	w9, [x19, #0x74]
    18b0: f940326a     	ldr	x10, [x19, #0x60]
    18b4: f85e83a1     	ldur	x1, [x29, #-0x18]
    18b8: b9401fe2     	ldr	w2, [sp, #0x1c]
    18bc: 9b092900     	madd	x0, x8, x9, x10
    18c0: 94000000     	bl	0x18c0 <sample+0x80c>
		00000000000018c0:  R_AARCH64_CALL26	memcpy
    18c4: ad4087e0     	ldp	q0, q1, [sp, #0x10]
    18c8: 2a1f03e8     	mov	w8, wzr
    18cc: 3c808360     	stur	q0, [x27, #0x8]
    18d0: ad418be0     	ldp	q0, q2, [sp, #0x30]
    18d4: 3c818361     	stur	q1, [x27, #0x18]
    18d8: 3c828360     	stur	q0, [x27, #0x28]
    18dc: 3c838362     	stur	q2, [x27, #0x38]
    18e0: b9421e69     	ldr	w9, [x19, #0x21c]
    18e4: 340000e9     	cbz	w9, 0x1900 <sample+0x84c>
    18e8: 71000b5f     	cmp	w26, #0x2
    18ec: 540000a3     	b.lo	0x1900 <sample+0x84c>
    18f0: f942aa69     	ldr	x9, [x19, #0x550]
    18f4: 5100074a     	sub	w10, w26, #0x1
    18f8: 8b0a0129     	add	x9, x9, x10
    18fc: f902aa69     	str	x9, [x19, #0x550]
    1900: b85d43a9     	ldur	w9, [x29, #-0x2c]
    1904: f94027ea     	ldr	x10, [sp, #0x48]
    1908: b9022669     	str	w9, [x19, #0x224]
    190c: 52800029     	mov	w9, #0x1                // =1
    1910: f901166a     	str	x10, [x19, #0x228]
    1914: b9021e69     	str	w9, [x19, #0x21c]
    1918: 17ffff60     	b	0x1698 <sample+0x5e4>

000000000000191c <iq4_f4_source_bind_page_guard_on_ui_02>:
    191c: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
    1920: f9000bf5     	str	x21, [sp, #0x10]
    1924: a9024ff4     	stp	x20, x19, [sp, #0x20]
    1928: 910003fd     	mov	x29, sp
    192c: aa0003f4     	mov	x20, x0
    1930: 52800040     	mov	w0, #0x2                // =2
    1934: b40001d4     	cbz	x20, 0x196c <iq4_f4_source_bind_page_guard_on_ui_02+0x50>
    1938: b40001a1     	cbz	x1, 0x196c <iq4_f4_source_bind_page_guard_on_ui_02+0x50>
    193c: aa1403e0     	mov	x0, x20
    1940: aa0203f3     	mov	x19, x2
    1944: aa0103f5     	mov	x21, x1
    1948: 97fffc54     	bl	0xa98 <on_ui>
    194c: 340000e0     	cbz	w0, 0x1968 <iq4_f4_source_bind_page_guard_on_ui_02+0x4c>
    1950: 91032288     	add	x8, x20, #0xc8
    1954: 88dffd08     	ldar	w8, [x8]
    1958: 35000088     	cbnz	w8, 0x1968 <iq4_f4_source_bind_page_guard_on_ui_02+0x4c>
    195c: 91033288     	add	x8, x20, #0xcc
    1960: 88dffd08     	ldar	w8, [x8]
    1964: 340000c8     	cbz	w8, 0x197c <iq4_f4_source_bind_page_guard_on_ui_02+0x60>
    1968: 52800040     	mov	w0, #0x2                // =2
    196c: a9424ff4     	ldp	x20, x19, [sp, #0x20]
    1970: f9400bf5     	ldr	x21, [sp, #0x10]
    1974: a8c37bfd     	ldp	x29, x30, [sp], #0x30
    1978: d65f03c0     	ret
    197c: 2a1f03e0     	mov	w0, wzr
    1980: a91f4e95     	stp	x21, x19, [x20, #0x1f0]
    1984: 17fffffa     	b	0x196c <iq4_f4_source_bind_page_guard_on_ui_02+0x50>

0000000000001988 <iq4_f4_source_is_ui_02>:
    1988: b4000040     	cbz	x0, 0x1990 <iq4_f4_source_is_ui_02+0x8>
    198c: 17fffc43     	b	0xa98 <on_ui>
    1990: d65f03c0     	ret

0000000000001994 <iq4_f4_source_bind_handoff_on_ui_02>:
    1994: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
    1998: a90157f6     	stp	x22, x21, [sp, #0x10]
    199c: a9024ff4     	stp	x20, x19, [sp, #0x20]
    19a0: 910003fd     	mov	x29, sp
    19a4: aa0003f3     	mov	x19, x0
    19a8: 52800040     	mov	w0, #0x2                // =2
    19ac: b4000293     	cbz	x19, 0x19fc <iq4_f4_source_bind_handoff_on_ui_02+0x68>
    19b0: b4000261     	cbz	x1, 0x19fc <iq4_f4_source_bind_handoff_on_ui_02+0x68>
    19b4: b4000242     	cbz	x2, 0x19fc <iq4_f4_source_bind_handoff_on_ui_02+0x68>
    19b8: aa1303e0     	mov	x0, x19
    19bc: aa0103f6     	mov	x22, x1
    19c0: aa0203f5     	mov	x21, x2
    19c4: aa0303f4     	mov	x20, x3
    19c8: 97fffc34     	bl	0xa98 <on_ui>
    19cc: 34000160     	cbz	w0, 0x19f8 <iq4_f4_source_bind_handoff_on_ui_02+0x64>
    19d0: 91032268     	add	x8, x19, #0xc8
    19d4: 88dffd08     	ldar	w8, [x8]
    19d8: 35000108     	cbnz	w8, 0x19f8 <iq4_f4_source_bind_handoff_on_ui_02+0x64>
    19dc: 91033268     	add	x8, x19, #0xcc
    19e0: 88dffd08     	ldar	w8, [x8]
    19e4: 350000a8     	cbnz	w8, 0x19f8 <iq4_f4_source_bind_handoff_on_ui_02+0x64>
    19e8: f9410268     	ldr	x8, [x19, #0x200]
    19ec: b5000068     	cbnz	x8, 0x19f8 <iq4_f4_source_bind_handoff_on_ui_02+0x64>
    19f0: f9410668     	ldr	x8, [x19, #0x208]
    19f4: b40000c8     	cbz	x8, 0x1a0c <iq4_f4_source_bind_handoff_on_ui_02+0x78>
    19f8: 52800040     	mov	w0, #0x2                // =2
    19fc: a9424ff4     	ldp	x20, x19, [sp, #0x20]
    1a00: a94157f6     	ldp	x22, x21, [sp, #0x10]
    1a04: a8c37bfd     	ldp	x29, x30, [sp], #0x30
    1a08: d65f03c0     	ret
    1a0c: 2a1f03e0     	mov	w0, wzr
    1a10: f9010276     	str	x22, [x19, #0x200]
    1a14: f9010675     	str	x21, [x19, #0x208]
    1a18: f9010a74     	str	x20, [x19, #0x210]
    1a1c: 17fffff8     	b	0x19fc <iq4_f4_source_bind_handoff_on_ui_02+0x68>

0000000000001a20 <iq4_f4_source_post_control_02>:
    1a20: b4000300     	cbz	x0, 0x1a80 <iq4_f4_source_post_control_02+0x60>
    1a24: d28a4649     	mov	x9, #0x5232             // =21042
    1a28: f9400008     	ldr	x8, [x0]
    1a2c: f2a68a69     	movk	x9, #0x3453, lsl #16
    1a30: f2c688c9     	movk	x9, #0x3446, lsl #32
    1a34: f2e92a29     	movk	x9, #0x4951, lsl #48
    1a38: eb09011f     	cmp	x8, x9
    1a3c: 54000221     	b.ne	0x1a80 <iq4_f4_source_post_control_02+0x60>
    1a40: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
    1a44: f9000bf3     	str	x19, [sp, #0x10]
    1a48: 910003fd     	mov	x29, sp
    1a4c: 91033008     	add	x8, x0, #0xcc
    1a50: 88dffd08     	ldar	w8, [x8]
    1a54: 35000248     	cbnz	w8, 0x1a9c <iq4_f4_source_post_control_02+0x7c>
    1a58: b941e408     	ldr	w8, [x0, #0x1e4]
    1a5c: 34000168     	cbz	w8, 0x1a88 <iq4_f4_source_post_control_02+0x68>
    1a60: aa0003f3     	mov	x19, x0
    1a64: 91038000     	add	x0, x0, #0xe0
    1a68: 94000000     	bl	0x1a68 <iq4_f4_source_post_control_02+0x48>
		0000000000001a68:  R_AARCH64_CALL26	iq4_f4_native_event_notify_02
    1a6c: 2a0003e8     	mov	w8, w0
    1a70: aa1303e0     	mov	x0, x19
    1a74: 340000a8     	cbz	w8, 0x1a88 <iq4_f4_source_post_control_02+0x68>
    1a78: 528000c0     	mov	w0, #0x6                // =6
    1a7c: 14000009     	b	0x1aa0 <iq4_f4_source_post_control_02+0x80>
    1a80: 52800020     	mov	w0, #0x1                // =1
    1a84: d65f03c0     	ret
    1a88: 91032008     	add	x8, x0, #0xc8
    1a8c: 91033009     	add	x9, x0, #0xcc
    1a90: 5280002a     	mov	w10, #0x1               // =1
    1a94: 889ffd1f     	stlr	wzr, [x8]
    1a98: 889ffd2a     	stlr	w10, [x9]
    1a9c: 528000a0     	mov	w0, #0x5                // =5
    1aa0: f9400bf3     	ldr	x19, [sp, #0x10]
    1aa4: a8c27bfd     	ldp	x29, x30, [sp], #0x20
    1aa8: d65f03c0     	ret

0000000000001aac <iq4_f4_source_start_on_ui_02>:
    1aac: d100c3ff     	sub	sp, sp, #0x30
    1ab0: a9017bfd     	stp	x29, x30, [sp, #0x10]
    1ab4: a9024ff4     	stp	x20, x19, [sp, #0x20]
    1ab8: 910043fd     	add	x29, sp, #0x10
    1abc: aa0003f3     	mov	x19, x0
    1ac0: 52800040     	mov	w0, #0x2                // =2
    1ac4: b40001b3     	cbz	x19, 0x1af8 <iq4_f4_source_start_on_ui_02+0x4c>
    1ac8: b4000181     	cbz	x1, 0x1af8 <iq4_f4_source_start_on_ui_02+0x4c>
    1acc: aa1303e0     	mov	x0, x19
    1ad0: aa0103f4     	mov	x20, x1
    1ad4: 97fffbf1     	bl	0xa98 <on_ui>
    1ad8: 340000e0     	cbz	w0, 0x1af4 <iq4_f4_source_start_on_ui_02+0x48>
    1adc: 91031268     	add	x8, x19, #0xc4
    1ae0: 88dffd08     	ldar	w8, [x8]
    1ae4: 34000088     	cbz	w8, 0x1af4 <iq4_f4_source_start_on_ui_02+0x48>
    1ae8: 91032268     	add	x8, x19, #0xc8
    1aec: 88dffd08     	ldar	w8, [x8]
    1af0: 340000c8     	cbz	w8, 0x1b08 <iq4_f4_source_start_on_ui_02+0x5c>
    1af4: 52800040     	mov	w0, #0x2                // =2
    1af8: a9424ff4     	ldp	x20, x19, [sp, #0x20]
    1afc: a9417bfd     	ldp	x29, x30, [sp, #0x10]
    1b00: 9100c3ff     	add	sp, sp, #0x30
    1b04: d65f03c0     	ret
    1b08: b9421a68     	ldr	w8, [x19, #0x218]
    1b0c: 34ffff48     	cbz	w8, 0x1af4 <iq4_f4_source_start_on_ui_02+0x48>
    1b10: f940fa68     	ldr	x8, [x19, #0x1f0]
    1b14: b4ffff08     	cbz	x8, 0x1af4 <iq4_f4_source_start_on_ui_02+0x48>
    1b18: f940fe60     	ldr	x0, [x19, #0x1f8]
    1b1c: d63f0100     	blr	x8
    1b20: 7100041f     	cmp	w0, #0x1
    1b24: 54fffe81     	b.ne	0x1af4 <iq4_f4_source_start_on_ui_02+0x48>
    1b28: 91090261     	add	x1, x19, #0x240
    1b2c: aa1403e0     	mov	x0, x20
    1b30: 52800802     	mov	w2, #0x40               // =64
    1b34: 94000000     	bl	0x1b34 <iq4_f4_source_start_on_ui_02+0x88>
		0000000000001b34:  R_AARCH64_CALL26	memcmp
    1b38: 35fffde0     	cbnz	w0, 0x1af4 <iq4_f4_source_start_on_ui_02+0x48>
    1b3c: d10013a1     	sub	x1, x29, #0x4
    1b40: 910003e2     	mov	x2, sp
    1b44: aa1303e0     	mov	x0, x19
    1b48: 94000026     	bl	0x1be0 <live>
    1b4c: 2a0003e8     	mov	w8, w0
    1b50: 52800040     	mov	w0, #0x2                // =2
    1b54: 34fffd28     	cbz	w8, 0x1af8 <iq4_f4_source_start_on_ui_02+0x4c>
    1b58: f94003e8     	ldr	x8, [sp]
    1b5c: b5fffce8     	cbnz	x8, 0x1af8 <iq4_f4_source_start_on_ui_02+0x4c>
    1b60: 91033268     	add	x8, x19, #0xcc
    1b64: 88dffd08     	ldar	w8, [x8]
    1b68: 34000068     	cbz	w8, 0x1b74 <iq4_f4_source_start_on_ui_02+0xc8>
    1b6c: 528000a0     	mov	w0, #0x5                // =5
    1b70: 17ffffe2     	b	0x1af8 <iq4_f4_source_start_on_ui_02+0x4c>
    1b74: b9407268     	ldr	w8, [x19, #0x70]
    1b78: 34000148     	cbz	w8, 0x1ba0 <iq4_f4_source_start_on_ui_02+0xf4>
    1b7c: aa1f03e8     	mov	x8, xzr
    1b80: 910b0269     	add	x9, x19, #0x2c0
    1b84: 88dffd2a     	ldar	w10, [x9]
    1b88: 3500028a     	cbnz	w10, 0x1bd8 <iq4_f4_source_start_on_ui_02+0x12c>
    1b8c: b940726a     	ldr	w10, [x19, #0x70]
    1b90: 91000508     	add	x8, x8, #0x1
    1b94: 91012129     	add	x9, x9, #0x48
    1b98: eb0a011f     	cmp	x8, x10
    1b9c: 54ffff43     	b.lo	0x1b84 <iq4_f4_source_start_on_ui_02+0xd8>
    1ba0: ad520660     	ldp	q0, q1, [x19, #0x240]
    1ba4: 91087268     	add	x8, x19, #0x21c
    1ba8: d2c00029     	mov	x9, #0x100000000        // =4294967296
    1bac: 2a1f03e0     	mov	w0, wzr
    1bb0: f9000109     	str	x9, [x8]
    1bb4: 9107a268     	add	x8, x19, #0x1e8
    1bb8: 52800029     	mov	w9, #0x1                // =1
    1bbc: ad140660     	stp	q0, q1, [x19, #0x280]
    1bc0: ad530262     	ldp	q2, q0, [x19, #0x260]
    1bc4: ad150262     	stp	q2, q0, [x19, #0x2a0]
    1bc8: 889ffd1f     	stlr	wzr, [x8]
    1bcc: 91032268     	add	x8, x19, #0xc8
    1bd0: 889ffd09     	stlr	w9, [x8]
    1bd4: 17ffffc9     	b	0x1af8 <iq4_f4_source_start_on_ui_02+0x4c>
    1bd8: 528000c0     	mov	w0, #0x6                // =6
    1bdc: 17ffffc7     	b	0x1af8 <iq4_f4_source_start_on_ui_02+0x4c>

0000000000001be0 <live>:
    1be0: d10103ff     	sub	sp, sp, #0x40
    1be4: a9017bfd     	stp	x29, x30, [sp, #0x10]
    1be8: f90013f5     	str	x21, [sp, #0x20]
    1bec: a9034ff4     	stp	x20, x19, [sp, #0x30]
    1bf0: 910043fd     	add	x29, sp, #0x10
    1bf4: aa0203f4     	mov	x20, x2
    1bf8: aa0103f5     	mov	x21, x1
    1bfc: aa0003f3     	mov	x19, x0
    1c00: 97fffba6     	bl	0xa98 <on_ui>
    1c04: 340012e0     	cbz	w0, 0x1e60 <live+0x280>
    1c08: f9401a68     	ldr	x8, [x19, #0x30]
    1c0c: 91041109     	add	x9, x8, #0x104
    1c10: d342fd29     	lsr	x9, x9, #2
    1c14: f110053f     	cmp	x9, #0x401
    1c18: 54000163     	b.lo	0x1c44 <live+0x64>
    1c1c: a9408269     	ldp	x9, x0, [x19, #0x8]
    1c20: 91040101     	add	x1, x8, #0x100
    1c24: aa1503e2     	mov	x2, x21
    1c28: 52800083     	mov	w3, #0x4                // =4
    1c2c: d63f0120     	blr	x9
    1c30: 7100041f     	cmp	w0, #0x1
    1c34: 54000081     	b.ne	0x1c44 <live+0x64>
    1c38: b94002a8     	ldr	w8, [x21]
    1c3c: 7100151f     	cmp	w8, #0x5
    1c40: 540001c3     	b.lo	0x1c78 <live+0x98>
    1c44: 9115a269     	add	x9, x19, #0x568
    1c48: 52801b88     	mov	w8, #0xdc               // =220
    1c4c: 889ffd28     	stlr	w8, [x9]
    1c50: 9115b269     	add	x9, x19, #0x56c
    1c54: 885ffd2a     	ldaxr	w10, [x9]
    1c58: 3500100a     	cbnz	w10, 0x1e58 <live+0x278>
    1c5c: 880afd28     	stlxr	w10, w8, [x9]
    1c60: 35ffffaa     	cbnz	w10, 0x1c54 <live+0x74>
    1c64: 9115c268     	add	x8, x19, #0x570
    1c68: 52800149     	mov	w9, #0xa                // =10
    1c6c: 2a1f03e0     	mov	w0, wzr
    1c70: 889ffd09     	stlr	w9, [x8]
    1c74: 1400007b     	b	0x1e60 <live+0x280>
    1c78: f9401a68     	ldr	x8, [x19, #0x30]
    1c7c: 91041509     	add	x9, x8, #0x105
    1c80: f140053f     	cmp	x9, #0x1, lsl #12       // =0x1000
    1c84: 54000188     	b.hi	0x1cb4 <live+0xd4>
    1c88: 9115a269     	add	x9, x19, #0x568
    1c8c: 52801b88     	mov	w8, #0xdc               // =220
    1c90: 889ffd28     	stlr	w8, [x9]
    1c94: 9115b269     	add	x9, x19, #0x56c
    1c98: 885ffd2a     	ldaxr	w10, [x9]
    1c9c: 35000dea     	cbnz	w10, 0x1e58 <live+0x278>
    1ca0: 880afd28     	stlxr	w10, w8, [x9]
    1ca4: 35ffffaa     	cbnz	w10, 0x1c98 <live+0xb8>
    1ca8: 9115c268     	add	x8, x19, #0x570
    1cac: 52800169     	mov	w9, #0xb                // =11
    1cb0: 17ffffef     	b	0x1c6c <live+0x8c>
    1cb4: a9408269     	ldp	x9, x0, [x19, #0x8]
    1cb8: 91041101     	add	x1, x8, #0x104
    1cbc: d10013a2     	sub	x2, x29, #0x4
    1cc0: 52800023     	mov	w3, #0x1                // =1
    1cc4: d63f0120     	blr	x9
    1cc8: 7100041f     	cmp	w0, #0x1
    1ccc: 54fffde1     	b.ne	0x1c88 <live+0xa8>
    1cd0: 385fc3a8     	ldurb	w8, [x29, #-0x4]
    1cd4: 7100051f     	cmp	w8, #0x1
    1cd8: 54fffd81     	b.ne	0x1c88 <live+0xa8>
    1cdc: f9401e68     	ldr	x8, [x19, #0x38]
    1ce0: 9102d109     	add	x9, x8, #0xb4
    1ce4: d342fd29     	lsr	x9, x9, #2
    1ce8: f110053f     	cmp	x9, #0x401
    1cec: 540003c3     	b.lo	0x1d64 <live+0x184>
    1cf0: a9408269     	ldp	x9, x0, [x19, #0x8]
    1cf4: 9102c101     	add	x1, x8, #0xb0
    1cf8: 910013e2     	add	x2, sp, #0x4
    1cfc: 52800083     	mov	w3, #0x4                // =4
    1d00: d63f0120     	blr	x9
    1d04: 7100041f     	cmp	w0, #0x1
    1d08: 540002e1     	b.ne	0x1d64 <live+0x184>
    1d0c: b94007e8     	ldr	w8, [sp, #0x4]
    1d10: b94002a9     	ldr	w9, [x21]
    1d14: 6b09011f     	cmp	w8, w9
    1d18: 54000261     	b.ne	0x1d64 <live+0x184>
    1d1c: f9401e69     	ldr	x9, [x19, #0x38]
    1d20: 531d7108     	lsl	w8, w8, #3
    1d24: 8b090108     	add	x8, x8, x9
    1d28: 91030109     	add	x9, x8, #0xc0
    1d2c: d343fd29     	lsr	x9, x9, #3
    1d30: f108053f     	cmp	x9, #0x201
    1d34: 540002e2     	b.hs	0x1d90 <live+0x1b0>
    1d38: 9115a269     	add	x9, x19, #0x568
    1d3c: 52801b88     	mov	w8, #0xdc               // =220
    1d40: 889ffd28     	stlr	w8, [x9]
    1d44: 9115b269     	add	x9, x19, #0x56c
    1d48: 885ffd2a     	ldaxr	w10, [x9]
    1d4c: 3500086a     	cbnz	w10, 0x1e58 <live+0x278>
    1d50: 880afd28     	stlxr	w10, w8, [x9]
    1d54: 35ffffaa     	cbnz	w10, 0x1d48 <live+0x168>
    1d58: 9115c268     	add	x8, x19, #0x570
    1d5c: 528001a9     	mov	w9, #0xd                // =13
    1d60: 17ffffc3     	b	0x1c6c <live+0x8c>
    1d64: 9115a269     	add	x9, x19, #0x568
    1d68: 52801b88     	mov	w8, #0xdc               // =220
    1d6c: 889ffd28     	stlr	w8, [x9]
    1d70: 9115b269     	add	x9, x19, #0x56c
    1d74: 885ffd2a     	ldaxr	w10, [x9]
    1d78: 3500070a     	cbnz	w10, 0x1e58 <live+0x278>
    1d7c: 880afd28     	stlxr	w10, w8, [x9]
    1d80: 35ffffaa     	cbnz	w10, 0x1d74 <live+0x194>
    1d84: 9115c268     	add	x8, x19, #0x570
    1d88: 52800189     	mov	w9, #0xc                // =12
    1d8c: 17ffffb8     	b	0x1c6c <live+0x8c>
    1d90: a9408269     	ldp	x9, x0, [x19, #0x8]
    1d94: 9102e101     	add	x1, x8, #0xb8
    1d98: 910063a2     	add	x2, x29, #0x18
    1d9c: 52800103     	mov	w3, #0x8                // =8
    1da0: d63f0120     	blr	x9
    1da4: 7100041f     	cmp	w0, #0x1
    1da8: 54fffc81     	b.ne	0x1d38 <live+0x158>
    1dac: f9400fa8     	ldr	x8, [x29, #0x18]
    1db0: d16e6908     	sub	x8, x8, #0xb9a, lsl #12 // =0xb9a000
    1db4: f113811f     	cmp	x8, #0x4e0
    1db8: 54fffc01     	b.ne	0x1d38 <live+0x158>
    1dbc: f9401a68     	ldr	x8, [x19, #0x30]
    1dc0: 91064109     	add	x9, x8, #0x190
    1dc4: d343fd29     	lsr	x9, x9, #3
    1dc8: f108053f     	cmp	x9, #0x201
    1dcc: 54000303     	b.lo	0x1e2c <live+0x24c>
    1dd0: a9408269     	ldp	x9, x0, [x19, #0x8]
    1dd4: 91062101     	add	x1, x8, #0x188
    1dd8: aa1403e2     	mov	x2, x20
    1ddc: 52800103     	mov	w3, #0x8                // =8
    1de0: d63f0120     	blr	x9
    1de4: 7100041f     	cmp	w0, #0x1
    1de8: 54000221     	b.ne	0x1e2c <live+0x24c>
    1dec: f9401a68     	ldr	x8, [x19, #0x30]
    1df0: 91070509     	add	x9, x8, #0x1c1
    1df4: f140053f     	cmp	x9, #0x1, lsl #12       // =0x1000
    1df8: 540001a9     	b.ls	0x1e2c <live+0x24c>
    1dfc: a9408269     	ldp	x9, x0, [x19, #0x8]
    1e00: 91070101     	add	x1, x8, #0x1c0
    1e04: 910023e2     	add	x2, sp, #0x8
    1e08: 52800023     	mov	w3, #0x1                // =1
    1e0c: d63f0120     	blr	x9
    1e10: 7100041f     	cmp	w0, #0x1
    1e14: 540000c1     	b.ne	0x1e2c <live+0x24c>
    1e18: 394023e8     	ldrb	w8, [sp, #0x8]
    1e1c: 340002c8     	cbz	w8, 0x1e74 <live+0x294>
    1e20: 52800020     	mov	w0, #0x1                // =1
    1e24: f9000280     	str	x0, [x20]
    1e28: 1400000e     	b	0x1e60 <live+0x280>
    1e2c: 9115a269     	add	x9, x19, #0x568
    1e30: 52801b88     	mov	w8, #0xdc               // =220
    1e34: 889ffd28     	stlr	w8, [x9]
    1e38: 9115b269     	add	x9, x19, #0x56c
    1e3c: 885ffd2a     	ldaxr	w10, [x9]
    1e40: 350000ca     	cbnz	w10, 0x1e58 <live+0x278>
    1e44: 880afd28     	stlxr	w10, w8, [x9]
    1e48: 35ffffaa     	cbnz	w10, 0x1e3c <live+0x25c>
    1e4c: 9115c268     	add	x8, x19, #0x570
    1e50: 528001c9     	mov	w9, #0xe                // =14
    1e54: 17ffff86     	b	0x1c6c <live+0x8c>
    1e58: 2a1f03e0     	mov	w0, wzr
    1e5c: d5033f5f     	clrex
    1e60: a9434ff4     	ldp	x20, x19, [sp, #0x30]
    1e64: f94013f5     	ldr	x21, [sp, #0x20]
    1e68: a9417bfd     	ldp	x29, x30, [sp, #0x10]
    1e6c: 910103ff     	add	sp, sp, #0x40
    1e70: d65f03c0     	ret
    1e74: 52800020     	mov	w0, #0x1                // =1
    1e78: 17fffffa     	b	0x1e60 <live+0x280>

0000000000001e7c <iq4_f4_source_request_stop_02>:
    1e7c: b4000240     	cbz	x0, 0x1ec4 <iq4_f4_source_request_stop_02+0x48>
    1e80: d28a4649     	mov	x9, #0x5232             // =21042
    1e84: f9400008     	ldr	x8, [x0]
    1e88: f2a68a69     	movk	x9, #0x3453, lsl #16
    1e8c: f2c688c9     	movk	x9, #0x3446, lsl #32
    1e90: f2e92a29     	movk	x9, #0x4951, lsl #48
    1e94: eb09011f     	cmp	x8, x9
    1e98: 54000161     	b.ne	0x1ec4 <iq4_f4_source_request_stop_02+0x48>
    1e9c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
    1ea0: f9000bf3     	str	x19, [sp, #0x10]
    1ea4: 910003fd     	mov	x29, sp
    1ea8: 91032008     	add	x8, x0, #0xc8
    1eac: 889ffd1f     	stlr	wzr, [x8]
    1eb0: 91033008     	add	x8, x0, #0xcc
    1eb4: 88dffd08     	ldar	w8, [x8]
    1eb8: 340000a8     	cbz	w8, 0x1ecc <iq4_f4_source_request_stop_02+0x50>
    1ebc: 528000a0     	mov	w0, #0x5                // =5
    1ec0: 1400001a     	b	0x1f28 <iq4_f4_source_request_stop_02+0xac>
    1ec4: 52800020     	mov	w0, #0x1                // =1
    1ec8: d65f03c0     	ret
    1ecc: 9107a008     	add	x8, x0, #0x1e8
    1ed0: 52800029     	mov	w9, #0x1                // =1
    1ed4: 885ffd0a     	ldaxr	w10, [x8]
    1ed8: 3500024a     	cbnz	w10, 0x1f20 <iq4_f4_source_request_stop_02+0xa4>
    1edc: 880afd09     	stlxr	w10, w9, [x8]
    1ee0: 35ffffaa     	cbnz	w10, 0x1ed4 <iq4_f4_source_request_stop_02+0x58>
    1ee4: b941e408     	ldr	w8, [x0, #0x1e4]
    1ee8: 340000e8     	cbz	w8, 0x1f04 <iq4_f4_source_request_stop_02+0x88>
    1eec: aa0003f3     	mov	x19, x0
    1ef0: 91038000     	add	x0, x0, #0xe0
    1ef4: 94000000     	bl	0x1ef4 <iq4_f4_source_request_stop_02+0x78>
		0000000000001ef4:  R_AARCH64_CALL26	iq4_f4_native_event_notify_02
    1ef8: 2a0003e8     	mov	w8, w0
    1efc: aa1303e0     	mov	x0, x19
    1f00: 35000128     	cbnz	w8, 0x1f24 <iq4_f4_source_request_stop_02+0xa8>
    1f04: 91032008     	add	x8, x0, #0xc8
    1f08: 91033009     	add	x9, x0, #0xcc
    1f0c: 5280002a     	mov	w10, #0x1               // =1
    1f10: 889ffd1f     	stlr	wzr, [x8]
    1f14: 528000a0     	mov	w0, #0x5                // =5
    1f18: 889ffd2a     	stlr	w10, [x9]
    1f1c: 14000003     	b	0x1f28 <iq4_f4_source_request_stop_02+0xac>
    1f20: d5033f5f     	clrex
    1f24: 528000c0     	mov	w0, #0x6                // =6
    1f28: f9400bf3     	ldr	x19, [sp, #0x10]
    1f2c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
    1f30: d65f03c0     	ret

0000000000001f34 <iq4_f4_source_stop_on_ui_02>:
    1f34: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
    1f38: f9000bf3     	str	x19, [sp, #0x10]
    1f3c: 910003fd     	mov	x29, sp
    1f40: b40001e0     	cbz	x0, 0x1f7c <iq4_f4_source_stop_on_ui_02+0x48>
    1f44: d28a4649     	mov	x9, #0x5232             // =21042
    1f48: f9400008     	ldr	x8, [x0]
    1f4c: f2a68a69     	movk	x9, #0x3453, lsl #16
    1f50: f2c688c9     	movk	x9, #0x3446, lsl #32
    1f54: f2e92a29     	movk	x9, #0x4951, lsl #48
    1f58: eb09011f     	cmp	x8, x9
    1f5c: 54000101     	b.ne	0x1f7c <iq4_f4_source_stop_on_ui_02+0x48>
    1f60: 91032008     	add	x8, x0, #0xc8
    1f64: 889ffd1f     	stlr	wzr, [x8]
    1f68: 91033008     	add	x8, x0, #0xcc
    1f6c: 88dffd08     	ldar	w8, [x8]
    1f70: 340000e8     	cbz	w8, 0x1f8c <iq4_f4_source_stop_on_ui_02+0x58>
    1f74: 528000a0     	mov	w0, #0x5                // =5
    1f78: 14000002     	b	0x1f80 <iq4_f4_source_stop_on_ui_02+0x4c>
    1f7c: 52800020     	mov	w0, #0x1                // =1
    1f80: f9400bf3     	ldr	x19, [sp, #0x10]
    1f84: a8c27bfd     	ldp	x29, x30, [sp], #0x20
    1f88: d65f03c0     	ret
    1f8c: aa0003f3     	mov	x19, x0
    1f90: 97fffac2     	bl	0xa98 <on_ui>
    1f94: 2a0003e8     	mov	w8, w0
    1f98: aa1303e0     	mov	x0, x19
    1f9c: 34000088     	cbz	w8, 0x1fac <iq4_f4_source_stop_on_ui_02+0x78>
    1fa0: 91034008     	add	x8, x0, #0xd0
    1fa4: 88dffd08     	ldar	w8, [x8]
    1fa8: 34000108     	cbz	w8, 0x1fc8 <iq4_f4_source_stop_on_ui_02+0x94>
    1fac: 91032008     	add	x8, x0, #0xc8
    1fb0: 91033009     	add	x9, x0, #0xcc
    1fb4: 5280002a     	mov	w10, #0x1               // =1
    1fb8: 889ffd1f     	stlr	wzr, [x8]
    1fbc: 528000a0     	mov	w0, #0x5                // =5
    1fc0: 889ffd2a     	stlr	w10, [x9]
    1fc4: 17ffffef     	b	0x1f80 <iq4_f4_source_stop_on_ui_02+0x4c>
    1fc8: 91031008     	add	x8, x0, #0xc4
    1fcc: 88dffd08     	ldar	w8, [x8]
    1fd0: 340002a8     	cbz	w8, 0x2024 <iq4_f4_source_stop_on_ui_02+0xf0>
    1fd4: f9402401     	ldr	x1, [x0, #0x48]
    1fd8: 9101e002     	add	x2, x0, #0x78
    1fdc: 97fffb4e     	bl	0xd14 <exact_triple>
    1fe0: 7100041f     	cmp	w0, #0x1
    1fe4: 54000141     	b.ne	0x200c <iq4_f4_source_stop_on_ui_02+0xd8>
    1fe8: f9402661     	ldr	x1, [x19, #0x48]
    1fec: 9101e260     	add	x0, x19, #0x78
    1ff0: 94000000     	bl	0x1ff0 <iq4_f4_source_stop_on_ui_02+0xbc>
		0000000000001ff0:  R_AARCH64_CALL26	iq4_f4_native_unsubscribe_02
    1ff4: 340000c0     	cbz	w0, 0x200c <iq4_f4_source_stop_on_ui_02+0xd8>
    1ff8: f9402661     	ldr	x1, [x19, #0x48]
    1ffc: aa1303e0     	mov	x0, x19
    2000: 9101e262     	add	x2, x19, #0x78
    2004: 97fffb44     	bl	0xd14 <exact_triple>
    2008: 34000080     	cbz	w0, 0x2018 <iq4_f4_source_stop_on_ui_02+0xe4>
    200c: 91032268     	add	x8, x19, #0xc8
    2010: 91033269     	add	x9, x19, #0xcc
    2014: 17ffffe8     	b	0x1fb4 <iq4_f4_source_stop_on_ui_02+0x80>
    2018: aa1303e0     	mov	x0, x19
    201c: 91031268     	add	x8, x19, #0xc4
    2020: 889ffd1f     	stlr	wzr, [x8]
    2024: f9400bf3     	ldr	x19, [sp, #0x10]
    2028: a8c27bfd     	ldp	x29, x30, [sp], #0x20
    202c: 14000000     	b	0x202c <iq4_f4_source_stop_on_ui_02+0xf8>
		000000000000202c:  R_AARCH64_JUMP26	iq4_f4_source_fence_02

0000000000002030 <iq4_f4_source_fence_02>:
    2030: b40001a0     	cbz	x0, 0x2064 <iq4_f4_source_fence_02+0x34>
    2034: d28a4649     	mov	x9, #0x5232             // =21042
    2038: f9400008     	ldr	x8, [x0]
    203c: f2a68a69     	movk	x9, #0x3453, lsl #16
    2040: f2c688c9     	movk	x9, #0x3446, lsl #32
    2044: f2e92a29     	movk	x9, #0x4951, lsl #48
    2048: eb09011f     	cmp	x8, x9
    204c: 540000c1     	b.ne	0x2064 <iq4_f4_source_fence_02+0x34>
    2050: 91033008     	add	x8, x0, #0xcc
    2054: 88dffd08     	ldar	w8, [x8]
    2058: 340000c8     	cbz	w8, 0x2070 <iq4_f4_source_fence_02+0x40>
    205c: 528000a0     	mov	w0, #0x5                // =5
    2060: d65f03c0     	ret
    2064: 52800028     	mov	w8, #0x1                // =1
    2068: 2a0803e0     	mov	w0, w8
    206c: d65f03c0     	ret
    2070: 91032008     	add	x8, x0, #0xc8
    2074: 88dffd08     	ldar	w8, [x8]
    2078: 350000e8     	cbnz	w8, 0x2094 <iq4_f4_source_fence_02+0x64>
    207c: 91031008     	add	x8, x0, #0xc4
    2080: 88dffd08     	ldar	w8, [x8]
    2084: 35000088     	cbnz	w8, 0x2094 <iq4_f4_source_fence_02+0x64>
    2088: 91034008     	add	x8, x0, #0xd0
    208c: 88dffd08     	ldar	w8, [x8]
    2090: 34000068     	cbz	w8, 0x209c <iq4_f4_source_fence_02+0x6c>
    2094: 528000c0     	mov	w0, #0x6                // =6
    2098: d65f03c0     	ret
    209c: b9407008     	ldr	w8, [x0, #0x70]
    20a0: 34fffe48     	cbz	w8, 0x2068 <iq4_f4_source_fence_02+0x38>
    20a4: aa1f03e9     	mov	x9, xzr
    20a8: 910b000a     	add	x10, x0, #0x2c0
    20ac: 88dffd48     	ldar	w8, [x10]
    20b0: 35ffff28     	cbnz	w8, 0x2094 <iq4_f4_source_fence_02+0x64>
    20b4: b940700b     	ldr	w11, [x0, #0x70]
    20b8: 91000529     	add	x9, x9, #0x1
    20bc: 9101214a     	add	x10, x10, #0x48
    20c0: eb0b013f     	cmp	x9, x11
    20c4: 54ffff43     	b.lo	0x20ac <iq4_f4_source_fence_02+0x7c>
    20c8: 17ffffe8     	b	0x2068 <iq4_f4_source_fence_02+0x38>

00000000000020cc <iq4_f4_source_worker_claim_02>:
    20cc: aa0003e8     	mov	x8, x0
    20d0: 52800020     	mov	w0, #0x1                // =1
    20d4: b4000908     	cbz	x8, 0x21f4 <iq4_f4_source_worker_claim_02+0x128>
    20d8: b40008e1     	cbz	x1, 0x21f4 <iq4_f4_source_worker_claim_02+0x128>
    20dc: d28a464a     	mov	x10, #0x5232            // =21042
    20e0: f9400109     	ldr	x9, [x8]
    20e4: f2a68a6a     	movk	x10, #0x3453, lsl #16
    20e8: f2c688ca     	movk	x10, #0x3446, lsl #32
    20ec: f2e92a2a     	movk	x10, #0x4951, lsl #48
    20f0: eb0a013f     	cmp	x9, x10
    20f4: 54000801     	b.ne	0x21f4 <iq4_f4_source_worker_claim_02+0x128>
    20f8: d10183ff     	sub	sp, sp, #0x60
    20fc: a9047bfd     	stp	x29, x30, [sp, #0x40]
    2100: a9054ff4     	stp	x20, x19, [sp, #0x50]
    2104: 910103fd     	add	x29, sp, #0x40
    2108: 91033109     	add	x9, x8, #0xcc
    210c: 88dffd29     	ldar	w9, [x9]
    2110: 34000069     	cbz	w9, 0x211c <iq4_f4_source_worker_claim_02+0x50>
    2114: 528000a0     	mov	w0, #0x5                // =5
    2118: 14000034     	b	0x21e8 <iq4_f4_source_worker_claim_02+0x11c>
    211c: aa0803f4     	mov	x20, x8
    2120: aa0103f3     	mov	x19, x1
    2124: 94000000     	bl	0x2124 <iq4_f4_source_worker_claim_02+0x58>
		0000000000002124:  R_AARCH64_CALL26	iq4_f4_native_tid_02
    2128: b40005e0     	cbz	x0, 0x21e4 <iq4_f4_source_worker_claim_02+0x118>
    212c: f9402a88     	ldr	x8, [x20, #0x50]
    2130: eb08001f     	cmp	x0, x8
    2134: 54000580     	b.eq	0x21e4 <iq4_f4_source_worker_claim_02+0x118>
    2138: aa1403e9     	mov	x9, x20
    213c: 9101628a     	add	x10, x20, #0x58
    2140: aa1303e8     	mov	x8, x19
    2144: c85ffd4b     	ldaxr	x11, [x10]
    2148: b500008b     	cbnz	x11, 0x2158 <iq4_f4_source_worker_claim_02+0x8c>
    214c: c80bfd40     	stlxr	w11, x0, [x10]
    2150: 35ffffab     	cbnz	w11, 0x2144 <iq4_f4_source_worker_claim_02+0x78>
    2154: 14000002     	b	0x215c <iq4_f4_source_worker_claim_02+0x90>
    2158: d5033f5f     	clrex
    215c: c8dffd4a     	ldar	x10, [x10]
    2160: eb00015f     	cmp	x10, x0
    2164: 54000401     	b.ne	0x21e4 <iq4_f4_source_worker_claim_02+0x118>
    2168: f9411d2a     	ldr	x10, [x9, #0x238]
    216c: b940712b     	ldr	w11, [x9, #0x70]
    2170: 9acb094c     	udiv	x12, x10, x11
    2174: 9b0ba98a     	msub	x10, x12, x11, x10
    2178: 5280090b     	mov	w11, #0x48              // =72
    217c: 5280006c     	mov	w12, #0x3               // =3
    2180: 9b0b254b     	madd	x11, x10, x11, x9
    2184: 910b016b     	add	x11, x11, #0x2c0
    2188: 885ffd6d     	ldaxr	w13, [x11]
    218c: 710009bf     	cmp	w13, #0x2
    2190: 54000341     	b.ne	0x21f8 <iq4_f4_source_worker_claim_02+0x12c>
    2194: 880dfd6c     	stlxr	w13, w12, [x11]
    2198: 35ffff8d     	cbnz	w13, 0x2188 <iq4_f4_source_worker_claim_02+0xbc>
    219c: b940752c     	ldr	w12, [x9, #0x74]
    21a0: f9403129     	ldr	x9, [x9, #0x60]
    21a4: 2a1f03e0     	mov	w0, wzr
    21a8: 3cc08160     	ldur	q0, [x11, #0x8]
    21ac: 3cc18161     	ldur	q1, [x11, #0x18]
    21b0: 3cc28162     	ldur	q2, [x11, #0x28]
    21b4: 9b0c2549     	madd	x9, x10, x12, x9
    21b8: 3cc38163     	ldur	q3, [x11, #0x38]
    21bc: b940056b     	ldr	w11, [x11, #0x4]
    21c0: ad0007e0     	stp	q0, q1, [sp]
    21c4: ad010fe2     	stp	q2, q3, [sp, #0x20]
    21c8: 3c838103     	stur	q3, [x8, #0x38]
    21cc: 3c828102     	stur	q2, [x8, #0x28]
    21d0: 3c818101     	stur	q1, [x8, #0x18]
    21d4: f9000109     	str	x9, [x8]
    21d8: 3c808100     	stur	q0, [x8, #0x8]
    21dc: 29092d0a     	stp	w10, w11, [x8, #0x48]
    21e0: 14000002     	b	0x21e8 <iq4_f4_source_worker_claim_02+0x11c>
    21e4: 52800040     	mov	w0, #0x2                // =2
    21e8: a9454ff4     	ldp	x20, x19, [sp, #0x50]
    21ec: a9447bfd     	ldp	x29, x30, [sp, #0x40]
    21f0: 910183ff     	add	sp, sp, #0x60
    21f4: d65f03c0     	ret
    21f8: 528000e0     	mov	w0, #0x7                // =7
    21fc: d5033f5f     	clrex
    2200: 17fffffa     	b	0x21e8 <iq4_f4_source_worker_claim_02+0x11c>

0000000000002204 <iq4_f4_source_worker_release_02>:
    2204: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
    2208: a9014ff4     	stp	x20, x19, [sp, #0x10]
    220c: 910003fd     	mov	x29, sp
    2210: aa0003f3     	mov	x19, x0
    2214: 52800040     	mov	w0, #0x2                // =2
    2218: b4000573     	cbz	x19, 0x22c4 <iq4_f4_source_worker_release_02+0xc0>
    221c: b4000541     	cbz	x1, 0x22c4 <iq4_f4_source_worker_release_02+0xc0>
    2220: d28a4649     	mov	x9, #0x5232             // =21042
    2224: f9400268     	ldr	x8, [x19]
    2228: f2a68a69     	movk	x9, #0x3453, lsl #16
    222c: f2c688c9     	movk	x9, #0x3446, lsl #32
    2230: f2e92a29     	movk	x9, #0x4951, lsl #48
    2234: eb09011f     	cmp	x8, x9
    2238: 54000461     	b.ne	0x22c4 <iq4_f4_source_worker_release_02+0xc0>
    223c: aa0103f4     	mov	x20, x1
    2240: 94000000     	bl	0x2240 <iq4_f4_source_worker_release_02+0x3c>
		0000000000002240:  R_AARCH64_CALL26	iq4_f4_native_tid_02
    2244: 91016268     	add	x8, x19, #0x58
    2248: c8dffd08     	ldar	x8, [x8]
    224c: eb08001f     	cmp	x0, x8
    2250: 54000381     	b.ne	0x22c0 <iq4_f4_source_worker_release_02+0xbc>
    2254: b9404a89     	ldr	w9, [x20, #0x48]
    2258: b940726a     	ldr	w10, [x19, #0x70]
    225c: 6b0a013f     	cmp	w9, w10
    2260: 54000302     	b.hs	0x22c0 <iq4_f4_source_worker_release_02+0xbc>
    2264: f9411e6b     	ldr	x11, [x19, #0x238]
    2268: 9aca096c     	udiv	x12, x11, x10
    226c: 9b0aad8a     	msub	x10, x12, x10, x11
    2270: eb09015f     	cmp	x10, x9
    2274: 54000261     	b.ne	0x22c0 <iq4_f4_source_worker_release_02+0xbc>
    2278: 5280090a     	mov	w10, #0x48              // =72
    227c: 9baa4d29     	umaddl	x9, w9, w10, x19
    2280: 910b0129     	add	x9, x9, #0x2c0
    2284: 88dffd2a     	ldar	w10, [x9]
    2288: 71000d5f     	cmp	w10, #0x3
    228c: 540001a1     	b.ne	0x22c0 <iq4_f4_source_worker_release_02+0xbc>
    2290: b9404e8a     	ldr	w10, [x20, #0x4c]
    2294: b940052b     	ldr	w11, [x9, #0x4]
    2298: aa1403e8     	mov	x8, x20
    229c: 6b0b015f     	cmp	w10, w11
    22a0: 54000101     	b.ne	0x22c0 <iq4_f4_source_worker_release_02+0xbc>
    22a4: b940490a     	ldr	w10, [x8, #0x48]
    22a8: b940766b     	ldr	w11, [x19, #0x74]
    22ac: f940326c     	ldr	x12, [x19, #0x60]
    22b0: f9400108     	ldr	x8, [x8]
    22b4: 9baa316a     	umaddl	x10, w11, w10, x12
    22b8: eb0a011f     	cmp	x8, x10
    22bc: 540000a0     	b.eq	0x22d0 <iq4_f4_source_worker_release_02+0xcc>
    22c0: 52800040     	mov	w0, #0x2                // =2
    22c4: a9414ff4     	ldp	x20, x19, [sp, #0x10]
    22c8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
    22cc: d65f03c0     	ret
    22d0: 889ffd3f     	stlr	wzr, [x9]
    22d4: 2a1f03e0     	mov	w0, wzr
    22d8: f9411e68     	ldr	x8, [x19, #0x238]
    22dc: 91000508     	add	x8, x8, #0x1
    22e0: f9011e68     	str	x8, [x19, #0x238]
    22e4: 17fffff8     	b	0x22c4 <iq4_f4_source_worker_release_02+0xc0>

00000000000022e8 <iq4_f4_source_status_on_ui_02>:
    22e8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
    22ec: a9014ff4     	stp	x20, x19, [sp, #0x10]
    22f0: 910003fd     	mov	x29, sp
    22f4: 6f00e400     	movi	v0.2d, #0000000000000000
    22f8: aa0803f3     	mov	x19, x8
    22fc: f900311f     	str	xzr, [x8, #0x60]
    2300: ad000100     	stp	q0, q0, [x8]
    2304: ad010100     	stp	q0, q0, [x8, #0x20]
    2308: ad020100     	stp	q0, q0, [x8, #0x40]
    230c: b4000300     	cbz	x0, 0x236c <iq4_f4_source_status_on_ui_02+0x84>
    2310: aa0003f4     	mov	x20, x0
    2314: 97fff9e1     	bl	0xa98 <on_ui>
    2318: 340002a0     	cbz	w0, 0x236c <iq4_f4_source_status_on_ui_02+0x84>
    231c: 3dc15280     	ldr	q0, [x20, #0x540]
    2320: 3dc15681     	ldr	q1, [x20, #0x550]
    2324: f942b288     	ldr	x8, [x20, #0x560]
    2328: 3dc14e82     	ldr	q2, [x20, #0x530]
    232c: ad020660     	stp	q0, q1, [x19, #0x40]
    2330: 3dc14280     	ldr	q0, [x20, #0x500]
    2334: 3dc14681     	ldr	q1, [x20, #0x510]
    2338: f9003268     	str	x8, [x19, #0x60]
    233c: 91033288     	add	x8, x20, #0xcc
    2340: ad000660     	stp	q0, q1, [x19]
    2344: 3dc14a80     	ldr	q0, [x20, #0x520]
    2348: ad010a60     	stp	q0, q2, [x19, #0x20]
    234c: 88dffd09     	ldar	w9, [x8]
    2350: 91031288     	add	x8, x20, #0xc4
    2354: 88dffd08     	ldar	w8, [x8]
    2358: 290b2269     	stp	w9, w8, [x19, #0x58]
    235c: 91032288     	add	x8, x20, #0xc8
    2360: 52800c09     	mov	w9, #0x60               // =96
    2364: 88dffd08     	ldar	w8, [x8]
    2368: 14000003     	b	0x2374 <iq4_f4_source_status_on_ui_02+0x8c>
    236c: 52800028     	mov	w8, #0x1                // =1
    2370: 52800b09     	mov	w9, #0x58               // =88
    2374: b8296a68     	str	w8, [x19, x9]
    2378: a9414ff4     	ldp	x20, x19, [sp, #0x10]
    237c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
    2380: d65f03c0     	ret

0000000000002384 <iq4_f4_source_diagnostics_04>:
    2384: 2a1f03e8     	mov	w8, wzr
    2388: b4000180     	cbz	x0, 0x23b8 <iq4_f4_source_diagnostics_04+0x34>
    238c: b4000161     	cbz	x1, 0x23b8 <iq4_f4_source_diagnostics_04+0x34>
    2390: 9115a008     	add	x8, x0, #0x568
    2394: 88dffd08     	ldar	w8, [x8]
    2398: b9000028     	str	w8, [x1]
    239c: 9115b008     	add	x8, x0, #0x56c
    23a0: 88dffd08     	ldar	w8, [x8]
    23a4: b9000428     	str	w8, [x1, #0x4]
    23a8: 9115c008     	add	x8, x0, #0x570
    23ac: 88dffd08     	ldar	w8, [x8]
    23b0: b9000828     	str	w8, [x1, #0x8]
    23b4: 52800028     	mov	w8, #0x1                // =1
    23b8: 2a0803e0     	mov	w0, w8
    23bc: d65f03c0     	ret

00000000000023c0 <same_shape>:
    23c0: b9400008     	ldr	w8, [x0]
    23c4: b9400029     	ldr	w9, [x1]
    23c8: 6b09011f     	cmp	w8, w9
    23cc: 540004e1     	b.ne	0x2468 <same_shape+0xa8>
    23d0: b9400408     	ldr	w8, [x0, #0x4]
    23d4: b9400429     	ldr	w9, [x1, #0x4]
    23d8: 6b09011f     	cmp	w8, w9
    23dc: 54000461     	b.ne	0x2468 <same_shape+0xa8>
    23e0: b9400808     	ldr	w8, [x0, #0x8]
    23e4: b9400829     	ldr	w9, [x1, #0x8]
    23e8: 6b09011f     	cmp	w8, w9
    23ec: 540003e1     	b.ne	0x2468 <same_shape+0xa8>
    23f0: b9400c08     	ldr	w8, [x0, #0xc]
    23f4: b9400c29     	ldr	w9, [x1, #0xc]
    23f8: 6b09011f     	cmp	w8, w9
    23fc: 54000361     	b.ne	0x2468 <same_shape+0xa8>
    2400: b9401808     	ldr	w8, [x0, #0x18]
    2404: b9401829     	ldr	w9, [x1, #0x18]
    2408: 6b09011f     	cmp	w8, w9
    240c: 540002e1     	b.ne	0x2468 <same_shape+0xa8>
    2410: b9402c08     	ldr	w8, [x0, #0x2c]
    2414: b9402c29     	ldr	w9, [x1, #0x2c]
    2418: 6b09011f     	cmp	w8, w9
    241c: 54000261     	b.ne	0x2468 <same_shape+0xa8>
    2420: b9403008     	ldr	w8, [x0, #0x30]
    2424: b9403029     	ldr	w9, [x1, #0x30]
    2428: 6b09011f     	cmp	w8, w9
    242c: 540001e1     	b.ne	0x2468 <same_shape+0xa8>
    2430: b9403408     	ldr	w8, [x0, #0x34]
    2434: b9403429     	ldr	w9, [x1, #0x34]
    2438: 6b09011f     	cmp	w8, w9
    243c: 54000161     	b.ne	0x2468 <same_shape+0xa8>
    2440: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
    2444: 910003fd     	mov	x29, sp
    2448: 91007000     	add	x0, x0, #0x1c
    244c: 91007021     	add	x1, x1, #0x1c
    2450: 52800202     	mov	w2, #0x10               // =16
    2454: 94000000     	bl	0x2454 <same_shape+0x94>
		0000000000002454:  R_AARCH64_CALL26	memcmp
    2458: 7100001f     	cmp	w0, #0x0
    245c: 1a9f17e0     	cset	w0, eq
    2460: a8c17bfd     	ldp	x29, x30, [sp], #0x10
    2464: d65f03c0     	ret
    2468: 2a1f03e0     	mov	w0, wzr
    246c: d65f03c0     	ret
