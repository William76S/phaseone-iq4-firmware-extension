
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f4_mkv_software_zero_build_01/native_mkv_1.o:	file format elf64-littleaarch64

Disassembly of section .text.iq4_mkv_begin:

0000000000000000 <iq4_mkv_begin>:
       0: d10743ff     	sub	sp, sp, #0x1d0
       4: a9197bfd     	stp	x29, x30, [sp, #0x190]
       8: a91a5ffc     	stp	x28, x23, [sp, #0x1a0]
       c: a91b57f6     	stp	x22, x21, [sp, #0x1b0]
      10: a91c4ff4     	stp	x20, x19, [sp, #0x1c0]
      14: 910643fd     	add	x29, sp, #0x190
      18: aa0003f3     	mov	x19, x0
      1c: 52800020     	mov	w0, #0x1                // =1
      20: b4000a73     	cbz	x19, 0x16c <iq4_mkv_begin+0x16c>
      24: b4000a41     	cbz	x1, 0x16c <iq4_mkv_begin+0x16c>
      28: f9400428     	ldr	x8, [x1, #0x8]
      2c: b4000a08     	cbz	x8, 0x16c <iq4_mkv_begin+0x16c>
      30: b2607fe8     	mov	x8, #-0x100000000       // =-4294967296
      34: 929dffe9     	mov	x9, #-0xf000            // =-61440
      38: 8b080088     	add	x8, x4, x8
      3c: f2a00009     	movk	x9, #0x0, lsl #16
      40: eb09011f     	cmp	x8, x9
      44: 54000943     	b.lo	0x16c <iq4_mkv_begin+0x16c>
      48: 12a04008     	mov	w8, #-0x2000001         // =-33554433
      4c: 32072be9     	mov	w9, #-0x1fffff1         // =-33554417
      50: 0b0800a8     	add	w8, w5, w8
      54: 6b09011f     	cmp	w8, w9
      58: 540008a3     	b.lo	0x16c <iq4_mkv_begin+0x16c>
      5c: 5297b7e8     	mov	w8, #0xbdbf             // =48575
      60: 72bffe08     	movk	w8, #0xfff0, lsl #16
      64: 0b0800c9     	add	w9, w6, w8
      68: 11000508     	add	w8, w8, #0x1
      6c: 6b08013f     	cmp	w9, w8
      70: 540007e3     	b.lo	0x16c <iq4_mkv_begin+0x16c>
      74: 529ffb88     	mov	w8, #0xffdc             // =65500
      78: 6b08007f     	cmp	w3, w8
      7c: 54000788     	b.hi	0x16c <iq4_mkv_begin+0x16c>
      80: 6b08005f     	cmp	w2, w8
      84: 54000748     	b.hi	0x16c <iq4_mkv_begin+0x16c>
      88: 34000723     	cbz	w3, 0x16c <iq4_mkv_begin+0x16c>
      8c: 34000702     	cbz	w2, 0x16c <iq4_mkv_begin+0x16c>
      90: f9400828     	ldr	x8, [x1, #0x10]
      94: b40006c8     	cbz	x8, 0x16c <iq4_mkv_begin+0x16c>
      98: b9401a68     	ldr	w8, [x19, #0x18]
      9c: 34000068     	cbz	w8, 0xa8 <iq4_mkv_begin+0xa8>
      a0: 52800040     	mov	w0, #0x2                // =2
      a4: 14000032     	b	0x16c <iq4_mkv_begin+0x16c>
      a8: 6f00e400     	movi	v0.2d, #0000000000000000
      ac: f900327f     	str	xzr, [x19, #0x60]
      b0: aa1303e0     	mov	x0, x19
      b4: 910033f5     	add	x21, sp, #0xc
      b8: ad000260     	stp	q0, q0, [x19]
      bc: ad010260     	stp	q0, q0, [x19, #0x20]
      c0: ad020260     	stp	q0, q0, [x19, #0x40]
      c4: f9400828     	ldr	x8, [x1, #0x10]
      c8: 3dc00020     	ldr	q0, [x1]
      cc: 2a0203e1     	mov	w1, w2
      d0: f9001a64     	str	x4, [x19, #0x30]
      d4: f9000a68     	str	x8, [x19, #0x10]
      d8: 52800028     	mov	w8, #0x1                // =1
      dc: 29030a68     	stp	w8, w2, [x19, #0x18]
      e0: 910033e8     	add	x8, sp, #0xc
      e4: 2a0303e2     	mov	w2, w3
      e8: 3d800260     	str	q0, [x19]
      ec: 29041663     	stp	w3, w5, [x19, #0x20]
      f0: b9002a66     	str	w6, [x19, #0x28]
      f4: 94000000     	bl	0xf4 <iq4_mkv_begin+0xf4>
		00000000000000f4:  R_AARCH64_CALL26	.text.header
      f8: b9418ff6     	ldr	w22, [sp, #0x18c]
      fc: 34000236     	cbz	w22, 0x140 <iq4_mkv_begin+0x140>
     100: 2a1f03f7     	mov	w23, wzr
     104: a9402260     	ldp	x0, x8, [x19]
     108: 8b3742a1     	add	x1, x21, w23, uxtw
     10c: 4b1702d4     	sub	w20, w22, w23
     110: 2a1403e2     	mov	w2, w20
     114: d63f0100     	blr	x8
     118: 35000180     	cbnz	w0, 0x148 <iq4_mkv_begin+0x148>
     11c: d1000428     	sub	x8, x1, #0x1
     120: eb34411f     	cmp	x8, w20, uxtw
     124: 540001e2     	b.hs	0x160 <iq4_mkv_begin+0x160>
     128: f9401e68     	ldr	x8, [x19, #0x38]
     12c: 0b0102f7     	add	w23, w23, w1
     130: 6b1602ff     	cmp	w23, w22
     134: 8b010108     	add	x8, x8, x1
     138: f9001e68     	str	x8, [x19, #0x38]
     13c: 54fffe43     	b.lo	0x104 <iq4_mkv_begin+0x104>
     140: 2a1f03e0     	mov	w0, wzr
     144: 1400000a     	b	0x16c <iq4_mkv_begin+0x16c>
     148: 7100041f     	cmp	w0, #0x1
     14c: 52800068     	mov	w8, #0x3                // =3
     150: 528000c9     	mov	w9, #0x6                // =6
     154: 1a880508     	cinc	w8, w8, ne
     158: 1a890520     	cinc	w0, w9, ne
     15c: 14000003     	b	0x168 <iq4_mkv_begin+0x168>
     160: 52800068     	mov	w8, #0x3                // =3
     164: 528000c0     	mov	w0, #0x6                // =6
     168: b9001a68     	str	w8, [x19, #0x18]
     16c: a95c4ff4     	ldp	x20, x19, [sp, #0x1c0]
     170: a95b57f6     	ldp	x22, x21, [sp, #0x1b0]
     174: a95a5ffc     	ldp	x28, x23, [sp, #0x1a0]
     178: a9597bfd     	ldp	x29, x30, [sp, #0x190]
     17c: 910743ff     	add	sp, sp, #0x1d0
     180: d65f03c0     	ret

Disassembly of section .text.header:

0000000000000000 <header>:
       0: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
       4: f9000bfc     	str	x28, [sp, #0x10]
       8: 910003fd     	mov	x29, sp
       c: a9025ff8     	stp	x24, x23, [sp, #0x20]
      10: a90357f6     	stp	x22, x21, [sp, #0x30]
      14: a9044ff4     	stp	x20, x19, [sp, #0x40]
      18: d11f43ff     	sub	sp, sp, #0x7d0
      1c: 6f00e400     	movi	v0.2d, #0000000000000000
      20: 2a0203f4     	mov	w20, w2
      24: 2a0103f5     	mov	w21, w1
      28: aa0003f6     	mov	x22, x0
      2c: 911903e0     	add	x0, sp, #0x640
      30: 528850c1     	mov	w1, #0x4286             // =17030
      34: 52800042     	mov	w2, #0x2                // =2
      38: 52800023     	mov	w3, #0x1                // =1
      3c: 52800024     	mov	w4, #0x1                // =1
      40: aa0803f3     	mov	x19, x8
      44: b901811f     	str	wzr, [x8, #0x180]
      48: 52800038     	mov	w24, #0x1               // =1
      4c: ad000100     	stp	q0, q0, [x8]
      50: ad010100     	stp	q0, q0, [x8, #0x20]
      54: ad020100     	stp	q0, q0, [x8, #0x40]
      58: ad030100     	stp	q0, q0, [x8, #0x60]
      5c: ad040100     	stp	q0, q0, [x8, #0x80]
      60: ad050100     	stp	q0, q0, [x8, #0xa0]
      64: ad060100     	stp	q0, q0, [x8, #0xc0]
      68: ad070100     	stp	q0, q0, [x8, #0xe0]
      6c: ad080100     	stp	q0, q0, [x8, #0x100]
      70: ad090100     	stp	q0, q0, [x8, #0x120]
      74: ad0a0100     	stp	q0, q0, [x8, #0x140]
      78: ad0b0100     	stp	q0, q0, [x8, #0x160]
      7c: b907c3ff     	str	wzr, [sp, #0x7c0]
      80: 3d81efe0     	str	q0, [sp, #0x7b0]
      84: 3d81ebe0     	str	q0, [sp, #0x7a0]
      88: 3d81e7e0     	str	q0, [sp, #0x790]
      8c: 3d81e3e0     	str	q0, [sp, #0x780]
      90: 3d81dfe0     	str	q0, [sp, #0x770]
      94: 3d81dbe0     	str	q0, [sp, #0x760]
      98: 3d81d7e0     	str	q0, [sp, #0x750]
      9c: 3d81d3e0     	str	q0, [sp, #0x740]
      a0: 3d81cfe0     	str	q0, [sp, #0x730]
      a4: 3d81cbe0     	str	q0, [sp, #0x720]
      a8: 3d81c7e0     	str	q0, [sp, #0x710]
      ac: 3d81c3e0     	str	q0, [sp, #0x700]
      b0: 3d81bfe0     	str	q0, [sp, #0x6f0]
      b4: 3d81bbe0     	str	q0, [sp, #0x6e0]
      b8: 3d81b7e0     	str	q0, [sp, #0x6d0]
      bc: 3d81b3e0     	str	q0, [sp, #0x6c0]
      c0: 3d81afe0     	str	q0, [sp, #0x6b0]
      c4: 3d81abe0     	str	q0, [sp, #0x6a0]
      c8: 3d81a7e0     	str	q0, [sp, #0x690]
      cc: 3d81a3e0     	str	q0, [sp, #0x680]
      d0: 3d819fe0     	str	q0, [sp, #0x670]
      d4: 3d819be0     	str	q0, [sp, #0x660]
      d8: 3d8197e0     	str	q0, [sp, #0x650]
      dc: 3d8193e0     	str	q0, [sp, #0x640]
      e0: b90633ff     	str	wzr, [sp, #0x630]
      e4: 3d818be0     	str	q0, [sp, #0x620]
      e8: 3d8187e0     	str	q0, [sp, #0x610]
      ec: 3d8183e0     	str	q0, [sp, #0x600]
      f0: 3d817fe0     	str	q0, [sp, #0x5f0]
      f4: 3d817be0     	str	q0, [sp, #0x5e0]
      f8: 3d8177e0     	str	q0, [sp, #0x5d0]
      fc: 3d8173e0     	str	q0, [sp, #0x5c0]
     100: 3d816fe0     	str	q0, [sp, #0x5b0]
     104: 3d816be0     	str	q0, [sp, #0x5a0]
     108: 3d8167e0     	str	q0, [sp, #0x590]
     10c: 3d8163e0     	str	q0, [sp, #0x580]
     110: 3d815fe0     	str	q0, [sp, #0x570]
     114: 3d815be0     	str	q0, [sp, #0x560]
     118: 3d8157e0     	str	q0, [sp, #0x550]
     11c: 3d8153e0     	str	q0, [sp, #0x540]
     120: 3d814fe0     	str	q0, [sp, #0x530]
     124: 3d814be0     	str	q0, [sp, #0x520]
     128: 3d8147e0     	str	q0, [sp, #0x510]
     12c: 3d8143e0     	str	q0, [sp, #0x500]
     130: 3d813fe0     	str	q0, [sp, #0x4f0]
     134: 3d813be0     	str	q0, [sp, #0x4e0]
     138: 3d8137e0     	str	q0, [sp, #0x4d0]
     13c: 3d8133e0     	str	q0, [sp, #0x4c0]
     140: 3d812fe0     	str	q0, [sp, #0x4b0]
     144: b904a3ff     	str	wzr, [sp, #0x4a0]
     148: 3d8127e0     	str	q0, [sp, #0x490]
     14c: 3d8123e0     	str	q0, [sp, #0x480]
     150: 3d811fe0     	str	q0, [sp, #0x470]
     154: 3d811be0     	str	q0, [sp, #0x460]
     158: 3d8117e0     	str	q0, [sp, #0x450]
     15c: 3d8113e0     	str	q0, [sp, #0x440]
     160: 3d810fe0     	str	q0, [sp, #0x430]
     164: 3d810be0     	str	q0, [sp, #0x420]
     168: 3d8107e0     	str	q0, [sp, #0x410]
     16c: ad1983e0     	stp	q0, q0, [sp, #0x330]
     170: ad1a83e0     	stp	q0, q0, [sp, #0x350]
     174: ad1b83e0     	stp	q0, q0, [sp, #0x370]
     178: ad1c83e0     	stp	q0, q0, [sp, #0x390]
     17c: ad1d83e0     	stp	q0, q0, [sp, #0x3b0]
     180: 3d80cbe0     	str	q0, [sp, #0x320]
     184: ad0103e0     	stp	q0, q0, [sp, #0x20]
     188: ad0203e0     	stp	q0, q0, [sp, #0x40]
     18c: ad0303e0     	stp	q0, q0, [sp, #0x60]
     190: ad0403e0     	stp	q0, q0, [sp, #0x80]
     194: ad0503e0     	stp	q0, q0, [sp, #0xa0]
     198: ad0603e0     	stp	q0, q0, [sp, #0xc0]
     19c: ad0703e0     	stp	q0, q0, [sp, #0xe0]
     1a0: ad0803e0     	stp	q0, q0, [sp, #0x100]
     1a4: ad0903e0     	stp	q0, q0, [sp, #0x120]
     1a8: ad0a03e0     	stp	q0, q0, [sp, #0x140]
     1ac: ad0b03e0     	stp	q0, q0, [sp, #0x160]
     1b0: ad0c83e0     	stp	q0, q0, [sp, #0x190]
     1b4: ad0d83e0     	stp	q0, q0, [sp, #0x1b0]
     1b8: ad0e83e0     	stp	q0, q0, [sp, #0x1d0]
     1bc: ad0f83e0     	stp	q0, q0, [sp, #0x1f0]
     1c0: ad1083e0     	stp	q0, q0, [sp, #0x210]
     1c4: ad1183e0     	stp	q0, q0, [sp, #0x230]
     1c8: ad1283e0     	stp	q0, q0, [sp, #0x250]
     1cc: ad1383e0     	stp	q0, q0, [sp, #0x270]
     1d0: ad1483e0     	stp	q0, q0, [sp, #0x290]
     1d4: ad1583e0     	stp	q0, q0, [sp, #0x2b0]
     1d8: ad1683e0     	stp	q0, q0, [sp, #0x2d0]
     1dc: ad1783e0     	stp	q0, q0, [sp, #0x2f0]
     1e0: ad1e83e0     	stp	q0, q0, [sp, #0x3d0]
     1e4: ad1f83e0     	stp	q0, q0, [sp, #0x3f0]
     1e8: b90313ff     	str	wzr, [sp, #0x310]
     1ec: b90183ff     	str	wzr, [sp, #0x180]
     1f0: ad0003e0     	stp	q0, q0, [sp]
     1f4: 94000000     	bl	0x1f4 <header+0x1f4>
		00000000000001f4:  R_AARCH64_CALL26	.text.uint_elem
     1f8: 911903e0     	add	x0, sp, #0x640
     1fc: 52885ee1     	mov	w1, #0x42f7             // =17143
     200: 52800042     	mov	w2, #0x2                // =2
     204: 52800023     	mov	w3, #0x1                // =1
     208: 52800024     	mov	w4, #0x1                // =1
     20c: 94000000     	bl	0x20c <header+0x20c>
		000000000000020c:  R_AARCH64_CALL26	.text.uint_elem
     210: 911903e0     	add	x0, sp, #0x640
     214: 52885e41     	mov	w1, #0x42f2             // =17138
     218: 52800042     	mov	w2, #0x2                // =2
     21c: 52800083     	mov	w3, #0x4                // =4
     220: 52800024     	mov	w4, #0x1                // =1
     224: 94000000     	bl	0x224 <header+0x224>
		0000000000000224:  R_AARCH64_CALL26	.text.uint_elem
     228: 911903e0     	add	x0, sp, #0x640
     22c: 52885e61     	mov	w1, #0x42f3             // =17139
     230: 52800042     	mov	w2, #0x2                // =2
     234: 52800103     	mov	w3, #0x8                // =8
     238: 52800024     	mov	w4, #0x1                // =1
     23c: 94000000     	bl	0x23c <header+0x23c>
		000000000000023c:  R_AARCH64_CALL26	.text.uint_elem
     240: 90000003     	adrp	x3, 0x0 <header>
		0000000000000240:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1
     244: 91000063     	add	x3, x3, #0x0
		0000000000000244:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1
     248: 911903e0     	add	x0, sp, #0x640
     24c: 52885041     	mov	w1, #0x4282             // =17026
     250: 52800042     	mov	w2, #0x2                // =2
     254: 94000000     	bl	0x254 <header+0x254>
		0000000000000254:  R_AARCH64_CALL26	.text.str_elem
     258: 911903e0     	add	x0, sp, #0x640
     25c: 528850e1     	mov	w1, #0x4287             // =17031
     260: 52800042     	mov	w2, #0x2                // =2
     264: 52800083     	mov	w3, #0x4                // =4
     268: 52800024     	mov	w4, #0x1                // =1
     26c: 94000000     	bl	0x26c <header+0x26c>
		000000000000026c:  R_AARCH64_CALL26	.text.uint_elem
     270: 911903e0     	add	x0, sp, #0x640
     274: 528850a1     	mov	w1, #0x4285             // =17029
     278: 52800042     	mov	w2, #0x2                // =2
     27c: 52800043     	mov	w3, #0x2                // =2
     280: 52800024     	mov	w4, #0x1                // =1
     284: 94000000     	bl	0x284 <header+0x284>
		0000000000000284:  R_AARCH64_CALL26	.text.uint_elem
     288: b9418268     	ldr	w8, [x19, #0x180]
     28c: b947c3e2     	ldr	w2, [sp, #0x7c0]
     290: 11000509     	add	w9, w8, #0x1
     294: 7101fc5f     	cmp	w2, #0x7f
     298: b9018269     	str	w9, [x19, #0x180]
     29c: 52800349     	mov	w9, #0x1a               // =26
     2a0: 38286a69     	strb	w9, [x19, x8]
     2a4: b9418268     	ldr	w8, [x19, #0x180]
     2a8: 11000509     	add	w9, w8, #0x1
     2ac: b9018269     	str	w9, [x19, #0x180]
     2b0: 528008a9     	mov	w9, #0x45               // =69
     2b4: 38286a69     	strb	w9, [x19, x8]
     2b8: b9418268     	ldr	w8, [x19, #0x180]
     2bc: 11000509     	add	w9, w8, #0x1
     2c0: b9018269     	str	w9, [x19, #0x180]
     2c4: 52801be9     	mov	w9, #0xdf               // =223
     2c8: 38286a69     	strb	w9, [x19, x8]
     2cc: b9418268     	ldr	w8, [x19, #0x180]
     2d0: 11000509     	add	w9, w8, #0x1
     2d4: b9018269     	str	w9, [x19, #0x180]
     2d8: 52801469     	mov	w9, #0xa3               // =163
     2dc: 38286a69     	strb	w9, [x19, x8]
     2e0: 540001e3     	b.lo	0x31c <header+0x31c>
     2e4: 5287ffe8     	mov	w8, #0x3fff             // =16383
     2e8: 6b08005f     	cmp	w2, w8
     2ec: 54000062     	b.hs	0x2f8 <header+0x2f8>
     2f0: 52800058     	mov	w24, #0x2               // =2
     2f4: 1400000a     	b	0x31c <header+0x31c>
     2f8: 12bffc08     	mov	w8, #0x1fffff           // =2097151
     2fc: 6b08005f     	cmp	w2, w8
     300: 54000062     	b.hs	0x30c <header+0x30c>
     304: 52800078     	mov	w24, #0x3               // =3
     308: 14000005     	b	0x31c <header+0x31c>
     30c: 12be0008     	mov	w8, #0xfffffff          // =268435455
     310: 6b08005f     	cmp	w2, w8
     314: 52800088     	mov	w8, #0x4                // =4
     318: 1a883518     	cinc	w24, w8, hs
     31c: 531d730a     	lsl	w10, w24, #3
     320: 52800037     	mov	w23, #0x1               // =1
     324: b941826b     	ldr	w11, [x19, #0x180]
     328: 2a1803e9     	mov	w9, w24
     32c: 4b180148     	sub	w8, w10, w24
     330: 5100214a     	sub	w10, w10, #0x8
     334: 1100056c     	add	w12, w11, #0x1
     338: 9ac822e8     	lsl	x8, x23, x8
     33c: b901826c     	str	w12, [x19, #0x180]
     340: aa020108     	orr	x8, x8, x2
     344: 9aca250d     	lsr	x13, x8, x10
     348: d100052a     	sub	x10, x9, #0x1
     34c: 382b6a6d     	strb	w13, [x19, x11]
     350: 3400046a     	cbz	w10, 0x3dc <header+0x3dc>
     354: 531d714a     	lsl	w10, w10, #3
     358: b941826b     	ldr	w11, [x19, #0x180]
     35c: 5100214a     	sub	w10, w10, #0x8
     360: 1100056c     	add	w12, w11, #0x1
     364: 9aca250d     	lsr	x13, x8, x10
     368: d100092a     	sub	x10, x9, #0x2
     36c: b901826c     	str	w12, [x19, #0x180]
     370: 382b6a6d     	strb	w13, [x19, x11]
     374: 3400034a     	cbz	w10, 0x3dc <header+0x3dc>
     378: 531d714a     	lsl	w10, w10, #3
     37c: b941826b     	ldr	w11, [x19, #0x180]
     380: 5100214a     	sub	w10, w10, #0x8
     384: 1100056c     	add	w12, w11, #0x1
     388: 9aca250d     	lsr	x13, x8, x10
     38c: d1000d2a     	sub	x10, x9, #0x3
     390: b901826c     	str	w12, [x19, #0x180]
     394: 382b6a6d     	strb	w13, [x19, x11]
     398: 3400022a     	cbz	w10, 0x3dc <header+0x3dc>
     39c: 531d714a     	lsl	w10, w10, #3
     3a0: b941826b     	ldr	w11, [x19, #0x180]
     3a4: d1001129     	sub	x9, x9, #0x4
     3a8: 5100214a     	sub	w10, w10, #0x8
     3ac: 1100056c     	add	w12, w11, #0x1
     3b0: 9aca250a     	lsr	x10, x8, x10
     3b4: b901826c     	str	w12, [x19, #0x180]
     3b8: 382b6a6a     	strb	w10, [x19, x11]
     3bc: 34000109     	cbz	w9, 0x3dc <header+0x3dc>
     3c0: 531d7129     	lsl	w9, w9, #3
     3c4: b941826a     	ldr	w10, [x19, #0x180]
     3c8: 51002129     	sub	w9, w9, #0x8
     3cc: 1100054b     	add	w11, w10, #0x1
     3d0: 9ac92508     	lsr	x8, x8, x9
     3d4: b901826b     	str	w11, [x19, #0x180]
     3d8: 382a6a68     	strb	w8, [x19, x10]
     3dc: b9418268     	ldr	w8, [x19, #0x180]
     3e0: 911903e1     	add	x1, sp, #0x640
     3e4: 8b080260     	add	x0, x19, x8
     3e8: 94000000     	bl	0x3e8 <header+0x3e8>
		00000000000003e8:  R_AARCH64_CALL26	memcpy
     3ec: b947c3e8     	ldr	w8, [sp, #0x7c0]
     3f0: b9418269     	ldr	w9, [x19, #0x180]
     3f4: 529af621     	mov	w1, #0xd7b1             // =55217
     3f8: 9112c3e0     	add	x0, sp, #0x4b0
     3fc: 72a00541     	movk	w1, #0x2a, lsl #16
     400: 52800062     	mov	w2, #0x3                // =3
     404: 0b080128     	add	w8, w9, w8
     408: 52800023     	mov	w3, #0x1                // =1
     40c: 52800024     	mov	w4, #0x1                // =1
     410: 11000509     	add	w9, w8, #0x1
     414: b9018269     	str	w9, [x19, #0x180]
     418: 52800309     	mov	w9, #0x18               // =24
     41c: 38284a69     	strb	w9, [x19, w8, uxtw]
     420: b9418268     	ldr	w8, [x19, #0x180]
     424: 11000509     	add	w9, w8, #0x1
     428: b9018269     	str	w9, [x19, #0x180]
     42c: 52800a69     	mov	w9, #0x53               // =83
     430: 38286a69     	strb	w9, [x19, x8]
     434: b9418268     	ldr	w8, [x19, #0x180]
     438: 11000509     	add	w9, w8, #0x1
     43c: b9018269     	str	w9, [x19, #0x180]
     440: 52801009     	mov	w9, #0x80               // =128
     444: 38286a69     	strb	w9, [x19, x8]
     448: b9418268     	ldr	w8, [x19, #0x180]
     44c: 11000509     	add	w9, w8, #0x1
     450: b9018269     	str	w9, [x19, #0x180]
     454: 52800ce9     	mov	w9, #0x67               // =103
     458: 38286a69     	strb	w9, [x19, x8]
     45c: b9418268     	ldr	w8, [x19, #0x180]
     460: 11000509     	add	w9, w8, #0x1
     464: b9018269     	str	w9, [x19, #0x180]
     468: 38286a77     	strb	w23, [x19, x8]
     46c: b9418269     	ldr	w9, [x19, #0x180]
     470: 1100052a     	add	w10, w9, #0x1
     474: b901826a     	str	w10, [x19, #0x180]
     478: 52801fea     	mov	w10, #0xff              // =255
     47c: 38296a6a     	strb	w10, [x19, x9]
     480: b9418269     	ldr	w9, [x19, #0x180]
     484: 1100052b     	add	w11, w9, #0x1
     488: b901826b     	str	w11, [x19, #0x180]
     48c: 38296a6a     	strb	w10, [x19, x9]
     490: b9418269     	ldr	w9, [x19, #0x180]
     494: 1100052b     	add	w11, w9, #0x1
     498: b901826b     	str	w11, [x19, #0x180]
     49c: 38296a6a     	strb	w10, [x19, x9]
     4a0: b9418269     	ldr	w9, [x19, #0x180]
     4a4: 1100052b     	add	w11, w9, #0x1
     4a8: b901826b     	str	w11, [x19, #0x180]
     4ac: 38296a6a     	strb	w10, [x19, x9]
     4b0: b9418269     	ldr	w9, [x19, #0x180]
     4b4: 1100052b     	add	w11, w9, #0x1
     4b8: b901826b     	str	w11, [x19, #0x180]
     4bc: 38296a6a     	strb	w10, [x19, x9]
     4c0: b9418269     	ldr	w9, [x19, #0x180]
     4c4: 1100052b     	add	w11, w9, #0x1
     4c8: b901826b     	str	w11, [x19, #0x180]
     4cc: 38296a6a     	strb	w10, [x19, x9]
     4d0: b9418269     	ldr	w9, [x19, #0x180]
     4d4: 1100052b     	add	w11, w9, #0x1
     4d8: b901826b     	str	w11, [x19, #0x180]
     4dc: 38296a6a     	strb	w10, [x19, x9]
     4e0: b9418269     	ldr	w9, [x19, #0x180]
     4e4: a90426c8     	stp	x8, x9, [x22, #0x40]
     4e8: 94000000     	bl	0x4e8 <header+0x4e8>
		00000000000004e8:  R_AARCH64_CALL26	.text.uint_elem
     4ec: 90000016     	adrp	x22, 0x0 <header>
		00000000000004ec:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x16
     4f0: 910002d6     	add	x22, x22, #0x0
		00000000000004f0:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x16
     4f4: 9112c3e0     	add	x0, sp, #0x4b0
     4f8: 5289b001     	mov	w1, #0x4d80             // =19840
     4fc: 52800042     	mov	w2, #0x2                // =2
     500: aa1603e3     	mov	x3, x22
     504: 94000000     	bl	0x504 <header+0x504>
		0000000000000504:  R_AARCH64_CALL26	.text.str_elem
     508: 9112c3e0     	add	x0, sp, #0x4b0
     50c: 528ae821     	mov	w1, #0x5741             // =22337
     510: 52800042     	mov	w2, #0x2                // =2
     514: aa1603e3     	mov	x3, x22
     518: 94000000     	bl	0x518 <header+0x518>
		0000000000000518:  R_AARCH64_CALL26	.text.str_elem
     51c: b9418268     	ldr	w8, [x19, #0x180]
     520: b94633e2     	ldr	w2, [sp, #0x630]
     524: 11000509     	add	w9, w8, #0x1
     528: 7101fc5f     	cmp	w2, #0x7f
     52c: b9018269     	str	w9, [x19, #0x180]
     530: 528002a9     	mov	w9, #0x15               // =21
     534: 38286a69     	strb	w9, [x19, x8]
     538: b9418268     	ldr	w8, [x19, #0x180]
     53c: 11000509     	add	w9, w8, #0x1
     540: b9018269     	str	w9, [x19, #0x180]
     544: 52800929     	mov	w9, #0x49               // =73
     548: 38286a69     	strb	w9, [x19, x8]
     54c: b9418268     	ldr	w8, [x19, #0x180]
     550: 11000509     	add	w9, w8, #0x1
     554: b9018269     	str	w9, [x19, #0x180]
     558: 52801529     	mov	w9, #0xa9               // =169
     55c: 38286a69     	strb	w9, [x19, x8]
     560: b9418268     	ldr	w8, [x19, #0x180]
     564: 11000509     	add	w9, w8, #0x1
     568: b9018269     	str	w9, [x19, #0x180]
     56c: 52800cc9     	mov	w9, #0x66               // =102
     570: 38286a69     	strb	w9, [x19, x8]
     574: 540001e3     	b.lo	0x5b0 <header+0x5b0>
     578: 5287ffe8     	mov	w8, #0x3fff             // =16383
     57c: 6b08005f     	cmp	w2, w8
     580: 54000062     	b.hs	0x58c <header+0x58c>
     584: 52800057     	mov	w23, #0x2               // =2
     588: 1400000a     	b	0x5b0 <header+0x5b0>
     58c: 12bffc08     	mov	w8, #0x1fffff           // =2097151
     590: 6b08005f     	cmp	w2, w8
     594: 54000062     	b.hs	0x5a0 <header+0x5a0>
     598: 52800077     	mov	w23, #0x3               // =3
     59c: 14000005     	b	0x5b0 <header+0x5b0>
     5a0: 12be0008     	mov	w8, #0xfffffff          // =268435455
     5a4: 6b08005f     	cmp	w2, w8
     5a8: 52800088     	mov	w8, #0x4                // =4
     5ac: 1a883517     	cinc	w23, w8, hs
     5b0: 531d72ea     	lsl	w10, w23, #3
     5b4: 52800028     	mov	w8, #0x1                // =1
     5b8: b941826b     	ldr	w11, [x19, #0x180]
     5bc: 4b170149     	sub	w9, w10, w23
     5c0: 5100214a     	sub	w10, w10, #0x8
     5c4: 1100056c     	add	w12, w11, #0x1
     5c8: 9ac92108     	lsl	x8, x8, x9
     5cc: 2a1703e9     	mov	w9, w23
     5d0: b901826c     	str	w12, [x19, #0x180]
     5d4: aa020108     	orr	x8, x8, x2
     5d8: 9aca250d     	lsr	x13, x8, x10
     5dc: d100052a     	sub	x10, x9, #0x1
     5e0: 382b6a6d     	strb	w13, [x19, x11]
     5e4: 3400046a     	cbz	w10, 0x670 <header+0x670>
     5e8: 531d714a     	lsl	w10, w10, #3
     5ec: b941826b     	ldr	w11, [x19, #0x180]
     5f0: 5100214a     	sub	w10, w10, #0x8
     5f4: 1100056c     	add	w12, w11, #0x1
     5f8: 9aca250d     	lsr	x13, x8, x10
     5fc: d100092a     	sub	x10, x9, #0x2
     600: b901826c     	str	w12, [x19, #0x180]
     604: 382b6a6d     	strb	w13, [x19, x11]
     608: 3400034a     	cbz	w10, 0x670 <header+0x670>
     60c: 531d714a     	lsl	w10, w10, #3
     610: b941826b     	ldr	w11, [x19, #0x180]
     614: 5100214a     	sub	w10, w10, #0x8
     618: 1100056c     	add	w12, w11, #0x1
     61c: 9aca250d     	lsr	x13, x8, x10
     620: d1000d2a     	sub	x10, x9, #0x3
     624: b901826c     	str	w12, [x19, #0x180]
     628: 382b6a6d     	strb	w13, [x19, x11]
     62c: 3400022a     	cbz	w10, 0x670 <header+0x670>
     630: 531d714a     	lsl	w10, w10, #3
     634: b941826b     	ldr	w11, [x19, #0x180]
     638: d1001129     	sub	x9, x9, #0x4
     63c: 5100214a     	sub	w10, w10, #0x8
     640: 1100056c     	add	w12, w11, #0x1
     644: 9aca250a     	lsr	x10, x8, x10
     648: b901826c     	str	w12, [x19, #0x180]
     64c: 382b6a6a     	strb	w10, [x19, x11]
     650: 34000109     	cbz	w9, 0x670 <header+0x670>
     654: 531d7129     	lsl	w9, w9, #3
     658: b941826a     	ldr	w10, [x19, #0x180]
     65c: 51002129     	sub	w9, w9, #0x8
     660: 1100054b     	add	w11, w10, #0x1
     664: 9ac92508     	lsr	x8, x8, x9
     668: b901826b     	str	w11, [x19, #0x180]
     66c: 382a6a68     	strb	w8, [x19, x10]
     670: b9418268     	ldr	w8, [x19, #0x180]
     674: 9112c3e1     	add	x1, sp, #0x4b0
     678: 8b080260     	add	x0, x19, x8
     67c: 94000000     	bl	0x67c <header+0x67c>
		000000000000067c:  R_AARCH64_CALL26	memcpy
     680: b94633e8     	ldr	w8, [sp, #0x630]
     684: b9418269     	ldr	w9, [x19, #0x180]
     688: 910c83e0     	add	x0, sp, #0x320
     68c: 52801ae1     	mov	w1, #0xd7               // =215
     690: 52800022     	mov	w2, #0x1                // =1
     694: 52800023     	mov	w3, #0x1                // =1
     698: 0b080128     	add	w8, w9, w8
     69c: 52800024     	mov	w4, #0x1                // =1
     6a0: 52800037     	mov	w23, #0x1               // =1
     6a4: b9018268     	str	w8, [x19, #0x180]
     6a8: 910c83f6     	add	x22, sp, #0x320
     6ac: 94000000     	bl	0x6ac <header+0x6ac>
		00000000000006ac:  R_AARCH64_CALL26	.text.uint_elem
     6b0: 910c83e0     	add	x0, sp, #0x320
     6b4: 528e78a1     	mov	w1, #0x73c5             // =29637
     6b8: 52800042     	mov	w2, #0x2                // =2
     6bc: 52800023     	mov	w3, #0x1                // =1
     6c0: 52800024     	mov	w4, #0x1                // =1
     6c4: 94000000     	bl	0x6c4 <header+0x6c4>
		00000000000006c4:  R_AARCH64_CALL26	.text.uint_elem
     6c8: 910c83e0     	add	x0, sp, #0x320
     6cc: 52801061     	mov	w1, #0x83               // =131
     6d0: 52800022     	mov	w2, #0x1                // =1
     6d4: 52800023     	mov	w3, #0x1                // =1
     6d8: 52800024     	mov	w4, #0x1                // =1
     6dc: 94000000     	bl	0x6dc <header+0x6dc>
		00000000000006dc:  R_AARCH64_CALL26	.text.uint_elem
     6e0: 910c83e0     	add	x0, sp, #0x320
     6e4: 52801381     	mov	w1, #0x9c               // =156
     6e8: 52800022     	mov	w2, #0x1                // =1
     6ec: aa1f03e3     	mov	x3, xzr
     6f0: 52800024     	mov	w4, #0x1                // =1
     6f4: 94000000     	bl	0x6f4 <header+0x6f4>
		00000000000006f4:  R_AARCH64_CALL26	.text.uint_elem
     6f8: 90000003     	adrp	x3, 0x0 <header>
		00000000000006f8:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xe
     6fc: 91000063     	add	x3, x3, #0x0
		00000000000006fc:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xe
     700: 910c83e0     	add	x0, sp, #0x320
     704: 528010c1     	mov	w1, #0x86               // =134
     708: 52800022     	mov	w2, #0x1                // =1
     70c: 94000000     	bl	0x70c <header+0x70c>
		000000000000070c:  R_AARCH64_CALL26	.text.str_elem
     710: 2a1503e3     	mov	w3, w21
     714: 910643e0     	add	x0, sp, #0x190
     718: 52801601     	mov	w1, #0xb0               // =176
     71c: 52800022     	mov	w2, #0x1                // =1
     720: 52800044     	mov	w4, #0x2                // =2
     724: 94000000     	bl	0x724 <header+0x724>
		0000000000000724:  R_AARCH64_CALL26	.text.uint_elem
     728: 2a1403e3     	mov	w3, w20
     72c: 910643e0     	add	x0, sp, #0x190
     730: 52801741     	mov	w1, #0xba               // =186
     734: 52800022     	mov	w2, #0x1                // =1
     738: 52800044     	mov	w4, #0x2                // =2
     73c: 94000000     	bl	0x73c <header+0x73c>
		000000000000073c:  R_AARCH64_CALL26	.text.uint_elem
     740: b944a3e8     	ldr	w8, [sp, #0x4a0]
     744: b94313e2     	ldr	w2, [sp, #0x310]
     748: 11000509     	add	w9, w8, #0x1
     74c: 7101fc5f     	cmp	w2, #0x7f
     750: b904a3e9     	str	w9, [sp, #0x4a0]
     754: 52801c09     	mov	w9, #0xe0               // =224
     758: 38286ac9     	strb	w9, [x22, x8]
     75c: 540001e3     	b.lo	0x798 <header+0x798>
     760: 5287ffe8     	mov	w8, #0x3fff             // =16383
     764: 6b08005f     	cmp	w2, w8
     768: 54000062     	b.hs	0x774 <header+0x774>
     76c: 52800057     	mov	w23, #0x2               // =2
     770: 1400000a     	b	0x798 <header+0x798>
     774: 12bffc08     	mov	w8, #0x1fffff           // =2097151
     778: 6b08005f     	cmp	w2, w8
     77c: 54000062     	b.hs	0x788 <header+0x788>
     780: 52800077     	mov	w23, #0x3               // =3
     784: 14000005     	b	0x798 <header+0x798>
     788: 12be0008     	mov	w8, #0xfffffff          // =268435455
     78c: 6b08005f     	cmp	w2, w8
     790: 52800088     	mov	w8, #0x4                // =4
     794: 1a883517     	cinc	w23, w8, hs
     798: 531d72ea     	lsl	w10, w23, #3
     79c: 52800028     	mov	w8, #0x1                // =1
     7a0: b944a3eb     	ldr	w11, [sp, #0x4a0]
     7a4: 4b170149     	sub	w9, w10, w23
     7a8: 5100214a     	sub	w10, w10, #0x8
     7ac: 1100056c     	add	w12, w11, #0x1
     7b0: 9ac92108     	lsl	x8, x8, x9
     7b4: 2a1703e9     	mov	w9, w23
     7b8: b904a3ec     	str	w12, [sp, #0x4a0]
     7bc: aa020108     	orr	x8, x8, x2
     7c0: 9aca250d     	lsr	x13, x8, x10
     7c4: d100052a     	sub	x10, x9, #0x1
     7c8: 382b6acd     	strb	w13, [x22, x11]
     7cc: 340004aa     	cbz	w10, 0x860 <header+0x860>
     7d0: 531d714a     	lsl	w10, w10, #3
     7d4: b944a3ec     	ldr	w12, [sp, #0x4a0]
     7d8: 5100214a     	sub	w10, w10, #0x8
     7dc: 1100058b     	add	w11, w12, #0x1
     7e0: 9aca250d     	lsr	x13, x8, x10
     7e4: b904a3eb     	str	w11, [sp, #0x4a0]
     7e8: 910c83ea     	add	x10, sp, #0x320
     7ec: d100092b     	sub	x11, x9, #0x2
     7f0: 382c694d     	strb	w13, [x10, x12]
     7f4: 3400036b     	cbz	w11, 0x860 <header+0x860>
     7f8: 531d716b     	lsl	w11, w11, #3
     7fc: b944a3ec     	ldr	w12, [sp, #0x4a0]
     800: 5100216b     	sub	w11, w11, #0x8
     804: 1100058d     	add	w13, w12, #0x1
     808: 9acb250e     	lsr	x14, x8, x11
     80c: d1000d2b     	sub	x11, x9, #0x3
     810: b904a3ed     	str	w13, [sp, #0x4a0]
     814: 382c694e     	strb	w14, [x10, x12]
     818: 3400024b     	cbz	w11, 0x860 <header+0x860>
     81c: 531d716a     	lsl	w10, w11, #3
     820: b944a3eb     	ldr	w11, [sp, #0x4a0]
     824: d1001129     	sub	x9, x9, #0x4
     828: 5100214a     	sub	w10, w10, #0x8
     82c: 1100056c     	add	w12, w11, #0x1
     830: 9aca250d     	lsr	x13, x8, x10
     834: 910c83ea     	add	x10, sp, #0x320
     838: b904a3ec     	str	w12, [sp, #0x4a0]
     83c: 382b694d     	strb	w13, [x10, x11]
     840: 34000109     	cbz	w9, 0x860 <header+0x860>
     844: 531d7129     	lsl	w9, w9, #3
     848: b944a3eb     	ldr	w11, [sp, #0x4a0]
     84c: 51002129     	sub	w9, w9, #0x8
     850: 1100056c     	add	w12, w11, #0x1
     854: 9ac92508     	lsr	x8, x8, x9
     858: b904a3ec     	str	w12, [sp, #0x4a0]
     85c: 382b6948     	strb	w8, [x10, x11]
     860: b944a3e8     	ldr	w8, [sp, #0x4a0]
     864: 910c83e9     	add	x9, sp, #0x320
     868: 910643e1     	add	x1, sp, #0x190
     86c: 8b080120     	add	x0, x9, x8
     870: 94000000     	bl	0x870 <header+0x870>
		0000000000000870:  R_AARCH64_CALL26	memcpy
     874: b94313e8     	ldr	w8, [sp, #0x310]
     878: b944a3e9     	ldr	w9, [sp, #0x4a0]
     87c: 910003ea     	mov	x10, sp
     880: b94183eb     	ldr	w11, [sp, #0x180]
     884: 0b080122     	add	w2, w9, w8
     888: 11000568     	add	w8, w11, #0x1
     88c: 7101fc5f     	cmp	w2, #0x7f
     890: b904a3e2     	str	w2, [sp, #0x4a0]
     894: b90183e8     	str	w8, [sp, #0x180]
     898: 528015c8     	mov	w8, #0xae               // =174
     89c: 382b6948     	strb	w8, [x10, x11]
     8a0: 54000062     	b.hs	0x8ac <header+0x8ac>
     8a4: 52800029     	mov	w9, #0x1                // =1
     8a8: 1400000f     	b	0x8e4 <header+0x8e4>
     8ac: 5287ffe8     	mov	w8, #0x3fff             // =16383
     8b0: 6b08005f     	cmp	w2, w8
     8b4: 54000062     	b.hs	0x8c0 <header+0x8c0>
     8b8: 52800049     	mov	w9, #0x2                // =2
     8bc: 1400000a     	b	0x8e4 <header+0x8e4>
     8c0: 12bffc08     	mov	w8, #0x1fffff           // =2097151
     8c4: 6b08005f     	cmp	w2, w8
     8c8: 54000062     	b.hs	0x8d4 <header+0x8d4>
     8cc: 52800069     	mov	w9, #0x3                // =3
     8d0: 14000005     	b	0x8e4 <header+0x8e4>
     8d4: 12be0008     	mov	w8, #0xfffffff          // =268435455
     8d8: 6b08005f     	cmp	w2, w8
     8dc: 52800088     	mov	w8, #0x4                // =4
     8e0: 1a883509     	cinc	w9, w8, hs
     8e4: 531d712b     	lsl	w11, w9, #3
     8e8: 52800028     	mov	w8, #0x1                // =1
     8ec: 4b09016c     	sub	w12, w11, w9
     8f0: 2a0903e9     	mov	w9, w9
     8f4: 5100216b     	sub	w11, w11, #0x8
     8f8: 9acc2108     	lsl	x8, x8, x12
     8fc: b94183ec     	ldr	w12, [sp, #0x180]
     900: aa020108     	orr	x8, x8, x2
     904: 1100058d     	add	w13, w12, #0x1
     908: 9acb250e     	lsr	x14, x8, x11
     90c: d100052b     	sub	x11, x9, #0x1
     910: b90183ed     	str	w13, [sp, #0x180]
     914: 382c694e     	strb	w14, [x10, x12]
     918: 340004ab     	cbz	w11, 0x9ac <header+0x9ac>
     91c: 531d716a     	lsl	w10, w11, #3
     920: b94183ec     	ldr	w12, [sp, #0x180]
     924: 5100214a     	sub	w10, w10, #0x8
     928: 1100058b     	add	w11, w12, #0x1
     92c: 9aca250d     	lsr	x13, x8, x10
     930: b90183eb     	str	w11, [sp, #0x180]
     934: 910003ea     	mov	x10, sp
     938: d100092b     	sub	x11, x9, #0x2
     93c: 382c694d     	strb	w13, [x10, x12]
     940: 3400036b     	cbz	w11, 0x9ac <header+0x9ac>
     944: 531d716b     	lsl	w11, w11, #3
     948: b94183ec     	ldr	w12, [sp, #0x180]
     94c: 5100216b     	sub	w11, w11, #0x8
     950: 1100058d     	add	w13, w12, #0x1
     954: 9acb250e     	lsr	x14, x8, x11
     958: d1000d2b     	sub	x11, x9, #0x3
     95c: b90183ed     	str	w13, [sp, #0x180]
     960: 382c694e     	strb	w14, [x10, x12]
     964: 3400024b     	cbz	w11, 0x9ac <header+0x9ac>
     968: 531d716a     	lsl	w10, w11, #3
     96c: b94183eb     	ldr	w11, [sp, #0x180]
     970: d1001129     	sub	x9, x9, #0x4
     974: 5100214a     	sub	w10, w10, #0x8
     978: 1100056c     	add	w12, w11, #0x1
     97c: 9aca250d     	lsr	x13, x8, x10
     980: 910003ea     	mov	x10, sp
     984: b90183ec     	str	w12, [sp, #0x180]
     988: 382b694d     	strb	w13, [x10, x11]
     98c: 34000109     	cbz	w9, 0x9ac <header+0x9ac>
     990: 531d7129     	lsl	w9, w9, #3
     994: b94183eb     	ldr	w11, [sp, #0x180]
     998: 51002129     	sub	w9, w9, #0x8
     99c: 1100056c     	add	w12, w11, #0x1
     9a0: 9ac92508     	lsr	x8, x8, x9
     9a4: b90183ec     	str	w12, [sp, #0x180]
     9a8: 382b6948     	strb	w8, [x10, x11]
     9ac: b94183e8     	ldr	w8, [sp, #0x180]
     9b0: 910003e9     	mov	x9, sp
     9b4: 910c83e1     	add	x1, sp, #0x320
     9b8: 8b080120     	add	x0, x9, x8
     9bc: 94000000     	bl	0x9bc <header+0x9bc>
		00000000000009bc:  R_AARCH64_CALL26	memcpy
     9c0: b9418268     	ldr	w8, [x19, #0x180]
     9c4: b944a3ea     	ldr	w10, [sp, #0x4a0]
     9c8: 11000509     	add	w9, w8, #0x1
     9cc: b9018269     	str	w9, [x19, #0x180]
     9d0: 528002c9     	mov	w9, #0x16               // =22
     9d4: 38286a69     	strb	w9, [x19, x8]
     9d8: b9418268     	ldr	w8, [x19, #0x180]
     9dc: 11000509     	add	w9, w8, #0x1
     9e0: b9018269     	str	w9, [x19, #0x180]
     9e4: 52800a89     	mov	w9, #0x54               // =84
     9e8: 38286a69     	strb	w9, [x19, x8]
     9ec: b9418268     	ldr	w8, [x19, #0x180]
     9f0: 11000509     	add	w9, w8, #0x1
     9f4: b9018269     	str	w9, [x19, #0x180]
     9f8: 528015c9     	mov	w9, #0xae               // =174
     9fc: 38286a69     	strb	w9, [x19, x8]
     a00: b94183e8     	ldr	w8, [sp, #0x180]
     a04: b9418269     	ldr	w9, [x19, #0x180]
     a08: 0b0a0102     	add	w2, w8, w10
     a0c: 11000528     	add	w8, w9, #0x1
     a10: 7101fc5f     	cmp	w2, #0x7f
     a14: b90183e2     	str	w2, [sp, #0x180]
     a18: b9018268     	str	w8, [x19, #0x180]
     a1c: 52800d68     	mov	w8, #0x6b               // =107
     a20: 38296a68     	strb	w8, [x19, x9]
     a24: 54000062     	b.hs	0xa30 <header+0xa30>
     a28: 52800029     	mov	w9, #0x1                // =1
     a2c: 1400000f     	b	0xa68 <header+0xa68>
     a30: 5287ffe8     	mov	w8, #0x3fff             // =16383
     a34: 6b08005f     	cmp	w2, w8
     a38: 54000062     	b.hs	0xa44 <header+0xa44>
     a3c: 52800049     	mov	w9, #0x2                // =2
     a40: 1400000a     	b	0xa68 <header+0xa68>
     a44: 12bffc08     	mov	w8, #0x1fffff           // =2097151
     a48: 6b08005f     	cmp	w2, w8
     a4c: 54000062     	b.hs	0xa58 <header+0xa58>
     a50: 52800069     	mov	w9, #0x3                // =3
     a54: 14000005     	b	0xa68 <header+0xa68>
     a58: 12be0008     	mov	w8, #0xfffffff          // =268435455
     a5c: 6b08005f     	cmp	w2, w8
     a60: 52800088     	mov	w8, #0x4                // =4
     a64: 1a883509     	cinc	w9, w8, hs
     a68: 531d712a     	lsl	w10, w9, #3
     a6c: 52800028     	mov	w8, #0x1                // =1
     a70: 4b09014b     	sub	w11, w10, w9
     a74: 2a0903e9     	mov	w9, w9
     a78: 5100214a     	sub	w10, w10, #0x8
     a7c: 9acb2108     	lsl	x8, x8, x11
     a80: b941826b     	ldr	w11, [x19, #0x180]
     a84: aa020108     	orr	x8, x8, x2
     a88: 1100056c     	add	w12, w11, #0x1
     a8c: 9aca250d     	lsr	x13, x8, x10
     a90: d100052a     	sub	x10, x9, #0x1
     a94: b901826c     	str	w12, [x19, #0x180]
     a98: 382b6a6d     	strb	w13, [x19, x11]
     a9c: 3400046a     	cbz	w10, 0xb28 <header+0xb28>
     aa0: 531d714a     	lsl	w10, w10, #3
     aa4: b941826b     	ldr	w11, [x19, #0x180]
     aa8: 5100214a     	sub	w10, w10, #0x8
     aac: 1100056c     	add	w12, w11, #0x1
     ab0: 9aca250d     	lsr	x13, x8, x10
     ab4: d100092a     	sub	x10, x9, #0x2
     ab8: b901826c     	str	w12, [x19, #0x180]
     abc: 382b6a6d     	strb	w13, [x19, x11]
     ac0: 3400034a     	cbz	w10, 0xb28 <header+0xb28>
     ac4: 531d714a     	lsl	w10, w10, #3
     ac8: b941826b     	ldr	w11, [x19, #0x180]
     acc: 5100214a     	sub	w10, w10, #0x8
     ad0: 1100056c     	add	w12, w11, #0x1
     ad4: 9aca250d     	lsr	x13, x8, x10
     ad8: d1000d2a     	sub	x10, x9, #0x3
     adc: b901826c     	str	w12, [x19, #0x180]
     ae0: 382b6a6d     	strb	w13, [x19, x11]
     ae4: 3400022a     	cbz	w10, 0xb28 <header+0xb28>
     ae8: 531d714a     	lsl	w10, w10, #3
     aec: b941826b     	ldr	w11, [x19, #0x180]
     af0: d1001129     	sub	x9, x9, #0x4
     af4: 5100214a     	sub	w10, w10, #0x8
     af8: 1100056c     	add	w12, w11, #0x1
     afc: 9aca250a     	lsr	x10, x8, x10
     b00: b901826c     	str	w12, [x19, #0x180]
     b04: 382b6a6a     	strb	w10, [x19, x11]
     b08: 34000109     	cbz	w9, 0xb28 <header+0xb28>
     b0c: 531d7129     	lsl	w9, w9, #3
     b10: b941826a     	ldr	w10, [x19, #0x180]
     b14: 51002129     	sub	w9, w9, #0x8
     b18: 1100054b     	add	w11, w10, #0x1
     b1c: 9ac92508     	lsr	x8, x8, x9
     b20: b901826b     	str	w11, [x19, #0x180]
     b24: 382a6a68     	strb	w8, [x19, x10]
     b28: b9418268     	ldr	w8, [x19, #0x180]
     b2c: 910003e1     	mov	x1, sp
     b30: 8b080260     	add	x0, x19, x8
     b34: 94000000     	bl	0xb34 <header+0xb34>
		0000000000000b34:  R_AARCH64_CALL26	memcpy
     b38: b94183e8     	ldr	w8, [sp, #0x180]
     b3c: b9418269     	ldr	w9, [x19, #0x180]
     b40: 0b080128     	add	w8, w9, w8
     b44: b9018268     	str	w8, [x19, #0x180]
     b48: 911f43ff     	add	sp, sp, #0x7d0
     b4c: a9444ff4     	ldp	x20, x19, [sp, #0x40]
     b50: f9400bfc     	ldr	x28, [sp, #0x10]
     b54: a94357f6     	ldp	x22, x21, [sp, #0x30]
     b58: a9425ff8     	ldp	x24, x23, [sp, #0x20]
     b5c: a8c57bfd     	ldp	x29, x30, [sp], #0x50
     b60: d65f03c0     	ret

Disassembly of section .text.append:

0000000000000000 <append>:
       0: 34000362     	cbz	w2, 0x6c <append+0x6c>
       4: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
       8: f9000bf7     	str	x23, [sp, #0x10]
       c: a90257f6     	stp	x22, x21, [sp, #0x20]
      10: a9034ff4     	stp	x20, x19, [sp, #0x30]
      14: 910003fd     	mov	x29, sp
      18: 2a0203f4     	mov	w20, w2
      1c: aa0103f5     	mov	x21, x1
      20: aa0003f3     	mov	x19, x0
      24: 2a1f03f7     	mov	w23, wzr
      28: a9402260     	ldp	x0, x8, [x19]
      2c: 8b3742a1     	add	x1, x21, w23, uxtw
      30: 4b170296     	sub	w22, w20, w23
      34: 2a1603e2     	mov	w2, w22
      38: d63f0100     	blr	x8
      3c: 350001c0     	cbnz	w0, 0x74 <append+0x74>
      40: d1000428     	sub	x8, x1, #0x1
      44: eb36411f     	cmp	x8, w22, uxtw
      48: 54000222     	b.hs	0x8c <append+0x8c>
      4c: f9401e68     	ldr	x8, [x19, #0x38]
      50: 0b0102f7     	add	w23, w23, w1
      54: 6b1402ff     	cmp	w23, w20
      58: 8b010108     	add	x8, x8, x1
      5c: f9001e68     	str	x8, [x19, #0x38]
      60: 54fffe43     	b.lo	0x28 <append+0x28>
      64: 2a1f03e0     	mov	w0, wzr
      68: 1400000c     	b	0x98 <append+0x98>
      6c: 2a1f03e0     	mov	w0, wzr
      70: d65f03c0     	ret
      74: 7100041f     	cmp	w0, #0x1
      78: 52800068     	mov	w8, #0x3                // =3
      7c: 528000c9     	mov	w9, #0x6                // =6
      80: 1a880508     	cinc	w8, w8, ne
      84: 1a890520     	cinc	w0, w9, ne
      88: 14000003     	b	0x94 <append+0x94>
      8c: 52800068     	mov	w8, #0x3                // =3
      90: 528000c0     	mov	w0, #0x6                // =6
      94: b9001a68     	str	w8, [x19, #0x18]
      98: a9434ff4     	ldp	x20, x19, [sp, #0x30]
      9c: f9400bf7     	ldr	x23, [sp, #0x10]
      a0: a94257f6     	ldp	x22, x21, [sp, #0x20]
      a4: a8c47bfd     	ldp	x29, x30, [sp], #0x40
      a8: d65f03c0     	ret

Disassembly of section .text.iq4_mkv_packet:

0000000000000000 <iq4_mkv_packet>:
       0: b4000220     	cbz	x0, 0x44 <iq4_mkv_packet+0x44>
       4: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
       8: a9016ffc     	stp	x28, x27, [sp, #0x10]
       c: 910003fd     	mov	x29, sp
      10: a90267fa     	stp	x26, x25, [sp, #0x20]
      14: a9035ff8     	stp	x24, x23, [sp, #0x30]
      18: a90457f6     	stp	x22, x21, [sp, #0x40]
      1c: a9054ff4     	stp	x20, x19, [sp, #0x50]
      20: d11403ff     	sub	sp, sp, #0x500
      24: b9401808     	ldr	w8, [x0, #0x18]
      28: aa0003f3     	mov	x19, x0
      2c: 7100051f     	cmp	w8, #0x1
      30: 540000e0     	b.eq	0x4c <iq4_mkv_packet+0x4c>
      34: 7100111f     	cmp	w8, #0x4
      38: 54000441     	b.ne	0xc0 <iq4_mkv_packet+0xc0>
      3c: 528000e0     	mov	w0, #0x7                // =7
      40: 14000125     	b	0x4d4 <iq4_mkv_packet+0x4d4>
      44: 52800020     	mov	w0, #0x1                // =1
      48: d65f03c0     	ret
      4c: b4002401     	cbz	x1, 0x4cc <iq4_mkv_packet+0x4cc>
      50: 7100405f     	cmp	w2, #0x10
      54: 540023c3     	b.lo	0x4cc <iq4_mkv_packet+0x4cc>
      58: b40023a3     	cbz	x3, 0x4cc <iq4_mkv_packet+0x4cc>
      5c: b9402668     	ldr	w8, [x19, #0x24]
      60: 6b08005f     	cmp	w2, w8
      64: 54002348     	b.hi	0x4cc <iq4_mkv_packet+0x4cc>
      68: b9402e68     	ldr	w8, [x19, #0x2c]
      6c: 340000e8     	cbz	w8, 0x88 <iq4_mkv_packet+0x88>
      70: f9402e69     	ldr	x9, [x19, #0x58]
      74: eb09007f     	cmp	x3, x9
      78: 54000289     	b.ls	0xc8 <iq4_mkv_packet+0xc8>
      7c: f9403269     	ldr	x9, [x19, #0x60]
      80: eb09009f     	cmp	x4, x9
      84: 54000229     	b.ls	0xc8 <iq4_mkv_packet+0xc8>
      88: b9402a69     	ldr	w9, [x19, #0x28]
      8c: 6b09011f     	cmp	w8, w9
      90: 54000102     	b.hs	0xb0 <iq4_mkv_packet+0xb0>
      94: a9432269     	ldp	x9, x8, [x19, #0x30]
      98: eb080128     	subs	x8, x9, x8
      9c: 540000a3     	b.lo	0xb0 <iq4_mkv_packet+0xb0>
      a0: 2a0203f6     	mov	w22, w2
      a4: 910126c9     	add	x9, x22, #0x49
      a8: eb08013f     	cmp	x9, x8
      ac: 54000169     	b.ls	0xd8 <iq4_mkv_packet+0xd8>
      b0: 52800068     	mov	w8, #0x3                // =3
      b4: 528000a0     	mov	w0, #0x5                // =5
      b8: b9001a68     	str	w8, [x19, #0x18]
      bc: 14000106     	b	0x4d4 <iq4_mkv_packet+0x4d4>
      c0: 52800040     	mov	w0, #0x2                // =2
      c4: 14000104     	b	0x4d4 <iq4_mkv_packet+0x4d4>
      c8: 52800068     	mov	w8, #0x3                // =3
      cc: 52800080     	mov	w0, #0x4                // =4
      d0: b9001a68     	str	w8, [x19, #0x18]
      d4: 14000100     	b	0x4d4 <iq4_mkv_packet+0x4d4>
      d8: d10143a0     	sub	x0, x29, #0x50
      dc: 2a0203f4     	mov	w20, w2
      e0: aa0303f9     	mov	x25, x3
      e4: f90007e4     	str	x4, [sp, #0x8]
      e8: aa0103f7     	mov	x23, x1
      ec: 94000000     	bl	0xec <iq4_mkv_packet+0xec>
		00000000000000ec:  R_AARCH64_CALL26	f3_jpeg_syntax_init_02
      f0: d10143a0     	sub	x0, x29, #0x50
      f4: aa1703e1     	mov	x1, x23
      f8: aa1603e2     	mov	x2, x22
      fc: aa1703f5     	mov	x21, x23
     100: 94000000     	bl	0x100 <iq4_mkv_packet+0x100>
		0000000000000100:  R_AARCH64_CALL26	f3_jpeg_syntax_feed_02
     104: 34001e40     	cbz	w0, 0x4cc <iq4_mkv_packet+0x4cc>
     108: 29438a61     	ldp	w1, w2, [x19, #0x1c]
     10c: d10143a0     	sub	x0, x29, #0x50
     110: 94000000     	bl	0x110 <iq4_mkv_packet+0x110>
		0000000000000110:  R_AARCH64_CALL26	f3_jpeg_syntax_done_02
     114: 34001dc0     	cbz	w0, 0x4cc <iq4_mkv_packet+0x4cc>
     118: b9402e69     	ldr	w9, [x19, #0x2c]
     11c: aa1303f7     	mov	x23, x19
     120: 910cb3e8     	add	x8, sp, #0x32c
     124: aa1903fc     	mov	x28, x25
     128: aa1903eb     	mov	x11, x25
     12c: 34000049     	cbz	w9, 0x134 <iq4_mkv_packet+0x134>
     130: f9402aeb     	ldr	x11, [x23, #0x50]
     134: 6f00e400     	movi	v0.2d, #0000000000000000
     138: 910cb3fb     	add	x27, sp, #0x32c
     13c: 52800038     	mov	w24, #0x1               // =1
     140: 91003369     	add	x9, x27, #0xc
     144: cb0b0383     	sub	x3, x28, x11
     148: 910cb3e0     	add	x0, sp, #0x32c
     14c: 52801ce1     	mov	w1, #0xe7               // =231
     150: 52800022     	mov	w2, #0x1                // =1
     154: 52800104     	mov	w4, #0x8                // =8
     158: f90003eb     	str	x11, [sp]
     15c: 3c8fc100     	stur	q0, [x8, #0xfc]
     160: 3c8ec100     	stur	q0, [x8, #0xec]
     164: 3c8dc100     	stur	q0, [x8, #0xdc]
     168: 3c8cc100     	stur	q0, [x8, #0xcc]
     16c: 3c8bc100     	stur	q0, [x8, #0xbc]
     170: 3c8ac100     	stur	q0, [x8, #0xac]
     174: 3c89c100     	stur	q0, [x8, #0x9c]
     178: 3c88c100     	stur	q0, [x8, #0x8c]
     17c: 3c87c100     	stur	q0, [x8, #0x7c]
     180: 3c86c100     	stur	q0, [x8, #0x6c]
     184: 3c85c100     	stur	q0, [x8, #0x5c]
     188: 3c84c100     	stur	q0, [x8, #0x4c]
     18c: 3c83c100     	stur	q0, [x8, #0x3c]
     190: 3c82c100     	stur	q0, [x8, #0x2c]
     194: 3c81c100     	stur	q0, [x8, #0x1c]
     198: 3c80c100     	stur	q0, [x8, #0xc]
     19c: d2800088     	mov	x8, #0x4                // =4
     1a0: f2e02008     	movk	x8, #0x100, lsl #48
     1a4: ad088120     	stp	q0, q0, [x9, #0x110]
     1a8: 8b0802da     	add	x26, x22, x8
     1ac: ad098120     	stp	q0, q0, [x9, #0x130]
     1b0: ad0a8120     	stp	q0, q0, [x9, #0x150]
     1b4: 9100e748     	add	x8, x26, #0x39
     1b8: 3d804120     	str	q0, [x9, #0x100]
     1bc: 90000009     	adrp	x9, 0x0 <iq4_mkv_packet>
		00000000000001bc:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8
     1c0: d358fd0a     	lsr	x10, x8, #24
     1c4: ad0083e0     	stp	q0, q0, [sp, #0x10]
     1c8: ad0183e0     	stp	q0, q0, [sp, #0x30]
     1cc: ad0283e0     	stp	q0, q0, [sp, #0x50]
     1d0: ad0383e0     	stp	q0, q0, [sp, #0x70]
     1d4: ad0483e0     	stp	q0, q0, [sp, #0x90]
     1d8: ad0583e0     	stp	q0, q0, [sp, #0xb0]
     1dc: ad0683e0     	stp	q0, q0, [sp, #0xd0]
     1e0: ad0783e0     	stp	q0, q0, [sp, #0xf0]
     1e4: ad0883e0     	stp	q0, q0, [sp, #0x110]
     1e8: ad0983e0     	stp	q0, q0, [sp, #0x130]
     1ec: ad0a83e0     	stp	q0, q0, [sp, #0x150]
     1f0: ad0b83e0     	stp	q0, q0, [sp, #0x170]
     1f4: ad0d03e0     	stp	q0, q0, [sp, #0x1a0]
     1f8: ad0e03e0     	stp	q0, q0, [sp, #0x1c0]
     1fc: ad0f03e0     	stp	q0, q0, [sp, #0x1e0]
     200: ad1003e0     	stp	q0, q0, [sp, #0x200]
     204: ad1103e0     	stp	q0, q0, [sp, #0x220]
     208: ad1203e0     	stp	q0, q0, [sp, #0x240]
     20c: ad1303e0     	stp	q0, q0, [sp, #0x260]
     210: ad1403e0     	stp	q0, q0, [sp, #0x280]
     214: ad1503e0     	stp	q0, q0, [sp, #0x2a0]
     218: ad1603e0     	stp	q0, q0, [sp, #0x2c0]
     21c: ad1703e0     	stp	q0, q0, [sp, #0x2e0]
     220: ad1803e0     	stp	q0, q0, [sp, #0x300]
     224: fd400120     	ldr	d0, [x9]
		0000000000000224:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8
     228: d360fd09     	lsr	x9, x8, #32
     22c: b904abff     	str	wzr, [sp, #0x4a8]
     230: 390ccfe9     	strb	w9, [sp, #0x333]
     234: d350fd09     	lsr	x9, x8, #16
     238: b90323ff     	str	wzr, [sp, #0x320]
     23c: 390cd7e9     	strb	w9, [sp, #0x335]
     240: d348fd09     	lsr	x9, x8, #8
     244: b90193ff     	str	wzr, [sp, #0x190]
     248: 390cdbe9     	strb	w9, [sp, #0x336]
     24c: 52800189     	mov	w9, #0xc                // =12
     250: bd032fe0     	str	s0, [sp, #0x32c]
     254: 390cd3ea     	strb	w10, [sp, #0x334]
     258: 790663f8     	strh	w24, [sp, #0x330]
     25c: 390ccbff     	strb	wzr, [sp, #0x332]
     260: b904afe9     	str	w9, [sp, #0x4ac]
     264: 390cdfe8     	strb	w8, [sp, #0x337]
     268: 94000000     	bl	0x268 <iq4_mkv_packet+0x268>
		0000000000000268:  R_AARCH64_CALL26	.text.uint_elem
     26c: b944afe8     	ldr	w8, [sp, #0x4ac]
     270: d360ff4a     	lsr	x10, x26, #32
     274: 90000001     	adrp	x1, 0x0 <iq4_mkv_packet>
		0000000000000274:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x9
     278: 91000021     	add	x1, x1, #0x0
		0000000000000278:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x9
     27c: 910683e0     	add	x0, sp, #0x1a0
     280: 52800082     	mov	w2, #0x4                // =4
     284: 11000509     	add	w9, w8, #0x1
     288: b904afe9     	str	w9, [sp, #0x4ac]
     28c: 52801469     	mov	w9, #0xa3               // =163
     290: 38286b69     	strb	w9, [x27, x8]
     294: b944afe8     	ldr	w8, [sp, #0x4ac]
     298: 11000509     	add	w9, w8, #0x1
     29c: b904afe9     	str	w9, [sp, #0x4ac]
     2a0: 38286b78     	strb	w24, [x27, x8]
     2a4: b944afe8     	ldr	w8, [sp, #0x4ac]
     2a8: 11000509     	add	w9, w8, #0x1
     2ac: b904afe9     	str	w9, [sp, #0x4ac]
     2b0: 38286b7f     	strb	wzr, [x27, x8]
     2b4: b944afe8     	ldr	w8, [sp, #0x4ac]
     2b8: 11000509     	add	w9, w8, #0x1
     2bc: b904afe9     	str	w9, [sp, #0x4ac]
     2c0: 38286b7f     	strb	wzr, [x27, x8]
     2c4: b944afe8     	ldr	w8, [sp, #0x4ac]
     2c8: 11000509     	add	w9, w8, #0x1
     2cc: b904afe9     	str	w9, [sp, #0x4ac]
     2d0: 38286b6a     	strb	w10, [x27, x8]
     2d4: d358ff4a     	lsr	x10, x26, #24
     2d8: b944afe8     	ldr	w8, [sp, #0x4ac]
     2dc: 11000509     	add	w9, w8, #0x1
     2e0: b904afe9     	str	w9, [sp, #0x4ac]
     2e4: 38286b6a     	strb	w10, [x27, x8]
     2e8: d350ff4a     	lsr	x10, x26, #16
     2ec: b944afe8     	ldr	w8, [sp, #0x4ac]
     2f0: 11000509     	add	w9, w8, #0x1
     2f4: b904afe9     	str	w9, [sp, #0x4ac]
     2f8: 38286b6a     	strb	w10, [x27, x8]
     2fc: d348ff4a     	lsr	x10, x26, #8
     300: b944afe8     	ldr	w8, [sp, #0x4ac]
     304: 11000509     	add	w9, w8, #0x1
     308: b904afe9     	str	w9, [sp, #0x4ac]
     30c: 38286b6a     	strb	w10, [x27, x8]
     310: b944afe8     	ldr	w8, [sp, #0x4ac]
     314: 11000509     	add	w9, w8, #0x1
     318: b904afe9     	str	w9, [sp, #0x4ac]
     31c: 38286b7a     	strb	w26, [x27, x8]
     320: b944afe8     	ldr	w8, [sp, #0x4ac]
     324: 11000509     	add	w9, w8, #0x1
     328: b904afe9     	str	w9, [sp, #0x4ac]
     32c: 52801029     	mov	w9, #0x81               // =129
     330: 38286b69     	strb	w9, [x27, x8]
     334: b944afe8     	ldr	w8, [sp, #0x4ac]
     338: 11000509     	add	w9, w8, #0x1
     33c: b904afe9     	str	w9, [sp, #0x4ac]
     340: 38286b7f     	strb	wzr, [x27, x8]
     344: b944afe8     	ldr	w8, [sp, #0x4ac]
     348: 11000509     	add	w9, w8, #0x1
     34c: b904afe9     	str	w9, [sp, #0x4ac]
     350: 38286b7f     	strb	wzr, [x27, x8]
     354: b944afe8     	ldr	w8, [sp, #0x4ac]
     358: 11000509     	add	w9, w8, #0x1
     35c: b904afe9     	str	w9, [sp, #0x4ac]
     360: 52801009     	mov	w9, #0x80               // =128
     364: 38286b69     	strb	w9, [x27, x8]
     368: 94000000     	bl	0x368 <iq4_mkv_packet+0x368>
		0000000000000368:  R_AARCH64_CALL26	memcpy
     36c: d348ff88     	lsr	x8, x28, #8
     370: d350ff89     	lsr	x9, x28, #16
     374: 0f000440     	movi	v0.2s, #0x2
     378: 12800000     	mov	w0, #-0x1               // =-1
     37c: aa1503e1     	mov	x1, x21
     380: aa1603e2     	mov	x2, x22
     384: 3906a7e8     	strb	w8, [sp, #0x1a9]
     388: d358ff88     	lsr	x8, x28, #24
     38c: 3906abe9     	strb	w9, [sp, #0x1aa]
     390: d360ff89     	lsr	x9, x28, #32
     394: 3906afe8     	strb	w8, [sp, #0x1ab]
     398: d368ff88     	lsr	x8, x28, #40
     39c: 3906b3e9     	strb	w9, [sp, #0x1ac]
     3a0: d370ff89     	lsr	x9, x28, #48
     3a4: 3906b7e8     	strb	w8, [sp, #0x1ad]
     3a8: d378ff88     	lsr	x8, x28, #56
     3ac: 3906bbe9     	strb	w9, [sp, #0x1ae]
     3b0: 3906bfe8     	strb	w8, [sp, #0x1af]
     3b4: f94007e8     	ldr	x8, [sp, #0x8]
     3b8: 3906a3fc     	strb	w28, [sp, #0x1a8]
     3bc: d348fd09     	lsr	x9, x8, #8
     3c0: d350fd0a     	lsr	x10, x8, #16
     3c4: 3906c3e8     	strb	w8, [sp, #0x1b0]
     3c8: bd01a7e0     	str	s0, [sp, #0x1a4]
     3cc: 3906c7e9     	strb	w9, [sp, #0x1b1]
     3d0: d358fd09     	lsr	x9, x8, #24
     3d4: 3906cbea     	strb	w10, [sp, #0x1b2]
     3d8: d360fd0a     	lsr	x10, x8, #32
     3dc: 3906cfe9     	strb	w9, [sp, #0x1b3]
     3e0: d368fd09     	lsr	x9, x8, #40
     3e4: 3906d3ea     	strb	w10, [sp, #0x1b4]
     3e8: d370fd0a     	lsr	x10, x8, #48
     3ec: d378fd08     	lsr	x8, x8, #56
     3f0: 3906d7e9     	strb	w9, [sp, #0x1b5]
     3f4: d350fec9     	lsr	x9, x22, #16
     3f8: 3906dfe8     	strb	w8, [sp, #0x1b7]
     3fc: d348fec8     	lsr	x8, x22, #8
     400: 3906fbe9     	strb	w9, [sp, #0x1be]
     404: 52800409     	mov	w9, #0x20               // =32
     408: 3906f7e8     	strb	w8, [sp, #0x1bd]
     40c: d358fec8     	lsr	x8, x22, #24
     410: 3906dbea     	strb	w10, [sp, #0x1b6]
     414: bd01bbe0     	str	s0, [sp, #0x1b8]
     418: 3906f3f4     	strb	w20, [sp, #0x1bc]
     41c: b90323e9     	str	w9, [sp, #0x320]
     420: 3906ffe8     	strb	w8, [sp, #0x1bf]
     424: 94000000     	bl	0x424 <iq4_mkv_packet+0x424>
		0000000000000424:  R_AARCH64_CALL26	.text.crc
     428: 910683e1     	add	x1, sp, #0x1a0
     42c: 52800402     	mov	w2, #0x20               // =32
     430: 94000000     	bl	0x430 <iq4_mkv_packet+0x430>
		0000000000000430:  R_AARCH64_CALL26	.text.crc
     434: 52800488     	mov	w8, #0x24               // =36
     438: 2a2003e9     	mvn	w9, w0
     43c: 910043e0     	add	x0, sp, #0x10
     440: b90323e8     	str	w8, [sp, #0x320]
     444: d348fd28     	lsr	x8, x9, #8
     448: d350fd2a     	lsr	x10, x9, #16
     44c: 390703e9     	strb	w9, [sp, #0x1c0]
     450: d358fd29     	lsr	x9, x9, #24
     454: 910683e3     	add	x3, sp, #0x1a0
     458: 52801d81     	mov	w1, #0xec               // =236
     45c: 52800022     	mov	w2, #0x1                // =1
     460: 390707e8     	strb	w8, [sp, #0x1c1]
     464: 39070bea     	strb	w10, [sp, #0x1c2]
     468: 39070fe9     	strb	w9, [sp, #0x1c3]
     46c: 94000000     	bl	0x46c <iq4_mkv_packet+0x46c>
		000000000000046c:  R_AARCH64_CALL26	.text.elem
     470: b944afe2     	ldr	w2, [sp, #0x4ac]
     474: 910cb3e1     	add	x1, sp, #0x32c
     478: aa1703e0     	mov	x0, x23
     47c: 94000000     	bl	0x47c <iq4_mkv_packet+0x47c>
		000000000000047c:  R_AARCH64_CALL26	.text.append
     480: 350002a0     	cbnz	w0, 0x4d4 <iq4_mkv_packet+0x4d4>
     484: f94003f6     	ldr	x22, [sp]
     488: aa1303e0     	mov	x0, x19
     48c: aa1503e1     	mov	x1, x21
     490: 2a1403e2     	mov	w2, w20
     494: 94000000     	bl	0x494 <iq4_mkv_packet+0x494>
		0000000000000494:  R_AARCH64_CALL26	.text.append
     498: 350001e0     	cbnz	w0, 0x4d4 <iq4_mkv_packet+0x4d4>
     49c: b94193e2     	ldr	w2, [sp, #0x190]
     4a0: 910043e1     	add	x1, sp, #0x10
     4a4: aa1303e0     	mov	x0, x19
     4a8: 94000000     	bl	0x4a8 <iq4_mkv_packet+0x4a8>
		00000000000004a8:  R_AARCH64_CALL26	.text.append
     4ac: 35000140     	cbnz	w0, 0x4d4 <iq4_mkv_packet+0x4d4>
     4b0: b9402e69     	ldr	w9, [x19, #0x2c]
     4b4: f94007e8     	ldr	x8, [sp, #0x8]
     4b8: a9056676     	stp	x22, x25, [x19, #0x50]
     4bc: f9003268     	str	x8, [x19, #0x60]
     4c0: 11000528     	add	w8, w9, #0x1
     4c4: b9002e68     	str	w8, [x19, #0x2c]
     4c8: 14000003     	b	0x4d4 <iq4_mkv_packet+0x4d4>
     4cc: 52800060     	mov	w0, #0x3                // =3
     4d0: b9001a60     	str	w0, [x19, #0x18]
     4d4: 911403ff     	add	sp, sp, #0x500
     4d8: a9454ff4     	ldp	x20, x19, [sp, #0x50]
     4dc: a94457f6     	ldp	x22, x21, [sp, #0x40]
     4e0: a9435ff8     	ldp	x24, x23, [sp, #0x30]
     4e4: a94267fa     	ldp	x26, x25, [sp, #0x20]
     4e8: a9416ffc     	ldp	x28, x27, [sp, #0x10]
     4ec: a8c67bfd     	ldp	x29, x30, [sp], #0x60
     4f0: d65f03c0     	ret

Disassembly of section .text.uint_elem:

0000000000000000 <uint_elem>:
       0: d106c3ff     	sub	sp, sp, #0x1b0
       4: a9197bfd     	stp	x29, x30, [sp, #0x190]
       8: a91a4ffc     	stp	x28, x19, [sp, #0x1a0]
       c: 910643fd     	add	x29, sp, #0x190
      10: b90183ff     	str	wzr, [sp, #0x180]
      14: 531d7088     	lsl	w8, w4, #3
      18: 6f00e400     	movi	v0.2d, #0000000000000000
      1c: b94183eb     	ldr	w11, [sp, #0x180]
      20: aa0003f3     	mov	x19, x0
      24: 51002109     	sub	w9, w8, #0x8
      28: 2a0403e8     	mov	w8, w4
      2c: 9ac9246c     	lsr	x12, x3, x9
      30: 11000569     	add	w9, w11, #0x1
      34: d100050a     	sub	x10, x8, #0x1
      38: b90183e9     	str	w9, [sp, #0x180]
      3c: 910003e9     	mov	x9, sp
      40: ad0003e0     	stp	q0, q0, [sp]
      44: ad0103e0     	stp	q0, q0, [sp, #0x20]
      48: ad0203e0     	stp	q0, q0, [sp, #0x40]
      4c: ad0303e0     	stp	q0, q0, [sp, #0x60]
      50: ad0403e0     	stp	q0, q0, [sp, #0x80]
      54: ad0503e0     	stp	q0, q0, [sp, #0xa0]
      58: ad0603e0     	stp	q0, q0, [sp, #0xc0]
      5c: ad0703e0     	stp	q0, q0, [sp, #0xe0]
      60: ad0803e0     	stp	q0, q0, [sp, #0x100]
      64: ad0903e0     	stp	q0, q0, [sp, #0x120]
      68: ad0a03e0     	stp	q0, q0, [sp, #0x140]
      6c: ad0b03e0     	stp	q0, q0, [sp, #0x160]
      70: 382b692c     	strb	w12, [x9, x11]
      74: 3400082a     	cbz	w10, 0x178 <uint_elem+0x178>
      78: 531d714a     	lsl	w10, w10, #3
      7c: b94183eb     	ldr	w11, [sp, #0x180]
      80: 5100214a     	sub	w10, w10, #0x8
      84: 1100056c     	add	w12, w11, #0x1
      88: 9aca246d     	lsr	x13, x3, x10
      8c: d100090a     	sub	x10, x8, #0x2
      90: b90183ec     	str	w12, [sp, #0x180]
      94: 382b692d     	strb	w13, [x9, x11]
      98: 3400070a     	cbz	w10, 0x178 <uint_elem+0x178>
      9c: 531d7149     	lsl	w9, w10, #3
      a0: b94183eb     	ldr	w11, [sp, #0x180]
      a4: 51002129     	sub	w9, w9, #0x8
      a8: 1100056a     	add	w10, w11, #0x1
      ac: 9ac9246c     	lsr	x12, x3, x9
      b0: b90183ea     	str	w10, [sp, #0x180]
      b4: 910003e9     	mov	x9, sp
      b8: d1000d0a     	sub	x10, x8, #0x3
      bc: 382b692c     	strb	w12, [x9, x11]
      c0: 340005ca     	cbz	w10, 0x178 <uint_elem+0x178>
      c4: 531d714a     	lsl	w10, w10, #3
      c8: b94183eb     	ldr	w11, [sp, #0x180]
      cc: 5100214a     	sub	w10, w10, #0x8
      d0: 1100056c     	add	w12, w11, #0x1
      d4: 9aca246d     	lsr	x13, x3, x10
      d8: d100110a     	sub	x10, x8, #0x4
      dc: b90183ec     	str	w12, [sp, #0x180]
      e0: 382b692d     	strb	w13, [x9, x11]
      e4: 340004aa     	cbz	w10, 0x178 <uint_elem+0x178>
      e8: 531d7149     	lsl	w9, w10, #3
      ec: b94183eb     	ldr	w11, [sp, #0x180]
      f0: 51002129     	sub	w9, w9, #0x8
      f4: 1100056a     	add	w10, w11, #0x1
      f8: 9ac9246c     	lsr	x12, x3, x9
      fc: b90183ea     	str	w10, [sp, #0x180]
     100: 910003e9     	mov	x9, sp
     104: d100150a     	sub	x10, x8, #0x5
     108: 382b692c     	strb	w12, [x9, x11]
     10c: 3400036a     	cbz	w10, 0x178 <uint_elem+0x178>
     110: 531d714a     	lsl	w10, w10, #3
     114: b94183eb     	ldr	w11, [sp, #0x180]
     118: 5100214a     	sub	w10, w10, #0x8
     11c: 1100056c     	add	w12, w11, #0x1
     120: 9aca246d     	lsr	x13, x3, x10
     124: d100190a     	sub	x10, x8, #0x6
     128: b90183ec     	str	w12, [sp, #0x180]
     12c: 382b692d     	strb	w13, [x9, x11]
     130: 3400024a     	cbz	w10, 0x178 <uint_elem+0x178>
     134: 531d7149     	lsl	w9, w10, #3
     138: b94183ea     	ldr	w10, [sp, #0x180]
     13c: d1001d08     	sub	x8, x8, #0x7
     140: 51002129     	sub	w9, w9, #0x8
     144: 1100054b     	add	w11, w10, #0x1
     148: 9ac9246c     	lsr	x12, x3, x9
     14c: 910003e9     	mov	x9, sp
     150: b90183eb     	str	w11, [sp, #0x180]
     154: 382a692c     	strb	w12, [x9, x10]
     158: 34000108     	cbz	w8, 0x178 <uint_elem+0x178>
     15c: 531d7108     	lsl	w8, w8, #3
     160: b94183ea     	ldr	w10, [sp, #0x180]
     164: 51002108     	sub	w8, w8, #0x8
     168: 1100054b     	add	w11, w10, #0x1
     16c: 9ac82468     	lsr	x8, x3, x8
     170: b90183eb     	str	w11, [sp, #0x180]
     174: 382a6928     	strb	w8, [x9, x10]
     178: 531d704a     	lsl	w10, w2, #3
     17c: b941826b     	ldr	w11, [x19, #0x180]
     180: 2a0103e8     	mov	w8, w1
     184: 2a0203e9     	mov	w9, w2
     188: 5100214a     	sub	w10, w10, #0x8
     18c: 1100056c     	add	w12, w11, #0x1
     190: 9aca250d     	lsr	x13, x8, x10
     194: d100052a     	sub	x10, x9, #0x1
     198: b901826c     	str	w12, [x19, #0x180]
     19c: 382b6a6d     	strb	w13, [x19, x11]
     1a0: 3400022a     	cbz	w10, 0x1e4 <uint_elem+0x1e4>
     1a4: 531d714a     	lsl	w10, w10, #3
     1a8: b941826b     	ldr	w11, [x19, #0x180]
     1ac: d1000929     	sub	x9, x9, #0x2
     1b0: 5100214a     	sub	w10, w10, #0x8
     1b4: 1100056c     	add	w12, w11, #0x1
     1b8: 9aca250a     	lsr	x10, x8, x10
     1bc: b901826c     	str	w12, [x19, #0x180]
     1c0: 382b6a6a     	strb	w10, [x19, x11]
     1c4: 34000109     	cbz	w9, 0x1e4 <uint_elem+0x1e4>
     1c8: 531d7129     	lsl	w9, w9, #3
     1cc: b941826a     	ldr	w10, [x19, #0x180]
     1d0: 51002129     	sub	w9, w9, #0x8
     1d4: 1100054b     	add	w11, w10, #0x1
     1d8: 9ac92508     	lsr	x8, x8, x9
     1dc: b901826b     	str	w11, [x19, #0x180]
     1e0: 382a6a68     	strb	w8, [x19, x10]
     1e4: b94183e2     	ldr	w2, [sp, #0x180]
     1e8: 7101fc5f     	cmp	w2, #0x7f
     1ec: 54000062     	b.hs	0x1f8 <uint_elem+0x1f8>
     1f0: 52800029     	mov	w9, #0x1                // =1
     1f4: 1400000f     	b	0x230 <uint_elem+0x230>
     1f8: 5287ffe8     	mov	w8, #0x3fff             // =16383
     1fc: 6b08005f     	cmp	w2, w8
     200: 54000062     	b.hs	0x20c <uint_elem+0x20c>
     204: 52800049     	mov	w9, #0x2                // =2
     208: 1400000a     	b	0x230 <uint_elem+0x230>
     20c: 12bffc08     	mov	w8, #0x1fffff           // =2097151
     210: 6b08005f     	cmp	w2, w8
     214: 54000062     	b.hs	0x220 <uint_elem+0x220>
     218: 52800069     	mov	w9, #0x3                // =3
     21c: 14000005     	b	0x230 <uint_elem+0x230>
     220: 12be0008     	mov	w8, #0xfffffff          // =268435455
     224: 6b08005f     	cmp	w2, w8
     228: 52800088     	mov	w8, #0x4                // =4
     22c: 1a883509     	cinc	w9, w8, hs
     230: 531d712a     	lsl	w10, w9, #3
     234: 52800028     	mov	w8, #0x1                // =1
     238: 4b09014b     	sub	w11, w10, w9
     23c: 2a0903e9     	mov	w9, w9
     240: 5100214a     	sub	w10, w10, #0x8
     244: 9acb2108     	lsl	x8, x8, x11
     248: b941826b     	ldr	w11, [x19, #0x180]
     24c: aa020108     	orr	x8, x8, x2
     250: 1100056c     	add	w12, w11, #0x1
     254: 9aca250d     	lsr	x13, x8, x10
     258: d100052a     	sub	x10, x9, #0x1
     25c: b901826c     	str	w12, [x19, #0x180]
     260: 382b6a6d     	strb	w13, [x19, x11]
     264: 3400046a     	cbz	w10, 0x2f0 <uint_elem+0x2f0>
     268: 531d714a     	lsl	w10, w10, #3
     26c: b941826b     	ldr	w11, [x19, #0x180]
     270: 5100214a     	sub	w10, w10, #0x8
     274: 1100056c     	add	w12, w11, #0x1
     278: 9aca250d     	lsr	x13, x8, x10
     27c: d100092a     	sub	x10, x9, #0x2
     280: b901826c     	str	w12, [x19, #0x180]
     284: 382b6a6d     	strb	w13, [x19, x11]
     288: 3400034a     	cbz	w10, 0x2f0 <uint_elem+0x2f0>
     28c: 531d714a     	lsl	w10, w10, #3
     290: b941826b     	ldr	w11, [x19, #0x180]
     294: 5100214a     	sub	w10, w10, #0x8
     298: 1100056c     	add	w12, w11, #0x1
     29c: 9aca250d     	lsr	x13, x8, x10
     2a0: d1000d2a     	sub	x10, x9, #0x3
     2a4: b901826c     	str	w12, [x19, #0x180]
     2a8: 382b6a6d     	strb	w13, [x19, x11]
     2ac: 3400022a     	cbz	w10, 0x2f0 <uint_elem+0x2f0>
     2b0: 531d714a     	lsl	w10, w10, #3
     2b4: b941826b     	ldr	w11, [x19, #0x180]
     2b8: d1001129     	sub	x9, x9, #0x4
     2bc: 5100214a     	sub	w10, w10, #0x8
     2c0: 1100056c     	add	w12, w11, #0x1
     2c4: 9aca250a     	lsr	x10, x8, x10
     2c8: b901826c     	str	w12, [x19, #0x180]
     2cc: 382b6a6a     	strb	w10, [x19, x11]
     2d0: 34000109     	cbz	w9, 0x2f0 <uint_elem+0x2f0>
     2d4: 531d7129     	lsl	w9, w9, #3
     2d8: b941826a     	ldr	w10, [x19, #0x180]
     2dc: 51002129     	sub	w9, w9, #0x8
     2e0: 1100054b     	add	w11, w10, #0x1
     2e4: 9ac92508     	lsr	x8, x8, x9
     2e8: b901826b     	str	w11, [x19, #0x180]
     2ec: 382a6a68     	strb	w8, [x19, x10]
     2f0: b9418268     	ldr	w8, [x19, #0x180]
     2f4: 910003e1     	mov	x1, sp
     2f8: 8b080260     	add	x0, x19, x8
     2fc: 94000000     	bl	0x2fc <uint_elem+0x2fc>
		00000000000002fc:  R_AARCH64_CALL26	memcpy
     300: b94183e8     	ldr	w8, [sp, #0x180]
     304: b9418269     	ldr	w9, [x19, #0x180]
     308: a9597bfd     	ldp	x29, x30, [sp, #0x190]
     30c: 0b080128     	add	w8, w9, w8
     310: b9018268     	str	w8, [x19, #0x180]
     314: a95a4ffc     	ldp	x28, x19, [sp, #0x1a0]
     318: 9106c3ff     	add	sp, sp, #0x1b0
     31c: d65f03c0     	ret

Disassembly of section .text.crc:

0000000000000000 <crc>:
       0: 90000008     	adrp	x8, 0x0 <crc>
		0000000000000000:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst16+0x10
       4: 90000009     	adrp	x9, 0x0 <crc>
		0000000000000004:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst16
       8: 3dc00100     	ldr	q0, [x8]
		0000000000000008:  R_AARCH64_LDST128_ABS_LO12_NC	.rodata.cst16+0x10
       c: 3dc00121     	ldr	q1, [x9]
		000000000000000c:  R_AARCH64_LDST128_ABS_LO12_NC	.rodata.cst16
      10: 52906408     	mov	w8, #0x8320             // =33568
      14: 52883209     	mov	w9, #0x4190             // =16784
      18: 72bdb708     	movk	w8, #0xedb8, lsl #16
      1c: 72aedb89     	movk	w9, #0x76dc, lsl #16
      20: 3840142a     	ldrb	w10, [x1], #0x1
      24: f1000442     	subs	x2, x2, #0x1
      28: 4a0a000a     	eor	w10, w0, w10
      2c: 4e040d42     	dup	v2.4s, w10
      30: 1300014b     	sbfx	w11, w10, #0, #1
      34: 5302054c     	lsl	w12, w10, #30
      38: 0a08016b     	and	w11, w11, w8
      3c: 4e201c42     	and	v2.16b, v2.16b, v0.16b
      40: 4a4a056a     	eor	w10, w11, w10, lsr #1
      44: 0a8c7d0b     	and	w11, w8, w12, asr #31
      48: 4a4a056b     	eor	w11, w11, w10, lsr #1
      4c: 5306154a     	lsl	w10, w10, #26
      50: 4ea09842     	cmeq	v2.4s, v2.4s, #0
      54: 5306156c     	lsl	w12, w11, #26
      58: 0a8a7d2a     	and	w10, w9, w10, asr #31
      5c: 4e621c22     	bic	v2.16b, v1.16b, v2.16b
      60: 0a8c7d0c     	and	w12, w8, w12, asr #31
      64: 4a4b198b     	eor	w11, w12, w11, lsr #6
      68: 6e024043     	ext	v3.16b, v2.16b, v2.16b, #0x8
      6c: 2e231c42     	eor	v2.8b, v2.8b, v3.8b
      70: 9e66004d     	fmov	x13, d2
      74: d360fdac     	lsr	x12, x13, #32
      78: 4a0a01aa     	eor	w10, w13, w10
      7c: 4a0b014a     	eor	w10, w10, w11
      80: 4a0c0140     	eor	w0, w10, w12
      84: 54fffce1     	b.ne	0x20 <crc+0x20>
      88: d65f03c0     	ret

Disassembly of section .text.elem:

0000000000000000 <elem>:
       0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
       4: a9014ff4     	stp	x20, x19, [sp, #0x10]
       8: 910003fd     	mov	x29, sp
       c: 531d704a     	lsl	w10, w2, #3
      10: b941800b     	ldr	w11, [x0, #0x180]
      14: 2a0103e8     	mov	w8, w1
      18: 2a0203e9     	mov	w9, w2
      1c: aa0303f4     	mov	x20, x3
      20: aa0003f3     	mov	x19, x0
      24: 5100214a     	sub	w10, w10, #0x8
      28: 1100056c     	add	w12, w11, #0x1
      2c: 9aca250d     	lsr	x13, x8, x10
      30: d100052a     	sub	x10, x9, #0x1
      34: b901800c     	str	w12, [x0, #0x180]
      38: 382b680d     	strb	w13, [x0, x11]
      3c: 3400034a     	cbz	w10, 0xa4 <elem+0xa4>
      40: 531d714a     	lsl	w10, w10, #3
      44: b941826b     	ldr	w11, [x19, #0x180]
      48: 5100214a     	sub	w10, w10, #0x8
      4c: 1100056c     	add	w12, w11, #0x1
      50: 9aca250d     	lsr	x13, x8, x10
      54: d100092a     	sub	x10, x9, #0x2
      58: b901826c     	str	w12, [x19, #0x180]
      5c: 382b6a6d     	strb	w13, [x19, x11]
      60: 3400022a     	cbz	w10, 0xa4 <elem+0xa4>
      64: 531d714a     	lsl	w10, w10, #3
      68: b941826b     	ldr	w11, [x19, #0x180]
      6c: d1000d29     	sub	x9, x9, #0x3
      70: 5100214a     	sub	w10, w10, #0x8
      74: 1100056c     	add	w12, w11, #0x1
      78: 9aca250a     	lsr	x10, x8, x10
      7c: b901826c     	str	w12, [x19, #0x180]
      80: 382b6a6a     	strb	w10, [x19, x11]
      84: 34000109     	cbz	w9, 0xa4 <elem+0xa4>
      88: 531d7129     	lsl	w9, w9, #3
      8c: b941826a     	ldr	w10, [x19, #0x180]
      90: 51002129     	sub	w9, w9, #0x8
      94: 1100054b     	add	w11, w10, #0x1
      98: 9ac92508     	lsr	x8, x8, x9
      9c: b901826b     	str	w11, [x19, #0x180]
      a0: 382a6a68     	strb	w8, [x19, x10]
      a4: b9418288     	ldr	w8, [x20, #0x180]
      a8: 7101fd1f     	cmp	w8, #0x7f
      ac: 54000062     	b.hs	0xb8 <elem+0xb8>
      b0: 52800029     	mov	w9, #0x1                // =1
      b4: 1400000f     	b	0xf0 <elem+0xf0>
      b8: 5287ffe9     	mov	w9, #0x3fff             // =16383
      bc: 6b09011f     	cmp	w8, w9
      c0: 54000062     	b.hs	0xcc <elem+0xcc>
      c4: 52800049     	mov	w9, #0x2                // =2
      c8: 1400000a     	b	0xf0 <elem+0xf0>
      cc: 12bffc09     	mov	w9, #0x1fffff           // =2097151
      d0: 6b09011f     	cmp	w8, w9
      d4: 54000062     	b.hs	0xe0 <elem+0xe0>
      d8: 52800069     	mov	w9, #0x3                // =3
      dc: 14000005     	b	0xf0 <elem+0xf0>
      e0: 12be0009     	mov	w9, #0xfffffff          // =268435455
      e4: 6b09011f     	cmp	w8, w9
      e8: 52800089     	mov	w9, #0x4                // =4
      ec: 1a893529     	cinc	w9, w9, hs
      f0: 531d712a     	lsl	w10, w9, #3
      f4: 5280002b     	mov	w11, #0x1               // =1
      f8: 4b09014c     	sub	w12, w10, w9
      fc: 2a0903e9     	mov	w9, w9
     100: 5100214a     	sub	w10, w10, #0x8
     104: 9acc216b     	lsl	x11, x11, x12
     108: b941826c     	ldr	w12, [x19, #0x180]
     10c: aa080168     	orr	x8, x11, x8
     110: 1100058b     	add	w11, w12, #0x1
     114: 9aca250d     	lsr	x13, x8, x10
     118: d100052a     	sub	x10, x9, #0x1
     11c: b901826b     	str	w11, [x19, #0x180]
     120: 382c6a6d     	strb	w13, [x19, x12]
     124: 3400046a     	cbz	w10, 0x1b0 <elem+0x1b0>
     128: 531d714a     	lsl	w10, w10, #3
     12c: b941826b     	ldr	w11, [x19, #0x180]
     130: 5100214a     	sub	w10, w10, #0x8
     134: 1100056c     	add	w12, w11, #0x1
     138: 9aca250d     	lsr	x13, x8, x10
     13c: d100092a     	sub	x10, x9, #0x2
     140: b901826c     	str	w12, [x19, #0x180]
     144: 382b6a6d     	strb	w13, [x19, x11]
     148: 3400034a     	cbz	w10, 0x1b0 <elem+0x1b0>
     14c: 531d714a     	lsl	w10, w10, #3
     150: b941826b     	ldr	w11, [x19, #0x180]
     154: 5100214a     	sub	w10, w10, #0x8
     158: 1100056c     	add	w12, w11, #0x1
     15c: 9aca250d     	lsr	x13, x8, x10
     160: d1000d2a     	sub	x10, x9, #0x3
     164: b901826c     	str	w12, [x19, #0x180]
     168: 382b6a6d     	strb	w13, [x19, x11]
     16c: 3400022a     	cbz	w10, 0x1b0 <elem+0x1b0>
     170: 531d714a     	lsl	w10, w10, #3
     174: b941826b     	ldr	w11, [x19, #0x180]
     178: d1001129     	sub	x9, x9, #0x4
     17c: 5100214a     	sub	w10, w10, #0x8
     180: 1100056c     	add	w12, w11, #0x1
     184: 9aca250a     	lsr	x10, x8, x10
     188: b901826c     	str	w12, [x19, #0x180]
     18c: 382b6a6a     	strb	w10, [x19, x11]
     190: 34000109     	cbz	w9, 0x1b0 <elem+0x1b0>
     194: 531d7129     	lsl	w9, w9, #3
     198: b941826a     	ldr	w10, [x19, #0x180]
     19c: 51002129     	sub	w9, w9, #0x8
     1a0: 1100054b     	add	w11, w10, #0x1
     1a4: 9ac92508     	lsr	x8, x8, x9
     1a8: b901826b     	str	w11, [x19, #0x180]
     1ac: 382a6a68     	strb	w8, [x19, x10]
     1b0: b9418268     	ldr	w8, [x19, #0x180]
     1b4: b9418282     	ldr	w2, [x20, #0x180]
     1b8: aa1403e1     	mov	x1, x20
     1bc: 8b080260     	add	x0, x19, x8
     1c0: 94000000     	bl	0x1c0 <elem+0x1c0>
		00000000000001c0:  R_AARCH64_CALL26	memcpy
     1c4: b9418288     	ldr	w8, [x20, #0x180]
     1c8: b9418269     	ldr	w9, [x19, #0x180]
     1cc: 0b080128     	add	w8, w9, w8
     1d0: b9018268     	str	w8, [x19, #0x180]
     1d4: a9414ff4     	ldp	x20, x19, [sp, #0x10]
     1d8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
     1dc: d65f03c0     	ret

Disassembly of section .text.iq4_mkv_seal:

0000000000000000 <iq4_mkv_seal>:
       0: b4000aa0     	cbz	x0, 0x154 <iq4_mkv_seal+0x154>
       4: d10743ff     	sub	sp, sp, #0x1d0
       8: a9197bfd     	stp	x29, x30, [sp, #0x190]
       c: a91a5ffc     	stp	x28, x23, [sp, #0x1a0]
      10: a91b57f6     	stp	x22, x21, [sp, #0x1b0]
      14: a91c4ff4     	stp	x20, x19, [sp, #0x1c0]
      18: 910643fd     	add	x29, sp, #0x190
      1c: b9401808     	ldr	w8, [x0, #0x18]
      20: aa0003f3     	mov	x19, x0
      24: 7100111f     	cmp	w8, #0x4
      28: 540009e0     	b.eq	0x164 <iq4_mkv_seal+0x164>
      2c: 7100051f     	cmp	w8, #0x1
      30: 54000961     	b.ne	0x15c <iq4_mkv_seal+0x15c>
      34: b9402e68     	ldr	w8, [x19, #0x2c]
      38: 34000928     	cbz	w8, 0x15c <iq4_mkv_seal+0x15c>
      3c: f9401e68     	ldr	x8, [x19, #0x38]
      40: f9402669     	ldr	x9, [x19, #0x48]
      44: eb090108     	subs	x8, x8, x9
      48: 54000923     	b.lo	0x16c <iq4_mkv_seal+0x16c>
      4c: 92ffe009     	mov	x9, #0xffffffffffffff   // =72057594037927935
      50: eb09011f     	cmp	x8, x9
      54: 540008c2     	b.hs	0x16c <iq4_mkv_seal+0x16c>
      58: 6f00e400     	movi	v0.2d, #0000000000000000
      5c: 910033f6     	add	x22, sp, #0xc
      60: 910217ea     	add	x10, sp, #0x85
      64: 910022c9     	add	x9, x22, #0x8
      68: 52800117     	mov	w23, #0x8               // =8
      6c: 2a1f03f5     	mov	w21, wzr
      70: f80ff15f     	stur	xzr, [x10, #0xff]
      74: b9018ff7     	str	w23, [sp, #0x18c]
      78: ad088120     	stp	q0, q0, [x9, #0x110]
      7c: ad098120     	stp	q0, q0, [x9, #0x130]
      80: ad0a8120     	stp	q0, q0, [x9, #0x150]
      84: 3d804120     	str	q0, [x9, #0x100]
      88: 910033e9     	add	x9, sp, #0xc
      8c: 3c8f8120     	stur	q0, [x9, #0xf8]
      90: 3c8e8120     	stur	q0, [x9, #0xe8]
      94: 3c8d8120     	stur	q0, [x9, #0xd8]
      98: 3c8c8120     	stur	q0, [x9, #0xc8]
      9c: 3c8b8120     	stur	q0, [x9, #0xb8]
      a0: 3c8a8120     	stur	q0, [x9, #0xa8]
      a4: 3c898120     	stur	q0, [x9, #0x98]
      a8: 3c888120     	stur	q0, [x9, #0x88]
      ac: 52800029     	mov	w9, #0x1                // =1
      b0: 390033e9     	strb	w9, [sp, #0xc]
      b4: d370fd09     	lsr	x9, x8, #48
      b8: 3c8843e0     	stur	q0, [sp, #0x84]
      bc: 390037e9     	strb	w9, [sp, #0xd]
      c0: d368fd09     	lsr	x9, x8, #40
      c4: 3c8743e0     	stur	q0, [sp, #0x74]
      c8: 39003be9     	strb	w9, [sp, #0xe]
      cc: d360fd09     	lsr	x9, x8, #32
      d0: 3c8643e0     	stur	q0, [sp, #0x64]
      d4: 39003fe9     	strb	w9, [sp, #0xf]
      d8: d358fd09     	lsr	x9, x8, #24
      dc: 3c8543e0     	stur	q0, [sp, #0x54]
      e0: 390043e9     	strb	w9, [sp, #0x10]
      e4: d350fd09     	lsr	x9, x8, #16
      e8: 3c8443e0     	stur	q0, [sp, #0x44]
      ec: 390047e9     	strb	w9, [sp, #0x11]
      f0: d348fd09     	lsr	x9, x8, #8
      f4: 3c8343e0     	stur	q0, [sp, #0x34]
      f8: 3c8243e0     	stur	q0, [sp, #0x24]
      fc: 3c8143e0     	stur	q0, [sp, #0x14]
     100: 39004be9     	strb	w9, [sp, #0x12]
     104: 39004fe8     	strb	w8, [sp, #0x13]
     108: f9402269     	ldr	x9, [x19, #0x40]
     10c: f9400a68     	ldr	x8, [x19, #0x10]
     110: 2a1503ea     	mov	w10, w21
     114: f9400260     	ldr	x0, [x19]
     118: 4b1502f4     	sub	w20, w23, w21
     11c: 8b0a02c2     	add	x2, x22, x10
     120: 8b0a0121     	add	x1, x9, x10
     124: 2a1403e3     	mov	w3, w20
     128: d63f0100     	blr	x8
     12c: 35000260     	cbnz	w0, 0x178 <iq4_mkv_seal+0x178>
     130: d1000428     	sub	x8, x1, #0x1
     134: eb34411f     	cmp	x8, w20, uxtw
     138: 540002c2     	b.hs	0x190 <iq4_mkv_seal+0x190>
     13c: 0b0102b5     	add	w21, w21, w1
     140: 71001ebf     	cmp	w21, #0x7
     144: 54fffe29     	b.ls	0x108 <iq4_mkv_seal+0x108>
     148: 2a1f03e0     	mov	w0, wzr
     14c: 52800048     	mov	w8, #0x2                // =2
     150: 14000012     	b	0x198 <iq4_mkv_seal+0x198>
     154: 52800020     	mov	w0, #0x1                // =1
     158: d65f03c0     	ret
     15c: 52800040     	mov	w0, #0x2                // =2
     160: 1400000f     	b	0x19c <iq4_mkv_seal+0x19c>
     164: 528000e0     	mov	w0, #0x7                // =7
     168: 1400000d     	b	0x19c <iq4_mkv_seal+0x19c>
     16c: 52800068     	mov	w8, #0x3                // =3
     170: 528000a0     	mov	w0, #0x5                // =5
     174: 14000009     	b	0x198 <iq4_mkv_seal+0x198>
     178: 7100041f     	cmp	w0, #0x1
     17c: 52800068     	mov	w8, #0x3                // =3
     180: 528000c9     	mov	w9, #0x6                // =6
     184: 1a880508     	cinc	w8, w8, ne
     188: 1a890520     	cinc	w0, w9, ne
     18c: 14000003     	b	0x198 <iq4_mkv_seal+0x198>
     190: 52800068     	mov	w8, #0x3                // =3
     194: 528000c0     	mov	w0, #0x6                // =6
     198: b9001a68     	str	w8, [x19, #0x18]
     19c: a95c4ff4     	ldp	x20, x19, [sp, #0x1c0]
     1a0: a95b57f6     	ldp	x22, x21, [sp, #0x1b0]
     1a4: a95a5ffc     	ldp	x28, x23, [sp, #0x1a0]
     1a8: a9597bfd     	ldp	x29, x30, [sp, #0x190]
     1ac: 910743ff     	add	sp, sp, #0x1d0
     1b0: d65f03c0     	ret

Disassembly of section .text.iq4_mkv_scan_begin:

0000000000000000 <iq4_mkv_scan_begin>:
       0: aa0003e8     	mov	x8, x0
       4: 52800040     	mov	w0, #0x2                // =2
       8: b4000288     	cbz	x8, 0x58 <iq4_mkv_scan_begin+0x58>
       c: b4000261     	cbz	x1, 0x58 <iq4_mkv_scan_begin+0x58>
      10: 12a04009     	mov	w9, #-0x2000001         // =-33554433
      14: 32072bea     	mov	w10, #-0x1fffff1        // =-33554417
      18: 0b0900a9     	add	w9, w5, w9
      1c: 6b0a013f     	cmp	w9, w10
      20: 540001c3     	b.lo	0x58 <iq4_mkv_scan_begin+0x58>
      24: d360fc49     	lsr	x9, x2, #32
      28: b5000189     	cbnz	x9, 0x58 <iq4_mkv_scan_begin+0x58>
      2c: 529ffb89     	mov	w9, #0xffdc             // =65500
      30: 6b09009f     	cmp	w4, w9
      34: 54000128     	b.hi	0x58 <iq4_mkv_scan_begin+0x58>
      38: 6b09007f     	cmp	w3, w9
      3c: 540000e8     	b.hi	0x58 <iq4_mkv_scan_begin+0x58>
      40: 340000c4     	cbz	w4, 0x58 <iq4_mkv_scan_begin+0x58>
      44: 340000a3     	cbz	w3, 0x58 <iq4_mkv_scan_begin+0x58>
      48: f9400429     	ldr	x9, [x1, #0x8]
      4c: b4000069     	cbz	x9, 0x58 <iq4_mkv_scan_begin+0x58>
      50: f9400d09     	ldr	x9, [x8, #0x18]
      54: b4000049     	cbz	x9, 0x5c <iq4_mkv_scan_begin+0x5c>
      58: d65f03c0     	ret
      5c: b9404d09     	ldr	w9, [x8, #0x4c]
      60: 35ffffc9     	cbnz	w9, 0x58 <iq4_mkv_scan_begin+0x58>
      64: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
      68: a90157fc     	stp	x28, x21, [sp, #0x10]
      6c: 910003fd     	mov	x29, sp
      70: a9024ff4     	stp	x20, x19, [sp, #0x20]
      74: d10e03ff     	sub	sp, sp, #0x380
      78: 6f00e400     	movi	v0.2d, #0000000000000000
      7c: d101c3b4     	sub	x20, x29, #0x70
      80: aa0803f3     	mov	x19, x8
      84: d101c3a0     	sub	x0, x29, #0x70
      88: aa0203f5     	mov	x21, x2
      8c: f900329f     	str	xzr, [x20, #0x60]
      90: ad008100     	stp	q0, q0, [x8, #0x10]
      94: ad018100     	stp	q0, q0, [x8, #0x30]
      98: 3d800100     	str	q0, [x8]
      9c: 3dc00021     	ldr	q1, [x1]
      a0: f9000902     	str	x2, [x8, #0x10]
      a4: 2a0303e1     	mov	w1, w3
      a8: 29071103     	stp	w3, w4, [x8, #0x38]
      ac: 2a0403e2     	mov	w2, w4
      b0: 3d800101     	str	q1, [x8]
      b4: b9004105     	str	w5, [x8, #0x40]
      b8: 910633e8     	add	x8, sp, #0x18c
      bc: ad000280     	stp	q0, q0, [x20]
      c0: ad010280     	stp	q0, q0, [x20, #0x20]
      c4: ad020280     	stp	q0, q0, [x20, #0x40]
      c8: 94000000     	bl	0xc8 <iq4_mkv_scan_begin+0xc8>
		00000000000000c8:  R_AARCH64_CALL26	.text.header
      cc: b9430fe3     	ldr	w3, [sp, #0x30c]
      d0: eb0302bf     	cmp	x21, x3
      d4: 54000062     	b.hs	0xe0 <iq4_mkv_scan_begin+0xe0>
      d8: 52800060     	mov	w0, #0x3                // =3
      dc: 14000006     	b	0xf4 <iq4_mkv_scan_begin+0xf4>
      e0: 910033e2     	add	x2, sp, #0xc
      e4: aa1303e0     	mov	x0, x19
      e8: aa1f03e1     	mov	x1, xzr
      ec: 94000000     	bl	0xec <iq4_mkv_scan_begin+0xec>
		00000000000000ec:  R_AARCH64_CALL26	.text.read_exact
      f0: 340000c0     	cbz	w0, 0x108 <iq4_mkv_scan_begin+0x108>
      f4: 910e03ff     	add	sp, sp, #0x380
      f8: a9424ff4     	ldp	x20, x19, [sp, #0x20]
      fc: a94157fc     	ldp	x28, x21, [sp, #0x10]
     100: a8c37bfd     	ldp	x29, x30, [sp], #0x30
     104: d65f03c0     	ret
     108: b9430fe8     	ldr	w8, [sp, #0x30c]
     10c: f9402289     	ldr	x9, [x20, #0x40]
     110: 34000248     	cbz	w8, 0x158 <iq4_mkv_scan_begin+0x158>
     114: f940268b     	ldr	x11, [x20, #0x48]
     118: aa1f03ea     	mov	x10, xzr
     11c: 910033ec     	add	x12, sp, #0xc
     120: 910633ed     	add	x13, sp, #0x18c
     124: 14000008     	b	0x144 <iq4_mkv_scan_begin+0x144>
     128: 386a698e     	ldrb	w14, [x12, x10]
     12c: 386a69af     	ldrb	w15, [x13, x10]
     130: 6b0f01df     	cmp	w14, w15
     134: 54fffd21     	b.ne	0xd8 <iq4_mkv_scan_begin+0xd8>
     138: 9100054a     	add	x10, x10, #0x1
     13c: eb0a011f     	cmp	x8, x10
     140: 540000c0     	b.eq	0x158 <iq4_mkv_scan_begin+0x158>
     144: eb0a013f     	cmp	x9, x10
     148: 54ffff08     	b.hi	0x128 <iq4_mkv_scan_begin+0x128>
     14c: eb0a017f     	cmp	x11, x10
     150: 54ffff48     	b.hi	0x138 <iq4_mkv_scan_begin+0x138>
     154: 17fffff5     	b	0x128 <iq4_mkv_scan_begin+0x128>
     158: 910033ea     	add	x10, sp, #0xc
     15c: 38696949     	ldrb	w9, [x10, x9]
     160: 7100053f     	cmp	w9, #0x1
     164: 54fffba1     	b.ne	0xd8 <iq4_mkv_scan_begin+0xd8>
     168: 2a1f03e0     	mov	w0, wzr
     16c: f9000e68     	str	x8, [x19, #0x18]
     170: 17ffffe1     	b	0xf4 <iq4_mkv_scan_begin+0xf4>

Disassembly of section .text.read_exact:

0000000000000000 <read_exact>:
       0: b9404c08     	ldr	w8, [x0, #0x4c]
       4: 34000068     	cbz	w8, 0x10 <read_exact+0x10>
       8: 528000a0     	mov	w0, #0x5                // =5
       c: d65f03c0     	ret
      10: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
      14: a9015ff8     	stp	x24, x23, [sp, #0x10]
      18: a90257f6     	stp	x22, x21, [sp, #0x20]
      1c: a9034ff4     	stp	x20, x19, [sp, #0x30]
      20: 910003fd     	mov	x29, sp
      24: 2a0303f4     	mov	w20, w3
      28: 34000263     	cbz	w3, 0x74 <read_exact+0x74>
      2c: aa0203f5     	mov	x21, x2
      30: aa0003f3     	mov	x19, x0
      34: aa0103f6     	mov	x22, x1
      38: 2a1f03f8     	mov	w24, wzr
      3c: a9402260     	ldp	x0, x8, [x19]
      40: 2a1803e9     	mov	w9, w24
      44: 4b180297     	sub	w23, w20, w24
      48: 8b0902c1     	add	x1, x22, x9
      4c: 8b0902a2     	add	x2, x21, x9
      50: 2a1703e3     	mov	w3, w23
      54: d63f0100     	blr	x8
      58: 35000120     	cbnz	w0, 0x7c <read_exact+0x7c>
      5c: d1000428     	sub	x8, x1, #0x1
      60: eb37411f     	cmp	x8, w23, uxtw
      64: 54000102     	b.hs	0x84 <read_exact+0x84>
      68: 0b010318     	add	w24, w24, w1
      6c: 6b14031f     	cmp	w24, w20
      70: 54fffe63     	b.lo	0x3c <read_exact+0x3c>
      74: 2a1f03e0     	mov	w0, wzr
      78: 14000008     	b	0x98 <read_exact+0x98>
      7c: 7100041f     	cmp	w0, #0x1
      80: 54000061     	b.ne	0x8c <read_exact+0x8c>
      84: 52800080     	mov	w0, #0x4                // =4
      88: 14000004     	b	0x98 <read_exact+0x98>
      8c: 52800028     	mov	w8, #0x1                // =1
      90: 528000a0     	mov	w0, #0x5                // =5
      94: b9004e68     	str	w8, [x19, #0x4c]
      98: a9434ff4     	ldp	x20, x19, [sp, #0x30]
      9c: a94257f6     	ldp	x22, x21, [sp, #0x20]
      a0: a9415ff8     	ldp	x24, x23, [sp, #0x10]
      a4: a8c47bfd     	ldp	x29, x30, [sp], #0x40
      a8: d65f03c0     	ret

Disassembly of section .text.iq4_mkv_scan_next:

0000000000000000 <iq4_mkv_scan_next>:
       0: 52800048     	mov	w8, #0x2                // =2
       4: b40001e0     	cbz	x0, 0x40 <iq4_mkv_scan_next+0x40>
       8: b40001c1     	cbz	x1, 0x40 <iq4_mkv_scan_next+0x40>
       c: b40001a3     	cbz	x3, 0x40 <iq4_mkv_scan_next+0x40>
      10: b4000184     	cbz	x4, 0x40 <iq4_mkv_scan_next+0x40>
      14: b4000165     	cbz	x5, 0x40 <iq4_mkv_scan_next+0x40>
      18: f9400c08     	ldr	x8, [x0, #0x18]
      1c: b4000108     	cbz	x8, 0x3c <iq4_mkv_scan_next+0x3c>
      20: b900007f     	str	wzr, [x3]
      24: b9404c08     	ldr	w8, [x0, #0x4c]
      28: f900009f     	str	xzr, [x4]
      2c: f90000bf     	str	xzr, [x5]
      30: 340000c8     	cbz	w8, 0x48 <iq4_mkv_scan_next+0x48>
      34: 528000a0     	mov	w0, #0x5                // =5
      38: d65f03c0     	ret
      3c: 52800048     	mov	w8, #0x2                // =2
      40: 2a0803e0     	mov	w0, w8
      44: d65f03c0     	ret
      48: b9404808     	ldr	w8, [x0, #0x48]
      4c: 34000068     	cbz	w8, 0x58 <iq4_mkv_scan_next+0x58>
      50: 52800020     	mov	w0, #0x1                // =1
      54: d65f03c0     	ret
      58: d10403ff     	sub	sp, sp, #0x100
      5c: a90a7bfd     	stp	x29, x30, [sp, #0xa0]
      60: a90b6ffc     	stp	x28, x27, [sp, #0xb0]
      64: a90c67fa     	stp	x26, x25, [sp, #0xc0]
      68: a90d5ff8     	stp	x24, x23, [sp, #0xd0]
      6c: a90e57f6     	stp	x22, x21, [sp, #0xe0]
      70: a90f4ff4     	stp	x20, x19, [sp, #0xf0]
      74: 910283fd     	add	x29, sp, #0xa0
      78: a9416808     	ldp	x8, x26, [x0, #0x10]
      7c: eb1a0108     	subs	x8, x8, x26
      80: 54000e03     	b.lo	0x240 <iq4_mkv_scan_next+0x240>
      84: f100891f     	cmp	x8, #0x22
      88: 54000dc9     	b.ls	0x240 <iq4_mkv_scan_next+0x240>
      8c: 2a0203f9     	mov	w25, w2
      90: aa0103f3     	mov	x19, x1
      94: aa0303f7     	mov	x23, x3
      98: aa0403f6     	mov	x22, x4
      9c: f90007e5     	str	x5, [sp, #0x8]
      a0: 2a1f03fb     	mov	w27, wzr
      a4: d10093bc     	sub	x28, x29, #0x24
      a8: 52800475     	mov	w21, #0x23              // =35
      ac: aa0003f8     	mov	x24, x0
      b0: a9402000     	ldp	x0, x8, [x0]
      b4: 2a1b03e9     	mov	w9, w27
      b8: 4b1b02b4     	sub	w20, w21, w27
      bc: 8b090341     	add	x1, x26, x9
      c0: 8b090382     	add	x2, x28, x9
      c4: 2a1403e3     	mov	w3, w20
      c8: d63f0100     	blr	x8
      cc: 35000a00     	cbnz	w0, 0x20c <iq4_mkv_scan_next+0x20c>
      d0: d1000428     	sub	x8, x1, #0x1
      d4: eb34411f     	cmp	x8, w20, uxtw
      d8: 540009e2     	b.hs	0x214 <iq4_mkv_scan_next+0x214>
      dc: 0b01037b     	add	w27, w27, w1
      e0: aa1803e0     	mov	x0, x24
      e4: 71008b7f     	cmp	w27, #0x22
      e8: 54fffe29     	b.ls	0xac <iq4_mkv_scan_next+0xac>
      ec: b85dc3a8     	ldur	w8, [x29, #-0x24]
      f0: 5296cea9     	mov	w9, #0xb675             // =46709
      f4: 72a3e869     	movk	w9, #0x1f43, lsl #16
      f8: 5ac00908     	rev	w8, w8
      fc: 6b09011f     	cmp	w8, w9
     100: 54000a01     	b.ne	0x240 <iq4_mkv_scan_next+0x240>
     104: 385e03a8     	ldurb	w8, [x29, #-0x20]
     108: 7100051f     	cmp	w8, #0x1
     10c: 540009a1     	b.ne	0x240 <iq4_mkv_scan_next+0x240>
     110: 385e83a8     	ldurb	w8, [x29, #-0x18]
     114: 71039d1f     	cmp	w8, #0xe7
     118: 54000941     	b.ne	0x240 <iq4_mkv_scan_next+0x240>
     11c: 385e93a8     	ldurb	w8, [x29, #-0x17]
     120: 7102211f     	cmp	w8, #0x88
     124: 540008e1     	b.ne	0x240 <iq4_mkv_scan_next+0x240>
     128: 385f23a8     	ldurb	w8, [x29, #-0xe]
     12c: 71028d1f     	cmp	w8, #0xa3
     130: 54000881     	b.ne	0x240 <iq4_mkv_scan_next+0x240>
     134: 385f33a8     	ldurb	w8, [x29, #-0xd]
     138: 7100051f     	cmp	w8, #0x1
     13c: 54000821     	b.ne	0x240 <iq4_mkv_scan_next+0x240>
     140: b85fb3a8     	ldur	w8, [x29, #-0x5]
     144: 52801009     	mov	w9, #0x80               // =128
     148: 72b02009     	movk	w9, #0x8100, lsl #16
     14c: 5ac00908     	rev	w8, w8
     150: 6b09011f     	cmp	w8, w9
     154: 54000761     	b.ne	0x240 <iq4_mkv_scan_next+0x240>
     158: 385f53a8     	ldurb	w8, [x29, #-0xb]
     15c: 385f43a9     	ldurb	w9, [x29, #-0xc]
     160: 385f93aa     	ldurb	w10, [x29, #-0x7]
     164: 53185d08     	lsl	w8, w8, #8
     168: d378dd4a     	lsl	x10, x10, #8
     16c: 2a094108     	orr	w8, w8, w9, lsl #16
     170: 385f63a9     	ldurb	w9, [x29, #-0xa]
     174: 2a090108     	orr	w8, w8, w9
     178: 385f73a9     	ldurb	w9, [x29, #-0x9]
     17c: d370bd08     	lsl	x8, x8, #16
     180: aa092108     	orr	x8, x8, x9, lsl #8
     184: 385f83a9     	ldurb	w9, [x29, #-0x8]
     188: aa090108     	orr	x8, x8, x9
     18c: 385fa3a9     	ldurb	w9, [x29, #-0x6]
     190: aa084148     	orr	x8, x10, x8, lsl #16
     194: aa09011a     	orr	x26, x8, x9
     198: f100535f     	cmp	x26, #0x14
     19c: 54000523     	b.lo	0x240 <iq4_mkv_scan_next+0x240>
     1a0: b9404008     	ldr	w8, [x0, #0x40]
     1a4: d1001343     	sub	x3, x26, #0x4
     1a8: eb08007f     	cmp	x3, x8
     1ac: 540004a8     	b.hi	0x240 <iq4_mkv_scan_next+0x240>
     1b0: 385e23a8     	ldurb	w8, [x29, #-0x1e]
     1b4: 385e13a9     	ldurb	w9, [x29, #-0x1f]
     1b8: 385e63aa     	ldurb	w10, [x29, #-0x1a]
     1bc: 53185d08     	lsl	w8, w8, #8
     1c0: d378dd4a     	lsl	x10, x10, #8
     1c4: 2a094108     	orr	w8, w8, w9, lsl #16
     1c8: 385e33a9     	ldurb	w9, [x29, #-0x1d]
     1cc: 2a090108     	orr	w8, w8, w9
     1d0: 385e43a9     	ldurb	w9, [x29, #-0x1c]
     1d4: d370bd08     	lsl	x8, x8, #16
     1d8: aa092108     	orr	x8, x8, x9, lsl #8
     1dc: 385e53a9     	ldurb	w9, [x29, #-0x1b]
     1e0: aa090108     	orr	x8, x8, x9
     1e4: 385e73a9     	ldurb	w9, [x29, #-0x19]
     1e8: aa084148     	orr	x8, x10, x8, lsl #16
     1ec: aa090108     	orr	x8, x8, x9
     1f0: 9100e749     	add	x9, x26, #0x39
     1f4: eb09011f     	cmp	x8, x9
     1f8: 54000241     	b.ne	0x240 <iq4_mkv_scan_next+0x240>
     1fc: 6b03033f     	cmp	w25, w3
     200: 54000162     	b.hs	0x22c <iq4_mkv_scan_next+0x22c>
     204: 52800048     	mov	w8, #0x2                // =2
     208: 14000010     	b	0x248 <iq4_mkv_scan_next+0x248>
     20c: 7100041f     	cmp	w0, #0x1
     210: 54000061     	b.ne	0x21c <iq4_mkv_scan_next+0x21c>
     214: 52800088     	mov	w8, #0x4                // =4
     218: 1400000c     	b	0x248 <iq4_mkv_scan_next+0x248>
     21c: 52800028     	mov	w8, #0x1                // =1
     220: b9004f08     	str	w8, [x24, #0x4c]
     224: 528000a8     	mov	w8, #0x5                // =5
     228: 14000008     	b	0x248 <iq4_mkv_scan_next+0x248>
     22c: a9412009     	ldp	x9, x8, [x0, #0x10]
     230: 91011754     	add	x20, x26, #0x45
     234: cb080129     	sub	x9, x9, x8
     238: eb09029f     	cmp	x20, x9
     23c: 54000189     	b.ls	0x26c <iq4_mkv_scan_next+0x26c>
     240: 52800028     	mov	w8, #0x1                // =1
     244: b9004808     	str	w8, [x0, #0x48]
     248: a94f4ff4     	ldp	x20, x19, [sp, #0xf0]
     24c: a94e57f6     	ldp	x22, x21, [sp, #0xe0]
     250: a94d5ff8     	ldp	x24, x23, [sp, #0xd0]
     254: a94c67fa     	ldp	x26, x25, [sp, #0xc0]
     258: a94b6ffc     	ldp	x28, x27, [sp, #0xb0]
     25c: a94a7bfd     	ldp	x29, x30, [sp, #0xa0]
     260: 910403ff     	add	sp, sp, #0x100
     264: 2a0803e0     	mov	w0, w8
     268: d65f03c0     	ret
     26c: 91008d01     	add	x1, x8, #0x23
     270: aa1303e2     	mov	x2, x19
     274: f90003e3     	str	x3, [sp]
     278: 94000000     	bl	0x278 <iq4_mkv_scan_next+0x278>
		0000000000000278:  R_AARCH64_CALL26	.text.read_exact
     27c: 35000120     	cbnz	w0, 0x2a0 <iq4_mkv_scan_next+0x2a0>
     280: f9400f08     	ldr	x8, [x24, #0x18]
     284: aa1803e0     	mov	x0, x24
     288: d10133a2     	sub	x2, x29, #0x4c
     28c: 528004c3     	mov	w3, #0x26               // =38
     290: 8b080348     	add	x8, x26, x8
     294: 91007d01     	add	x1, x8, #0x1f
     298: 94000000     	bl	0x298 <iq4_mkv_scan_next+0x298>
		0000000000000298:  R_AARCH64_CALL26	.text.read_exact
     29c: 34000060     	cbz	w0, 0x2a8 <iq4_mkv_scan_next+0x2a8>
     2a0: 2a0003e8     	mov	w8, w0
     2a4: 17ffffe9     	b	0x248 <iq4_mkv_scan_next+0x248>
     2a8: f85be3b9     	ldur	x25, [x29, #-0x42]
     2ac: b9404708     	ldr	w8, [x24, #0x44]
     2b0: aa1903fa     	mov	x26, x25
     2b4: 34000048     	cbz	w8, 0x2bc <iq4_mkv_scan_next+0x2bc>
     2b8: f940131a     	ldr	x26, [x24, #0x20]
     2bc: f85c63bb     	ldur	x27, [x29, #-0x3a]
     2c0: 910053e0     	add	x0, sp, #0x14
     2c4: 94000000     	bl	0x2c4 <iq4_mkv_scan_next+0x2c4>
		00000000000002c4:  R_AARCH64_CALL26	f3_jpeg_syntax_init_02
     2c8: 385b43a8     	ldurb	w8, [x29, #-0x4c]
     2cc: 7103b11f     	cmp	w8, #0xec
     2d0: 54000aa1     	b.ne	0x424 <iq4_mkv_scan_next+0x424>
     2d4: 385b53a8     	ldurb	w8, [x29, #-0x4b]
     2d8: 7102911f     	cmp	w8, #0xa4
     2dc: 54000a41     	b.ne	0x424 <iq4_mkv_scan_next+0x424>
     2e0: d10133bc     	sub	x28, x29, #0x4c
     2e4: 90000001     	adrp	x1, 0x0 <iq4_mkv_scan_next>
		00000000000002e4:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x9
     2e8: 91000021     	add	x1, x1, #0x0
		00000000000002e8:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x9
     2ec: b27f0380     	orr	x0, x28, #0x2
     2f0: 52800082     	mov	w2, #0x4                // =4
     2f4: 94000000     	bl	0x2f4 <iq4_mkv_scan_next+0x2f4>
		00000000000002f4:  R_AARCH64_CALL26	memcmp
     2f8: 35000960     	cbnz	w0, 0x424 <iq4_mkv_scan_next+0x424>
     2fc: b85ba3a8     	ldur	w8, [x29, #-0x46]
     300: 7100091f     	cmp	w8, #0x2
     304: 54000901     	b.ne	0x424 <iq4_mkv_scan_next+0x424>
     308: b85ce3a8     	ldur	w8, [x29, #-0x32]
     30c: 7100091f     	cmp	w8, #0x2
     310: 540008a1     	b.ne	0x424 <iq4_mkv_scan_next+0x424>
     314: b85d23a9     	ldur	w9, [x29, #-0x2e]
     318: f94003e8     	ldr	x8, [sp]
     31c: eb08013f     	cmp	x9, x8
     320: 54000821     	b.ne	0x424 <iq4_mkv_scan_next+0x424>
     324: b4000819     	cbz	x25, 0x424 <iq4_mkv_scan_next+0x424>
     328: eb1a0328     	subs	x8, x25, x26
     32c: 540007c3     	b.lo	0x424 <iq4_mkv_scan_next+0x424>
     330: b9404709     	ldr	w9, [x24, #0x44]
     334: 340000e9     	cbz	w9, 0x350 <iq4_mkv_scan_next+0x350>
     338: f9401709     	ldr	x9, [x24, #0x28]
     33c: eb09033f     	cmp	x25, x9
     340: 54000729     	b.ls	0x424 <iq4_mkv_scan_next+0x424>
     344: f9401b09     	ldr	x9, [x24, #0x30]
     348: eb09037f     	cmp	x27, x9
     34c: 540006c9     	b.ls	0x424 <iq4_mkv_scan_next+0x424>
     350: 385eb3a9     	ldurb	w9, [x29, #-0x15]
     354: 385ea3aa     	ldurb	w10, [x29, #-0x16]
     358: 385ef3ab     	ldurb	w11, [x29, #-0x11]
     35c: 53185d29     	lsl	w9, w9, #8
     360: d378dd6b     	lsl	x11, x11, #8
     364: 2a0a4129     	orr	w9, w9, w10, lsl #16
     368: 385ec3aa     	ldurb	w10, [x29, #-0x14]
     36c: 2a0a0129     	orr	w9, w9, w10
     370: 385ed3aa     	ldurb	w10, [x29, #-0x13]
     374: d370bd29     	lsl	x9, x9, #16
     378: aa0a2129     	orr	x9, x9, x10, lsl #8
     37c: 385ee3aa     	ldurb	w10, [x29, #-0x12]
     380: aa0a0129     	orr	x9, x9, x10
     384: 385f03aa     	ldurb	w10, [x29, #-0x10]
     388: aa094169     	orr	x9, x11, x9, lsl #16
     38c: 385f13ab     	ldurb	w11, [x29, #-0xf]
     390: aa0a0129     	orr	x9, x9, x10
     394: aa092169     	orr	x9, x11, x9, lsl #8
     398: eb08013f     	cmp	x9, x8
     39c: 54000441     	b.ne	0x424 <iq4_mkv_scan_next+0x424>
     3a0: f94003e2     	ldr	x2, [sp]
     3a4: b85d63b5     	ldur	w21, [x29, #-0x2a]
     3a8: 12800000     	mov	w0, #-0x1               // =-1
     3ac: aa1303e1     	mov	x1, x19
     3b0: 94000000     	bl	0x3b0 <iq4_mkv_scan_next+0x3b0>
		00000000000003b0:  R_AARCH64_CALL26	.text.crc
     3b4: b27f0381     	orr	x1, x28, #0x2
     3b8: 52800402     	mov	w2, #0x20               // =32
     3bc: 94000000     	bl	0x3bc <iq4_mkv_scan_next+0x3bc>
		00000000000003bc:  R_AARCH64_CALL26	.text.crc
     3c0: 2a2003e8     	mvn	w8, w0
     3c4: eb0802bf     	cmp	x21, x8
     3c8: 540002e1     	b.ne	0x424 <iq4_mkv_scan_next+0x424>
     3cc: f94003e2     	ldr	x2, [sp]
     3d0: 910053e0     	add	x0, sp, #0x14
     3d4: aa1303e1     	mov	x1, x19
     3d8: 94000000     	bl	0x3d8 <iq4_mkv_scan_next+0x3d8>
		00000000000003d8:  R_AARCH64_CALL26	f3_jpeg_syntax_feed_02
     3dc: 34000240     	cbz	w0, 0x424 <iq4_mkv_scan_next+0x424>
     3e0: 29470b01     	ldp	w1, w2, [x24, #0x38]
     3e4: 910053e0     	add	x0, sp, #0x14
     3e8: 94000000     	bl	0x3e8 <iq4_mkv_scan_next+0x3e8>
		00000000000003e8:  R_AARCH64_CALL26	f3_jpeg_syntax_done_02
     3ec: 340001c0     	cbz	w0, 0x424 <iq4_mkv_scan_next+0x424>
     3f0: f9400f09     	ldr	x9, [x24, #0x18]
     3f4: b940470a     	ldr	w10, [x24, #0x44]
     3f8: 2a1f03e8     	mov	w8, wzr
     3fc: a902ef19     	stp	x25, x27, [x24, #0x28]
     400: 8b140129     	add	x9, x9, x20
     404: a901eb09     	stp	x9, x26, [x24, #0x18]
     408: 11000549     	add	w9, w10, #0x1
     40c: b9004709     	str	w9, [x24, #0x44]
     410: a94027ea     	ldp	x10, x9, [sp]
     414: f90002d9     	str	x25, [x22]
     418: b90002ea     	str	w10, [x23]
     41c: f900013b     	str	x27, [x9]
     420: 17ffff8a     	b	0x248 <iq4_mkv_scan_next+0x248>
     424: 52800028     	mov	w8, #0x1                // =1
     428: b9004b08     	str	w8, [x24, #0x48]
     42c: 17ffff87     	b	0x248 <iq4_mkv_scan_next+0x248>

Disassembly of section .text.str_elem:

0000000000000000 <str_elem>:
       0: d106c3ff     	sub	sp, sp, #0x1b0
       4: a9197bfd     	stp	x29, x30, [sp, #0x190]
       8: a91a4ffc     	stp	x28, x19, [sp, #0x1a0]
       c: 910643fd     	add	x29, sp, #0x190
      10: 6f00e400     	movi	v0.2d, #0000000000000000
      14: 39400068     	ldrb	w8, [x3]
      18: aa0003f3     	mov	x19, x0
      1c: b90183ff     	str	wzr, [sp, #0x180]
      20: ad0003e0     	stp	q0, q0, [sp]
      24: ad0103e0     	stp	q0, q0, [sp, #0x20]
      28: ad0203e0     	stp	q0, q0, [sp, #0x40]
      2c: ad0303e0     	stp	q0, q0, [sp, #0x60]
      30: ad0403e0     	stp	q0, q0, [sp, #0x80]
      34: ad0503e0     	stp	q0, q0, [sp, #0xa0]
      38: ad0603e0     	stp	q0, q0, [sp, #0xc0]
      3c: ad0703e0     	stp	q0, q0, [sp, #0xe0]
      40: ad0803e0     	stp	q0, q0, [sp, #0x100]
      44: ad0903e0     	stp	q0, q0, [sp, #0x120]
      48: ad0a03e0     	stp	q0, q0, [sp, #0x140]
      4c: ad0b03e0     	stp	q0, q0, [sp, #0x160]
      50: 34000128     	cbz	w8, 0x74 <str_elem+0x74>
      54: 91000469     	add	x9, x3, #0x1
      58: 910003ea     	mov	x10, sp
      5c: b94183eb     	ldr	w11, [sp, #0x180]
      60: 1100056c     	add	w12, w11, #0x1
      64: b90183ec     	str	w12, [sp, #0x180]
      68: 382b6948     	strb	w8, [x10, x11]
      6c: 38401528     	ldrb	w8, [x9], #0x1
      70: 35ffff68     	cbnz	w8, 0x5c <str_elem+0x5c>
      74: 531d7049     	lsl	w9, w2, #3
      78: b941826a     	ldr	w10, [x19, #0x180]
      7c: 2a0103e8     	mov	w8, w1
      80: 2a0203eb     	mov	w11, w2
      84: 51002129     	sub	w9, w9, #0x8
      88: 1100054c     	add	w12, w10, #0x1
      8c: 9ac9250d     	lsr	x13, x8, x9
      90: d1000569     	sub	x9, x11, #0x1
      94: b901826c     	str	w12, [x19, #0x180]
      98: 382a6a6d     	strb	w13, [x19, x10]
      9c: 34000109     	cbz	w9, 0xbc <str_elem+0xbc>
      a0: 531d7129     	lsl	w9, w9, #3
      a4: b941826a     	ldr	w10, [x19, #0x180]
      a8: 51002129     	sub	w9, w9, #0x8
      ac: 1100054b     	add	w11, w10, #0x1
      b0: 9ac92508     	lsr	x8, x8, x9
      b4: b901826b     	str	w11, [x19, #0x180]
      b8: 382a6a68     	strb	w8, [x19, x10]
      bc: b94183e2     	ldr	w2, [sp, #0x180]
      c0: 7101fc5f     	cmp	w2, #0x7f
      c4: 54000062     	b.hs	0xd0 <str_elem+0xd0>
      c8: 52800029     	mov	w9, #0x1                // =1
      cc: 1400000f     	b	0x108 <str_elem+0x108>
      d0: 5287ffe8     	mov	w8, #0x3fff             // =16383
      d4: 6b08005f     	cmp	w2, w8
      d8: 54000062     	b.hs	0xe4 <str_elem+0xe4>
      dc: 52800049     	mov	w9, #0x2                // =2
      e0: 1400000a     	b	0x108 <str_elem+0x108>
      e4: 12bffc08     	mov	w8, #0x1fffff           // =2097151
      e8: 6b08005f     	cmp	w2, w8
      ec: 54000062     	b.hs	0xf8 <str_elem+0xf8>
      f0: 52800069     	mov	w9, #0x3                // =3
      f4: 14000005     	b	0x108 <str_elem+0x108>
      f8: 12be0008     	mov	w8, #0xfffffff          // =268435455
      fc: 6b08005f     	cmp	w2, w8
     100: 52800088     	mov	w8, #0x4                // =4
     104: 1a883509     	cinc	w9, w8, hs
     108: 531d712a     	lsl	w10, w9, #3
     10c: 52800028     	mov	w8, #0x1                // =1
     110: 4b09014b     	sub	w11, w10, w9
     114: 2a0903e9     	mov	w9, w9
     118: 5100214a     	sub	w10, w10, #0x8
     11c: 9acb2108     	lsl	x8, x8, x11
     120: b941826b     	ldr	w11, [x19, #0x180]
     124: aa020108     	orr	x8, x8, x2
     128: 1100056c     	add	w12, w11, #0x1
     12c: 9aca250d     	lsr	x13, x8, x10
     130: d100052a     	sub	x10, x9, #0x1
     134: b901826c     	str	w12, [x19, #0x180]
     138: 382b6a6d     	strb	w13, [x19, x11]
     13c: 3400046a     	cbz	w10, 0x1c8 <str_elem+0x1c8>
     140: 531d714a     	lsl	w10, w10, #3
     144: b941826b     	ldr	w11, [x19, #0x180]
     148: 5100214a     	sub	w10, w10, #0x8
     14c: 1100056c     	add	w12, w11, #0x1
     150: 9aca250d     	lsr	x13, x8, x10
     154: d100092a     	sub	x10, x9, #0x2
     158: b901826c     	str	w12, [x19, #0x180]
     15c: 382b6a6d     	strb	w13, [x19, x11]
     160: 3400034a     	cbz	w10, 0x1c8 <str_elem+0x1c8>
     164: 531d714a     	lsl	w10, w10, #3
     168: b941826b     	ldr	w11, [x19, #0x180]
     16c: 5100214a     	sub	w10, w10, #0x8
     170: 1100056c     	add	w12, w11, #0x1
     174: 9aca250d     	lsr	x13, x8, x10
     178: d1000d2a     	sub	x10, x9, #0x3
     17c: b901826c     	str	w12, [x19, #0x180]
     180: 382b6a6d     	strb	w13, [x19, x11]
     184: 3400022a     	cbz	w10, 0x1c8 <str_elem+0x1c8>
     188: 531d714a     	lsl	w10, w10, #3
     18c: b941826b     	ldr	w11, [x19, #0x180]
     190: d1001129     	sub	x9, x9, #0x4
     194: 5100214a     	sub	w10, w10, #0x8
     198: 1100056c     	add	w12, w11, #0x1
     19c: 9aca250a     	lsr	x10, x8, x10
     1a0: b901826c     	str	w12, [x19, #0x180]
     1a4: 382b6a6a     	strb	w10, [x19, x11]
     1a8: 34000109     	cbz	w9, 0x1c8 <str_elem+0x1c8>
     1ac: 531d7129     	lsl	w9, w9, #3
     1b0: b941826a     	ldr	w10, [x19, #0x180]
     1b4: 51002129     	sub	w9, w9, #0x8
     1b8: 1100054b     	add	w11, w10, #0x1
     1bc: 9ac92508     	lsr	x8, x8, x9
     1c0: b901826b     	str	w11, [x19, #0x180]
     1c4: 382a6a68     	strb	w8, [x19, x10]
     1c8: b9418268     	ldr	w8, [x19, #0x180]
     1cc: 910003e1     	mov	x1, sp
     1d0: 8b080260     	add	x0, x19, x8
     1d4: 94000000     	bl	0x1d4 <str_elem+0x1d4>
		00000000000001d4:  R_AARCH64_CALL26	memcpy
     1d8: b94183e8     	ldr	w8, [sp, #0x180]
     1dc: b9418269     	ldr	w9, [x19, #0x180]
     1e0: a9597bfd     	ldp	x29, x30, [sp, #0x190]
     1e4: 0b080128     	add	w8, w9, w8
     1e8: b9018268     	str	w8, [x19, #0x180]
     1ec: a95a4ffc     	ldp	x28, x19, [sp, #0x1a0]
     1f0: 9106c3ff     	add	sp, sp, #0x1b0
     1f4: d65f03c0     	ret
