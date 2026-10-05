
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f4_codec_cleanup_build_01/worker_1.o:	file format elf64-littleaarch64

Disassembly of section .text.iq4_f4_worker_init_02:

0000000000000000 <iq4_f4_worker_init_02>:
       0: aa0003e8     	mov	x8, x0
       4: 52800040     	mov	w0, #0x2                // =2
       8: b4000788     	cbz	x8, 0xf8 <iq4_f4_worker_init_02+0xf8>
       c: b4000761     	cbz	x1, 0xf8 <iq4_f4_worker_init_02+0xf8>
      10: b4000742     	cbz	x2, 0xf8 <iq4_f4_worker_init_02+0xf8>
      14: b4000726     	cbz	x6, 0xf8 <iq4_f4_worker_init_02+0xf8>
      18: 510004a9     	sub	w9, w5, #0x1
      1c: 71018d3f     	cmp	w9, #0x63
      20: 540006c8     	b.hi	0xf8 <iq4_f4_worker_init_02+0xf8>
      24: 51100089     	sub	w9, w4, #0x400
      28: 32163bea     	mov	w10, #0x1fffc00         // =33553408
      2c: 6b0a013f     	cmp	w9, w10
      30: 54000648     	b.hi	0xf8 <iq4_f4_worker_init_02+0xf8>
      34: b4000623     	cbz	x3, 0xf8 <iq4_f4_worker_init_02+0xf8>
      38: b9401849     	ldr	w9, [x2, #0x18]
      3c: 7100053f     	cmp	w9, #0x1
      40: 540005c1     	b.ne	0xf8 <iq4_f4_worker_init_02+0xf8>
      44: d10143ff     	sub	sp, sp, #0x50
      48: a9017bfd     	stp	x29, x30, [sp, #0x10]
      4c: a9025ff8     	stp	x24, x23, [sp, #0x20]
      50: a90357f6     	stp	x22, x21, [sp, #0x30]
      54: a9044ff4     	stp	x20, x19, [sp, #0x40]
      58: 910043fd     	add	x29, sp, #0x10
      5c: 6f00e400     	movi	v0.2d, #0000000000000000
      60: aa0103f7     	mov	x23, x1
      64: aa0203f6     	mov	x22, x2
      68: aa0303f5     	mov	x21, x3
      6c: aa0803f8     	mov	x24, x8
      70: 90000000     	adrp	x0, 0x0 <iq4_f4_worker_init_02>
		0000000000000070:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.source_sha
      74: 91000000     	add	x0, x0, #0x0
		0000000000000074:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.source_sha
      78: 90000001     	adrp	x1, 0x0 <iq4_f4_worker_init_02>
		0000000000000078:  R_AARCH64_ADR_PREL_PG_HI21	.text.read_jpeg
      7c: 91000021     	add	x1, x1, #0x0
		000000000000007c:  R_AARCH64_ADD_ABS_LO12_NC	.text.read_jpeg
      80: 910003e2     	mov	x2, sp
      84: 2a0403f4     	mov	w20, w4
      88: 2a0503f3     	mov	w19, w5
      8c: ad018100     	stp	q0, q0, [x8, #0x30]
      90: ad028100     	stp	q0, q0, [x8, #0x50]
      94: ad038100     	stp	q0, q0, [x8, #0x70]
      98: ad048100     	stp	q0, q0, [x8, #0x90]
      9c: 3d800900     	str	q0, [x8, #0x20]
      a0: 3d800100     	str	q0, [x8]
      a4: 3c810d00     	str	q0, [x8, #0x10]!
      a8: aa0803e3     	mov	x3, x8
      ac: a9001fe6     	stp	x6, x7, [sp]
      b0: 94000000     	bl	0xb0 <iq4_f4_worker_init_02+0xb0>
		00000000000000b0:  R_AARCH64_CALL26	iq4_native_jpeg82_bind_01
      b4: 34000060     	cbz	w0, 0xc0 <iq4_f4_worker_init_02+0xc0>
      b8: 52800040     	mov	w0, #0x2                // =2
      bc: 1400000a     	b	0xe4 <iq4_f4_worker_init_02+0xe4>
      c0: 94000000     	bl	0xc0 <iq4_f4_worker_init_02+0xc0>
		00000000000000c0:  R_AARCH64_CALL26	iq4_f4_native_tid_02
      c4: f9003f00     	str	x0, [x24, #0x78]
      c8: b4ffff80     	cbz	x0, 0xb8 <iq4_f4_worker_init_02+0xb8>
      cc: 2a1f03e0     	mov	w0, wzr
      d0: 52800028     	mov	w8, #0x1                // =1
      d4: a9005b17     	stp	x23, x22, [x24]
      d8: f9003715     	str	x21, [x24, #0x68]
      dc: 290e4f14     	stp	w20, w19, [x24, #0x70]
      e0: b900af08     	str	w8, [x24, #0xac]
      e4: a9444ff4     	ldp	x20, x19, [sp, #0x40]
      e8: a94357f6     	ldp	x22, x21, [sp, #0x30]
      ec: a9425ff8     	ldp	x24, x23, [sp, #0x20]
      f0: a9417bfd     	ldp	x29, x30, [sp, #0x10]
      f4: 910143ff     	add	sp, sp, #0x50
      f8: d65f03c0     	ret

Disassembly of section .text.read_jpeg:

0000000000000000 <read_jpeg>:
       0: a9402004     	ldp	x4, x8, [x0]
       4: aa0803e0     	mov	x0, x8
       8: d61f0080     	br	x4

Disassembly of section .text.iq4_f4_worker_pump_one_02:

0000000000000000 <iq4_f4_worker_pump_one_02>:
       0: b4000220     	cbz	x0, 0x44 <iq4_f4_worker_pump_one_02+0x44>
       4: d10643ff     	sub	sp, sp, #0x190
       8: a9167bfd     	stp	x29, x30, [sp, #0x160]
       c: f900bbfc     	str	x28, [sp, #0x170]
      10: a9184ff4     	stp	x20, x19, [sp, #0x180]
      14: 910583fd     	add	x29, sp, #0x160
      18: b940ac08     	ldr	w8, [x0, #0xac]
      1c: aa0003f3     	mov	x19, x0
      20: 340002c8     	cbz	w8, 0x78 <iq4_f4_worker_pump_one_02+0x78>
      24: 94000000     	bl	0x24 <iq4_f4_worker_pump_one_02+0x24>
		0000000000000024:  R_AARCH64_CALL26	iq4_f4_native_tid_02
      28: f9403e68     	ldr	x8, [x19, #0x78]
      2c: eb08001f     	cmp	x0, x8
      30: 54000241     	b.ne	0x78 <iq4_f4_worker_pump_one_02+0x78>
      34: b940aa68     	ldr	w8, [x19, #0xa8]
      38: 340000a8     	cbz	w8, 0x4c <iq4_f4_worker_pump_one_02+0x4c>
      3c: 528000a0     	mov	w0, #0x5                // =5
      40: 1400000f     	b	0x7c <iq4_f4_worker_pump_one_02+0x7c>
      44: 52800040     	mov	w0, #0x2                // =2
      48: d65f03c0     	ret
      4c: f9400260     	ldr	x0, [x19]
      50: d10143a1     	sub	x1, x29, #0x50
      54: 94000000     	bl	0x54 <iq4_f4_worker_pump_one_02+0x54>
		0000000000000054:  R_AARCH64_CALL26	iq4_f4_source_worker_claim_02
      58: 34000200     	cbz	w0, 0x98 <iq4_f4_worker_pump_one_02+0x98>
      5c: 71001c1f     	cmp	w0, #0x7
      60: 54000180     	b.eq	0x90 <iq4_f4_worker_pump_one_02+0x90>
      64: 7100141f     	cmp	w0, #0x5
      68: 54000081     	b.ne	0x78 <iq4_f4_worker_pump_one_02+0x78>
      6c: 52800028     	mov	w8, #0x1                // =1
      70: b900aa68     	str	w8, [x19, #0xa8]
      74: 14000002     	b	0x7c <iq4_f4_worker_pump_one_02+0x7c>
      78: 52800040     	mov	w0, #0x2                // =2
      7c: a9584ff4     	ldp	x20, x19, [sp, #0x180]
      80: f940bbfc     	ldr	x28, [sp, #0x170]
      84: a9567bfd     	ldp	x29, x30, [sp, #0x160]
      88: 910643ff     	add	sp, sp, #0x190
      8c: d65f03c0     	ret
      90: 52800020     	mov	w0, #0x1                // =1
      94: 17fffffa     	b	0x7c <iq4_f4_worker_pump_one_02+0x7c>
      98: f9400668     	ldr	x8, [x19, #0x8]
      9c: b85b83a9     	ldur	w9, [x29, #-0x48]
      a0: b9401d0a     	ldr	w10, [x8, #0x1c]
      a4: 6b0a013f     	cmp	w9, w10
      a8: 54000381     	b.ne	0x118 <iq4_f4_worker_pump_one_02+0x118>
      ac: b85bc3aa     	ldur	w10, [x29, #-0x44]
      b0: b9402108     	ldr	w8, [x8, #0x20]
      b4: 6b08015f     	cmp	w10, w8
      b8: 54000301     	b.ne	0x118 <iq4_f4_worker_pump_one_02+0x118>
      bc: b85c03ac     	ldur	w12, [x29, #-0x40]
      c0: 8b090528     	add	x8, x9, x9, lsl #1
      c4: eb0c011f     	cmp	x8, x12
      c8: 54000281     	b.ne	0x118 <iq4_f4_worker_pump_one_02+0x118>
      cc: 9baa7d88     	umull	x8, w12, w10
      d0: b85c43ad     	ldur	w13, [x29, #-0x3c]
      d4: eb0d011f     	cmp	x8, x13
      d8: 54000201     	b.ne	0x118 <iq4_f4_worker_pump_one_02+0x118>
      dc: f85f03a8     	ldur	x8, [x29, #-0x10]
      e0: b40001c8     	cbz	x8, 0x118 <iq4_f4_worker_pump_one_02+0x118>
      e4: b940a668     	ldr	w8, [x19, #0xa4]
      e8: b85c83b4     	ldur	w20, [x29, #-0x38]
      ec: 34000388     	cbz	w8, 0x15c <iq4_f4_worker_pump_one_02+0x15c>
      f0: b940a26e     	ldr	w14, [x19, #0xa0]
      f4: 52800048     	mov	w8, #0x2                // =2
      f8: 5280120b     	mov	w11, #0x90              // =144
      fc: 6b0e029f     	cmp	w20, w14
     100: 54000100     	b.eq	0x120 <iq4_f4_worker_pump_one_02+0x120>
     104: 4b0e028e     	sub	w14, w20, w14
     108: 37f800ce     	tbnz	w14, #0x1f, 0x120 <iq4_f4_worker_pump_one_02+0x120>
     10c: f9404e68     	ldr	x8, [x19, #0x98]
     110: ab0e011f     	cmn	x8, x14
     114: 54000223     	b.lo	0x158 <iq4_f4_worker_pump_one_02+0x158>
     118: 52800048     	mov	w8, #0x2                // =2
     11c: 5280120b     	mov	w11, #0x90              // =144
     120: f86b6a69     	ldr	x9, [x19, x11]
     124: f9400260     	ldr	x0, [x19]
     128: d10143a1     	sub	x1, x29, #0x50
     12c: 2a0803f4     	mov	w20, w8
     130: 91000529     	add	x9, x9, #0x1
     134: f82b6a69     	str	x9, [x19, x11]
     138: 94000000     	bl	0x138 <iq4_f4_worker_pump_one_02+0x138>
		0000000000000138:  R_AARCH64_CALL26	iq4_f4_source_worker_release_02
     13c: 2a0003e8     	mov	w8, w0
     140: 2a1403e0     	mov	w0, w20
     144: 34fff9c8     	cbz	w8, 0x7c <iq4_f4_worker_pump_one_02+0x7c>
     148: 52800028     	mov	w8, #0x1                // =1
     14c: 528000a0     	mov	w0, #0x5                // =5
     150: b900aa68     	str	w8, [x19, #0xa8]
     154: 17ffffca     	b	0x7c <iq4_f4_worker_pump_one_02+0x7c>
     158: 8b0e0114     	add	x20, x8, x14
     15c: f85b03a8     	ldur	x8, [x29, #-0x50]
     160: f9403662     	ldr	x2, [x19, #0x68]
     164: 91004260     	add	x0, x19, #0x10
     168: 910023e1     	add	x1, sp, #0x8
     16c: 9100c3e4     	add	x4, sp, #0x30
     170: 29032be9     	stp	w9, w10, [sp, #0x18]
     174: a900b7e8     	stp	x8, x13, [sp, #0x8]
     178: 294e2263     	ldp	w3, w8, [x19, #0x70]
     17c: f90013ec     	str	x12, [sp, #0x20]
     180: 29057fe8     	stp	w8, wzr, [sp, #0x28]
     184: 94000000     	bl	0x184 <iq4_f4_worker_pump_one_02+0x184>
		0000000000000184:  R_AARCH64_CALL26	iq4_jpeg_encode_bounded
     188: 7100181f     	cmp	w0, #0x6
     18c: 54000101     	b.ne	0x1ac <iq4_f4_worker_pump_one_02+0x1ac>
     190: f9404668     	ldr	x8, [x19, #0x88]
     194: 52800029     	mov	w9, #0x1                // =1
     198: 528000a0     	mov	w0, #0x5                // =5
     19c: b900aa69     	str	w9, [x19, #0xa8]
     1a0: 91000508     	add	x8, x8, #0x1
     1a4: f9004668     	str	x8, [x19, #0x88]
     1a8: 17ffffb5     	b	0x7c <iq4_f4_worker_pump_one_02+0x7c>
     1ac: 52800068     	mov	w8, #0x3                // =3
     1b0: 5280110b     	mov	w11, #0x88              // =136
     1b4: 35fffb60     	cbnz	w0, 0x120 <iq4_f4_worker_pump_one_02+0x120>
     1b8: f9401fe9     	ldr	x9, [sp, #0x38]
     1bc: b4fffb29     	cbz	x9, 0x120 <iq4_f4_worker_pump_one_02+0x120>
     1c0: b9407268     	ldr	w8, [x19, #0x70]
     1c4: eb08013f     	cmp	x9, x8
     1c8: 54000089     	b.ls	0x1d8 <iq4_f4_worker_pump_one_02+0x1d8>
     1cc: 52800068     	mov	w8, #0x3                // =3
     1d0: 5280110b     	mov	w11, #0x88              // =136
     1d4: 17ffffd3     	b	0x120 <iq4_f4_worker_pump_one_02+0x120>
     1d8: f9400260     	ldr	x0, [x19]
     1dc: d10143a1     	sub	x1, x29, #0x50
     1e0: 94000000     	bl	0x1e0 <iq4_f4_worker_pump_one_02+0x1e0>
		00000000000001e0:  R_AARCH64_CALL26	iq4_f4_source_worker_release_02
     1e4: 35fffb20     	cbnz	w0, 0x148 <iq4_f4_worker_pump_one_02+0x148>
     1e8: f9400660     	ldr	x0, [x19, #0x8]
     1ec: f9403661     	ldr	x1, [x19, #0x68]
     1f0: aa1403e4     	mov	x4, x20
     1f4: b9403be2     	ldr	w2, [sp, #0x38]
     1f8: f85f03a3     	ldur	x3, [x29, #-0x10]
     1fc: 94000000     	bl	0x1fc <iq4_f4_worker_pump_one_02+0x1fc>
		00000000000001fc:  R_AARCH64_CALL26	iq4_mkv_packet
     200: 34000140     	cbz	w0, 0x228 <iq4_f4_worker_pump_one_02+0x228>
     204: f9400668     	ldr	x8, [x19, #0x8]
     208: b9401908     	ldr	w8, [x8, #0x18]
     20c: 7100111f     	cmp	w8, #0x4
     210: 54fff9c0     	b.eq	0x148 <iq4_f4_worker_pump_one_02+0x148>
     214: b940aa68     	ldr	w8, [x19, #0xa8]
     218: 7100011f     	cmp	w8, #0x0
     21c: 52800088     	mov	w8, #0x4                // =4
     220: 1a880500     	cinc	w0, w8, ne
     224: 17ffff96     	b	0x7c <iq4_f4_worker_pump_one_02+0x7c>
     228: b85c83a9     	ldur	w9, [x29, #-0x38]
     22c: f940426a     	ldr	x10, [x19, #0x80]
     230: 52800028     	mov	w8, #0x1                // =1
     234: f9004e74     	str	x20, [x19, #0x98]
     238: 29142269     	stp	w9, w8, [x19, #0xa0]
     23c: 91000548     	add	x8, x10, #0x1
     240: f9004268     	str	x8, [x19, #0x80]
     244: 17ffff8e     	b	0x7c <iq4_f4_worker_pump_one_02+0x7c>

Disassembly of section .text.iq4_f4_worker_seal_02:

0000000000000000 <iq4_f4_worker_seal_02>:
       0: b4000260     	cbz	x0, 0x4c <iq4_f4_worker_seal_02+0x4c>
       4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
       8: f9000bf3     	str	x19, [sp, #0x10]
       c: 910003fd     	mov	x29, sp
      10: b940ac08     	ldr	w8, [x0, #0xac]
      14: aa0003f3     	mov	x19, x0
      18: 34000128     	cbz	w8, 0x3c <iq4_f4_worker_seal_02+0x3c>
      1c: 94000000     	bl	0x1c <iq4_f4_worker_seal_02+0x1c>
		000000000000001c:  R_AARCH64_CALL26	iq4_f4_native_tid_02
      20: f9403e68     	ldr	x8, [x19, #0x78]
      24: eb08001f     	cmp	x0, x8
      28: 540000a1     	b.ne	0x3c <iq4_f4_worker_seal_02+0x3c>
      2c: b940aa68     	ldr	w8, [x19, #0xa8]
      30: 34000128     	cbz	w8, 0x54 <iq4_f4_worker_seal_02+0x54>
      34: 528000a0     	mov	w0, #0x5                // =5
      38: 14000002     	b	0x40 <iq4_f4_worker_seal_02+0x40>
      3c: 52800040     	mov	w0, #0x2                // =2
      40: f9400bf3     	ldr	x19, [sp, #0x10]
      44: a8c27bfd     	ldp	x29, x30, [sp], #0x20
      48: d65f03c0     	ret
      4c: 52800040     	mov	w0, #0x2                // =2
      50: d65f03c0     	ret
      54: f9400260     	ldr	x0, [x19]
      58: 94000000     	bl	0x58 <iq4_f4_worker_seal_02+0x58>
		0000000000000058:  R_AARCH64_CALL26	iq4_f4_source_fence_02
      5c: 340000c0     	cbz	w0, 0x74 <iq4_f4_worker_seal_02+0x74>
      60: 7100141f     	cmp	w0, #0x5
      64: 540001e1     	b.ne	0xa0 <iq4_f4_worker_seal_02+0xa0>
      68: 52800028     	mov	w8, #0x1                // =1
      6c: b900aa68     	str	w8, [x19, #0xa8]
      70: 17fffff4     	b	0x40 <iq4_f4_worker_seal_02+0x40>
      74: f9400660     	ldr	x0, [x19, #0x8]
      78: 94000000     	bl	0x78 <iq4_f4_worker_seal_02+0x78>
		0000000000000078:  R_AARCH64_CALL26	iq4_mkv_seal
      7c: 34fffe20     	cbz	w0, 0x40 <iq4_f4_worker_seal_02+0x40>
      80: f9400668     	ldr	x8, [x19, #0x8]
      84: b9401908     	ldr	w8, [x8, #0x18]
      88: 7100111f     	cmp	w8, #0x4
      8c: 540000e1     	b.ne	0xa8 <iq4_f4_worker_seal_02+0xa8>
      90: 52800028     	mov	w8, #0x1                // =1
      94: 528000a0     	mov	w0, #0x5                // =5
      98: b900aa68     	str	w8, [x19, #0xa8]
      9c: 17ffffe9     	b	0x40 <iq4_f4_worker_seal_02+0x40>
      a0: 52800020     	mov	w0, #0x1                // =1
      a4: 17ffffe7     	b	0x40 <iq4_f4_worker_seal_02+0x40>
      a8: b940aa68     	ldr	w8, [x19, #0xa8]
      ac: 7100011f     	cmp	w8, #0x0
      b0: 52800088     	mov	w8, #0x4                // =4
      b4: 1a880500     	cinc	w0, w8, ne
      b8: 17ffffe2     	b	0x40 <iq4_f4_worker_seal_02+0x40>
