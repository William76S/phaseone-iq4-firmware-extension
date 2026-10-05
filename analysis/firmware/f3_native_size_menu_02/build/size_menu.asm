
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_native_size_menu_02/build/size_menu.o:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000000000 <iq4_f3_storage_size_append_wrapper_01>:
       0: d10443ff     	sub	sp, sp, #0x110
       4: a9107bfd     	stp	x29, x30, [sp, #0x100]
       8: 910003fd     	mov	x29, sp
       c: a90007e0     	stp	x0, x1, [sp]
      10: a9010fe2     	stp	x2, x3, [sp, #0x10]
      14: a90217e4     	stp	x4, x5, [sp, #0x20]
      18: a9031fe6     	stp	x6, x7, [sp, #0x30]
      1c: f90023e8     	str	x8, [sp, #0x40]
      20: d53b4209     	mrs	x9, NZCV
      24: f90027e9     	str	x9, [sp, #0x48]
      28: ad0287e0     	stp	q0, q1, [sp, #0x50]
      2c: ad038fe2     	stp	q2, q3, [sp, #0x70]
      30: ad0497e4     	stp	q4, q5, [sp, #0x90]
      34: ad059fe6     	stp	q6, q7, [sp, #0xb0]
      38: aa1e03e2     	mov	x2, x30
      3c: 94000000     	bl	0x3c <iq4_f3_storage_size_append_wrapper_01+0x3c>
		000000000000003c:  R_AARCH64_CALL26	iq4_f3_storage_size_child_01
      40: f90007e0     	str	x0, [sp, #0x8]
      44: ad4287e0     	ldp	q0, q1, [sp, #0x50]
      48: ad438fe2     	ldp	q2, q3, [sp, #0x70]
      4c: ad4497e4     	ldp	q4, q5, [sp, #0x90]
      50: ad459fe6     	ldp	q6, q7, [sp, #0xb0]
      54: f94027e9     	ldr	x9, [sp, #0x48]
      58: d51b4209     	msr	NZCV, x9
      5c: a94007e0     	ldp	x0, x1, [sp]
      60: a9410fe2     	ldp	x2, x3, [sp, #0x10]
      64: a94217e4     	ldp	x4, x5, [sp, #0x20]
      68: a9431fe6     	ldp	x6, x7, [sp, #0x30]
      6c: f94023e8     	ldr	x8, [sp, #0x40]
      70: a9507bfd     	ldp	x29, x30, [sp, #0x100]
      74: 910443ff     	add	sp, sp, #0x110
      78: d28b1710     	mov	x16, #0x58b8            // =22712
      7c: f2a009d0     	movk	x16, #0x4e, lsl #16
      80: d61f0200     	br	x16

0000000000000084 <iq4_f3_storage_size_child_01>:
      84: d10343ff     	sub	sp, sp, #0xd0
      88: a9077bfd     	stp	x29, x30, [sp, #0x70]
      8c: a9086ffc     	stp	x28, x27, [sp, #0x80]
      90: a90967fa     	stp	x26, x25, [sp, #0x90]
      94: a90a5ff8     	stp	x24, x23, [sp, #0xa0]
      98: a90b57f6     	stp	x22, x21, [sp, #0xb0]
      9c: a90c4ff4     	stp	x20, x19, [sp, #0xc0]
      a0: 9101c3fd     	add	x29, sp, #0x70
      a4: aa0203f5     	mov	x21, x2
      a8: aa0103f3     	mov	x19, x1
      ac: aa0003f4     	mov	x20, x0
      b0: 94000000     	bl	0xb0 <iq4_f3_storage_size_child_01+0x2c>
		00000000000000b0:  R_AARCH64_CALL26	iq4_extensions_installation_stage_02
      b4: f2400a9f     	tst	x20, #0x7
      b8: 54002ba1     	b.ne	0x62c <iq4_f3_storage_size_child_01+0x5a8>
      bc: f140069f     	cmp	x20, #0x1, lsl #12      // =0x1000
      c0: 54002b63     	b.lo	0x62c <iq4_f3_storage_size_child_01+0x5a8>
      c4: b4002b53     	cbz	x19, 0x62c <iq4_f3_storage_size_child_01+0x5a8>
      c8: b4002b34     	cbz	x20, 0x62c <iq4_f3_storage_size_child_01+0x5a8>
      cc: 5280a588     	mov	w8, #0x52c              // =1324
      d0: 72a009e8     	movk	w8, #0x4f, lsl #16
      d4: eb0802bf     	cmp	x21, x8
      d8: 54002aa1     	b.ne	0x62c <iq4_f3_storage_size_child_01+0x5a8>
      dc: 7101901f     	cmp	w0, #0x64
      e0: 54002a61     	b.ne	0x62c <iq4_f3_storage_size_child_01+0x5a8>
      e4: f2400a7f     	tst	x19, #0x7
      e8: 54002a21     	b.ne	0x62c <iq4_f3_storage_size_child_01+0x5a8>
      ec: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000000ec:  R_AARCH64_ADR_PREL_PG_HI21	.bss
      f0: 39400108     	ldrb	w8, [x8]
		00000000000000f0:  R_AARCH64_LDST8_ABS_LO12_NC	.bss
      f4: 370029c8     	tbnz	w8, #0x0, 0x62c <iq4_f3_storage_size_child_01+0x5a8>
      f8: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000000f8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x4
      fc: 39400108     	ldrb	w8, [x8]
		00000000000000fc:  R_AARCH64_LDST8_ABS_LO12_NC	.bss+0x4
     100: 37002968     	tbnz	w8, #0x0, 0x62c <iq4_f3_storage_size_child_01+0x5a8>
     104: aa1f03f7     	mov	x23, xzr
     108: 52800308     	mov	w8, #0x18               // =24
     10c: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000010c:  R_AARCH64_ADR_PREL_PG_HI21	.data.rel.ro
     110: 91000129     	add	x9, x9, #0x0
		0000000000000110:  R_AARCH64_ADD_ABS_LO12_NC	.data.rel.ro
     114: 5280081b     	mov	w27, #0x40              // =64
     118: f90003f3     	str	x19, [sp]
     11c: 9b0826fc     	madd	x28, x23, x8, x9
     120: aa0903f3     	mov	x19, x9
     124: f9400796     	ldr	x22, [x28, #0x8]
     128: b4000396     	cbz	x22, 0x198 <iq4_f3_storage_size_child_01+0x114>
     12c: f9400398     	ldr	x24, [x28]
     130: aa1f03f9     	mov	x25, xzr
     134: aa1603e8     	mov	x8, x22
     138: f101011a     	subs	x26, x8, #0x40
     13c: 8b190301     	add	x1, x24, x25
     140: 9a9b3115     	csel	x21, x8, x27, lo
     144: ab0102bf     	cmn	x21, x1
     148: 1a9f37e8     	cset	w8, hs
     14c: f140043f     	cmp	x1, #0x1, lsl #12       // =0x1000
     150: 540026c3     	b.lo	0x628 <iq4_f3_storage_size_child_01+0x5a4>
     154: 370026a8     	tbnz	w8, #0x0, 0x628 <iq4_f3_storage_size_child_01+0x5a4>
     158: 9100c3e2     	add	x2, sp, #0x30
     15c: aa1f03e0     	mov	x0, xzr
     160: aa1503e3     	mov	x3, x21
     164: 94000000     	bl	0x164 <iq4_f3_storage_size_child_01+0xe0>
		0000000000000164:  R_AARCH64_CALL26	iq4_native_self_read_01
     168: 7100041f     	cmp	w0, #0x1
     16c: 540025e1     	b.ne	0x628 <iq4_f3_storage_size_child_01+0x5a4>
     170: f9400b88     	ldr	x8, [x28, #0x10]
     174: 9100c3e0     	add	x0, sp, #0x30
     178: aa1503e2     	mov	x2, x21
     17c: 8b190101     	add	x1, x8, x25
     180: 94000000     	bl	0x180 <iq4_f3_storage_size_child_01+0xfc>
		0000000000000180:  R_AARCH64_CALL26	memcmp
     184: 35002520     	cbnz	w0, 0x628 <iq4_f3_storage_size_child_01+0x5a4>
     188: 91010339     	add	x25, x25, #0x40
     18c: aa1a03e8     	mov	x8, x26
     190: eb16033f     	cmp	x25, x22
     194: 54fffd23     	b.lo	0x138 <iq4_f3_storage_size_child_01+0xb4>
     198: 910006f7     	add	x23, x23, #0x1
     19c: 52800308     	mov	w8, #0x18               // =24
     1a0: aa1303e9     	mov	x9, x19
     1a4: f1002aff     	cmp	x23, #0xa
     1a8: 54fffba1     	b.ne	0x11c <iq4_f3_storage_size_child_01+0x98>
     1ac: 91002288     	add	x8, x20, #0x8
     1b0: d343fd08     	lsr	x8, x8, #3
     1b4: f108051f     	cmp	x8, #0x201
     1b8: 54002383     	b.lo	0x628 <iq4_f3_storage_size_child_01+0x5a4>
     1bc: 9100a3e2     	add	x2, sp, #0x28
     1c0: aa1f03e0     	mov	x0, xzr
     1c4: aa1403e1     	mov	x1, x20
     1c8: 52800103     	mov	w3, #0x8                // =8
     1cc: 94000000     	bl	0x1cc <iq4_f3_storage_size_child_01+0x148>
		00000000000001cc:  R_AARCH64_CALL26	iq4_native_self_read_01
     1d0: 7100041f     	cmp	w0, #0x1
     1d4: 540022a1     	b.ne	0x628 <iq4_f3_storage_size_child_01+0x5a4>
     1d8: 9100c3e2     	add	x2, sp, #0x30
     1dc: aa1f03e0     	mov	x0, xzr
     1e0: aa1403e1     	mov	x1, x20
     1e4: 52800103     	mov	w3, #0x8                // =8
     1e8: 94000000     	bl	0x1e8 <iq4_f3_storage_size_child_01+0x164>
		00000000000001e8:  R_AARCH64_CALL26	iq4_native_self_read_01
     1ec: 7100041f     	cmp	w0, #0x1
     1f0: 540021c1     	b.ne	0x628 <iq4_f3_storage_size_child_01+0x5a4>
     1f4: 91006288     	add	x8, x20, #0x18
     1f8: f94003f3     	ldr	x19, [sp]
     1fc: d342fd08     	lsr	x8, x8, #2
     200: f110051f     	cmp	x8, #0x401
     204: 54002143     	b.lo	0x62c <iq4_f3_storage_size_child_01+0x5a8>
     208: f9401be8     	ldr	x8, [sp, #0x30]
     20c: 529f3717     	mov	w23, #0xf9b8            // =63928
     210: 72a01717     	movk	w23, #0xb8, lsl #16
     214: eb17011f     	cmp	x8, x23
     218: 540020a1     	b.ne	0x62c <iq4_f3_storage_size_child_01+0x5a8>
     21c: f94017e8     	ldr	x8, [sp, #0x28]
     220: eb17011f     	cmp	x8, x23
     224: 54002041     	b.ne	0x62c <iq4_f3_storage_size_child_01+0x5a8>
     228: 91005281     	add	x1, x20, #0x14
     22c: 910033e2     	add	x2, sp, #0xc
     230: aa1f03e0     	mov	x0, xzr
     234: 52800083     	mov	w3, #0x4                // =4
     238: 94000000     	bl	0x238 <iq4_f3_storage_size_child_01+0x1b4>
		0000000000000238:  R_AARCH64_CALL26	iq4_native_self_read_01
     23c: 7100041f     	cmp	w0, #0x1
     240: 54001f61     	b.ne	0x62c <iq4_f3_storage_size_child_01+0x5a8>
     244: b9400fe8     	ldr	w8, [sp, #0xc]
     248: 7106151f     	cmp	w8, #0x185
     24c: 54001f01     	b.ne	0x62c <iq4_f3_storage_size_child_01+0x5a8>
     250: 91002268     	add	x8, x19, #0x8
     254: d343fd08     	lsr	x8, x8, #3
     258: f108051f     	cmp	x8, #0x201
     25c: 54001e83     	b.lo	0x62c <iq4_f3_storage_size_child_01+0x5a8>
     260: 9100a3e2     	add	x2, sp, #0x28
     264: aa1f03e0     	mov	x0, xzr
     268: aa1303e1     	mov	x1, x19
     26c: 52800103     	mov	w3, #0x8                // =8
     270: 94000000     	bl	0x270 <iq4_f3_storage_size_child_01+0x1ec>
		0000000000000270:  R_AARCH64_CALL26	iq4_native_self_read_01
     274: 7100041f     	cmp	w0, #0x1
     278: 54001da1     	b.ne	0x62c <iq4_f3_storage_size_child_01+0x5a8>
     27c: 9100c3e2     	add	x2, sp, #0x30
     280: aa1f03e0     	mov	x0, xzr
     284: aa1303e1     	mov	x1, x19
     288: 52800103     	mov	w3, #0x8                // =8
     28c: 94000000     	bl	0x28c <iq4_f3_storage_size_child_01+0x208>
		000000000000028c:  R_AARCH64_CALL26	iq4_native_self_read_01
     290: 7100041f     	cmp	w0, #0x1
     294: 54001cc1     	b.ne	0x62c <iq4_f3_storage_size_child_01+0x5a8>
     298: f9401be9     	ldr	x9, [sp, #0x30]
     29c: 910e22e8     	add	x8, x23, #0x388
     2a0: 90000018     	adrp	x24, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000002a0:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     2a4: 90000015     	adrp	x21, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000002a4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x4
     2a8: eb08013f     	cmp	x9, x8
     2ac: 54001be1     	b.ne	0x628 <iq4_f3_storage_size_child_01+0x5a4>
     2b0: f94017e9     	ldr	x9, [sp, #0x28]
     2b4: eb08013f     	cmp	x9, x8
     2b8: 54001b81     	b.ne	0x628 <iq4_f3_storage_size_child_01+0x5a4>
     2bc: f94003e8     	ldr	x8, [sp]
     2c0: 9100c3e1     	add	x1, sp, #0x30
     2c4: 91006100     	add	x0, x8, #0x18
     2c8: 940000e2     	bl	0x650 <word>
     2cc: 34001ae0     	cbz	w0, 0x628 <iq4_f3_storage_size_child_01+0x5a4>
     2d0: f9401be0     	ldr	x0, [sp, #0x30]
     2d4: 9100a3e1     	add	x1, sp, #0x28
     2d8: 940000de     	bl	0x650 <word>
     2dc: 34001a60     	cbz	w0, 0x628 <iq4_f3_storage_size_child_01+0x5a4>
     2e0: f94017e8     	ldr	x8, [sp, #0x28]
     2e4: d16efd08     	sub	x8, x8, #0xbbf, lsl #12 // =0xbbf000
     2e8: f10fe11f     	cmp	x8, #0x3f8
     2ec: 540019e1     	b.ne	0x628 <iq4_f3_storage_size_child_01+0x5a4>
     2f0: 910083e0     	add	x0, sp, #0x20
     2f4: 94000000     	bl	0x2f4 <iq4_f3_storage_size_child_01+0x270>
		00000000000002f4:  R_AARCH64_CALL26	iq4_f4_native_current_02
     2f8: 34001980     	cbz	w0, 0x628 <iq4_f3_storage_size_child_01+0x5a4>
     2fc: f94013e0     	ldr	x0, [sp, #0x20]
     300: 9100a3e1     	add	x1, sp, #0x28
     304: 940000d3     	bl	0x650 <word>
     308: 34001900     	cbz	w0, 0x628 <iq4_f3_storage_size_child_01+0x5a4>
     30c: f94017e8     	ldr	x8, [sp, #0x28]
     310: d16e4508     	sub	x8, x8, #0xb91, lsl #12 // =0xb91000
     314: f13d211f     	cmp	x8, #0xf48
     318: 54001881     	b.ne	0x628 <iq4_f3_storage_size_child_01+0x5a4>
     31c: f94013e8     	ldr	x8, [sp, #0x20]
     320: 910063e1     	add	x1, sp, #0x18
     324: 91072100     	add	x0, x8, #0x1c8
     328: 940000ca     	bl	0x650 <word>
     32c: 340017e0     	cbz	w0, 0x628 <iq4_f3_storage_size_child_01+0x5a4>
     330: f9400fe0     	ldr	x0, [sp, #0x18]
     334: 9100a3e1     	add	x1, sp, #0x28
     338: 940000c6     	bl	0x650 <word>
     33c: 34001760     	cbz	w0, 0x628 <iq4_f3_storage_size_child_01+0x5a4>
     340: f94017e8     	ldr	x8, [sp, #0x28]
     344: d11982e9     	sub	x9, x23, #0x660
     348: eb09011f     	cmp	x8, x9
     34c: 540016e1     	b.ne	0x628 <iq4_f3_storage_size_child_01+0x5a4>
     350: f9400fe8     	ldr	x8, [sp, #0x18]
     354: 910043e1     	add	x1, sp, #0x10
     358: 91002100     	add	x0, x8, #0x8
     35c: 940000bd     	bl	0x650 <word>
     360: 34001640     	cbz	w0, 0x628 <iq4_f3_storage_size_child_01+0x5a4>
     364: f9400be8     	ldr	x8, [sp, #0x10]
     368: f94013e9     	ldr	x9, [sp, #0x20]
     36c: eb09011f     	cmp	x8, x9
     370: 540015c1     	b.ne	0x628 <iq4_f3_storage_size_child_01+0x5a4>
     374: 9000001a     	adrp	x26, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000374:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x8
     378: f9400349     	ldr	x9, [x26]
		0000000000000378:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x8
     37c: b40002a9     	cbz	x9, 0x3d0 <iq4_f3_storage_size_child_01+0x34c>
     380: eb14013f     	cmp	x9, x20
     384: 54001521     	b.ne	0x628 <iq4_f3_storage_size_child_01+0x5a4>
     388: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000388:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x10
     38c: f94003ea     	ldr	x10, [sp]
     390: f9400129     	ldr	x9, [x9]
		0000000000000390:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x10
     394: eb0a013f     	cmp	x9, x10
     398: 54001481     	b.ne	0x628 <iq4_f3_storage_size_child_01+0x5a4>
     39c: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000039c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x18
     3a0: f9400129     	ldr	x9, [x9]
		00000000000003a0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x18
     3a4: eb08013f     	cmp	x9, x8
     3a8: 54001401     	b.ne	0x628 <iq4_f3_storage_size_child_01+0x5a4>
     3ac: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000003ac:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x20
     3b0: f9400fe9     	ldr	x9, [sp, #0x18]
     3b4: 9000000a     	adrp	x10, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000003b4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x28
     3b8: f9400108     	ldr	x8, [x8]
		00000000000003b8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x20
     3bc: f940014a     	ldr	x10, [x10]
		00000000000003bc:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     3c0: f94003f3     	ldr	x19, [sp]
     3c4: eb09011f     	cmp	x8, x9
     3c8: 9a930153     	csel	x19, x10, x19, eq
     3cc: 14000098     	b	0x62c <iq4_f3_storage_size_child_01+0x5a8>
     3d0: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000003d0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x18
     3d4: f9400fea     	ldr	x10, [sp, #0x18]
     3d8: 90000019     	adrp	x25, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000003d8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x30
     3dc: 91000339     	add	x25, x25, #0x0
		00000000000003dc:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x30
     3e0: 5280002b     	mov	w11, #0x1               // =1
     3e4: f9000128     	str	x8, [x9]
		00000000000003e4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x18
     3e8: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000003e8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x20
     3ec: d10042f6     	sub	x22, x23, #0x10
     3f0: 5280031b     	mov	w27, #0x18              // =24
     3f4: aa1903f7     	mov	x23, x25
     3f8: 390002ab     	strb	w11, [x21]
		00000000000003f8:  R_AARCH64_LDST8_ABS_LO12_NC	.bss+0x4
     3fc: f900010a     	str	x10, [x8]
		00000000000003fc:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x20
     400: aa1603e0     	mov	x0, x22
     404: aa1703e1     	mov	x1, x23
     408: 94000092     	bl	0x650 <word>
     40c: 340010a0     	cbz	w0, 0x620 <iq4_f3_storage_size_child_01+0x59c>
     410: f100077b     	subs	x27, x27, #0x1
     414: 910022d6     	add	x22, x22, #0x8
     418: 910022f7     	add	x23, x23, #0x8
     41c: 54ffff21     	b.ne	0x400 <iq4_f3_storage_size_child_01+0x37c>
     420: 5280e717     	mov	w23, #0x738             // =1848
     424: 90000016     	adrp	x22, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000424:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xf0
     428: 910002d6     	add	x22, x22, #0x0
		0000000000000428:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0xf0
     42c: 72a01737     	movk	w23, #0xb9, lsl #16
     430: 528002db     	mov	w27, #0x16              // =22
     434: aa1703e0     	mov	x0, x23
     438: aa1603e1     	mov	x1, x22
     43c: 94000085     	bl	0x650 <word>
     440: 34000f00     	cbz	w0, 0x620 <iq4_f3_storage_size_child_01+0x59c>
     444: f100077b     	subs	x27, x27, #0x1
     448: 910022f7     	add	x23, x23, #0x8
     44c: 910022d6     	add	x22, x22, #0x8
     450: 54ffff21     	b.ne	0x434 <iq4_f3_storage_size_child_01+0x3b0>
     454: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000454:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x6e0
     458: 91000108     	add	x8, x8, #0x0
		0000000000000458:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x6e0
     45c: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000045c:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x74c
     460: 91000129     	add	x9, x9, #0x0
		0000000000000460:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x74c
     464: 9000000a     	adrp	x10, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000464:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x118
     468: 9100014a     	add	x10, x10, #0x0
		0000000000000468:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x118
     46c: a902a728     	stp	x8, x9, [x25, #0x28]
     470: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000470:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x80c
     474: 91000108     	add	x8, x8, #0x0
		0000000000000474:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x80c
     478: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000478:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x904
     47c: 91000129     	add	x9, x9, #0x0
		000000000000047c:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x904
     480: 528ae882     	mov	w2, #0x5744             // =22340
     484: a9002548     	stp	x8, x9, [x10]
     488: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000488:  R_AARCH64_ADR_PREL_PG_HI21	.text+0xa50
     48c: 91000108     	add	x8, x8, #0x0
		000000000000048c:  R_AARCH64_ADD_ABS_LO12_NC	.text+0xa50
     490: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000490:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x28
     494: 91000000     	add	x0, x0, #0x0
		0000000000000494:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x28
     498: 52802301     	mov	w1, #0x118              // =280
     49c: 72a009c2     	movk	w2, #0x4e, lsl #16
     4a0: aa1903e3     	mov	x3, x25
     4a4: f9001d48     	str	x8, [x10, #0x38]
     4a8: 9400020d     	bl	0xcdc <construct>
     4ac: 34000ba0     	cbz	w0, 0x620 <iq4_f3_storage_size_child_01+0x59c>
     4b0: 5293a602     	mov	w2, #0x9d30             // =40240
     4b4: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000004b4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a0
     4b8: 91000000     	add	x0, x0, #0x0
		00000000000004b8:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x1a0
     4bc: 90000003     	adrp	x3, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000004bc:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xf0
     4c0: 91000063     	add	x3, x3, #0x0
		00000000000004c0:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0xf0
     4c4: 52800701     	mov	w1, #0x38               // =56
     4c8: 72a009c2     	movk	w2, #0x4e, lsl #16
     4cc: 94000204     	bl	0xcdc <construct>
     4d0: 34000a80     	cbz	w0, 0x620 <iq4_f3_storage_size_child_01+0x59c>
     4d4: 5293a602     	mov	w2, #0x9d30             // =40240
     4d8: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000004d8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a8
     4dc: 91000000     	add	x0, x0, #0x0
		00000000000004dc:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x1a8
     4e0: 90000003     	adrp	x3, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000004e0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xf0
     4e4: 91000063     	add	x3, x3, #0x0
		00000000000004e4:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0xf0
     4e8: 52800701     	mov	w1, #0x38               // =56
     4ec: 72a009c2     	movk	w2, #0x4e, lsl #16
     4f0: 940001fb     	bl	0xcdc <construct>
     4f4: 34000960     	cbz	w0, 0x620 <iq4_f3_storage_size_child_01+0x59c>
     4f8: 5293a602     	mov	w2, #0x9d30             // =40240
     4fc: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000004fc:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b0
     500: 91000000     	add	x0, x0, #0x0
		0000000000000500:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x1b0
     504: 90000003     	adrp	x3, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000504:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xf0
     508: 91000063     	add	x3, x3, #0x0
		0000000000000508:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0xf0
     50c: 52800701     	mov	w1, #0x38               // =56
     510: 72a009c2     	movk	w2, #0x4e, lsl #16
     514: 940001f2     	bl	0xcdc <construct>
     518: 34000840     	cbz	w0, 0x620 <iq4_f3_storage_size_child_01+0x59c>
     51c: 5293a602     	mov	w2, #0x9d30             // =40240
     520: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000520:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b8
     524: 91000000     	add	x0, x0, #0x0
		0000000000000524:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x1b8
     528: 90000003     	adrp	x3, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000528:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xf0
     52c: 91000063     	add	x3, x3, #0x0
		000000000000052c:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0xf0
     530: 52800701     	mov	w1, #0x38               // =56
     534: 72a009c2     	movk	w2, #0x4e, lsl #16
     538: 940001e9     	bl	0xcdc <construct>
     53c: 34000720     	cbz	w0, 0x620 <iq4_f3_storage_size_child_01+0x59c>
     540: 5293a602     	mov	w2, #0x9d30             // =40240
     544: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000544:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c0
     548: 91000000     	add	x0, x0, #0x0
		0000000000000548:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x1c0
     54c: 90000003     	adrp	x3, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000054c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xf0
     550: 91000063     	add	x3, x3, #0x0
		0000000000000550:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0xf0
     554: 52800701     	mov	w1, #0x38               // =56
     558: 72a009c2     	movk	w2, #0x4e, lsl #16
     55c: 940001e0     	bl	0xcdc <construct>
     560: 34000600     	cbz	w0, 0x620 <iq4_f3_storage_size_child_01+0x59c>
     564: 5293a602     	mov	w2, #0x9d30             // =40240
     568: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000568:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c8
     56c: 91000000     	add	x0, x0, #0x0
		000000000000056c:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x1c8
     570: 90000003     	adrp	x3, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000570:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xf0
     574: 91000063     	add	x3, x3, #0x0
		0000000000000574:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0xf0
     578: 52800701     	mov	w1, #0x38               // =56
     57c: 72a009c2     	movk	w2, #0x4e, lsl #16
     580: 940001d7     	bl	0xcdc <construct>
     584: 340004e0     	cbz	w0, 0x620 <iq4_f3_storage_size_child_01+0x59c>
     588: 90000016     	adrp	x22, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000588:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x28
     58c: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000058c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a0
     590: f94002c0     	ldr	x0, [x22]
		0000000000000590:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     594: f9400101     	ldr	x1, [x8]
		0000000000000594:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1a0
     598: 94000000     	bl	0x598 <iq4_f3_storage_size_child_01+0x514>
		0000000000000598:  R_AARCH64_CALL26	iq4_f4_menu_append_03
     59c: 34000420     	cbz	w0, 0x620 <iq4_f3_storage_size_child_01+0x59c>
     5a0: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000005a0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a8
     5a4: f94002c0     	ldr	x0, [x22]
		00000000000005a4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     5a8: f9400101     	ldr	x1, [x8]
		00000000000005a8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1a8
     5ac: 94000000     	bl	0x5ac <iq4_f3_storage_size_child_01+0x528>
		00000000000005ac:  R_AARCH64_CALL26	iq4_f4_menu_append_03
     5b0: 34000380     	cbz	w0, 0x620 <iq4_f3_storage_size_child_01+0x59c>
     5b4: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000005b4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b0
     5b8: f94002c0     	ldr	x0, [x22]
		00000000000005b8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     5bc: f9400101     	ldr	x1, [x8]
		00000000000005bc:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1b0
     5c0: 94000000     	bl	0x5c0 <iq4_f3_storage_size_child_01+0x53c>
		00000000000005c0:  R_AARCH64_CALL26	iq4_f4_menu_append_03
     5c4: 340002e0     	cbz	w0, 0x620 <iq4_f3_storage_size_child_01+0x59c>
     5c8: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000005c8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b8
     5cc: f94002c0     	ldr	x0, [x22]
		00000000000005cc:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     5d0: f9400101     	ldr	x1, [x8]
		00000000000005d0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1b8
     5d4: 94000000     	bl	0x5d4 <iq4_f3_storage_size_child_01+0x550>
		00000000000005d4:  R_AARCH64_CALL26	iq4_f4_menu_append_03
     5d8: 34000240     	cbz	w0, 0x620 <iq4_f3_storage_size_child_01+0x59c>
     5dc: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000005dc:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c0
     5e0: f94002c0     	ldr	x0, [x22]
		00000000000005e0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     5e4: f9400101     	ldr	x1, [x8]
		00000000000005e4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c0
     5e8: 94000000     	bl	0x5e8 <iq4_f3_storage_size_child_01+0x564>
		00000000000005e8:  R_AARCH64_CALL26	iq4_f4_menu_append_03
     5ec: 340001a0     	cbz	w0, 0x620 <iq4_f3_storage_size_child_01+0x59c>
     5f0: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000005f0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c8
     5f4: f94002c0     	ldr	x0, [x22]
		00000000000005f4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     5f8: f9400101     	ldr	x1, [x8]
		00000000000005f8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c8
     5fc: 94000000     	bl	0x5fc <iq4_f3_storage_size_child_01+0x578>
		00000000000005fc:  R_AARCH64_CALL26	iq4_f4_menu_append_03
     600: 34000100     	cbz	w0, 0x620 <iq4_f3_storage_size_child_01+0x59c>
     604: f94003e9     	ldr	x9, [sp]
     608: f94002d3     	ldr	x19, [x22]
		0000000000000608:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     60c: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000060c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x10
     610: f9000354     	str	x20, [x26]
		0000000000000610:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x8
     614: f9000109     	str	x9, [x8]
		0000000000000614:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x10
     618: 390002bf     	strb	wzr, [x21]
		0000000000000618:  R_AARCH64_LDST8_ABS_LO12_NC	.bss+0x4
     61c: 14000004     	b	0x62c <iq4_f3_storage_size_child_01+0x5a8>
     620: 52800028     	mov	w8, #0x1                // =1
     624: 39000308     	strb	w8, [x24]
		0000000000000624:  R_AARCH64_LDST8_ABS_LO12_NC	.bss
     628: f94003f3     	ldr	x19, [sp]
     62c: aa1303e0     	mov	x0, x19
     630: a94c4ff4     	ldp	x20, x19, [sp, #0xc0]
     634: a94b57f6     	ldp	x22, x21, [sp, #0xb0]
     638: a94a5ff8     	ldp	x24, x23, [sp, #0xa0]
     63c: a94967fa     	ldp	x26, x25, [sp, #0x90]
     640: a9486ffc     	ldp	x28, x27, [sp, #0x80]
     644: a9477bfd     	ldp	x29, x30, [sp, #0x70]
     648: 910343ff     	add	sp, sp, #0xd0
     64c: d65f03c0     	ret

0000000000000650 <word>:
     650: 91002008     	add	x8, x0, #0x8
     654: d343fd08     	lsr	x8, x8, #3
     658: f108051f     	cmp	x8, #0x201
     65c: 54000062     	b.hs	0x668 <word+0x18>
     660: 2a1f03e0     	mov	w0, wzr
     664: d65f03c0     	ret
     668: d100c3ff     	sub	sp, sp, #0x30
     66c: a9017bfd     	stp	x29, x30, [sp, #0x10]
     670: a9024ff4     	stp	x20, x19, [sp, #0x20]
     674: 910043fd     	add	x29, sp, #0x10
     678: aa0003f4     	mov	x20, x0
     67c: aa0103f3     	mov	x19, x1
     680: aa1f03e0     	mov	x0, xzr
     684: aa1403e1     	mov	x1, x20
     688: aa1303e2     	mov	x2, x19
     68c: 52800103     	mov	w3, #0x8                // =8
     690: 94000000     	bl	0x690 <word+0x40>
		0000000000000690:  R_AARCH64_CALL26	iq4_native_self_read_01
     694: 7100041f     	cmp	w0, #0x1
     698: 540001a1     	b.ne	0x6cc <word+0x7c>
     69c: 910023e2     	add	x2, sp, #0x8
     6a0: aa1f03e0     	mov	x0, xzr
     6a4: aa1403e1     	mov	x1, x20
     6a8: 52800103     	mov	w3, #0x8                // =8
     6ac: 94000000     	bl	0x6ac <word+0x5c>
		00000000000006ac:  R_AARCH64_CALL26	iq4_native_self_read_01
     6b0: 7100041f     	cmp	w0, #0x1
     6b4: 540000c1     	b.ne	0x6cc <word+0x7c>
     6b8: f94007e8     	ldr	x8, [sp, #0x8]
     6bc: f9400269     	ldr	x9, [x19]
     6c0: eb09011f     	cmp	x8, x9
     6c4: 1a9f17e0     	cset	w0, eq
     6c8: 14000002     	b	0x6d0 <word+0x80>
     6cc: 2a1f03e0     	mov	w0, wzr
     6d0: a9424ff4     	ldp	x20, x19, [sp, #0x20]
     6d4: a9417bfd     	ldp	x29, x30, [sp, #0x10]
     6d8: 9100c3ff     	add	sp, sp, #0x30
     6dc: d65f03c0     	ret

00000000000006e0 <menu_name>:
     6e0: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000006e0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x28
     6e4: aa0003e8     	mov	x8, x0
     6e8: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000006e8:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
     6ec: 91000000     	add	x0, x0, #0x0
		00000000000006ec:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
     6f0: f9400129     	ldr	x9, [x9]
		00000000000006f0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     6f4: eb09011f     	cmp	x8, x9
     6f8: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000006f8:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1
     6fc: 91000108     	add	x8, x8, #0x0
		00000000000006fc:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1
     700: 9a800108     	csel	x8, x8, x0, eq
     704: b4000221     	cbz	x1, 0x748 <menu_name+0x68>
     708: 71000449     	subs	w9, w2, #0x1
     70c: 540001eb     	b.lt	0x748 <menu_name+0x68>
     710: 7100085f     	cmp	w2, #0x2
     714: 54000143     	b.lo	0x73c <menu_name+0x5c>
     718: aa1f03ea     	mov	x10, xzr
     71c: 386a690b     	ldrb	w11, [x8, x10]
     720: 3400010b     	cbz	w11, 0x740 <menu_name+0x60>
     724: 382a682b     	strb	w11, [x1, x10]
     728: 9100054a     	add	x10, x10, #0x1
     72c: eb0a013f     	cmp	x9, x10
     730: 54ffff61     	b.ne	0x71c <menu_name+0x3c>
     734: aa0903ea     	mov	x10, x9
     738: 14000002     	b	0x740 <menu_name+0x60>
     73c: aa1f03ea     	mov	x10, xzr
     740: aa0103e0     	mov	x0, x1
     744: 382a683f     	strb	wzr, [x1, x10]
     748: d65f03c0     	ret

000000000000074c <menu_value>:
     74c: d100c3ff     	sub	sp, sp, #0x30
     750: a9017bfd     	stp	x29, x30, [sp, #0x10]
     754: a9024ff4     	stp	x20, x19, [sp, #0x20]
     758: 910043fd     	add	x29, sp, #0x10
     75c: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000075c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x28
     760: 2a0203f4     	mov	w20, w2
     764: aa0103f3     	mov	x19, x1
     768: f9400108     	ldr	x8, [x8]
		0000000000000768:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     76c: eb08001f     	cmp	x0, x8
     770: 54000260     	b.eq	0x7bc <menu_value+0x70>
     774: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000774:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xb
     778: 91000108     	add	x8, x8, #0x0
		0000000000000778:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xb
     77c: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000077c:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
     780: 91000000     	add	x0, x0, #0x0
		0000000000000780:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
     784: b40003d3     	cbz	x19, 0x7fc <menu_value+0xb0>
     788: 71000689     	subs	w9, w20, #0x1
     78c: 5400038b     	b.lt	0x7fc <menu_value+0xb0>
     790: 71000a9f     	cmp	w20, #0x2
     794: 540002e3     	b.lo	0x7f0 <menu_value+0xa4>
     798: aa1f03ea     	mov	x10, xzr
     79c: 386a690b     	ldrb	w11, [x8, x10]
     7a0: 340002ab     	cbz	w11, 0x7f4 <menu_value+0xa8>
     7a4: 382a6a6b     	strb	w11, [x19, x10]
     7a8: 9100054a     	add	x10, x10, #0x1
     7ac: eb0a013f     	cmp	x9, x10
     7b0: 54ffff61     	b.ne	0x79c <menu_value+0x50>
     7b4: aa0903ea     	mov	x10, x9
     7b8: 1400000f     	b	0x7f4 <menu_value+0xa8>
     7bc: 910003e0     	mov	x0, sp
     7c0: 94000000     	bl	0x7c0 <menu_value+0x74>
		00000000000007c0:  R_AARCH64_CALL26	iq4_f3_settings_snapshot_06
     7c4: 34fffd80     	cbz	w0, 0x774 <menu_value+0x28>
     7c8: b9400be8     	ldr	w8, [sp, #0x8]
     7cc: 7100151f     	cmp	w8, #0x5
     7d0: 54fffd28     	b.hi	0x774 <menu_value+0x28>
     7d4: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000007d4:  R_AARCH64_ADR_PREL_PG_HI21	.rodata+0x378
     7d8: 91000129     	add	x9, x9, #0x0
		00000000000007d8:  R_AARCH64_ADD_ABS_LO12_NC	.rodata+0x378
     7dc: f8687928     	ldr	x8, [x9, x8, lsl #3]
     7e0: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000007e0:  R_AARCH64_ADR_PREL_PG_HI21	.data.rel.ro+0xf0
     7e4: 91000129     	add	x9, x9, #0x0
		00000000000007e4:  R_AARCH64_ADD_ABS_LO12_NC	.data.rel.ro+0xf0
     7e8: f8687928     	ldr	x8, [x9, x8, lsl #3]
     7ec: 17ffffe4     	b	0x77c <menu_value+0x30>
     7f0: aa1f03ea     	mov	x10, xzr
     7f4: aa1303e0     	mov	x0, x19
     7f8: 382a6a7f     	strb	wzr, [x19, x10]
     7fc: a9424ff4     	ldp	x20, x19, [sp, #0x20]
     800: a9417bfd     	ldp	x29, x30, [sp, #0x10]
     804: 9100c3ff     	add	sp, sp, #0x30
     808: d65f03c0     	ret

000000000000080c <item_name>:
     80c: b4000320     	cbz	x0, 0x870 <item_name+0x64>
     810: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000810:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a0
     814: f9400108     	ldr	x8, [x8]
		0000000000000814:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1a0
     818: eb08001f     	cmp	x0, x8
     81c: 54000300     	b.eq	0x87c <item_name+0x70>
     820: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000820:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a8
     824: f9400108     	ldr	x8, [x8]
		0000000000000824:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1a8
     828: eb08001f     	cmp	x0, x8
     82c: 540002c0     	b.eq	0x884 <item_name+0x78>
     830: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000830:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b0
     834: f9400108     	ldr	x8, [x8]
		0000000000000834:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1b0
     838: eb08001f     	cmp	x0, x8
     83c: 54000280     	b.eq	0x88c <item_name+0x80>
     840: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000840:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b8
     844: f9400108     	ldr	x8, [x8]
		0000000000000844:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1b8
     848: eb08001f     	cmp	x0, x8
     84c: 54000240     	b.eq	0x894 <item_name+0x88>
     850: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000850:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c0
     854: f9400108     	ldr	x8, [x8]
		0000000000000854:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c0
     858: eb08001f     	cmp	x0, x8
     85c: 54000200     	b.eq	0x89c <item_name+0x90>
     860: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000860:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c8
     864: f9400108     	ldr	x8, [x8]
		0000000000000864:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c8
     868: eb08001f     	cmp	x0, x8
     86c: 540001c0     	b.eq	0x8a4 <item_name+0x98>
     870: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000870:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
     874: 91000108     	add	x8, x8, #0x0
		0000000000000874:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
     878: 1400000f     	b	0x8b4 <item_name+0xa8>
     87c: aa1f03e8     	mov	x8, xzr
     880: 1400000a     	b	0x8a8 <item_name+0x9c>
     884: 52800028     	mov	w8, #0x1                // =1
     888: 14000008     	b	0x8a8 <item_name+0x9c>
     88c: 52800048     	mov	w8, #0x2                // =2
     890: 14000006     	b	0x8a8 <item_name+0x9c>
     894: 52800068     	mov	w8, #0x3                // =3
     898: 14000004     	b	0x8a8 <item_name+0x9c>
     89c: 52800088     	mov	w8, #0x4                // =4
     8a0: 14000002     	b	0x8a8 <item_name+0x9c>
     8a4: 528000a8     	mov	w8, #0x5                // =5
     8a8: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000008a8:  R_AARCH64_ADR_PREL_PG_HI21	.data.rel.ro+0xf0
     8ac: 91000129     	add	x9, x9, #0x0
		00000000000008ac:  R_AARCH64_ADD_ABS_LO12_NC	.data.rel.ro+0xf0
     8b0: f8687928     	ldr	x8, [x9, x8, lsl #3]
     8b4: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000008b4:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
     8b8: 91000000     	add	x0, x0, #0x0
		00000000000008b8:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
     8bc: b4000221     	cbz	x1, 0x900 <item_name+0xf4>
     8c0: 71000449     	subs	w9, w2, #0x1
     8c4: 540001eb     	b.lt	0x900 <item_name+0xf4>
     8c8: 7100085f     	cmp	w2, #0x2
     8cc: 54000143     	b.lo	0x8f4 <item_name+0xe8>
     8d0: aa1f03ea     	mov	x10, xzr
     8d4: 386a690b     	ldrb	w11, [x8, x10]
     8d8: 3400010b     	cbz	w11, 0x8f8 <item_name+0xec>
     8dc: 382a682b     	strb	w11, [x1, x10]
     8e0: 9100054a     	add	x10, x10, #0x1
     8e4: eb0a013f     	cmp	x9, x10
     8e8: 54ffff61     	b.ne	0x8d4 <item_name+0xc8>
     8ec: aa0903ea     	mov	x10, x9
     8f0: 14000002     	b	0x8f8 <item_name+0xec>
     8f4: aa1f03ea     	mov	x10, xzr
     8f8: aa0103e0     	mov	x0, x1
     8fc: 382a683f     	strb	wzr, [x1, x10]
     900: d65f03c0     	ret

0000000000000904 <item_value>:
     904: d10103ff     	sub	sp, sp, #0x40
     908: a9017bfd     	stp	x29, x30, [sp, #0x10]
     90c: f90013f5     	str	x21, [sp, #0x20]
     910: a9034ff4     	stp	x20, x19, [sp, #0x30]
     914: 910043fd     	add	x29, sp, #0x10
     918: 2a0203f4     	mov	w20, w2
     91c: aa0103f3     	mov	x19, x1
     920: b4000320     	cbz	x0, 0x984 <item_value+0x80>
     924: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000924:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a0
     928: f9400108     	ldr	x8, [x8]
		0000000000000928:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1a0
     92c: eb08001f     	cmp	x0, x8
     930: 54000300     	b.eq	0x990 <item_value+0x8c>
     934: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000934:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a8
     938: f9400108     	ldr	x8, [x8]
		0000000000000938:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1a8
     93c: eb08001f     	cmp	x0, x8
     940: 540002c0     	b.eq	0x998 <item_value+0x94>
     944: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000944:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b0
     948: f9400108     	ldr	x8, [x8]
		0000000000000948:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1b0
     94c: eb08001f     	cmp	x0, x8
     950: 54000280     	b.eq	0x9a0 <item_value+0x9c>
     954: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000954:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b8
     958: f9400108     	ldr	x8, [x8]
		0000000000000958:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1b8
     95c: eb08001f     	cmp	x0, x8
     960: 54000240     	b.eq	0x9a8 <item_value+0xa4>
     964: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000964:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c0
     968: f9400108     	ldr	x8, [x8]
		0000000000000968:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c0
     96c: eb08001f     	cmp	x0, x8
     970: 54000200     	b.eq	0x9b0 <item_value+0xac>
     974: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000974:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c8
     978: f9400108     	ldr	x8, [x8]
		0000000000000978:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c8
     97c: eb08001f     	cmp	x0, x8
     980: 540001c0     	b.eq	0x9b8 <item_value+0xb4>
     984: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000984:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
     988: 91000108     	add	x8, x8, #0x0
		0000000000000988:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
     98c: 14000019     	b	0x9f0 <item_value+0xec>
     990: aa1f03f5     	mov	x21, xzr
     994: 1400000a     	b	0x9bc <item_value+0xb8>
     998: 52800035     	mov	w21, #0x1               // =1
     99c: 14000008     	b	0x9bc <item_value+0xb8>
     9a0: 52800055     	mov	w21, #0x2               // =2
     9a4: 14000006     	b	0x9bc <item_value+0xb8>
     9a8: 52800075     	mov	w21, #0x3               // =3
     9ac: 14000004     	b	0x9bc <item_value+0xb8>
     9b0: 52800095     	mov	w21, #0x4               // =4
     9b4: 14000002     	b	0x9bc <item_value+0xb8>
     9b8: 528000b5     	mov	w21, #0x5               // =5
     9bc: 910003e0     	mov	x0, sp
     9c0: 94000000     	bl	0x9c0 <item_value+0xbc>
		00000000000009c0:  R_AARCH64_CALL26	iq4_f3_settings_snapshot_06
     9c4: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000009c4:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
     9c8: 91000108     	add	x8, x8, #0x0
		00000000000009c8:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
     9cc: 34000120     	cbz	w0, 0x9f0 <item_value+0xec>
     9d0: 9000000a     	adrp	x10, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000009d0:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str4.4
     9d4: 9100014a     	add	x10, x10, #0x0
		00000000000009d4:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str4.4
     9d8: b9400be9     	ldr	w9, [sp, #0x8]
     9dc: b875794a     	ldr	w10, [x10, x21, lsl #2]
     9e0: 6b0a013f     	cmp	w9, w10
     9e4: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000009e4:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x2e
     9e8: 91000129     	add	x9, x9, #0x0
		00000000000009e8:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x2e
     9ec: 9a880128     	csel	x8, x9, x8, eq
     9f0: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000009f0:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
     9f4: 91000000     	add	x0, x0, #0x0
		00000000000009f4:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
     9f8: b4000233     	cbz	x19, 0xa3c <item_value+0x138>
     9fc: 71000689     	subs	w9, w20, #0x1
     a00: 540001eb     	b.lt	0xa3c <item_value+0x138>
     a04: 71000a9f     	cmp	w20, #0x2
     a08: 54000143     	b.lo	0xa30 <item_value+0x12c>
     a0c: aa1f03ea     	mov	x10, xzr
     a10: 386a690b     	ldrb	w11, [x8, x10]
     a14: 3400010b     	cbz	w11, 0xa34 <item_value+0x130>
     a18: 382a6a6b     	strb	w11, [x19, x10]
     a1c: 9100054a     	add	x10, x10, #0x1
     a20: eb0a013f     	cmp	x9, x10
     a24: 54ffff61     	b.ne	0xa10 <item_value+0x10c>
     a28: aa0903ea     	mov	x10, x9
     a2c: 14000002     	b	0xa34 <item_value+0x130>
     a30: aa1f03ea     	mov	x10, xzr
     a34: aa1303e0     	mov	x0, x19
     a38: 382a6a7f     	strb	wzr, [x19, x10]
     a3c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
     a40: f94013f5     	ldr	x21, [sp, #0x20]
     a44: a9417bfd     	ldp	x29, x30, [sp, #0x10]
     a48: 910103ff     	add	sp, sp, #0x40
     a4c: d65f03c0     	ret

0000000000000a50 <activate>:
     a50: d10183ff     	sub	sp, sp, #0x60
     a54: a9037bfd     	stp	x29, x30, [sp, #0x30]
     a58: f90023f5     	str	x21, [sp, #0x40]
     a5c: a9054ff4     	stp	x20, x19, [sp, #0x50]
     a60: 9100c3fd     	add	x29, sp, #0x30
     a64: b4001300     	cbz	x0, 0xcc4 <activate+0x274>
     a68: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000a68:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a0
     a6c: f9400108     	ldr	x8, [x8]
		0000000000000a6c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1a0
     a70: eb08001f     	cmp	x0, x8
     a74: 540002e0     	b.eq	0xad0 <activate+0x80>
     a78: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000a78:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a8
     a7c: f9400108     	ldr	x8, [x8]
		0000000000000a7c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1a8
     a80: eb08001f     	cmp	x0, x8
     a84: 540002a0     	b.eq	0xad8 <activate+0x88>
     a88: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000a88:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b0
     a8c: f9400108     	ldr	x8, [x8]
		0000000000000a8c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1b0
     a90: eb08001f     	cmp	x0, x8
     a94: 54000260     	b.eq	0xae0 <activate+0x90>
     a98: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000a98:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b8
     a9c: f9400108     	ldr	x8, [x8]
		0000000000000a9c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1b8
     aa0: eb08001f     	cmp	x0, x8
     aa4: 54000220     	b.eq	0xae8 <activate+0x98>
     aa8: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000aa8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c0
     aac: f9400108     	ldr	x8, [x8]
		0000000000000aac:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c0
     ab0: eb08001f     	cmp	x0, x8
     ab4: 540001e0     	b.eq	0xaf0 <activate+0xa0>
     ab8: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000ab8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c8
     abc: f9400108     	ldr	x8, [x8]
		0000000000000abc:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c8
     ac0: eb08001f     	cmp	x0, x8
     ac4: 54001001     	b.ne	0xcc4 <activate+0x274>
     ac8: 528000b4     	mov	w20, #0x5               // =5
     acc: 1400000a     	b	0xaf4 <activate+0xa4>
     ad0: aa1f03f4     	mov	x20, xzr
     ad4: 14000008     	b	0xaf4 <activate+0xa4>
     ad8: 52800034     	mov	w20, #0x1               // =1
     adc: 14000006     	b	0xaf4 <activate+0xa4>
     ae0: 52800054     	mov	w20, #0x2               // =2
     ae4: 14000004     	b	0xaf4 <activate+0xa4>
     ae8: 52800074     	mov	w20, #0x3               // =3
     aec: 14000002     	b	0xaf4 <activate+0xa4>
     af0: 52800094     	mov	w20, #0x4               // =4
     af4: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000af4:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     af8: a9007fff     	stp	xzr, xzr, [sp]
     afc: 39400108     	ldrb	w8, [x8]
		0000000000000afc:  R_AARCH64_LDST8_ABS_LO12_NC	.bss
     b00: 37000e28     	tbnz	w8, #0x0, 0xcc4 <activate+0x274>
     b04: 90000015     	adrp	x21, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000b04:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x18
     b08: f94002a8     	ldr	x8, [x21]
		0000000000000b08:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x18
     b0c: b4000dc8     	cbz	x8, 0xcc4 <activate+0x274>
     b10: d10023a0     	sub	x0, x29, #0x8
     b14: 94000000     	bl	0xb14 <activate+0xc4>
		0000000000000b14:  R_AARCH64_CALL26	iq4_f4_native_current_02
     b18: 34000d60     	cbz	w0, 0xcc4 <activate+0x274>
     b1c: f85f83b3     	ldur	x19, [x29, #-0x8]
     b20: f94002a8     	ldr	x8, [x21]
		0000000000000b20:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x18
     b24: eb08027f     	cmp	x19, x8
     b28: 54000ce1     	b.ne	0xcc4 <activate+0x274>
     b2c: 91002268     	add	x8, x19, #0x8
     b30: d343fd08     	lsr	x8, x8, #3
     b34: f108051f     	cmp	x8, #0x201
     b38: 54000c63     	b.lo	0xcc4 <activate+0x274>
     b3c: d10043a2     	sub	x2, x29, #0x10
     b40: aa1f03e0     	mov	x0, xzr
     b44: aa1303e1     	mov	x1, x19
     b48: 52800103     	mov	w3, #0x8                // =8
     b4c: 94000000     	bl	0xb4c <activate+0xfc>
		0000000000000b4c:  R_AARCH64_CALL26	iq4_native_self_read_01
     b50: 7100041f     	cmp	w0, #0x1
     b54: 54000b81     	b.ne	0xcc4 <activate+0x274>
     b58: 910063a2     	add	x2, x29, #0x18
     b5c: aa1f03e0     	mov	x0, xzr
     b60: aa1303e1     	mov	x1, x19
     b64: 52800103     	mov	w3, #0x8                // =8
     b68: 94000000     	bl	0xb68 <activate+0x118>
		0000000000000b68:  R_AARCH64_CALL26	iq4_native_self_read_01
     b6c: 7100041f     	cmp	w0, #0x1
     b70: 54000aa1     	b.ne	0xcc4 <activate+0x274>
     b74: f9400fa9     	ldr	x9, [x29, #0x18]
     b78: 5283e908     	mov	w8, #0x1f48             // =8008
     b7c: 72a01728     	movk	w8, #0xb9, lsl #16
     b80: eb08013f     	cmp	x9, x8
     b84: 54000a01     	b.ne	0xcc4 <activate+0x274>
     b88: f85f03a9     	ldur	x9, [x29, #-0x10]
     b8c: eb08013f     	cmp	x9, x8
     b90: 540009a1     	b.ne	0xcc4 <activate+0x274>
     b94: f85f83b3     	ldur	x19, [x29, #-0x8]
     b98: 91074268     	add	x8, x19, #0x1d0
     b9c: d343fd08     	lsr	x8, x8, #3
     ba0: f108051f     	cmp	x8, #0x201
     ba4: 54000903     	b.lo	0xcc4 <activate+0x274>
     ba8: 91072261     	add	x1, x19, #0x1c8
     bac: 910063e2     	add	x2, sp, #0x18
     bb0: aa1f03e0     	mov	x0, xzr
     bb4: 52800103     	mov	w3, #0x8                // =8
     bb8: 94000000     	bl	0xbb8 <activate+0x168>
		0000000000000bb8:  R_AARCH64_CALL26	iq4_native_self_read_01
     bbc: 7100041f     	cmp	w0, #0x1
     bc0: 54000821     	b.ne	0xcc4 <activate+0x274>
     bc4: 91072261     	add	x1, x19, #0x1c8
     bc8: 910063a2     	add	x2, x29, #0x18
     bcc: aa1f03e0     	mov	x0, xzr
     bd0: 52800103     	mov	w3, #0x8                // =8
     bd4: 94000000     	bl	0xbd4 <activate+0x184>
		0000000000000bd4:  R_AARCH64_CALL26	iq4_native_self_read_01
     bd8: 7100041f     	cmp	w0, #0x1
     bdc: 54000741     	b.ne	0xcc4 <activate+0x274>
     be0: f9400fb3     	ldr	x19, [x29, #0x18]
     be4: f9400fe8     	ldr	x8, [sp, #0x18]
     be8: eb08027f     	cmp	x19, x8
     bec: 540006c1     	b.ne	0xcc4 <activate+0x274>
     bf0: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000bf0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x20
     bf4: f9400108     	ldr	x8, [x8]
		0000000000000bf4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x20
     bf8: eb08027f     	cmp	x19, x8
     bfc: 54000641     	b.ne	0xcc4 <activate+0x274>
     c00: 91002268     	add	x8, x19, #0x8
     c04: d343fd08     	lsr	x8, x8, #3
     c08: f108051f     	cmp	x8, #0x201
     c0c: 540005c3     	b.lo	0xcc4 <activate+0x274>
     c10: d10043a2     	sub	x2, x29, #0x10
     c14: aa1f03e0     	mov	x0, xzr
     c18: aa1303e1     	mov	x1, x19
     c1c: 52800103     	mov	w3, #0x8                // =8
     c20: 94000000     	bl	0xc20 <activate+0x1d0>
		0000000000000c20:  R_AARCH64_CALL26	iq4_native_self_read_01
     c24: 7100041f     	cmp	w0, #0x1
     c28: 540004e1     	b.ne	0xcc4 <activate+0x274>
     c2c: 910063a2     	add	x2, x29, #0x18
     c30: aa1f03e0     	mov	x0, xzr
     c34: aa1303e1     	mov	x1, x19
     c38: 52800103     	mov	w3, #0x8                // =8
     c3c: 94000000     	bl	0xc3c <activate+0x1ec>
		0000000000000c3c:  R_AARCH64_CALL26	iq4_native_self_read_01
     c40: 7100041f     	cmp	w0, #0x1
     c44: 54000401     	b.ne	0xcc4 <activate+0x274>
     c48: f9400fa9     	ldr	x9, [x29, #0x18]
     c4c: 529e6b08     	mov	w8, #0xf358             // =62296
     c50: 72a01708     	movk	w8, #0xb8, lsl #16
     c54: eb08013f     	cmp	x9, x8
     c58: 54000361     	b.ne	0xcc4 <activate+0x274>
     c5c: f85f03a9     	ldur	x9, [x29, #-0x10]
     c60: eb08013f     	cmp	x9, x8
     c64: 54000301     	b.ne	0xcc4 <activate+0x274>
     c68: f9400fe8     	ldr	x8, [sp, #0x18]
     c6c: 910043e1     	add	x1, sp, #0x10
     c70: 91002100     	add	x0, x8, #0x8
     c74: 97fffe77     	bl	0x650 <word>
     c78: 34000260     	cbz	w0, 0xcc4 <activate+0x274>
     c7c: f9400be8     	ldr	x8, [sp, #0x10]
     c80: f85f83a9     	ldur	x9, [x29, #-0x8]
     c84: eb09011f     	cmp	x8, x9
     c88: 540001e1     	b.ne	0xcc4 <activate+0x274>
     c8c: 910003e0     	mov	x0, sp
     c90: 94000000     	bl	0xc90 <activate+0x240>
		0000000000000c90:  R_AARCH64_CALL26	iq4_activity_snapshot_01
     c94: 2a0003e8     	mov	w8, w0
     c98: 2a1f03e0     	mov	w0, wzr
     c9c: 35000168     	cbnz	w8, 0xcc8 <activate+0x278>
     ca0: b9400be8     	ldr	w8, [sp, #0x8]
     ca4: 35000128     	cbnz	w8, 0xcc8 <activate+0x278>
     ca8: b9400fe8     	ldr	w8, [sp, #0xc]
     cac: 350000e8     	cbnz	w8, 0xcc8 <activate+0x278>
     cb0: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000cb0:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str4.4
     cb4: 91000108     	add	x8, x8, #0x0
		0000000000000cb4:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str4.4
     cb8: b8747900     	ldr	w0, [x8, x20, lsl #2]
     cbc: 94000000     	bl	0xcbc <activate+0x26c>
		0000000000000cbc:  R_AARCH64_CALL26	iq4_f3_scale_set_on_ui_01
     cc0: 14000002     	b	0xcc8 <activate+0x278>
     cc4: 2a1f03e0     	mov	w0, wzr
     cc8: a9454ff4     	ldp	x20, x19, [sp, #0x50]
     ccc: f94023f5     	ldr	x21, [sp, #0x40]
     cd0: a9437bfd     	ldp	x29, x30, [sp, #0x30]
     cd4: 910183ff     	add	sp, sp, #0x60
     cd8: d65f03c0     	ret

0000000000000cdc <construct>:
     cdc: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
     ce0: f9000bf5     	str	x21, [sp, #0x10]
     ce4: a9024ff4     	stp	x20, x19, [sp, #0x20]
     ce8: 910003fd     	mov	x29, sp
     cec: aa0003f4     	mov	x20, x0
     cf0: aa0103e0     	mov	x0, x1
     cf4: aa0303f3     	mov	x19, x3
     cf8: aa1403e1     	mov	x1, x20
     cfc: aa0203f5     	mov	x21, x2
     d00: 94000000     	bl	0xd00 <construct+0x24>
		0000000000000d00:  R_AARCH64_CALL26	iq4_f4_menu_new_03
     d04: 340001e0     	cbz	w0, 0xd40 <construct+0x64>
     d08: f9400281     	ldr	x1, [x20]
     d0c: b4000181     	cbz	x1, 0xd3c <construct+0x60>
     d10: aa1503e0     	mov	x0, x21
     d14: 94000000     	bl	0xd14 <construct+0x38>
		0000000000000d14:  R_AARCH64_CALL26	iq4_f4_menu_ctor_03
     d18: 34000140     	cbz	w0, 0xd40 <construct+0x64>
     d1c: f9400280     	ldr	x0, [x20]
     d20: 91004268     	add	x8, x19, #0x10
     d24: 910063a1     	add	x1, x29, #0x18
     d28: 52800102     	mov	w2, #0x8                // =8
     d2c: f9000fa8     	str	x8, [x29, #0x18]
     d30: 94000000     	bl	0xd30 <construct+0x54>
		0000000000000d30:  R_AARCH64_CALL26	memcpy
     d34: 52800020     	mov	w0, #0x1                // =1
     d38: 14000002     	b	0xd40 <construct+0x64>
     d3c: 2a1f03e0     	mov	w0, wzr
     d40: a9424ff4     	ldp	x20, x19, [sp, #0x20]
     d44: f9400bf5     	ldr	x21, [sp, #0x10]
     d48: a8c37bfd     	ldp	x29, x30, [sp], #0x30
     d4c: d65f03c0     	ret
