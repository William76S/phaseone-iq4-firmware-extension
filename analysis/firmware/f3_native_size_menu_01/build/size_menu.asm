
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_native_size_menu_01/build/size_menu.o:	file format elf64-littleaarch64

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
      84: f240081f     	tst	x0, #0x7
      88: 54001ae1     	b.ne	0x3e4 <iq4_f3_storage_size_child_01+0x360>
      8c: f140041f     	cmp	x0, #0x1, lsl #12       // =0x1000
      90: 54001aa3     	b.lo	0x3e4 <iq4_f3_storage_size_child_01+0x360>
      94: b4001a81     	cbz	x1, 0x3e4 <iq4_f3_storage_size_child_01+0x360>
      98: b4001a60     	cbz	x0, 0x3e4 <iq4_f3_storage_size_child_01+0x360>
      9c: 5280a588     	mov	w8, #0x52c              // =1324
      a0: 72a009e8     	movk	w8, #0x4f, lsl #16
      a4: eb08005f     	cmp	x2, x8
      a8: 540019e1     	b.ne	0x3e4 <iq4_f3_storage_size_child_01+0x360>
      ac: f240083f     	tst	x1, #0x7
      b0: 540019a1     	b.ne	0x3e4 <iq4_f3_storage_size_child_01+0x360>
      b4: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000000b4:  R_AARCH64_ADR_PREL_PG_HI21	.bss
      b8: 39400108     	ldrb	w8, [x8]
		00000000000000b8:  R_AARCH64_LDST8_ABS_LO12_NC	.bss
      bc: 37001948     	tbnz	w8, #0x0, 0x3e4 <iq4_f3_storage_size_child_01+0x360>
      c0: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000000c0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x4
      c4: 39400108     	ldrb	w8, [x8]
		00000000000000c4:  R_AARCH64_LDST8_ABS_LO12_NC	.bss+0x4
      c8: 370018e8     	tbnz	w8, #0x0, 0x3e4 <iq4_f3_storage_size_child_01+0x360>
      cc: d10383ff     	sub	sp, sp, #0xe0
      d0: a9087bfd     	stp	x29, x30, [sp, #0x80]
      d4: a9096ffc     	stp	x28, x27, [sp, #0x90]
      d8: a90a67fa     	stp	x26, x25, [sp, #0xa0]
      dc: a90b5ff8     	stp	x24, x23, [sp, #0xb0]
      e0: a90c57f6     	stp	x22, x21, [sp, #0xc0]
      e4: a90d4ff4     	stp	x20, x19, [sp, #0xd0]
      e8: 910203fd     	add	x29, sp, #0x80
      ec: aa1f03f7     	mov	x23, xzr
      f0: 52800318     	mov	w24, #0x18              // =24
      f4: 9000001a     	adrp	x26, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000000f4:  R_AARCH64_ADR_PREL_PG_HI21	.data.rel.ro
      f8: 9100035a     	add	x26, x26, #0x0
		00000000000000f8:  R_AARCH64_ADD_ABS_LO12_NC	.data.rel.ro
      fc: 5280081b     	mov	w27, #0x40              // =64
     100: a90087e0     	stp	x0, x1, [sp, #0x8]
     104: 9b186afc     	madd	x28, x23, x24, x26
     108: f9400794     	ldr	x20, [x28, #0x8]
     10c: b4000394     	cbz	x20, 0x17c <iq4_f3_storage_size_child_01+0xf8>
     110: f9400396     	ldr	x22, [x28]
     114: aa1f03f3     	mov	x19, xzr
     118: aa1403e8     	mov	x8, x20
     11c: f1010119     	subs	x25, x8, #0x40
     120: 8b1302c1     	add	x1, x22, x19
     124: 9a9b3115     	csel	x21, x8, x27, lo
     128: ab0102bf     	cmn	x21, x1
     12c: 1a9f37e8     	cset	w8, hs
     130: f140043f     	cmp	x1, #0x1, lsl #12       // =0x1000
     134: 54001483     	b.lo	0x3c4 <iq4_f3_storage_size_child_01+0x340>
     138: 37001468     	tbnz	w8, #0x0, 0x3c4 <iq4_f3_storage_size_child_01+0x340>
     13c: 910103e2     	add	x2, sp, #0x40
     140: aa1f03e0     	mov	x0, xzr
     144: aa1503e3     	mov	x3, x21
     148: 94000000     	bl	0x148 <iq4_f3_storage_size_child_01+0xc4>
		0000000000000148:  R_AARCH64_CALL26	iq4_native_self_read_01
     14c: 7100041f     	cmp	w0, #0x1
     150: 540013a1     	b.ne	0x3c4 <iq4_f3_storage_size_child_01+0x340>
     154: f9400b88     	ldr	x8, [x28, #0x10]
     158: 910103e0     	add	x0, sp, #0x40
     15c: aa1503e2     	mov	x2, x21
     160: 8b130101     	add	x1, x8, x19
     164: 94000000     	bl	0x164 <iq4_f3_storage_size_child_01+0xe0>
		0000000000000164:  R_AARCH64_CALL26	memcmp
     168: 350012e0     	cbnz	w0, 0x3c4 <iq4_f3_storage_size_child_01+0x340>
     16c: 91010273     	add	x19, x19, #0x40
     170: aa1903e8     	mov	x8, x25
     174: eb14027f     	cmp	x19, x20
     178: 54fffd23     	b.lo	0x11c <iq4_f3_storage_size_child_01+0x98>
     17c: 910006f7     	add	x23, x23, #0x1
     180: f1002aff     	cmp	x23, #0xa
     184: 54fffc01     	b.ne	0x104 <iq4_f3_storage_size_child_01+0x80>
     188: f94007e8     	ldr	x8, [sp, #0x8]
     18c: 91002108     	add	x8, x8, #0x8
     190: d343fd08     	lsr	x8, x8, #3
     194: f108051f     	cmp	x8, #0x201
     198: 54001163     	b.lo	0x3c4 <iq4_f3_storage_size_child_01+0x340>
     19c: f94007e1     	ldr	x1, [sp, #0x8]
     1a0: 9100e3e2     	add	x2, sp, #0x38
     1a4: aa1f03e0     	mov	x0, xzr
     1a8: 52800103     	mov	w3, #0x8                // =8
     1ac: 94000000     	bl	0x1ac <iq4_f3_storage_size_child_01+0x128>
		00000000000001ac:  R_AARCH64_CALL26	iq4_native_self_read_01
     1b0: 7100041f     	cmp	w0, #0x1
     1b4: 54001081     	b.ne	0x3c4 <iq4_f3_storage_size_child_01+0x340>
     1b8: f94007e1     	ldr	x1, [sp, #0x8]
     1bc: 910103e2     	add	x2, sp, #0x40
     1c0: aa1f03e0     	mov	x0, xzr
     1c4: 52800103     	mov	w3, #0x8                // =8
     1c8: 94000000     	bl	0x1c8 <iq4_f3_storage_size_child_01+0x144>
		00000000000001c8:  R_AARCH64_CALL26	iq4_native_self_read_01
     1cc: 7100041f     	cmp	w0, #0x1
     1d0: 54000fa1     	b.ne	0x3c4 <iq4_f3_storage_size_child_01+0x340>
     1d4: f94007e8     	ldr	x8, [sp, #0x8]
     1d8: 91006109     	add	x9, x8, #0x18
     1dc: d342fd29     	lsr	x9, x9, #2
     1e0: f110053f     	cmp	x9, #0x401
     1e4: 54000f03     	b.lo	0x3c4 <iq4_f3_storage_size_child_01+0x340>
     1e8: f94023e9     	ldr	x9, [sp, #0x40]
     1ec: 529f3717     	mov	w23, #0xf9b8            // =63928
     1f0: f9400be1     	ldr	x1, [sp, #0x10]
     1f4: 72a01717     	movk	w23, #0xb8, lsl #16
     1f8: eb17013f     	cmp	x9, x23
     1fc: 54000e61     	b.ne	0x3c8 <iq4_f3_storage_size_child_01+0x344>
     200: f9401fe9     	ldr	x9, [sp, #0x38]
     204: eb17013f     	cmp	x9, x23
     208: 54000e01     	b.ne	0x3c8 <iq4_f3_storage_size_child_01+0x344>
     20c: 91005101     	add	x1, x8, #0x14
     210: 910073e2     	add	x2, sp, #0x1c
     214: aa1f03e0     	mov	x0, xzr
     218: 52800083     	mov	w3, #0x4                // =4
     21c: 94000000     	bl	0x21c <iq4_f3_storage_size_child_01+0x198>
		000000000000021c:  R_AARCH64_CALL26	iq4_native_self_read_01
     220: 7100041f     	cmp	w0, #0x1
     224: 54000d01     	b.ne	0x3c4 <iq4_f3_storage_size_child_01+0x340>
     228: b9401fe8     	ldr	w8, [sp, #0x1c]
     22c: f9400be1     	ldr	x1, [sp, #0x10]
     230: 7106151f     	cmp	w8, #0x185
     234: 54000ca1     	b.ne	0x3c8 <iq4_f3_storage_size_child_01+0x344>
     238: 91002028     	add	x8, x1, #0x8
     23c: d343fd08     	lsr	x8, x8, #3
     240: f108051f     	cmp	x8, #0x201
     244: 54000c23     	b.lo	0x3c8 <iq4_f3_storage_size_child_01+0x344>
     248: f9400be1     	ldr	x1, [sp, #0x10]
     24c: 9100e3e2     	add	x2, sp, #0x38
     250: aa1f03e0     	mov	x0, xzr
     254: 52800103     	mov	w3, #0x8                // =8
     258: 94000000     	bl	0x258 <iq4_f3_storage_size_child_01+0x1d4>
		0000000000000258:  R_AARCH64_CALL26	iq4_native_self_read_01
     25c: f9400be1     	ldr	x1, [sp, #0x10]
     260: 7100041f     	cmp	w0, #0x1
     264: 54000b21     	b.ne	0x3c8 <iq4_f3_storage_size_child_01+0x344>
     268: f9400be1     	ldr	x1, [sp, #0x10]
     26c: 910103e2     	add	x2, sp, #0x40
     270: aa1f03e0     	mov	x0, xzr
     274: 52800103     	mov	w3, #0x8                // =8
     278: 94000000     	bl	0x278 <iq4_f3_storage_size_child_01+0x1f4>
		0000000000000278:  R_AARCH64_CALL26	iq4_native_self_read_01
     27c: f9400be1     	ldr	x1, [sp, #0x10]
     280: 7100041f     	cmp	w0, #0x1
     284: 54000a21     	b.ne	0x3c8 <iq4_f3_storage_size_child_01+0x344>
     288: f94023e9     	ldr	x9, [sp, #0x40]
     28c: 910e22e8     	add	x8, x23, #0x388
     290: 90000018     	adrp	x24, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000290:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     294: 90000015     	adrp	x21, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000294:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x4
     298: eb08013f     	cmp	x9, x8
     29c: 54000941     	b.ne	0x3c4 <iq4_f3_storage_size_child_01+0x340>
     2a0: f9401fe9     	ldr	x9, [sp, #0x38]
     2a4: eb08013f     	cmp	x9, x8
     2a8: 540008e1     	b.ne	0x3c4 <iq4_f3_storage_size_child_01+0x340>
     2ac: f9400be8     	ldr	x8, [sp, #0x10]
     2b0: 910103e1     	add	x1, sp, #0x40
     2b4: 91006100     	add	x0, x8, #0x18
     2b8: 940000e5     	bl	0x64c <word>
     2bc: 34000840     	cbz	w0, 0x3c4 <iq4_f3_storage_size_child_01+0x340>
     2c0: f94023e0     	ldr	x0, [sp, #0x40]
     2c4: 9100e3e1     	add	x1, sp, #0x38
     2c8: 940000e1     	bl	0x64c <word>
     2cc: 340007c0     	cbz	w0, 0x3c4 <iq4_f3_storage_size_child_01+0x340>
     2d0: f9401fe8     	ldr	x8, [sp, #0x38]
     2d4: d16efd08     	sub	x8, x8, #0xbbf, lsl #12 // =0xbbf000
     2d8: f10fe11f     	cmp	x8, #0x3f8
     2dc: 54000741     	b.ne	0x3c4 <iq4_f3_storage_size_child_01+0x340>
     2e0: 9100c3e0     	add	x0, sp, #0x30
     2e4: 94000000     	bl	0x2e4 <iq4_f3_storage_size_child_01+0x260>
		00000000000002e4:  R_AARCH64_CALL26	iq4_f4_native_current_02
     2e8: 340006e0     	cbz	w0, 0x3c4 <iq4_f3_storage_size_child_01+0x340>
     2ec: f9401be0     	ldr	x0, [sp, #0x30]
     2f0: 9100e3e1     	add	x1, sp, #0x38
     2f4: 940000d6     	bl	0x64c <word>
     2f8: 34000660     	cbz	w0, 0x3c4 <iq4_f3_storage_size_child_01+0x340>
     2fc: f9401fe8     	ldr	x8, [sp, #0x38]
     300: d16e4508     	sub	x8, x8, #0xb91, lsl #12 // =0xb91000
     304: f13d211f     	cmp	x8, #0xf48
     308: 540005e1     	b.ne	0x3c4 <iq4_f3_storage_size_child_01+0x340>
     30c: f9401be8     	ldr	x8, [sp, #0x30]
     310: 9100a3e1     	add	x1, sp, #0x28
     314: 91072100     	add	x0, x8, #0x1c8
     318: 940000cd     	bl	0x64c <word>
     31c: 34000540     	cbz	w0, 0x3c4 <iq4_f3_storage_size_child_01+0x340>
     320: f94017e0     	ldr	x0, [sp, #0x28]
     324: 9100e3e1     	add	x1, sp, #0x38
     328: 940000c9     	bl	0x64c <word>
     32c: 340004c0     	cbz	w0, 0x3c4 <iq4_f3_storage_size_child_01+0x340>
     330: f9401fe8     	ldr	x8, [sp, #0x38]
     334: d11982e9     	sub	x9, x23, #0x660
     338: eb09011f     	cmp	x8, x9
     33c: 54000441     	b.ne	0x3c4 <iq4_f3_storage_size_child_01+0x340>
     340: f94017e8     	ldr	x8, [sp, #0x28]
     344: 910083e1     	add	x1, sp, #0x20
     348: 91002100     	add	x0, x8, #0x8
     34c: 940000c0     	bl	0x64c <word>
     350: 340003a0     	cbz	w0, 0x3c4 <iq4_f3_storage_size_child_01+0x340>
     354: f94013e8     	ldr	x8, [sp, #0x20]
     358: f9401be9     	ldr	x9, [sp, #0x30]
     35c: eb09011f     	cmp	x8, x9
     360: 54000321     	b.ne	0x3c4 <iq4_f3_storage_size_child_01+0x340>
     364: 9000001a     	adrp	x26, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000364:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x8
     368: f9400349     	ldr	x9, [x26]
		0000000000000368:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x8
     36c: b4000409     	cbz	x9, 0x3ec <iq4_f3_storage_size_child_01+0x368>
     370: f94007ea     	ldr	x10, [sp, #0x8]
     374: eb0a013f     	cmp	x9, x10
     378: 54000261     	b.ne	0x3c4 <iq4_f3_storage_size_child_01+0x340>
     37c: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000037c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x10
     380: f940012a     	ldr	x10, [x9]
		0000000000000380:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x10
     384: f9400be9     	ldr	x9, [sp, #0x10]
     388: eb09015f     	cmp	x10, x9
     38c: 540001c1     	b.ne	0x3c4 <iq4_f3_storage_size_child_01+0x340>
     390: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000390:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x18
     394: f9400129     	ldr	x9, [x9]
		0000000000000394:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x18
     398: eb08013f     	cmp	x9, x8
     39c: 54000141     	b.ne	0x3c4 <iq4_f3_storage_size_child_01+0x340>
     3a0: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000003a0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x20
     3a4: f94017e9     	ldr	x9, [sp, #0x28]
     3a8: 9000000a     	adrp	x10, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000003a8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x28
     3ac: f9400108     	ldr	x8, [x8]
		00000000000003ac:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x20
     3b0: f940014a     	ldr	x10, [x10]
		00000000000003b0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     3b4: f9400be1     	ldr	x1, [sp, #0x10]
     3b8: eb09011f     	cmp	x8, x9
     3bc: 9a810141     	csel	x1, x10, x1, eq
     3c0: 14000002     	b	0x3c8 <iq4_f3_storage_size_child_01+0x344>
     3c4: f9400be1     	ldr	x1, [sp, #0x10]
     3c8: a94d4ff4     	ldp	x20, x19, [sp, #0xd0]
     3cc: a94c57f6     	ldp	x22, x21, [sp, #0xc0]
     3d0: a94b5ff8     	ldp	x24, x23, [sp, #0xb0]
     3d4: a94a67fa     	ldp	x26, x25, [sp, #0xa0]
     3d8: a9496ffc     	ldp	x28, x27, [sp, #0x90]
     3dc: a9487bfd     	ldp	x29, x30, [sp, #0x80]
     3e0: 910383ff     	add	sp, sp, #0xe0
     3e4: aa0103e0     	mov	x0, x1
     3e8: d65f03c0     	ret
     3ec: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000003ec:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x18
     3f0: f94017ea     	ldr	x10, [sp, #0x28]
     3f4: 90000019     	adrp	x25, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000003f4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x30
     3f8: 91000339     	add	x25, x25, #0x0
		00000000000003f8:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x30
     3fc: 5280002b     	mov	w11, #0x1               // =1
     400: f9000128     	str	x8, [x9]
		0000000000000400:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x18
     404: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000404:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x20
     408: d10042f6     	sub	x22, x23, #0x10
     40c: 52800313     	mov	w19, #0x18              // =24
     410: aa1903f7     	mov	x23, x25
     414: 390002ab     	strb	w11, [x21]
		0000000000000414:  R_AARCH64_LDST8_ABS_LO12_NC	.bss+0x4
     418: f900010a     	str	x10, [x8]
		0000000000000418:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x20
     41c: aa1603e0     	mov	x0, x22
     420: aa1703e1     	mov	x1, x23
     424: 9400008a     	bl	0x64c <word>
     428: 340010a0     	cbz	w0, 0x63c <iq4_f3_storage_size_child_01+0x5b8>
     42c: f1000673     	subs	x19, x19, #0x1
     430: 910022d6     	add	x22, x22, #0x8
     434: 910022f7     	add	x23, x23, #0x8
     438: 54ffff21     	b.ne	0x41c <iq4_f3_storage_size_child_01+0x398>
     43c: 5280e717     	mov	w23, #0x738             // =1848
     440: 90000016     	adrp	x22, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000440:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xf0
     444: 910002d6     	add	x22, x22, #0x0
		0000000000000444:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0xf0
     448: 72a01737     	movk	w23, #0xb9, lsl #16
     44c: 528002d3     	mov	w19, #0x16              // =22
     450: aa1703e0     	mov	x0, x23
     454: aa1603e1     	mov	x1, x22
     458: 9400007d     	bl	0x64c <word>
     45c: 34000f00     	cbz	w0, 0x63c <iq4_f3_storage_size_child_01+0x5b8>
     460: f1000673     	subs	x19, x19, #0x1
     464: 910022f7     	add	x23, x23, #0x8
     468: 910022d6     	add	x22, x22, #0x8
     46c: 54ffff21     	b.ne	0x450 <iq4_f3_storage_size_child_01+0x3cc>
     470: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000470:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x6dc
     474: 91000108     	add	x8, x8, #0x0
		0000000000000474:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x6dc
     478: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000478:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x748
     47c: 91000129     	add	x9, x9, #0x0
		000000000000047c:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x748
     480: 9000000a     	adrp	x10, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000480:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x118
     484: 9100014a     	add	x10, x10, #0x0
		0000000000000484:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x118
     488: a902a728     	stp	x8, x9, [x25, #0x28]
     48c: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000048c:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x808
     490: 91000108     	add	x8, x8, #0x0
		0000000000000490:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x808
     494: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000494:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x900
     498: 91000129     	add	x9, x9, #0x0
		0000000000000498:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x900
     49c: 528ae882     	mov	w2, #0x5744             // =22340
     4a0: a9002548     	stp	x8, x9, [x10]
     4a4: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000004a4:  R_AARCH64_ADR_PREL_PG_HI21	.text+0xa4c
     4a8: 91000108     	add	x8, x8, #0x0
		00000000000004a8:  R_AARCH64_ADD_ABS_LO12_NC	.text+0xa4c
     4ac: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000004ac:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x28
     4b0: 91000000     	add	x0, x0, #0x0
		00000000000004b0:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x28
     4b4: 52802301     	mov	w1, #0x118              // =280
     4b8: 72a009c2     	movk	w2, #0x4e, lsl #16
     4bc: aa1903e3     	mov	x3, x25
     4c0: f9001d48     	str	x8, [x10, #0x38]
     4c4: 94000205     	bl	0xcd8 <construct>
     4c8: 34000ba0     	cbz	w0, 0x63c <iq4_f3_storage_size_child_01+0x5b8>
     4cc: 5293a602     	mov	w2, #0x9d30             // =40240
     4d0: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000004d0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a0
     4d4: 91000000     	add	x0, x0, #0x0
		00000000000004d4:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x1a0
     4d8: 90000003     	adrp	x3, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000004d8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xf0
     4dc: 91000063     	add	x3, x3, #0x0
		00000000000004dc:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0xf0
     4e0: 52800701     	mov	w1, #0x38               // =56
     4e4: 72a009c2     	movk	w2, #0x4e, lsl #16
     4e8: 940001fc     	bl	0xcd8 <construct>
     4ec: 34000a80     	cbz	w0, 0x63c <iq4_f3_storage_size_child_01+0x5b8>
     4f0: 5293a602     	mov	w2, #0x9d30             // =40240
     4f4: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000004f4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a8
     4f8: 91000000     	add	x0, x0, #0x0
		00000000000004f8:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x1a8
     4fc: 90000003     	adrp	x3, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000004fc:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xf0
     500: 91000063     	add	x3, x3, #0x0
		0000000000000500:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0xf0
     504: 52800701     	mov	w1, #0x38               // =56
     508: 72a009c2     	movk	w2, #0x4e, lsl #16
     50c: 940001f3     	bl	0xcd8 <construct>
     510: 34000960     	cbz	w0, 0x63c <iq4_f3_storage_size_child_01+0x5b8>
     514: 5293a602     	mov	w2, #0x9d30             // =40240
     518: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000518:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b0
     51c: 91000000     	add	x0, x0, #0x0
		000000000000051c:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x1b0
     520: 90000003     	adrp	x3, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000520:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xf0
     524: 91000063     	add	x3, x3, #0x0
		0000000000000524:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0xf0
     528: 52800701     	mov	w1, #0x38               // =56
     52c: 72a009c2     	movk	w2, #0x4e, lsl #16
     530: 940001ea     	bl	0xcd8 <construct>
     534: 34000840     	cbz	w0, 0x63c <iq4_f3_storage_size_child_01+0x5b8>
     538: 5293a602     	mov	w2, #0x9d30             // =40240
     53c: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000053c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b8
     540: 91000000     	add	x0, x0, #0x0
		0000000000000540:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x1b8
     544: 90000003     	adrp	x3, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000544:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xf0
     548: 91000063     	add	x3, x3, #0x0
		0000000000000548:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0xf0
     54c: 52800701     	mov	w1, #0x38               // =56
     550: 72a009c2     	movk	w2, #0x4e, lsl #16
     554: 940001e1     	bl	0xcd8 <construct>
     558: 34000720     	cbz	w0, 0x63c <iq4_f3_storage_size_child_01+0x5b8>
     55c: 5293a602     	mov	w2, #0x9d30             // =40240
     560: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000560:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c0
     564: 91000000     	add	x0, x0, #0x0
		0000000000000564:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x1c0
     568: 90000003     	adrp	x3, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000568:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xf0
     56c: 91000063     	add	x3, x3, #0x0
		000000000000056c:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0xf0
     570: 52800701     	mov	w1, #0x38               // =56
     574: 72a009c2     	movk	w2, #0x4e, lsl #16
     578: 940001d8     	bl	0xcd8 <construct>
     57c: 34000600     	cbz	w0, 0x63c <iq4_f3_storage_size_child_01+0x5b8>
     580: 5293a602     	mov	w2, #0x9d30             // =40240
     584: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000584:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c8
     588: 91000000     	add	x0, x0, #0x0
		0000000000000588:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x1c8
     58c: 90000003     	adrp	x3, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000058c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xf0
     590: 91000063     	add	x3, x3, #0x0
		0000000000000590:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0xf0
     594: 52800701     	mov	w1, #0x38               // =56
     598: 72a009c2     	movk	w2, #0x4e, lsl #16
     59c: 940001cf     	bl	0xcd8 <construct>
     5a0: 340004e0     	cbz	w0, 0x63c <iq4_f3_storage_size_child_01+0x5b8>
     5a4: 90000016     	adrp	x22, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000005a4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x28
     5a8: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000005a8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a0
     5ac: f94002c0     	ldr	x0, [x22]
		00000000000005ac:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     5b0: f9400101     	ldr	x1, [x8]
		00000000000005b0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1a0
     5b4: 94000000     	bl	0x5b4 <iq4_f3_storage_size_child_01+0x530>
		00000000000005b4:  R_AARCH64_CALL26	iq4_f4_menu_append_03
     5b8: 34000420     	cbz	w0, 0x63c <iq4_f3_storage_size_child_01+0x5b8>
     5bc: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000005bc:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a8
     5c0: f94002c0     	ldr	x0, [x22]
		00000000000005c0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     5c4: f9400101     	ldr	x1, [x8]
		00000000000005c4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1a8
     5c8: 94000000     	bl	0x5c8 <iq4_f3_storage_size_child_01+0x544>
		00000000000005c8:  R_AARCH64_CALL26	iq4_f4_menu_append_03
     5cc: 34000380     	cbz	w0, 0x63c <iq4_f3_storage_size_child_01+0x5b8>
     5d0: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000005d0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b0
     5d4: f94002c0     	ldr	x0, [x22]
		00000000000005d4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     5d8: f9400101     	ldr	x1, [x8]
		00000000000005d8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1b0
     5dc: 94000000     	bl	0x5dc <iq4_f3_storage_size_child_01+0x558>
		00000000000005dc:  R_AARCH64_CALL26	iq4_f4_menu_append_03
     5e0: 340002e0     	cbz	w0, 0x63c <iq4_f3_storage_size_child_01+0x5b8>
     5e4: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000005e4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b8
     5e8: f94002c0     	ldr	x0, [x22]
		00000000000005e8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     5ec: f9400101     	ldr	x1, [x8]
		00000000000005ec:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1b8
     5f0: 94000000     	bl	0x5f0 <iq4_f3_storage_size_child_01+0x56c>
		00000000000005f0:  R_AARCH64_CALL26	iq4_f4_menu_append_03
     5f4: 34000240     	cbz	w0, 0x63c <iq4_f3_storage_size_child_01+0x5b8>
     5f8: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000005f8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c0
     5fc: f94002c0     	ldr	x0, [x22]
		00000000000005fc:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     600: f9400101     	ldr	x1, [x8]
		0000000000000600:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c0
     604: 94000000     	bl	0x604 <iq4_f3_storage_size_child_01+0x580>
		0000000000000604:  R_AARCH64_CALL26	iq4_f4_menu_append_03
     608: 340001a0     	cbz	w0, 0x63c <iq4_f3_storage_size_child_01+0x5b8>
     60c: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000060c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c8
     610: f94002c0     	ldr	x0, [x22]
		0000000000000610:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     614: f9400101     	ldr	x1, [x8]
		0000000000000614:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c8
     618: 94000000     	bl	0x618 <iq4_f3_storage_size_child_01+0x594>
		0000000000000618:  R_AARCH64_CALL26	iq4_f4_menu_append_03
     61c: 34000100     	cbz	w0, 0x63c <iq4_f3_storage_size_child_01+0x5b8>
     620: a940a3ea     	ldp	x10, x8, [sp, #0x8]
     624: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000624:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x10
     628: f94002c1     	ldr	x1, [x22]
		0000000000000628:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     62c: 390002bf     	strb	wzr, [x21]
		000000000000062c:  R_AARCH64_LDST8_ABS_LO12_NC	.bss+0x4
     630: f900034a     	str	x10, [x26]
		0000000000000630:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x8
     634: f9000128     	str	x8, [x9]
		0000000000000634:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x10
     638: 17ffff64     	b	0x3c8 <iq4_f3_storage_size_child_01+0x344>
     63c: 52800028     	mov	w8, #0x1                // =1
     640: f9400be1     	ldr	x1, [sp, #0x10]
     644: 39000308     	strb	w8, [x24]
		0000000000000644:  R_AARCH64_LDST8_ABS_LO12_NC	.bss
     648: 17ffff60     	b	0x3c8 <iq4_f3_storage_size_child_01+0x344>

000000000000064c <word>:
     64c: 91002008     	add	x8, x0, #0x8
     650: d343fd08     	lsr	x8, x8, #3
     654: f108051f     	cmp	x8, #0x201
     658: 54000062     	b.hs	0x664 <word+0x18>
     65c: 2a1f03e0     	mov	w0, wzr
     660: d65f03c0     	ret
     664: d100c3ff     	sub	sp, sp, #0x30
     668: a9017bfd     	stp	x29, x30, [sp, #0x10]
     66c: a9024ff4     	stp	x20, x19, [sp, #0x20]
     670: 910043fd     	add	x29, sp, #0x10
     674: aa0003f4     	mov	x20, x0
     678: aa0103f3     	mov	x19, x1
     67c: aa1f03e0     	mov	x0, xzr
     680: aa1403e1     	mov	x1, x20
     684: aa1303e2     	mov	x2, x19
     688: 52800103     	mov	w3, #0x8                // =8
     68c: 94000000     	bl	0x68c <word+0x40>
		000000000000068c:  R_AARCH64_CALL26	iq4_native_self_read_01
     690: 7100041f     	cmp	w0, #0x1
     694: 540001a1     	b.ne	0x6c8 <word+0x7c>
     698: 910023e2     	add	x2, sp, #0x8
     69c: aa1f03e0     	mov	x0, xzr
     6a0: aa1403e1     	mov	x1, x20
     6a4: 52800103     	mov	w3, #0x8                // =8
     6a8: 94000000     	bl	0x6a8 <word+0x5c>
		00000000000006a8:  R_AARCH64_CALL26	iq4_native_self_read_01
     6ac: 7100041f     	cmp	w0, #0x1
     6b0: 540000c1     	b.ne	0x6c8 <word+0x7c>
     6b4: f94007e8     	ldr	x8, [sp, #0x8]
     6b8: f9400269     	ldr	x9, [x19]
     6bc: eb09011f     	cmp	x8, x9
     6c0: 1a9f17e0     	cset	w0, eq
     6c4: 14000002     	b	0x6cc <word+0x80>
     6c8: 2a1f03e0     	mov	w0, wzr
     6cc: a9424ff4     	ldp	x20, x19, [sp, #0x20]
     6d0: a9417bfd     	ldp	x29, x30, [sp, #0x10]
     6d4: 9100c3ff     	add	sp, sp, #0x30
     6d8: d65f03c0     	ret

00000000000006dc <menu_name>:
     6dc: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000006dc:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x28
     6e0: aa0003e8     	mov	x8, x0
     6e4: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000006e4:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
     6e8: 91000000     	add	x0, x0, #0x0
		00000000000006e8:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
     6ec: f9400129     	ldr	x9, [x9]
		00000000000006ec:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     6f0: eb09011f     	cmp	x8, x9
     6f4: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000006f4:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1
     6f8: 91000108     	add	x8, x8, #0x0
		00000000000006f8:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1
     6fc: 9a800108     	csel	x8, x8, x0, eq
     700: b4000221     	cbz	x1, 0x744 <menu_name+0x68>
     704: 71000449     	subs	w9, w2, #0x1
     708: 540001eb     	b.lt	0x744 <menu_name+0x68>
     70c: 7100085f     	cmp	w2, #0x2
     710: 54000143     	b.lo	0x738 <menu_name+0x5c>
     714: aa1f03ea     	mov	x10, xzr
     718: 386a690b     	ldrb	w11, [x8, x10]
     71c: 3400010b     	cbz	w11, 0x73c <menu_name+0x60>
     720: 382a682b     	strb	w11, [x1, x10]
     724: 9100054a     	add	x10, x10, #0x1
     728: eb0a013f     	cmp	x9, x10
     72c: 54ffff61     	b.ne	0x718 <menu_name+0x3c>
     730: aa0903ea     	mov	x10, x9
     734: 14000002     	b	0x73c <menu_name+0x60>
     738: aa1f03ea     	mov	x10, xzr
     73c: aa0103e0     	mov	x0, x1
     740: 382a683f     	strb	wzr, [x1, x10]
     744: d65f03c0     	ret

0000000000000748 <menu_value>:
     748: d100c3ff     	sub	sp, sp, #0x30
     74c: a9017bfd     	stp	x29, x30, [sp, #0x10]
     750: a9024ff4     	stp	x20, x19, [sp, #0x20]
     754: 910043fd     	add	x29, sp, #0x10
     758: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000758:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x28
     75c: 2a0203f4     	mov	w20, w2
     760: aa0103f3     	mov	x19, x1
     764: f9400108     	ldr	x8, [x8]
		0000000000000764:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     768: eb08001f     	cmp	x0, x8
     76c: 54000260     	b.eq	0x7b8 <menu_value+0x70>
     770: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000770:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xb
     774: 91000108     	add	x8, x8, #0x0
		0000000000000774:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xb
     778: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000778:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
     77c: 91000000     	add	x0, x0, #0x0
		000000000000077c:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
     780: b40003d3     	cbz	x19, 0x7f8 <menu_value+0xb0>
     784: 71000689     	subs	w9, w20, #0x1
     788: 5400038b     	b.lt	0x7f8 <menu_value+0xb0>
     78c: 71000a9f     	cmp	w20, #0x2
     790: 540002e3     	b.lo	0x7ec <menu_value+0xa4>
     794: aa1f03ea     	mov	x10, xzr
     798: 386a690b     	ldrb	w11, [x8, x10]
     79c: 340002ab     	cbz	w11, 0x7f0 <menu_value+0xa8>
     7a0: 382a6a6b     	strb	w11, [x19, x10]
     7a4: 9100054a     	add	x10, x10, #0x1
     7a8: eb0a013f     	cmp	x9, x10
     7ac: 54ffff61     	b.ne	0x798 <menu_value+0x50>
     7b0: aa0903ea     	mov	x10, x9
     7b4: 1400000f     	b	0x7f0 <menu_value+0xa8>
     7b8: 910003e0     	mov	x0, sp
     7bc: 94000000     	bl	0x7bc <menu_value+0x74>
		00000000000007bc:  R_AARCH64_CALL26	iq4_f3_settings_snapshot_06
     7c0: 34fffd80     	cbz	w0, 0x770 <menu_value+0x28>
     7c4: b9400be8     	ldr	w8, [sp, #0x8]
     7c8: 7100151f     	cmp	w8, #0x5
     7cc: 54fffd28     	b.hi	0x770 <menu_value+0x28>
     7d0: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000007d0:  R_AARCH64_ADR_PREL_PG_HI21	.rodata+0x378
     7d4: 91000129     	add	x9, x9, #0x0
		00000000000007d4:  R_AARCH64_ADD_ABS_LO12_NC	.rodata+0x378
     7d8: f8687928     	ldr	x8, [x9, x8, lsl #3]
     7dc: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000007dc:  R_AARCH64_ADR_PREL_PG_HI21	.data.rel.ro+0xf0
     7e0: 91000129     	add	x9, x9, #0x0
		00000000000007e0:  R_AARCH64_ADD_ABS_LO12_NC	.data.rel.ro+0xf0
     7e4: f8687928     	ldr	x8, [x9, x8, lsl #3]
     7e8: 17ffffe4     	b	0x778 <menu_value+0x30>
     7ec: aa1f03ea     	mov	x10, xzr
     7f0: aa1303e0     	mov	x0, x19
     7f4: 382a6a7f     	strb	wzr, [x19, x10]
     7f8: a9424ff4     	ldp	x20, x19, [sp, #0x20]
     7fc: a9417bfd     	ldp	x29, x30, [sp, #0x10]
     800: 9100c3ff     	add	sp, sp, #0x30
     804: d65f03c0     	ret

0000000000000808 <item_name>:
     808: b4000320     	cbz	x0, 0x86c <item_name+0x64>
     80c: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000080c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a0
     810: f9400108     	ldr	x8, [x8]
		0000000000000810:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1a0
     814: eb08001f     	cmp	x0, x8
     818: 54000300     	b.eq	0x878 <item_name+0x70>
     81c: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000081c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a8
     820: f9400108     	ldr	x8, [x8]
		0000000000000820:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1a8
     824: eb08001f     	cmp	x0, x8
     828: 540002c0     	b.eq	0x880 <item_name+0x78>
     82c: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000082c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b0
     830: f9400108     	ldr	x8, [x8]
		0000000000000830:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1b0
     834: eb08001f     	cmp	x0, x8
     838: 54000280     	b.eq	0x888 <item_name+0x80>
     83c: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000083c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b8
     840: f9400108     	ldr	x8, [x8]
		0000000000000840:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1b8
     844: eb08001f     	cmp	x0, x8
     848: 54000240     	b.eq	0x890 <item_name+0x88>
     84c: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000084c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c0
     850: f9400108     	ldr	x8, [x8]
		0000000000000850:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c0
     854: eb08001f     	cmp	x0, x8
     858: 54000200     	b.eq	0x898 <item_name+0x90>
     85c: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000085c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c8
     860: f9400108     	ldr	x8, [x8]
		0000000000000860:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c8
     864: eb08001f     	cmp	x0, x8
     868: 540001c0     	b.eq	0x8a0 <item_name+0x98>
     86c: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		000000000000086c:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
     870: 91000108     	add	x8, x8, #0x0
		0000000000000870:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
     874: 1400000f     	b	0x8b0 <item_name+0xa8>
     878: aa1f03e8     	mov	x8, xzr
     87c: 1400000a     	b	0x8a4 <item_name+0x9c>
     880: 52800028     	mov	w8, #0x1                // =1
     884: 14000008     	b	0x8a4 <item_name+0x9c>
     888: 52800048     	mov	w8, #0x2                // =2
     88c: 14000006     	b	0x8a4 <item_name+0x9c>
     890: 52800068     	mov	w8, #0x3                // =3
     894: 14000004     	b	0x8a4 <item_name+0x9c>
     898: 52800088     	mov	w8, #0x4                // =4
     89c: 14000002     	b	0x8a4 <item_name+0x9c>
     8a0: 528000a8     	mov	w8, #0x5                // =5
     8a4: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000008a4:  R_AARCH64_ADR_PREL_PG_HI21	.data.rel.ro+0xf0
     8a8: 91000129     	add	x9, x9, #0x0
		00000000000008a8:  R_AARCH64_ADD_ABS_LO12_NC	.data.rel.ro+0xf0
     8ac: f8687928     	ldr	x8, [x9, x8, lsl #3]
     8b0: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000008b0:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
     8b4: 91000000     	add	x0, x0, #0x0
		00000000000008b4:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
     8b8: b4000221     	cbz	x1, 0x8fc <item_name+0xf4>
     8bc: 71000449     	subs	w9, w2, #0x1
     8c0: 540001eb     	b.lt	0x8fc <item_name+0xf4>
     8c4: 7100085f     	cmp	w2, #0x2
     8c8: 54000143     	b.lo	0x8f0 <item_name+0xe8>
     8cc: aa1f03ea     	mov	x10, xzr
     8d0: 386a690b     	ldrb	w11, [x8, x10]
     8d4: 3400010b     	cbz	w11, 0x8f4 <item_name+0xec>
     8d8: 382a682b     	strb	w11, [x1, x10]
     8dc: 9100054a     	add	x10, x10, #0x1
     8e0: eb0a013f     	cmp	x9, x10
     8e4: 54ffff61     	b.ne	0x8d0 <item_name+0xc8>
     8e8: aa0903ea     	mov	x10, x9
     8ec: 14000002     	b	0x8f4 <item_name+0xec>
     8f0: aa1f03ea     	mov	x10, xzr
     8f4: aa0103e0     	mov	x0, x1
     8f8: 382a683f     	strb	wzr, [x1, x10]
     8fc: d65f03c0     	ret

0000000000000900 <item_value>:
     900: d10103ff     	sub	sp, sp, #0x40
     904: a9017bfd     	stp	x29, x30, [sp, #0x10]
     908: f90013f5     	str	x21, [sp, #0x20]
     90c: a9034ff4     	stp	x20, x19, [sp, #0x30]
     910: 910043fd     	add	x29, sp, #0x10
     914: 2a0203f4     	mov	w20, w2
     918: aa0103f3     	mov	x19, x1
     91c: b4000320     	cbz	x0, 0x980 <item_value+0x80>
     920: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000920:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a0
     924: f9400108     	ldr	x8, [x8]
		0000000000000924:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1a0
     928: eb08001f     	cmp	x0, x8
     92c: 54000300     	b.eq	0x98c <item_value+0x8c>
     930: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000930:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a8
     934: f9400108     	ldr	x8, [x8]
		0000000000000934:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1a8
     938: eb08001f     	cmp	x0, x8
     93c: 540002c0     	b.eq	0x994 <item_value+0x94>
     940: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000940:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b0
     944: f9400108     	ldr	x8, [x8]
		0000000000000944:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1b0
     948: eb08001f     	cmp	x0, x8
     94c: 54000280     	b.eq	0x99c <item_value+0x9c>
     950: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000950:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b8
     954: f9400108     	ldr	x8, [x8]
		0000000000000954:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1b8
     958: eb08001f     	cmp	x0, x8
     95c: 54000240     	b.eq	0x9a4 <item_value+0xa4>
     960: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000960:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c0
     964: f9400108     	ldr	x8, [x8]
		0000000000000964:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c0
     968: eb08001f     	cmp	x0, x8
     96c: 54000200     	b.eq	0x9ac <item_value+0xac>
     970: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000970:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c8
     974: f9400108     	ldr	x8, [x8]
		0000000000000974:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c8
     978: eb08001f     	cmp	x0, x8
     97c: 540001c0     	b.eq	0x9b4 <item_value+0xb4>
     980: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000980:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
     984: 91000108     	add	x8, x8, #0x0
		0000000000000984:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
     988: 14000019     	b	0x9ec <item_value+0xec>
     98c: aa1f03f5     	mov	x21, xzr
     990: 1400000a     	b	0x9b8 <item_value+0xb8>
     994: 52800035     	mov	w21, #0x1               // =1
     998: 14000008     	b	0x9b8 <item_value+0xb8>
     99c: 52800055     	mov	w21, #0x2               // =2
     9a0: 14000006     	b	0x9b8 <item_value+0xb8>
     9a4: 52800075     	mov	w21, #0x3               // =3
     9a8: 14000004     	b	0x9b8 <item_value+0xb8>
     9ac: 52800095     	mov	w21, #0x4               // =4
     9b0: 14000002     	b	0x9b8 <item_value+0xb8>
     9b4: 528000b5     	mov	w21, #0x5               // =5
     9b8: 910003e0     	mov	x0, sp
     9bc: 94000000     	bl	0x9bc <item_value+0xbc>
		00000000000009bc:  R_AARCH64_CALL26	iq4_f3_settings_snapshot_06
     9c0: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000009c0:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
     9c4: 91000108     	add	x8, x8, #0x0
		00000000000009c4:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
     9c8: 34000120     	cbz	w0, 0x9ec <item_value+0xec>
     9cc: 9000000a     	adrp	x10, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000009cc:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str4.4
     9d0: 9100014a     	add	x10, x10, #0x0
		00000000000009d0:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str4.4
     9d4: b9400be9     	ldr	w9, [sp, #0x8]
     9d8: b875794a     	ldr	w10, [x10, x21, lsl #2]
     9dc: 6b0a013f     	cmp	w9, w10
     9e0: 90000009     	adrp	x9, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000009e0:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x2e
     9e4: 91000129     	add	x9, x9, #0x0
		00000000000009e4:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x2e
     9e8: 9a880128     	csel	x8, x9, x8, eq
     9ec: 90000000     	adrp	x0, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		00000000000009ec:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
     9f0: 91000000     	add	x0, x0, #0x0
		00000000000009f0:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
     9f4: b4000233     	cbz	x19, 0xa38 <item_value+0x138>
     9f8: 71000689     	subs	w9, w20, #0x1
     9fc: 540001eb     	b.lt	0xa38 <item_value+0x138>
     a00: 71000a9f     	cmp	w20, #0x2
     a04: 54000143     	b.lo	0xa2c <item_value+0x12c>
     a08: aa1f03ea     	mov	x10, xzr
     a0c: 386a690b     	ldrb	w11, [x8, x10]
     a10: 3400010b     	cbz	w11, 0xa30 <item_value+0x130>
     a14: 382a6a6b     	strb	w11, [x19, x10]
     a18: 9100054a     	add	x10, x10, #0x1
     a1c: eb0a013f     	cmp	x9, x10
     a20: 54ffff61     	b.ne	0xa0c <item_value+0x10c>
     a24: aa0903ea     	mov	x10, x9
     a28: 14000002     	b	0xa30 <item_value+0x130>
     a2c: aa1f03ea     	mov	x10, xzr
     a30: aa1303e0     	mov	x0, x19
     a34: 382a6a7f     	strb	wzr, [x19, x10]
     a38: a9434ff4     	ldp	x20, x19, [sp, #0x30]
     a3c: f94013f5     	ldr	x21, [sp, #0x20]
     a40: a9417bfd     	ldp	x29, x30, [sp, #0x10]
     a44: 910103ff     	add	sp, sp, #0x40
     a48: d65f03c0     	ret

0000000000000a4c <activate>:
     a4c: d10183ff     	sub	sp, sp, #0x60
     a50: a9037bfd     	stp	x29, x30, [sp, #0x30]
     a54: f90023f5     	str	x21, [sp, #0x40]
     a58: a9054ff4     	stp	x20, x19, [sp, #0x50]
     a5c: 9100c3fd     	add	x29, sp, #0x30
     a60: b4001300     	cbz	x0, 0xcc0 <activate+0x274>
     a64: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000a64:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a0
     a68: f9400108     	ldr	x8, [x8]
		0000000000000a68:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1a0
     a6c: eb08001f     	cmp	x0, x8
     a70: 540002e0     	b.eq	0xacc <activate+0x80>
     a74: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000a74:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1a8
     a78: f9400108     	ldr	x8, [x8]
		0000000000000a78:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1a8
     a7c: eb08001f     	cmp	x0, x8
     a80: 540002a0     	b.eq	0xad4 <activate+0x88>
     a84: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000a84:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b0
     a88: f9400108     	ldr	x8, [x8]
		0000000000000a88:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1b0
     a8c: eb08001f     	cmp	x0, x8
     a90: 54000260     	b.eq	0xadc <activate+0x90>
     a94: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000a94:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1b8
     a98: f9400108     	ldr	x8, [x8]
		0000000000000a98:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1b8
     a9c: eb08001f     	cmp	x0, x8
     aa0: 54000220     	b.eq	0xae4 <activate+0x98>
     aa4: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000aa4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c0
     aa8: f9400108     	ldr	x8, [x8]
		0000000000000aa8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c0
     aac: eb08001f     	cmp	x0, x8
     ab0: 540001e0     	b.eq	0xaec <activate+0xa0>
     ab4: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000ab4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c8
     ab8: f9400108     	ldr	x8, [x8]
		0000000000000ab8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c8
     abc: eb08001f     	cmp	x0, x8
     ac0: 54001001     	b.ne	0xcc0 <activate+0x274>
     ac4: 528000b4     	mov	w20, #0x5               // =5
     ac8: 1400000a     	b	0xaf0 <activate+0xa4>
     acc: aa1f03f4     	mov	x20, xzr
     ad0: 14000008     	b	0xaf0 <activate+0xa4>
     ad4: 52800034     	mov	w20, #0x1               // =1
     ad8: 14000006     	b	0xaf0 <activate+0xa4>
     adc: 52800054     	mov	w20, #0x2               // =2
     ae0: 14000004     	b	0xaf0 <activate+0xa4>
     ae4: 52800074     	mov	w20, #0x3               // =3
     ae8: 14000002     	b	0xaf0 <activate+0xa4>
     aec: 52800094     	mov	w20, #0x4               // =4
     af0: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000af0:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     af4: a9007fff     	stp	xzr, xzr, [sp]
     af8: 39400108     	ldrb	w8, [x8]
		0000000000000af8:  R_AARCH64_LDST8_ABS_LO12_NC	.bss
     afc: 37000e28     	tbnz	w8, #0x0, 0xcc0 <activate+0x274>
     b00: 90000015     	adrp	x21, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000b00:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x18
     b04: f94002a8     	ldr	x8, [x21]
		0000000000000b04:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x18
     b08: b4000dc8     	cbz	x8, 0xcc0 <activate+0x274>
     b0c: d10023a0     	sub	x0, x29, #0x8
     b10: 94000000     	bl	0xb10 <activate+0xc4>
		0000000000000b10:  R_AARCH64_CALL26	iq4_f4_native_current_02
     b14: 34000d60     	cbz	w0, 0xcc0 <activate+0x274>
     b18: f85f83b3     	ldur	x19, [x29, #-0x8]
     b1c: f94002a8     	ldr	x8, [x21]
		0000000000000b1c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x18
     b20: eb08027f     	cmp	x19, x8
     b24: 54000ce1     	b.ne	0xcc0 <activate+0x274>
     b28: 91002268     	add	x8, x19, #0x8
     b2c: d343fd08     	lsr	x8, x8, #3
     b30: f108051f     	cmp	x8, #0x201
     b34: 54000c63     	b.lo	0xcc0 <activate+0x274>
     b38: d10043a2     	sub	x2, x29, #0x10
     b3c: aa1f03e0     	mov	x0, xzr
     b40: aa1303e1     	mov	x1, x19
     b44: 52800103     	mov	w3, #0x8                // =8
     b48: 94000000     	bl	0xb48 <activate+0xfc>
		0000000000000b48:  R_AARCH64_CALL26	iq4_native_self_read_01
     b4c: 7100041f     	cmp	w0, #0x1
     b50: 54000b81     	b.ne	0xcc0 <activate+0x274>
     b54: 910063a2     	add	x2, x29, #0x18
     b58: aa1f03e0     	mov	x0, xzr
     b5c: aa1303e1     	mov	x1, x19
     b60: 52800103     	mov	w3, #0x8                // =8
     b64: 94000000     	bl	0xb64 <activate+0x118>
		0000000000000b64:  R_AARCH64_CALL26	iq4_native_self_read_01
     b68: 7100041f     	cmp	w0, #0x1
     b6c: 54000aa1     	b.ne	0xcc0 <activate+0x274>
     b70: f9400fa9     	ldr	x9, [x29, #0x18]
     b74: 5283e908     	mov	w8, #0x1f48             // =8008
     b78: 72a01728     	movk	w8, #0xb9, lsl #16
     b7c: eb08013f     	cmp	x9, x8
     b80: 54000a01     	b.ne	0xcc0 <activate+0x274>
     b84: f85f03a9     	ldur	x9, [x29, #-0x10]
     b88: eb08013f     	cmp	x9, x8
     b8c: 540009a1     	b.ne	0xcc0 <activate+0x274>
     b90: f85f83b3     	ldur	x19, [x29, #-0x8]
     b94: 91074268     	add	x8, x19, #0x1d0
     b98: d343fd08     	lsr	x8, x8, #3
     b9c: f108051f     	cmp	x8, #0x201
     ba0: 54000903     	b.lo	0xcc0 <activate+0x274>
     ba4: 91072261     	add	x1, x19, #0x1c8
     ba8: 910063e2     	add	x2, sp, #0x18
     bac: aa1f03e0     	mov	x0, xzr
     bb0: 52800103     	mov	w3, #0x8                // =8
     bb4: 94000000     	bl	0xbb4 <activate+0x168>
		0000000000000bb4:  R_AARCH64_CALL26	iq4_native_self_read_01
     bb8: 7100041f     	cmp	w0, #0x1
     bbc: 54000821     	b.ne	0xcc0 <activate+0x274>
     bc0: 91072261     	add	x1, x19, #0x1c8
     bc4: 910063a2     	add	x2, x29, #0x18
     bc8: aa1f03e0     	mov	x0, xzr
     bcc: 52800103     	mov	w3, #0x8                // =8
     bd0: 94000000     	bl	0xbd0 <activate+0x184>
		0000000000000bd0:  R_AARCH64_CALL26	iq4_native_self_read_01
     bd4: 7100041f     	cmp	w0, #0x1
     bd8: 54000741     	b.ne	0xcc0 <activate+0x274>
     bdc: f9400fb3     	ldr	x19, [x29, #0x18]
     be0: f9400fe8     	ldr	x8, [sp, #0x18]
     be4: eb08027f     	cmp	x19, x8
     be8: 540006c1     	b.ne	0xcc0 <activate+0x274>
     bec: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000bec:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x20
     bf0: f9400108     	ldr	x8, [x8]
		0000000000000bf0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x20
     bf4: eb08027f     	cmp	x19, x8
     bf8: 54000641     	b.ne	0xcc0 <activate+0x274>
     bfc: 91002268     	add	x8, x19, #0x8
     c00: d343fd08     	lsr	x8, x8, #3
     c04: f108051f     	cmp	x8, #0x201
     c08: 540005c3     	b.lo	0xcc0 <activate+0x274>
     c0c: d10043a2     	sub	x2, x29, #0x10
     c10: aa1f03e0     	mov	x0, xzr
     c14: aa1303e1     	mov	x1, x19
     c18: 52800103     	mov	w3, #0x8                // =8
     c1c: 94000000     	bl	0xc1c <activate+0x1d0>
		0000000000000c1c:  R_AARCH64_CALL26	iq4_native_self_read_01
     c20: 7100041f     	cmp	w0, #0x1
     c24: 540004e1     	b.ne	0xcc0 <activate+0x274>
     c28: 910063a2     	add	x2, x29, #0x18
     c2c: aa1f03e0     	mov	x0, xzr
     c30: aa1303e1     	mov	x1, x19
     c34: 52800103     	mov	w3, #0x8                // =8
     c38: 94000000     	bl	0xc38 <activate+0x1ec>
		0000000000000c38:  R_AARCH64_CALL26	iq4_native_self_read_01
     c3c: 7100041f     	cmp	w0, #0x1
     c40: 54000401     	b.ne	0xcc0 <activate+0x274>
     c44: f9400fa9     	ldr	x9, [x29, #0x18]
     c48: 529e6b08     	mov	w8, #0xf358             // =62296
     c4c: 72a01708     	movk	w8, #0xb8, lsl #16
     c50: eb08013f     	cmp	x9, x8
     c54: 54000361     	b.ne	0xcc0 <activate+0x274>
     c58: f85f03a9     	ldur	x9, [x29, #-0x10]
     c5c: eb08013f     	cmp	x9, x8
     c60: 54000301     	b.ne	0xcc0 <activate+0x274>
     c64: f9400fe8     	ldr	x8, [sp, #0x18]
     c68: 910043e1     	add	x1, sp, #0x10
     c6c: 91002100     	add	x0, x8, #0x8
     c70: 97fffe77     	bl	0x64c <word>
     c74: 34000260     	cbz	w0, 0xcc0 <activate+0x274>
     c78: f9400be8     	ldr	x8, [sp, #0x10]
     c7c: f85f83a9     	ldur	x9, [x29, #-0x8]
     c80: eb09011f     	cmp	x8, x9
     c84: 540001e1     	b.ne	0xcc0 <activate+0x274>
     c88: 910003e0     	mov	x0, sp
     c8c: 94000000     	bl	0xc8c <activate+0x240>
		0000000000000c8c:  R_AARCH64_CALL26	iq4_activity_snapshot_01
     c90: 2a0003e8     	mov	w8, w0
     c94: 2a1f03e0     	mov	w0, wzr
     c98: 35000168     	cbnz	w8, 0xcc4 <activate+0x278>
     c9c: b9400be8     	ldr	w8, [sp, #0x8]
     ca0: 35000128     	cbnz	w8, 0xcc4 <activate+0x278>
     ca4: b9400fe8     	ldr	w8, [sp, #0xc]
     ca8: 350000e8     	cbnz	w8, 0xcc4 <activate+0x278>
     cac: 90000008     	adrp	x8, 0x0 <iq4_f3_storage_size_append_wrapper_01>
		0000000000000cac:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str4.4
     cb0: 91000108     	add	x8, x8, #0x0
		0000000000000cb0:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str4.4
     cb4: b8747900     	ldr	w0, [x8, x20, lsl #2]
     cb8: 94000000     	bl	0xcb8 <activate+0x26c>
		0000000000000cb8:  R_AARCH64_CALL26	iq4_f3_scale_set_on_ui_01
     cbc: 14000002     	b	0xcc4 <activate+0x278>
     cc0: 2a1f03e0     	mov	w0, wzr
     cc4: a9454ff4     	ldp	x20, x19, [sp, #0x50]
     cc8: f94023f5     	ldr	x21, [sp, #0x40]
     ccc: a9437bfd     	ldp	x29, x30, [sp, #0x30]
     cd0: 910183ff     	add	sp, sp, #0x60
     cd4: d65f03c0     	ret

0000000000000cd8 <construct>:
     cd8: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
     cdc: f9000bf5     	str	x21, [sp, #0x10]
     ce0: a9024ff4     	stp	x20, x19, [sp, #0x20]
     ce4: 910003fd     	mov	x29, sp
     ce8: aa0003f4     	mov	x20, x0
     cec: aa0103e0     	mov	x0, x1
     cf0: aa0303f3     	mov	x19, x3
     cf4: aa1403e1     	mov	x1, x20
     cf8: aa0203f5     	mov	x21, x2
     cfc: 94000000     	bl	0xcfc <construct+0x24>
		0000000000000cfc:  R_AARCH64_CALL26	iq4_f4_menu_new_03
     d00: 340001e0     	cbz	w0, 0xd3c <construct+0x64>
     d04: f9400281     	ldr	x1, [x20]
     d08: b4000181     	cbz	x1, 0xd38 <construct+0x60>
     d0c: aa1503e0     	mov	x0, x21
     d10: 94000000     	bl	0xd10 <construct+0x38>
		0000000000000d10:  R_AARCH64_CALL26	iq4_f4_menu_ctor_03
     d14: 34000140     	cbz	w0, 0xd3c <construct+0x64>
     d18: f9400280     	ldr	x0, [x20]
     d1c: 91004268     	add	x8, x19, #0x10
     d20: 910063a1     	add	x1, x29, #0x18
     d24: 52800102     	mov	w2, #0x8                // =8
     d28: f9000fa8     	str	x8, [x29, #0x18]
     d2c: 94000000     	bl	0xd2c <construct+0x54>
		0000000000000d2c:  R_AARCH64_CALL26	memcpy
     d30: 52800020     	mov	w0, #0x1                // =1
     d34: 14000002     	b	0xd3c <construct+0x64>
     d38: 2a1f03e0     	mov	w0, wzr
     d3c: a9424ff4     	ldp	x20, x19, [sp, #0x20]
     d40: f9400bf5     	ldr	x21, [sp, #0x10]
     d44: a8c37bfd     	ldp	x29, x30, [sp], #0x30
     d48: d65f03c0     	ret
