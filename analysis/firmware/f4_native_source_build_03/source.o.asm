
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f4_native_source_build_03/source.o:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000000000 <iq4_f4_source_storage_bytes_02>:
       0: 5280ae00     	mov	w0, #0x570              // =1392
       4: d65f03c0     	ret

0000000000000008 <iq4_f4_source_init_02>:
       8: b4000da0     	cbz	x0, 0x1bc <iq4_f4_source_init_02+0x1b4>
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
      34: b4000b42     	cbz	x2, 0x19c <iq4_f4_source_init_02+0x194>
      38: f115c03f     	cmp	x1, #0x570
      3c: 54000b03     	b.lo	0x19c <iq4_f4_source_init_02+0x194>
      40: 92400e68     	and	x8, x19, #0xf
      44: b5000ac8     	cbnz	x8, 0x19c <iq4_f4_source_init_02+0x194>
      48: b4000aa4     	cbz	x4, 0x19c <iq4_f4_source_init_02+0x194>
      4c: 510024c8     	sub	w8, w6, #0x9
      50: 31001d1f     	cmn	w8, #0x7
      54: 54000a43     	b.lo	0x19c <iq4_f4_source_init_02+0x194>
      58: 12a02008     	mov	w8, #-0x1000001         // =-16777217
      5c: 0b0800e8     	add	w8, w7, w8
      60: 53187d08     	lsr	w8, w8, #24
      64: 7103fd1f     	cmp	w8, #0xff
      68: 540009a3     	b.lo	0x19c <iq4_f4_source_init_02+0x194>
      6c: 1b067ce8     	mul	w8, w7, w6
      70: eb0800bf     	cmp	x5, x8
      74: 54000943     	b.lo	0x19c <iq4_f4_source_init_02+0x194>
      78: ab0400bf     	cmn	x5, x4
      7c: 1a9f37e8     	cset	w8, hs
      80: b115c67f     	cmn	x19, #0x571
      84: 540008c8     	b.hi	0x19c <iq4_f4_source_init_02+0x194>
      88: 370008a8     	tbnz	w8, #0x0, 0x19c <iq4_f4_source_init_02+0x194>
      8c: 9115c268     	add	x8, x19, #0x570
      90: eb04011f     	cmp	x8, x4
      94: 54000089     	b.ls	0xa4 <iq4_f4_source_init_02+0x9c>
      98: 8b0400a8     	add	x8, x5, x4
      9c: eb13011f     	cmp	x8, x19
      a0: 540007e8     	b.hi	0x19c <iq4_f4_source_init_02+0x194>
      a4: aa1303e0     	mov	x0, x19
      a8: 2a1f03e1     	mov	w1, wzr
      ac: aa0203f4     	mov	x20, x2
      b0: 5280ae02     	mov	w2, #0x570              // =1392
      b4: a90017e4     	stp	x4, x5, [sp]
      b8: aa0303f5     	mov	x21, x3
      bc: 29021fe6     	stp	w6, w7, [sp, #0x10]
      c0: 94000000     	bl	0xc0 <iq4_f4_source_init_02+0xb8>
		00000000000000c0:  R_AARCH64_CALL26	memset
      c4: aa1f03f9     	mov	x25, xzr
      c8: 52800308     	mov	w8, #0x18               // =24
      cc: 9000001b     	adrp	x27, 0x0 <iq4_f4_source_storage_bytes_02>
		00000000000000cc:  R_AARCH64_ADR_PREL_PG_HI21	.data.rel.ro
      d0: 9100037b     	add	x27, x27, #0x0
		00000000000000d0:  R_AARCH64_ADD_ABS_LO12_NC	.data.rel.ro
      d4: 5280081c     	mov	w28, #0x40              // =64
      d8: a900d674     	stp	x20, x21, [x19, #0x8]
      dc: 9b086f35     	madd	x21, x25, x8, x27
      e0: f94006b6     	ldr	x22, [x21, #0x8]
      e4: b4000396     	cbz	x22, 0x154 <iq4_f4_source_init_02+0x14c>
      e8: f94002b8     	ldr	x24, [x21]
      ec: aa1f03f7     	mov	x23, xzr
      f0: aa1603e8     	mov	x8, x22
      f4: f101011a     	subs	x26, x8, #0x40
      f8: 8b170301     	add	x1, x24, x23
      fc: 9a9c3114     	csel	x20, x8, x28, lo
     100: ab01029f     	cmn	x20, x1
     104: 1a9f37e8     	cset	w8, hs
     108: f140043f     	cmp	x1, #0x1, lsl #12       // =0x1000
     10c: 54000463     	b.lo	0x198 <iq4_f4_source_init_02+0x190>
     110: 37000448     	tbnz	w8, #0x0, 0x198 <iq4_f4_source_init_02+0x190>
     114: a9408268     	ldp	x8, x0, [x19, #0x8]
     118: d10103a2     	sub	x2, x29, #0x40
     11c: aa1403e3     	mov	x3, x20
     120: d63f0100     	blr	x8
     124: 7100041f     	cmp	w0, #0x1
     128: 54000381     	b.ne	0x198 <iq4_f4_source_init_02+0x190>
     12c: f9400aa8     	ldr	x8, [x21, #0x10]
     130: d10103a0     	sub	x0, x29, #0x40
     134: aa1403e2     	mov	x2, x20
     138: 8b170101     	add	x1, x8, x23
     13c: 94000000     	bl	0x13c <iq4_f4_source_init_02+0x134>
		000000000000013c:  R_AARCH64_CALL26	memcmp
     140: 350002c0     	cbnz	w0, 0x198 <iq4_f4_source_init_02+0x190>
     144: 910102f7     	add	x23, x23, #0x40
     148: aa1a03e8     	mov	x8, x26
     14c: eb1602ff     	cmp	x23, x22
     150: 54fffd23     	b.lo	0xf4 <iq4_f4_source_init_02+0xec>
     154: 91000739     	add	x25, x25, #0x1
     158: 52800308     	mov	w8, #0x18               // =24
     15c: f1008b3f     	cmp	x25, #0x22
     160: 54fffbe1     	b.ne	0xdc <iq4_f4_source_init_02+0xd4>
     164: d10103a1     	sub	x1, x29, #0x40
     168: aa1303e0     	mov	x0, x19
     16c: 9400002b     	bl	0x218 <owner>
     170: 34000140     	cbz	w0, 0x198 <iq4_f4_source_init_02+0x190>
     174: 910063e1     	add	x1, sp, #0x18
     178: aa1303e0     	mov	x0, x19
     17c: 94000027     	bl	0x218 <owner>
     180: 340000c0     	cbz	w0, 0x198 <iq4_f4_source_init_02+0x190>
     184: d10103a0     	sub	x0, x29, #0x40
     188: 910063e1     	add	x1, sp, #0x18
     18c: 52800702     	mov	w2, #0x38               // =56
     190: 94000000     	bl	0x190 <iq4_f4_source_init_02+0x188>
		0000000000000190:  R_AARCH64_CALL26	memcmp
     194: 34000180     	cbz	w0, 0x1c4 <iq4_f4_source_init_02+0x1bc>
     198: 52800040     	mov	w0, #0x2                // =2
     19c: a94e4ff4     	ldp	x20, x19, [sp, #0xe0]
     1a0: a94d57f6     	ldp	x22, x21, [sp, #0xd0]
     1a4: a94c5ff8     	ldp	x24, x23, [sp, #0xc0]
     1a8: a94b67fa     	ldp	x26, x25, [sp, #0xb0]
     1ac: a94a6ffc     	ldp	x28, x27, [sp, #0xa0]
     1b0: a9497bfd     	ldp	x29, x30, [sp, #0x90]
     1b4: 9103c3ff     	add	sp, sp, #0xf0
     1b8: d65f03c0     	ret
     1bc: 52800040     	mov	w0, #0x2                // =2
     1c0: d65f03c0     	ret
     1c4: 94000000     	bl	0x1c4 <iq4_f4_source_init_02+0x1bc>
		00000000000001c4:  R_AARCH64_CALL26	iq4_f4_native_tid_02
     1c8: f9002a60     	str	x0, [x19, #0x50]
     1cc: b4fffe60     	cbz	x0, 0x198 <iq4_f4_source_init_02+0x190>
     1d0: f85f03a8     	ldur	x8, [x29, #-0x10]
     1d4: ad7e07a0     	ldp	q0, q1, [x29, #-0x40]
     1d8: 3cde03a2     	ldur	q2, [x29, #-0x20]
     1dc: 2a1f03e0     	mov	w0, wzr
     1e0: f9002668     	str	x8, [x19, #0x48]
     1e4: a94023e9     	ldp	x9, x8, [sp]
     1e8: 3c818260     	stur	q0, [x19, #0x18]
     1ec: 3c828261     	stur	q1, [x19, #0x28]
     1f0: a9062269     	stp	x9, x8, [x19, #0x60]
     1f4: 294223e9     	ldp	w9, w8, [sp, #0x10]
     1f8: 3c838262     	stur	q2, [x19, #0x38]
     1fc: 290e2269     	stp	w9, w8, [x19, #0x70]
     200: d28a4648     	mov	x8, #0x5232             // =21042
     204: f2a68a68     	movk	x8, #0x3453, lsl #16
     208: f2c688c8     	movk	x8, #0x3446, lsl #32
     20c: f2e92a28     	movk	x8, #0x4951, lsl #48
     210: f9000268     	str	x8, [x19]
     214: 17ffffe2     	b	0x19c <iq4_f4_source_init_02+0x194>

0000000000000218 <owner>:
     218: d10183ff     	sub	sp, sp, #0x60
     21c: a9047bfd     	stp	x29, x30, [sp, #0x40]
     220: a9054ff4     	stp	x20, x19, [sp, #0x50]
     224: 910103fd     	add	x29, sp, #0x40
     228: aa0003f4     	mov	x20, x0
     22c: d10023a0     	sub	x0, x29, #0x8
     230: aa0103f3     	mov	x19, x1
     234: 94000000     	bl	0x234 <owner+0x1c>
		0000000000000234:  R_AARCH64_CALL26	iq4_f4_native_current_02
     238: 34001f20     	cbz	w0, 0x61c <owner+0x404>
     23c: f85f83a1     	ldur	x1, [x29, #-0x8]
     240: 52920028     	mov	w8, #0x9001             // =36865
     244: 2a1f03e0     	mov	w0, wzr
     248: 8b080028     	add	x8, x1, x8
     24c: f140291f     	cmp	x8, #0xa, lsl #12       // =0xa000
     250: 54001e69     	b.ls	0x61c <owner+0x404>
     254: 92400828     	and	x8, x1, #0x7
     258: b5001e28     	cbnz	x8, 0x61c <owner+0x404>
     25c: a9408288     	ldp	x8, x0, [x20, #0x8]
     260: d10043a2     	sub	x2, x29, #0x10
     264: 52800103     	mov	w3, #0x8                // =8
     268: d63f0100     	blr	x8
     26c: 7100041f     	cmp	w0, #0x1
     270: 2a1f03e0     	mov	w0, wzr
     274: 54001d41     	b.ne	0x61c <owner+0x404>
     278: f85f03a8     	ldur	x8, [x29, #-0x10]
     27c: d16e4508     	sub	x8, x8, #0xb91, lsl #12 // =0xb91000
     280: f13d211f     	cmp	x8, #0xf48
     284: 54001cc1     	b.ne	0x61c <owner+0x404>
     288: f85f83a8     	ldur	x8, [x29, #-0x8]
     28c: 91074109     	add	x9, x8, #0x1d0
     290: d343fd29     	lsr	x9, x9, #3
     294: f108053f     	cmp	x9, #0x201
     298: 54001c03     	b.lo	0x618 <owner+0x400>
     29c: a9408289     	ldp	x9, x0, [x20, #0x8]
     2a0: 91072101     	add	x1, x8, #0x1c8
     2a4: d10063a2     	sub	x2, x29, #0x18
     2a8: 52800103     	mov	w3, #0x8                // =8
     2ac: d63f0120     	blr	x9
     2b0: 7100041f     	cmp	w0, #0x1
     2b4: 54001b21     	b.ne	0x618 <owner+0x400>
     2b8: f85e83a1     	ldur	x1, [x29, #-0x18]
     2bc: 52920028     	mov	w8, #0x9001             // =36865
     2c0: 2a1f03e0     	mov	w0, wzr
     2c4: 8b080028     	add	x8, x1, x8
     2c8: f140291f     	cmp	x8, #0xa, lsl #12       // =0xa000
     2cc: 54001a89     	b.ls	0x61c <owner+0x404>
     2d0: 92400828     	and	x8, x1, #0x7
     2d4: b5001a48     	cbnz	x8, 0x61c <owner+0x404>
     2d8: a9408288     	ldp	x8, x0, [x20, #0x8]
     2dc: d10043a2     	sub	x2, x29, #0x10
     2e0: 52800103     	mov	w3, #0x8                // =8
     2e4: d63f0100     	blr	x8
     2e8: 7100041f     	cmp	w0, #0x1
     2ec: 2a1f03e0     	mov	w0, wzr
     2f0: 54001961     	b.ne	0x61c <owner+0x404>
     2f4: f85f03a8     	ldur	x8, [x29, #-0x10]
     2f8: d16e3d08     	sub	x8, x8, #0xb8f, lsl #12 // =0xb8f000
     2fc: f10d611f     	cmp	x8, #0x358
     300: 540018e1     	b.ne	0x61c <owner+0x404>
     304: f85e83a8     	ldur	x8, [x29, #-0x18]
     308: 91004109     	add	x9, x8, #0x10
     30c: d343fd29     	lsr	x9, x9, #3
     310: f108053f     	cmp	x9, #0x201
     314: 54001823     	b.lo	0x618 <owner+0x400>
     318: a9408289     	ldp	x9, x0, [x20, #0x8]
     31c: 91002101     	add	x1, x8, #0x8
     320: d10043a2     	sub	x2, x29, #0x10
     324: 52800103     	mov	w3, #0x8                // =8
     328: d63f0120     	blr	x9
     32c: 7100041f     	cmp	w0, #0x1
     330: 54001741     	b.ne	0x618 <owner+0x400>
     334: a97f27a8     	ldp	x8, x9, [x29, #-0x10]
     338: 2a1f03e0     	mov	w0, wzr
     33c: eb09011f     	cmp	x8, x9
     340: 540016e1     	b.ne	0x61c <owner+0x404>
     344: 91270129     	add	x9, x9, #0x9c0
     348: d343fd29     	lsr	x9, x9, #3
     34c: f108053f     	cmp	x9, #0x201
     350: 54001663     	b.lo	0x61c <owner+0x404>
     354: a9408289     	ldp	x9, x0, [x20, #0x8]
     358: 9126e101     	add	x1, x8, #0x9b8
     35c: 910083e2     	add	x2, sp, #0x20
     360: 52800103     	mov	w3, #0x8                // =8
     364: d63f0120     	blr	x9
     368: 7100041f     	cmp	w0, #0x1
     36c: 54001561     	b.ne	0x618 <owner+0x400>
     370: f94013e8     	ldr	x8, [sp, #0x20]
     374: 52920029     	mov	w9, #0x9001             // =36865
     378: 2a1f03e0     	mov	w0, wzr
     37c: 8b090109     	add	x9, x8, x9
     380: f140293f     	cmp	x9, #0xa, lsl #12       // =0xa000
     384: 540014c9     	b.ls	0x61c <owner+0x404>
     388: 92400908     	and	x8, x8, #0x7
     38c: b5001488     	cbnz	x8, 0x61c <owner+0x404>
     390: f85e83a8     	ldur	x8, [x29, #-0x18]
     394: 911e6109     	add	x9, x8, #0x798
     398: d343fd29     	lsr	x9, x9, #3
     39c: f108053f     	cmp	x9, #0x201
     3a0: 540013c3     	b.lo	0x618 <owner+0x400>
     3a4: a9408289     	ldp	x9, x0, [x20, #0x8]
     3a8: 911e4101     	add	x1, x8, #0x790
     3ac: d10043a2     	sub	x2, x29, #0x10
     3b0: 52800103     	mov	w3, #0x8                // =8
     3b4: d63f0120     	blr	x9
     3b8: 7100041f     	cmp	w0, #0x1
     3bc: 540012e1     	b.ne	0x618 <owner+0x400>
     3c0: f85f03a8     	ldur	x8, [x29, #-0x10]
     3c4: f94013e9     	ldr	x9, [sp, #0x20]
     3c8: eb09011f     	cmp	x8, x9
     3cc: 54001261     	b.ne	0x618 <owner+0x400>
     3d0: f85f83a8     	ldur	x8, [x29, #-0x8]
     3d4: 91232109     	add	x9, x8, #0x8c8
     3d8: d343fd29     	lsr	x9, x9, #3
     3dc: f108053f     	cmp	x9, #0x201
     3e0: 540011c3     	b.lo	0x618 <owner+0x400>
     3e4: a9408289     	ldp	x9, x0, [x20, #0x8]
     3e8: 91230101     	add	x1, x8, #0x8c0
     3ec: 910063e2     	add	x2, sp, #0x18
     3f0: 52800103     	mov	w3, #0x8                // =8
     3f4: d63f0120     	blr	x9
     3f8: 7100041f     	cmp	w0, #0x1
     3fc: 540010e1     	b.ne	0x618 <owner+0x400>
     400: f9400fe1     	ldr	x1, [sp, #0x18]
     404: 52920028     	mov	w8, #0x9001             // =36865
     408: 2a1f03e0     	mov	w0, wzr
     40c: 8b080028     	add	x8, x1, x8
     410: f140291f     	cmp	x8, #0xa, lsl #12       // =0xa000
     414: 54001049     	b.ls	0x61c <owner+0x404>
     418: 92400828     	and	x8, x1, #0x7
     41c: b5001008     	cbnz	x8, 0x61c <owner+0x404>
     420: a9408288     	ldp	x8, x0, [x20, #0x8]
     424: d10043a2     	sub	x2, x29, #0x10
     428: 52800103     	mov	w3, #0x8                // =8
     42c: d63f0100     	blr	x8
     430: 7100041f     	cmp	w0, #0x1
     434: 2a1f03e0     	mov	w0, wzr
     438: 54000f21     	b.ne	0x61c <owner+0x404>
     43c: f85f03a8     	ldur	x8, [x29, #-0x10]
     440: d16e6908     	sub	x8, x8, #0xb9a, lsl #12 // =0xb9a000
     444: f127611f     	cmp	x8, #0x9d8
     448: 54000ea1     	b.ne	0x61c <owner+0x404>
     44c: f94013e8     	ldr	x8, [sp, #0x20]
     450: 91048109     	add	x9, x8, #0x120
     454: d343fd29     	lsr	x9, x9, #3
     458: f108053f     	cmp	x9, #0x201
     45c: 54000de3     	b.lo	0x618 <owner+0x400>
     460: a9408289     	ldp	x9, x0, [x20, #0x8]
     464: 91046101     	add	x1, x8, #0x118
     468: 910043e2     	add	x2, sp, #0x10
     46c: 52800103     	mov	w3, #0x8                // =8
     470: d63f0120     	blr	x9
     474: 7100041f     	cmp	w0, #0x1
     478: 54000d01     	b.ne	0x618 <owner+0x400>
     47c: f9400be8     	ldr	x8, [sp, #0x10]
     480: 52920029     	mov	w9, #0x9001             // =36865
     484: 2a1f03e0     	mov	w0, wzr
     488: 8b090109     	add	x9, x8, x9
     48c: f140293f     	cmp	x9, #0xa, lsl #12       // =0xa000
     490: 54000c69     	b.ls	0x61c <owner+0x404>
     494: 92400908     	and	x8, x8, #0x7
     498: b5000c28     	cbnz	x8, 0x61c <owner+0x404>
     49c: f9400fe8     	ldr	x8, [sp, #0x18]
     4a0: 91044109     	add	x9, x8, #0x110
     4a4: d343fd29     	lsr	x9, x9, #3
     4a8: f108053f     	cmp	x9, #0x201
     4ac: 54000b63     	b.lo	0x618 <owner+0x400>
     4b0: a9408289     	ldp	x9, x0, [x20, #0x8]
     4b4: 91042101     	add	x1, x8, #0x108
     4b8: d10043a2     	sub	x2, x29, #0x10
     4bc: 52800103     	mov	w3, #0x8                // =8
     4c0: d63f0120     	blr	x9
     4c4: 7100041f     	cmp	w0, #0x1
     4c8: 54000a81     	b.ne	0x618 <owner+0x400>
     4cc: f85f03a1     	ldur	x1, [x29, #-0x10]
     4d0: f9400be8     	ldr	x8, [sp, #0x10]
     4d4: 2a1f03e0     	mov	w0, wzr
     4d8: eb08003f     	cmp	x1, x8
     4dc: 54000a01     	b.ne	0x61c <owner+0x404>
     4e0: 91002108     	add	x8, x8, #0x8
     4e4: d343fd08     	lsr	x8, x8, #3
     4e8: f108051f     	cmp	x8, #0x201
     4ec: 54000983     	b.lo	0x61c <owner+0x404>
     4f0: a9408288     	ldp	x8, x0, [x20, #0x8]
     4f4: d10043a2     	sub	x2, x29, #0x10
     4f8: 52800103     	mov	w3, #0x8                // =8
     4fc: d63f0100     	blr	x8
     500: 7100041f     	cmp	w0, #0x1
     504: 2a1f03e0     	mov	w0, wzr
     508: 540008a1     	b.ne	0x61c <owner+0x404>
     50c: f85f03a8     	ldur	x8, [x29, #-0x10]
     510: d1701d08     	sub	x8, x8, #0xc07, lsl #12 // =0xc07000
     514: f136a11f     	cmp	x8, #0xda8
     518: 54000821     	b.ne	0x61c <owner+0x404>
     51c: f9400be8     	ldr	x8, [sp, #0x10]
     520: 91004109     	add	x9, x8, #0x10
     524: d343fd29     	lsr	x9, x9, #3
     528: f108053f     	cmp	x9, #0x201
     52c: 54000763     	b.lo	0x618 <owner+0x400>
     530: a9408289     	ldp	x9, x0, [x20, #0x8]
     534: 91002101     	add	x1, x8, #0x8
     538: 910023e2     	add	x2, sp, #0x8
     53c: 52800103     	mov	w3, #0x8                // =8
     540: d63f0120     	blr	x9
     544: 7100041f     	cmp	w0, #0x1
     548: 54000681     	b.ne	0x618 <owner+0x400>
     54c: f94007e8     	ldr	x8, [sp, #0x8]
     550: 52920029     	mov	w9, #0x9001             // =36865
     554: 2a1f03e0     	mov	w0, wzr
     558: 8b090109     	add	x9, x8, x9
     55c: f140293f     	cmp	x9, #0xa, lsl #12       // =0xa000
     560: 540005e9     	b.ls	0x61c <owner+0x404>
     564: 92400909     	and	x9, x8, #0x7
     568: b50005a9     	cbnz	x9, 0x61c <owner+0x404>
     56c: a9408289     	ldp	x9, x0, [x20, #0x8]
     570: 91190101     	add	x1, x8, #0x640
     574: d10043a2     	sub	x2, x29, #0x10
     578: 52800103     	mov	w3, #0x8                // =8
     57c: d63f0120     	blr	x9
     580: 7100041f     	cmp	w0, #0x1
     584: 2a1f03e0     	mov	w0, wzr
     588: 540004a1     	b.ne	0x61c <owner+0x404>
     58c: f85f03a8     	ldur	x8, [x29, #-0x10]
     590: d1708d08     	sub	x8, x8, #0xc23, lsl #12 // =0xc23000
     594: f11e811f     	cmp	x8, #0x7a0
     598: 54000421     	b.ne	0x61c <owner+0x404>
     59c: f94007e8     	ldr	x8, [sp, #0x8]
     5a0: 911b8109     	add	x9, x8, #0x6e0
     5a4: d343fd29     	lsr	x9, x9, #3
     5a8: f108053f     	cmp	x9, #0x201
     5ac: 54000363     	b.lo	0x618 <owner+0x400>
     5b0: a9408289     	ldp	x9, x0, [x20, #0x8]
     5b4: 911b6101     	add	x1, x8, #0x6d8
     5b8: d10043a2     	sub	x2, x29, #0x10
     5bc: 52800103     	mov	w3, #0x8                // =8
     5c0: d63f0120     	blr	x9
     5c4: 7100041f     	cmp	w0, #0x1
     5c8: 54000281     	b.ne	0x618 <owner+0x400>
     5cc: f85f03a8     	ldur	x8, [x29, #-0x10]
     5d0: 52920029     	mov	w9, #0x9001             // =36865
     5d4: 2a1f03e0     	mov	w0, wzr
     5d8: 8b090109     	add	x9, x8, x9
     5dc: f140293f     	cmp	x9, #0xa, lsl #12       // =0xa000
     5e0: 540001e9     	b.ls	0x61c <owner+0x404>
     5e4: 92400908     	and	x8, x8, #0x7
     5e8: b50001a8     	cbnz	x8, 0x61c <owner+0x404>
     5ec: f85f83a8     	ldur	x8, [x29, #-0x8]
     5f0: f85e83a9     	ldur	x9, [x29, #-0x18]
     5f4: 52800020     	mov	w0, #0x1                // =1
     5f8: a9002668     	stp	x8, x9, [x19]
     5fc: a941abe8     	ldp	x8, x10, [sp, #0x18]
     600: a901226a     	stp	x10, x8, [x19, #0x10]
     604: a940a7ea     	ldp	x10, x9, [sp, #0x8]
     608: 91190148     	add	x8, x10, #0x640
     60c: a9022a69     	stp	x9, x10, [x19, #0x20]
     610: f9001a68     	str	x8, [x19, #0x30]
     614: 14000002     	b	0x61c <owner+0x404>
     618: 2a1f03e0     	mov	w0, wzr
     61c: a9454ff4     	ldp	x20, x19, [sp, #0x50]
     620: a9447bfd     	ldp	x29, x30, [sp, #0x40]
     624: 910183ff     	add	sp, sp, #0x60
     628: d65f03c0     	ret

000000000000062c <iq4_f4_source_attach_on_ui_02>:
     62c: b4000180     	cbz	x0, 0x65c <iq4_f4_source_attach_on_ui_02+0x30>
     630: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
     634: a9014ff4     	stp	x20, x19, [sp, #0x10]
     638: 910003fd     	mov	x29, sp
     63c: aa0003f3     	mov	x19, x0
     640: 94000081     	bl	0x844 <on_ui>
     644: 34000200     	cbz	w0, 0x684 <iq4_f4_source_attach_on_ui_02+0x58>
     648: 91033268     	add	x8, x19, #0xcc
     64c: 88dffd08     	ldar	w8, [x8]
     650: 340000a8     	cbz	w8, 0x664 <iq4_f4_source_attach_on_ui_02+0x38>
     654: 528000a0     	mov	w0, #0x5                // =5
     658: 1400000c     	b	0x688 <iq4_f4_source_attach_on_ui_02+0x5c>
     65c: 52800040     	mov	w0, #0x2                // =2
     660: d65f03c0     	ret
     664: 91031268     	add	x8, x19, #0xc4
     668: 88dffd08     	ldar	w8, [x8]
     66c: 350000c8     	cbnz	w8, 0x684 <iq4_f4_source_attach_on_ui_02+0x58>
     670: f9402661     	ldr	x1, [x19, #0x48]
     674: 9101e262     	add	x2, x19, #0x78
     678: aa1303e0     	mov	x0, x19
     67c: 94000111     	bl	0xac0 <exact_triple>
     680: 340000a0     	cbz	w0, 0x694 <iq4_f4_source_attach_on_ui_02+0x68>
     684: 52800040     	mov	w0, #0x2                // =2
     688: a9414ff4     	ldp	x20, x19, [sp, #0x10]
     68c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
     690: d65f03c0     	ret
     694: b940c268     	ldr	w8, [x19, #0xc0]
     698: 34000248     	cbz	w8, 0x6e0 <iq4_f4_source_attach_on_ui_02+0xb4>
     69c: b941e268     	ldr	w8, [x19, #0x1e0]
     6a0: 34000548     	cbz	w8, 0x748 <iq4_f4_source_attach_on_ui_02+0x11c>
     6a4: f9402661     	ldr	x1, [x19, #0x48]
     6a8: 9101e260     	add	x0, x19, #0x78
     6ac: 94000000     	bl	0x6ac <iq4_f4_source_attach_on_ui_02+0x80>
		00000000000006ac:  R_AARCH64_CALL26	iq4_f4_native_subscribe_02
     6b0: 34000a20     	cbz	w0, 0x7f4 <iq4_f4_source_attach_on_ui_02+0x1c8>
     6b4: f9402661     	ldr	x1, [x19, #0x48]
     6b8: 9101e262     	add	x2, x19, #0x78
     6bc: aa1303e0     	mov	x0, x19
     6c0: 94000100     	bl	0xac0 <exact_triple>
     6c4: 7100041f     	cmp	w0, #0x1
     6c8: 54000961     	b.ne	0x7f4 <iq4_f4_source_attach_on_ui_02+0x1c8>
     6cc: 2a1f03e0     	mov	w0, wzr
     6d0: 91031268     	add	x8, x19, #0xc4
     6d4: 52800029     	mov	w9, #0x1                // =1
     6d8: 889ffd09     	stlr	w9, [x8]
     6dc: 17ffffeb     	b	0x688 <iq4_f4_source_attach_on_ui_02+0x5c>
     6e0: f9400e62     	ldr	x2, [x19, #0x18]
     6e4: 90000001     	adrp	x1, 0x0 <iq4_f4_source_storage_bytes_02>
		00000000000006e4:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1
     6e8: 91000021     	add	x1, x1, #0x0
		00000000000006e8:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1
     6ec: 9101e260     	add	x0, x19, #0x78
     6f0: 94000000     	bl	0x6f0 <iq4_f4_source_attach_on_ui_02+0xc4>
		00000000000006f0:  R_AARCH64_CALL26	iq4_f4_native_construct_observer_02
     6f4: 34000800     	cbz	w0, 0x7f4 <iq4_f4_source_attach_on_ui_02+0x1c8>
     6f8: f9404268     	ldr	x8, [x19, #0x80]
     6fc: f9400e69     	ldr	x9, [x19, #0x18]
     700: eb09011f     	cmp	x8, x9
     704: 54000781     	b.ne	0x7f4 <iq4_f4_source_attach_on_ui_02+0x1c8>
     708: 90000008     	adrp	x8, 0x0 <iq4_f4_source_storage_bytes_02>
		0000000000000708:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst16
     70c: 90000009     	adrp	x9, 0x0 <iq4_f4_source_storage_bytes_02>
		000000000000070c:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x8f0
     710: 91000129     	add	x9, x9, #0x0
		0000000000000710:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x8f0
     714: 3dc00100     	ldr	q0, [x8]
		0000000000000714:  R_AARCH64_LDST128_ABS_LO12_NC	.rodata.cst16
     718: 90000008     	adrp	x8, 0x0 <iq4_f4_source_storage_bytes_02>
		0000000000000718:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x914
     71c: 91000108     	add	x8, x8, #0x0
		000000000000071c:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x914
     720: aa1303ea     	mov	x10, x19
     724: a90b2269     	stp	x9, x8, [x19, #0xb0]
     728: 52800028     	mov	w8, #0x1                // =1
     72c: f80a8d49     	str	x9, [x10, #0xa8]!
     730: 3c898260     	stur	q0, [x19, #0x98]
     734: f9003e6a     	str	x10, [x19, #0x78]
     738: f9004a73     	str	x19, [x19, #0x90]
     73c: b900c268     	str	w8, [x19, #0xc0]
     740: b941e268     	ldr	w8, [x19, #0x1e0]
     744: 35fffb08     	cbnz	w8, 0x6a4 <iq4_f4_source_attach_on_ui_02+0x78>
     748: 90000001     	adrp	x1, 0x0 <iq4_f4_source_storage_bytes_02>
		0000000000000748:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x16
     74c: 91000021     	add	x1, x1, #0x0
		000000000000074c:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x16
     750: 91038260     	add	x0, x19, #0xe0
     754: 94000000     	bl	0x754 <iq4_f4_source_attach_on_ui_02+0x128>
		0000000000000754:  R_AARCH64_CALL26	iq4_f4_native_event_construct_02
     758: 340004e0     	cbz	w0, 0x7f4 <iq4_f4_source_attach_on_ui_02+0x1c8>
     75c: f84e0268     	ldur	x8, [x19, #0xe0]
     760: 5286f414     	mov	w20, #0x37a0            // =14240
     764: 72a01854     	movk	w20, #0xc2, lsl #16
     768: eb14011f     	cmp	x8, x20
     76c: 54000441     	b.ne	0x7f4 <iq4_f4_source_attach_on_ui_02+0x1c8>
     770: f9400e62     	ldr	x2, [x19, #0x18]
     774: 90000001     	adrp	x1, 0x0 <iq4_f4_source_storage_bytes_02>
		0000000000000774:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x30
     778: 91000021     	add	x1, x1, #0x0
		0000000000000778:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x30
     77c: 91066260     	add	x0, x19, #0x198
     780: 94000000     	bl	0x780 <iq4_f4_source_attach_on_ui_02+0x154>
		0000000000000780:  R_AARCH64_CALL26	iq4_f4_native_construct_observer_02
     784: 34000380     	cbz	w0, 0x7f4 <iq4_f4_source_attach_on_ui_02+0x1c8>
     788: f940d268     	ldr	x8, [x19, #0x1a0]
     78c: f9400e69     	ldr	x9, [x19, #0x18]
     790: eb09011f     	cmp	x8, x9
     794: 54000301     	b.ne	0x7f4 <iq4_f4_source_attach_on_ui_02+0x1c8>
     798: 910c4288     	add	x8, x20, #0x310
     79c: 90000009     	adrp	x9, 0x0 <iq4_f4_source_storage_bytes_02>
		000000000000079c:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x8f0
     7a0: 91000129     	add	x9, x9, #0x0
		00000000000007a0:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x8f0
     7a4: a91c2668     	stp	x8, x9, [x19, #0x1c0]
     7a8: 90000008     	adrp	x8, 0x0 <iq4_f4_source_storage_bytes_02>
		00000000000007a8:  R_AARCH64_ADR_PREL_PG_HI21	.text+0xa34
     7ac: 91000108     	add	x8, x8, #0x0
		00000000000007ac:  R_AARCH64_ADD_ABS_LO12_NC	.text+0xa34
     7b0: a91d2269     	stp	x9, x8, [x19, #0x1d0]
     7b4: 91072269     	add	x9, x19, #0x1c8
     7b8: 52800034     	mov	w20, #0x1               // =1
     7bc: 91038261     	add	x1, x19, #0xe0
     7c0: 91066262     	add	x2, x19, #0x198
     7c4: aa1303e0     	mov	x0, x19
     7c8: f900ce69     	str	x9, [x19, #0x198]
     7cc: a91b7e73     	stp	x19, xzr, [x19, #0x1b0]
     7d0: b901e274     	str	w20, [x19, #0x1e0]
     7d4: 940000bb     	bl	0xac0 <exact_triple>
     7d8: 340001c0     	cbz	w0, 0x810 <iq4_f4_source_attach_on_ui_02+0x1e4>
     7dc: 91032268     	add	x8, x19, #0xc8
     7e0: 91033269     	add	x9, x19, #0xcc
     7e4: 528000a0     	mov	w0, #0x5                // =5
     7e8: 889ffd1f     	stlr	wzr, [x8]
     7ec: 889ffd34     	stlr	w20, [x9]
     7f0: 17ffffa6     	b	0x688 <iq4_f4_source_attach_on_ui_02+0x5c>
     7f4: 91032268     	add	x8, x19, #0xc8
     7f8: 91033269     	add	x9, x19, #0xcc
     7fc: 5280002a     	mov	w10, #0x1               // =1
     800: 889ffd1f     	stlr	wzr, [x8]
     804: 528000a0     	mov	w0, #0x5                // =5
     808: 889ffd2a     	stlr	w10, [x9]
     80c: 17ffff9f     	b	0x688 <iq4_f4_source_attach_on_ui_02+0x5c>
     810: 91066260     	add	x0, x19, #0x198
     814: 91038261     	add	x1, x19, #0xe0
     818: 94000000     	bl	0x818 <iq4_f4_source_attach_on_ui_02+0x1ec>
		0000000000000818:  R_AARCH64_CALL26	iq4_f4_native_subscribe_02
     81c: 34fffe00     	cbz	w0, 0x7dc <iq4_f4_source_attach_on_ui_02+0x1b0>
     820: 91038261     	add	x1, x19, #0xe0
     824: 91066262     	add	x2, x19, #0x198
     828: aa1303e0     	mov	x0, x19
     82c: 940000a5     	bl	0xac0 <exact_triple>
     830: 7100041f     	cmp	w0, #0x1
     834: 54fffd41     	b.ne	0x7dc <iq4_f4_source_attach_on_ui_02+0x1b0>
     838: 52800028     	mov	w8, #0x1                // =1
     83c: b901e668     	str	w8, [x19, #0x1e4]
     840: 17ffff99     	b	0x6a4 <iq4_f4_source_attach_on_ui_02+0x78>

0000000000000844 <on_ui>:
     844: d28a4649     	mov	x9, #0x5232             // =21042
     848: f9400008     	ldr	x8, [x0]
     84c: f2a68a69     	movk	x9, #0x3453, lsl #16
     850: f2c688c9     	movk	x9, #0x3446, lsl #32
     854: f2e92a29     	movk	x9, #0x4951, lsl #48
     858: eb09011f     	cmp	x8, x9
     85c: 54000381     	b.ne	0x8cc <on_ui+0x88>
     860: d10243ff     	sub	sp, sp, #0x90
     864: a9077bfd     	stp	x29, x30, [sp, #0x70]
     868: f90043f3     	str	x19, [sp, #0x80]
     86c: 9101c3fd     	add	x29, sp, #0x70
     870: aa0003f3     	mov	x19, x0
     874: 94000000     	bl	0x874 <on_ui+0x30>
		0000000000000874:  R_AARCH64_CALL26	iq4_f4_native_tid_02
     878: f9402a68     	ldr	x8, [x19, #0x50]
     87c: eb08001f     	cmp	x0, x8
     880: 540001c1     	b.ne	0x8b8 <on_ui+0x74>
     884: 9100e3e1     	add	x1, sp, #0x38
     888: aa1303e0     	mov	x0, x19
     88c: 97fffe63     	bl	0x218 <owner>
     890: 34000160     	cbz	w0, 0x8bc <on_ui+0x78>
     894: 910003e1     	mov	x1, sp
     898: aa1303e0     	mov	x0, x19
     89c: 97fffe5f     	bl	0x218 <owner>
     8a0: 340000e0     	cbz	w0, 0x8bc <on_ui+0x78>
     8a4: 9100e3e0     	add	x0, sp, #0x38
     8a8: 910003e1     	mov	x1, sp
     8ac: 52800702     	mov	w2, #0x38               // =56
     8b0: 94000000     	bl	0x8b0 <on_ui+0x6c>
		00000000000008b0:  R_AARCH64_CALL26	memcmp
     8b4: 34000100     	cbz	w0, 0x8d4 <on_ui+0x90>
     8b8: 2a1f03e0     	mov	w0, wzr
     8bc: a9477bfd     	ldp	x29, x30, [sp, #0x70]
     8c0: f94043f3     	ldr	x19, [sp, #0x80]
     8c4: 910243ff     	add	sp, sp, #0x90
     8c8: d65f03c0     	ret
     8cc: 2a1f03e0     	mov	w0, wzr
     8d0: d65f03c0     	ret
     8d4: 9100e3e0     	add	x0, sp, #0x38
     8d8: 91006261     	add	x1, x19, #0x18
     8dc: 52800702     	mov	w2, #0x38               // =56
     8e0: 94000000     	bl	0x8e0 <on_ui+0x9c>
		00000000000008e0:  R_AARCH64_CALL26	memcmp
     8e4: 7100001f     	cmp	w0, #0x0
     8e8: 1a9f17e0     	cset	w0, eq
     8ec: 17fffff4     	b	0x8bc <on_ui+0x78>

00000000000008f0 <destroy>:
     8f0: b4000100     	cbz	x0, 0x910 <destroy+0x20>
     8f4: f9400c08     	ldr	x8, [x0, #0x18]
     8f8: b40000c8     	cbz	x8, 0x910 <destroy+0x20>
     8fc: 91032109     	add	x9, x8, #0xc8
     900: 91033108     	add	x8, x8, #0xcc
     904: 5280002a     	mov	w10, #0x1               // =1
     908: 889ffd3f     	stlr	wzr, [x9]
     90c: 889ffd0a     	stlr	w10, [x8]
     910: d65f03c0     	ret

0000000000000914 <notified>:
     914: b4000580     	cbz	x0, 0x9c4 <notified+0xb0>
     918: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
     91c: f9000bf5     	str	x21, [sp, #0x10]
     920: a9024ff4     	stp	x20, x19, [sp, #0x20]
     924: 910003fd     	mov	x29, sp
     928: f9400c13     	ldr	x19, [x0, #0x18]
     92c: b4000473     	cbz	x19, 0x9b8 <notified+0xa4>
     930: 91034274     	add	x20, x19, #0xd0
     934: 885ffe88     	ldaxr	w8, [x20]
     938: 11000508     	add	w8, w8, #0x1
     93c: 8809fe88     	stlxr	w9, w8, [x20]
     940: 35ffffa9     	cbnz	w9, 0x934 <notified+0x20>
     944: d28a464a     	mov	x10, #0x5232            // =21042
     948: f9428268     	ldr	x8, [x19, #0x500]
     94c: f9400269     	ldr	x9, [x19]
     950: f2a68a6a     	movk	x10, #0x3453, lsl #16
     954: f2c688ca     	movk	x10, #0x3446, lsl #32
     958: 91000508     	add	x8, x8, #0x1
     95c: f2e92a2a     	movk	x10, #0x4951, lsl #48
     960: f9028268     	str	x8, [x19, #0x500]
     964: eb0a013f     	cmp	x9, x10
     968: 54000101     	b.ne	0x988 <notified+0x74>
     96c: aa1303e0     	mov	x0, x19
     970: aa0103f5     	mov	x21, x1
     974: 97ffffb4     	bl	0x844 <on_ui>
     978: 34000080     	cbz	w0, 0x988 <notified+0x74>
     97c: f9402669     	ldr	x9, [x19, #0x48]
     980: eb0902bf     	cmp	x21, x9
     984: 54000220     	b.eq	0x9c8 <notified+0xb4>
     988: f9429e68     	ldr	x8, [x19, #0x538]
     98c: 91032269     	add	x9, x19, #0xc8
     990: 5280002a     	mov	w10, #0x1               // =1
     994: 91000508     	add	x8, x8, #0x1
     998: f9029e68     	str	x8, [x19, #0x538]
     99c: 91033268     	add	x8, x19, #0xcc
     9a0: 889ffd3f     	stlr	wzr, [x9]
     9a4: 889ffd0a     	stlr	w10, [x8]
     9a8: 885f7e88     	ldxr	w8, [x20]
     9ac: 51000508     	sub	w8, w8, #0x1
     9b0: 8809fe88     	stlxr	w9, w8, [x20]
     9b4: 35ffffa9     	cbnz	w9, 0x9a8 <notified+0x94>
     9b8: a9424ff4     	ldp	x20, x19, [sp, #0x20]
     9bc: f9400bf5     	ldr	x21, [sp, #0x10]
     9c0: a8c37bfd     	ldp	x29, x30, [sp], #0x30
     9c4: d65f03c0     	ret
     9c8: 91032268     	add	x8, x19, #0xc8
     9cc: 88dffd08     	ldar	w8, [x8]
     9d0: 34fffec8     	cbz	w8, 0x9a8 <notified+0x94>
     9d4: 91033268     	add	x8, x19, #0xcc
     9d8: 88dffd08     	ldar	w8, [x8]
     9dc: 35fffe68     	cbnz	w8, 0x9a8 <notified+0x94>
     9e0: f940fa68     	ldr	x8, [x19, #0x1f0]
     9e4: b4000168     	cbz	x8, 0xa10 <notified+0xfc>
     9e8: f940fe60     	ldr	x0, [x19, #0x1f8]
     9ec: d63f0100     	blr	x8
     9f0: 340001c0     	cbz	w0, 0xa28 <notified+0x114>
     9f4: 7100041f     	cmp	w0, #0x1
     9f8: 540000c1     	b.ne	0xa10 <notified+0xfc>
     9fc: aa1303e0     	mov	x0, x19
     a00: 52800021     	mov	w1, #0x1                // =1
     a04: aa1f03e2     	mov	x2, xzr
     a08: 9400011b     	bl	0xe74 <sample>
     a0c: 17ffffe7     	b	0x9a8 <notified+0x94>
     a10: 91032268     	add	x8, x19, #0xc8
     a14: 91033269     	add	x9, x19, #0xcc
     a18: 5280002a     	mov	w10, #0x1               // =1
     a1c: 889ffd1f     	stlr	wzr, [x8]
     a20: 889ffd2a     	stlr	w10, [x9]
     a24: 17ffffe1     	b	0x9a8 <notified+0x94>
     a28: aa1303e0     	mov	x0, x19
     a2c: 94000000     	bl	0xa2c <notified+0x118>
		0000000000000a2c:  R_AARCH64_CALL26	iq4_f4_source_request_stop_02
     a30: 17ffffde     	b	0x9a8 <notified+0x94>

0000000000000a34 <control_notified>:
     a34: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
     a38: a9014ff4     	stp	x20, x19, [sp, #0x10]
     a3c: 910003fd     	mov	x29, sp
     a40: b40003a0     	cbz	x0, 0xab4 <control_notified+0x80>
     a44: f9400c13     	ldr	x19, [x0, #0x18]
     a48: b4000373     	cbz	x19, 0xab4 <control_notified+0x80>
     a4c: aa1303e0     	mov	x0, x19
     a50: aa0103f4     	mov	x20, x1
     a54: 97ffff7c     	bl	0x844 <on_ui>
     a58: 34000240     	cbz	w0, 0xaa0 <control_notified+0x6c>
     a5c: 91038268     	add	x8, x19, #0xe0
     a60: eb08029f     	cmp	x20, x8
     a64: 540001e1     	b.ne	0xaa0 <control_notified+0x6c>
     a68: 9107a268     	add	x8, x19, #0x1e8
     a6c: 88dffd08     	ldar	w8, [x8]
     a70: 34000068     	cbz	w8, 0xa7c <control_notified+0x48>
     a74: aa1303e0     	mov	x0, x19
     a78: 94000000     	bl	0xa78 <control_notified+0x44>
		0000000000000a78:  R_AARCH64_CALL26	iq4_f4_source_stop_on_ui_02
     a7c: 91033268     	add	x8, x19, #0xcc
     a80: 88dffd08     	ldar	w8, [x8]
     a84: 35000188     	cbnz	w8, 0xab4 <control_notified+0x80>
     a88: f9410661     	ldr	x1, [x19, #0x208]
     a8c: b4000141     	cbz	x1, 0xab4 <control_notified+0x80>
     a90: f9410a60     	ldr	x0, [x19, #0x210]
     a94: a9414ff4     	ldp	x20, x19, [sp, #0x10]
     a98: a8c27bfd     	ldp	x29, x30, [sp], #0x20
     a9c: d61f0020     	br	x1
     aa0: 91032268     	add	x8, x19, #0xc8
     aa4: 91033269     	add	x9, x19, #0xcc
     aa8: 5280002a     	mov	w10, #0x1               // =1
     aac: 889ffd1f     	stlr	wzr, [x8]
     ab0: 889ffd2a     	stlr	w10, [x9]
     ab4: a9414ff4     	ldp	x20, x19, [sp, #0x10]
     ab8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
     abc: d65f03c0     	ret

0000000000000ac0 <exact_triple>:
     ac0: d10303ff     	sub	sp, sp, #0xc0
     ac4: a9067bfd     	stp	x29, x30, [sp, #0x60]
     ac8: a9076ffc     	stp	x28, x27, [sp, #0x70]
     acc: a90867fa     	stp	x26, x25, [sp, #0x80]
     ad0: a9095ff8     	stp	x24, x23, [sp, #0x90]
     ad4: a90a57f6     	stp	x22, x21, [sp, #0xa0]
     ad8: a90b4ff4     	stp	x20, x19, [sp, #0xb0]
     adc: 910183fd     	add	x29, sp, #0x60
     ae0: aa0203f3     	mov	x19, x2
     ae4: aa0103f4     	mov	x20, x1
     ae8: aa0003f5     	mov	x21, x0
     aec: 97ffff56     	bl	0x844 <on_ui>
     af0: 34000600     	cbz	w0, 0xbb0 <exact_triple+0xf0>
     af4: a94082a8     	ldp	x8, x0, [x21, #0x8]
     af8: 528a7816     	mov	w22, #0x53c0            // =21440
     afc: 72a01eb6     	movk	w22, #0xf5, lsl #16
     b00: 910013e2     	add	x2, sp, #0x4
     b04: 52800083     	mov	w3, #0x4                // =4
     b08: b27c02c1     	orr	x1, x22, #0x10
     b0c: d63f0100     	blr	x8
     b10: 7100041f     	cmp	w0, #0x1
     b14: 12800000     	mov	w0, #-0x1               // =-1
     b18: 540004e1     	b.ne	0xbb4 <exact_triple+0xf4>
     b1c: b94007e8     	ldr	w8, [sp, #0x4]
     b20: 7100051f     	cmp	w8, #0x1
     b24: 54000481     	b.ne	0xbb4 <exact_triple+0xf4>
     b28: a94082a8     	ldp	x8, x0, [x21, #0x8]
     b2c: d10062c1     	sub	x1, x22, #0x18
     b30: 910023e2     	add	x2, sp, #0x8
     b34: 52800103     	mov	w3, #0x8                // =8
     b38: d63f0100     	blr	x8
     b3c: 7100041f     	cmp	w0, #0x1
     b40: 12800000     	mov	w0, #-0x1               // =-1
     b44: 54000381     	b.ne	0xbb4 <exact_triple+0xf4>
     b48: f94007e8     	ldr	x8, [sp, #0x8]
     b4c: b4000348     	cbz	x8, 0xbb4 <exact_triple+0xf4>
     b50: 528a7800     	mov	w0, #0x53c0             // =21440
     b54: 910003e1     	mov	x1, sp
     b58: 72a01ea0     	movk	w0, #0xf5, lsl #16
     b5c: 94000000     	bl	0xb5c <exact_triple+0x9c>
		0000000000000b5c:  R_AARCH64_CALL26	iq4_f4_native_trylock_02
     b60: 2a0003e8     	mov	w8, w0
     b64: 12800000     	mov	w0, #-0x1               // =-1
     b68: 34000268     	cbz	w8, 0xbb4 <exact_triple+0xf4>
     b6c: b94003e8     	ldr	w8, [sp]
     b70: 35000228     	cbnz	w8, 0xbb4 <exact_triple+0xf4>
     b74: f9400eb7     	ldr	x23, [x21, #0x18]
     b78: 910222f6     	add	x22, x23, #0x88
     b7c: d343fec8     	lsr	x8, x22, #3
     b80: f108051f     	cmp	x8, #0x201
     b84: 54000282     	b.hs	0xbd4 <exact_triple+0x114>
     b88: 1280001b     	mov	w27, #-0x1              // =-1
     b8c: 528a7800     	mov	w0, #0x53c0             // =21440
     b90: 910003e1     	mov	x1, sp
     b94: 72a01ea0     	movk	w0, #0xf5, lsl #16
     b98: 94000000     	bl	0xb98 <exact_triple+0xd8>
		0000000000000b98:  R_AARCH64_CALL26	iq4_f4_native_mutex_unlock_02
     b9c: b94003e8     	ldr	w8, [sp]
     ba0: 7100011f     	cmp	w8, #0x0
     ba4: 7a400804     	ccmp	w0, #0x0, #0x4, eq
     ba8: 5a9f1360     	csinv	w0, w27, wzr, ne
     bac: 14000002     	b	0xbb4 <exact_triple+0xf4>
     bb0: 12800000     	mov	w0, #-0x1               // =-1
     bb4: a94b4ff4     	ldp	x20, x19, [sp, #0xb0]
     bb8: a94a57f6     	ldp	x22, x21, [sp, #0xa0]
     bbc: a9495ff8     	ldp	x24, x23, [sp, #0x90]
     bc0: a94867fa     	ldp	x26, x25, [sp, #0x80]
     bc4: a9476ffc     	ldp	x28, x27, [sp, #0x70]
     bc8: a9467bfd     	ldp	x29, x30, [sp, #0x60]
     bcc: 910303ff     	add	sp, sp, #0xc0
     bd0: d65f03c0     	ret
     bd4: a94082a8     	ldp	x8, x0, [x21, #0x8]
     bd8: 910202e1     	add	x1, x23, #0x80
     bdc: d10023a2     	sub	x2, x29, #0x8
     be0: 52800103     	mov	w3, #0x8                // =8
     be4: d63f0100     	blr	x8
     be8: 910242e8     	add	x8, x23, #0x90
     bec: 1280001b     	mov	w27, #-0x1              // =-1
     bf0: d343fd08     	lsr	x8, x8, #3
     bf4: f108051f     	cmp	x8, #0x201
     bf8: 54fffca3     	b.lo	0xb8c <exact_triple+0xcc>
     bfc: 7100041f     	cmp	w0, #0x1
     c00: 54fffc61     	b.ne	0xb8c <exact_triple+0xcc>
     c04: a94082a8     	ldp	x8, x0, [x21, #0x8]
     c08: d10043a2     	sub	x2, x29, #0x10
     c0c: aa1603e1     	mov	x1, x22
     c10: 52800103     	mov	w3, #0x8                // =8
     c14: d63f0100     	blr	x8
     c18: 7100041f     	cmp	w0, #0x1
     c1c: 54fffb81     	b.ne	0xb8c <exact_triple+0xcc>
     c20: f85f83a1     	ldur	x1, [x29, #-0x8]
     c24: 9101e2f7     	add	x23, x23, #0x78
     c28: eb17003f     	cmp	x1, x23
     c2c: 540000e1     	b.ne	0xc48 <exact_triple+0x188>
     c30: 2a1f03f6     	mov	w22, wzr
     c34: aa1703fc     	mov	x28, x23
     c38: f85f03a8     	ldur	x8, [x29, #-0x10]
     c3c: eb08039f     	cmp	x28, x8
     c40: 5a9f02db     	csinv	w27, w22, wzr, eq
     c44: 17ffffd2     	b	0xb8c <exact_triple+0xcc>
     c48: 5287971a     	mov	w26, #0x3cb8            // =15544
     c4c: 2a1f03f6     	mov	w22, wzr
     c50: 52820038     	mov	w24, #0x1001            // =4097
     c54: 52920039     	mov	w25, #0x9001            // =36865
     c58: 72a0185a     	movk	w26, #0xc2, lsl #16
     c5c: aa1703fc     	mov	x28, x23
     c60: 8b190028     	add	x8, x1, x25
     c64: 1280001b     	mov	w27, #-0x1              // =-1
     c68: f140291f     	cmp	x8, #0xa, lsl #12       // =0xa000
     c6c: 54fff909     	b.ls	0xb8c <exact_triple+0xcc>
     c70: 92400828     	and	x8, x1, #0x7
     c74: b5fff8c8     	cbnz	x8, 0xb8c <exact_triple+0xcc>
     c78: 71000718     	subs	w24, w24, #0x1
     c7c: 54fff880     	b.eq	0xb8c <exact_triple+0xcc>
     c80: a94082a8     	ldp	x8, x0, [x21, #0x8]
     c84: 9100a3e2     	add	x2, sp, #0x28
     c88: 52800403     	mov	w3, #0x20               // =32
     c8c: d63f0100     	blr	x8
     c90: 7100041f     	cmp	w0, #0x1
     c94: 54fff7c1     	b.ne	0xb8c <exact_triple+0xcc>
     c98: f94017e8     	ldr	x8, [sp, #0x28]
     c9c: eb1a011f     	cmp	x8, x26
     ca0: 54fff761     	b.ne	0xb8c <exact_triple+0xcc>
     ca4: f9401fe8     	ldr	x8, [sp, #0x38]
     ca8: eb1c011f     	cmp	x8, x28
     cac: 54fff701     	b.ne	0xb8c <exact_triple+0xcc>
     cb0: f9401be8     	ldr	x8, [sp, #0x30]
     cb4: 8b190109     	add	x9, x8, x25
     cb8: f140293f     	cmp	x9, #0xa, lsl #12       // =0xa000
     cbc: 54fff689     	b.ls	0xb8c <exact_triple+0xcc>
     cc0: 92400909     	and	x9, x8, #0x7
     cc4: b5fff649     	cbnz	x9, 0xb8c <exact_triple+0xcc>
     cc8: f94023e9     	ldr	x9, [sp, #0x40]
     ccc: 8b19012a     	add	x10, x9, x25
     cd0: f140295f     	cmp	x10, #0xa, lsl #12      // =0xa000
     cd4: 54fff5c9     	b.ls	0xb8c <exact_triple+0xcc>
     cd8: 9240092a     	and	x10, x9, #0x7
     cdc: b5fff58a     	cbnz	x10, 0xb8c <exact_triple+0xcc>
     ce0: f85f83aa     	ldur	x10, [x29, #-0x8]
     ce4: 9101a129     	add	x9, x9, #0x68
     ce8: eb09015f     	cmp	x10, x9
     cec: 54fff501     	b.ne	0xb8c <exact_triple+0xcc>
     cf0: a94082a9     	ldp	x9, x0, [x21, #0x8]
     cf4: 91004101     	add	x1, x8, #0x10
     cf8: d10063a2     	sub	x2, x29, #0x18
     cfc: 52800103     	mov	w3, #0x8                // =8
     d00: d63f0120     	blr	x9
     d04: 7100041f     	cmp	w0, #0x1
     d08: 54fff421     	b.ne	0xb8c <exact_triple+0xcc>
     d0c: f85e83a8     	ldur	x8, [x29, #-0x18]
     d10: f85f83a9     	ldur	x9, [x29, #-0x8]
     d14: eb09011f     	cmp	x8, x9
     d18: 54fff3a1     	b.ne	0xb8c <exact_triple+0xcc>
     d1c: f94023e8     	ldr	x8, [sp, #0x40]
     d20: 91004109     	add	x9, x8, #0x10
     d24: d343fd29     	lsr	x9, x9, #3
     d28: f108053f     	cmp	x9, #0x201
     d2c: 54fff303     	b.lo	0xb8c <exact_triple+0xcc>
     d30: a94082a9     	ldp	x9, x0, [x21, #0x8]
     d34: 91002101     	add	x1, x8, #0x8
     d38: 910083e2     	add	x2, sp, #0x20
     d3c: 52800103     	mov	w3, #0x8                // =8
     d40: d63f0120     	blr	x9
     d44: 7100041f     	cmp	w0, #0x1
     d48: 54fff221     	b.ne	0xb8c <exact_triple+0xcc>
     d4c: f94023e8     	ldr	x8, [sp, #0x40]
     d50: 9100e109     	add	x9, x8, #0x38
     d54: d343fd29     	lsr	x9, x9, #3
     d58: f108053f     	cmp	x9, #0x201
     d5c: 54fff183     	b.lo	0xb8c <exact_triple+0xcc>
     d60: a94082a9     	ldp	x9, x0, [x21, #0x8]
     d64: 9100c101     	add	x1, x8, #0x30
     d68: 910063e2     	add	x2, sp, #0x18
     d6c: 52800103     	mov	w3, #0x8                // =8
     d70: d63f0120     	blr	x9
     d74: 7100041f     	cmp	w0, #0x1
     d78: 54fff0a1     	b.ne	0xb8c <exact_triple+0xcc>
     d7c: f9400fe8     	ldr	x8, [sp, #0x18]
     d80: f9400ea9     	ldr	x9, [x21, #0x18]
     d84: eb09011f     	cmp	x8, x9
     d88: 54fff021     	b.ne	0xb8c <exact_triple+0xcc>
     d8c: f94023e8     	ldr	x8, [sp, #0x40]
     d90: 91012109     	add	x9, x8, #0x48
     d94: d343fd29     	lsr	x9, x9, #3
     d98: f108053f     	cmp	x9, #0x201
     d9c: 54ffef83     	b.lo	0xb8c <exact_triple+0xcc>
     da0: a94082a9     	ldp	x9, x0, [x21, #0x8]
     da4: 91010101     	add	x1, x8, #0x40
     da8: 910043e2     	add	x2, sp, #0x10
     dac: 52800103     	mov	w3, #0x8                // =8
     db0: d63f0120     	blr	x9
     db4: 7100041f     	cmp	w0, #0x1
     db8: 54ffeea1     	b.ne	0xb8c <exact_triple+0xcc>
     dbc: f94013e8     	ldr	x8, [sp, #0x20]
     dc0: eb14011f     	cmp	x8, x20
     dc4: 540000c1     	b.ne	0xddc <exact_triple+0x31c>
     dc8: f9400be8     	ldr	x8, [sp, #0x10]
     dcc: eb13011f     	cmp	x8, x19
     dd0: 54000061     	b.ne	0xddc <exact_triple+0x31c>
     dd4: 35ffedd6     	cbnz	w22, 0xb8c <exact_triple+0xcc>
     dd8: 52800036     	mov	w22, #0x1               // =1
     ddc: f9401be1     	ldr	x1, [sp, #0x30]
     de0: f85f83bc     	ldur	x28, [x29, #-0x8]
     de4: eb17003f     	cmp	x1, x23
     de8: f81f83a1     	stur	x1, [x29, #-0x8]
     dec: 54fff3a1     	b.ne	0xc60 <exact_triple+0x1a0>
     df0: 17ffff92     	b	0xc38 <exact_triple+0x178>

0000000000000df4 <iq4_f4_source_measure_on_ui_02>:
     df4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
     df8: a9014ff4     	stp	x20, x19, [sp, #0x10]
     dfc: 910003fd     	mov	x29, sp
     e00: aa0003f3     	mov	x19, x0
     e04: 52800040     	mov	w0, #0x2                // =2
     e08: b4000253     	cbz	x19, 0xe50 <iq4_f4_source_measure_on_ui_02+0x5c>
     e0c: b4000221     	cbz	x1, 0xe50 <iq4_f4_source_measure_on_ui_02+0x5c>
     e10: aa1303e0     	mov	x0, x19
     e14: aa0103f4     	mov	x20, x1
     e18: 97fffe8b     	bl	0x844 <on_ui>
     e1c: 34000180     	cbz	w0, 0xe4c <iq4_f4_source_measure_on_ui_02+0x58>
     e20: 91033268     	add	x8, x19, #0xcc
     e24: 88dffd08     	ldar	w8, [x8]
     e28: 34000068     	cbz	w8, 0xe34 <iq4_f4_source_measure_on_ui_02+0x40>
     e2c: 528000a0     	mov	w0, #0x5                // =5
     e30: 14000008     	b	0xe50 <iq4_f4_source_measure_on_ui_02+0x5c>
     e34: 91032268     	add	x8, x19, #0xc8
     e38: 88dffd08     	ldar	w8, [x8]
     e3c: 35000088     	cbnz	w8, 0xe4c <iq4_f4_source_measure_on_ui_02+0x58>
     e40: 91034268     	add	x8, x19, #0xd0
     e44: 88dffd08     	ldar	w8, [x8]
     e48: 340000a8     	cbz	w8, 0xe5c <iq4_f4_source_measure_on_ui_02+0x68>
     e4c: 52800040     	mov	w0, #0x2                // =2
     e50: a9414ff4     	ldp	x20, x19, [sp, #0x10]
     e54: a8c27bfd     	ldp	x29, x30, [sp], #0x20
     e58: d65f03c0     	ret
     e5c: aa1303e0     	mov	x0, x19
     e60: aa1403e2     	mov	x2, x20
     e64: 2a1f03e1     	mov	w1, wzr
     e68: a9414ff4     	ldp	x20, x19, [sp, #0x10]
     e6c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
     e70: 14000001     	b	0xe74 <sample>

0000000000000e74 <sample>:
     e74: d10403ff     	sub	sp, sp, #0x100
     e78: a90a7bfd     	stp	x29, x30, [sp, #0xa0]
     e7c: f9005bfb     	str	x27, [sp, #0xb0]
     e80: a90c67fa     	stp	x26, x25, [sp, #0xc0]
     e84: a90d5ff8     	stp	x24, x23, [sp, #0xd0]
     e88: a90e57f6     	stp	x22, x21, [sp, #0xe0]
     e8c: a90f4ff4     	stp	x20, x19, [sp, #0xf0]
     e90: 910283fd     	add	x29, sp, #0xa0
     e94: 6f00e400     	movi	v0.2d, #0000000000000000
     e98: aa0203f4     	mov	x20, x2
     e9c: 2a0103f5     	mov	w21, w1
     ea0: f9402016     	ldr	x22, [x0, #0x40]
     ea4: d10013a1     	sub	x1, x29, #0x4
     ea8: d10043a2     	sub	x2, x29, #0x10
     eac: aa0003f3     	mov	x19, x0
     eb0: ad0083e0     	stp	q0, q0, [sp, #0x10]
     eb4: ad0183e0     	stp	q0, q0, [sp, #0x30]
     eb8: 9400027b     	bl	0x18a4 <live>
     ebc: 34000100     	cbz	w0, 0xedc <sample+0x68>
     ec0: d10043b8     	sub	x24, x29, #0x10
     ec4: f9400308     	ldr	x8, [x24]
     ec8: b4000128     	cbz	x8, 0xeec <sample+0x78>
     ecc: f9429a68     	ldr	x8, [x19, #0x530]
     ed0: 91000508     	add	x8, x8, #0x1
     ed4: f9029a68     	str	x8, [x19, #0x530]
     ed8: 1400000d     	b	0xf0c <sample+0x98>
     edc: f9429e68     	ldr	x8, [x19, #0x538]
     ee0: 91000508     	add	x8, x8, #0x1
     ee4: f9029e68     	str	x8, [x19, #0x538]
     ee8: 14000009     	b	0xf0c <sample+0x98>
     eec: 52844b88     	mov	w8, #0x225c             // =8796
     ef0: 8b0802c8     	add	x8, x22, x8
     ef4: d342fd08     	lsr	x8, x8, #2
     ef8: f110051f     	cmp	x8, #0x401
     efc: 540001a2     	b.hs	0xf30 <sample+0xbc>
     f00: f9429668     	ldr	x8, [x19, #0x528]
     f04: 91000508     	add	x8, x8, #0x1
     f08: f9029668     	str	x8, [x19, #0x528]
     f0c: 52800040     	mov	w0, #0x2                // =2
     f10: a94f4ff4     	ldp	x20, x19, [sp, #0xf0]
     f14: f9405bfb     	ldr	x27, [sp, #0xb0]
     f18: a94e57f6     	ldp	x22, x21, [sp, #0xe0]
     f1c: a94d5ff8     	ldp	x24, x23, [sp, #0xd0]
     f20: a94c67fa     	ldp	x26, x25, [sp, #0xc0]
     f24: a94a7bfd     	ldp	x29, x30, [sp, #0xa0]
     f28: 910403ff     	add	sp, sp, #0x100
     f2c: d65f03c0     	ret
     f30: a9408268     	ldp	x8, x0, [x19, #0x8]
     f34: 52844b17     	mov	w23, #0x2258            // =8792
     f38: 8b1702c1     	add	x1, x22, x23
     f3c: d10093a2     	sub	x2, x29, #0x24
     f40: 52800083     	mov	w3, #0x4                // =4
     f44: d63f0100     	blr	x8
     f48: 7100041f     	cmp	w0, #0x1
     f4c: 54fffda1     	b.ne	0xf00 <sample+0x8c>
     f50: b85dc3a8     	ldur	w8, [x29, #-0x24]
     f54: 7100111f     	cmp	w8, #0x4
     f58: 54fffd41     	b.ne	0xf00 <sample+0x8c>
     f5c: 52844a88     	mov	w8, #0x2254             // =8788
     f60: 8b0802c1     	add	x1, x22, x8
     f64: f140043f     	cmp	x1, #0x1, lsl #12       // =0x1000
     f68: 54fffcc3     	b.lo	0xf00 <sample+0x8c>
     f6c: a9408268     	ldp	x8, x0, [x19, #0x8]
     f70: d100e3a2     	sub	x2, x29, #0x38
     f74: 52800083     	mov	w3, #0x4                // =4
     f78: d63f0100     	blr	x8
     f7c: 7100041f     	cmp	w0, #0x1
     f80: 54fffc01     	b.ne	0xf00 <sample+0x8c>
     f84: b85c83a8     	ldur	w8, [x29, #-0x38]
     f88: 7100111f     	cmp	w8, #0x4
     f8c: 54fffba2     	b.hs	0xf00 <sample+0x8c>
     f90: f9401e60     	ldr	x0, [x19, #0x38]
     f94: b85fc3a1     	ldur	w1, [x29, #-0x4]
     f98: d10063a2     	sub	x2, x29, #0x18
     f9c: 94000000     	bl	0xf9c <sample+0x128>
		0000000000000f9c:  R_AARCH64_CALL26	iq4_f4_native_lock_02
     fa0: 340027a0     	cbz	w0, 0x1494 <sample+0x620>
     fa4: a9408268     	ldp	x8, x0, [x19, #0x8]
     fa8: 8b1702c1     	add	x1, x22, x23
     fac: d100a3a2     	sub	x2, x29, #0x28
     fb0: 52800083     	mov	w3, #0x4                // =4
     fb4: d63f0100     	blr	x8
     fb8: 7100041f     	cmp	w0, #0x1
     fbc: 540026c1     	b.ne	0x1494 <sample+0x620>
     fc0: b85d83a8     	ldur	w8, [x29, #-0x28]
     fc4: 71000d1f     	cmp	w8, #0x3
     fc8: 54002668     	b.hi	0x1494 <sample+0x620>
     fcc: 52844d08     	mov	w8, #0x2268             // =8808
     fd0: 8b0802c8     	add	x8, x22, x8
     fd4: d342fd08     	lsr	x8, x8, #2
     fd8: f110051f     	cmp	x8, #0x401
     fdc: 540025c3     	b.lo	0x1494 <sample+0x620>
     fe0: a9408268     	ldp	x8, x0, [x19, #0x8]
     fe4: 52844c99     	mov	w25, #0x2264            // =8804
     fe8: 8b1902c1     	add	x1, x22, x25
     fec: d100b3a2     	sub	x2, x29, #0x2c
     ff0: 52800083     	mov	w3, #0x4                // =4
     ff4: d63f0100     	blr	x8
     ff8: 7100041f     	cmp	w0, #0x1
     ffc: 540024c1     	b.ne	0x1494 <sample+0x620>
    1000: f9401e60     	ldr	x0, [x19, #0x38]
    1004: d10103a1     	sub	x1, x29, #0x40
    1008: 94000000     	bl	0x1008 <sample+0x194>
		0000000000001008:  R_AARCH64_CALL26	iq4_f4_native_size_02
    100c: 34001ba0     	cbz	w0, 0x1380 <sample+0x50c>
    1010: f9401e60     	ldr	x0, [x19, #0x38]
    1014: d100c3a1     	sub	x1, x29, #0x30
    1018: 94000000     	bl	0x1018 <sample+0x1a4>
		0000000000001018:  R_AARCH64_CALL26	iq4_f4_native_id_02
    101c: 34001b20     	cbz	w0, 0x1380 <sample+0x50c>
    1020: d10023a1     	sub	x1, x29, #0x8
    1024: d10043a2     	sub	x2, x29, #0x10
    1028: aa1303e0     	mov	x0, x19
    102c: 9400021e     	bl	0x18a4 <live>
    1030: 34001a80     	cbz	w0, 0x1380 <sample+0x50c>
    1034: 297f27a8     	ldp	w8, w9, [x29, #-0x8]
    1038: 6b09011f     	cmp	w8, w9
    103c: 52800048     	mov	w8, #0x2                // =2
    1040: 54001a21     	b.ne	0x1384 <sample+0x510>
    1044: f9400309     	ldr	x9, [x24]
    1048: b50019e9     	cbnz	x9, 0x1384 <sample+0x510>
    104c: b85d83a8     	ldur	w8, [x29, #-0x28]
    1050: 52843009     	mov	w9, #0x2180             // =8576
    1054: 8b0902da     	add	x26, x22, x9
    1058: 531d7108     	lsl	w8, w8, #3
    105c: 8b080341     	add	x1, x26, x8
    1060: 91002028     	add	x8, x1, #0x8
    1064: d343fd08     	lsr	x8, x8, #3
    1068: f108051f     	cmp	x8, #0x201
    106c: 540018a3     	b.lo	0x1380 <sample+0x50c>
    1070: a9408268     	ldp	x8, x0, [x19, #0x8]
    1074: d10083a2     	sub	x2, x29, #0x20
    1078: 52800103     	mov	w3, #0x8                // =8
    107c: d63f0100     	blr	x8
    1080: 7100041f     	cmp	w0, #0x1
    1084: 540017e1     	b.ne	0x1380 <sample+0x50c>
    1088: a97e27a8     	ldp	x8, x9, [x29, #-0x20]
    108c: eb09011f     	cmp	x8, x9
    1090: 54001781     	b.ne	0x1380 <sample+0x50c>
    1094: 52800048     	mov	w8, #0x2                // =2
    1098: b4001769     	cbz	x9, 0x1384 <sample+0x510>
    109c: b85d83a8     	ldur	w8, [x29, #-0x28]
    10a0: 52843909     	mov	w9, #0x21c8             // =8648
    10a4: 531d7108     	lsl	w8, w8, #3
    10a8: 8b0802c8     	add	x8, x22, x8
    10ac: 8b090109     	add	x9, x8, x9
    10b0: d343fd29     	lsr	x9, x9, #3
    10b4: f108053f     	cmp	x9, #0x201
    10b8: 54001643     	b.lo	0x1380 <sample+0x50c>
    10bc: a9408269     	ldp	x9, x0, [x19, #0x8]
    10c0: 5284380a     	mov	w10, #0x21c0            // =8640
    10c4: 8b0a0101     	add	x1, x8, x10
    10c8: d10123a2     	sub	x2, x29, #0x48
    10cc: 52800103     	mov	w3, #0x8                // =8
    10d0: d63f0120     	blr	x9
    10d4: 7100041f     	cmp	w0, #0x1
    10d8: 54001541     	b.ne	0x1380 <sample+0x50c>
    10dc: a97ba7a8     	ldp	x8, x9, [x29, #-0x48]
    10e0: eb09011f     	cmp	x8, x9
    10e4: 540014e1     	b.ne	0x1380 <sample+0x50c>
    10e8: 297a27a8     	ldp	w8, w9, [x29, #-0x30]
    10ec: 6b09011f     	cmp	w8, w9
    10f0: 54001481     	b.ne	0x1380 <sample+0x50c>
    10f4: a9408268     	ldp	x8, x0, [x19, #0x8]
    10f8: 8b1702c1     	add	x1, x22, x23
    10fc: d100d3a2     	sub	x2, x29, #0x34
    1100: 52800083     	mov	w3, #0x4                // =4
    1104: d63f0100     	blr	x8
    1108: 7100041f     	cmp	w0, #0x1
    110c: 540013a1     	b.ne	0x1380 <sample+0x50c>
    1110: b85cc3a8     	ldur	w8, [x29, #-0x34]
    1114: b85d83a9     	ldur	w9, [x29, #-0x28]
    1118: 6b09011f     	cmp	w8, w9
    111c: 54001321     	b.ne	0x1380 <sample+0x50c>
    1120: a9408268     	ldp	x8, x0, [x19, #0x8]
    1124: 8b1902c1     	add	x1, x22, x25
    1128: d100d3a2     	sub	x2, x29, #0x34
    112c: 52800083     	mov	w3, #0x4                // =4
    1130: d63f0100     	blr	x8
    1134: 7100041f     	cmp	w0, #0x1
    1138: 54001241     	b.ne	0x1380 <sample+0x50c>
    113c: b85cc3a8     	ldur	w8, [x29, #-0x34]
    1140: b85d43a9     	ldur	w9, [x29, #-0x2c]
    1144: 6b09011f     	cmp	w8, w9
    1148: 540011c1     	b.ne	0x1380 <sample+0x50c>
    114c: f85c03a9     	ldur	x9, [x29, #-0x40]
    1150: b85d83ac     	ldur	w12, [x29, #-0x28]
    1154: 129fffcb     	mov	w11, #-0xffff           // =-65535
    1158: d360fd2a     	lsr	x10, x9, #32
    115c: 5140412d     	sub	w13, w9, #0x10, lsl #12 // =0x10000
    1160: 290433e8     	stp	w8, w12, [sp, #0x20]
    1164: 6b0b01bf     	cmp	w13, w11
    1168: 29022be9     	stp	w9, w10, [sp, #0x10]
    116c: 540010a3     	b.lo	0x1380 <sample+0x50c>
    1170: 51404148     	sub	w8, w10, #0x10, lsl #12 // =0x10000
    1174: 6b0b011f     	cmp	w8, w11
    1178: 52800048     	mov	w8, #0x2                // =2
    117c: 54001043     	b.lo	0x1384 <sample+0x510>
    1180: 1b097d48     	mul	w8, w10, w9
    1184: b940766b     	ldr	w11, [x19, #0x74]
    1188: 8b284508     	add	x8, x8, w8, uxtw #1
    118c: eb0b011f     	cmp	x8, x11
    1190: 54000f88     	b.hi	0x1380 <sample+0x50c>
    1194: 0b090528     	add	w8, w9, w9, lsl #1
    1198: 1b0a7d09     	mul	w9, w8, w10
    119c: d344ff4a     	lsr	x10, x26, #4
    11a0: f104055f     	cmp	x10, #0x101
    11a4: 290327e8     	stp	w8, w9, [sp, #0x18]
    11a8: 54000ec3     	b.lo	0x1380 <sample+0x50c>
    11ac: a9408268     	ldp	x8, x0, [x19, #0x8]
    11b0: 52842e09     	mov	w9, #0x2170             // =8560
    11b4: 910043fa     	add	x26, sp, #0x10
    11b8: 8b0902c1     	add	x1, x22, x9
    11bc: 52800203     	mov	w3, #0x10               // =16
    11c0: 91007342     	add	x2, x26, #0x1c
    11c4: d63f0100     	blr	x8
    11c8: 7100041f     	cmp	w0, #0x1
    11cc: 54000da1     	b.ne	0x1380 <sample+0x50c>
    11d0: a9408268     	ldp	x8, x0, [x19, #0x8]
    11d4: 52844809     	mov	w9, #0x2240             // =8768
    11d8: 8b0902c1     	add	x1, x22, x9
    11dc: 9100b342     	add	x2, x26, #0x2c
    11e0: 52800083     	mov	w3, #0x4                // =4
    11e4: d63f0100     	blr	x8
    11e8: 7100041f     	cmp	w0, #0x1
    11ec: 54000ca1     	b.ne	0x1380 <sample+0x50c>
    11f0: a9408268     	ldp	x8, x0, [x19, #0x8]
    11f4: 910043fa     	add	x26, sp, #0x10
    11f8: 52844889     	mov	w9, #0x2244             // =8772
    11fc: 9100c342     	add	x2, x26, #0x30
    1200: 52800083     	mov	w3, #0x4                // =4
    1204: 8b0902c1     	add	x1, x22, x9
    1208: d63f0100     	blr	x8
    120c: 7100041f     	cmp	w0, #0x1
    1210: 54000b81     	b.ne	0x1380 <sample+0x50c>
    1214: a9408268     	ldp	x8, x0, [x19, #0x8]
    1218: 52844909     	mov	w9, #0x2248             // =8776
    121c: 8b0902c1     	add	x1, x22, x9
    1220: 9100d342     	add	x2, x26, #0x34
    1224: 52800083     	mov	w3, #0x4                // =4
    1228: d63f0100     	blr	x8
    122c: 7100041f     	cmp	w0, #0x1
    1230: 54000a81     	b.ne	0x1380 <sample+0x50c>
    1234: 52844e08     	mov	w8, #0x2270             // =8816
    1238: 8b0802c8     	add	x8, x22, x8
    123c: d342fd08     	lsr	x8, x8, #2
    1240: f110051f     	cmp	x8, #0x401
    1244: 540009e3     	b.lo	0x1380 <sample+0x50c>
    1248: a9408268     	ldp	x8, x0, [x19, #0x8]
    124c: 910043e9     	add	x9, sp, #0x10
    1250: 52844d8a     	mov	w10, #0x226c            // =8812
    1254: 91006122     	add	x2, x9, #0x18
    1258: 52800083     	mov	w3, #0x4                // =4
    125c: 8b0a02c1     	add	x1, x22, x10
    1260: d63f0100     	blr	x8
    1264: 7100041f     	cmp	w0, #0x1
    1268: 540008c1     	b.ne	0x1380 <sample+0x50c>
    126c: 90000008     	adrp	x8, 0x1000 <sample+0x18c>
		000000000000126c:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst16+0x10
    1270: 3cc283e0     	ldur	q0, [sp, #0x28]
    1274: 3dc00101     	ldr	q1, [x8]
		0000000000001274:  R_AARCH64_LDST128_ABS_LO12_NC	.rodata.cst16+0x10
    1278: 6ea18c00     	cmeq	v0.4s, v0.4s, v1.4s
    127c: 6e205800     	mvn	v0.16b, v0.16b
    1280: 6eb0a800     	umaxv	s0, v0.4s
    1284: 1e260008     	fmov	w8, s0
    1288: 370007c8     	tbnz	w8, #0x0, 0x1380 <sample+0x50c>
    128c: b9403be8     	ldr	w8, [sp, #0x38]
    1290: 7103fd1f     	cmp	w8, #0xff
    1294: 54000761     	b.ne	0x1380 <sample+0x50c>
    1298: b9403fe9     	ldr	w9, [sp, #0x3c]
    129c: 34000729     	cbz	w9, 0x1380 <sample+0x50c>
    12a0: b94043eb     	ldr	w11, [sp, #0x40]
    12a4: 52800048     	mov	w8, #0x2                // =2
    12a8: 340006eb     	cbz	w11, 0x1384 <sample+0x510>
    12ac: b94047ea     	ldr	w10, [sp, #0x44]
    12b0: 529e0008     	mov	w8, #0xf000             // =61440
    12b4: 72a07fa8     	movk	w8, #0x3fd, lsl #16
    12b8: 6b08015f     	cmp	w10, w8
    12bc: 54000628     	b.hi	0x1380 <sample+0x50c>
    12c0: 9ba97d68     	umull	x8, w11, w9
    12c4: d37ff908     	lsl	x8, x8, #1
    12c8: 9ba92168     	umaddl	x8, w11, w9, x8
    12cc: eb0a011f     	cmp	x8, x10
    12d0: 52800048     	mov	w8, #0x2                // =2
    12d4: 54000581     	b.ne	0x1384 <sample+0x510>
    12d8: b9401fe9     	ldr	w9, [sp, #0x1c]
    12dc: 6b0a013f     	cmp	w9, w10
    12e0: 54000528     	b.hi	0x1384 <sample+0x510>
    12e4: f85e83a8     	ldur	x8, [x29, #-0x18]
    12e8: ab08013f     	cmn	x9, x8
    12ec: 540004a2     	b.hs	0x1380 <sample+0x50c>
    12f0: f940326a     	ldr	x10, [x19, #0x60]
    12f4: 8b090109     	add	x9, x8, x9
    12f8: eb0a013f     	cmp	x9, x10
    12fc: 540000a9     	b.ls	0x1310 <sample+0x49c>
    1300: f9403669     	ldr	x9, [x19, #0x68]
    1304: 8b0a0129     	add	x9, x9, x10
    1308: eb09011f     	cmp	x8, x9
    130c: 540003a3     	b.lo	0x1380 <sample+0x50c>
    1310: 94000000     	bl	0x1310 <sample+0x49c>
		0000000000001310:  R_AARCH64_CALL26	iq4_f4_native_clock_02
    1314: f90027e0     	str	x0, [sp, #0x48]
    1318: b40002e0     	cbz	x0, 0x1374 <sample+0x500>
    131c: b9421e7b     	ldr	w27, [x19, #0x21c]
    1320: 3400009b     	cbz	w27, 0x1330 <sample+0x4bc>
    1324: f9411668     	ldr	x8, [x19, #0x228]
    1328: eb08001f     	cmp	x0, x8
    132c: 54000249     	b.ls	0x1374 <sample+0x500>
    1330: 34000f55     	cbz	w21, 0x1518 <sample+0x6a4>
    1334: b9422268     	ldr	w8, [x19, #0x220]
    1338: 34000248     	cbz	w8, 0x1380 <sample+0x50c>
    133c: 910043e0     	add	x0, sp, #0x10
    1340: 910a0261     	add	x1, x19, #0x280
    1344: 94000309     	bl	0x1f68 <same_shape>
    1348: 340001c0     	cbz	w0, 0x1380 <sample+0x50c>
    134c: b85d43a8     	ldur	w8, [x29, #-0x2c]
    1350: b9422669     	ldr	w9, [x19, #0x224]
    1354: 6b09011a     	subs	w26, w8, w9
    1358: 34000e5b     	cbz	w27, 0x1520 <sample+0x6ac>
    135c: 54000e21     	b.ne	0x1520 <sample+0x6ac>
    1360: f9428a68     	ldr	x8, [x19, #0x510]
    1364: 91000508     	add	x8, x8, #0x1
    1368: f9028a68     	str	x8, [x19, #0x510]
    136c: 52800068     	mov	w8, #0x3                // =3
    1370: 14000005     	b	0x1384 <sample+0x510>
    1374: f942a268     	ldr	x8, [x19, #0x540]
    1378: 91000508     	add	x8, x8, #0x1
    137c: f902a268     	str	x8, [x19, #0x540]
    1380: 52800048     	mov	w8, #0x2                // =2
    1384: d10023a1     	sub	x1, x29, #0x8
    1388: d10043a2     	sub	x2, x29, #0x10
    138c: aa1303e0     	mov	x0, x19
    1390: 2a0803fa     	mov	w26, w8
    1394: 94000144     	bl	0x18a4 <live>
    1398: 340007e0     	cbz	w0, 0x1494 <sample+0x620>
    139c: 297f27a8     	ldp	w8, w9, [x29, #-0x8]
    13a0: 6b09011f     	cmp	w8, w9
    13a4: 54000781     	b.ne	0x1494 <sample+0x620>
    13a8: f9400308     	ldr	x8, [x24]
    13ac: b5000748     	cbnz	x8, 0x1494 <sample+0x620>
    13b0: a9408268     	ldp	x8, x0, [x19, #0x8]
    13b4: 8b1702c1     	add	x1, x22, x23
    13b8: d100d3a2     	sub	x2, x29, #0x34
    13bc: 52800083     	mov	w3, #0x4                // =4
    13c0: d63f0100     	blr	x8
    13c4: 7100041f     	cmp	w0, #0x1
    13c8: 54000661     	b.ne	0x1494 <sample+0x620>
    13cc: b85cc3a8     	ldur	w8, [x29, #-0x34]
    13d0: b85d83a9     	ldur	w9, [x29, #-0x28]
    13d4: 6b09011f     	cmp	w8, w9
    13d8: 540005e1     	b.ne	0x1494 <sample+0x620>
    13dc: a9408268     	ldp	x8, x0, [x19, #0x8]
    13e0: 8b1902c1     	add	x1, x22, x25
    13e4: d100d3a2     	sub	x2, x29, #0x34
    13e8: 52800083     	mov	w3, #0x4                // =4
    13ec: d63f0100     	blr	x8
    13f0: 7100041f     	cmp	w0, #0x1
    13f4: 54000501     	b.ne	0x1494 <sample+0x620>
    13f8: b85cc3a8     	ldur	w8, [x29, #-0x34]
    13fc: b85d43a9     	ldur	w9, [x29, #-0x2c]
    1400: 6b09011f     	cmp	w8, w9
    1404: 54000481     	b.ne	0x1494 <sample+0x620>
    1408: f942a668     	ldr	x8, [x19, #0x548]
    140c: f9401e60     	ldr	x0, [x19, #0x38]
    1410: 910033e2     	add	x2, sp, #0xc
    1414: b85fc3a1     	ldur	w1, [x29, #-0x4]
    1418: 91000508     	add	x8, x8, #0x1
    141c: f902a668     	str	x8, [x19, #0x548]
    1420: 94000000     	bl	0x1420 <sample+0x5ac>
		0000000000001420:  R_AARCH64_CALL26	iq4_f4_native_unlock_02
    1424: 34000380     	cbz	w0, 0x1494 <sample+0x620>
    1428: b9400fe8     	ldr	w8, [sp, #0xc]
    142c: 34000348     	cbz	w8, 0x1494 <sample+0x620>
    1430: a9408268     	ldp	x8, x0, [x19, #0x8]
    1434: 8b1702c1     	add	x1, x22, x23
    1438: d100d3a2     	sub	x2, x29, #0x34
    143c: 52800083     	mov	w3, #0x4                // =4
    1440: d63f0100     	blr	x8
    1444: 7100041f     	cmp	w0, #0x1
    1448: 54000261     	b.ne	0x1494 <sample+0x620>
    144c: b85cc3a8     	ldur	w8, [x29, #-0x34]
    1450: 7100111f     	cmp	w8, #0x4
    1454: 54000201     	b.ne	0x1494 <sample+0x620>
    1458: 71000b5f     	cmp	w26, #0x2
    145c: 54ffd520     	b.eq	0xf00 <sample+0x8c>
    1460: 2a1a03e0     	mov	w0, w26
    1464: 35ffd57a     	cbnz	w26, 0xf10 <sample+0x9c>
    1468: 34000255     	cbz	w21, 0x14b0 <sample+0x63c>
    146c: f9411a68     	ldr	x8, [x19, #0x230]
    1470: b9407269     	ldr	w9, [x19, #0x70]
    1474: 9ac9090a     	udiv	x10, x8, x9
    1478: 9b09a149     	msub	x9, x10, x9, x8
    147c: 5280090a     	mov	w10, #0x48              // =72
    1480: 9b0a4d29     	madd	x9, x9, x10, x19
    1484: b942c52a     	ldr	w10, [x9, #0x2c4]
    1488: 3100054a     	adds	w10, w10, #0x1
    148c: b902c52a     	str	w10, [x9, #0x2c4]
    1490: 540001e3     	b.lo	0x14cc <sample+0x658>
    1494: 91032268     	add	x8, x19, #0xc8
    1498: 91033269     	add	x9, x19, #0xcc
    149c: 5280002a     	mov	w10, #0x1               // =1
    14a0: 889ffd1f     	stlr	wzr, [x8]
    14a4: 528000a0     	mov	w0, #0x5                // =5
    14a8: 889ffd2a     	stlr	w10, [x9]
    14ac: 17fffe99     	b	0xf10 <sample+0x9c>
    14b0: ad4087e0     	ldp	q0, q1, [sp, #0x10]
    14b4: 52800028     	mov	w8, #0x1                // =1
    14b8: b9021a68     	str	w8, [x19, #0x218]
    14bc: ad120660     	stp	q0, q1, [x19, #0x240]
    14c0: ad418be0     	ldp	q0, q2, [sp, #0x30]
    14c4: ad130a60     	stp	q0, q2, [x19, #0x260]
    14c8: 1400000d     	b	0x14fc <sample+0x688>
    14cc: 910b0129     	add	x9, x9, #0x2c0
    14d0: 5280004a     	mov	w10, #0x2               // =2
    14d4: 889ffd2a     	stlr	w10, [x9]
    14d8: 9100050a     	add	x10, x8, #0x1
    14dc: f9428669     	ldr	x9, [x19, #0x508]
    14e0: f9410268     	ldr	x8, [x19, #0x200]
    14e4: f9011a6a     	str	x10, [x19, #0x230]
    14e8: 91000529     	add	x9, x9, #0x1
    14ec: f9028669     	str	x9, [x19, #0x508]
    14f0: b4000068     	cbz	x8, 0x14fc <sample+0x688>
    14f4: f9410a60     	ldr	x0, [x19, #0x210]
    14f8: d63f0100     	blr	x8
    14fc: 2a1f03e0     	mov	w0, wzr
    1500: b4ffd094     	cbz	x20, 0xf10 <sample+0x9c>
    1504: ad4087e0     	ldp	q0, q1, [sp, #0x10]
    1508: ad000680     	stp	q0, q1, [x20]
    150c: ad418be0     	ldp	q0, q2, [sp, #0x30]
    1510: ad010a80     	stp	q0, q2, [x20, #0x20]
    1514: 17fffe7f     	b	0xf10 <sample+0x9c>
    1518: 2a1f03e8     	mov	w8, wzr
    151c: 17ffff9a     	b	0x1384 <sample+0x510>
    1520: 340000db     	cbz	w27, 0x1538 <sample+0x6c4>
    1524: 36f800ba     	tbz	w26, #0x1f, 0x1538 <sample+0x6c4>
    1528: f9428e68     	ldr	x8, [x19, #0x518]
    152c: 91000508     	add	x8, x8, #0x1
    1530: f9028e68     	str	x8, [x19, #0x518]
    1534: 17ffff93     	b	0x1380 <sample+0x50c>
    1538: f9411a68     	ldr	x8, [x19, #0x230]
    153c: b9407269     	ldr	w9, [x19, #0x70]
    1540: 9ac9090a     	udiv	x10, x8, x9
    1544: 9b09a148     	msub	x8, x10, x9, x8
    1548: 52800909     	mov	w9, #0x48               // =72
    154c: 9b094d09     	madd	x9, x8, x9, x19
    1550: 910b013b     	add	x27, x9, #0x2c0
    1554: 88dfff69     	ldar	w9, [x27]
    1558: 340000c9     	cbz	w9, 0x1570 <sample+0x6fc>
    155c: f9429268     	ldr	x8, [x19, #0x520]
    1560: 91000508     	add	x8, x8, #0x1
    1564: f9029268     	str	x8, [x19, #0x520]
    1568: 52800088     	mov	w8, #0x4                // =4
    156c: 1400000e     	b	0x15a4 <sample+0x730>
    1570: b9407669     	ldr	w9, [x19, #0x74]
    1574: f940326a     	ldr	x10, [x19, #0x60]
    1578: f85e83a1     	ldur	x1, [x29, #-0x18]
    157c: b9401fe2     	ldr	w2, [sp, #0x1c]
    1580: 9b092900     	madd	x0, x8, x9, x10
    1584: 94000000     	bl	0x1584 <sample+0x710>
		0000000000001584:  R_AARCH64_CALL26	memcpy
    1588: ad4087e0     	ldp	q0, q1, [sp, #0x10]
    158c: 2a1f03e8     	mov	w8, wzr
    1590: 3c808360     	stur	q0, [x27, #0x8]
    1594: ad418be0     	ldp	q0, q2, [sp, #0x30]
    1598: 3c818361     	stur	q1, [x27, #0x18]
    159c: 3c828360     	stur	q0, [x27, #0x28]
    15a0: 3c838362     	stur	q2, [x27, #0x38]
    15a4: b9421e69     	ldr	w9, [x19, #0x21c]
    15a8: 340000e9     	cbz	w9, 0x15c4 <sample+0x750>
    15ac: 71000b5f     	cmp	w26, #0x2
    15b0: 540000a3     	b.lo	0x15c4 <sample+0x750>
    15b4: f942aa69     	ldr	x9, [x19, #0x550]
    15b8: 5100074a     	sub	w10, w26, #0x1
    15bc: 8b0a0129     	add	x9, x9, x10
    15c0: f902aa69     	str	x9, [x19, #0x550]
    15c4: b85d43a9     	ldur	w9, [x29, #-0x2c]
    15c8: f94027ea     	ldr	x10, [sp, #0x48]
    15cc: b9022669     	str	w9, [x19, #0x224]
    15d0: 52800029     	mov	w9, #0x1                // =1
    15d4: f901166a     	str	x10, [x19, #0x228]
    15d8: b9021e69     	str	w9, [x19, #0x21c]
    15dc: 17ffff6a     	b	0x1384 <sample+0x510>

00000000000015e0 <iq4_f4_source_bind_page_guard_on_ui_02>:
    15e0: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
    15e4: f9000bf5     	str	x21, [sp, #0x10]
    15e8: a9024ff4     	stp	x20, x19, [sp, #0x20]
    15ec: 910003fd     	mov	x29, sp
    15f0: aa0003f4     	mov	x20, x0
    15f4: 52800040     	mov	w0, #0x2                // =2
    15f8: b40001d4     	cbz	x20, 0x1630 <iq4_f4_source_bind_page_guard_on_ui_02+0x50>
    15fc: b40001a1     	cbz	x1, 0x1630 <iq4_f4_source_bind_page_guard_on_ui_02+0x50>
    1600: aa1403e0     	mov	x0, x20
    1604: aa0203f3     	mov	x19, x2
    1608: aa0103f5     	mov	x21, x1
    160c: 97fffc8e     	bl	0x844 <on_ui>
    1610: 340000e0     	cbz	w0, 0x162c <iq4_f4_source_bind_page_guard_on_ui_02+0x4c>
    1614: 91032288     	add	x8, x20, #0xc8
    1618: 88dffd08     	ldar	w8, [x8]
    161c: 35000088     	cbnz	w8, 0x162c <iq4_f4_source_bind_page_guard_on_ui_02+0x4c>
    1620: 91033288     	add	x8, x20, #0xcc
    1624: 88dffd08     	ldar	w8, [x8]
    1628: 340000c8     	cbz	w8, 0x1640 <iq4_f4_source_bind_page_guard_on_ui_02+0x60>
    162c: 52800040     	mov	w0, #0x2                // =2
    1630: a9424ff4     	ldp	x20, x19, [sp, #0x20]
    1634: f9400bf5     	ldr	x21, [sp, #0x10]
    1638: a8c37bfd     	ldp	x29, x30, [sp], #0x30
    163c: d65f03c0     	ret
    1640: 2a1f03e0     	mov	w0, wzr
    1644: a91f4e95     	stp	x21, x19, [x20, #0x1f0]
    1648: 17fffffa     	b	0x1630 <iq4_f4_source_bind_page_guard_on_ui_02+0x50>

000000000000164c <iq4_f4_source_is_ui_02>:
    164c: b4000040     	cbz	x0, 0x1654 <iq4_f4_source_is_ui_02+0x8>
    1650: 17fffc7d     	b	0x844 <on_ui>
    1654: d65f03c0     	ret

0000000000001658 <iq4_f4_source_bind_handoff_on_ui_02>:
    1658: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
    165c: a90157f6     	stp	x22, x21, [sp, #0x10]
    1660: a9024ff4     	stp	x20, x19, [sp, #0x20]
    1664: 910003fd     	mov	x29, sp
    1668: aa0003f3     	mov	x19, x0
    166c: 52800040     	mov	w0, #0x2                // =2
    1670: b4000293     	cbz	x19, 0x16c0 <iq4_f4_source_bind_handoff_on_ui_02+0x68>
    1674: b4000261     	cbz	x1, 0x16c0 <iq4_f4_source_bind_handoff_on_ui_02+0x68>
    1678: b4000242     	cbz	x2, 0x16c0 <iq4_f4_source_bind_handoff_on_ui_02+0x68>
    167c: aa1303e0     	mov	x0, x19
    1680: aa0103f6     	mov	x22, x1
    1684: aa0203f5     	mov	x21, x2
    1688: aa0303f4     	mov	x20, x3
    168c: 97fffc6e     	bl	0x844 <on_ui>
    1690: 34000160     	cbz	w0, 0x16bc <iq4_f4_source_bind_handoff_on_ui_02+0x64>
    1694: 91032268     	add	x8, x19, #0xc8
    1698: 88dffd08     	ldar	w8, [x8]
    169c: 35000108     	cbnz	w8, 0x16bc <iq4_f4_source_bind_handoff_on_ui_02+0x64>
    16a0: 91033268     	add	x8, x19, #0xcc
    16a4: 88dffd08     	ldar	w8, [x8]
    16a8: 350000a8     	cbnz	w8, 0x16bc <iq4_f4_source_bind_handoff_on_ui_02+0x64>
    16ac: f9410268     	ldr	x8, [x19, #0x200]
    16b0: b5000068     	cbnz	x8, 0x16bc <iq4_f4_source_bind_handoff_on_ui_02+0x64>
    16b4: f9410668     	ldr	x8, [x19, #0x208]
    16b8: b40000c8     	cbz	x8, 0x16d0 <iq4_f4_source_bind_handoff_on_ui_02+0x78>
    16bc: 52800040     	mov	w0, #0x2                // =2
    16c0: a9424ff4     	ldp	x20, x19, [sp, #0x20]
    16c4: a94157f6     	ldp	x22, x21, [sp, #0x10]
    16c8: a8c37bfd     	ldp	x29, x30, [sp], #0x30
    16cc: d65f03c0     	ret
    16d0: 2a1f03e0     	mov	w0, wzr
    16d4: f9010276     	str	x22, [x19, #0x200]
    16d8: f9010675     	str	x21, [x19, #0x208]
    16dc: f9010a74     	str	x20, [x19, #0x210]
    16e0: 17fffff8     	b	0x16c0 <iq4_f4_source_bind_handoff_on_ui_02+0x68>

00000000000016e4 <iq4_f4_source_post_control_02>:
    16e4: b4000300     	cbz	x0, 0x1744 <iq4_f4_source_post_control_02+0x60>
    16e8: d28a4649     	mov	x9, #0x5232             // =21042
    16ec: f9400008     	ldr	x8, [x0]
    16f0: f2a68a69     	movk	x9, #0x3453, lsl #16
    16f4: f2c688c9     	movk	x9, #0x3446, lsl #32
    16f8: f2e92a29     	movk	x9, #0x4951, lsl #48
    16fc: eb09011f     	cmp	x8, x9
    1700: 54000221     	b.ne	0x1744 <iq4_f4_source_post_control_02+0x60>
    1704: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
    1708: f9000bf3     	str	x19, [sp, #0x10]
    170c: 910003fd     	mov	x29, sp
    1710: 91033008     	add	x8, x0, #0xcc
    1714: 88dffd08     	ldar	w8, [x8]
    1718: 35000248     	cbnz	w8, 0x1760 <iq4_f4_source_post_control_02+0x7c>
    171c: b941e408     	ldr	w8, [x0, #0x1e4]
    1720: 34000168     	cbz	w8, 0x174c <iq4_f4_source_post_control_02+0x68>
    1724: aa0003f3     	mov	x19, x0
    1728: 91038000     	add	x0, x0, #0xe0
    172c: 94000000     	bl	0x172c <iq4_f4_source_post_control_02+0x48>
		000000000000172c:  R_AARCH64_CALL26	iq4_f4_native_event_notify_02
    1730: 2a0003e8     	mov	w8, w0
    1734: aa1303e0     	mov	x0, x19
    1738: 340000a8     	cbz	w8, 0x174c <iq4_f4_source_post_control_02+0x68>
    173c: 528000c0     	mov	w0, #0x6                // =6
    1740: 14000009     	b	0x1764 <iq4_f4_source_post_control_02+0x80>
    1744: 52800020     	mov	w0, #0x1                // =1
    1748: d65f03c0     	ret
    174c: 91032008     	add	x8, x0, #0xc8
    1750: 91033009     	add	x9, x0, #0xcc
    1754: 5280002a     	mov	w10, #0x1               // =1
    1758: 889ffd1f     	stlr	wzr, [x8]
    175c: 889ffd2a     	stlr	w10, [x9]
    1760: 528000a0     	mov	w0, #0x5                // =5
    1764: f9400bf3     	ldr	x19, [sp, #0x10]
    1768: a8c27bfd     	ldp	x29, x30, [sp], #0x20
    176c: d65f03c0     	ret

0000000000001770 <iq4_f4_source_start_on_ui_02>:
    1770: d100c3ff     	sub	sp, sp, #0x30
    1774: a9017bfd     	stp	x29, x30, [sp, #0x10]
    1778: a9024ff4     	stp	x20, x19, [sp, #0x20]
    177c: 910043fd     	add	x29, sp, #0x10
    1780: aa0003f3     	mov	x19, x0
    1784: 52800040     	mov	w0, #0x2                // =2
    1788: b40001b3     	cbz	x19, 0x17bc <iq4_f4_source_start_on_ui_02+0x4c>
    178c: b4000181     	cbz	x1, 0x17bc <iq4_f4_source_start_on_ui_02+0x4c>
    1790: aa1303e0     	mov	x0, x19
    1794: aa0103f4     	mov	x20, x1
    1798: 97fffc2b     	bl	0x844 <on_ui>
    179c: 340000e0     	cbz	w0, 0x17b8 <iq4_f4_source_start_on_ui_02+0x48>
    17a0: 91031268     	add	x8, x19, #0xc4
    17a4: 88dffd08     	ldar	w8, [x8]
    17a8: 34000088     	cbz	w8, 0x17b8 <iq4_f4_source_start_on_ui_02+0x48>
    17ac: 91032268     	add	x8, x19, #0xc8
    17b0: 88dffd08     	ldar	w8, [x8]
    17b4: 340000c8     	cbz	w8, 0x17cc <iq4_f4_source_start_on_ui_02+0x5c>
    17b8: 52800040     	mov	w0, #0x2                // =2
    17bc: a9424ff4     	ldp	x20, x19, [sp, #0x20]
    17c0: a9417bfd     	ldp	x29, x30, [sp, #0x10]
    17c4: 9100c3ff     	add	sp, sp, #0x30
    17c8: d65f03c0     	ret
    17cc: b9421a68     	ldr	w8, [x19, #0x218]
    17d0: 34ffff48     	cbz	w8, 0x17b8 <iq4_f4_source_start_on_ui_02+0x48>
    17d4: f940fa68     	ldr	x8, [x19, #0x1f0]
    17d8: b4ffff08     	cbz	x8, 0x17b8 <iq4_f4_source_start_on_ui_02+0x48>
    17dc: f940fe60     	ldr	x0, [x19, #0x1f8]
    17e0: d63f0100     	blr	x8
    17e4: 7100041f     	cmp	w0, #0x1
    17e8: 54fffe81     	b.ne	0x17b8 <iq4_f4_source_start_on_ui_02+0x48>
    17ec: 91090261     	add	x1, x19, #0x240
    17f0: aa1403e0     	mov	x0, x20
    17f4: 52800802     	mov	w2, #0x40               // =64
    17f8: 94000000     	bl	0x17f8 <iq4_f4_source_start_on_ui_02+0x88>
		00000000000017f8:  R_AARCH64_CALL26	memcmp
    17fc: 35fffde0     	cbnz	w0, 0x17b8 <iq4_f4_source_start_on_ui_02+0x48>
    1800: d10013a1     	sub	x1, x29, #0x4
    1804: 910003e2     	mov	x2, sp
    1808: aa1303e0     	mov	x0, x19
    180c: 94000026     	bl	0x18a4 <live>
    1810: 2a0003e8     	mov	w8, w0
    1814: 52800040     	mov	w0, #0x2                // =2
    1818: 34fffd28     	cbz	w8, 0x17bc <iq4_f4_source_start_on_ui_02+0x4c>
    181c: f94003e8     	ldr	x8, [sp]
    1820: b5fffce8     	cbnz	x8, 0x17bc <iq4_f4_source_start_on_ui_02+0x4c>
    1824: 91033268     	add	x8, x19, #0xcc
    1828: 88dffd08     	ldar	w8, [x8]
    182c: 34000068     	cbz	w8, 0x1838 <iq4_f4_source_start_on_ui_02+0xc8>
    1830: 528000a0     	mov	w0, #0x5                // =5
    1834: 17ffffe2     	b	0x17bc <iq4_f4_source_start_on_ui_02+0x4c>
    1838: b9407268     	ldr	w8, [x19, #0x70]
    183c: 34000148     	cbz	w8, 0x1864 <iq4_f4_source_start_on_ui_02+0xf4>
    1840: aa1f03e8     	mov	x8, xzr
    1844: 910b0269     	add	x9, x19, #0x2c0
    1848: 88dffd2a     	ldar	w10, [x9]
    184c: 3500028a     	cbnz	w10, 0x189c <iq4_f4_source_start_on_ui_02+0x12c>
    1850: b940726a     	ldr	w10, [x19, #0x70]
    1854: 91000508     	add	x8, x8, #0x1
    1858: 91012129     	add	x9, x9, #0x48
    185c: eb0a011f     	cmp	x8, x10
    1860: 54ffff43     	b.lo	0x1848 <iq4_f4_source_start_on_ui_02+0xd8>
    1864: ad520660     	ldp	q0, q1, [x19, #0x240]
    1868: 91087268     	add	x8, x19, #0x21c
    186c: d2c00029     	mov	x9, #0x100000000        // =4294967296
    1870: 2a1f03e0     	mov	w0, wzr
    1874: f9000109     	str	x9, [x8]
    1878: 9107a268     	add	x8, x19, #0x1e8
    187c: 52800029     	mov	w9, #0x1                // =1
    1880: ad140660     	stp	q0, q1, [x19, #0x280]
    1884: ad530262     	ldp	q2, q0, [x19, #0x260]
    1888: ad150262     	stp	q2, q0, [x19, #0x2a0]
    188c: 889ffd1f     	stlr	wzr, [x8]
    1890: 91032268     	add	x8, x19, #0xc8
    1894: 889ffd09     	stlr	w9, [x8]
    1898: 17ffffc9     	b	0x17bc <iq4_f4_source_start_on_ui_02+0x4c>
    189c: 528000c0     	mov	w0, #0x6                // =6
    18a0: 17ffffc7     	b	0x17bc <iq4_f4_source_start_on_ui_02+0x4c>

00000000000018a4 <live>:
    18a4: d10103ff     	sub	sp, sp, #0x40
    18a8: a9017bfd     	stp	x29, x30, [sp, #0x10]
    18ac: f90013f5     	str	x21, [sp, #0x20]
    18b0: a9034ff4     	stp	x20, x19, [sp, #0x30]
    18b4: 910043fd     	add	x29, sp, #0x10
    18b8: aa0203f3     	mov	x19, x2
    18bc: aa0103f5     	mov	x21, x1
    18c0: aa0003f4     	mov	x20, x0
    18c4: 97fffbe0     	bl	0x844 <on_ui>
    18c8: 340002a0     	cbz	w0, 0x191c <live+0x78>
    18cc: f9401a88     	ldr	x8, [x20, #0x30]
    18d0: 91041109     	add	x9, x8, #0x104
    18d4: d342fd29     	lsr	x9, x9, #2
    18d8: f110053f     	cmp	x9, #0x401
    18dc: 540001e3     	b.lo	0x1918 <live+0x74>
    18e0: a9408289     	ldp	x9, x0, [x20, #0x8]
    18e4: 91040101     	add	x1, x8, #0x100
    18e8: aa1503e2     	mov	x2, x21
    18ec: 52800083     	mov	w3, #0x4                // =4
    18f0: d63f0120     	blr	x9
    18f4: 7100041f     	cmp	w0, #0x1
    18f8: 54000101     	b.ne	0x1918 <live+0x74>
    18fc: b94002a8     	ldr	w8, [x21]
    1900: 7100111f     	cmp	w8, #0x4
    1904: 540000a8     	b.hi	0x1918 <live+0x74>
    1908: f9401a88     	ldr	x8, [x20, #0x30]
    190c: 91041509     	add	x9, x8, #0x105
    1910: f140053f     	cmp	x9, #0x1, lsl #12       // =0x1000
    1914: 540000e8     	b.hi	0x1930 <live+0x8c>
    1918: 2a1f03e0     	mov	w0, wzr
    191c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
    1920: f94013f5     	ldr	x21, [sp, #0x20]
    1924: a9417bfd     	ldp	x29, x30, [sp, #0x10]
    1928: 910103ff     	add	sp, sp, #0x40
    192c: d65f03c0     	ret
    1930: a9408289     	ldp	x9, x0, [x20, #0x8]
    1934: 91041101     	add	x1, x8, #0x104
    1938: d10013a2     	sub	x2, x29, #0x4
    193c: 52800023     	mov	w3, #0x1                // =1
    1940: d63f0120     	blr	x9
    1944: 7100041f     	cmp	w0, #0x1
    1948: 2a1f03e0     	mov	w0, wzr
    194c: 54fffe81     	b.ne	0x191c <live+0x78>
    1950: 385fc3a8     	ldurb	w8, [x29, #-0x4]
    1954: 7100051f     	cmp	w8, #0x1
    1958: 54fffe21     	b.ne	0x191c <live+0x78>
    195c: f9401e88     	ldr	x8, [x20, #0x38]
    1960: 9102d109     	add	x9, x8, #0xb4
    1964: d342fd29     	lsr	x9, x9, #2
    1968: f110053f     	cmp	x9, #0x401
    196c: 54fffd63     	b.lo	0x1918 <live+0x74>
    1970: a9408289     	ldp	x9, x0, [x20, #0x8]
    1974: 9102c101     	add	x1, x8, #0xb0
    1978: 910013e2     	add	x2, sp, #0x4
    197c: 52800083     	mov	w3, #0x4                // =4
    1980: d63f0120     	blr	x9
    1984: 7100041f     	cmp	w0, #0x1
    1988: 54fffc81     	b.ne	0x1918 <live+0x74>
    198c: b94007e8     	ldr	w8, [sp, #0x4]
    1990: b94002a9     	ldr	w9, [x21]
    1994: 6b09011f     	cmp	w8, w9
    1998: 54fffc01     	b.ne	0x1918 <live+0x74>
    199c: f9401e89     	ldr	x9, [x20, #0x38]
    19a0: 531d7108     	lsl	w8, w8, #3
    19a4: 8b090108     	add	x8, x8, x9
    19a8: 91030109     	add	x9, x8, #0xc0
    19ac: d343fd29     	lsr	x9, x9, #3
    19b0: f108053f     	cmp	x9, #0x201
    19b4: 54fffb23     	b.lo	0x1918 <live+0x74>
    19b8: a9408289     	ldp	x9, x0, [x20, #0x8]
    19bc: 9102e101     	add	x1, x8, #0xb8
    19c0: 910063a2     	add	x2, x29, #0x18
    19c4: 52800103     	mov	w3, #0x8                // =8
    19c8: d63f0120     	blr	x9
    19cc: 7100041f     	cmp	w0, #0x1
    19d0: 2a1f03e0     	mov	w0, wzr
    19d4: 54fffa41     	b.ne	0x191c <live+0x78>
    19d8: f9400fa8     	ldr	x8, [x29, #0x18]
    19dc: d16e6908     	sub	x8, x8, #0xb9a, lsl #12 // =0xb9a000
    19e0: f113811f     	cmp	x8, #0x4e0
    19e4: 54fff9c1     	b.ne	0x191c <live+0x78>
    19e8: f9401a88     	ldr	x8, [x20, #0x30]
    19ec: 91064109     	add	x9, x8, #0x190
    19f0: d343fd29     	lsr	x9, x9, #3
    19f4: f108053f     	cmp	x9, #0x201
    19f8: 54fff903     	b.lo	0x1918 <live+0x74>
    19fc: a9408289     	ldp	x9, x0, [x20, #0x8]
    1a00: 91062101     	add	x1, x8, #0x188
    1a04: aa1303e2     	mov	x2, x19
    1a08: 52800103     	mov	w3, #0x8                // =8
    1a0c: d63f0120     	blr	x9
    1a10: 7100041f     	cmp	w0, #0x1
    1a14: 54fff821     	b.ne	0x1918 <live+0x74>
    1a18: f9401a88     	ldr	x8, [x20, #0x30]
    1a1c: 91070509     	add	x9, x8, #0x1c1
    1a20: f140053f     	cmp	x9, #0x1, lsl #12       // =0x1000
    1a24: 54fff7a9     	b.ls	0x1918 <live+0x74>
    1a28: a9408289     	ldp	x9, x0, [x20, #0x8]
    1a2c: 91070101     	add	x1, x8, #0x1c0
    1a30: 910023e2     	add	x2, sp, #0x8
    1a34: 52800023     	mov	w3, #0x1                // =1
    1a38: d63f0120     	blr	x9
    1a3c: 7100041f     	cmp	w0, #0x1
    1a40: 54fff6c1     	b.ne	0x1918 <live+0x74>
    1a44: 394023e8     	ldrb	w8, [sp, #0x8]
    1a48: 34000088     	cbz	w8, 0x1a58 <live+0x1b4>
    1a4c: 52800020     	mov	w0, #0x1                // =1
    1a50: f9000260     	str	x0, [x19]
    1a54: 17ffffb2     	b	0x191c <live+0x78>
    1a58: 52800020     	mov	w0, #0x1                // =1
    1a5c: 17ffffb0     	b	0x191c <live+0x78>

0000000000001a60 <iq4_f4_source_request_stop_02>:
    1a60: b4000240     	cbz	x0, 0x1aa8 <iq4_f4_source_request_stop_02+0x48>
    1a64: d28a4649     	mov	x9, #0x5232             // =21042
    1a68: f9400008     	ldr	x8, [x0]
    1a6c: f2a68a69     	movk	x9, #0x3453, lsl #16
    1a70: f2c688c9     	movk	x9, #0x3446, lsl #32
    1a74: f2e92a29     	movk	x9, #0x4951, lsl #48
    1a78: eb09011f     	cmp	x8, x9
    1a7c: 54000161     	b.ne	0x1aa8 <iq4_f4_source_request_stop_02+0x48>
    1a80: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
    1a84: f9000bf3     	str	x19, [sp, #0x10]
    1a88: 910003fd     	mov	x29, sp
    1a8c: 91032008     	add	x8, x0, #0xc8
    1a90: 889ffd1f     	stlr	wzr, [x8]
    1a94: 91033008     	add	x8, x0, #0xcc
    1a98: 88dffd08     	ldar	w8, [x8]
    1a9c: 340000a8     	cbz	w8, 0x1ab0 <iq4_f4_source_request_stop_02+0x50>
    1aa0: 528000a0     	mov	w0, #0x5                // =5
    1aa4: 1400001a     	b	0x1b0c <iq4_f4_source_request_stop_02+0xac>
    1aa8: 52800020     	mov	w0, #0x1                // =1
    1aac: d65f03c0     	ret
    1ab0: 9107a008     	add	x8, x0, #0x1e8
    1ab4: 52800029     	mov	w9, #0x1                // =1
    1ab8: 885ffd0a     	ldaxr	w10, [x8]
    1abc: 3500024a     	cbnz	w10, 0x1b04 <iq4_f4_source_request_stop_02+0xa4>
    1ac0: 880afd09     	stlxr	w10, w9, [x8]
    1ac4: 35ffffaa     	cbnz	w10, 0x1ab8 <iq4_f4_source_request_stop_02+0x58>
    1ac8: b941e408     	ldr	w8, [x0, #0x1e4]
    1acc: 340000e8     	cbz	w8, 0x1ae8 <iq4_f4_source_request_stop_02+0x88>
    1ad0: aa0003f3     	mov	x19, x0
    1ad4: 91038000     	add	x0, x0, #0xe0
    1ad8: 94000000     	bl	0x1ad8 <iq4_f4_source_request_stop_02+0x78>
		0000000000001ad8:  R_AARCH64_CALL26	iq4_f4_native_event_notify_02
    1adc: 2a0003e8     	mov	w8, w0
    1ae0: aa1303e0     	mov	x0, x19
    1ae4: 35000128     	cbnz	w8, 0x1b08 <iq4_f4_source_request_stop_02+0xa8>
    1ae8: 91032008     	add	x8, x0, #0xc8
    1aec: 91033009     	add	x9, x0, #0xcc
    1af0: 5280002a     	mov	w10, #0x1               // =1
    1af4: 889ffd1f     	stlr	wzr, [x8]
    1af8: 528000a0     	mov	w0, #0x5                // =5
    1afc: 889ffd2a     	stlr	w10, [x9]
    1b00: 14000003     	b	0x1b0c <iq4_f4_source_request_stop_02+0xac>
    1b04: d5033f5f     	clrex
    1b08: 528000c0     	mov	w0, #0x6                // =6
    1b0c: f9400bf3     	ldr	x19, [sp, #0x10]
    1b10: a8c27bfd     	ldp	x29, x30, [sp], #0x20
    1b14: d65f03c0     	ret

0000000000001b18 <iq4_f4_source_stop_on_ui_02>:
    1b18: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
    1b1c: f9000bf3     	str	x19, [sp, #0x10]
    1b20: 910003fd     	mov	x29, sp
    1b24: b40001e0     	cbz	x0, 0x1b60 <iq4_f4_source_stop_on_ui_02+0x48>
    1b28: d28a4649     	mov	x9, #0x5232             // =21042
    1b2c: f9400008     	ldr	x8, [x0]
    1b30: f2a68a69     	movk	x9, #0x3453, lsl #16
    1b34: f2c688c9     	movk	x9, #0x3446, lsl #32
    1b38: f2e92a29     	movk	x9, #0x4951, lsl #48
    1b3c: eb09011f     	cmp	x8, x9
    1b40: 54000101     	b.ne	0x1b60 <iq4_f4_source_stop_on_ui_02+0x48>
    1b44: 91032008     	add	x8, x0, #0xc8
    1b48: 889ffd1f     	stlr	wzr, [x8]
    1b4c: 91033008     	add	x8, x0, #0xcc
    1b50: 88dffd08     	ldar	w8, [x8]
    1b54: 340000e8     	cbz	w8, 0x1b70 <iq4_f4_source_stop_on_ui_02+0x58>
    1b58: 528000a0     	mov	w0, #0x5                // =5
    1b5c: 14000002     	b	0x1b64 <iq4_f4_source_stop_on_ui_02+0x4c>
    1b60: 52800020     	mov	w0, #0x1                // =1
    1b64: f9400bf3     	ldr	x19, [sp, #0x10]
    1b68: a8c27bfd     	ldp	x29, x30, [sp], #0x20
    1b6c: d65f03c0     	ret
    1b70: aa0003f3     	mov	x19, x0
    1b74: 97fffb34     	bl	0x844 <on_ui>
    1b78: 2a0003e8     	mov	w8, w0
    1b7c: aa1303e0     	mov	x0, x19
    1b80: 34000088     	cbz	w8, 0x1b90 <iq4_f4_source_stop_on_ui_02+0x78>
    1b84: 91034008     	add	x8, x0, #0xd0
    1b88: 88dffd08     	ldar	w8, [x8]
    1b8c: 34000108     	cbz	w8, 0x1bac <iq4_f4_source_stop_on_ui_02+0x94>
    1b90: 91032008     	add	x8, x0, #0xc8
    1b94: 91033009     	add	x9, x0, #0xcc
    1b98: 5280002a     	mov	w10, #0x1               // =1
    1b9c: 889ffd1f     	stlr	wzr, [x8]
    1ba0: 528000a0     	mov	w0, #0x5                // =5
    1ba4: 889ffd2a     	stlr	w10, [x9]
    1ba8: 17ffffef     	b	0x1b64 <iq4_f4_source_stop_on_ui_02+0x4c>
    1bac: 91031008     	add	x8, x0, #0xc4
    1bb0: 88dffd08     	ldar	w8, [x8]
    1bb4: 340002a8     	cbz	w8, 0x1c08 <iq4_f4_source_stop_on_ui_02+0xf0>
    1bb8: f9402401     	ldr	x1, [x0, #0x48]
    1bbc: 9101e002     	add	x2, x0, #0x78
    1bc0: 97fffbc0     	bl	0xac0 <exact_triple>
    1bc4: 7100041f     	cmp	w0, #0x1
    1bc8: 54000141     	b.ne	0x1bf0 <iq4_f4_source_stop_on_ui_02+0xd8>
    1bcc: f9402661     	ldr	x1, [x19, #0x48]
    1bd0: 9101e260     	add	x0, x19, #0x78
    1bd4: 94000000     	bl	0x1bd4 <iq4_f4_source_stop_on_ui_02+0xbc>
		0000000000001bd4:  R_AARCH64_CALL26	iq4_f4_native_unsubscribe_02
    1bd8: 340000c0     	cbz	w0, 0x1bf0 <iq4_f4_source_stop_on_ui_02+0xd8>
    1bdc: f9402661     	ldr	x1, [x19, #0x48]
    1be0: aa1303e0     	mov	x0, x19
    1be4: 9101e262     	add	x2, x19, #0x78
    1be8: 97fffbb6     	bl	0xac0 <exact_triple>
    1bec: 34000080     	cbz	w0, 0x1bfc <iq4_f4_source_stop_on_ui_02+0xe4>
    1bf0: 91032268     	add	x8, x19, #0xc8
    1bf4: 91033269     	add	x9, x19, #0xcc
    1bf8: 17ffffe8     	b	0x1b98 <iq4_f4_source_stop_on_ui_02+0x80>
    1bfc: aa1303e0     	mov	x0, x19
    1c00: 91031268     	add	x8, x19, #0xc4
    1c04: 889ffd1f     	stlr	wzr, [x8]
    1c08: f9400bf3     	ldr	x19, [sp, #0x10]
    1c0c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
    1c10: 14000000     	b	0x1c10 <iq4_f4_source_stop_on_ui_02+0xf8>
		0000000000001c10:  R_AARCH64_JUMP26	iq4_f4_source_fence_02

0000000000001c14 <iq4_f4_source_fence_02>:
    1c14: b40001a0     	cbz	x0, 0x1c48 <iq4_f4_source_fence_02+0x34>
    1c18: d28a4649     	mov	x9, #0x5232             // =21042
    1c1c: f9400008     	ldr	x8, [x0]
    1c20: f2a68a69     	movk	x9, #0x3453, lsl #16
    1c24: f2c688c9     	movk	x9, #0x3446, lsl #32
    1c28: f2e92a29     	movk	x9, #0x4951, lsl #48
    1c2c: eb09011f     	cmp	x8, x9
    1c30: 540000c1     	b.ne	0x1c48 <iq4_f4_source_fence_02+0x34>
    1c34: 91033008     	add	x8, x0, #0xcc
    1c38: 88dffd08     	ldar	w8, [x8]
    1c3c: 340000c8     	cbz	w8, 0x1c54 <iq4_f4_source_fence_02+0x40>
    1c40: 528000a0     	mov	w0, #0x5                // =5
    1c44: d65f03c0     	ret
    1c48: 52800028     	mov	w8, #0x1                // =1
    1c4c: 2a0803e0     	mov	w0, w8
    1c50: d65f03c0     	ret
    1c54: 91032008     	add	x8, x0, #0xc8
    1c58: 88dffd08     	ldar	w8, [x8]
    1c5c: 350000e8     	cbnz	w8, 0x1c78 <iq4_f4_source_fence_02+0x64>
    1c60: 91031008     	add	x8, x0, #0xc4
    1c64: 88dffd08     	ldar	w8, [x8]
    1c68: 35000088     	cbnz	w8, 0x1c78 <iq4_f4_source_fence_02+0x64>
    1c6c: 91034008     	add	x8, x0, #0xd0
    1c70: 88dffd08     	ldar	w8, [x8]
    1c74: 34000068     	cbz	w8, 0x1c80 <iq4_f4_source_fence_02+0x6c>
    1c78: 528000c0     	mov	w0, #0x6                // =6
    1c7c: d65f03c0     	ret
    1c80: b9407008     	ldr	w8, [x0, #0x70]
    1c84: 34fffe48     	cbz	w8, 0x1c4c <iq4_f4_source_fence_02+0x38>
    1c88: aa1f03e9     	mov	x9, xzr
    1c8c: 910b000a     	add	x10, x0, #0x2c0
    1c90: 88dffd48     	ldar	w8, [x10]
    1c94: 35ffff28     	cbnz	w8, 0x1c78 <iq4_f4_source_fence_02+0x64>
    1c98: b940700b     	ldr	w11, [x0, #0x70]
    1c9c: 91000529     	add	x9, x9, #0x1
    1ca0: 9101214a     	add	x10, x10, #0x48
    1ca4: eb0b013f     	cmp	x9, x11
    1ca8: 54ffff43     	b.lo	0x1c90 <iq4_f4_source_fence_02+0x7c>
    1cac: 17ffffe8     	b	0x1c4c <iq4_f4_source_fence_02+0x38>

0000000000001cb0 <iq4_f4_source_worker_claim_02>:
    1cb0: aa0003e8     	mov	x8, x0
    1cb4: 52800020     	mov	w0, #0x1                // =1
    1cb8: b4000908     	cbz	x8, 0x1dd8 <iq4_f4_source_worker_claim_02+0x128>
    1cbc: b40008e1     	cbz	x1, 0x1dd8 <iq4_f4_source_worker_claim_02+0x128>
    1cc0: d28a464a     	mov	x10, #0x5232            // =21042
    1cc4: f9400109     	ldr	x9, [x8]
    1cc8: f2a68a6a     	movk	x10, #0x3453, lsl #16
    1ccc: f2c688ca     	movk	x10, #0x3446, lsl #32
    1cd0: f2e92a2a     	movk	x10, #0x4951, lsl #48
    1cd4: eb0a013f     	cmp	x9, x10
    1cd8: 54000801     	b.ne	0x1dd8 <iq4_f4_source_worker_claim_02+0x128>
    1cdc: d10183ff     	sub	sp, sp, #0x60
    1ce0: a9047bfd     	stp	x29, x30, [sp, #0x40]
    1ce4: a9054ff4     	stp	x20, x19, [sp, #0x50]
    1ce8: 910103fd     	add	x29, sp, #0x40
    1cec: 91033109     	add	x9, x8, #0xcc
    1cf0: 88dffd29     	ldar	w9, [x9]
    1cf4: 34000069     	cbz	w9, 0x1d00 <iq4_f4_source_worker_claim_02+0x50>
    1cf8: 528000a0     	mov	w0, #0x5                // =5
    1cfc: 14000034     	b	0x1dcc <iq4_f4_source_worker_claim_02+0x11c>
    1d00: aa0803f4     	mov	x20, x8
    1d04: aa0103f3     	mov	x19, x1
    1d08: 94000000     	bl	0x1d08 <iq4_f4_source_worker_claim_02+0x58>
		0000000000001d08:  R_AARCH64_CALL26	iq4_f4_native_tid_02
    1d0c: b40005e0     	cbz	x0, 0x1dc8 <iq4_f4_source_worker_claim_02+0x118>
    1d10: f9402a88     	ldr	x8, [x20, #0x50]
    1d14: eb08001f     	cmp	x0, x8
    1d18: 54000580     	b.eq	0x1dc8 <iq4_f4_source_worker_claim_02+0x118>
    1d1c: aa1403e9     	mov	x9, x20
    1d20: 9101628a     	add	x10, x20, #0x58
    1d24: aa1303e8     	mov	x8, x19
    1d28: c85ffd4b     	ldaxr	x11, [x10]
    1d2c: b500008b     	cbnz	x11, 0x1d3c <iq4_f4_source_worker_claim_02+0x8c>
    1d30: c80bfd40     	stlxr	w11, x0, [x10]
    1d34: 35ffffab     	cbnz	w11, 0x1d28 <iq4_f4_source_worker_claim_02+0x78>
    1d38: 14000002     	b	0x1d40 <iq4_f4_source_worker_claim_02+0x90>
    1d3c: d5033f5f     	clrex
    1d40: c8dffd4a     	ldar	x10, [x10]
    1d44: eb00015f     	cmp	x10, x0
    1d48: 54000401     	b.ne	0x1dc8 <iq4_f4_source_worker_claim_02+0x118>
    1d4c: f9411d2a     	ldr	x10, [x9, #0x238]
    1d50: b940712b     	ldr	w11, [x9, #0x70]
    1d54: 9acb094c     	udiv	x12, x10, x11
    1d58: 9b0ba98a     	msub	x10, x12, x11, x10
    1d5c: 5280090b     	mov	w11, #0x48              // =72
    1d60: 5280006c     	mov	w12, #0x3               // =3
    1d64: 9b0b254b     	madd	x11, x10, x11, x9
    1d68: 910b016b     	add	x11, x11, #0x2c0
    1d6c: 885ffd6d     	ldaxr	w13, [x11]
    1d70: 710009bf     	cmp	w13, #0x2
    1d74: 54000341     	b.ne	0x1ddc <iq4_f4_source_worker_claim_02+0x12c>
    1d78: 880dfd6c     	stlxr	w13, w12, [x11]
    1d7c: 35ffff8d     	cbnz	w13, 0x1d6c <iq4_f4_source_worker_claim_02+0xbc>
    1d80: b940752c     	ldr	w12, [x9, #0x74]
    1d84: f9403129     	ldr	x9, [x9, #0x60]
    1d88: 2a1f03e0     	mov	w0, wzr
    1d8c: 3cc08160     	ldur	q0, [x11, #0x8]
    1d90: 3cc18161     	ldur	q1, [x11, #0x18]
    1d94: 3cc28162     	ldur	q2, [x11, #0x28]
    1d98: 9b0c2549     	madd	x9, x10, x12, x9
    1d9c: 3cc38163     	ldur	q3, [x11, #0x38]
    1da0: b940056b     	ldr	w11, [x11, #0x4]
    1da4: ad0007e0     	stp	q0, q1, [sp]
    1da8: ad010fe2     	stp	q2, q3, [sp, #0x20]
    1dac: 3c838103     	stur	q3, [x8, #0x38]
    1db0: 3c828102     	stur	q2, [x8, #0x28]
    1db4: 3c818101     	stur	q1, [x8, #0x18]
    1db8: f9000109     	str	x9, [x8]
    1dbc: 3c808100     	stur	q0, [x8, #0x8]
    1dc0: 29092d0a     	stp	w10, w11, [x8, #0x48]
    1dc4: 14000002     	b	0x1dcc <iq4_f4_source_worker_claim_02+0x11c>
    1dc8: 52800040     	mov	w0, #0x2                // =2
    1dcc: a9454ff4     	ldp	x20, x19, [sp, #0x50]
    1dd0: a9447bfd     	ldp	x29, x30, [sp, #0x40]
    1dd4: 910183ff     	add	sp, sp, #0x60
    1dd8: d65f03c0     	ret
    1ddc: 528000e0     	mov	w0, #0x7                // =7
    1de0: d5033f5f     	clrex
    1de4: 17fffffa     	b	0x1dcc <iq4_f4_source_worker_claim_02+0x11c>

0000000000001de8 <iq4_f4_source_worker_release_02>:
    1de8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
    1dec: a9014ff4     	stp	x20, x19, [sp, #0x10]
    1df0: 910003fd     	mov	x29, sp
    1df4: aa0003f3     	mov	x19, x0
    1df8: 52800040     	mov	w0, #0x2                // =2
    1dfc: b4000573     	cbz	x19, 0x1ea8 <iq4_f4_source_worker_release_02+0xc0>
    1e00: b4000541     	cbz	x1, 0x1ea8 <iq4_f4_source_worker_release_02+0xc0>
    1e04: d28a4649     	mov	x9, #0x5232             // =21042
    1e08: f9400268     	ldr	x8, [x19]
    1e0c: f2a68a69     	movk	x9, #0x3453, lsl #16
    1e10: f2c688c9     	movk	x9, #0x3446, lsl #32
    1e14: f2e92a29     	movk	x9, #0x4951, lsl #48
    1e18: eb09011f     	cmp	x8, x9
    1e1c: 54000461     	b.ne	0x1ea8 <iq4_f4_source_worker_release_02+0xc0>
    1e20: aa0103f4     	mov	x20, x1
    1e24: 94000000     	bl	0x1e24 <iq4_f4_source_worker_release_02+0x3c>
		0000000000001e24:  R_AARCH64_CALL26	iq4_f4_native_tid_02
    1e28: 91016268     	add	x8, x19, #0x58
    1e2c: c8dffd08     	ldar	x8, [x8]
    1e30: eb08001f     	cmp	x0, x8
    1e34: 54000381     	b.ne	0x1ea4 <iq4_f4_source_worker_release_02+0xbc>
    1e38: b9404a89     	ldr	w9, [x20, #0x48]
    1e3c: b940726a     	ldr	w10, [x19, #0x70]
    1e40: 6b0a013f     	cmp	w9, w10
    1e44: 54000302     	b.hs	0x1ea4 <iq4_f4_source_worker_release_02+0xbc>
    1e48: f9411e6b     	ldr	x11, [x19, #0x238]
    1e4c: 9aca096c     	udiv	x12, x11, x10
    1e50: 9b0aad8a     	msub	x10, x12, x10, x11
    1e54: eb09015f     	cmp	x10, x9
    1e58: 54000261     	b.ne	0x1ea4 <iq4_f4_source_worker_release_02+0xbc>
    1e5c: 5280090a     	mov	w10, #0x48              // =72
    1e60: 9baa4d29     	umaddl	x9, w9, w10, x19
    1e64: 910b0129     	add	x9, x9, #0x2c0
    1e68: 88dffd2a     	ldar	w10, [x9]
    1e6c: 71000d5f     	cmp	w10, #0x3
    1e70: 540001a1     	b.ne	0x1ea4 <iq4_f4_source_worker_release_02+0xbc>
    1e74: b9404e8a     	ldr	w10, [x20, #0x4c]
    1e78: b940052b     	ldr	w11, [x9, #0x4]
    1e7c: aa1403e8     	mov	x8, x20
    1e80: 6b0b015f     	cmp	w10, w11
    1e84: 54000101     	b.ne	0x1ea4 <iq4_f4_source_worker_release_02+0xbc>
    1e88: b940490a     	ldr	w10, [x8, #0x48]
    1e8c: b940766b     	ldr	w11, [x19, #0x74]
    1e90: f940326c     	ldr	x12, [x19, #0x60]
    1e94: f9400108     	ldr	x8, [x8]
    1e98: 9baa316a     	umaddl	x10, w11, w10, x12
    1e9c: eb0a011f     	cmp	x8, x10
    1ea0: 540000a0     	b.eq	0x1eb4 <iq4_f4_source_worker_release_02+0xcc>
    1ea4: 52800040     	mov	w0, #0x2                // =2
    1ea8: a9414ff4     	ldp	x20, x19, [sp, #0x10]
    1eac: a8c27bfd     	ldp	x29, x30, [sp], #0x20
    1eb0: d65f03c0     	ret
    1eb4: 889ffd3f     	stlr	wzr, [x9]
    1eb8: 2a1f03e0     	mov	w0, wzr
    1ebc: f9411e68     	ldr	x8, [x19, #0x238]
    1ec0: 91000508     	add	x8, x8, #0x1
    1ec4: f9011e68     	str	x8, [x19, #0x238]
    1ec8: 17fffff8     	b	0x1ea8 <iq4_f4_source_worker_release_02+0xc0>

0000000000001ecc <iq4_f4_source_status_on_ui_02>:
    1ecc: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
    1ed0: a9014ff4     	stp	x20, x19, [sp, #0x10]
    1ed4: 910003fd     	mov	x29, sp
    1ed8: 6f00e400     	movi	v0.2d, #0000000000000000
    1edc: aa0803f3     	mov	x19, x8
    1ee0: f900311f     	str	xzr, [x8, #0x60]
    1ee4: ad000100     	stp	q0, q0, [x8]
    1ee8: ad010100     	stp	q0, q0, [x8, #0x20]
    1eec: ad020100     	stp	q0, q0, [x8, #0x40]
    1ef0: b4000300     	cbz	x0, 0x1f50 <iq4_f4_source_status_on_ui_02+0x84>
    1ef4: aa0003f4     	mov	x20, x0
    1ef8: 97fffa53     	bl	0x844 <on_ui>
    1efc: 340002a0     	cbz	w0, 0x1f50 <iq4_f4_source_status_on_ui_02+0x84>
    1f00: 3dc15280     	ldr	q0, [x20, #0x540]
    1f04: 3dc15681     	ldr	q1, [x20, #0x550]
    1f08: f942b288     	ldr	x8, [x20, #0x560]
    1f0c: 3dc14e82     	ldr	q2, [x20, #0x530]
    1f10: ad020660     	stp	q0, q1, [x19, #0x40]
    1f14: 3dc14280     	ldr	q0, [x20, #0x500]
    1f18: 3dc14681     	ldr	q1, [x20, #0x510]
    1f1c: f9003268     	str	x8, [x19, #0x60]
    1f20: 91033288     	add	x8, x20, #0xcc
    1f24: ad000660     	stp	q0, q1, [x19]
    1f28: 3dc14a80     	ldr	q0, [x20, #0x520]
    1f2c: ad010a60     	stp	q0, q2, [x19, #0x20]
    1f30: 88dffd09     	ldar	w9, [x8]
    1f34: 91031288     	add	x8, x20, #0xc4
    1f38: 88dffd08     	ldar	w8, [x8]
    1f3c: 290b2269     	stp	w9, w8, [x19, #0x58]
    1f40: 91032288     	add	x8, x20, #0xc8
    1f44: 52800c09     	mov	w9, #0x60               // =96
    1f48: 88dffd08     	ldar	w8, [x8]
    1f4c: 14000003     	b	0x1f58 <iq4_f4_source_status_on_ui_02+0x8c>
    1f50: 52800028     	mov	w8, #0x1                // =1
    1f54: 52800b09     	mov	w9, #0x58               // =88
    1f58: b8296a68     	str	w8, [x19, x9]
    1f5c: a9414ff4     	ldp	x20, x19, [sp, #0x10]
    1f60: a8c27bfd     	ldp	x29, x30, [sp], #0x20
    1f64: d65f03c0     	ret

0000000000001f68 <same_shape>:
    1f68: b9400008     	ldr	w8, [x0]
    1f6c: b9400029     	ldr	w9, [x1]
    1f70: 6b09011f     	cmp	w8, w9
    1f74: 540004e1     	b.ne	0x2010 <same_shape+0xa8>
    1f78: b9400408     	ldr	w8, [x0, #0x4]
    1f7c: b9400429     	ldr	w9, [x1, #0x4]
    1f80: 6b09011f     	cmp	w8, w9
    1f84: 54000461     	b.ne	0x2010 <same_shape+0xa8>
    1f88: b9400808     	ldr	w8, [x0, #0x8]
    1f8c: b9400829     	ldr	w9, [x1, #0x8]
    1f90: 6b09011f     	cmp	w8, w9
    1f94: 540003e1     	b.ne	0x2010 <same_shape+0xa8>
    1f98: b9400c08     	ldr	w8, [x0, #0xc]
    1f9c: b9400c29     	ldr	w9, [x1, #0xc]
    1fa0: 6b09011f     	cmp	w8, w9
    1fa4: 54000361     	b.ne	0x2010 <same_shape+0xa8>
    1fa8: b9401808     	ldr	w8, [x0, #0x18]
    1fac: b9401829     	ldr	w9, [x1, #0x18]
    1fb0: 6b09011f     	cmp	w8, w9
    1fb4: 540002e1     	b.ne	0x2010 <same_shape+0xa8>
    1fb8: b9402c08     	ldr	w8, [x0, #0x2c]
    1fbc: b9402c29     	ldr	w9, [x1, #0x2c]
    1fc0: 6b09011f     	cmp	w8, w9
    1fc4: 54000261     	b.ne	0x2010 <same_shape+0xa8>
    1fc8: b9403008     	ldr	w8, [x0, #0x30]
    1fcc: b9403029     	ldr	w9, [x1, #0x30]
    1fd0: 6b09011f     	cmp	w8, w9
    1fd4: 540001e1     	b.ne	0x2010 <same_shape+0xa8>
    1fd8: b9403408     	ldr	w8, [x0, #0x34]
    1fdc: b9403429     	ldr	w9, [x1, #0x34]
    1fe0: 6b09011f     	cmp	w8, w9
    1fe4: 54000161     	b.ne	0x2010 <same_shape+0xa8>
    1fe8: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
    1fec: 910003fd     	mov	x29, sp
    1ff0: 91007000     	add	x0, x0, #0x1c
    1ff4: 91007021     	add	x1, x1, #0x1c
    1ff8: 52800202     	mov	w2, #0x10               // =16
    1ffc: 94000000     	bl	0x1ffc <same_shape+0x94>
		0000000000001ffc:  R_AARCH64_CALL26	memcmp
    2000: 7100001f     	cmp	w0, #0x0
    2004: 1a9f17e0     	cset	w0, eq
    2008: a8c17bfd     	ldp	x29, x30, [sp], #0x10
    200c: d65f03c0     	ret
    2010: 2a1f03e0     	mov	w0, wzr
    2014: d65f03c0     	ret
