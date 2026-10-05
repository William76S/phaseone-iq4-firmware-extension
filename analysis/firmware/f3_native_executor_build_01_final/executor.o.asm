
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_native_executor_build_01_final/executor.o:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000000000 <iq4_f3_executor_hold_01>:
       0: d10083ff     	sub	sp, sp, #0x20
       4: a9017bfd     	stp	x29, x30, [sp, #0x10]
       8: 910043fd     	add	x29, sp, #0x10
       c: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		000000000000000c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x8
      10: 91000108     	add	x8, x8, #0x0
		0000000000000010:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x8
      14: 52800029     	mov	w9, #0x1                // =1
      18: 9101410a     	add	x10, x8, #0x50
      1c: 889ffd09     	stlr	w9, [x8]
      20: 91016108     	add	x8, x8, #0x58
      24: c8dffd49     	ldar	x9, [x10]
      28: c8dffd08     	ldar	x8, [x8]
      2c: a90023e9     	stp	x9, x8, [sp]
      30: b4000069     	cbz	x9, 0x3c <iq4_f3_executor_hold_01+0x3c>
      34: 910003e0     	mov	x0, sp
      38: 94000000     	bl	0x38 <iq4_f3_executor_hold_01+0x38>
		0000000000000038:  R_AARCH64_CALL26	iq4_activity_hold_01
      3c: 528000a8     	mov	w8, #0x5                // =5
      40: 90000009     	adrp	x9, 0x0 <iq4_f3_executor_hold_01>
		0000000000000040:  R_AARCH64_ADR_PREL_PG_HI21	.bss
      44: 91000129     	add	x9, x9, #0x0
		0000000000000044:  R_AARCH64_ADD_ABS_LO12_NC	.bss
      48: 889ffd28     	stlr	w8, [x9]
      4c: a9417bfd     	ldp	x29, x30, [sp, #0x10]
      50: 910083ff     	add	sp, sp, #0x20
      54: d65f03c0     	ret

0000000000000058 <iq4_f3_executor_selection_on_ui_01>:
      58: b4001100     	cbz	x0, 0x278 <iq4_f3_executor_selection_on_ui_01+0x220>
      5c: d10243ff     	sub	sp, sp, #0x90
      60: a9067bfd     	stp	x29, x30, [sp, #0x60]
      64: f9003bf5     	str	x21, [sp, #0x70]
      68: a9084ff4     	stp	x20, x19, [sp, #0x80]
      6c: 910183fd     	add	x29, sp, #0x60
      70: aa0003f4     	mov	x20, x0
      74: 94000083     	bl	0x280 <_ZL5on_uiv>
      78: 36000f40     	tbz	w0, #0x0, 0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
      7c: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		000000000000007c:  R_AARCH64_ADR_PREL_PG_HI21	.bss
      80: 91000108     	add	x8, x8, #0x0
		0000000000000080:  R_AARCH64_ADD_ABS_LO12_NC	.bss
      84: 88dffd09     	ldar	w9, [x8]
      88: 34000ec9     	cbz	w9, 0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
      8c: 88dffd08     	ldar	w8, [x8]
      90: 7100151f     	cmp	w8, #0x5
      94: 54000e60     	b.eq	0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
      98: 90000015     	adrp	x21, 0x0 <iq4_f3_executor_hold_01>
		0000000000000098:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x18
      9c: 12800009     	mov	w9, #-0x1               // =-1
      a0: f9000fbf     	str	xzr, [x29, #0x18]
      a4: f94002b3     	ldr	x19, [x21]
		00000000000000a4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x18
      a8: a9017fff     	stp	xzr, xzr, [sp, #0x10]
      ac: b9000fe9     	str	w9, [sp, #0xc]
      b0: 9106c268     	add	x8, x19, #0x1b0
      b4: d343fd08     	lsr	x8, x8, #3
      b8: f108051f     	cmp	x8, #0x201
      bc: 54000d23     	b.lo	0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
      c0: 9106a260     	add	x0, x19, #0x1a8
      c4: 910063e1     	add	x1, sp, #0x18
      c8: 52800102     	mov	w2, #0x8                // =8
      cc: 94000000     	bl	0xcc <iq4_f3_executor_selection_on_ui_01+0x74>
		00000000000000cc:  R_AARCH64_CALL26	f3_executor_read_01
      d0: 7100041f     	cmp	w0, #0x1
      d4: 54000c61     	b.ne	0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
      d8: 9106a260     	add	x0, x19, #0x1a8
      dc: 910083e1     	add	x1, sp, #0x20
      e0: 52800102     	mov	w2, #0x8                // =8
      e4: 94000000     	bl	0xe4 <iq4_f3_executor_selection_on_ui_01+0x8c>
		00000000000000e4:  R_AARCH64_CALL26	f3_executor_read_01
      e8: 7100041f     	cmp	w0, #0x1
      ec: 54000ba1     	b.ne	0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
      f0: 910063e0     	add	x0, sp, #0x18
      f4: 910083e1     	add	x1, sp, #0x20
      f8: 52800102     	mov	w2, #0x8                // =8
      fc: 94000000     	bl	0xfc <iq4_f3_executor_selection_on_ui_01+0xa4>
		00000000000000fc:  R_AARCH64_CALL26	memcmp
     100: 35000b00     	cbnz	w0, 0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
     104: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		0000000000000104:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x20
     108: f9400ff3     	ldr	x19, [sp, #0x18]
     10c: f9400108     	ldr	x8, [x8]
		000000000000010c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x20
     110: eb08027f     	cmp	x19, x8
     114: 54000a61     	b.ne	0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
     118: 91002268     	add	x8, x19, #0x8
     11c: d343fd08     	lsr	x8, x8, #3
     120: f108051f     	cmp	x8, #0x201
     124: 540009e3     	b.lo	0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
     128: 910063a1     	add	x1, x29, #0x18
     12c: aa1303e0     	mov	x0, x19
     130: 52800102     	mov	w2, #0x8                // =8
     134: 94000000     	bl	0x134 <iq4_f3_executor_selection_on_ui_01+0xdc>
		0000000000000134:  R_AARCH64_CALL26	f3_executor_read_01
     138: 7100041f     	cmp	w0, #0x1
     13c: 54000921     	b.ne	0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
     140: 910083e1     	add	x1, sp, #0x20
     144: aa1303e0     	mov	x0, x19
     148: 52800102     	mov	w2, #0x8                // =8
     14c: 94000000     	bl	0x14c <iq4_f3_executor_selection_on_ui_01+0xf4>
		000000000000014c:  R_AARCH64_CALL26	f3_executor_read_01
     150: 7100041f     	cmp	w0, #0x1
     154: 54000861     	b.ne	0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
     158: 910063a0     	add	x0, x29, #0x18
     15c: 910083e1     	add	x1, sp, #0x20
     160: 52800102     	mov	w2, #0x8                // =8
     164: 94000000     	bl	0x164 <iq4_f3_executor_selection_on_ui_01+0x10c>
		0000000000000164:  R_AARCH64_CALL26	memcmp
     168: 2a0003e8     	mov	w8, w0
     16c: 52800040     	mov	w0, #0x2                // =2
     170: 350007a8     	cbnz	w8, 0x264 <iq4_f3_executor_selection_on_ui_01+0x20c>
     174: 529d9c13     	mov	w19, #0xece0            // =60640
     178: f9400fa8     	ldr	x8, [x29, #0x18]
     17c: 72a016f3     	movk	w19, #0xb7, lsl #16
     180: 91320269     	add	x9, x19, #0xc80
     184: eb09011f     	cmp	x8, x9
     188: 540006e1     	b.ne	0x264 <iq4_f3_executor_selection_on_ui_01+0x20c>
     18c: f9400fe8     	ldr	x8, [sp, #0x18]
     190: 910043e1     	add	x1, sp, #0x10
     194: 913ea100     	add	x0, x8, #0xfa8
     198: 940000a6     	bl	0x430 <_ZL4wordmRm>
     19c: 36000620     	tbz	w0, #0x0, 0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
     1a0: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		00000000000001a0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x28
     1a4: f9400be0     	ldr	x0, [sp, #0x10]
     1a8: f9400108     	ldr	x8, [x8]
		00000000000001a8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     1ac: eb08001f     	cmp	x0, x8
     1b0: 54000581     	b.ne	0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
     1b4: 910063a1     	add	x1, x29, #0x18
     1b8: 9400009e     	bl	0x430 <_ZL4wordmRm>
     1bc: 2a0003e8     	mov	w8, w0
     1c0: 52800040     	mov	w0, #0x2                // =2
     1c4: 36000508     	tbz	w8, #0x0, 0x264 <iq4_f3_executor_selection_on_ui_01+0x20c>
     1c8: f9400fa8     	ldr	x8, [x29, #0x18]
     1cc: eb13011f     	cmp	x8, x19
     1d0: 540004a1     	b.ne	0x264 <iq4_f3_executor_selection_on_ui_01+0x20c>
     1d4: f9400fe8     	ldr	x8, [sp, #0x18]
     1d8: 910033e1     	add	x1, sp, #0xc
     1dc: 91002100     	add	x0, x8, #0x8
     1e0: 94000000     	bl	0x1e0 <iq4_f3_executor_selection_on_ui_01+0x188>
		00000000000001e0:  R_AARCH64_CALL26	f3_executor_selected_get_01
     1e4: 2a0003e8     	mov	w8, w0
     1e8: 52800040     	mov	w0, #0x2                // =2
     1ec: 340003c8     	cbz	w8, 0x264 <iq4_f3_executor_selection_on_ui_01+0x20c>
     1f0: b9400fe8     	ldr	w8, [sp, #0xc]
     1f4: 37f80388     	tbnz	w8, #0x1f, 0x264 <iq4_f3_executor_selection_on_ui_01+0x20c>
     1f8: f9400fe8     	ldr	x8, [sp, #0x18]
     1fc: 910083e1     	add	x1, sp, #0x20
     200: f90013ff     	str	xzr, [sp, #0x20]
     204: 913ea100     	add	x0, x8, #0xfa8
     208: 9400008a     	bl	0x430 <_ZL4wordmRm>
     20c: 360002a0     	tbz	w0, #0x0, 0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
     210: f94013e8     	ldr	x8, [sp, #0x20]
     214: f9400be9     	ldr	x9, [sp, #0x10]
     218: eb09011f     	cmp	x8, x9
     21c: 54000221     	b.ne	0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
     220: f94002a8     	ldr	x8, [x21]
		0000000000000220:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x18
     224: 910083e1     	add	x1, sp, #0x20
     228: 9106a100     	add	x0, x8, #0x1a8
     22c: 94000081     	bl	0x430 <_ZL4wordmRm>
     230: 36000180     	tbz	w0, #0x0, 0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
     234: a941a3e9     	ldp	x9, x8, [sp, #0x18]
     238: eb09011f     	cmp	x8, x9
     23c: 54000121     	b.ne	0x260 <iq4_f3_executor_selection_on_ui_01+0x208>
     240: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		0000000000000240:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x18
     244: 91000108     	add	x8, x8, #0x0
		0000000000000244:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x18
     248: 2a1f03e0     	mov	w0, wzr
     24c: ad400500     	ldp	q0, q1, [x8]
     250: b9400fe8     	ldr	w8, [sp, #0xc]
     254: b9002288     	str	w8, [x20, #0x20]
     258: ad000680     	stp	q0, q1, [x20]
     25c: 14000002     	b	0x264 <iq4_f3_executor_selection_on_ui_01+0x20c>
     260: 52800040     	mov	w0, #0x2                // =2
     264: a9484ff4     	ldp	x20, x19, [sp, #0x80]
     268: f9403bf5     	ldr	x21, [sp, #0x70]
     26c: a9467bfd     	ldp	x29, x30, [sp, #0x60]
     270: 910243ff     	add	sp, sp, #0x90
     274: d65f03c0     	ret
     278: 52800040     	mov	w0, #0x2                // =2
     27c: d65f03c0     	ret

0000000000000280 <_ZL5on_uiv>:
     280: d10203ff     	sub	sp, sp, #0x80
     284: a9067bfd     	stp	x29, x30, [sp, #0x60]
     288: f9003bf3     	str	x19, [sp, #0x70]
     28c: 910183fd     	add	x29, sp, #0x60
     290: 910063a0     	add	x0, x29, #0x18
     294: f9000fbf     	str	xzr, [x29, #0x18]
     298: a9017fff     	stp	xzr, xzr, [sp, #0x10]
     29c: f90007ff     	str	xzr, [sp, #0x8]
     2a0: 94000000     	bl	0x2a0 <_ZL5on_uiv+0x20>
		00000000000002a0:  R_AARCH64_CALL26	f3_executor_current_01
     2a4: 340006e0     	cbz	w0, 0x380 <_ZL5on_uiv+0x100>
     2a8: f9400fb3     	ldr	x19, [x29, #0x18]
     2ac: 92840029     	mov	x9, #-0x2002            // =-8194
     2b0: 2a1f03e0     	mov	w0, wzr
     2b4: d1400668     	sub	x8, x19, #0x1, lsl #12  // =0x1000
     2b8: eb09011f     	cmp	x8, x9
     2bc: 54000628     	b.hi	0x380 <_ZL5on_uiv+0x100>
     2c0: 92400a68     	and	x8, x19, #0x7
     2c4: b50005e8     	cbnz	x8, 0x380 <_ZL5on_uiv+0x100>
     2c8: 910063e1     	add	x1, sp, #0x18
     2cc: aa1303e0     	mov	x0, x19
     2d0: 52800102     	mov	w2, #0x8                // =8
     2d4: 94000000     	bl	0x2d4 <_ZL5on_uiv+0x54>
		00000000000002d4:  R_AARCH64_CALL26	f3_executor_read_01
     2d8: 7100041f     	cmp	w0, #0x1
     2dc: 54000501     	b.ne	0x37c <_ZL5on_uiv+0xfc>
     2e0: 910083e1     	add	x1, sp, #0x20
     2e4: aa1303e0     	mov	x0, x19
     2e8: 52800102     	mov	w2, #0x8                // =8
     2ec: 94000000     	bl	0x2ec <_ZL5on_uiv+0x6c>
		00000000000002ec:  R_AARCH64_CALL26	f3_executor_read_01
     2f0: 7100041f     	cmp	w0, #0x1
     2f4: 54000441     	b.ne	0x37c <_ZL5on_uiv+0xfc>
     2f8: 910063e0     	add	x0, sp, #0x18
     2fc: 910083e1     	add	x1, sp, #0x20
     300: 52800102     	mov	w2, #0x8                // =8
     304: 94000000     	bl	0x304 <_ZL5on_uiv+0x84>
		0000000000000304:  R_AARCH64_CALL26	memcmp
     308: 2a0003e8     	mov	w8, w0
     30c: 2a1f03e0     	mov	w0, wzr
     310: 35000388     	cbnz	w8, 0x380 <_ZL5on_uiv+0x100>
     314: f9400fe8     	ldr	x8, [sp, #0x18]
     318: d16e4508     	sub	x8, x8, #0xb91, lsl #12 // =0xb91000
     31c: f13d211f     	cmp	x8, #0xf48
     320: 54000301     	b.ne	0x380 <_ZL5on_uiv+0x100>
     324: f9400fb3     	ldr	x19, [x29, #0x18]
     328: 91074268     	add	x8, x19, #0x1d0
     32c: d343fd08     	lsr	x8, x8, #3
     330: f108051f     	cmp	x8, #0x201
     334: 54000243     	b.lo	0x37c <_ZL5on_uiv+0xfc>
     338: 91072260     	add	x0, x19, #0x1c8
     33c: 910043e1     	add	x1, sp, #0x10
     340: 52800102     	mov	w2, #0x8                // =8
     344: 94000000     	bl	0x344 <_ZL5on_uiv+0xc4>
		0000000000000344:  R_AARCH64_CALL26	f3_executor_read_01
     348: 7100041f     	cmp	w0, #0x1
     34c: 54000181     	b.ne	0x37c <_ZL5on_uiv+0xfc>
     350: 91072260     	add	x0, x19, #0x1c8
     354: 910083e1     	add	x1, sp, #0x20
     358: 52800102     	mov	w2, #0x8                // =8
     35c: 94000000     	bl	0x35c <_ZL5on_uiv+0xdc>
		000000000000035c:  R_AARCH64_CALL26	f3_executor_read_01
     360: 7100041f     	cmp	w0, #0x1
     364: 540000c1     	b.ne	0x37c <_ZL5on_uiv+0xfc>
     368: 910043e0     	add	x0, sp, #0x10
     36c: 910083e1     	add	x1, sp, #0x20
     370: 52800102     	mov	w2, #0x8                // =8
     374: 94000000     	bl	0x374 <_ZL5on_uiv+0xf4>
		0000000000000374:  R_AARCH64_CALL26	memcmp
     378: 340000c0     	cbz	w0, 0x390 <_ZL5on_uiv+0x110>
     37c: 2a1f03e0     	mov	w0, wzr
     380: a9467bfd     	ldp	x29, x30, [sp, #0x60]
     384: f9403bf3     	ldr	x19, [sp, #0x70]
     388: 910203ff     	add	sp, sp, #0x80
     38c: d65f03c0     	ret
     390: f9400bf3     	ldr	x19, [sp, #0x10]
     394: 92840029     	mov	x9, #-0x2002            // =-8194
     398: d1400668     	sub	x8, x19, #0x1, lsl #12  // =0x1000
     39c: eb09011f     	cmp	x8, x9
     3a0: 54ffff08     	b.hi	0x380 <_ZL5on_uiv+0x100>
     3a4: 92400a68     	and	x8, x19, #0x7
     3a8: b5fffec8     	cbnz	x8, 0x380 <_ZL5on_uiv+0x100>
     3ac: 910063e1     	add	x1, sp, #0x18
     3b0: aa1303e0     	mov	x0, x19
     3b4: 52800102     	mov	w2, #0x8                // =8
     3b8: 94000000     	bl	0x3b8 <_ZL5on_uiv+0x138>
		00000000000003b8:  R_AARCH64_CALL26	f3_executor_read_01
     3bc: 7100041f     	cmp	w0, #0x1
     3c0: 54fffde1     	b.ne	0x37c <_ZL5on_uiv+0xfc>
     3c4: 910083e1     	add	x1, sp, #0x20
     3c8: aa1303e0     	mov	x0, x19
     3cc: 52800102     	mov	w2, #0x8                // =8
     3d0: 94000000     	bl	0x3d0 <_ZL5on_uiv+0x150>
		00000000000003d0:  R_AARCH64_CALL26	f3_executor_read_01
     3d4: 7100041f     	cmp	w0, #0x1
     3d8: 54fffd21     	b.ne	0x37c <_ZL5on_uiv+0xfc>
     3dc: 910063e0     	add	x0, sp, #0x18
     3e0: 910083e1     	add	x1, sp, #0x20
     3e4: 52800102     	mov	w2, #0x8                // =8
     3e8: 94000000     	bl	0x3e8 <_ZL5on_uiv+0x168>
		00000000000003e8:  R_AARCH64_CALL26	memcmp
     3ec: 2a0003e8     	mov	w8, w0
     3f0: 2a1f03e0     	mov	w0, wzr
     3f4: 35fffc68     	cbnz	w8, 0x380 <_ZL5on_uiv+0x100>
     3f8: f9400fe8     	ldr	x8, [sp, #0x18]
     3fc: d16e3d08     	sub	x8, x8, #0xb8f, lsl #12 // =0xb8f000
     400: f10d611f     	cmp	x8, #0x358
     404: 54fffbe1     	b.ne	0x380 <_ZL5on_uiv+0x100>
     408: f9400be8     	ldr	x8, [sp, #0x10]
     40c: 910023e1     	add	x1, sp, #0x8
     410: 91002100     	add	x0, x8, #0x8
     414: 94000007     	bl	0x430 <_ZL4wordmRm>
     418: 3607fb20     	tbz	w0, #0x0, 0x37c <_ZL5on_uiv+0xfc>
     41c: f94007e8     	ldr	x8, [sp, #0x8]
     420: f9400fa9     	ldr	x9, [x29, #0x18]
     424: eb09011f     	cmp	x8, x9
     428: 1a9f17e0     	cset	w0, eq
     42c: 17ffffd5     	b	0x380 <_ZL5on_uiv+0x100>

0000000000000430 <_ZL4wordmRm>:
     430: 91002008     	add	x8, x0, #0x8
     434: d343fd08     	lsr	x8, x8, #3
     438: f108051f     	cmp	x8, #0x201
     43c: 54000062     	b.hs	0x448 <_ZL4wordmRm+0x18>
     440: 2a1f03e0     	mov	w0, wzr
     444: d65f03c0     	ret
     448: d10183ff     	sub	sp, sp, #0x60
     44c: a9047bfd     	stp	x29, x30, [sp, #0x40]
     450: a9054ff4     	stp	x20, x19, [sp, #0x50]
     454: 910103fd     	add	x29, sp, #0x40
     458: 52800102     	mov	w2, #0x8                // =8
     45c: aa0003f4     	mov	x20, x0
     460: aa0103f3     	mov	x19, x1
     464: 94000000     	bl	0x464 <_ZL4wordmRm+0x34>
		0000000000000464:  R_AARCH64_CALL26	f3_executor_read_01
     468: 7100041f     	cmp	w0, #0x1
     46c: 540001c1     	b.ne	0x4a4 <_ZL4wordmRm+0x74>
     470: 910003e1     	mov	x1, sp
     474: aa1403e0     	mov	x0, x20
     478: 52800102     	mov	w2, #0x8                // =8
     47c: 94000000     	bl	0x47c <_ZL4wordmRm+0x4c>
		000000000000047c:  R_AARCH64_CALL26	f3_executor_read_01
     480: 7100041f     	cmp	w0, #0x1
     484: 54000101     	b.ne	0x4a4 <_ZL4wordmRm+0x74>
     488: 910003e1     	mov	x1, sp
     48c: aa1303e0     	mov	x0, x19
     490: 52800102     	mov	w2, #0x8                // =8
     494: 94000000     	bl	0x494 <_ZL4wordmRm+0x64>
		0000000000000494:  R_AARCH64_CALL26	memcmp
     498: 7100001f     	cmp	w0, #0x0
     49c: 1a9f17e0     	cset	w0, eq
     4a0: 14000002     	b	0x4a8 <_ZL4wordmRm+0x78>
     4a4: 2a1f03e0     	mov	w0, wzr
     4a8: a9454ff4     	ldp	x20, x19, [sp, #0x50]
     4ac: a9447bfd     	ldp	x29, x30, [sp, #0x40]
     4b0: 910183ff     	add	sp, sp, #0x60
     4b4: d65f03c0     	ret

00000000000004b8 <iq4_f3_executor_begin_on_ui_01>:
     4b8: b40001e0     	cbz	x0, 0x4f4 <iq4_f3_executor_begin_on_ui_01+0x3c>
     4bc: d100c3ff     	sub	sp, sp, #0x30
     4c0: a9017bfd     	stp	x29, x30, [sp, #0x10]
     4c4: a9024ff4     	stp	x20, x19, [sp, #0x20]
     4c8: 910043fd     	add	x29, sp, #0x10
     4cc: aa0003f4     	mov	x20, x0
     4d0: 97ffff6c     	bl	0x280 <_ZL5on_uiv>
     4d4: 36000140     	tbz	w0, #0x0, 0x4fc <iq4_f3_executor_begin_on_ui_01+0x44>
     4d8: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		00000000000004d8:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     4dc: 91000108     	add	x8, x8, #0x0
		00000000000004dc:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     4e0: 88dffd09     	ldar	w9, [x8]
     4e4: 7100153f     	cmp	w9, #0x5
     4e8: 540000e1     	b.ne	0x504 <iq4_f3_executor_begin_on_ui_01+0x4c>
     4ec: 52800060     	mov	w0, #0x3                // =3
     4f0: 14000020     	b	0x570 <iq4_f3_executor_begin_on_ui_01+0xb8>
     4f4: 52800040     	mov	w0, #0x2                // =2
     4f8: d65f03c0     	ret
     4fc: 52800040     	mov	w0, #0x2                // =2
     500: 1400001c     	b	0x570 <iq4_f3_executor_begin_on_ui_01+0xb8>
     504: 90000009     	adrp	x9, 0x0 <iq4_f3_executor_hold_01>
		0000000000000504:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x4
     508: 91000129     	add	x9, x9, #0x0
		0000000000000508:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x4
     50c: 88dffd29     	ldar	w9, [x9]
     510: 350002e9     	cbnz	w9, 0x56c <iq4_f3_executor_begin_on_ui_01+0xb4>
     514: 528000c9     	mov	w9, #0x6                // =6
     518: 885ffd0a     	ldaxr	w10, [x8]
     51c: 7100055f     	cmp	w10, #0x1
     520: 54000241     	b.ne	0x568 <iq4_f3_executor_begin_on_ui_01+0xb0>
     524: 880afd09     	stlxr	w10, w9, [x8]
     528: 35ffff8a     	cbnz	w10, 0x518 <iq4_f3_executor_begin_on_ui_01+0x60>
     52c: 90000013     	adrp	x19, 0x0 <iq4_f3_executor_hold_01>
		000000000000052c:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     530: 91000273     	add	x19, x19, #0x0
		0000000000000530:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     534: 910003e2     	mov	x2, sp
     538: 52800060     	mov	w0, #0x3                // =3
     53c: aa1303e1     	mov	x1, x19
     540: a9007fff     	stp	xzr, xzr, [sp]
     544: 94000000     	bl	0x544 <iq4_f3_executor_begin_on_ui_01+0x8c>
		0000000000000544:  R_AARCH64_CALL26	iq4_activity_try_01
     548: 340001c0     	cbz	w0, 0x580 <iq4_f3_executor_begin_on_ui_01+0xc8>
     54c: 91018268     	add	x8, x19, #0x60
     550: 91016269     	add	x9, x19, #0x58
     554: 52800020     	mov	w0, #0x1                // =1
     558: c89ffd1f     	stlr	xzr, [x8]
     55c: c89ffd3f     	stlr	xzr, [x9]
     560: 889ffe60     	stlr	w0, [x19]
     564: 14000003     	b	0x570 <iq4_f3_executor_begin_on_ui_01+0xb8>
     568: d5033f5f     	clrex
     56c: 52800020     	mov	w0, #0x1                // =1
     570: a9424ff4     	ldp	x20, x19, [sp, #0x20]
     574: a9417bfd     	ldp	x29, x30, [sp, #0x10]
     578: 9100c3ff     	add	sp, sp, #0x30
     57c: d65f03c0     	ret
     580: a94027e8     	ldp	x8, x9, [sp]
     584: 9000000a     	adrp	x10, 0x0 <iq4_f3_executor_hold_01>
		0000000000000584:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x10
     588: 9100014a     	add	x10, x10, #0x0
		0000000000000588:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x10
     58c: 9101414b     	add	x11, x10, #0x50
     590: 9101214c     	add	x12, x10, #0x48
     594: c89ffd69     	stlr	x9, [x11]
     598: c89ffd88     	stlr	x8, [x12]
     59c: c8dffd48     	ldar	x8, [x10]
     5a0: b100051f     	cmn	x8, #0x1
     5a4: 54000220     	b.eq	0x5e8 <iq4_f3_executor_begin_on_ui_01+0x130>
     5a8: 90000009     	adrp	x9, 0x0 <iq4_f3_executor_hold_01>
		00000000000005a8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xc
     5ac: 91000129     	add	x9, x9, #0x0
		00000000000005ac:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0xc
     5b0: 91000508     	add	x8, x8, #0x1
     5b4: 9100112a     	add	x10, x9, #0x4
     5b8: 6f00e400     	movi	v0.2d, #0000000000000000
     5bc: 2a1f03e0     	mov	w0, wzr
     5c0: c89ffd48     	stlr	x8, [x10]
     5c4: 9101712a     	add	x10, x9, #0x5c
     5c8: b900013f     	str	wzr, [x9]
     5cc: 889ffd5f     	stlr	wzr, [x10]
     5d0: 3dc003e1     	ldr	q1, [sp]
     5d4: 3c83c120     	stur	q0, [x9, #0x3c]
     5d8: 3c82c120     	stur	q0, [x9, #0x2c]
     5dc: f9000288     	str	x8, [x20]
     5e0: 3c808281     	stur	q1, [x20, #0x8]
     5e4: 17ffffe3     	b	0x570 <iq4_f3_executor_begin_on_ui_01+0xb8>
     5e8: 94000000     	bl	0x5e8 <iq4_f3_executor_begin_on_ui_01+0x130>
		00000000000005e8:  R_AARCH64_CALL26	iq4_f3_executor_hold_01
     5ec: 52800060     	mov	w0, #0x3                // =3
     5f0: 17ffffe0     	b	0x570 <iq4_f3_executor_begin_on_ui_01+0xb8>

00000000000005f4 <iq4_f3_executor_cancel_on_ui_01>:
     5f4: d100c3ff     	sub	sp, sp, #0x30
     5f8: a9017bfd     	stp	x29, x30, [sp, #0x10]
     5fc: a9024ff4     	stp	x20, x19, [sp, #0x20]
     600: 910043fd     	add	x29, sp, #0x10
     604: aa0003f3     	mov	x19, x0
     608: 97ffff1e     	bl	0x280 <_ZL5on_uiv>
     60c: 36000460     	tbz	w0, #0x0, 0x698 <iq4_f3_executor_cancel_on_ui_01+0xa4>
     610: 90000014     	adrp	x20, 0x0 <iq4_f3_executor_hold_01>
		0000000000000610:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     614: 91000294     	add	x20, x20, #0x0
		0000000000000614:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     618: 88dffe88     	ldar	w8, [x20]
     61c: 7100191f     	cmp	w8, #0x6
     620: 540003c1     	b.ne	0x698 <iq4_f3_executor_cancel_on_ui_01+0xa4>
     624: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		0000000000000624:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x10
     628: 91000108     	add	x8, x8, #0x0
		0000000000000628:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x10
     62c: c8dffd08     	ldar	x8, [x8]
     630: eb08027f     	cmp	x19, x8
     634: 54000321     	b.ne	0x698 <iq4_f3_executor_cancel_on_ui_01+0xa4>
     638: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		0000000000000638:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x58
     63c: 91000108     	add	x8, x8, #0x0
		000000000000063c:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x58
     640: 910003e0     	mov	x0, sp
     644: c8dffd09     	ldar	x9, [x8]
     648: 91002108     	add	x8, x8, #0x8
     64c: c8dffd08     	ldar	x8, [x8]
     650: a90023e9     	stp	x9, x8, [sp]
     654: 94000000     	bl	0x654 <iq4_f3_executor_cancel_on_ui_01+0x60>
		0000000000000654:  R_AARCH64_CALL26	iq4_activity_release_01
     658: 340002a0     	cbz	w0, 0x6ac <iq4_f3_executor_cancel_on_ui_01+0xb8>
     65c: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		000000000000065c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x8
     660: 91000108     	add	x8, x8, #0x0
		0000000000000660:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x8
     664: 52800029     	mov	w9, #0x1                // =1
     668: 9101410a     	add	x10, x8, #0x50
     66c: 889ffd09     	stlr	w9, [x8]
     670: 91016108     	add	x8, x8, #0x58
     674: c8dffd49     	ldar	x9, [x10]
     678: c8dffd08     	ldar	x8, [x8]
     67c: a90023e9     	stp	x9, x8, [sp]
     680: b4000069     	cbz	x9, 0x68c <iq4_f3_executor_cancel_on_ui_01+0x98>
     684: 910003e0     	mov	x0, sp
     688: 94000000     	bl	0x688 <iq4_f3_executor_cancel_on_ui_01+0x94>
		0000000000000688:  R_AARCH64_CALL26	iq4_activity_hold_01
     68c: 528000a8     	mov	w8, #0x5                // =5
     690: 52800060     	mov	w0, #0x3                // =3
     694: 1400000b     	b	0x6c0 <iq4_f3_executor_cancel_on_ui_01+0xcc>
     698: 52800040     	mov	w0, #0x2                // =2
     69c: a9424ff4     	ldp	x20, x19, [sp, #0x20]
     6a0: a9417bfd     	ldp	x29, x30, [sp, #0x10]
     6a4: 9100c3ff     	add	sp, sp, #0x30
     6a8: d65f03c0     	ret
     6ac: 91018288     	add	x8, x20, #0x60
     6b0: 91016289     	add	x9, x20, #0x58
     6b4: c89ffd1f     	stlr	xzr, [x8]
     6b8: 52800028     	mov	w8, #0x1                // =1
     6bc: c89ffd3f     	stlr	xzr, [x9]
     6c0: 889ffe88     	stlr	w8, [x20]
     6c4: 17fffff6     	b	0x69c <iq4_f3_executor_cancel_on_ui_01+0xa8>

00000000000006c8 <iq4_f3_executor_submit_on_ui_01>:
     6c8: b40005a0     	cbz	x0, 0x77c <iq4_f3_executor_submit_on_ui_01+0xb4>
     6cc: d100c3ff     	sub	sp, sp, #0x30
     6d0: a9017bfd     	stp	x29, x30, [sp, #0x10]
     6d4: a9024ff4     	stp	x20, x19, [sp, #0x20]
     6d8: 910043fd     	add	x29, sp, #0x10
     6dc: aa0003f3     	mov	x19, x0
     6e0: 97fffee8     	bl	0x280 <_ZL5on_uiv>
     6e4: 36000420     	tbz	w0, #0x0, 0x768 <iq4_f3_executor_submit_on_ui_01+0xa0>
     6e8: 90000014     	adrp	x20, 0x0 <iq4_f3_executor_hold_01>
		00000000000006e8:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     6ec: 91000294     	add	x20, x20, #0x0
		00000000000006ec:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     6f0: 88dffe88     	ldar	w8, [x20]
     6f4: 7100191f     	cmp	w8, #0x6
     6f8: 54000381     	b.ne	0x768 <iq4_f3_executor_submit_on_ui_01+0xa0>
     6fc: f9400268     	ldr	x8, [x19]
     700: b4000348     	cbz	x8, 0x768 <iq4_f3_executor_submit_on_ui_01+0xa0>
     704: f9400668     	ldr	x8, [x19, #0x8]
     708: b4000308     	cbz	x8, 0x768 <iq4_f3_executor_submit_on_ui_01+0xa0>
     70c: 90000009     	adrp	x9, 0x0 <iq4_f3_executor_hold_01>
		000000000000070c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x10
     710: 91000129     	add	x9, x9, #0x0
		0000000000000710:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x10
     714: f9400a68     	ldr	x8, [x19, #0x10]
     718: c8dffd29     	ldar	x9, [x9]
     71c: eb09011f     	cmp	x8, x9
     720: 54000241     	b.ne	0x768 <iq4_f3_executor_submit_on_ui_01+0xa0>
     724: f9400e68     	ldr	x8, [x19, #0x18]
     728: 9284002a     	mov	x10, #-0x2002           // =-8194
     72c: 52800040     	mov	w0, #0x2                // =2
     730: d1400509     	sub	x9, x8, #0x1, lsl #12   // =0x1000
     734: eb0a013f     	cmp	x9, x10
     738: 540001a8     	b.hi	0x76c <iq4_f3_executor_submit_on_ui_01+0xa4>
     73c: 92400908     	and	x8, x8, #0x7
     740: b5000168     	cbnz	x8, 0x76c <iq4_f3_executor_submit_on_ui_01+0xa4>
     744: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		0000000000000744:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x58
     748: 91000108     	add	x8, x8, #0x0
		0000000000000748:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x58
     74c: 910003e0     	mov	x0, sp
     750: c8dffd09     	ldar	x9, [x8]
     754: 91002108     	add	x8, x8, #0x8
     758: c8dffd08     	ldar	x8, [x8]
     75c: a90023e9     	stp	x9, x8, [sp]
     760: 94000000     	bl	0x760 <iq4_f3_executor_submit_on_ui_01+0x98>
		0000000000000760:  R_AARCH64_CALL26	iq4_activity_valid_01
     764: 34000100     	cbz	w0, 0x784 <iq4_f3_executor_submit_on_ui_01+0xbc>
     768: 52800040     	mov	w0, #0x2                // =2
     76c: a9424ff4     	ldp	x20, x19, [sp, #0x20]
     770: a9417bfd     	ldp	x29, x30, [sp, #0x10]
     774: 9100c3ff     	add	sp, sp, #0x30
     778: d65f03c0     	ret
     77c: 52800040     	mov	w0, #0x2                // =2
     780: d65f03c0     	ret
     784: f9400e60     	ldr	x0, [x19, #0x18]
     788: 910003e1     	mov	x1, sp
     78c: f90003ff     	str	xzr, [sp]
     790: 97ffff28     	bl	0x430 <_ZL4wordmRm>
     794: 2a0003e8     	mov	w8, w0
     798: 52800040     	mov	w0, #0x2                // =2
     79c: 3607fe88     	tbz	w8, #0x0, 0x76c <iq4_f3_executor_submit_on_ui_01+0xa4>
     7a0: f94003e8     	ldr	x8, [sp]
     7a4: d1708d08     	sub	x8, x8, #0xc23, lsl #12 // =0xc23000
     7a8: f11e811f     	cmp	x8, #0x7a0
     7ac: 54fffe01     	b.ne	0x76c <iq4_f3_executor_submit_on_ui_01+0xa4>
     7b0: ad400261     	ldp	q1, q0, [x19]
     7b4: 52800048     	mov	w8, #0x2                // =2
     7b8: 9101c280     	add	x0, x20, #0x70
     7bc: 3c848280     	stur	q0, [x20, #0x48]
     7c0: 3c838281     	stur	q1, [x20, #0x38]
     7c4: 889ffe88     	stlr	w8, [x20]
     7c8: 94000000     	bl	0x7c8 <iq4_f3_executor_submit_on_ui_01+0x100>
		00000000000007c8:  R_AARCH64_CALL26	f3_executor_event_notify_01
     7cc: 34000060     	cbz	w0, 0x7d8 <iq4_f3_executor_submit_on_ui_01+0x110>
     7d0: 2a1f03e0     	mov	w0, wzr
     7d4: 17ffffe6     	b	0x76c <iq4_f3_executor_submit_on_ui_01+0xa4>
     7d8: 94000000     	bl	0x7d8 <iq4_f3_executor_submit_on_ui_01+0x110>
		00000000000007d8:  R_AARCH64_CALL26	iq4_f3_executor_hold_01
     7dc: 52800060     	mov	w0, #0x3                // =3
     7e0: 17ffffe3     	b	0x76c <iq4_f3_executor_submit_on_ui_01+0xa4>

00000000000007e4 <iq4_f3_executor_view_on_ui_01>:
     7e4: b40003e0     	cbz	x0, 0x860 <iq4_f3_executor_view_on_ui_01+0x7c>
     7e8: d10103ff     	sub	sp, sp, #0x40
     7ec: a9027bfd     	stp	x29, x30, [sp, #0x20]
     7f0: f9001bf3     	str	x19, [sp, #0x30]
     7f4: 910083fd     	add	x29, sp, #0x20
     7f8: aa0003f3     	mov	x19, x0
     7fc: 97fffea1     	bl	0x280 <_ZL5on_uiv>
     800: 36000260     	tbz	w0, #0x0, 0x84c <iq4_f3_executor_view_on_ui_01+0x68>
     804: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		0000000000000804:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     808: 91000108     	add	x8, x8, #0x0
		0000000000000808:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     80c: 88dffd08     	ldar	w8, [x8]
     810: 340001e8     	cbz	w8, 0x84c <iq4_f3_executor_view_on_ui_01+0x68>
     814: 90000009     	adrp	x9, 0x0 <iq4_f3_executor_hold_01>
		0000000000000814:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x10
     818: 91000129     	add	x9, x9, #0x0
		0000000000000818:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x10
     81c: 7100151f     	cmp	w8, #0x5
     820: 9101612a     	add	x10, x9, #0x58
     824: 88dffd4a     	ldar	w10, [x10]
     828: c8dffd2b     	ldar	x11, [x9]
     82c: 3cc18120     	ldur	q0, [x9, #0x18]
     830: 3cc08121     	ldur	q1, [x9, #0x8]
     834: 29002a68     	stp	w8, w10, [x19]
     838: 52800068     	mov	w8, #0x3                // =3
     83c: 1a9f0100     	csel	w0, w8, wzr, eq
     840: f900066b     	str	x11, [x19, #0x8]
     844: ad008261     	stp	q1, q0, [x19, #0x10]
     848: 14000002     	b	0x850 <iq4_f3_executor_view_on_ui_01+0x6c>
     84c: 52800040     	mov	w0, #0x2                // =2
     850: a9427bfd     	ldp	x29, x30, [sp, #0x20]
     854: f9401bf3     	ldr	x19, [sp, #0x30]
     858: 910103ff     	add	sp, sp, #0x40
     85c: d65f03c0     	ret
     860: 52800040     	mov	w0, #0x2                // =2
     864: d65f03c0     	ret

0000000000000868 <iq4_f3_executor_finish_on_ui_01>:
     868: d100c3ff     	sub	sp, sp, #0x30
     86c: a9017bfd     	stp	x29, x30, [sp, #0x10]
     870: a9024ff4     	stp	x20, x19, [sp, #0x20]
     874: 910043fd     	add	x29, sp, #0x10
     878: aa0003f3     	mov	x19, x0
     87c: 97fffe81     	bl	0x280 <_ZL5on_uiv>
     880: 36000480     	tbz	w0, #0x0, 0x910 <iq4_f3_executor_finish_on_ui_01+0xa8>
     884: 90000014     	adrp	x20, 0x0 <iq4_f3_executor_hold_01>
		0000000000000884:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     888: 91000294     	add	x20, x20, #0x0
		0000000000000888:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     88c: 88dffe88     	ldar	w8, [x20]
     890: 7100111f     	cmp	w8, #0x4
     894: 540003e1     	b.ne	0x910 <iq4_f3_executor_finish_on_ui_01+0xa8>
     898: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		0000000000000898:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x10
     89c: 91000108     	add	x8, x8, #0x0
		000000000000089c:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x10
     8a0: c8dffd08     	ldar	x8, [x8]
     8a4: eb08027f     	cmp	x19, x8
     8a8: 54000341     	b.ne	0x910 <iq4_f3_executor_finish_on_ui_01+0xa8>
     8ac: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		00000000000008ac:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x4
     8b0: 91000108     	add	x8, x8, #0x0
		00000000000008b0:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x4
     8b4: 88dffd08     	ldar	w8, [x8]
     8b8: 350002c8     	cbnz	w8, 0x910 <iq4_f3_executor_finish_on_ui_01+0xa8>
     8bc: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		00000000000008bc:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x58
     8c0: 91000108     	add	x8, x8, #0x0
		00000000000008c0:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x58
     8c4: 910003e0     	mov	x0, sp
     8c8: c8dffd09     	ldar	x9, [x8]
     8cc: 91002108     	add	x8, x8, #0x8
     8d0: c8dffd08     	ldar	x8, [x8]
     8d4: a90023e9     	stp	x9, x8, [sp]
     8d8: 94000000     	bl	0x8d8 <iq4_f3_executor_finish_on_ui_01+0x70>
		00000000000008d8:  R_AARCH64_CALL26	iq4_activity_valid_01
     8dc: 7100081f     	cmp	w0, #0x2
     8e0: 54000181     	b.ne	0x910 <iq4_f3_executor_finish_on_ui_01+0xa8>
     8e4: 6f00e400     	movi	v0.2d, #0000000000000000
     8e8: 91018288     	add	x8, x20, #0x60
     8ec: 2a1f03e0     	mov	w0, wzr
     8f0: 91016289     	add	x9, x20, #0x58
     8f4: c89ffd1f     	stlr	xzr, [x8]
     8f8: 52800028     	mov	w8, #0x1                // =1
     8fc: c89ffd3f     	stlr	xzr, [x9]
     900: 3c848280     	stur	q0, [x20, #0x48]
     904: 3c838280     	stur	q0, [x20, #0x38]
     908: 889ffe88     	stlr	w8, [x20]
     90c: 14000002     	b	0x914 <iq4_f3_executor_finish_on_ui_01+0xac>
     910: 52800040     	mov	w0, #0x2                // =2
     914: a9424ff4     	ldp	x20, x19, [sp, #0x20]
     918: a9417bfd     	ldp	x29, x30, [sp, #0x10]
     91c: 9100c3ff     	add	sp, sp, #0x30
     920: d65f03c0     	ret

0000000000000924 <iq4_f3_executor_invoke_saved_on_native_01>:
     924: d10143ff     	sub	sp, sp, #0x50
     928: a9027bfd     	stp	x29, x30, [sp, #0x20]
     92c: a90357f6     	stp	x22, x21, [sp, #0x30]
     930: a9044ff4     	stp	x20, x19, [sp, #0x40]
     934: 910083fd     	add	x29, sp, #0x20
     938: a9007fff     	stp	xzr, xzr, [sp]
     93c: b40007e0     	cbz	x0, 0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     940: f9400008     	ldr	x8, [x0]
     944: b40007a8     	cbz	x8, 0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     948: f9400408     	ldr	x8, [x0, #0x8]
     94c: b4000768     	cbz	x8, 0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     950: aa0003e8     	mov	x8, x0
     954: 52800040     	mov	w0, #0x2                // =2
     958: b4000721     	cbz	x1, 0xa3c <iq4_f3_executor_invoke_saved_on_native_01+0x118>
     95c: aa0803f3     	mov	x19, x8
     960: f9400d08     	ldr	x8, [x8, #0x18]
     964: b50006c8     	cbnz	x8, 0xa3c <iq4_f3_executor_invoke_saved_on_native_01+0x118>
     968: 910023e0     	add	x0, sp, #0x8
     96c: aa0103f4     	mov	x20, x1
     970: 94000000     	bl	0x970 <iq4_f3_executor_invoke_saved_on_native_01+0x4c>
		0000000000000970:  R_AARCH64_CALL26	f3_executor_current_01
     974: 34000620     	cbz	w0, 0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     978: f94007e8     	ldr	x8, [sp, #0x8]
     97c: 52820029     	mov	w9, #0x1001             // =4097
     980: 52800040     	mov	w0, #0x2                // =2
     984: 8b090109     	add	x9, x8, x9
     988: f140093f     	cmp	x9, #0x2, lsl #12       // =0x2000
     98c: 54000589     	b.ls	0xa3c <iq4_f3_executor_invoke_saved_on_native_01+0x118>
     990: 92400909     	and	x9, x8, #0x7
     994: b5000549     	cbnz	x9, 0xa3c <iq4_f3_executor_invoke_saved_on_native_01+0x118>
     998: 90000009     	adrp	x9, 0x0 <iq4_f3_executor_hold_01>
		0000000000000998:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x18
     99c: f9400129     	ldr	x9, [x9]
		000000000000099c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x18
     9a0: eb09011f     	cmp	x8, x9
     9a4: 540004c0     	b.eq	0xa3c <iq4_f3_executor_invoke_saved_on_native_01+0x118>
     9a8: 910003e1     	mov	x1, sp
     9ac: aa0803e0     	mov	x0, x8
     9b0: 97fffea0     	bl	0x430 <_ZL4wordmRm>
     9b4: 36000420     	tbz	w0, #0x0, 0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     9b8: f94003e8     	ldr	x8, [sp]
     9bc: 52800040     	mov	w0, #0x2                // =2
     9c0: d16e0109     	sub	x9, x8, #0xb80, lsl #12 // =0xb80000
     9c4: f117013f     	cmp	x9, #0x5c0
     9c8: 540003a0     	b.eq	0xa3c <iq4_f3_executor_invoke_saved_on_native_01+0x118>
     9cc: 5283e909     	mov	w9, #0x1f48             // =8008
     9d0: 72a01729     	movk	w9, #0xb9, lsl #16
     9d4: eb09011f     	cmp	x8, x9
     9d8: 54000320     	b.eq	0xa3c <iq4_f3_executor_invoke_saved_on_native_01+0x118>
     9dc: 94000000     	bl	0x9dc <iq4_f3_executor_invoke_saved_on_native_01+0xb8>
		00000000000009dc:  R_AARCH64_CALL26	f3_executor_tid_01
     9e0: b40002c0     	cbz	x0, 0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     9e4: b9402e89     	ldr	w9, [x20, #0x2c]
     9e8: 35000289     	cbnz	w9, 0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     9ec: b9402a89     	ldr	w9, [x20, #0x28]
     9f0: aa1403e8     	mov	x8, x20
     9f4: 71000d3f     	cmp	w9, #0x3
     9f8: 54000201     	b.ne	0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     9fc: b9403109     	ldr	w9, [x8, #0x30]
     a00: 340001c9     	cbz	w9, 0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     a04: b9404509     	ldr	w9, [x8, #0x44]
     a08: 34000189     	cbz	w9, 0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     a0c: b9403509     	ldr	w9, [x8, #0x34]
     a10: 34000149     	cbz	w9, 0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     a14: b9403909     	ldr	w9, [x8, #0x38]
     a18: 34000109     	cbz	w9, 0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     a1c: b9403d09     	ldr	w9, [x8, #0x3c]
     a20: 340000c9     	cbz	w9, 0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     a24: b9404108     	ldr	w8, [x8, #0x40]
     a28: 34000088     	cbz	w8, 0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     a2c: b9407688     	ldr	w8, [x20, #0x74]
     a30: 3100051f     	cmn	w8, #0x1
     a34: 540000e0     	b.eq	0xa50 <iq4_f3_executor_invoke_saved_on_native_01+0x12c>
     a38: 52800040     	mov	w0, #0x2                // =2
     a3c: a9444ff4     	ldp	x20, x19, [sp, #0x40]
     a40: a94357f6     	ldp	x22, x21, [sp, #0x30]
     a44: a9427bfd     	ldp	x29, x30, [sp, #0x20]
     a48: 910143ff     	add	sp, sp, #0x50
     a4c: d65f03c0     	ret
     a50: b9407288     	ldr	w8, [x20, #0x70]
     a54: 37ffff28     	tbnz	w8, #0x1f, 0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     a58: f9402688     	ldr	x8, [x20, #0x48]
     a5c: 9284002a     	mov	x10, #-0x2002           // =-8194
     a60: 52800040     	mov	w0, #0x2                // =2
     a64: d1400509     	sub	x9, x8, #0x1, lsl #12   // =0x1000
     a68: eb0a013f     	cmp	x9, x10
     a6c: 54fffe88     	b.hi	0xa3c <iq4_f3_executor_invoke_saved_on_native_01+0x118>
     a70: 92400909     	and	x9, x8, #0x7
     a74: b5fffe49     	cbnz	x9, 0xa3c <iq4_f3_executor_invoke_saved_on_native_01+0x118>
     a78: 910003e1     	mov	x1, sp
     a7c: aa0803e0     	mov	x0, x8
     a80: 97fffe6c     	bl	0x430 <_ZL4wordmRm>
     a84: 2a0003e8     	mov	w8, w0
     a88: 52800040     	mov	w0, #0x2                // =2
     a8c: 3607fd88     	tbz	w8, #0x0, 0xa3c <iq4_f3_executor_invoke_saved_on_native_01+0x118>
     a90: f94003e8     	ldr	x8, [sp]
     a94: d176f108     	sub	x8, x8, #0xdbc, lsl #12 // =0xdbc000
     a98: f11ae11f     	cmp	x8, #0x6b8
     a9c: 54fffd01     	b.ne	0xa3c <iq4_f3_executor_invoke_saved_on_native_01+0x118>
     aa0: f9403295     	ldr	x21, [x20, #0x60]
     aa4: b4fffcd5     	cbz	x21, 0xa3c <iq4_f3_executor_invoke_saved_on_native_01+0x118>
     aa8: 94000000     	bl	0xaa8 <iq4_f3_executor_invoke_saved_on_native_01+0x184>
		0000000000000aa8:  R_AARCH64_CALL26	f3_executor_pthread_self_01
     aac: eb0002bf     	cmp	x21, x0
     ab0: 54fffc41     	b.ne	0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     ab4: f940d289     	ldr	x9, [x20, #0x1a0]
     ab8: eb14013f     	cmp	x9, x20
     abc: 54fffbe1     	b.ne	0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     ac0: 91066280     	add	x0, x20, #0x198
     ac4: 94000000     	bl	0xac4 <iq4_f3_executor_invoke_saved_on_native_01+0x1a0>
		0000000000000ac4:  R_AARCH64_CALL26	iq4_activity_valid_01
     ac8: 35fffb80     	cbnz	w0, 0xa38 <iq4_f3_executor_invoke_saved_on_native_01+0x114>
     acc: 90000015     	adrp	x21, 0x0 <iq4_f3_executor_hold_01>
		0000000000000acc:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     ad0: 910002b5     	add	x21, x21, #0x0
		0000000000000ad0:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     ad4: 88dffea8     	ldar	w8, [x21]
     ad8: 7100151f     	cmp	w8, #0x5
     adc: 54000061     	b.ne	0xae8 <iq4_f3_executor_invoke_saved_on_native_01+0x1c4>
     ae0: 52800060     	mov	w0, #0x3                // =3
     ae4: 17ffffd6     	b	0xa3c <iq4_f3_executor_invoke_saved_on_native_01+0x118>
     ae8: 90000016     	adrp	x22, 0x0 <iq4_f3_executor_hold_01>
		0000000000000ae8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x4
     aec: 910002d6     	add	x22, x22, #0x0
		0000000000000aec:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x4
     af0: 88dffec8     	ldar	w8, [x22]
     af4: 34000068     	cbz	w8, 0xb00 <iq4_f3_executor_invoke_saved_on_native_01+0x1dc>
     af8: 52800020     	mov	w0, #0x1                // =1
     afc: 17ffffd0     	b	0xa3c <iq4_f3_executor_invoke_saved_on_native_01+0x118>
     b00: 528000c8     	mov	w8, #0x6                // =6
     b04: 885ffea9     	ldaxr	w9, [x21]
     b08: 7100053f     	cmp	w9, #0x1
     b0c: 540006a1     	b.ne	0xbe0 <iq4_f3_executor_invoke_saved_on_native_01+0x2bc>
     b10: 8809fea8     	stlxr	w9, w8, [x21]
     b14: 35ffff89     	cbnz	w9, 0xb04 <iq4_f3_executor_invoke_saved_on_native_01+0x1e0>
     b18: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		0000000000000b18:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x10
     b1c: 91000108     	add	x8, x8, #0x0
		0000000000000b1c:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x10
     b20: c8dffd08     	ldar	x8, [x8]
     b24: b100051f     	cmn	x8, #0x1
     b28: 54000740     	b.eq	0xc10 <iq4_f3_executor_invoke_saved_on_native_01+0x2ec>
     b2c: a959aa89     	ldp	x9, x10, [x20, #0x198]
     b30: 9000000b     	adrp	x11, 0x0 <iq4_f3_executor_hold_01>
		0000000000000b30:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xc
     b34: 9100016b     	add	x11, x11, #0x0
		0000000000000b34:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0xc
     b38: 91000508     	add	x8, x8, #0x1
     b3c: 9101516c     	add	x12, x11, #0x54
     b40: c89ffd8a     	stlr	x10, [x12]
     b44: 9101316a     	add	x10, x11, #0x4c
     b48: 5280002c     	mov	w12, #0x1               // =1
     b4c: c89ffd49     	stlr	x9, [x10]
     b50: 91001169     	add	x9, x11, #0x4
     b54: b900016c     	str	w12, [x11]
     b58: c89ffd28     	stlr	x8, [x9]
     b5c: ad400261     	ldp	q1, q0, [x19]
     b60: 3c83c160     	stur	q0, [x11, #0x3c]
     b64: f803c168     	stur	x8, [x11, #0x3c]
     b68: 91017168     	add	x8, x11, #0x5c
     b6c: 3c82c161     	stur	q1, [x11, #0x2c]
     b70: 889ffd1f     	stlr	wzr, [x8]
     b74: 94000000     	bl	0xb74 <iq4_f3_executor_invoke_saved_on_native_01+0x250>
		0000000000000b74:  R_AARCH64_CALL26	f3_executor_clock_01
     b78: b40004c0     	cbz	x0, 0xc10 <iq4_f3_executor_invoke_saved_on_native_01+0x2ec>
     b7c: aa0003f3     	mov	x19, x0
     b80: 52800048     	mov	w8, #0x2                // =2
     b84: 9101c2a0     	add	x0, x21, #0x70
     b88: 889ffea8     	stlr	w8, [x21]
     b8c: 94000000     	bl	0xb8c <iq4_f3_executor_invoke_saved_on_native_01+0x268>
		0000000000000b8c:  R_AARCH64_CALL26	f3_executor_event_notify_01
     b90: 34000400     	cbz	w0, 0xc10 <iq4_f3_executor_invoke_saved_on_native_01+0x2ec>
     b94: d28dfff4     	mov	x20, #0x6fff            // =28671
     b98: f2b65934     	movk	x20, #0xb2c9, lsl #16
     b9c: f2c01174     	movk	x20, #0x8b, lsl #32
     ba0: 88dffea8     	ldar	w8, [x21]
     ba4: 7100111f     	cmp	w8, #0x4
     ba8: 54000080     	b.eq	0xbb8 <iq4_f3_executor_invoke_saved_on_native_01+0x294>
     bac: 7100151f     	cmp	w8, #0x5
     bb0: 54000081     	b.ne	0xbc0 <iq4_f3_executor_invoke_saved_on_native_01+0x29c>
     bb4: 17ffffcb     	b	0xae0 <iq4_f3_executor_invoke_saved_on_native_01+0x1bc>
     bb8: 88dffec8     	ldar	w8, [x22]
     bbc: 34000188     	cbz	w8, 0xbec <iq4_f3_executor_invoke_saved_on_native_01+0x2c8>
     bc0: 94000000     	bl	0xbc0 <iq4_f3_executor_invoke_saved_on_native_01+0x29c>
		0000000000000bc0:  R_AARCH64_CALL26	f3_executor_clock_01
     bc4: eb130008     	subs	x8, x0, x19
     bc8: 54000243     	b.lo	0xc10 <iq4_f3_executor_invoke_saved_on_native_01+0x2ec>
     bcc: eb14011f     	cmp	x8, x20
     bd0: 54000208     	b.hi	0xc10 <iq4_f3_executor_invoke_saved_on_native_01+0x2ec>
     bd4: 94000000     	bl	0xbd4 <iq4_f3_executor_invoke_saved_on_native_01+0x2b0>
		0000000000000bd4:  R_AARCH64_CALL26	f3_executor_pause_01
     bd8: 35fffe40     	cbnz	w0, 0xba0 <iq4_f3_executor_invoke_saved_on_native_01+0x27c>
     bdc: 1400000d     	b	0xc10 <iq4_f3_executor_invoke_saved_on_native_01+0x2ec>
     be0: d5033f5f     	clrex
     be4: 52800020     	mov	w0, #0x1                // =1
     be8: 17ffff95     	b	0xa3c <iq4_f3_executor_invoke_saved_on_native_01+0x118>
     bec: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		0000000000000bec:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x58
     bf0: 91000108     	add	x8, x8, #0x0
		0000000000000bf0:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x58
     bf4: 910043e0     	add	x0, sp, #0x10
     bf8: c8dffd09     	ldar	x9, [x8]
     bfc: 91002108     	add	x8, x8, #0x8
     c00: c8dffd08     	ldar	x8, [x8]
     c04: a90123e9     	stp	x9, x8, [sp, #0x10]
     c08: 94000000     	bl	0xc08 <iq4_f3_executor_invoke_saved_on_native_01+0x2e4>
		0000000000000c08:  R_AARCH64_CALL26	iq4_activity_valid_01
     c0c: 34000060     	cbz	w0, 0xc18 <iq4_f3_executor_invoke_saved_on_native_01+0x2f4>
     c10: 94000000     	bl	0xc10 <iq4_f3_executor_invoke_saved_on_native_01+0x2ec>
		0000000000000c10:  R_AARCH64_CALL26	iq4_f3_executor_hold_01
     c14: 17ffffb3     	b	0xae0 <iq4_f3_executor_invoke_saved_on_native_01+0x1bc>
     c18: 6f00e400     	movi	v0.2d, #0000000000000000
     c1c: 910182a8     	add	x8, x21, #0x60
     c20: 910162a9     	add	x9, x21, #0x58
     c24: 3c8482a0     	stur	q0, [x21, #0x48]
     c28: 3c8382a0     	stur	q0, [x21, #0x38]
     c2c: c89ffd1f     	stlr	xzr, [x8]
     c30: 52800028     	mov	w8, #0x1                // =1
     c34: c89ffd3f     	stlr	xzr, [x9]
     c38: b9000ebf     	str	wzr, [x21, #0xc]
     c3c: 889ffea8     	stlr	w8, [x21]
     c40: 17ffff7f     	b	0xa3c <iq4_f3_executor_invoke_saved_on_native_01+0x118>

0000000000000c44 <iq4_f3_ifm_wait_entry_01>:
     c44: d10543ff     	sub	sp, sp, #0x150
     c48: a90f7bfd     	stp	x29, x30, [sp, #0xf0]
     c4c: a9106ffc     	stp	x28, x27, [sp, #0x100]
     c50: a91167fa     	stp	x26, x25, [sp, #0x110]
     c54: a9125ff8     	stp	x24, x23, [sp, #0x120]
     c58: a91357f6     	stp	x22, x21, [sp, #0x130]
     c5c: a9144ff4     	stp	x20, x19, [sp, #0x140]
     c60: 9103c3fd     	add	x29, sp, #0xf0
     c64: 2a0103f3     	mov	w19, w1
     c68: aa0003f4     	mov	x20, x0
     c6c: d10143b6     	sub	x22, x29, #0x50
     c70: 90000017     	adrp	x23, 0x0 <iq4_f3_executor_hold_01>
		0000000000000c70:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     c74: 910002f7     	add	x23, x23, #0x0
		0000000000000c74:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     c78: 34000d81     	cbz	w1, 0xe28 <iq4_f3_ifm_wait_entry_01+0x1e4>
     c7c: 2a1f03f5     	mov	w21, wzr
     c80: 90000019     	adrp	x25, 0x0 <iq4_f3_executor_hold_01>
		0000000000000c80:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x4
     c84: 91000339     	add	x25, x25, #0x0
		0000000000000c84:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x4
     c88: 9104c2fa     	add	x26, x23, #0x130
     c8c: 9000001b     	adrp	x27, 0x0 <iq4_f3_executor_hold_01>
		0000000000000c8c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x8
     c90: 9100037b     	add	x27, x27, #0x0
		0000000000000c90:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x8
     c94: 5280007c     	mov	w28, #0x3               // =3
     c98: 52800038     	mov	w24, #0x1               // =1
     c9c: 14000002     	b	0xca4 <iq4_f3_ifm_wait_entry_01+0x60>
     ca0: d5033f5f     	clrex
     ca4: aa1403e0     	mov	x0, x20
     ca8: 2a1303e1     	mov	w1, w19
     cac: 94000000     	bl	0xcac <iq4_f3_ifm_wait_entry_01+0x68>
		0000000000000cac:  R_AARCH64_CALL26	iq4_f3_original_ifm_wait_01
     cb0: eb1a001f     	cmp	x0, x26
     cb4: 1a9f17e8     	cset	w8, eq
     cb8: 0a0802a8     	and	w8, w21, w8
     cbc: 36000a68     	tbz	w8, #0x0, 0xe08 <iq4_f3_ifm_wait_entry_01+0x1c4>
     cc0: aa1403e0     	mov	x0, x20
     cc4: 94000101     	bl	0x10c8 <_ZL9on_workerm>
     cc8: 36000420     	tbz	w0, #0x0, 0xd4c <iq4_f3_ifm_wait_entry_01+0x108>
     ccc: 885ffee8     	ldaxr	w8, [x23]
     cd0: 7100091f     	cmp	w8, #0x2
     cd4: 54fffe61     	b.ne	0xca0 <iq4_f3_ifm_wait_entry_01+0x5c>
     cd8: 8808fefc     	stlxr	w8, w28, [x23]
     cdc: 35ffff88     	cbnz	w8, 0xccc <iq4_f3_ifm_wait_entry_01+0x88>
     ce0: 889fff38     	stlr	w24, [x25]
     ce4: f8434320     	ldur	x0, [x25, #0x34]
     ce8: f844c336     	ldur	x22, [x25, #0x4c]
     cec: f843c328     	ldur	x8, [x25, #0x3c]
     cf0: 91005321     	add	x1, x25, #0x14
     cf4: d63f0100     	blr	x8
     cf8: 7100041f     	cmp	w0, #0x1
     cfc: 54000428     	b.hi	0xd80 <iq4_f3_ifm_wait_entry_01+0x13c>
     d00: 88dfff68     	ldar	w8, [x27]
     d04: 350003e8     	cbnz	w8, 0xd80 <iq4_f3_ifm_wait_entry_01+0x13c>
     d08: 7100001f     	cmp	w0, #0x0
     d0c: 90000009     	adrp	x9, 0x0 <iq4_f3_executor_hold_01>
		0000000000000d0c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x68
     d10: 91000129     	add	x9, x9, #0x0
		0000000000000d10:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x68
     d14: 1a981708     	cinc	w8, w24, eq
     d18: 889ffd28     	stlr	w8, [x9]
     d1c: 885ffee8     	ldaxr	w8, [x23]
     d20: 71000d1f     	cmp	w8, #0x3
     d24: 540002c1     	b.ne	0xd7c <iq4_f3_ifm_wait_entry_01+0x138>
     d28: 52800089     	mov	w9, #0x4                // =4
     d2c: 8808fee9     	stlxr	w8, w9, [x23]
     d30: 35ffff68     	cbnz	w8, 0xd1c <iq4_f3_ifm_wait_entry_01+0xd8>
     d34: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		0000000000000d34:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0xc
     d38: b9400108     	ldr	w8, [x8]
		0000000000000d38:  R_AARCH64_LDST32_ABS_LO12_NC	.bss+0xc
     d3c: 34000408     	cbz	w8, 0xdbc <iq4_f3_ifm_wait_entry_01+0x178>
     d40: 889fff3f     	stlr	wzr, [x25]
     d44: d10143b6     	sub	x22, x29, #0x50
     d48: 17ffffd7     	b	0xca4 <iq4_f3_ifm_wait_entry_01+0x60>
     d4c: 889fff78     	stlr	w24, [x27]
     d50: 91014368     	add	x8, x27, #0x50
     d54: 91016369     	add	x9, x27, #0x58
     d58: c8dffd08     	ldar	x8, [x8]
     d5c: c8dffd29     	ldar	x9, [x9]
     d60: a90026c8     	stp	x8, x9, [x22]
     d64: b4000068     	cbz	x8, 0xd70 <iq4_f3_ifm_wait_entry_01+0x12c>
     d68: d10143a0     	sub	x0, x29, #0x50
     d6c: 94000000     	bl	0xd6c <iq4_f3_ifm_wait_entry_01+0x128>
		0000000000000d6c:  R_AARCH64_CALL26	iq4_activity_hold_01
     d70: 528000a8     	mov	w8, #0x5                // =5
     d74: 889ffee8     	stlr	w8, [x23]
     d78: 17ffffcb     	b	0xca4 <iq4_f3_ifm_wait_entry_01+0x60>
     d7c: d5033f5f     	clrex
     d80: 889fff78     	stlr	w24, [x27]
     d84: 91014368     	add	x8, x27, #0x50
     d88: 91016369     	add	x9, x27, #0x58
     d8c: c8dffd08     	ldar	x8, [x8]
     d90: c8dffd29     	ldar	x9, [x9]
     d94: d10143b6     	sub	x22, x29, #0x50
     d98: a90026c8     	stp	x8, x9, [x22]
     d9c: b4000068     	cbz	x8, 0xda8 <iq4_f3_ifm_wait_entry_01+0x164>
     da0: d10143a0     	sub	x0, x29, #0x50
     da4: 94000000     	bl	0xda4 <iq4_f3_ifm_wait_entry_01+0x160>
		0000000000000da4:  R_AARCH64_CALL26	iq4_activity_hold_01
     da8: 528000a8     	mov	w8, #0x5                // =5
     dac: 889ffee8     	stlr	w8, [x23]
     db0: 910012e8     	add	x8, x23, #0x4
     db4: 889ffd1f     	stlr	wzr, [x8]
     db8: 17ffffbb     	b	0xca4 <iq4_f3_ifm_wait_entry_01+0x60>
     dbc: aa1603e0     	mov	x0, x22
     dc0: 94000000     	bl	0xdc0 <iq4_f3_ifm_wait_entry_01+0x17c>
		0000000000000dc0:  R_AARCH64_CALL26	f3_executor_event_notify_01
     dc4: 34fffde0     	cbz	w0, 0xd80 <iq4_f3_ifm_wait_entry_01+0x13c>
     dc8: 88dfff68     	ldar	w8, [x27]
     dcc: 35fffda8     	cbnz	w8, 0xd80 <iq4_f3_ifm_wait_entry_01+0x13c>
     dd0: 90000009     	adrp	x9, 0x0 <iq4_f3_executor_hold_01>
		0000000000000dd0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x58
     dd4: 91000129     	add	x9, x9, #0x0
		0000000000000dd4:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x58
     dd8: d10143aa     	sub	x10, x29, #0x50
     ddc: c8dffd28     	ldar	x8, [x9]
     de0: 91002129     	add	x9, x9, #0x8
     de4: d10143a0     	sub	x0, x29, #0x50
     de8: c8dffd29     	ldar	x9, [x9]
     dec: a9002548     	stp	x8, x9, [x10]
     df0: 94000000     	bl	0xdf0 <iq4_f3_ifm_wait_entry_01+0x1ac>
		0000000000000df0:  R_AARCH64_CALL26	iq4_activity_release_01
     df4: 35fffc60     	cbnz	w0, 0xd80 <iq4_f3_ifm_wait_entry_01+0x13c>
     df8: 17ffffd2     	b	0xd40 <iq4_f3_ifm_wait_entry_01+0xfc>
     dfc: 94000000     	bl	0xdfc <iq4_f3_ifm_wait_entry_01+0x1b8>
		0000000000000dfc:  R_AARCH64_CALL26	__cxa_begin_catch
     e00: 94000000     	bl	0xe00 <iq4_f3_ifm_wait_entry_01+0x1bc>
		0000000000000e00:  R_AARCH64_CALL26	__cxa_end_catch
     e04: 17ffffdf     	b	0xd80 <iq4_f3_ifm_wait_entry_01+0x13c>
     e08: a9544ff4     	ldp	x20, x19, [sp, #0x140]
     e0c: a95357f6     	ldp	x22, x21, [sp, #0x130]
     e10: a9525ff8     	ldp	x24, x23, [sp, #0x120]
     e14: a95167fa     	ldp	x26, x25, [sp, #0x110]
     e18: a9506ffc     	ldp	x28, x27, [sp, #0x100]
     e1c: a94f7bfd     	ldp	x29, x30, [sp, #0xf0]
     e20: 910543ff     	add	sp, sp, #0x150
     e24: d65f03c0     	ret
     e28: 88dffee8     	ldar	w8, [x23]
     e2c: 34000128     	cbz	w8, 0xe50 <iq4_f3_ifm_wait_entry_01+0x20c>
     e30: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		0000000000000e30:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x18
     e34: f9400108     	ldr	x8, [x8]
		0000000000000e34:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x18
     e38: eb14011f     	cmp	x8, x20
     e3c: 54fff201     	b.ne	0xc7c <iq4_f3_ifm_wait_entry_01+0x38>
     e40: aa1403e0     	mov	x0, x20
     e44: 940000a1     	bl	0x10c8 <_ZL9on_workerm>
     e48: 2a0003f5     	mov	w21, w0
     e4c: 17ffff8d     	b	0xc80 <iq4_f3_ifm_wait_entry_01+0x3c>
     e50: 6f00e400     	movi	v0.2d, #0000000000000000
     e54: f9002fff     	str	xzr, [sp, #0x58]
     e58: 90000018     	adrp	x24, 0x0 <iq4_f3_executor_hold_01>
		0000000000000e58:  R_AARCH64_ADR_PREL_PG_HI21	.data.rel.ro+0x10
     e5c: 91000318     	add	x24, x24, #0x0
		0000000000000e5c:  R_AARCH64_ADD_ABS_LO12_NC	.data.rel.ro+0x10
     e60: 52802a19     	mov	w25, #0x150             // =336
     e64: ad0083e0     	stp	q0, q0, [sp, #0x10]
     e68: ad0183e0     	stp	q0, q0, [sp, #0x30]
     e6c: f85f8315     	ldur	x21, [x24, #-0x8]
     e70: f10102bf     	cmp	x21, #0x40
     e74: 54fff048     	b.hi	0xc7c <iq4_f3_ifm_wait_entry_01+0x38>
     e78: f85f0316     	ldur	x22, [x24, #-0x10]
     e7c: ab1602bf     	cmn	x21, x22
     e80: 54000f22     	b.hs	0x1064 <iq4_f3_ifm_wait_entry_01+0x420>
     e84: b4000f15     	cbz	x21, 0x1064 <iq4_f3_ifm_wait_entry_01+0x420>
     e88: f14006df     	cmp	x22, #0x1, lsl #12      // =0x1000
     e8c: 54000ec3     	b.lo	0x1064 <iq4_f3_ifm_wait_entry_01+0x420>
     e90: 910183e1     	add	x1, sp, #0x60
     e94: aa1603e0     	mov	x0, x22
     e98: aa1503e2     	mov	x2, x21
     e9c: 94000000     	bl	0xe9c <iq4_f3_ifm_wait_entry_01+0x258>
		0000000000000e9c:  R_AARCH64_CALL26	f3_executor_read_01
     ea0: 7100041f     	cmp	w0, #0x1
     ea4: 54000e01     	b.ne	0x1064 <iq4_f3_ifm_wait_entry_01+0x420>
     ea8: d10143a1     	sub	x1, x29, #0x50
     eac: aa1603e0     	mov	x0, x22
     eb0: aa1503e2     	mov	x2, x21
     eb4: 94000000     	bl	0xeb4 <iq4_f3_ifm_wait_entry_01+0x270>
		0000000000000eb4:  R_AARCH64_CALL26	f3_executor_read_01
     eb8: 7100041f     	cmp	w0, #0x1
     ebc: 54000d41     	b.ne	0x1064 <iq4_f3_ifm_wait_entry_01+0x420>
     ec0: 910183e0     	add	x0, sp, #0x60
     ec4: d10143a1     	sub	x1, x29, #0x50
     ec8: aa1503e2     	mov	x2, x21
     ecc: 94000000     	bl	0xecc <iq4_f3_ifm_wait_entry_01+0x288>
		0000000000000ecc:  R_AARCH64_CALL26	memcmp
     ed0: d10143b6     	sub	x22, x29, #0x50
     ed4: 35ffed40     	cbnz	w0, 0xc7c <iq4_f3_ifm_wait_entry_01+0x38>
     ed8: f9400301     	ldr	x1, [x24]
     edc: 910183e0     	add	x0, sp, #0x60
     ee0: aa1503e2     	mov	x2, x21
     ee4: 94000000     	bl	0xee4 <iq4_f3_ifm_wait_entry_01+0x2a0>
		0000000000000ee4:  R_AARCH64_CALL26	memcmp
     ee8: 35ffeca0     	cbnz	w0, 0xc7c <iq4_f3_ifm_wait_entry_01+0x38>
     eec: f1006339     	subs	x25, x25, #0x18
     ef0: 91006318     	add	x24, x24, #0x18
     ef4: 54fffbc1     	b.ne	0xe6c <iq4_f3_ifm_wait_entry_01+0x228>
     ef8: 910163e0     	add	x0, sp, #0x58
     efc: 94000000     	bl	0xefc <iq4_f3_ifm_wait_entry_01+0x2b8>
		0000000000000efc:  R_AARCH64_CALL26	f3_executor_current_01
     f00: 34ffebe0     	cbz	w0, 0xc7c <iq4_f3_ifm_wait_entry_01+0x38>
     f04: f9402fe8     	ldr	x8, [sp, #0x58]
     f08: eb14011f     	cmp	x8, x20
     f0c: 54ffeb81     	b.ne	0xc7c <iq4_f3_ifm_wait_entry_01+0x38>
     f10: 9100c3e1     	add	x1, sp, #0x30
     f14: aa1403e0     	mov	x0, x20
     f18: 94000097     	bl	0x1174 <_ZL7inspectmR17F3ExecutorOwner01>
     f1c: 3607eb00     	tbz	w0, #0x0, 0xc7c <iq4_f3_ifm_wait_entry_01+0x38>
     f20: 910043e1     	add	x1, sp, #0x10
     f24: aa1403e0     	mov	x0, x20
     f28: 94000093     	bl	0x1174 <_ZL7inspectmR17F3ExecutorOwner01>
     f2c: 3607ea80     	tbz	w0, #0x0, 0xc7c <iq4_f3_ifm_wait_entry_01+0x38>
     f30: 9100c3e0     	add	x0, sp, #0x30
     f34: 910043e1     	add	x1, sp, #0x10
     f38: 52800402     	mov	w2, #0x20               // =32
     f3c: 94000000     	bl	0xf3c <iq4_f3_ifm_wait_entry_01+0x2f8>
		0000000000000f3c:  R_AARCH64_CALL26	memcmp
     f40: 35ffe9e0     	cbnz	w0, 0xc7c <iq4_f3_ifm_wait_entry_01+0x38>
     f44: ad4187e0     	ldp	q0, q1, [sp, #0x30]
     f48: 90000008     	adrp	x8, 0x0 <iq4_f3_executor_hold_01>
		0000000000000f48:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x18
     f4c: 91000108     	add	x8, x8, #0x0
		0000000000000f4c:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x18
     f50: 91016100     	add	x0, x8, #0x58
     f54: ad000500     	stp	q0, q1, [x8]
     f58: 94000000     	bl	0xf58 <iq4_f3_ifm_wait_entry_01+0x314>
		0000000000000f58:  R_AARCH64_CALL26	f3_executor_event_ctor_01
     f5c: 34000880     	cbz	w0, 0x106c <iq4_f3_ifm_wait_entry_01+0x428>
     f60: 90000001     	adrp	x1, 0x0 <iq4_f3_executor_hold_01>
		0000000000000f60:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x70
     f64: 91000021     	add	x1, x1, #0x0
		0000000000000f64:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x70
     f68: aa1403e2     	mov	x2, x20
     f6c: 91030020     	add	x0, x1, #0xc0
     f70: 94000000     	bl	0xf70 <iq4_f3_ifm_wait_entry_01+0x32c>
		0000000000000f70:  R_AARCH64_CALL26	f3_executor_listener_ctor_01
     f74: 340007c0     	cbz	w0, 0x106c <iq4_f3_ifm_wait_entry_01+0x428>
     f78: 90000015     	adrp	x21, 0x0 <iq4_f3_executor_hold_01>
		0000000000000f78:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x70
     f7c: 910002b5     	add	x21, x21, #0x0
		0000000000000f7c:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x70
     f80: 52801fe8     	mov	w8, #0xff               // =255
     f84: d10143a1     	sub	x1, x29, #0x50
     f88: aa1503e0     	mov	x0, x21
     f8c: d10143b8     	sub	x24, x29, #0x50
     f90: f90002df     	str	xzr, [x22]
     f94: f90033ff     	str	xzr, [sp, #0x60]
     f98: f90007ff     	str	xzr, [sp, #0x8]
     f9c: 390013e8     	strb	w8, [sp, #0x4]
     fa0: 97fffd24     	bl	0x430 <_ZL4wordmRm>
     fa4: 36000680     	tbz	w0, #0x0, 0x1074 <iq4_f3_ifm_wait_entry_01+0x430>
     fa8: f9400308     	ldr	x8, [x24]
     fac: 5286f416     	mov	w22, #0x37a0            // =14240
     fb0: 72a01856     	movk	w22, #0xc2, lsl #16
     fb4: eb16011f     	cmp	x8, x22
     fb8: 540005e1     	b.ne	0x1074 <iq4_f3_ifm_wait_entry_01+0x430>
     fbc: 90000000     	adrp	x0, 0x0 <iq4_f3_executor_hold_01>
		0000000000000fbc:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x130
     fc0: 91000000     	add	x0, x0, #0x0
		0000000000000fc0:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x130
     fc4: d10143a1     	sub	x1, x29, #0x50
     fc8: 97fffd1a     	bl	0x430 <_ZL4wordmRm>
     fcc: 36000540     	tbz	w0, #0x0, 0x1074 <iq4_f3_ifm_wait_entry_01+0x430>
     fd0: f9400308     	ldr	x8, [x24]
     fd4: 9113c2c9     	add	x9, x22, #0x4f0
     fd8: eb09011f     	cmp	x8, x9
     fdc: 540004c1     	b.ne	0x1074 <iq4_f3_ifm_wait_entry_01+0x430>
     fe0: 90000000     	adrp	x0, 0x0 <iq4_f3_executor_hold_01>
		0000000000000fe0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x138
     fe4: 91000000     	add	x0, x0, #0x0
		0000000000000fe4:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x138
     fe8: 910183e1     	add	x1, sp, #0x60
     fec: 97fffd11     	bl	0x430 <_ZL4wordmRm>
     ff0: 36000420     	tbz	w0, #0x0, 0x1074 <iq4_f3_ifm_wait_entry_01+0x430>
     ff4: f94033e8     	ldr	x8, [sp, #0x60]
     ff8: eb15011f     	cmp	x8, x21
     ffc: 540003c1     	b.ne	0x1074 <iq4_f3_ifm_wait_entry_01+0x430>
    1000: 90000000     	adrp	x0, 0x1000 <iq4_f3_ifm_wait_entry_01+0x3bc>
		0000000000001000:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x160
    1004: 91000000     	add	x0, x0, #0x0
		0000000000001004:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x160
    1008: 910023e1     	add	x1, sp, #0x8
    100c: 97fffd09     	bl	0x430 <_ZL4wordmRm>
    1010: 36000320     	tbz	w0, #0x0, 0x1074 <iq4_f3_ifm_wait_entry_01+0x430>
    1014: f94007e8     	ldr	x8, [sp, #0x8]
    1018: eb14011f     	cmp	x8, x20
    101c: 540002c1     	b.ne	0x1074 <iq4_f3_ifm_wait_entry_01+0x430>
    1020: 90000008     	adrp	x8, 0x1000 <iq4_f3_ifm_wait_entry_01+0x3bc>
		0000000000001020:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x168
    1024: 91000108     	add	x8, x8, #0x0
		0000000000001024:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x168
    1028: f140051f     	cmp	x8, #0x1, lsl #12       // =0x1000
    102c: 54000243     	b.lo	0x1074 <iq4_f3_ifm_wait_entry_01+0x430>
    1030: 90000000     	adrp	x0, 0x1000 <iq4_f3_ifm_wait_entry_01+0x3bc>
		0000000000001030:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x168
    1034: 91000000     	add	x0, x0, #0x0
		0000000000001034:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x168
    1038: 910013e1     	add	x1, sp, #0x4
    103c: 52800022     	mov	w2, #0x1                // =1
    1040: 94000000     	bl	0x1040 <iq4_f3_ifm_wait_entry_01+0x3fc>
		0000000000001040:  R_AARCH64_CALL26	f3_executor_read_01
    1044: 7100041f     	cmp	w0, #0x1
    1048: 54000161     	b.ne	0x1074 <iq4_f3_ifm_wait_entry_01+0x430>
    104c: 394013e8     	ldrb	w8, [sp, #0x4]
    1050: 35000128     	cbnz	w8, 0x1074 <iq4_f3_ifm_wait_entry_01+0x430>
    1054: 52800028     	mov	w8, #0x1                // =1
    1058: d10143b6     	sub	x22, x29, #0x50
    105c: 889ffee8     	stlr	w8, [x23]
    1060: 17ffff78     	b	0xe40 <iq4_f3_ifm_wait_entry_01+0x1fc>
    1064: d10143b6     	sub	x22, x29, #0x50
    1068: 17ffff05     	b	0xc7c <iq4_f3_ifm_wait_entry_01+0x38>
    106c: 94000000     	bl	0x106c <iq4_f3_ifm_wait_entry_01+0x428>
		000000000000106c:  R_AARCH64_CALL26	iq4_f3_executor_hold_01
    1070: 17ffff03     	b	0xc7c <iq4_f3_ifm_wait_entry_01+0x38>
    1074: 94000000     	bl	0x1074 <iq4_f3_ifm_wait_entry_01+0x430>
		0000000000001074:  R_AARCH64_CALL26	iq4_f3_executor_hold_01
    1078: 2a1f03f5     	mov	w21, wzr
    107c: d10143b6     	sub	x22, x29, #0x50
    1080: 17ffff00     	b	0xc80 <iq4_f3_ifm_wait_entry_01+0x3c>
    1084: 94000000     	bl	0x1084 <iq4_f3_ifm_wait_entry_01+0x440>
		0000000000001084:  R_AARCH64_CALL26	__cxa_begin_catch
    1088: 88dffee8     	ldar	w8, [x23]
    108c: 36000135     	tbz	w21, #0x0, 0x10b0 <iq4_f3_ifm_wait_entry_01+0x46c>
    1090: 7100191f     	cmp	w8, #0x6
    1094: 540000e8     	b.hi	0x10b0 <iq4_f3_ifm_wait_entry_01+0x46c>
    1098: 52800029     	mov	w9, #0x1                // =1
    109c: 1ac82128     	lsl	w8, w9, w8
    10a0: 52800989     	mov	w9, #0x4c               // =76
    10a4: 6a09011f     	tst	w8, w9
    10a8: 54000040     	b.eq	0x10b0 <iq4_f3_ifm_wait_entry_01+0x46c>
    10ac: 94000000     	bl	0x10ac <iq4_f3_ifm_wait_entry_01+0x468>
		00000000000010ac:  R_AARCH64_CALL26	iq4_f3_executor_hold_01
    10b0: 94000000     	bl	0x10b0 <iq4_f3_ifm_wait_entry_01+0x46c>
		00000000000010b0:  R_AARCH64_CALL26	__cxa_rethrow
    10b4: aa0003f3     	mov	x19, x0
    10b8: 94000000     	bl	0x10b8 <iq4_f3_ifm_wait_entry_01+0x474>
		00000000000010b8:  R_AARCH64_CALL26	__cxa_end_catch
    10bc: aa1303e0     	mov	x0, x19
    10c0: 94000000     	bl	0x10c0 <iq4_f3_ifm_wait_entry_01+0x47c>
		00000000000010c0:  R_AARCH64_CALL26	_Unwind_Resume
    10c4: 94000000     	bl	0x10c4 <iq4_f3_ifm_wait_entry_01+0x480>
		00000000000010c4:  R_AARCH64_CALL26	__clang_call_terminate

00000000000010c8 <_ZL9on_workerm>:
    10c8: d10183ff     	sub	sp, sp, #0x60
    10cc: a9047bfd     	stp	x29, x30, [sp, #0x40]
    10d0: f9002bf3     	str	x19, [sp, #0x50]
    10d4: 910103fd     	add	x29, sp, #0x40
    10d8: 6f00e400     	movi	v0.2d, #0000000000000000
    10dc: aa0003f3     	mov	x19, x0
    10e0: 910063a0     	add	x0, x29, #0x18
    10e4: f9000fbf     	str	xzr, [x29, #0x18]
    10e8: ad0003e0     	stp	q0, q0, [sp]
    10ec: ad0103e0     	stp	q0, q0, [sp, #0x20]
    10f0: 94000000     	bl	0x10f0 <_ZL9on_workerm+0x28>
		00000000000010f0:  R_AARCH64_CALL26	f3_executor_current_01
    10f4: 2a0003e8     	mov	w8, w0
    10f8: 2a1f03e0     	mov	w0, wzr
    10fc: 34000248     	cbz	w8, 0x1144 <_ZL9on_workerm+0x7c>
    1100: f9400fa8     	ldr	x8, [x29, #0x18]
    1104: eb13011f     	cmp	x8, x19
    1108: 540001e1     	b.ne	0x1144 <_ZL9on_workerm+0x7c>
    110c: 910083e1     	add	x1, sp, #0x20
    1110: aa1303e0     	mov	x0, x19
    1114: 94000018     	bl	0x1174 <_ZL7inspectmR17F3ExecutorOwner01>
    1118: 36000140     	tbz	w0, #0x0, 0x1140 <_ZL9on_workerm+0x78>
    111c: 910003e1     	mov	x1, sp
    1120: aa1303e0     	mov	x0, x19
    1124: 94000014     	bl	0x1174 <_ZL7inspectmR17F3ExecutorOwner01>
    1128: 360000c0     	tbz	w0, #0x0, 0x1140 <_ZL9on_workerm+0x78>
    112c: 910083e0     	add	x0, sp, #0x20
    1130: 910003e1     	mov	x1, sp
    1134: 52800402     	mov	w2, #0x20               // =32
    1138: 94000000     	bl	0x1138 <_ZL9on_workerm+0x70>
		0000000000001138:  R_AARCH64_CALL26	memcmp
    113c: 340000c0     	cbz	w0, 0x1154 <_ZL9on_workerm+0x8c>
    1140: 2a1f03e0     	mov	w0, wzr
    1144: a9447bfd     	ldp	x29, x30, [sp, #0x40]
    1148: f9402bf3     	ldr	x19, [sp, #0x50]
    114c: 910183ff     	add	sp, sp, #0x60
    1150: d65f03c0     	ret
    1154: 90000001     	adrp	x1, 0x1000 <iq4_f3_ifm_wait_entry_01+0x3bc>
		0000000000001154:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x18
    1158: 91000021     	add	x1, x1, #0x0
		0000000000001158:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x18
    115c: 910083e0     	add	x0, sp, #0x20
    1160: 52800402     	mov	w2, #0x20               // =32
    1164: 94000000     	bl	0x1164 <_ZL9on_workerm+0x9c>
		0000000000001164:  R_AARCH64_CALL26	memcmp
    1168: 7100001f     	cmp	w0, #0x0
    116c: 1a9f17e0     	cset	w0, eq
    1170: 17fffff5     	b	0x1144 <_ZL9on_workerm+0x7c>

0000000000001174 <_ZL7inspectmR17F3ExecutorOwner01>:
    1174: d10243ff     	sub	sp, sp, #0x90
    1178: a9067bfd     	stp	x29, x30, [sp, #0x60]
    117c: a90757f6     	stp	x22, x21, [sp, #0x70]
    1180: a9084ff4     	stp	x20, x19, [sp, #0x80]
    1184: 910183fd     	add	x29, sp, #0x60
    1188: aa0003f3     	mov	x19, x0
    118c: 92840029     	mov	x9, #-0x2002            // =-8194
    1190: 2a1f03e0     	mov	w0, wzr
    1194: d1400668     	sub	x8, x19, #0x1, lsl #12  // =0x1000
    1198: a9017fff     	stp	xzr, xzr, [sp, #0x10]
    119c: eb09011f     	cmp	x8, x9
    11a0: a9007fff     	stp	xzr, xzr, [sp]
    11a4: 540005a8     	b.hi	0x1258 <_ZL7inspectmR17F3ExecutorOwner01+0xe4>
    11a8: 92400a68     	and	x8, x19, #0x7
    11ac: b5000568     	cbnz	x8, 0x1258 <_ZL7inspectmR17F3ExecutorOwner01+0xe4>
    11b0: aa0103f5     	mov	x21, x1
    11b4: 910063e1     	add	x1, sp, #0x18
    11b8: aa1303e0     	mov	x0, x19
    11bc: 52800102     	mov	w2, #0x8                // =8
    11c0: 94000000     	bl	0x11c0 <_ZL7inspectmR17F3ExecutorOwner01+0x4c>
		00000000000011c0:  R_AARCH64_CALL26	f3_executor_read_01
    11c4: 7100041f     	cmp	w0, #0x1
    11c8: 54000461     	b.ne	0x1254 <_ZL7inspectmR17F3ExecutorOwner01+0xe0>
    11cc: 910083e1     	add	x1, sp, #0x20
    11d0: aa1303e0     	mov	x0, x19
    11d4: 52800102     	mov	w2, #0x8                // =8
    11d8: 94000000     	bl	0x11d8 <_ZL7inspectmR17F3ExecutorOwner01+0x64>
		00000000000011d8:  R_AARCH64_CALL26	f3_executor_read_01
    11dc: 7100041f     	cmp	w0, #0x1
    11e0: 540003a1     	b.ne	0x1254 <_ZL7inspectmR17F3ExecutorOwner01+0xe0>
    11e4: 910063e0     	add	x0, sp, #0x18
    11e8: 910083e1     	add	x1, sp, #0x20
    11ec: 52800102     	mov	w2, #0x8                // =8
    11f0: 94000000     	bl	0x11f0 <_ZL7inspectmR17F3ExecutorOwner01+0x7c>
		00000000000011f0:  R_AARCH64_CALL26	memcmp
    11f4: 2a0003e8     	mov	w8, w0
    11f8: 2a1f03e0     	mov	w0, wzr
    11fc: 350002e8     	cbnz	w8, 0x1258 <_ZL7inspectmR17F3ExecutorOwner01+0xe4>
    1200: f9400fe8     	ldr	x8, [sp, #0x18]
    1204: d16e0108     	sub	x8, x8, #0xb80, lsl #12 // =0xb80000
    1208: f117011f     	cmp	x8, #0x5c0
    120c: 54000261     	b.ne	0x1258 <_ZL7inspectmR17F3ExecutorOwner01+0xe4>
    1210: 9106a260     	add	x0, x19, #0x1a8
    1214: 910043e1     	add	x1, sp, #0x10
    1218: 52800102     	mov	w2, #0x8                // =8
    121c: 94000000     	bl	0x121c <_ZL7inspectmR17F3ExecutorOwner01+0xa8>
		000000000000121c:  R_AARCH64_CALL26	f3_executor_read_01
    1220: 7100041f     	cmp	w0, #0x1
    1224: 54000181     	b.ne	0x1254 <_ZL7inspectmR17F3ExecutorOwner01+0xe0>
    1228: 9106a260     	add	x0, x19, #0x1a8
    122c: 910083e1     	add	x1, sp, #0x20
    1230: 52800102     	mov	w2, #0x8                // =8
    1234: 94000000     	bl	0x1234 <_ZL7inspectmR17F3ExecutorOwner01+0xc0>
		0000000000001234:  R_AARCH64_CALL26	f3_executor_read_01
    1238: 7100041f     	cmp	w0, #0x1
    123c: 540000c1     	b.ne	0x1254 <_ZL7inspectmR17F3ExecutorOwner01+0xe0>
    1240: 910043e0     	add	x0, sp, #0x10
    1244: 910083e1     	add	x1, sp, #0x20
    1248: 52800102     	mov	w2, #0x8                // =8
    124c: 94000000     	bl	0x124c <_ZL7inspectmR17F3ExecutorOwner01+0xd8>
		000000000000124c:  R_AARCH64_CALL26	memcmp
    1250: 340000e0     	cbz	w0, 0x126c <_ZL7inspectmR17F3ExecutorOwner01+0xf8>
    1254: 2a1f03e0     	mov	w0, wzr
    1258: a9484ff4     	ldp	x20, x19, [sp, #0x80]
    125c: a94757f6     	ldp	x22, x21, [sp, #0x70]
    1260: a9467bfd     	ldp	x29, x30, [sp, #0x60]
    1264: 910243ff     	add	sp, sp, #0x90
    1268: d65f03c0     	ret
    126c: f9400bf4     	ldr	x20, [sp, #0x10]
    1270: 92840029     	mov	x9, #-0x2002            // =-8194
    1274: d1400688     	sub	x8, x20, #0x1, lsl #12  // =0x1000
    1278: eb09011f     	cmp	x8, x9
    127c: 54fffee8     	b.hi	0x1258 <_ZL7inspectmR17F3ExecutorOwner01+0xe4>
    1280: 92400a88     	and	x8, x20, #0x7
    1284: b5fffea8     	cbnz	x8, 0x1258 <_ZL7inspectmR17F3ExecutorOwner01+0xe4>
    1288: 910063e1     	add	x1, sp, #0x18
    128c: aa1403e0     	mov	x0, x20
    1290: 52800102     	mov	w2, #0x8                // =8
    1294: 94000000     	bl	0x1294 <_ZL7inspectmR17F3ExecutorOwner01+0x120>
		0000000000001294:  R_AARCH64_CALL26	f3_executor_read_01
    1298: 7100041f     	cmp	w0, #0x1
    129c: 54fffdc1     	b.ne	0x1254 <_ZL7inspectmR17F3ExecutorOwner01+0xe0>
    12a0: 910083e1     	add	x1, sp, #0x20
    12a4: aa1403e0     	mov	x0, x20
    12a8: 52800102     	mov	w2, #0x8                // =8
    12ac: 94000000     	bl	0x12ac <_ZL7inspectmR17F3ExecutorOwner01+0x138>
		00000000000012ac:  R_AARCH64_CALL26	f3_executor_read_01
    12b0: 7100041f     	cmp	w0, #0x1
    12b4: 54fffd01     	b.ne	0x1254 <_ZL7inspectmR17F3ExecutorOwner01+0xe0>
    12b8: 910063e0     	add	x0, sp, #0x18
    12bc: 910083e1     	add	x1, sp, #0x20
    12c0: 52800102     	mov	w2, #0x8                // =8
    12c4: 94000000     	bl	0x12c4 <_ZL7inspectmR17F3ExecutorOwner01+0x150>
		00000000000012c4:  R_AARCH64_CALL26	memcmp
    12c8: 2a0003e8     	mov	w8, w0
    12cc: 2a1f03e0     	mov	w0, wzr
    12d0: 35fffc48     	cbnz	w8, 0x1258 <_ZL7inspectmR17F3ExecutorOwner01+0xe4>
    12d4: 529d9c14     	mov	w20, #0xece0            // =60640
    12d8: f9400fe8     	ldr	x8, [sp, #0x18]
    12dc: 72a016f4     	movk	w20, #0xb7, lsl #16
    12e0: 91320289     	add	x9, x20, #0xc80
    12e4: eb09011f     	cmp	x8, x9
    12e8: 54fffb81     	b.ne	0x1258 <_ZL7inspectmR17F3ExecutorOwner01+0xe4>
    12ec: f9400bf6     	ldr	x22, [sp, #0x10]
    12f0: 913ec2c8     	add	x8, x22, #0xfb0
    12f4: d343fd08     	lsr	x8, x8, #3
    12f8: f108051f     	cmp	x8, #0x201
    12fc: 54fffac3     	b.lo	0x1254 <_ZL7inspectmR17F3ExecutorOwner01+0xe0>
    1300: 913ea2c0     	add	x0, x22, #0xfa8
    1304: 910023e1     	add	x1, sp, #0x8
    1308: 52800102     	mov	w2, #0x8                // =8
    130c: 94000000     	bl	0x130c <_ZL7inspectmR17F3ExecutorOwner01+0x198>
		000000000000130c:  R_AARCH64_CALL26	f3_executor_read_01
    1310: 7100041f     	cmp	w0, #0x1
    1314: 54fffa01     	b.ne	0x1254 <_ZL7inspectmR17F3ExecutorOwner01+0xe0>
    1318: 913ea2c0     	add	x0, x22, #0xfa8
    131c: 910083e1     	add	x1, sp, #0x20
    1320: 52800102     	mov	w2, #0x8                // =8
    1324: 94000000     	bl	0x1324 <_ZL7inspectmR17F3ExecutorOwner01+0x1b0>
		0000000000001324:  R_AARCH64_CALL26	f3_executor_read_01
    1328: 7100041f     	cmp	w0, #0x1
    132c: 54fff941     	b.ne	0x1254 <_ZL7inspectmR17F3ExecutorOwner01+0xe0>
    1330: 910023e0     	add	x0, sp, #0x8
    1334: 910083e1     	add	x1, sp, #0x20
    1338: 52800102     	mov	w2, #0x8                // =8
    133c: 94000000     	bl	0x133c <_ZL7inspectmR17F3ExecutorOwner01+0x1c8>
		000000000000133c:  R_AARCH64_CALL26	memcmp
    1340: 35fff8a0     	cbnz	w0, 0x1254 <_ZL7inspectmR17F3ExecutorOwner01+0xe0>
    1344: f94007e8     	ldr	x8, [sp, #0x8]
    1348: 9284002a     	mov	x10, #-0x2002           // =-8194
    134c: d1400509     	sub	x9, x8, #0x1, lsl #12   // =0x1000
    1350: eb0a013f     	cmp	x9, x10
    1354: 54fff828     	b.hi	0x1258 <_ZL7inspectmR17F3ExecutorOwner01+0xe4>
    1358: 92400909     	and	x9, x8, #0x7
    135c: b5fff7e9     	cbnz	x9, 0x1258 <_ZL7inspectmR17F3ExecutorOwner01+0xe4>
    1360: 910063e1     	add	x1, sp, #0x18
    1364: aa0803e0     	mov	x0, x8
    1368: 97fffc32     	bl	0x430 <_ZL4wordmRm>
    136c: 2a0003e8     	mov	w8, w0
    1370: 2a1f03e0     	mov	w0, wzr
    1374: 3607f728     	tbz	w8, #0x0, 0x1258 <_ZL7inspectmR17F3ExecutorOwner01+0xe4>
    1378: f9400fe8     	ldr	x8, [sp, #0x18]
    137c: eb14011f     	cmp	x8, x20
    1380: 54fff6c1     	b.ne	0x1258 <_ZL7inspectmR17F3ExecutorOwner01+0xe4>
    1384: f94007e8     	ldr	x8, [sp, #0x8]
    1388: 910003e1     	mov	x1, sp
    138c: 910ca100     	add	x0, x8, #0x328
    1390: 97fffc28     	bl	0x430 <_ZL4wordmRm>
    1394: 3607f600     	tbz	w0, #0x0, 0x1254 <_ZL7inspectmR17F3ExecutorOwner01+0xe0>
    1398: f94003e8     	ldr	x8, [sp]
    139c: f9400be9     	ldr	x9, [sp, #0x10]
    13a0: eb09011f     	cmp	x8, x9
    13a4: 54fff581     	b.ne	0x1254 <_ZL7inspectmR17F3ExecutorOwner01+0xe0>
    13a8: 94000000     	bl	0x13a8 <_ZL7inspectmR17F3ExecutorOwner01+0x234>
		00000000000013a8:  R_AARCH64_CALL26	f3_executor_tid_01
    13ac: b4fff560     	cbz	x0, 0x1258 <_ZL7inspectmR17F3ExecutorOwner01+0xe4>
    13b0: a940a7ea     	ldp	x10, x9, [sp, #0x8]
    13b4: aa0003e8     	mov	x8, x0
    13b8: 52800020     	mov	w0, #0x1                // =1
    13bc: a90026b3     	stp	x19, x9, [x21]
    13c0: a90122aa     	stp	x10, x8, [x21, #0x10]
    13c4: 17ffffa5     	b	0x1258 <_ZL7inspectmR17F3ExecutorOwner01+0xe4>

Disassembly of section .text.__clang_call_terminate:

0000000000000000 <__clang_call_terminate>:
       0: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
       4: 910003fd     	mov	x29, sp
       8: 94000000     	bl	0x8 <__clang_call_terminate+0x8>
		0000000000000008:  R_AARCH64_CALL26	__cxa_begin_catch
       c: 94000000     	bl	0xc <__clang_call_terminate+0xc>
		000000000000000c:  R_AARCH64_CALL26	_ZSt9terminatev
