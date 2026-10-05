
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_stream_export_build_04_attempt01/export_pixels.o:	file format elf64-littleaarch64

Disassembly of section .text.iq4_export_pixels_init:

0000000000000000 <iq4_export_pixels_init>:
       0: b40009a0     	cbz	x0, 0x134 <iq4_export_pixels_init+0x134>
       4: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
       8: a90167fa     	stp	x26, x25, [sp, #0x10]
       c: a9025ff8     	stp	x24, x23, [sp, #0x20]
      10: a90357f6     	stp	x22, x21, [sp, #0x30]
      14: a9044ff4     	stp	x20, x19, [sp, #0x40]
      18: 910003fd     	mov	x29, sp
      1c: 2a0503f3     	mov	w19, w5
      20: 2a0403f4     	mov	w20, w4
      24: b4000201     	cbz	x1, 0x64 <iq4_export_pixels_init+0x64>
      28: b40001e2     	cbz	x2, 0x64 <iq4_export_pixels_init+0x64>
      2c: ab02003f     	cmn	x1, x2
      30: aa0003e8     	mov	x8, x0
      34: 1a9f37e9     	cset	w9, hs
      38: b101041f     	cmn	x0, #0x41
      3c: 2a1f03e0     	mov	w0, wzr
      40: 54000708     	b.hi	0x120 <iq4_export_pixels_init+0x120>
      44: 370006e9     	tbnz	w9, #0x0, 0x120 <iq4_export_pixels_init+0x120>
      48: aa0803e0     	mov	x0, x8
      4c: 91010108     	add	x8, x8, #0x40
      50: eb01011f     	cmp	x8, x1
      54: 54000089     	b.ls	0x64 <iq4_export_pixels_init+0x64>
      58: 8b010048     	add	x8, x2, x1
      5c: eb00011f     	cmp	x8, x0
      60: 540005e8     	b.hi	0x11c <iq4_export_pixels_init+0x11c>
      64: aa0103f7     	mov	x23, x1
      68: aa0203f6     	mov	x22, x2
      6c: 2a1f03e1     	mov	w1, wzr
      70: 52800802     	mov	w2, #0x40               // =64
      74: 2a0603f9     	mov	w25, w6
      78: 2a0703fa     	mov	w26, w7
      7c: aa0303f5     	mov	x21, x3
      80: aa0003f8     	mov	x24, x0
      84: 94000000     	bl	0x84 <iq4_export_pixels_init+0x84>
		0000000000000084:  R_AARCH64_CALL26	memset
      88: 529ffb88     	mov	w8, #0xffdc             // =65500
      8c: 2a1f03e0     	mov	w0, wzr
      90: 6b08027f     	cmp	w19, w8
      94: 54000468     	b.hi	0x120 <iq4_export_pixels_init+0x120>
      98: 6b08029f     	cmp	w20, w8
      9c: 54000428     	b.hi	0x120 <iq4_export_pixels_init+0x120>
      a0: b4000417     	cbz	x23, 0x120 <iq4_export_pixels_init+0x120>
      a4: 340003f4     	cbz	w20, 0x120 <iq4_export_pixels_init+0x120>
      a8: 340003d3     	cbz	w19, 0x120 <iq4_export_pixels_init+0x120>
      ac: aa1603e9     	mov	x9, x22
      b0: ab1602ff     	cmn	x23, x22
      b4: 2a1f03e0     	mov	w0, wzr
      b8: 54000342     	b.hs	0x120 <iq4_export_pixels_init+0x120>
      bc: 531e768b     	lsl	w11, w20, #2
      c0: aa1503ea     	mov	x10, x21
      c4: eb0b02bf     	cmp	x21, x11
      c8: 540002c3     	b.lo	0x120 <iq4_export_pixels_init+0x120>
      cc: aa1803e8     	mov	x8, x24
      d0: 2a1a03e3     	mov	w3, w26
      d4: 2a1903e2     	mov	w2, w25
      d8: 71000a7f     	cmp	w19, #0x2
      dc: 540000e3     	b.lo	0xf8 <iq4_export_pixels_init+0xf8>
      e0: aa2b03ed     	mvn	x13, x11
      e4: 5100066c     	sub	w12, w19, #0x1
      e8: 9acc09ad     	udiv	x13, x13, x12
      ec: eb0d015f     	cmp	x10, x13
      f0: 54000168     	b.hi	0x11c <iq4_export_pixels_init+0x11c>
      f4: 14000002     	b	0xfc <iq4_export_pixels_init+0xfc>
      f8: aa1f03ec     	mov	x12, xzr
      fc: 9b0c2d4a     	madd	x10, x10, x12, x11
     100: eb09015f     	cmp	x10, x9
     104: 540000c8     	b.hi	0x11c <iq4_export_pixels_init+0x11c>
     108: 91006104     	add	x4, x8, #0x18
     10c: 2a1403e0     	mov	w0, w20
     110: 2a1303e1     	mov	w1, w19
     114: 94000000     	bl	0x114 <iq4_export_pixels_init+0x114>
		0000000000000114:  R_AARCH64_CALL26	iq4_export_geometry
     118: 34000100     	cbz	w0, 0x138 <iq4_export_pixels_init+0x138>
     11c: 2a1f03e0     	mov	w0, wzr
     120: a9444ff4     	ldp	x20, x19, [sp, #0x40]
     124: a94357f6     	ldp	x22, x21, [sp, #0x30]
     128: a9425ff8     	ldp	x24, x23, [sp, #0x20]
     12c: a94167fa     	ldp	x26, x25, [sp, #0x10]
     130: a8c57bfd     	ldp	x29, x30, [sp], #0x50
     134: d65f03c0     	ret
     138: 52800020     	mov	w0, #0x1                // =1
     13c: a9005b17     	stp	x23, x22, [x24]
     140: f9000b15     	str	x21, [x24, #0x10]
     144: 29074f14     	stp	w20, w19, [x24, #0x38]
     148: 17fffff6     	b	0x120 <iq4_export_pixels_init+0x120>

Disassembly of section .text.iq4_export_pixels_row:

0000000000000000 <iq4_export_pixels_row>:
       0: 2a1f03e8     	mov	w8, wzr
       4: b4000180     	cbz	x0, 0x34 <iq4_export_pixels_row+0x34>
       8: b4000162     	cbz	x2, 0x34 <iq4_export_pixels_row+0x34>
       c: f940000b     	ldr	x11, [x0]
      10: b400012b     	cbz	x11, 0x34 <iq4_export_pixels_row+0x34>
      14: b9402c09     	ldr	w9, [x0, #0x2c]
      18: 6b09003f     	cmp	w1, w9
      1c: 540000a2     	b.hs	0x30 <iq4_export_pixels_row+0x30>
      20: b940280a     	ldr	w10, [x0, #0x28]
      24: 8b0a0548     	add	x8, x10, x10, lsl #1
      28: eb08007f     	cmp	x3, x8
      2c: 54000082     	b.hs	0x3c <iq4_export_pixels_row+0x3c>
      30: 2a1f03e8     	mov	w8, wzr
      34: 2a0803e0     	mov	w0, w8
      38: d65f03c0     	ret
      3c: b40002c3     	cbz	x3, 0x94 <iq4_export_pixels_row+0x94>
      40: ab03005f     	cmn	x2, x3
      44: 2a1f03e8     	mov	w8, wzr
      48: 1a9f37ec     	cset	w12, hs
      4c: b101041f     	cmn	x0, #0x41
      50: 54ffff28     	b.hi	0x34 <iq4_export_pixels_row+0x34>
      54: 3707ff0c     	tbnz	w12, #0x0, 0x34 <iq4_export_pixels_row+0x34>
      58: 91010008     	add	x8, x0, #0x40
      5c: eb02011f     	cmp	x8, x2
      60: 8b020068     	add	x8, x3, x2
      64: 54000069     	b.ls	0x70 <iq4_export_pixels_row+0x70>
      68: eb00011f     	cmp	x8, x0
      6c: 54fffe28     	b.hi	0x30 <iq4_export_pixels_row+0x30>
      70: f940040c     	ldr	x12, [x0, #0x8]
      74: b400010c     	cbz	x12, 0x94 <iq4_export_pixels_row+0x94>
      78: ab0c017f     	cmn	x11, x12
      7c: 54fffda2     	b.hs	0x30 <iq4_export_pixels_row+0x30>
      80: eb0b011f     	cmp	x8, x11
      84: 54000089     	b.ls	0x94 <iq4_export_pixels_row+0x94>
      88: 8b0b0188     	add	x8, x12, x11
      8c: eb02011f     	cmp	x8, x2
      90: 54fffd08     	b.hi	0x30 <iq4_export_pixels_row+0x30>
      94: b9403008     	ldr	w8, [x0, #0x30]
      98: 528021cb     	mov	w11, #0x10e             // =270
      9c: 5280078c     	mov	w12, #0x3c              // =60
      a0: 5100054d     	sub	w13, w10, #0x1
      a4: 7101691f     	cmp	w8, #0x5a
      a8: 7a4b1104     	ccmp	w8, w11, #0x4, ne
      ac: 52800708     	mov	w8, #0x38               // =56
      b0: 9a88018b     	csel	x11, x12, x8, eq
      b4: 9a8c010c     	csel	x12, x8, x12, eq
      b8: 2a1f03e8     	mov	w8, wzr
      bc: b86b680b     	ldr	w11, [x0, x11]
      c0: 6b0b01bf     	cmp	w13, w11
      c4: 54fffb82     	b.hs	0x34 <iq4_export_pixels_row+0x34>
      c8: b86c6810     	ldr	w16, [x0, x12]
      cc: 6b10013f     	cmp	w9, w16
      d0: 54fffb28     	b.hi	0x34 <iq4_export_pixels_row+0x34>
      d4: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
      d8: a9016ffc     	stp	x28, x27, [sp, #0x10]
      dc: a90267fa     	stp	x26, x25, [sp, #0x20]
      e0: a9035ff8     	stp	x24, x23, [sp, #0x30]
      e4: a90457f6     	stp	x22, x21, [sp, #0x40]
      e8: a9054ff4     	stp	x20, x19, [sp, #0x50]
      ec: 11000428     	add	w8, w1, #0x1
      f0: 9280000e     	mov	x14, #-0x1              // =-1
      f4: 9ba17e0c     	umull	x12, w16, w1
      f8: 9ba83a0e     	umaddl	x14, w16, w8, x14
      fc: aa1f03e1     	mov	x1, xzr
     100: 9bab7e0f     	umull	x15, w16, w11
     104: 9ac9098d     	udiv	x13, x12, x9
     108: 9ba87e10     	umull	x16, w16, w8
     10c: d341fdf1     	lsr	x17, x15, #1
     110: 9ac909ce     	udiv	x14, x14, x9
     114: 6b0e01bf     	cmp	w13, w14
     118: 91000432     	add	x18, x1, #0x1
     11c: 54000289     	b.ls	0x16c <iq4_export_pixels_row+0x16c>
     120: aa1f03e4     	mov	x4, xzr
     124: aa1f03e3     	mov	x3, xzr
     128: aa1f03e5     	mov	x5, xzr
     12c: 8b1100a8     	add	x8, x5, x17
     130: 8b110084     	add	x4, x4, x17
     134: 8b110063     	add	x3, x3, x17
     138: 9acf0908     	udiv	x8, x8, x15
     13c: 8b010421     	add	x1, x1, x1, lsl #1
     140: eb0a025f     	cmp	x18, x10
     144: 8b010041     	add	x1, x2, x1
     148: 9acf0884     	udiv	x4, x4, x15
     14c: 39000028     	strb	w8, [x1]
     150: 52800028     	mov	w8, #0x1                // =1
     154: 9acf0863     	udiv	x3, x3, x15
     158: 39000424     	strb	w4, [x1, #0x1]
     15c: 39000823     	strb	w3, [x1, #0x2]
     160: aa1203e1     	mov	x1, x18
     164: 54fffd81     	b.ne	0x114 <iq4_export_pixels_row+0x114>
     168: 1400004b     	b	0x294 <iq4_export_pixels_row+0x294>
     16c: 9b0b7e53     	mul	x19, x18, x11
     170: aa1f03e3     	mov	x3, xzr
     174: aa1f03e4     	mov	x4, xzr
     178: aa1f03e5     	mov	x5, xzr
     17c: 2a0d03f5     	mov	w21, w13
     180: 9b0b7c26     	mul	x6, x1, x11
     184: d1000668     	sub	x8, x19, #0x1
     188: 9aca0914     	udiv	x20, x8, x10
     18c: 9aca08c7     	udiv	x7, x6, x10
     190: 14000004     	b	0x1a0 <iq4_export_pixels_row+0x1a0>
     194: 110006b5     	add	w21, w21, #0x1
     198: 6b0e02bf     	cmp	w21, w14
     19c: 54fffc88     	b.hi	0x12c <iq4_export_pixels_row+0x12c>
     1a0: 9bb52528     	umaddl	x8, w9, w21, x9
     1a4: 9bb57d36     	umull	x22, w9, w21
     1a8: eb08021f     	cmp	x16, x8
     1ac: 9a883208     	csel	x8, x16, x8, lo
     1b0: eb16019f     	cmp	x12, x22
     1b4: 9a968197     	csel	x23, x12, x22, hi
     1b8: 6b1400ff     	cmp	w7, w20
     1bc: 54fffec8     	b.hi	0x194 <iq4_export_pixels_row+0x194>
     1c0: b9403016     	ldr	w22, [x0, #0x30]
     1c4: cb170117     	sub	x23, x8, x23
     1c8: 2a3503f8     	mvn	w24, w21
     1cc: 2a0703f9     	mov	w25, w7
     1d0: 7102cedf     	cmp	w22, #0xb3
     1d4: 2a1f03e8     	mov	w8, wzr
     1d8: 5400016c     	b.gt	0x204 <iq4_export_pixels_row+0x204>
     1dc: 2a1903fa     	mov	w26, w25
     1e0: 2a1503fb     	mov	w27, w21
     1e4: 34000296     	cbz	w22, 0x234 <iq4_export_pixels_row+0x234>
     1e8: 71016adf     	cmp	w22, #0x5a
     1ec: 54000541     	b.ne	0x294 <iq4_export_pixels_row+0x294>
     1f0: b9403c08     	ldr	w8, [x0, #0x3c]
     1f4: 2a3903fa     	mvn	w26, w25
     1f8: 0b1a011b     	add	w27, w8, w26
     1fc: 2a1503fa     	mov	w26, w21
     200: 1400000d     	b	0x234 <iq4_export_pixels_row+0x234>
     204: 7102d2df     	cmp	w22, #0xb4
     208: 540000e0     	b.eq	0x224 <iq4_export_pixels_row+0x224>
     20c: 71043adf     	cmp	w22, #0x10e
     210: 54000421     	b.ne	0x294 <iq4_export_pixels_row+0x294>
     214: b9403808     	ldr	w8, [x0, #0x38]
     218: 2a1903fb     	mov	w27, w25
     21c: 0b18011a     	add	w26, w8, w24
     220: 14000005     	b	0x234 <iq4_export_pixels_row+0x234>
     224: 29476c08     	ldp	w8, w27, [x0, #0x38]
     228: 2a3903fa     	mvn	w26, w25
     22c: 0b1a011a     	add	w26, w8, w26
     230: 0b18037b     	add	w27, w27, w24
     234: f9400008     	ldr	x8, [x0]
     238: b40002e8     	cbz	x8, 0x294 <iq4_export_pixels_row+0x294>
     23c: 9bb9295c     	umaddl	x28, w10, w25, x10
     240: f940081d     	ldr	x29, [x0, #0x10]
     244: 2a1b03fb     	mov	w27, w27
     248: 9bb97d5e     	umull	x30, w10, w25
     24c: 11000739     	add	w25, w25, #0x1
     250: 9b1b23a8     	madd	x8, x29, x27, x8
     254: eb1c027f     	cmp	x19, x28
     258: 9a9c327b     	csel	x27, x19, x28, lo
     25c: eb1e00df     	cmp	x6, x30
     260: 9a9e80dc     	csel	x28, x6, x30, hi
     264: 6b14033f     	cmp	w25, w20
     268: cb1c037b     	sub	x27, x27, x28
     26c: 9b177f7b     	mul	x27, x27, x23
     270: 8b3a4908     	add	x8, x8, w26, uxtw #2
     274: 3940051a     	ldrb	w26, [x8, #0x1]
     278: 3940091c     	ldrb	w28, [x8, #0x2]
     27c: 39400d08     	ldrb	w8, [x8, #0x3]
     280: 9b1a1765     	madd	x5, x27, x26, x5
     284: 9b1c1364     	madd	x4, x27, x28, x4
     288: 9b080f63     	madd	x3, x27, x8, x3
     28c: 54fffa29     	b.ls	0x1d0 <iq4_export_pixels_row+0x1d0>
     290: 17ffffc1     	b	0x194 <iq4_export_pixels_row+0x194>
     294: a9454ff4     	ldp	x20, x19, [sp, #0x50]
     298: a94457f6     	ldp	x22, x21, [sp, #0x40]
     29c: a9435ff8     	ldp	x24, x23, [sp, #0x30]
     2a0: a94267fa     	ldp	x26, x25, [sp, #0x20]
     2a4: a9416ffc     	ldp	x28, x27, [sp, #0x10]
     2a8: a8c67bfd     	ldp	x29, x30, [sp], #0x60
     2ac: 2a0803e0     	mov	w0, w8
     2b0: d65f03c0     	ret
