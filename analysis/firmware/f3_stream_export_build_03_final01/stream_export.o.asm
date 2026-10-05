
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_stream_export_build_03_final01/stream_export.o:	file format elf64-littleaarch64

Disassembly of section .text.f3_jpeg_syntax_init_03:

0000000000000000 <f3_jpeg_syntax_init_03>:
       0: 6f00e400     	movi	v0.2d, #0000000000000000
       4: ad000000     	stp	q0, q0, [x0]
       8: ad010000     	stp	q0, q0, [x0, #0x20]
       c: d65f03c0     	ret

Disassembly of section .text.f3_jpeg_syntax_feed_03:

0000000000000000 <f3_jpeg_syntax_feed_03>:
       0: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
       4: a9016ffc     	stp	x28, x27, [sp, #0x10]
       8: a90267fa     	stp	x26, x25, [sp, #0x20]
       c: a9035ff8     	stp	x24, x23, [sp, #0x30]
      10: a90457f6     	stp	x22, x21, [sp, #0x40]
      14: a9054ff4     	stp	x20, x19, [sp, #0x50]
      18: 910003fd     	mov	x29, sp
      1c: b40000a0     	cbz	x0, 0x30 <f3_jpeg_syntax_feed_03+0x30>
      20: b9402808     	ldr	w8, [x0, #0x28]
      24: 35000068     	cbnz	w8, 0x30 <f3_jpeg_syntax_feed_03+0x30>
      28: b5000161     	cbnz	x1, 0x54 <f3_jpeg_syntax_feed_03+0x54>
      2c: b4000142     	cbz	x2, 0x54 <f3_jpeg_syntax_feed_03+0x54>
      30: 2a1f03f3     	mov	w19, wzr
      34: 2a1303e0     	mov	w0, w19
      38: a9454ff4     	ldp	x20, x19, [sp, #0x50]
      3c: a94457f6     	ldp	x22, x21, [sp, #0x40]
      40: a9435ff8     	ldp	x24, x23, [sp, #0x30]
      44: a94267fa     	ldp	x26, x25, [sp, #0x20]
      48: a9416ffc     	ldp	x28, x27, [sp, #0x10]
      4c: a8c67bfd     	ldp	x29, x30, [sp], #0x60
      50: d65f03c0     	ret
      54: 52800033     	mov	w19, #0x1               // =1
      58: b4fffee2     	cbz	x2, 0x34 <f3_jpeg_syntax_feed_03+0x34>
      5c: d2800239     	mov	x25, #0x11              // =17
      60: 9100b015     	add	x21, x0, #0x2c
      64: 52800056     	mov	w22, #0x2               // =2
      68: f2a50019     	movk	x25, #0x2800, lsl #16
      6c: 52800077     	mov	w23, #0x3               // =3
      70: 5280008b     	mov	w11, #0x4               // =4
      74: f2e80019     	movk	x25, #0x4000, lsl #48
      78: 528000ba     	mov	w26, #0x5               // =5
      7c: 528000db     	mov	w27, #0x6               // =6
      80: 5280010c     	mov	w12, #0x8               // =8
      84: 528000ed     	mov	w13, #0x7               // =7
      88: 14000006     	b	0xa0 <f3_jpeg_syntax_feed_03+0xa0>
      8c: 53185d08     	lsl	w8, w8, #8
      90: b900001a     	str	w26, [x0]
      94: b9000808     	str	w8, [x0, #0x8]
      98: f1000442     	subs	x2, x2, #0x1
      9c: 54001020     	b.eq	0x2a0 <f3_jpeg_syntax_feed_03+0x2a0>
      a0: b9400009     	ldr	w9, [x0]
      a4: 38401428     	ldrb	w8, [x1], #0x1
      a8: 71000d3f     	cmp	w9, #0x3
      ac: 5400024d     	b.le	0xf4 <f3_jpeg_syntax_feed_03+0xf4>
      b0: 7100153f     	cmp	w9, #0x5
      b4: 540004ad     	b.le	0x148 <f3_jpeg_syntax_feed_03+0x148>
      b8: 7100193f     	cmp	w9, #0x6
      bc: 54000880     	b.eq	0x1cc <f3_jpeg_syntax_feed_03+0x1cc>
      c0: 71001d3f     	cmp	w9, #0x7
      c4: 540006c0     	b.eq	0x19c <f3_jpeg_syntax_feed_03+0x19c>
      c8: 7100213f     	cmp	w9, #0x8
      cc: 54000ee1     	b.ne	0x2a8 <f3_jpeg_syntax_feed_03+0x2a8>
      d0: 340000c8     	cbz	w8, 0xe8 <f3_jpeg_syntax_feed_03+0xe8>
      d4: 7103fd1f     	cmp	w8, #0xff
      d8: 54fffe00     	b.eq	0x98 <f3_jpeg_syntax_feed_03+0x98>
      dc: 121d1109     	and	w9, w8, #0xf8
      e0: 7103413f     	cmp	w9, #0xd0
      e4: 54000d01     	b.ne	0x284 <f3_jpeg_syntax_feed_03+0x284>
      e8: b9002413     	str	w19, [x0, #0x24]
      ec: b900000d     	str	w13, [x0]
      f0: 17ffffea     	b	0x98 <f3_jpeg_syntax_feed_03+0x98>
      f4: 7100053f     	cmp	w9, #0x1
      f8: 5400010c     	b.gt	0x118 <f3_jpeg_syntax_feed_03+0x118>
      fc: 34000589     	cbz	w9, 0x1ac <f3_jpeg_syntax_feed_03+0x1ac>
     100: 7100053f     	cmp	w9, #0x1
     104: 54000d21     	b.ne	0x2a8 <f3_jpeg_syntax_feed_03+0x2a8>
     108: 7103611f     	cmp	w8, #0xd8
     10c: 54000ce1     	b.ne	0x2a8 <f3_jpeg_syntax_feed_03+0x2a8>
     110: b9000016     	str	w22, [x0]
     114: 17ffffe1     	b	0x98 <f3_jpeg_syntax_feed_03+0x98>
     118: 7100093f     	cmp	w9, #0x2
     11c: 54000500     	b.eq	0x1bc <f3_jpeg_syntax_feed_03+0x1bc>
     120: 71000d3f     	cmp	w9, #0x3
     124: 54000c21     	b.ne	0x2a8 <f3_jpeg_syntax_feed_03+0x2a8>
     128: 51030109     	sub	w9, w8, #0xc0
     12c: 7100fd3f     	cmp	w9, #0x3f
     130: 54000968     	b.hi	0x25c <f3_jpeg_syntax_feed_03+0x25c>
     134: 9ac9226a     	lsl	x10, x19, x9
     138: ea19015f     	tst	x10, x25
     13c: 540008c0     	b.eq	0x254 <f3_jpeg_syntax_feed_03+0x254>
     140: 2900200b     	stp	w11, w8, [x0]
     144: 17ffffd5     	b	0x98 <f3_jpeg_syntax_feed_03+0x98>
     148: 7100113f     	cmp	w9, #0x4
     14c: 54fffa00     	b.eq	0x8c <f3_jpeg_syntax_feed_03+0x8c>
     150: 7100153f     	cmp	w9, #0x5
     154: 54000aa1     	b.ne	0x2a8 <f3_jpeg_syntax_feed_03+0x2a8>
     158: b9400809     	ldr	w9, [x0, #0x8]
     15c: 2a080129     	orr	w9, w9, w8
     160: 71000928     	subs	w8, w9, #0x2
     164: b9000809     	str	w9, [x0, #0x8]
     168: 54000a03     	b.lo	0x2a8 <f3_jpeg_syntax_feed_03+0x2a8>
     16c: b940040a     	ldr	w10, [x0, #0x4]
     170: 7100453f     	cmp	w9, #0x11
     174: 54000060     	b.eq	0x180 <f3_jpeg_syntax_feed_03+0x180>
     178: 7103015f     	cmp	w10, #0xc0
     17c: 54000960     	b.eq	0x2a8 <f3_jpeg_syntax_feed_03+0x2a8>
     180: 7103755f     	cmp	w10, #0xdd
     184: 540003c0     	b.eq	0x1fc <f3_jpeg_syntax_feed_03+0x1fc>
     188: 7103695f     	cmp	w10, #0xda
     18c: 54000421     	b.ne	0x210 <f3_jpeg_syntax_feed_03+0x210>
     190: 7100313f     	cmp	w9, #0xc
     194: 54000380     	b.eq	0x204 <f3_jpeg_syntax_feed_03+0x204>
     198: 14000044     	b	0x2a8 <f3_jpeg_syntax_feed_03+0x2a8>
     19c: 7103fd1f     	cmp	w8, #0xff
     1a0: 540002a1     	b.ne	0x1f4 <f3_jpeg_syntax_feed_03+0x1f4>
     1a4: b900000c     	str	w12, [x0]
     1a8: 17ffffbc     	b	0x98 <f3_jpeg_syntax_feed_03+0x98>
     1ac: 7103fd1f     	cmp	w8, #0xff
     1b0: 540007c1     	b.ne	0x2a8 <f3_jpeg_syntax_feed_03+0x2a8>
     1b4: b9000013     	str	w19, [x0]
     1b8: 17ffffb8     	b	0x98 <f3_jpeg_syntax_feed_03+0x98>
     1bc: 7103fd1f     	cmp	w8, #0xff
     1c0: 54000741     	b.ne	0x2a8 <f3_jpeg_syntax_feed_03+0x2a8>
     1c4: b9000017     	str	w23, [x0]
     1c8: 17ffffb4     	b	0x98 <f3_jpeg_syntax_feed_03+0x98>
     1cc: b9401009     	ldr	w9, [x0, #0x10]
     1d0: 7100393f     	cmp	w9, #0xe
     1d4: 54000048     	b.hi	0x1dc <f3_jpeg_syntax_feed_03+0x1dc>
     1d8: 38296aa8     	strb	w8, [x21, x9]
     1dc: b9400c08     	ldr	w8, [x0, #0xc]
     1e0: 11000529     	add	w9, w9, #0x1
     1e4: 71000508     	subs	w8, w8, #0x1
     1e8: 2901a408     	stp	w8, w9, [x0, #0xc]
     1ec: 54fff561     	b.ne	0x98 <f3_jpeg_syntax_feed_03+0x98>
     1f0: 1400000c     	b	0x220 <f3_jpeg_syntax_feed_03+0x220>
     1f4: b9002413     	str	w19, [x0, #0x24]
     1f8: 17ffffa8     	b	0x98 <f3_jpeg_syntax_feed_03+0x98>
     1fc: 7100113f     	cmp	w9, #0x4
     200: 54000541     	b.ne	0x2a8 <f3_jpeg_syntax_feed_03+0x2a8>
     204: 2901fc08     	stp	w8, wzr, [x0, #0xc]
     208: b900001b     	str	w27, [x0]
     20c: 17ffffa3     	b	0x98 <f3_jpeg_syntax_feed_03+0x98>
     210: 71000928     	subs	w8, w9, #0x2
     214: b900001b     	str	w27, [x0]
     218: 2901fc08     	stp	w8, wzr, [x0, #0xc]
     21c: 54fff3e1     	b.ne	0x98 <f3_jpeg_syntax_feed_03+0x98>
     220: aa0003f4     	mov	x20, x0
     224: aa0203fc     	mov	x28, x2
     228: aa0103f8     	mov	x24, x1
     22c: 94000000     	bl	0x22c <f3_jpeg_syntax_feed_03+0x22c>
		000000000000022c:  R_AARCH64_CALL26	.text.segment_done
     230: 528000ed     	mov	w13, #0x7               // =7
     234: 5280010c     	mov	w12, #0x8               // =8
     238: 5280008b     	mov	w11, #0x4               // =4
     23c: aa1803e1     	mov	x1, x24
     240: aa1c03e2     	mov	x2, x28
     244: 2a0003e8     	mov	w8, w0
     248: aa1403e0     	mov	x0, x20
     24c: 35fff268     	cbnz	w8, 0x98 <f3_jpeg_syntax_feed_03+0x98>
     250: 14000016     	b	0x2a8 <f3_jpeg_syntax_feed_03+0x2a8>
     254: f100fd3f     	cmp	x9, #0x3f
     258: 54fff200     	b.eq	0x98 <f3_jpeg_syntax_feed_03+0x98>
     25c: 7103691f     	cmp	w8, #0xda
     260: 54000080     	b.eq	0x270 <f3_jpeg_syntax_feed_03+0x270>
     264: 121c0d09     	and	w9, w8, #0xf0
     268: 7103813f     	cmp	w9, #0xe0
     26c: 540001e1     	b.ne	0x2a8 <f3_jpeg_syntax_feed_03+0x2a8>
     270: 7103691f     	cmp	w8, #0xda
     274: 54fff661     	b.ne	0x140 <f3_jpeg_syntax_feed_03+0x140>
     278: b9401409     	ldr	w9, [x0, #0x14]
     27c: 35fff629     	cbnz	w9, 0x140 <f3_jpeg_syntax_feed_03+0x140>
     280: 1400000a     	b	0x2a8 <f3_jpeg_syntax_feed_03+0x2a8>
     284: 7103651f     	cmp	w8, #0xd9
     288: 54000101     	b.ne	0x2a8 <f3_jpeg_syntax_feed_03+0x2a8>
     28c: b9402408     	ldr	w8, [x0, #0x24]
     290: 340000c8     	cbz	w8, 0x2a8 <f3_jpeg_syntax_feed_03+0x2a8>
     294: 52800128     	mov	w8, #0x9                // =9
     298: b9000008     	str	w8, [x0]
     29c: 17ffff7f     	b	0x98 <f3_jpeg_syntax_feed_03+0x98>
     2a0: 52800033     	mov	w19, #0x1               // =1
     2a4: 17ffff64     	b	0x34 <f3_jpeg_syntax_feed_03+0x34>
     2a8: 52800028     	mov	w8, #0x1                // =1
     2ac: 2a1f03f3     	mov	w19, wzr
     2b0: b9002808     	str	w8, [x0, #0x28]
     2b4: 17ffff60     	b	0x34 <f3_jpeg_syntax_feed_03+0x34>

Disassembly of section .text.segment_done:

0000000000000000 <segment_done>:
       0: b9400408     	ldr	w8, [x0, #0x4]
       4: 7103691f     	cmp	w8, #0xda
       8: 54000a40     	b.eq	0x150 <segment_done+0x150>
       c: 7103011f     	cmp	w8, #0xc0
      10: 54000981     	b.ne	0x140 <segment_done+0x140>
      14: b9401408     	ldr	w8, [x0, #0x14]
      18: 35001248     	cbnz	w8, 0x260 <segment_done+0x260>
      1c: b9400808     	ldr	w8, [x0, #0x8]
      20: 7100451f     	cmp	w8, #0x11
      24: 540011e1     	b.ne	0x260 <segment_done+0x260>
      28: 3940b008     	ldrb	w8, [x0, #0x2c]
      2c: 7100211f     	cmp	w8, #0x8
      30: 54001181     	b.ne	0x260 <segment_done+0x260>
      34: 3940c408     	ldrb	w8, [x0, #0x31]
      38: 71000d1f     	cmp	w8, #0x3
      3c: 54001121     	b.ne	0x260 <segment_done+0x260>
      40: 7842d009     	ldurh	w9, [x0, #0x2d]
      44: 7842f00a     	ldurh	w10, [x0, #0x2f]
      48: 2a1f03e8     	mov	w8, wzr
      4c: 5ac00529     	rev16	w9, w9
      50: 5ac0054a     	rev16	w10, w10
      54: 2903a40a     	stp	w10, w9, [x0, #0x1c]
      58: 3400108a     	cbz	w10, 0x268 <segment_done+0x268>
      5c: 34001069     	cbz	w9, 0x268 <segment_done+0x268>
      60: 3940cc09     	ldrb	w9, [x0, #0x33]
      64: 7100413f     	cmp	w9, #0x10
      68: 54000fc3     	b.lo	0x260 <segment_done+0x260>
      6c: 71013d3f     	cmp	w9, #0x4f
      70: 2a1f03e8     	mov	w8, wzr
      74: 54000fa8     	b.hi	0x268 <segment_done+0x268>
      78: 12000d29     	and	w9, w9, #0xf
      7c: 34000f69     	cbz	w9, 0x268 <segment_done+0x268>
      80: 7100113f     	cmp	w9, #0x4
      84: 2a1f03e8     	mov	w8, wzr
      88: 54000f08     	b.hi	0x268 <segment_done+0x268>
      8c: 3940d009     	ldrb	w9, [x0, #0x34]
      90: 71000d3f     	cmp	w9, #0x3
      94: 54000ea8     	b.hi	0x268 <segment_done+0x268>
      98: 3940d80a     	ldrb	w10, [x0, #0x36]
      9c: 3940c809     	ldrb	w9, [x0, #0x32]
      a0: 7100415f     	cmp	w10, #0x10
      a4: 3900ec09     	strb	w9, [x0, #0x3b]
      a8: 54000dc3     	b.lo	0x260 <segment_done+0x260>
      ac: 71013d5f     	cmp	w10, #0x4f
      b0: 2a1f03e8     	mov	w8, wzr
      b4: 54000da8     	b.hi	0x268 <segment_done+0x268>
      b8: 12000d4a     	and	w10, w10, #0xf
      bc: 34000d6a     	cbz	w10, 0x268 <segment_done+0x268>
      c0: 7100115f     	cmp	w10, #0x4
      c4: 2a1f03e8     	mov	w8, wzr
      c8: 54000d08     	b.hi	0x268 <segment_done+0x268>
      cc: 3940dc0a     	ldrb	w10, [x0, #0x37]
      d0: 71000d5f     	cmp	w10, #0x3
      d4: 54000ca8     	b.hi	0x268 <segment_done+0x268>
      d8: 3940d40a     	ldrb	w10, [x0, #0x35]
      dc: 6b0a013f     	cmp	w9, w10
      e0: 54000c40     	b.eq	0x268 <segment_done+0x268>
      e4: 3940e40b     	ldrb	w11, [x0, #0x39]
      e8: 3900f00a     	strb	w10, [x0, #0x3c]
      ec: 7100417f     	cmp	w11, #0x10
      f0: 54000b83     	b.lo	0x260 <segment_done+0x260>
      f4: 71013d7f     	cmp	w11, #0x4f
      f8: 2a1f03e8     	mov	w8, wzr
      fc: 54000b68     	b.hi	0x268 <segment_done+0x268>
     100: 12000d6b     	and	w11, w11, #0xf
     104: 34000b2b     	cbz	w11, 0x268 <segment_done+0x268>
     108: 7100117f     	cmp	w11, #0x4
     10c: 2a1f03e8     	mov	w8, wzr
     110: 54000ac8     	b.hi	0x268 <segment_done+0x268>
     114: 3940e80b     	ldrb	w11, [x0, #0x3a]
     118: 71000d7f     	cmp	w11, #0x3
     11c: 54000a68     	b.hi	0x268 <segment_done+0x268>
     120: 3940e00b     	ldrb	w11, [x0, #0x38]
     124: 6b0b013f     	cmp	w9, w11
     128: 54000a00     	b.eq	0x268 <segment_done+0x268>
     12c: 6b0b015f     	cmp	w10, w11
     130: 540009c0     	b.eq	0x268 <segment_done+0x268>
     134: 52800028     	mov	w8, #0x1                // =1
     138: 3900f40b     	strb	w11, [x0, #0x3d]
     13c: b9001408     	str	w8, [x0, #0x14]
     140: 52800048     	mov	w8, #0x2                // =2
     144: b9000008     	str	w8, [x0]
     148: 52800028     	mov	w8, #0x1                // =1
     14c: 14000047     	b	0x268 <segment_done+0x268>
     150: b9401408     	ldr	w8, [x0, #0x14]
     154: 340008a8     	cbz	w8, 0x268 <segment_done+0x268>
     158: b9401808     	ldr	w8, [x0, #0x18]
     15c: 35000828     	cbnz	w8, 0x260 <segment_done+0x260>
     160: b9400808     	ldr	w8, [x0, #0x8]
     164: 7100311f     	cmp	w8, #0xc
     168: 540007c1     	b.ne	0x260 <segment_done+0x260>
     16c: 3940b008     	ldrb	w8, [x0, #0x2c]
     170: 71000d1f     	cmp	w8, #0x3
     174: 54000761     	b.ne	0x260 <segment_done+0x260>
     178: 3940cc08     	ldrb	w8, [x0, #0x33]
     17c: 35000728     	cbnz	w8, 0x260 <segment_done+0x260>
     180: 3940d008     	ldrb	w8, [x0, #0x34]
     184: 7100fd1f     	cmp	w8, #0x3f
     188: 540006c1     	b.ne	0x260 <segment_done+0x260>
     18c: 3940d408     	ldrb	w8, [x0, #0x35]
     190: 35000688     	cbnz	w8, 0x260 <segment_done+0x260>
     194: 3940b409     	ldrb	w9, [x0, #0x2d]
     198: 3940f00b     	ldrb	w11, [x0, #0x3c]
     19c: 3940ec0a     	ldrb	w10, [x0, #0x3b]
     1a0: 3940f40d     	ldrb	w13, [x0, #0x3d]
     1a4: 6b0b013f     	cmp	w9, w11
     1a8: 1a9f17e8     	cset	w8, eq
     1ac: 6b0a013f     	cmp	w9, w10
     1b0: 1a881508     	cinc	w8, w8, eq
     1b4: 6b0d013f     	cmp	w9, w13
     1b8: 1a881508     	cinc	w8, w8, eq
     1bc: 7100051f     	cmp	w8, #0x1
     1c0: 54000501     	b.ne	0x260 <segment_done+0x260>
     1c4: 3940b808     	ldrb	w8, [x0, #0x2e]
     1c8: 7202e51f     	tst	w8, #0xcccccccc
     1cc: 540004a1     	b.ne	0x260 <segment_done+0x260>
     1d0: 3940bc0c     	ldrb	w12, [x0, #0x2f]
     1d4: 6b0b019f     	cmp	w12, w11
     1d8: 1a9f17e8     	cset	w8, eq
     1dc: 6b0a019f     	cmp	w12, w10
     1e0: 1a881508     	cinc	w8, w8, eq
     1e4: 6b0d019f     	cmp	w12, w13
     1e8: 1a881508     	cinc	w8, w8, eq
     1ec: 7100051f     	cmp	w8, #0x1
     1f0: 54000381     	b.ne	0x260 <segment_done+0x260>
     1f4: 3940c008     	ldrb	w8, [x0, #0x30]
     1f8: 7202e51f     	tst	w8, #0xcccccccc
     1fc: 2a1f03e8     	mov	w8, wzr
     200: 54000341     	b.ne	0x268 <segment_done+0x268>
     204: 6b09019f     	cmp	w12, w9
     208: 54000300     	b.eq	0x268 <segment_done+0x268>
     20c: 3940c40e     	ldrb	w14, [x0, #0x31]
     210: 6b0b01df     	cmp	w14, w11
     214: 1a9f17e8     	cset	w8, eq
     218: 6b0a01df     	cmp	w14, w10
     21c: 1a881508     	cinc	w8, w8, eq
     220: 6b0d01df     	cmp	w14, w13
     224: 1a881508     	cinc	w8, w8, eq
     228: 7100051f     	cmp	w8, #0x1
     22c: 540001a1     	b.ne	0x260 <segment_done+0x260>
     230: 3940c808     	ldrb	w8, [x0, #0x32]
     234: 7202e51f     	tst	w8, #0xcccccccc
     238: 2a1f03e8     	mov	w8, wzr
     23c: 54000161     	b.ne	0x268 <segment_done+0x268>
     240: 6b0901df     	cmp	w14, w9
     244: 54000120     	b.eq	0x268 <segment_done+0x268>
     248: 6b0c01df     	cmp	w14, w12
     24c: 540000e0     	b.eq	0x268 <segment_done+0x268>
     250: 52800028     	mov	w8, #0x1                // =1
     254: b9001808     	str	w8, [x0, #0x18]
     258: 528000e8     	mov	w8, #0x7                // =7
     25c: 17ffffba     	b	0x144 <segment_done+0x144>
     260: 2a1f03e0     	mov	w0, wzr
     264: d65f03c0     	ret
     268: 2a0803e0     	mov	w0, w8
     26c: d65f03c0     	ret

Disassembly of section .text.f3_jpeg_syntax_done_03:

0000000000000000 <f3_jpeg_syntax_done_03>:
       0: b4000240     	cbz	x0, 0x48 <f3_jpeg_syntax_done_03+0x48>
       4: b9402808     	ldr	w8, [x0, #0x28]
       8: 35000228     	cbnz	w8, 0x4c <f3_jpeg_syntax_done_03+0x4c>
       c: b9400008     	ldr	w8, [x0]
      10: 7100251f     	cmp	w8, #0x9
      14: 540001c1     	b.ne	0x4c <f3_jpeg_syntax_done_03+0x4c>
      18: b9401408     	ldr	w8, [x0, #0x14]
      1c: 34000188     	cbz	w8, 0x4c <f3_jpeg_syntax_done_03+0x4c>
      20: b9401808     	ldr	w8, [x0, #0x18]
      24: 34000148     	cbz	w8, 0x4c <f3_jpeg_syntax_done_03+0x4c>
      28: b9402408     	ldr	w8, [x0, #0x24]
      2c: 34000108     	cbz	w8, 0x4c <f3_jpeg_syntax_done_03+0x4c>
      30: b9401c08     	ldr	w8, [x0, #0x1c]
      34: 6b01011f     	cmp	w8, w1
      38: 540000a1     	b.ne	0x4c <f3_jpeg_syntax_done_03+0x4c>
      3c: b9402008     	ldr	w8, [x0, #0x20]
      40: 6b02011f     	cmp	w8, w2
      44: 1a9f17e0     	cset	w0, eq
      48: d65f03c0     	ret
      4c: 2a1f03e0     	mov	w0, wzr
      50: d65f03c0     	ret

Disassembly of section .text.f3_stream_hold_03:

0000000000000000 <f3_stream_hold_03>:
       0: b40001a0     	cbz	x0, 0x34 <f3_stream_hold_03+0x34>
       4: 52800068     	mov	w8, #0x3                // =3
       8: f9400409     	ldr	x9, [x0, #0x8]
       c: 528000aa     	mov	w10, #0x5               // =5
      10: b9000008     	str	w8, [x0]
      14: 91040008     	add	x8, x0, #0x100
      18: b901000a     	str	w10, [x0, #0x100]
      1c: b9010401     	str	w1, [x0, #0x104]
      20: b40000c9     	cbz	x9, 0x38 <f3_stream_hold_03+0x38>
      24: 0f000420     	movi	v0.2s, #0x1
      28: aa0803e0     	mov	x0, x8
      2c: fd000520     	str	d0, [x9, #0x8]
      30: d65f03c0     	ret
      34: aa1f03e8     	mov	x8, xzr
      38: aa0803e0     	mov	x0, x8
      3c: d65f03c0     	ret

Disassembly of section .text.f3_stream_sink_write_03:

0000000000000000 <f3_stream_sink_write_03>:
       0: b40007a0     	cbz	x0, 0xf4 <f3_stream_sink_write_03+0xf4>
       4: f9400408     	ldr	x8, [x0, #0x8]
       8: b4000748     	cbz	x8, 0xf0 <f3_stream_sink_write_03+0xf0>
       c: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
      10: f9000bf5     	str	x21, [sp, #0x10]
      14: a9024ff4     	stp	x20, x19, [sp, #0x20]
      18: 910003fd     	mov	x29, sp
      1c: b9400d09     	ldr	w9, [x8, #0xc]
      20: 340005e9     	cbz	w9, 0xdc <f3_stream_sink_write_03+0xdc>
      24: b9400908     	ldr	w8, [x8, #0x8]
      28: 350005a8     	cbnz	w8, 0xdc <f3_stream_sink_write_03+0xdc>
      2c: b9400008     	ldr	w8, [x0]
      30: 7100051f     	cmp	w8, #0x1
      34: 54000541     	b.ne	0xdc <f3_stream_sink_write_03+0xdc>
      38: b9410808     	ldr	w8, [x0, #0x108]
      3c: 34000508     	cbz	w8, 0xdc <f3_stream_sink_write_03+0xdc>
      40: b4000461     	cbz	x1, 0xcc <f3_stream_sink_write_03+0xcc>
      44: b2607fe8     	mov	x8, #-0x100000000       // =-4294967296
      48: b26083e9     	mov	x9, #-0xffffffff        // =-4294967295
      4c: 8b080048     	add	x8, x2, x8
      50: eb09011f     	cmp	x8, x9
      54: 540003c3     	b.lo	0xcc <f3_stream_sink_write_03+0xcc>
      58: f940b008     	ldr	x8, [x0, #0x160]
      5c: f9410809     	ldr	x9, [x0, #0x210]
      60: eb080128     	subs	x8, x9, x8
      64: 54000343     	b.lo	0xcc <f3_stream_sink_write_03+0xcc>
      68: eb08005f     	cmp	x2, x8
      6c: 54000308     	b.hi	0xcc <f3_stream_sink_write_03+0xcc>
      70: ab02003f     	cmn	x1, x2
      74: 1a9f37e8     	cset	w8, hs
      78: b10b241f     	cmn	x0, #0x2c9
      7c: 54000288     	b.hi	0xcc <f3_stream_sink_write_03+0xcc>
      80: 37000268     	tbnz	w8, #0x0, 0xcc <f3_stream_sink_write_03+0xcc>
      84: 910b2008     	add	x8, x0, #0x2c8
      88: eb01011f     	cmp	x8, x1
      8c: 54000089     	b.ls	0x9c <f3_stream_sink_write_03+0x9c>
      90: 8b010048     	add	x8, x2, x1
      94: eb00011f     	cmp	x8, x0
      98: 540001a8     	b.hi	0xcc <f3_stream_sink_write_03+0xcc>
      9c: f9410008     	ldr	x8, [x0, #0x200]
      a0: f9410403     	ldr	x3, [x0, #0x208]
      a4: aa0003f5     	mov	x21, x0
      a8: aa0103e0     	mov	x0, x1
      ac: aa0103f3     	mov	x19, x1
      b0: aa0203e1     	mov	x1, x2
      b4: aa0203f4     	mov	x20, x2
      b8: aa0803e2     	mov	x2, x8
      bc: 94000000     	bl	0xbc <f3_stream_sink_write_03+0xbc>
		00000000000000bc:  R_AARCH64_CALL26	.text.overlap
      c0: 2a0003e8     	mov	w8, w0
      c4: aa1503e0     	mov	x0, x21
      c8: 34000188     	cbz	w8, 0xf8 <f3_stream_sink_write_03+0xf8>
      cc: 0f000480     	movi	v0.2s, #0x4
      d0: 52800049     	mov	w9, #0x2                // =2
      d4: b9000009     	str	w9, [x0]
      d8: fd008000     	str	d0, [x0, #0x100]
      dc: aa1f03e0     	mov	x0, xzr
      e0: a9424ff4     	ldp	x20, x19, [sp, #0x20]
      e4: f9400bf5     	ldr	x21, [sp, #0x10]
      e8: a8c37bfd     	ldp	x29, x30, [sp], #0x30
      ec: d65f03c0     	ret
      f0: aa1f03e0     	mov	x0, xzr
      f4: d65f03c0     	ret
      f8: 910a22a0     	add	x0, x21, #0x288
      fc: aa1303e1     	mov	x1, x19
     100: aa1403e2     	mov	x2, x20
     104: 94000000     	bl	0x104 <f3_stream_sink_write_03+0x104>
		0000000000000104:  R_AARCH64_CALL26	f3_jpeg_syntax_feed_03
     108: 2a0003e8     	mov	w8, w0
     10c: aa1503e0     	mov	x0, x21
     110: 34fffde8     	cbz	w8, 0xcc <f3_stream_sink_write_03+0xcc>
     114: b9411c08     	ldr	w8, [x0, #0x11c]
     118: f940600a     	ldr	x10, [x0, #0xc0]
     11c: aa1303e1     	mov	x1, x19
     120: aa1403e2     	mov	x2, x20
     124: 11000509     	add	w9, w8, #0x1
     128: f9405408     	ldr	x8, [x0, #0xa8]
     12c: b9011c09     	str	w9, [x0, #0x11c]
     130: aa0803e0     	mov	x0, x8
     134: d63f0140     	blr	x10
     138: 34000120     	cbz	w0, 0x15c <f3_stream_sink_write_03+0x15c>
     13c: 7100041f     	cmp	w0, #0x1
     140: 54000121     	b.ne	0x164 <f3_stream_sink_write_03+0x164>
     144: 0f000480     	movi	v0.2s, #0x4
     148: 52800048     	mov	w8, #0x2                // =2
     14c: aa1f03e0     	mov	x0, xzr
     150: b90002a8     	str	w8, [x21]
     154: fd0082a0     	str	d0, [x21, #0x100]
     158: 17ffffe2     	b	0xe0 <f3_stream_sink_write_03+0xe0>
     15c: eb14003f     	cmp	x1, x20
     160: 54000189     	b.ls	0x190 <f3_stream_sink_write_03+0x190>
     164: 90000008     	adrp	x8, 0x0 <f3_stream_sink_write_03>
		0000000000000164:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x50
     168: 52800069     	mov	w9, #0x3                // =3
     16c: fd400100     	ldr	d0, [x8]
		000000000000016c:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x50
     170: f94006a8     	ldr	x8, [x21, #0x8]
     174: b90002a9     	str	w9, [x21]
     178: fd0082a0     	str	d0, [x21, #0x100]
     17c: b4fffb08     	cbz	x8, 0xdc <f3_stream_sink_write_03+0xdc>
     180: 0f000420     	movi	v0.2s, #0x1
     184: aa1f03e0     	mov	x0, xzr
     188: fd000500     	str	d0, [x8, #0x8]
     18c: 17ffffd5     	b	0xe0 <f3_stream_sink_write_03+0xe0>
     190: f940b2a9     	ldr	x9, [x21, #0x160]
     194: eb14003f     	cmp	x1, x20
     198: 8b010129     	add	x9, x9, x1
     19c: f900b2a9     	str	x9, [x21, #0x160]
     1a0: 540000e1     	b.ne	0x1bc <f3_stream_sink_write_03+0x1bc>
     1a4: 910862a0     	add	x0, x21, #0x218
     1a8: aa1303e1     	mov	x1, x19
     1ac: aa1403e2     	mov	x2, x20
     1b0: 94000000     	bl	0x1b0 <f3_stream_sink_write_03+0x1b0>
		00000000000001b0:  R_AARCH64_CALL26	.text.f4_sha_update
     1b4: aa1403e0     	mov	x0, x20
     1b8: 17ffffca     	b	0xe0 <f3_stream_sink_write_03+0xe0>
     1bc: 0f000480     	movi	v0.2s, #0x4
     1c0: 52800048     	mov	w8, #0x2                // =2
     1c4: aa0103e0     	mov	x0, x1
     1c8: 17ffffe2     	b	0x150 <f3_stream_sink_write_03+0x150>

Disassembly of section .text.overlap:

0000000000000000 <overlap>:
       0: aa0003e8     	mov	x8, x0
       4: 2a1f03e0     	mov	w0, wzr
       8: b4000203     	cbz	x3, 0x48 <overlap+0x48>
       c: b40001e1     	cbz	x1, 0x48 <overlap+0x48>
      10: b40001c8     	cbz	x8, 0x48 <overlap+0x48>
      14: b40001a2     	cbz	x2, 0x48 <overlap+0x48>
      18: ab01011f     	cmn	x8, x1
      1c: 52800020     	mov	w0, #0x1                // =1
      20: 1a9f37ea     	cset	w10, hs
      24: ab03005f     	cmn	x2, x3
      28: 1a9f37e9     	cset	w9, hs
      2c: 370000ea     	tbnz	w10, #0x0, 0x48 <overlap+0x48>
      30: 370000c9     	tbnz	w9, #0x0, 0x48 <overlap+0x48>
      34: 8b080029     	add	x9, x1, x8
      38: 8b02006a     	add	x10, x3, x2
      3c: eb02013f     	cmp	x9, x2
      40: fa488140     	ccmp	x10, x8, #0x0, hi
      44: 1a9f97e0     	cset	w0, hi
      48: d65f03c0     	ret

Disassembly of section .text.observe:

0000000000000000 <observe>:
       0: 34000161     	cbz	w1, 0x2c <observe+0x2c>
       4: 7100043f     	cmp	w1, #0x1
       8: 54000161     	b.ne	0x34 <observe+0x34>
       c: aa0003e8     	mov	x8, x0
      10: 2a1f03e0     	mov	w0, wzr
      14: 52800049     	mov	w9, #0x2                // =2
      18: 5280008a     	mov	w10, #0x4               // =4
      1c: b9000109     	str	w9, [x8]
      20: b901010a     	str	w10, [x8, #0x100]
      24: b9010503     	str	w3, [x8, #0x104]
      28: d65f03c0     	ret
      2c: 52800020     	mov	w0, #0x1                // =1
      30: d65f03c0     	ret
      34: b4000160     	cbz	x0, 0x60 <observe+0x60>
      38: 52800069     	mov	w9, #0x3                // =3
      3c: 528000aa     	mov	w10, #0x5               // =5
      40: f9400408     	ldr	x8, [x0, #0x8]
      44: b9000009     	str	w9, [x0]
      48: b901000a     	str	w10, [x0, #0x100]
      4c: b9010403     	str	w3, [x0, #0x104]
      50: 2a1f03e0     	mov	w0, wzr
      54: b4000068     	cbz	x8, 0x60 <observe+0x60>
      58: 0f000420     	movi	v0.2s, #0x1
      5c: fd000500     	str	d0, [x8, #0x8]
      60: d65f03c0     	ret

Disassembly of section .text.f4_sha_update:

0000000000000000 <f4_sha_update>:
       0: f9401008     	ldr	x8, [x0, #0x20]
       4: 8b020108     	add	x8, x8, x2
       8: f9001008     	str	x8, [x0, #0x20]
       c: b40004c2     	cbz	x2, 0xa4 <f4_sha_update+0xa4>
      10: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
      14: a9015ff8     	stp	x24, x23, [sp, #0x10]
      18: a90257f6     	stp	x22, x21, [sp, #0x20]
      1c: a9034ff4     	stp	x20, x19, [sp, #0x30]
      20: 910003fd     	mov	x29, sp
      24: b9402808     	ldr	w8, [x0, #0x28]
      28: aa0203f3     	mov	x19, x2
      2c: aa0103f4     	mov	x20, x1
      30: aa0003f5     	mov	x21, x0
      34: 9100b016     	add	x22, x0, #0x2c
      38: 52800818     	mov	w24, #0x40              // =64
      3c: 14000004     	b	0x4c <f4_sha_update+0x4c>
      40: cb170273     	sub	x19, x19, x23
      44: 8b170294     	add	x20, x20, x23
      48: b4000273     	cbz	x19, 0x94 <f4_sha_update+0x94>
      4c: 4b080309     	sub	w9, w24, w8
      50: 8b2842c0     	add	x0, x22, w8, uxtw
      54: aa1403e1     	mov	x1, x20
      58: eb09027f     	cmp	x19, x9
      5c: 9a893277     	csel	x23, x19, x9, lo
      60: aa1703e2     	mov	x2, x23
      64: 94000000     	bl	0x64 <f4_sha_update+0x64>
		0000000000000064:  R_AARCH64_CALL26	memcpy
      68: b9402aa8     	ldr	w8, [x21, #0x28]
      6c: 0b170108     	add	w8, w8, w23
      70: 7101011f     	cmp	w8, #0x40
      74: b9002aa8     	str	w8, [x21, #0x28]
      78: 54fffe41     	b.ne	0x40 <f4_sha_update+0x40>
      7c: aa1503e0     	mov	x0, x21
      80: aa1603e1     	mov	x1, x22
      84: 94000000     	bl	0x84 <f4_sha_update+0x84>
		0000000000000084:  R_AARCH64_CALL26	.text.f4_sha_block
      88: 2a1f03e8     	mov	w8, wzr
      8c: b9002abf     	str	wzr, [x21, #0x28]
      90: 17ffffec     	b	0x40 <f4_sha_update+0x40>
      94: a9434ff4     	ldp	x20, x19, [sp, #0x30]
      98: a94257f6     	ldp	x22, x21, [sp, #0x20]
      9c: a9415ff8     	ldp	x24, x23, [sp, #0x10]
      a0: a8c47bfd     	ldp	x29, x30, [sp], #0x40
      a4: d65f03c0     	ret

Disassembly of section .text.f3_stream_abort_03:

0000000000000000 <f3_stream_abort_03>:
       0: b40001a0     	cbz	x0, 0x34 <f3_stream_abort_03+0x34>
       4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
       8: a9014ff4     	stp	x20, x19, [sp, #0x10]
       c: 910003fd     	mov	x29, sp
      10: f9400408     	ldr	x8, [x0, #0x8]
      14: b40000a8     	cbz	x8, 0x28 <f3_stream_abort_03+0x28>
      18: b9400d09     	ldr	w9, [x8, #0xc]
      1c: 34000069     	cbz	w9, 0x28 <f3_stream_abort_03+0x28>
      20: b9400908     	ldr	w8, [x8, #0x8]
      24: 340000a8     	cbz	w8, 0x38 <f3_stream_abort_03+0x38>
      28: 91040000     	add	x0, x0, #0x100
      2c: a9414ff4     	ldp	x20, x19, [sp, #0x10]
      30: a8c27bfd     	ldp	x29, x30, [sp], #0x20
      34: d65f03c0     	ret
      38: b9400008     	ldr	w8, [x0]
      3c: 7100051f     	cmp	w8, #0x1
      40: 54000080     	b.eq	0x50 <f3_stream_abort_03+0x50>
      44: 7100091f     	cmp	w8, #0x2
      48: 540000e0     	b.eq	0x64 <f3_stream_abort_03+0x64>
      4c: 17fffff7     	b	0x28 <f3_stream_abort_03+0x28>
      50: 90000008     	adrp	x8, 0x0 <f3_stream_abort_03>
		0000000000000050:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8
      54: 52800049     	mov	w9, #0x2                // =2
      58: fd400100     	ldr	d0, [x8]
		0000000000000058:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8
      5c: b9000009     	str	w9, [x0]
      60: fd008000     	str	d0, [x0, #0x100]
      64: b9410808     	ldr	w8, [x0, #0x108]
      68: 91040009     	add	x9, x0, #0x100
      6c: 34000308     	cbz	w8, 0xcc <f3_stream_abort_03+0xcc>
      70: b9412408     	ldr	w8, [x0, #0x124]
      74: aa0903f3     	mov	x19, x9
      78: f940640a     	ldr	x10, [x0, #0xc8]
      7c: aa0003f4     	mov	x20, x0
      80: 11000509     	add	w9, w8, #0x1
      84: f9405408     	ldr	x8, [x0, #0xa8]
      88: b9012409     	str	w9, [x0, #0x124]
      8c: aa0803e0     	mov	x0, x8
      90: d63f0140     	blr	x10
      94: aa0003e8     	mov	x8, x0
      98: aa1403e0     	mov	x0, x20
      9c: f27f791f     	tst	x8, #0xfffffffe
      a0: 54000041     	b.ne	0xa8 <f3_stream_abort_03+0xa8>
      a4: b901081f     	str	wzr, [x0, #0x108]
      a8: aa1303e9     	mov	x9, x19
      ac: 34000108     	cbz	w8, 0xcc <f3_stream_abort_03+0xcc>
      b0: 7100051f     	cmp	w8, #0x1
      b4: 54000441     	b.ne	0x13c <f3_stream_abort_03+0x13c>
      b8: 90000008     	adrp	x8, 0x0 <f3_stream_abort_03>
		00000000000000b8:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x38
      bc: 5280004a     	mov	w10, #0x2               // =2
      c0: fd400100     	ldr	d0, [x8]
		00000000000000c0:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x38
      c4: b900000a     	str	w10, [x0]
      c8: fd008000     	str	d0, [x0, #0x100]
      cc: b9410c08     	ldr	w8, [x0, #0x10c]
      d0: 340002c8     	cbz	w8, 0x128 <f3_stream_abort_03+0x128>
      d4: b9412808     	ldr	w8, [x0, #0x128]
      d8: aa0903f3     	mov	x19, x9
      dc: f940740a     	ldr	x10, [x0, #0xe8]
      e0: aa0003f4     	mov	x20, x0
      e4: 11000509     	add	w9, w8, #0x1
      e8: f9405408     	ldr	x8, [x0, #0xa8]
      ec: b9012809     	str	w9, [x0, #0x128]
      f0: aa0803e0     	mov	x0, x8
      f4: d63f0140     	blr	x10
      f8: aa0003e8     	mov	x8, x0
      fc: aa1403e0     	mov	x0, x20
     100: f27f791f     	tst	x8, #0xfffffffe
     104: 54000041     	b.ne	0x10c <f3_stream_abort_03+0x10c>
     108: b9010c1f     	str	wzr, [x0, #0x10c]
     10c: aa1303e9     	mov	x9, x19
     110: 340000c8     	cbz	w8, 0x128 <f3_stream_abort_03+0x128>
     114: 7100051f     	cmp	w8, #0x1
     118: 540001a1     	b.ne	0x14c <f3_stream_abort_03+0x14c>
     11c: 90000008     	adrp	x8, 0x0 <f3_stream_abort_03>
		000000000000011c:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x78
     120: fd400100     	ldr	d0, [x8]
		0000000000000120:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x78
     124: fd000120     	str	d0, [x9]
     128: f940040a     	ldr	x10, [x0, #0x8]
     12c: 52800088     	mov	w8, #0x4                // =4
     130: b9000008     	str	w8, [x0]
     134: b9000d5f     	str	wzr, [x10, #0xc]
     138: 1400000e     	b	0x170 <f3_stream_abort_03+0x170>
     13c: 90000008     	adrp	x8, 0x0 <f3_stream_abort_03>
		000000000000013c:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x28
     140: 5280006a     	mov	w10, #0x3               // =3
     144: fd400100     	ldr	d0, [x8]
		0000000000000144:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x28
     148: 14000004     	b	0x158 <f3_stream_abort_03+0x158>
     14c: 90000008     	adrp	x8, 0x0 <f3_stream_abort_03>
		000000000000014c:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x30
     150: 5280006a     	mov	w10, #0x3               // =3
     154: fd400100     	ldr	d0, [x8]
		0000000000000154:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x30
     158: f9400408     	ldr	x8, [x0, #0x8]
     15c: b900000a     	str	w10, [x0]
     160: fd008000     	str	d0, [x0, #0x100]
     164: b4000068     	cbz	x8, 0x170 <f3_stream_abort_03+0x170>
     168: 0f000420     	movi	v0.2s, #0x1
     16c: fd000500     	str	d0, [x8, #0x8]
     170: aa0903e0     	mov	x0, x9
     174: 17ffffae     	b	0x2c <f3_stream_abort_03+0x2c>

Disassembly of section .text.close_write:

0000000000000000 <close_write>:
       0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
       4: f9000bf3     	str	x19, [sp, #0x10]
       8: 910003fd     	mov	x29, sp
       c: b9412408     	ldr	w8, [x0, #0x124]
      10: aa0003f3     	mov	x19, x0
      14: f9406409     	ldr	x9, [x0, #0xc8]
      18: f9405400     	ldr	x0, [x0, #0xa8]
      1c: 11000508     	add	w8, w8, #0x1
      20: b9012668     	str	w8, [x19, #0x124]
      24: d63f0120     	blr	x9
      28: f27f781f     	tst	x0, #0xfffffffe
      2c: 54000160     	b.eq	0x58 <close_write+0x58>
      30: 34000180     	cbz	w0, 0x60 <close_write+0x60>
      34: 7100041f     	cmp	w0, #0x1
      38: 54000181     	b.ne	0x68 <close_write+0x68>
      3c: 90000008     	adrp	x8, 0x0 <close_write>
		000000000000003c:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x38
      40: 52800049     	mov	w9, #0x2                // =2
      44: 2a1f03e0     	mov	w0, wzr
      48: fd400100     	ldr	d0, [x8]
		0000000000000048:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x38
      4c: b9000269     	str	w9, [x19]
      50: fd008260     	str	d0, [x19, #0x100]
      54: 1400000f     	b	0x90 <close_write+0x90>
      58: b9010a7f     	str	wzr, [x19, #0x108]
      5c: 35fffec0     	cbnz	w0, 0x34 <close_write+0x34>
      60: 52800020     	mov	w0, #0x1                // =1
      64: 1400000b     	b	0x90 <close_write+0x90>
      68: 90000008     	adrp	x8, 0x0 <close_write>
		0000000000000068:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x28
      6c: 52800069     	mov	w9, #0x3                // =3
      70: 2a1f03e0     	mov	w0, wzr
      74: fd400100     	ldr	d0, [x8]
		0000000000000074:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x28
      78: f9400668     	ldr	x8, [x19, #0x8]
      7c: b9000269     	str	w9, [x19]
      80: fd008260     	str	d0, [x19, #0x100]
      84: b4000068     	cbz	x8, 0x90 <close_write+0x90>
      88: 0f000420     	movi	v0.2s, #0x1
      8c: fd000500     	str	d0, [x8, #0x8]
      90: f9400bf3     	ldr	x19, [sp, #0x10]
      94: a8c27bfd     	ldp	x29, x30, [sp], #0x20
      98: d65f03c0     	ret

Disassembly of section .text.close_read:

0000000000000000 <close_read>:
       0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
       4: f9000bf3     	str	x19, [sp, #0x10]
       8: 910003fd     	mov	x29, sp
       c: b9412808     	ldr	w8, [x0, #0x128]
      10: aa0003f3     	mov	x19, x0
      14: f9407409     	ldr	x9, [x0, #0xe8]
      18: f9405400     	ldr	x0, [x0, #0xa8]
      1c: 11000508     	add	w8, w8, #0x1
      20: b9012a68     	str	w8, [x19, #0x128]
      24: d63f0120     	blr	x9
      28: f27f781f     	tst	x0, #0xfffffffe
      2c: 54000160     	b.eq	0x58 <close_read+0x58>
      30: 34000180     	cbz	w0, 0x60 <close_read+0x60>
      34: 7100041f     	cmp	w0, #0x1
      38: 54000181     	b.ne	0x68 <close_read+0x68>
      3c: 90000008     	adrp	x8, 0x0 <close_read>
		000000000000003c:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x78
      40: 52800049     	mov	w9, #0x2                // =2
      44: 2a1f03e0     	mov	w0, wzr
      48: fd400100     	ldr	d0, [x8]
		0000000000000048:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x78
      4c: b9000269     	str	w9, [x19]
      50: fd008260     	str	d0, [x19, #0x100]
      54: 1400000f     	b	0x90 <close_read+0x90>
      58: b9010e7f     	str	wzr, [x19, #0x10c]
      5c: 35fffec0     	cbnz	w0, 0x34 <close_read+0x34>
      60: 52800020     	mov	w0, #0x1                // =1
      64: 1400000b     	b	0x90 <close_read+0x90>
      68: 90000008     	adrp	x8, 0x0 <close_read>
		0000000000000068:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x30
      6c: 52800069     	mov	w9, #0x3                // =3
      70: 2a1f03e0     	mov	w0, wzr
      74: fd400100     	ldr	d0, [x8]
		0000000000000074:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x30
      78: f9400668     	ldr	x8, [x19, #0x8]
      7c: b9000269     	str	w9, [x19]
      80: fd008260     	str	d0, [x19, #0x100]
      84: b4000068     	cbz	x8, 0x90 <close_read+0x90>
      88: 0f000420     	movi	v0.2s, #0x1
      8c: fd000500     	str	d0, [x8, #0x8]
      90: f9400bf3     	ldr	x19, [sp, #0x10]
      94: a8c27bfd     	ldp	x29, x30, [sp], #0x20
      98: d65f03c0     	ret

Disassembly of section .text.f3_stream_finish_03:

0000000000000000 <f3_stream_finish_03>:
       0: d104c3ff     	sub	sp, sp, #0x130
       4: a90e7bfd     	stp	x29, x30, [sp, #0xe0]
       8: a90f6bfc     	stp	x28, x26, [sp, #0xf0]
       c: a91063f9     	stp	x25, x24, [sp, #0x100]
      10: a91157f6     	stp	x22, x21, [sp, #0x110]
      14: a9124ff4     	stp	x20, x19, [sp, #0x120]
      18: 910383fd     	add	x29, sp, #0xe0
      1c: b4000100     	cbz	x0, 0x3c <f3_stream_finish_03+0x3c>
      20: f9400408     	ldr	x8, [x0, #0x8]
      24: b40000a8     	cbz	x8, 0x38 <f3_stream_finish_03+0x38>
      28: b9400d09     	ldr	w9, [x8, #0xc]
      2c: 34000069     	cbz	w9, 0x38 <f3_stream_finish_03+0x38>
      30: b9400908     	ldr	w8, [x8, #0x8]
      34: 34000128     	cbz	w8, 0x58 <f3_stream_finish_03+0x58>
      38: 91040000     	add	x0, x0, #0x100
      3c: a9524ff4     	ldp	x20, x19, [sp, #0x120]
      40: a95157f6     	ldp	x22, x21, [sp, #0x110]
      44: a95063f9     	ldp	x25, x24, [sp, #0x100]
      48: a94f6bfc     	ldp	x28, x26, [sp, #0xf0]
      4c: a94e7bfd     	ldp	x29, x30, [sp, #0xe0]
      50: 9104c3ff     	add	sp, sp, #0x130
      54: d65f03c0     	ret
      58: b9400008     	ldr	w8, [x0]
      5c: 7100051f     	cmp	w8, #0x1
      60: 54000080     	b.eq	0x70 <f3_stream_finish_03+0x70>
      64: 7100091f     	cmp	w8, #0x2
      68: 54000880     	b.eq	0x178 <f3_stream_finish_03+0x178>
      6c: 17fffff3     	b	0x38 <f3_stream_finish_03+0x38>
      70: b40007a1     	cbz	x1, 0x164 <f3_stream_finish_03+0x164>
      74: b9400028     	ldr	w8, [x1]
      78: 7100051f     	cmp	w8, #0x1
      7c: 54000741     	b.ne	0x164 <f3_stream_finish_03+0x164>
      80: b9400428     	ldr	w8, [x1, #0x4]
      84: 7100051f     	cmp	w8, #0x1
      88: 540006e1     	b.ne	0x164 <f3_stream_finish_03+0x164>
      8c: b9400828     	ldr	w8, [x1, #0x8]
      90: 7100051f     	cmp	w8, #0x1
      94: 54000681     	b.ne	0x164 <f3_stream_finish_03+0x164>
      98: b9400c22     	ldr	w2, [x1, #0xc]
      9c: b9404008     	ldr	w8, [x0, #0x40]
      a0: 6b08005f     	cmp	w2, w8
      a4: 54000601     	b.ne	0x164 <f3_stream_finish_03+0x164>
      a8: f9400835     	ldr	x21, [x1, #0x10]
      ac: b40005d5     	cbz	x21, 0x164 <f3_stream_finish_03+0x164>
      b0: f940b008     	ldr	x8, [x0, #0x160]
      b4: eb0802bf     	cmp	x21, x8
      b8: 54000561     	b.ne	0x164 <f3_stream_finish_03+0x164>
      bc: b9403c08     	ldr	w8, [x0, #0x3c]
      c0: aa0003f4     	mov	x20, x0
      c4: 910a2000     	add	x0, x0, #0x288
      c8: aa0103f8     	mov	x24, x1
      cc: 2a0803e1     	mov	w1, w8
      d0: 94000000     	bl	0xd0 <f3_stream_finish_03+0xd0>
		00000000000000d0:  R_AARCH64_CALL26	f3_jpeg_syntax_done_03
      d4: 2a0003e8     	mov	w8, w0
      d8: aa1403e0     	mov	x0, x20
      dc: 34000448     	cbz	w8, 0x164 <f3_stream_finish_03+0x164>
      e0: f900b415     	str	x21, [x0, #0x168]
      e4: aa0003f5     	mov	x21, x0
      e8: 9107d008     	add	x8, x0, #0x1f4
      ec: b20003e9     	mov	x9, #0x100000001        // =4294967297
      f0: 91040013     	add	x19, x0, #0x100
      f4: 91086000     	add	x0, x0, #0x218
      f8: 9105c2a1     	add	x1, x21, #0x170
      fc: f9000109     	str	x9, [x8]
     100: 94000000     	bl	0x100 <f3_stream_finish_03+0x100>
		0000000000000100:  R_AARCH64_CALL26	.text.f4_sha_end
     104: aa1503e0     	mov	x0, x21
     108: 94000000     	bl	0x108 <f3_stream_finish_03+0x108>
		0000000000000108:  R_AARCH64_CALL26	.text.close_write
     10c: 34001860     	cbz	w0, 0x418 <f3_stream_finish_03+0x418>
     110: 6f00e400     	movi	v0.2d, #0000000000000000
     114: f9400b08     	ldr	x8, [x24, #0x10]
     118: f9405680     	ldr	x0, [x20, #0xa8]
     11c: 9104e281     	add	x1, x20, #0x138
     120: d100c3a2     	sub	x2, x29, #0x30
     124: f81f03bf     	stur	xzr, [x29, #-0x10]
     128: f900ae88     	str	x8, [x20, #0x158]
     12c: f9406a88     	ldr	x8, [x20, #0xd0]
     130: ad3e83a0     	stp	q0, q0, [x29, #-0x30]
     134: d63f0100     	blr	x8
     138: 340002e0     	cbz	w0, 0x194 <f3_stream_finish_03+0x194>
     13c: 7100041f     	cmp	w0, #0x1
     140: 540017c1     	b.ne	0x438 <f3_stream_finish_03+0x438>
     144: 90000008     	adrp	x8, 0x0 <f3_stream_finish_03>
		0000000000000144:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x70
     148: 52800089     	mov	w9, #0x4                // =4
     14c: fd400100     	ldr	d0, [x8]
		000000000000014c:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x70
     150: f9400688     	ldr	x8, [x20, #0x8]
     154: b9000289     	str	w9, [x20]
     158: fd008280     	str	d0, [x20, #0x100]
     15c: b9000d1f     	str	wzr, [x8, #0xc]
     160: 140000bf     	b	0x45c <f3_stream_finish_03+0x45c>
     164: 90000008     	adrp	x8, 0x0 <f3_stream_finish_03>
		0000000000000164:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8
     168: 52800049     	mov	w9, #0x2                // =2
     16c: fd400100     	ldr	d0, [x8]
		000000000000016c:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8
     170: b9000009     	str	w9, [x0]
     174: fd008000     	str	d0, [x0, #0x100]
     178: a9524ff4     	ldp	x20, x19, [sp, #0x120]
     17c: a95157f6     	ldp	x22, x21, [sp, #0x110]
     180: a95063f9     	ldp	x25, x24, [sp, #0x100]
     184: a94f6bfc     	ldp	x28, x26, [sp, #0xf0]
     188: a94e7bfd     	ldp	x29, x30, [sp, #0xe0]
     18c: 9104c3ff     	add	sp, sp, #0x130
     190: 14000000     	b	0x190 <f3_stream_finish_03+0x190>
		0000000000000190:  R_AARCH64_JUMP26	f3_stream_abort_03
     194: f9409e88     	ldr	x8, [x20, #0x138]
     198: f85d03a9     	ldur	x9, [x29, #-0x30]
     19c: aa1403e0     	mov	x0, x20
     1a0: 5280002a     	mov	w10, #0x1               // =1
     1a4: eb09011f     	cmp	x8, x9
     1a8: b9010e8a     	str	w10, [x20, #0x10c]
     1ac: 540015c1     	b.ne	0x464 <f3_stream_finish_03+0x464>
     1b0: f940a008     	ldr	x8, [x0, #0x140]
     1b4: f85d83a9     	ldur	x9, [x29, #-0x28]
     1b8: eb09011f     	cmp	x8, x9
     1bc: 54001541     	b.ne	0x464 <f3_stream_finish_03+0x464>
     1c0: f940a408     	ldr	x8, [x0, #0x148]
     1c4: f85e03a9     	ldur	x9, [x29, #-0x20]
     1c8: eb09011f     	cmp	x8, x9
     1cc: 540014c1     	b.ne	0x464 <f3_stream_finish_03+0x464>
     1d0: f940a808     	ldr	x8, [x0, #0x150]
     1d4: f85e83a9     	ldur	x9, [x29, #-0x18]
     1d8: eb09011f     	cmp	x8, x9
     1dc: 54001441     	b.ne	0x464 <f3_stream_finish_03+0x464>
     1e0: f940ac08     	ldr	x8, [x0, #0x158]
     1e4: f85f03a9     	ldur	x9, [x29, #-0x10]
     1e8: eb09011f     	cmp	x8, x9
     1ec: 540013c1     	b.ne	0x464 <f3_stream_finish_03+0x464>
     1f0: 90000001     	adrp	x1, 0x0 <f3_stream_finish_03>
		00000000000001f0:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.f4_sha_init.iv
     1f4: 91000021     	add	x1, x1, #0x0
		00000000000001f4:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.f4_sha_init.iv
     1f8: 910103e0     	add	x0, sp, #0x40
     1fc: 52800402     	mov	w2, #0x20               // =32
     200: 94000000     	bl	0x200 <f3_stream_finish_03+0x200>
		0000000000000200:  R_AARCH64_CALL26	memcpy
     204: 6f00e400     	movi	v0.2d, #0000000000000000
     208: f9400b08     	ldr	x8, [x24, #0x10]
     20c: f90033ff     	str	xzr, [sp, #0x60]
     210: b9006bff     	str	wzr, [sp, #0x68]
     214: ad0003e0     	stp	q0, q0, [sp]
     218: ad0103e0     	stp	q0, q0, [sp, #0x20]
     21c: b40004e8     	cbz	x8, 0x2b8 <f3_stream_finish_03+0x2b8>
     220: aa1f03f9     	mov	x25, xzr
     224: 52a0003a     	mov	w26, #0x10000           // =65536
     228: 4b190108     	sub	w8, w8, w25
     22c: b9412289     	ldr	w9, [x20, #0x120]
     230: f9406e8a     	ldr	x10, [x20, #0xd8]
     234: 7140411f     	cmp	w8, #0x10, lsl #12      // =0x10000
     238: f9405680     	ldr	x0, [x20, #0xa8]
     23c: f9410281     	ldr	x1, [x20, #0x200]
     240: 1a9a3116     	csel	w22, w8, w26, lo
     244: 11000529     	add	w9, w9, #0x1
     248: 2a1603e2     	mov	w2, w22
     24c: b9012289     	str	w9, [x20, #0x120]
     250: d63f0140     	blr	x10
     254: aa0003e2     	mov	x2, x0
     258: aa0103f5     	mov	x21, x1
     25c: aa1403e0     	mov	x0, x20
     260: aa0203e1     	mov	x1, x2
     264: aa1503e2     	mov	x2, x21
     268: 52800123     	mov	w3, #0x9                // =9
     26c: 94000000     	bl	0x26c <f3_stream_finish_03+0x26c>
		000000000000026c:  R_AARCH64_CALL26	.text.observe
     270: 340011a0     	cbz	w0, 0x4a4 <f3_stream_finish_03+0x4a4>
     274: eb3642bf     	cmp	x21, w22, uxtw
     278: 54001041     	b.ne	0x480 <f3_stream_finish_03+0x480>
     27c: f9410296     	ldr	x22, [x20, #0x200]
     280: 910003e0     	mov	x0, sp
     284: aa1503e2     	mov	x2, x21
     288: aa1603e1     	mov	x1, x22
     28c: 94000000     	bl	0x28c <f3_stream_finish_03+0x28c>
		000000000000028c:  R_AARCH64_CALL26	f3_jpeg_syntax_feed_03
     290: 34000f80     	cbz	w0, 0x480 <f3_stream_finish_03+0x480>
     294: 910103e0     	add	x0, sp, #0x40
     298: aa1603e1     	mov	x1, x22
     29c: aa1503e2     	mov	x2, x21
     2a0: 94000000     	bl	0x2a0 <f3_stream_finish_03+0x2a0>
		00000000000002a0:  R_AARCH64_CALL26	.text.f4_sha_update
     2a4: f9400b08     	ldr	x8, [x24, #0x10]
     2a8: 8b150339     	add	x25, x25, x21
     2ac: f9009a99     	str	x25, [x20, #0x130]
     2b0: eb08033f     	cmp	x25, x8
     2b4: 54fffba3     	b.lo	0x228 <f3_stream_finish_03+0x228>
     2b8: 910103e0     	add	x0, sp, #0x40
     2bc: 9106c681     	add	x1, x20, #0x1b1
     2c0: 94000000     	bl	0x2c0 <f3_stream_finish_03+0x2c0>
		00000000000002c0:  R_AARCH64_CALL26	.text.f4_sha_end
     2c4: aa1f03e8     	mov	x8, xzr
     2c8: 8b08028a     	add	x10, x20, x8
     2cc: 3945c149     	ldrb	w9, [x10, #0x170]
     2d0: 3946c54a     	ldrb	w10, [x10, #0x1b1]
     2d4: 6b0a013f     	cmp	w9, w10
     2d8: 54000081     	b.ne	0x2e8 <f3_stream_finish_03+0x2e8>
     2dc: f101011f     	cmp	x8, #0x40
     2e0: 91000508     	add	x8, x8, #0x1
     2e4: 54ffff21     	b.ne	0x2c8 <f3_stream_finish_03+0x2c8>
     2e8: 6b0a013f     	cmp	w9, w10
     2ec: 54000ca1     	b.ne	0x480 <f3_stream_finish_03+0x480>
     2f0: b9402be8     	ldr	w8, [sp, #0x28]
     2f4: 35000c68     	cbnz	w8, 0x480 <f3_stream_finish_03+0x480>
     2f8: b94003e8     	ldr	w8, [sp]
     2fc: 7100251f     	cmp	w8, #0x9
     300: 54000c01     	b.ne	0x480 <f3_stream_finish_03+0x480>
     304: b94017e8     	ldr	w8, [sp, #0x14]
     308: 34000bc8     	cbz	w8, 0x480 <f3_stream_finish_03+0x480>
     30c: b9401be8     	ldr	w8, [sp, #0x18]
     310: 34000b88     	cbz	w8, 0x480 <f3_stream_finish_03+0x480>
     314: b94027e8     	ldr	w8, [sp, #0x24]
     318: 34000b48     	cbz	w8, 0x480 <f3_stream_finish_03+0x480>
     31c: b9403e88     	ldr	w8, [x20, #0x3c]
     320: b9401fe9     	ldr	w9, [sp, #0x1c]
     324: 6b08013f     	cmp	w9, w8
     328: 54000ac1     	b.ne	0x480 <f3_stream_finish_03+0x480>
     32c: b9404288     	ldr	w8, [x20, #0x40]
     330: b94023e9     	ldr	w9, [sp, #0x20]
     334: 6b08013f     	cmp	w9, w8
     338: 54000a41     	b.ne	0x480 <f3_stream_finish_03+0x480>
     33c: f9407288     	ldr	x8, [x20, #0xe0]
     340: f9405680     	ldr	x0, [x20, #0xa8]
     344: d100c3a1     	sub	x1, x29, #0x30
     348: d63f0100     	blr	x8
     34c: aa0003e2     	mov	x2, x0
     350: aa0103e3     	mov	x3, x1
     354: aa1403e0     	mov	x0, x20
     358: aa0203e1     	mov	x1, x2
     35c: aa0303e2     	mov	x2, x3
     360: 52800163     	mov	w3, #0xb                // =11
     364: 94000000     	bl	0x364 <f3_stream_finish_03+0x364>
		0000000000000364:  R_AARCH64_CALL26	.text.observe
     368: 340009e0     	cbz	w0, 0x4a4 <f3_stream_finish_03+0x4a4>
     36c: f9409e88     	ldr	x8, [x20, #0x138]
     370: f85d03a9     	ldur	x9, [x29, #-0x30]
     374: eb09011f     	cmp	x8, x9
     378: 54000a21     	b.ne	0x4bc <f3_stream_finish_03+0x4bc>
     37c: f940a288     	ldr	x8, [x20, #0x140]
     380: f85d83a9     	ldur	x9, [x29, #-0x28]
     384: eb09011f     	cmp	x8, x9
     388: 540009a1     	b.ne	0x4bc <f3_stream_finish_03+0x4bc>
     38c: f940a688     	ldr	x8, [x20, #0x148]
     390: f85e03a9     	ldur	x9, [x29, #-0x20]
     394: eb09011f     	cmp	x8, x9
     398: 54000921     	b.ne	0x4bc <f3_stream_finish_03+0x4bc>
     39c: f940aa88     	ldr	x8, [x20, #0x150]
     3a0: f85e83a9     	ldur	x9, [x29, #-0x18]
     3a4: eb09011f     	cmp	x8, x9
     3a8: 540008a1     	b.ne	0x4bc <f3_stream_finish_03+0x4bc>
     3ac: f940ae88     	ldr	x8, [x20, #0x158]
     3b0: f85f03a9     	ldur	x9, [x29, #-0x10]
     3b4: eb09011f     	cmp	x8, x9
     3b8: 54000821     	b.ne	0x4bc <f3_stream_finish_03+0x4bc>
     3bc: aa1403e0     	mov	x0, x20
     3c0: 94000000     	bl	0x3c0 <f3_stream_finish_03+0x3c0>
		00000000000003c0:  R_AARCH64_CALL26	.text.close_read
     3c4: 340002a0     	cbz	w0, 0x418 <f3_stream_finish_03+0x418>
     3c8: f9407a88     	ldr	x8, [x20, #0xf0]
     3cc: f9405680     	ldr	x0, [x20, #0xa8]
     3d0: 9104e281     	add	x1, x20, #0x138
     3d4: d63f0100     	blr	x8
     3d8: aa0003e2     	mov	x2, x0
     3dc: aa0103e3     	mov	x3, x1
     3e0: aa1403e0     	mov	x0, x20
     3e4: aa0203e1     	mov	x1, x2
     3e8: aa0303e2     	mov	x2, x3
     3ec: 528001c3     	mov	w3, #0xe                // =14
     3f0: 94000000     	bl	0x3f0 <f3_stream_finish_03+0x3f0>
		00000000000003f0:  R_AARCH64_CALL26	.text.observe
     3f4: 34000120     	cbz	w0, 0x418 <f3_stream_finish_03+0x418>
     3f8: f940068a     	ldr	x10, [x20, #0x8]
     3fc: 52800028     	mov	w8, #0x1                // =1
     400: 52800089     	mov	w9, #0x4                // =4
     404: b9011288     	str	w8, [x20, #0x110]
     408: b9010288     	str	w8, [x20, #0x100]
     40c: b9000289     	str	w9, [x20]
     410: b9000d5f     	str	wzr, [x10, #0xc]
     414: 14000012     	b	0x45c <f3_stream_finish_03+0x45c>
     418: b9400288     	ldr	w8, [x20]
     41c: 71000d1f     	cmp	w8, #0x3
     420: 540001e0     	b.eq	0x45c <f3_stream_finish_03+0x45c>
     424: f9400689     	ldr	x9, [x20, #0x8]
     428: 52800088     	mov	w8, #0x4                // =4
     42c: b9000288     	str	w8, [x20]
     430: b9000d3f     	str	wzr, [x9, #0xc]
     434: 1400000a     	b	0x45c <f3_stream_finish_03+0x45c>
     438: 90000008     	adrp	x8, 0x0 <f3_stream_finish_03>
		0000000000000438:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x10
     43c: 52800069     	mov	w9, #0x3                // =3
     440: fd400100     	ldr	d0, [x8]
		0000000000000440:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x10
     444: f9400688     	ldr	x8, [x20, #0x8]
     448: b9000289     	str	w9, [x20]
     44c: fd008280     	str	d0, [x20, #0x100]
     450: b4000068     	cbz	x8, 0x45c <f3_stream_finish_03+0x45c>
     454: 0f000420     	movi	v0.2s, #0x1
     458: fd000500     	str	d0, [x8, #0x8]
     45c: aa1303e0     	mov	x0, x19
     460: 17fffef7     	b	0x3c <f3_stream_finish_03+0x3c>
     464: 90000008     	adrp	x8, 0x0 <f3_stream_finish_03>
		0000000000000464:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x20
     468: 52800049     	mov	w9, #0x2                // =2
     46c: fd400100     	ldr	d0, [x8]
		000000000000046c:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x20
     470: b9000009     	str	w9, [x0]
     474: fd008000     	str	d0, [x0, #0x100]
     478: 94000000     	bl	0x478 <f3_stream_finish_03+0x478>
		0000000000000478:  R_AARCH64_CALL26	f3_stream_abort_03
     47c: 17fffef0     	b	0x3c <f3_stream_finish_03+0x3c>
     480: 90000008     	adrp	x8, 0x0 <f3_stream_finish_03>
		0000000000000480:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x58
     484: 52800049     	mov	w9, #0x2                // =2
     488: fd400100     	ldr	d0, [x8]
		0000000000000488:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x58
     48c: aa1403e0     	mov	x0, x20
     490: b9000289     	str	w9, [x20]
     494: fd008280     	str	d0, [x20, #0x100]
     498: 94000000     	bl	0x498 <f3_stream_finish_03+0x498>
		0000000000000498:  R_AARCH64_CALL26	f3_stream_abort_03
     49c: aa0003f3     	mov	x19, x0
     4a0: 17ffffef     	b	0x45c <f3_stream_finish_03+0x45c>
     4a4: b9400288     	ldr	w8, [x20]
     4a8: 71000d1f     	cmp	w8, #0x3
     4ac: 54fffd80     	b.eq	0x45c <f3_stream_finish_03+0x45c>
     4b0: aa1403e0     	mov	x0, x20
     4b4: 94000000     	bl	0x4b4 <f3_stream_finish_03+0x4b4>
		00000000000004b4:  R_AARCH64_CALL26	f3_stream_abort_03
     4b8: 17ffffe9     	b	0x45c <f3_stream_finish_03+0x45c>
     4bc: 90000008     	adrp	x8, 0x0 <f3_stream_finish_03>
		00000000000004bc:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x8
     4c0: 52800049     	mov	w9, #0x2                // =2
     4c4: fd400100     	ldr	d0, [x8]
		00000000000004c4:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x8
     4c8: 17fffff1     	b	0x48c <f3_stream_finish_03+0x48c>

Disassembly of section .text.f4_sha_end:

0000000000000000 <f4_sha_end>:
       0: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
       4: a90157f6     	stp	x22, x21, [sp, #0x10]
       8: a9024ff4     	stp	x20, x19, [sp, #0x20]
       c: 910003fd     	mov	x29, sp
      10: f9401008     	ldr	x8, [x0, #0x20]
      14: b9402809     	ldr	w9, [x0, #0x28]
      18: aa0103f3     	mov	x19, x1
      1c: aa0003f4     	mov	x20, x0
      20: 9100b015     	add	x21, x0, #0x2c
      24: 5280100a     	mov	w10, #0x80              // =128
      28: d37df116     	lsl	x22, x8, #3
      2c: 11000528     	add	w8, w9, #0x1
      30: 38296aaa     	strb	w10, [x21, x9]
      34: 7100e51f     	cmp	w8, #0x39
      38: b9002808     	str	w8, [x0, #0x28]
      3c: 54000163     	b.lo	0x68 <f4_sha_end+0x68>
      40: 8b2842a0     	add	x0, x21, w8, uxtw
      44: 528007e8     	mov	w8, #0x3f               // =63
      48: 2a1f03e1     	mov	w1, wzr
      4c: 4b090102     	sub	w2, w8, w9
      50: 94000000     	bl	0x50 <f4_sha_end+0x50>
		0000000000000050:  R_AARCH64_CALL26	memset
      54: aa1403e0     	mov	x0, x20
      58: aa1503e1     	mov	x1, x21
      5c: 94000000     	bl	0x5c <f4_sha_end+0x5c>
		000000000000005c:  R_AARCH64_CALL26	.text.f4_sha_block
      60: 2a1f03e8     	mov	w8, wzr
      64: b9002a9f     	str	wzr, [x20, #0x28]
      68: 8b2842a0     	add	x0, x21, w8, uxtw
      6c: 52800709     	mov	w9, #0x38               // =56
      70: 2a1f03e1     	mov	w1, wzr
      74: 4b080122     	sub	w2, w9, w8
      78: 94000000     	bl	0x78 <f4_sha_end+0x78>
		0000000000000078:  R_AARCH64_CALL26	memset
      7c: dac00ec8     	rev	x8, x22
      80: aa1403e0     	mov	x0, x20
      84: aa1503e1     	mov	x1, x21
      88: f8064288     	stur	x8, [x20, #0x64]
      8c: 94000000     	bl	0x8c <f4_sha_end+0x8c>
		000000000000008c:  R_AARCH64_CALL26	.text.f4_sha_block
      90: 2a1f03e8     	mov	w8, wzr
      94: aa1f03e9     	mov	x9, xzr
      98: 9100066a     	add	x10, x19, #0x1
      9c: 5280030b     	mov	w11, #0x18              // =24
      a0: 9000000c     	adrp	x12, 0x0 <f4_sha_end>
		00000000000000a0:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1
      a4: 9100018c     	add	x12, x12, #0x0
		00000000000000a4:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1
      a8: 927e752d     	and	x13, x9, #0xfffffffc
      ac: 0a28016e     	bic	w14, w11, w8
      b0: 91000529     	add	x9, x9, #0x1
      b4: b86d6a8d     	ldr	w13, [x20, x13]
      b8: f100813f     	cmp	x9, #0x20
      bc: 11002108     	add	w8, w8, #0x8
      c0: 1ace25ad     	lsr	w13, w13, w14
      c4: d3441dae     	ubfx	x14, x13, #4, #4
      c8: 92400dad     	and	x13, x13, #0xf
      cc: 386e698e     	ldrb	w14, [x12, x14]
      d0: 381ff14e     	sturb	w14, [x10, #-0x1]
      d4: 386d698d     	ldrb	w13, [x12, x13]
      d8: 3800254d     	strb	w13, [x10], #0x2
      dc: 54fffe61     	b.ne	0xa8 <f4_sha_end+0xa8>
      e0: 3901027f     	strb	wzr, [x19, #0x40]
      e4: a9424ff4     	ldp	x20, x19, [sp, #0x20]
      e8: a94157f6     	ldp	x22, x21, [sp, #0x10]
      ec: a8c37bfd     	ldp	x29, x30, [sp], #0x30
      f0: d65f03c0     	ret

Disassembly of section .text.same:

0000000000000000 <same>:
       0: f9400008     	ldr	x8, [x0]
       4: f9400029     	ldr	x9, [x1]
       8: eb09011f     	cmp	x8, x9
       c: 54000261     	b.ne	0x58 <same+0x58>
      10: f9400408     	ldr	x8, [x0, #0x8]
      14: f9400429     	ldr	x9, [x1, #0x8]
      18: eb09011f     	cmp	x8, x9
      1c: 540001e1     	b.ne	0x58 <same+0x58>
      20: f9400808     	ldr	x8, [x0, #0x10]
      24: f9400829     	ldr	x9, [x1, #0x10]
      28: eb09011f     	cmp	x8, x9
      2c: 54000161     	b.ne	0x58 <same+0x58>
      30: f9400c08     	ldr	x8, [x0, #0x18]
      34: f9400c29     	ldr	x9, [x1, #0x18]
      38: eb09011f     	cmp	x8, x9
      3c: 540000e1     	b.ne	0x58 <same+0x58>
      40: 34000102     	cbz	w2, 0x60 <same+0x60>
      44: f9401008     	ldr	x8, [x0, #0x20]
      48: f9401029     	ldr	x9, [x1, #0x20]
      4c: eb09011f     	cmp	x8, x9
      50: 1a9f17e0     	cset	w0, eq
      54: d65f03c0     	ret
      58: 2a1f03e0     	mov	w0, wzr
      5c: d65f03c0     	ret
      60: 52800020     	mov	w0, #0x1                // =1
      64: d65f03c0     	ret

Disassembly of section .text.f3_export_stream_begin_03:

0000000000000000 <f3_export_stream_begin_03>:
       0: 2a1f03e7     	mov	w7, wzr
       4: b4000fa0     	cbz	x0, 0x1f8 <f3_export_stream_begin_03+0x1f8>
       8: b4000f82     	cbz	x2, 0x1f8 <f3_export_stream_begin_03+0x1f8>
       c: 2a1f03e7     	mov	w7, wzr
      10: b4000f43     	cbz	x3, 0x1f8 <f3_export_stream_begin_03+0x1f8>
      14: b4000f21     	cbz	x1, 0x1f8 <f3_export_stream_begin_03+0x1f8>
      18: b9400008     	ldr	w8, [x0]
      1c: 35000ee8     	cbnz	w8, 0x1f8 <f3_export_stream_begin_03+0x1f8>
      20: b9401048     	ldr	w8, [x2, #0x10]
      24: 51000d08     	sub	w8, w8, #0x3
      28: 3100091f     	cmn	w8, #0x2
      2c: 540000a3     	b.lo	0x40 <f3_export_stream_begin_03+0x40>
      30: b940a048     	ldr	w8, [x2, #0xa0]
      34: 51019508     	sub	w8, w8, #0x65
      38: 3101911f     	cmn	w8, #0x64
      3c: 54000062     	b.hs	0x48 <f3_export_stream_begin_03+0x48>
      40: 2a1f03e0     	mov	w0, wzr
      44: d65f03c0     	ret
      48: b10bc41f     	cmn	x0, #0x2f1
      4c: 2a1f03e7     	mov	w7, wzr
      50: 54000d48     	b.hi	0x1f8 <f3_export_stream_begin_03+0x1f8>
      54: b102a45f     	cmn	x2, #0xa9
      58: 54000d08     	b.hi	0x1f8 <f3_export_stream_begin_03+0x1f8>
      5c: 9102a048     	add	x8, x2, #0xa8
      60: 2a1f03e7     	mov	w7, wzr
      64: eb00011f     	cmp	x8, x0
      68: 910bc008     	add	x8, x0, #0x2f0
      6c: fa428100     	ccmp	x8, x2, #0x0, hi
      70: 54000c48     	b.hi	0x1f8 <f3_export_stream_begin_03+0x1f8>
      74: b101647f     	cmn	x3, #0x59
      78: 54000c08     	b.hi	0x1f8 <f3_export_stream_begin_03+0x1f8>
      7c: 91016069     	add	x9, x3, #0x58
      80: 2a1f03e7     	mov	w7, wzr
      84: eb00013f     	cmp	x9, x0
      88: fa438100     	ccmp	x8, x3, #0x0, hi
      8c: 54000b68     	b.hi	0x1f8 <f3_export_stream_begin_03+0x1f8>
      90: b100443f     	cmn	x1, #0x11
      94: 54000b28     	b.hi	0x1f8 <f3_export_stream_begin_03+0x1f8>
      98: eb01011f     	cmp	x8, x1
      9c: 54000089     	b.ls	0xac <f3_export_stream_begin_03+0xac>
      a0: 91004029     	add	x9, x1, #0x10
      a4: eb00013f     	cmp	x9, x0
      a8: 54fffcc8     	b.hi	0x40 <f3_export_stream_begin_03+0x40>
      ac: b4000125     	cbz	x5, 0xd0 <f3_export_stream_begin_03+0xd0>
      b0: b4000106     	cbz	x6, 0xd0 <f3_export_stream_begin_03+0xd0>
      b4: ab0600bf     	cmn	x5, x6
      b8: 54fffc42     	b.hs	0x40 <f3_export_stream_begin_03+0x40>
      bc: eb05011f     	cmp	x8, x5
      c0: 54000089     	b.ls	0xd0 <f3_export_stream_begin_03+0xd0>
      c4: 8b0500c8     	add	x8, x6, x5
      c8: eb00011f     	cmp	x8, x0
      cc: 54fffba8     	b.hi	0x40 <f3_export_stream_begin_03+0x40>
      d0: d10443ff     	sub	sp, sp, #0x110
      d4: a90c7bfd     	stp	x29, x30, [sp, #0xc0]
      d8: a90d67fc     	stp	x28, x25, [sp, #0xd0]
      dc: a90e5ff8     	stp	x24, x23, [sp, #0xe0]
      e0: a90f57f6     	stp	x22, x21, [sp, #0xf0]
      e4: a9104ff4     	stp	x20, x19, [sp, #0x100]
      e8: 910303fd     	add	x29, sp, #0xc0
      ec: aa0303f6     	mov	x22, x3
      f0: aa0103f7     	mov	x23, x1
      f4: aa0003f8     	mov	x24, x0
      f8: 29530c48     	ldp	w8, w3, [x2, #0x98]
      fc: 29438440     	ldp	w0, w1, [x2, #0x1c]
     100: aa0403f5     	mov	x21, x4
     104: aa0203f9     	mov	x25, x2
     108: d10083a4     	sub	x4, x29, #0x20
     10c: 2a0803e2     	mov	w2, w8
     110: aa0503f4     	mov	x20, x5
     114: aa0603f3     	mov	x19, x6
     118: 94000000     	bl	0x118 <f3_export_stream_begin_03+0x118>
		0000000000000118:  R_AARCH64_CALL26	iq4_export_geometry
     11c: 35000600     	cbnz	w0, 0x1dc <f3_export_stream_begin_03+0x1dc>
     120: b9402729     	ldr	w9, [x25, #0x24]
     124: b85f03aa     	ldur	w10, [x29, #-0x10]
     128: 6b0a013f     	cmp	w9, w10
     12c: 54000581     	b.ne	0x1dc <f3_export_stream_begin_03+0x1dc>
     130: b9402b2a     	ldr	w10, [x25, #0x28]
     134: b85f43ab     	ldur	w11, [x29, #-0xc]
     138: aa1903e8     	mov	x8, x25
     13c: 6b0b015f     	cmp	w10, w11
     140: 540004e1     	b.ne	0x1dc <f3_export_stream_begin_03+0x1dc>
     144: b9402d0b     	ldr	w11, [x8, #0x2c]
     148: 6b09017f     	cmp	w11, w9
     14c: 54000481     	b.ne	0x1dc <f3_export_stream_begin_03+0x1dc>
     150: b9403109     	ldr	w9, [x8, #0x30]
     154: 6b0a013f     	cmp	w9, w10
     158: 54000421     	b.ne	0x1dc <f3_export_stream_begin_03+0x1dc>
     15c: ad7f07a0     	ldp	q0, q1, [x29, #-0x20]
     160: 910b2309     	add	x9, x24, #0x2c8
     164: aa1803e0     	mov	x0, x24
     168: 910003e2     	mov	x2, sp
     16c: d10083a7     	sub	x7, x29, #0x20
     170: aa1703e1     	mov	x1, x23
     174: aa1603e3     	mov	x3, x22
     178: aa1503e4     	mov	x4, x21
     17c: ad000520     	stp	q0, q1, [x9]
     180: aa1403e5     	mov	x5, x20
     184: aa1303e6     	mov	x6, x19
     188: b940a109     	ldr	w9, [x8, #0xa0]
     18c: b940110a     	ldr	w10, [x8, #0x10]
     190: b902eb09     	str	w9, [x24, #0x2e8]
     194: b902ef0a     	str	w10, [x24, #0x2ec]
     198: ad430500     	ldp	q0, q1, [x8, #0x60]
     19c: 3dc02102     	ldr	q2, [x8, #0x80]
     1a0: f9404909     	ldr	x9, [x8, #0x90]
     1a4: 3d8023e2     	str	q2, [sp, #0x80]
     1a8: ad0307e0     	stp	q0, q1, [sp, #0x60]
     1ac: ad410500     	ldp	q0, q1, [x8, #0x20]
     1b0: f9004be9     	str	x9, [sp, #0x90]
     1b4: ad0107e0     	stp	q0, q1, [sp, #0x20]
     1b8: ad420102     	ldp	q2, q0, [x8, #0x40]
     1bc: ad0203e2     	stp	q2, q0, [sp, #0x40]
     1c0: ad400101     	ldp	q1, q0, [x8]
     1c4: 52800028     	mov	w8, #0x1                // =1
     1c8: ad0003e1     	stp	q1, q0, [sp]
     1cc: b90013e8     	str	w8, [sp, #0x10]
     1d0: 94000000     	bl	0x1d0 <f3_export_stream_begin_03+0x1d0>
		00000000000001d0:  R_AARCH64_CALL26	.text.begin_checked
     1d4: 2a0003e7     	mov	w7, w0
     1d8: 14000002     	b	0x1e0 <f3_export_stream_begin_03+0x1e0>
     1dc: 2a1f03e7     	mov	w7, wzr
     1e0: a9504ff4     	ldp	x20, x19, [sp, #0x100]
     1e4: a94f57f6     	ldp	x22, x21, [sp, #0xf0]
     1e8: a94e5ff8     	ldp	x24, x23, [sp, #0xe0]
     1ec: a94d67fc     	ldp	x28, x25, [sp, #0xd0]
     1f0: a94c7bfd     	ldp	x29, x30, [sp, #0xc0]
     1f4: 910443ff     	add	sp, sp, #0x110
     1f8: 2a0703e0     	mov	w0, w7
     1fc: d65f03c0     	ret

Disassembly of section .text.begin_checked:

0000000000000000 <begin_checked>:
       0: b9400008     	ldr	w8, [x0]
       4: 350000a8     	cbnz	w8, 0x18 <begin_checked+0x18>
       8: b9400828     	ldr	w8, [x1, #0x8]
       c: 35000068     	cbnz	w8, 0x18 <begin_checked+0x18>
      10: b9400c28     	ldr	w8, [x1, #0xc]
      14: 34000068     	cbz	w8, 0x20 <begin_checked+0x20>
      18: 2a1f03e0     	mov	w0, wzr
      1c: d65f03c0     	ret
      20: f9400028     	ldr	x8, [x1]
      24: b4ffffa8     	cbz	x8, 0x18 <begin_checked+0x18>
      28: f9400049     	ldr	x9, [x2]
      2c: eb09011f     	cmp	x8, x9
      30: 54ffff41     	b.ne	0x18 <begin_checked+0x18>
      34: f9400448     	ldr	x8, [x2, #0x8]
      38: b4ffff08     	cbz	x8, 0x18 <begin_checked+0x18>
      3c: aa0203e8     	mov	x8, x2
      40: f8438d09     	ldr	x9, [x8, #0x38]!
      44: b4fffea9     	cbz	x9, 0x18 <begin_checked+0x18>
      48: f9402049     	ldr	x9, [x2, #0x40]
      4c: b4fffe69     	cbz	x9, 0x18 <begin_checked+0x18>
      50: f9402449     	ldr	x9, [x2, #0x48]
      54: b4fffe29     	cbz	x9, 0x18 <begin_checked+0x18>
      58: f9402849     	ldr	x9, [x2, #0x50]
      5c: b4fffde9     	cbz	x9, 0x18 <begin_checked+0x18>
      60: f9402c49     	ldr	x9, [x2, #0x58]
      64: b4fffda9     	cbz	x9, 0x18 <begin_checked+0x18>
      68: b9401049     	ldr	w9, [x2, #0x10]
      6c: 7100093f     	cmp	w9, #0x2
      70: 54fffd48     	b.hi	0x18 <begin_checked+0x18>
      74: b9401449     	ldr	w9, [x2, #0x14]
      78: 5100052a     	sub	w10, w9, #0x1
      7c: 7100055f     	cmp	w10, #0x1
      80: 54fffcc8     	b.hi	0x18 <begin_checked+0x18>
      84: b940184a     	ldr	w10, [x2, #0x18]
      88: 7100055f     	cmp	w10, #0x1
      8c: 54fffc68     	b.hi	0x18 <begin_checked+0x18>
      90: 7100093f     	cmp	w9, #0x2
      94: 54000041     	b.ne	0x9c <begin_checked+0x9c>
      98: 35fffc0a     	cbnz	w10, 0x18 <begin_checked+0x18>
      9c: d101c3ff     	sub	sp, sp, #0x70
      a0: a9057bfd     	stp	x29, x30, [sp, #0x50]
      a4: a9064ff4     	stp	x20, x19, [sp, #0x60]
      a8: 910143fd     	add	x29, sp, #0x50
      ac: a93e8fa8     	stp	x8, x3, [x29, #-0x18]
      b0: f9404448     	ldr	x8, [x2, #0x88]
      b4: f81e03a7     	stur	x7, [x29, #-0x20]
      b8: a90117e4     	stp	x4, x5, [sp, #0x10]
      bc: f90017e6     	str	x6, [sp, #0x28]
      c0: f90007e1     	str	x1, [sp, #0x8]
      c4: f90013e0     	str	x0, [sp, #0x20]
      c8: f81f83a2     	stur	x2, [x29, #-0x8]
      cc: b5000088     	cbnz	x8, 0xdc <begin_checked+0xdc>
      d0: f85f83a8     	ldur	x8, [x29, #-0x8]
      d4: f9404908     	ldr	x8, [x8, #0x90]
      d8: b40000c8     	cbz	x8, 0xf0 <begin_checked+0xf0>
      dc: 2a1f03e0     	mov	w0, wzr
      e0: a9464ff4     	ldp	x20, x19, [sp, #0x60]
      e4: a9457bfd     	ldp	x29, x30, [sp, #0x50]
      e8: 9101c3ff     	add	sp, sp, #0x70
      ec: d65f03c0     	ret
      f0: f85f03a8     	ldur	x8, [x29, #-0x10]
      f4: f9400508     	ldr	x8, [x8, #0x8]
      f8: b4ffff28     	cbz	x8, 0xdc <begin_checked+0xdc>
      fc: f85f03a8     	ldur	x8, [x29, #-0x10]
     100: f9400908     	ldr	x8, [x8, #0x10]
     104: b4fffec8     	cbz	x8, 0xdc <begin_checked+0xdc>
     108: f85f03a8     	ldur	x8, [x29, #-0x10]
     10c: f9400d08     	ldr	x8, [x8, #0x18]
     110: b4fffe68     	cbz	x8, 0xdc <begin_checked+0xdc>
     114: f85f03a8     	ldur	x8, [x29, #-0x10]
     118: f9401108     	ldr	x8, [x8, #0x20]
     11c: b4fffe08     	cbz	x8, 0xdc <begin_checked+0xdc>
     120: f85f03a8     	ldur	x8, [x29, #-0x10]
     124: f9401508     	ldr	x8, [x8, #0x28]
     128: b4fffda8     	cbz	x8, 0xdc <begin_checked+0xdc>
     12c: f85f03a8     	ldur	x8, [x29, #-0x10]
     130: f9401908     	ldr	x8, [x8, #0x30]
     134: b4fffd48     	cbz	x8, 0xdc <begin_checked+0xdc>
     138: f85f03a8     	ldur	x8, [x29, #-0x10]
     13c: f9401d08     	ldr	x8, [x8, #0x38]
     140: b4fffce8     	cbz	x8, 0xdc <begin_checked+0xdc>
     144: f85f03a8     	ldur	x8, [x29, #-0x10]
     148: f9402108     	ldr	x8, [x8, #0x40]
     14c: b4fffc88     	cbz	x8, 0xdc <begin_checked+0xdc>
     150: f85f03a8     	ldur	x8, [x29, #-0x10]
     154: f9402508     	ldr	x8, [x8, #0x48]
     158: b4fffc28     	cbz	x8, 0xdc <begin_checked+0xdc>
     15c: f85f83a8     	ldur	x8, [x29, #-0x8]
     160: b9401d14     	ldr	w20, [x8, #0x1c]
     164: 34fffbd4     	cbz	w20, 0xdc <begin_checked+0xdc>
     168: f85f83a8     	ldur	x8, [x29, #-0x8]
     16c: b9402113     	ldr	w19, [x8, #0x20]
     170: 34fffb73     	cbz	w19, 0xdc <begin_checked+0xdc>
     174: f85f83a8     	ldur	x8, [x29, #-0x8]
     178: b9403508     	ldr	w8, [x8, #0x34]
     17c: 7100051f     	cmp	w8, #0x1
     180: 54fffae1     	b.ne	0xdc <begin_checked+0xdc>
     184: f85f83a8     	ldur	x8, [x29, #-0x8]
     188: f85e83a1     	ldur	x1, [x29, #-0x18]
     18c: 52800022     	mov	w2, #0x1                // =1
     190: 91018100     	add	x0, x8, #0x60
     194: 94000000     	bl	0x194 <begin_checked+0x194>
		0000000000000194:  R_AARCH64_CALL26	.text.same
     198: 34fffa40     	cbz	w0, 0xe0 <begin_checked+0xe0>
     19c: f85f83a8     	ldur	x8, [x29, #-0x8]
     1a0: b9402d09     	ldr	w9, [x8, #0x2c]
     1a4: 34fff9c9     	cbz	w9, 0xdc <begin_checked+0xdc>
     1a8: 53107d28     	lsr	w8, w9, #16
     1ac: 2a1f03e0     	mov	w0, wzr
     1b0: 35fff988     	cbnz	w8, 0xe0 <begin_checked+0xe0>
     1b4: f85f83a8     	ldur	x8, [x29, #-0x8]
     1b8: 129fffcb     	mov	w11, #-0xffff           // =-65535
     1bc: b9403108     	ldr	w8, [x8, #0x30]
     1c0: 5140410a     	sub	w10, w8, #0x10, lsl #12 // =0x10000
     1c4: 6b0b015f     	cmp	w10, w11
     1c8: 54fff8c3     	b.lo	0xe0 <begin_checked+0xe0>
     1cc: f85f83aa     	ldur	x10, [x29, #-0x8]
     1d0: b940254a     	ldr	w10, [x10, #0x24]
     1d4: 6b09015f     	cmp	w10, w9
     1d8: 54fff821     	b.ne	0xdc <begin_checked+0xdc>
     1dc: f85f83aa     	ldur	x10, [x29, #-0x8]
     1e0: b940294a     	ldr	w10, [x10, #0x28]
     1e4: 6b08015f     	cmp	w10, w8
     1e8: 54fff7a1     	b.ne	0xdc <begin_checked+0xdc>
     1ec: f85e03aa     	ldur	x10, [x29, #-0x20]
     1f0: b940014a     	ldr	w10, [x10]
     1f4: 6b0a029f     	cmp	w20, w10
     1f8: 54fff721     	b.ne	0xdc <begin_checked+0xdc>
     1fc: f85e03aa     	ldur	x10, [x29, #-0x20]
     200: b940054a     	ldr	w10, [x10, #0x4]
     204: 6b0a027f     	cmp	w19, w10
     208: 54fff6a1     	b.ne	0xdc <begin_checked+0xdc>
     20c: f85e03aa     	ldur	x10, [x29, #-0x20]
     210: b940114a     	ldr	w10, [x10, #0x10]
     214: 6b0a013f     	cmp	w9, w10
     218: 54fff621     	b.ne	0xdc <begin_checked+0xdc>
     21c: f94017e9     	ldr	x9, [sp, #0x28]
     220: 2a1f03e0     	mov	w0, wzr
     224: f140413f     	cmp	x9, #0x10, lsl #12      // =0x10000
     228: 54fff5c3     	b.lo	0xe0 <begin_checked+0xe0>
     22c: f9400fe9     	ldr	x9, [sp, #0x18]
     230: b4fff589     	cbz	x9, 0xe0 <begin_checked+0xe0>
     234: f9400be9     	ldr	x9, [sp, #0x10]
     238: 92a2000a     	mov	x10, #-0x10000001       // =-268435457
     23c: 8b0a0129     	add	x9, x9, x10
     240: b2648fea     	mov	x10, #-0x10000000       // =-268435456
     244: eb0a013f     	cmp	x9, x10
     248: 54fff4c3     	b.lo	0xe0 <begin_checked+0xe0>
     24c: f85e03a9     	ldur	x9, [x29, #-0x20]
     250: b9401529     	ldr	w9, [x9, #0x14]
     254: 6b09011f     	cmp	w8, w9
     258: 54fff441     	b.ne	0xe0 <begin_checked+0xe0>
     25c: f94013e8     	ldr	x8, [sp, #0x20]
     260: 2a1f03e0     	mov	w0, wzr
     264: b10b251f     	cmn	x8, #0x2c9
     268: 54fff3c8     	b.hi	0xe0 <begin_checked+0xe0>
     26c: f85f83a8     	ldur	x8, [x29, #-0x8]
     270: b102651f     	cmn	x8, #0x99
     274: 54fff368     	b.hi	0xe0 <begin_checked+0xe0>
     278: f94013e8     	ldr	x8, [sp, #0x20]
     27c: 910b210a     	add	x10, x8, #0x2c8
     280: f85f83a8     	ldur	x8, [x29, #-0x8]
     284: eb08015f     	cmp	x10, x8
     288: 91026108     	add	x8, x8, #0x98
     28c: 54000089     	b.ls	0x29c <begin_checked+0x29c>
     290: f94013e9     	ldr	x9, [sp, #0x20]
     294: eb09011f     	cmp	x8, x9
     298: 54fff228     	b.hi	0xdc <begin_checked+0xdc>
     29c: f85f03a9     	ldur	x9, [x29, #-0x10]
     2a0: b101653f     	cmn	x9, #0x59
     2a4: 54fff1c8     	b.hi	0xdc <begin_checked+0xdc>
     2a8: f85f03a9     	ldur	x9, [x29, #-0x10]
     2ac: eb09015f     	cmp	x10, x9
     2b0: 91016129     	add	x9, x9, #0x58
     2b4: 54000089     	b.ls	0x2c4 <begin_checked+0x2c4>
     2b8: f94013eb     	ldr	x11, [sp, #0x20]
     2bc: eb0b013f     	cmp	x9, x11
     2c0: 54fff0e8     	b.hi	0xdc <begin_checked+0xdc>
     2c4: f94007eb     	ldr	x11, [sp, #0x8]
     2c8: b100457f     	cmn	x11, #0x11
     2cc: 54fff088     	b.hi	0xdc <begin_checked+0xdc>
     2d0: f94007eb     	ldr	x11, [sp, #0x8]
     2d4: eb0b015f     	cmp	x10, x11
     2d8: 9100416b     	add	x11, x11, #0x10
     2dc: 54000089     	b.ls	0x2ec <begin_checked+0x2ec>
     2e0: f94013ec     	ldr	x12, [sp, #0x20]
     2e4: eb0c017f     	cmp	x11, x12
     2e8: 54ffefa8     	b.hi	0xdc <begin_checked+0xdc>
     2ec: f94017ec     	ldr	x12, [sp, #0x28]
     2f0: f9400fed     	ldr	x13, [sp, #0x18]
     2f4: ab0c01bf     	cmn	x13, x12
     2f8: 54ffef22     	b.hs	0xdc <begin_checked+0xdc>
     2fc: f9400fec     	ldr	x12, [sp, #0x18]
     300: eb0c015f     	cmp	x10, x12
     304: f94017ea     	ldr	x10, [sp, #0x28]
     308: 8b0c014a     	add	x10, x10, x12
     30c: 54000089     	b.ls	0x31c <begin_checked+0x31c>
     310: f94013ec     	ldr	x12, [sp, #0x20]
     314: eb0c015f     	cmp	x10, x12
     318: 54ffee28     	b.hi	0xdc <begin_checked+0xdc>
     31c: f9400fec     	ldr	x12, [sp, #0x18]
     320: eb0c011f     	cmp	x8, x12
     324: 54000089     	b.ls	0x334 <begin_checked+0x334>
     328: f85f83a8     	ldur	x8, [x29, #-0x8]
     32c: eb08015f     	cmp	x10, x8
     330: 54ffed68     	b.hi	0xdc <begin_checked+0xdc>
     334: f9400fe8     	ldr	x8, [sp, #0x18]
     338: eb08013f     	cmp	x9, x8
     33c: 54000089     	b.ls	0x34c <begin_checked+0x34c>
     340: f85f03a8     	ldur	x8, [x29, #-0x10]
     344: eb08015f     	cmp	x10, x8
     348: 54ffeca8     	b.hi	0xdc <begin_checked+0xdc>
     34c: f9400fe8     	ldr	x8, [sp, #0x18]
     350: eb08017f     	cmp	x11, x8
     354: 54000089     	b.ls	0x364 <begin_checked+0x364>
     358: f94007e8     	ldr	x8, [sp, #0x8]
     35c: eb08015f     	cmp	x10, x8
     360: 54ffebe8     	b.hi	0xdc <begin_checked+0xdc>
     364: f94013e8     	ldr	x8, [sp, #0x20]
     368: f94007ea     	ldr	x10, [sp, #0x8]
     36c: 5280006d     	mov	w13, #0x3               // =3
     370: f85f83a1     	ldur	x1, [x29, #-0x8]
     374: f85f03ab     	ldur	x11, [x29, #-0x10]
     378: f900050a     	str	x10, [x8, #0x8]
     37c: b941190c     	ldr	w12, [x8, #0x118]
     380: ad400021     	ldp	q1, q0, [x1]
     384: 1100058c     	add	w12, w12, #0x1
     388: ad008101     	stp	q1, q0, [x8, #0x10]
     38c: ad420021     	ldp	q1, q0, [x1, #0x40]
     390: ad410c22     	ldp	q2, q3, [x1, #0x20]
     394: ad028101     	stp	q1, q0, [x8, #0x50]
     398: ad018d02     	stp	q2, q3, [x8, #0x30]
     39c: ad438022     	ldp	q2, q0, [x1, #0x70]
     3a0: f9404829     	ldr	x9, [x1, #0x90]
     3a4: 3dc01821     	ldr	q1, [x1, #0x60]
     3a8: f9005109     	str	x9, [x8, #0xa0]
     3ac: ad040102     	stp	q2, q0, [x8, #0x80]
     3b0: 3d801d01     	str	q1, [x8, #0x70]
     3b4: ad400161     	ldp	q1, q0, [x11]
     3b8: 3c8b8100     	stur	q0, [x8, #0xb8]
     3bc: 3c8a8101     	stur	q1, [x8, #0xa8]
     3c0: f9402969     	ldr	x9, [x11, #0x50]
     3c4: ad418162     	ldp	q2, q0, [x11, #0x30]
     3c8: 3dc00961     	ldr	q1, [x11, #0x20]
     3cc: b901010d     	str	w13, [x8, #0x100]
     3d0: f9007d09     	str	x9, [x8, #0xf8]
     3d4: f9400fe9     	ldr	x9, [sp, #0x18]
     3d8: 3c8e8100     	stur	q0, [x8, #0xe8]
     3dc: f9010109     	str	x9, [x8, #0x200]
     3e0: f94017e9     	ldr	x9, [sp, #0x28]
     3e4: 3c8d8102     	stur	q2, [x8, #0xd8]
     3e8: f9010509     	str	x9, [x8, #0x208]
     3ec: f9400be9     	ldr	x9, [sp, #0x10]
     3f0: 3c8c8101     	stur	q1, [x8, #0xc8]
     3f4: f9010909     	str	x9, [x8, #0x210]
     3f8: 52800029     	mov	w9, #0x1                // =1
     3fc: b9000109     	str	w9, [x8]
     400: b9000d49     	str	w9, [x10, #0xc]
     404: a9402560     	ldp	x0, x9, [x11]
     408: b901190c     	str	w12, [x8, #0x118]
     40c: d63f0120     	blr	x9
     410: 340001a0     	cbz	w0, 0x444 <begin_checked+0x444>
     414: 7100041f     	cmp	w0, #0x1
     418: 54000381     	b.ne	0x488 <begin_checked+0x488>
     41c: 90000008     	adrp	x8, 0x0 <begin_checked>
		000000000000041c:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x40
     420: 2a1f03e0     	mov	w0, wzr
     424: 52800089     	mov	w9, #0x4                // =4
     428: fd400100     	ldr	d0, [x8]
		0000000000000428:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x40
     42c: f94013e8     	ldr	x8, [sp, #0x20]
     430: f940050a     	ldr	x10, [x8, #0x8]
     434: b9000109     	str	w9, [x8]
     438: fd008100     	str	d0, [x8, #0x100]
     43c: b9000d5f     	str	wzr, [x10, #0xc]
     440: 17ffff28     	b	0xe0 <begin_checked+0xe0>
     444: f85f83a8     	ldur	x8, [x29, #-0x8]
     448: b9401108     	ldr	w8, [x8, #0x10]
     44c: 34000368     	cbz	w8, 0x4b8 <begin_checked+0x4b8>
     450: a97f07a8     	ldp	x8, x1, [x29, #-0x10]
     454: f9400909     	ldr	x9, [x8, #0x10]
     458: f9400100     	ldr	x0, [x8]
     45c: f94013e8     	ldr	x8, [sp, #0x20]
     460: 9104e102     	add	x2, x8, #0x138
     464: d63f0120     	blr	x9
     468: 34000380     	cbz	w0, 0x4d8 <begin_checked+0x4d8>
     46c: 7100041f     	cmp	w0, #0x1
     470: 54000821     	b.ne	0x574 <begin_checked+0x574>
     474: 90000008     	adrp	x8, 0x0 <begin_checked>
		0000000000000474:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x48
     478: 2a1f03e0     	mov	w0, wzr
     47c: 52800089     	mov	w9, #0x4                // =4
     480: fd400100     	ldr	d0, [x8]
		0000000000000480:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x48
     484: 17ffffea     	b	0x42c <begin_checked+0x42c>
     488: f94013ea     	ldr	x10, [sp, #0x20]
     48c: 90000008     	adrp	x8, 0x0 <begin_checked>
		000000000000048c:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x68
     490: 52800069     	mov	w9, #0x3                // =3
     494: fd400100     	ldr	d0, [x8]
		0000000000000494:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x68
     498: f9400548     	ldr	x8, [x10, #0x8]
     49c: b9000149     	str	w9, [x10]
     4a0: fd008140     	str	d0, [x10, #0x100]
     4a4: b4ffe1c8     	cbz	x8, 0xdc <begin_checked+0xdc>
     4a8: 0f000420     	movi	v0.2s, #0x1
     4ac: 2a1f03e0     	mov	w0, wzr
     4b0: fd000500     	str	d0, [x8, #0x8]
     4b4: 17ffff0b     	b	0xe0 <begin_checked+0xe0>
     4b8: f94013e8     	ldr	x8, [sp, #0x20]
     4bc: 52800089     	mov	w9, #0x4                // =4
     4c0: 2a1f03e0     	mov	w0, wzr
     4c4: f940050a     	ldr	x10, [x8, #0x8]
     4c8: b901011f     	str	wzr, [x8, #0x100]
     4cc: b9000109     	str	w9, [x8]
     4d0: b9000d5f     	str	wzr, [x10, #0xc]
     4d4: 17ffff03     	b	0xe0 <begin_checked+0xe0>
     4d8: f94013e9     	ldr	x9, [sp, #0x20]
     4dc: 5280002a     	mov	w10, #0x1               // =1
     4e0: f9409d28     	ldr	x8, [x9, #0x138]
     4e4: b901092a     	str	w10, [x9, #0x108]
     4e8: b4000368     	cbz	x8, 0x554 <begin_checked+0x554>
     4ec: f94013e9     	ldr	x9, [sp, #0x20]
     4f0: f940a129     	ldr	x9, [x9, #0x140]
     4f4: b4000309     	cbz	x9, 0x554 <begin_checked+0x554>
     4f8: f94013ea     	ldr	x10, [sp, #0x20]
     4fc: f940a54b     	ldr	x11, [x10, #0x148]
     500: f85f83aa     	ldur	x10, [x29, #-0x8]
     504: f940254a     	ldr	x10, [x10, #0x48]
     508: eb0a017f     	cmp	x11, x10
     50c: 54000241     	b.ne	0x554 <begin_checked+0x554>
     510: f94013ea     	ldr	x10, [sp, #0x20]
     514: f940a94b     	ldr	x11, [x10, #0x150]
     518: f85f83aa     	ldur	x10, [x29, #-0x8]
     51c: f940294a     	ldr	x10, [x10, #0x50]
     520: eb0a017f     	cmp	x11, x10
     524: 54000181     	b.ne	0x554 <begin_checked+0x554>
     528: f85e83aa     	ldur	x10, [x29, #-0x18]
     52c: f940014a     	ldr	x10, [x10]
     530: eb0a011f     	cmp	x8, x10
     534: 540000a1     	b.ne	0x548 <begin_checked+0x548>
     538: f85f83a8     	ldur	x8, [x29, #-0x8]
     53c: f9402108     	ldr	x8, [x8, #0x40]
     540: eb08013f     	cmp	x9, x8
     544: 54000080     	b.eq	0x554 <begin_checked+0x554>
     548: f94013e8     	ldr	x8, [sp, #0x20]
     54c: f940ad08     	ldr	x8, [x8, #0x158]
     550: b40001c8     	cbz	x8, 0x588 <begin_checked+0x588>
     554: 90000008     	adrp	x8, 0x0 <begin_checked>
		0000000000000554:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x18
     558: f94013e0     	ldr	x0, [sp, #0x20]
     55c: 52800049     	mov	w9, #0x2                // =2
     560: fd400100     	ldr	d0, [x8]
		0000000000000560:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x18
     564: b9000009     	str	w9, [x0]
     568: fd008000     	str	d0, [x0, #0x100]
     56c: 94000000     	bl	0x56c <begin_checked+0x56c>
		000000000000056c:  R_AARCH64_CALL26	f3_stream_abort_03
     570: 17fffedb     	b	0xdc <begin_checked+0xdc>
     574: f94013ea     	ldr	x10, [sp, #0x20]
     578: 90000008     	adrp	x8, 0x0 <begin_checked>
		0000000000000578:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst8+0x60
     57c: 52800069     	mov	w9, #0x3                // =3
     580: fd400100     	ldr	d0, [x8]
		0000000000000580:  R_AARCH64_LDST64_ABS_LO12_NC	.rodata.cst8+0x60
     584: 17ffffc5     	b	0x498 <begin_checked+0x498>
     588: f94013f3     	ldr	x19, [sp, #0x20]
     58c: 90000001     	adrp	x1, 0x0 <begin_checked>
		000000000000058c:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.f4_sha_init.iv
     590: 91000021     	add	x1, x1, #0x0
		0000000000000590:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.f4_sha_init.iv
     594: 52800402     	mov	w2, #0x20               // =32
     598: 91086260     	add	x0, x19, #0x218
     59c: 94000000     	bl	0x59c <begin_checked+0x59c>
		000000000000059c:  R_AARCH64_CALL26	memcpy
     5a0: 6f00e400     	movi	v0.2d, #0000000000000000
     5a4: 910a2268     	add	x8, x19, #0x288
     5a8: f9011e7f     	str	xzr, [x19, #0x238]
     5ac: b902427f     	str	wzr, [x19, #0x240]
     5b0: 52800020     	mov	w0, #0x1                // =1
     5b4: ad000100     	stp	q0, q0, [x8]
     5b8: ad010100     	stp	q0, q0, [x8, #0x20]
     5bc: 17fffec9     	b	0xe0 <begin_checked+0xe0>

Disassembly of section .text.f3_export_stream_encode_03:

0000000000000000 <f3_export_stream_encode_03>:
       0: d102c3ff     	sub	sp, sp, #0xb0
       4: a9097bfd     	stp	x29, x30, [sp, #0x90]
       8: f90053f3     	str	x19, [sp, #0xa0]
       c: 910243fd     	add	x29, sp, #0x90
      10: b4000180     	cbz	x0, 0x40 <f3_export_stream_encode_03+0x40>
      14: b4000162     	cbz	x2, 0x40 <f3_export_stream_encode_03+0x40>
      18: b4000143     	cbz	x3, 0x40 <f3_export_stream_encode_03+0x40>
      1c: b9400008     	ldr	w8, [x0]
      20: 7100051f     	cmp	w8, #0x1
      24: 540000a1     	b.ne	0x38 <f3_export_stream_encode_03+0x38>
      28: f940040a     	ldr	x10, [x0, #0x8]
      2c: b400006a     	cbz	x10, 0x38 <f3_export_stream_encode_03+0x38>
      30: b9400948     	ldr	w8, [x10, #0x8]
      34: 34000148     	cbz	w8, 0x5c <f3_export_stream_encode_03+0x5c>
      38: 91040000     	add	x0, x0, #0x100
      3c: 14000004     	b	0x4c <f3_export_stream_encode_03+0x4c>
      40: 91040008     	add	x8, x0, #0x100
      44: f100001f     	cmp	x0, #0x0
      48: 9a9f1100     	csel	x0, x8, xzr, ne
      4c: a9497bfd     	ldp	x29, x30, [sp, #0x90]
      50: f94053f3     	ldr	x19, [sp, #0xa0]
      54: 9102c3ff     	add	sp, sp, #0xb0
      58: d65f03c0     	ret
      5c: b9400d48     	ldr	w8, [x10, #0xc]
      60: 34fffec8     	cbz	w8, 0x38 <f3_export_stream_encode_03+0x38>
      64: b100a45f     	cmn	x2, #0x29
      68: 540003e8     	b.hi	0xe4 <f3_export_stream_encode_03+0xe4>
      6c: b100e47f     	cmn	x3, #0x39
      70: 540003a8     	b.hi	0xe4 <f3_export_stream_encode_03+0xe4>
      74: 9100a04c     	add	x12, x2, #0x28
      78: 9100e06e     	add	x14, x3, #0x38
      7c: eb03019f     	cmp	x12, x3
      80: 54000069     	b.ls	0x8c <f3_export_stream_encode_03+0x8c>
      84: eb0201df     	cmp	x14, x2
      88: 540002e8     	b.hi	0xe4 <f3_export_stream_encode_03+0xe4>
      8c: b4000101     	cbz	x1, 0xac <f3_export_stream_encode_03+0xac>
      90: b101643f     	cmn	x1, #0x59
      94: 54000288     	b.hi	0xe4 <f3_export_stream_encode_03+0xe4>
      98: 91016028     	add	x8, x1, #0x58
      9c: eb03011f     	cmp	x8, x3
      a0: 54000069     	b.ls	0xac <f3_export_stream_encode_03+0xac>
      a4: eb0101df     	cmp	x14, x1
      a8: 540001e8     	b.hi	0xe4 <f3_export_stream_encode_03+0xe4>
      ac: a9402448     	ldp	x8, x9, [x2]
      b0: f100011f     	cmp	x8, #0x0
      b4: fa401924     	ccmp	x9, #0x0, #0x4, ne
      b8: 1a9f07ed     	cset	w13, ne
      bc: 54000100     	b.eq	0xdc <f3_export_stream_encode_03+0xdc>
      c0: ab09011f     	cmn	x8, x9
      c4: 54000102     	b.hs	0xe4 <f3_export_stream_encode_03+0xe4>
      c8: eb0801df     	cmp	x14, x8
      cc: 54000089     	b.ls	0xdc <f3_export_stream_encode_03+0xdc>
      d0: 8b08012b     	add	x11, x9, x8
      d4: eb03017f     	cmp	x11, x3
      d8: 54000068     	b.hi	0xe4 <f3_export_stream_encode_03+0xe4>
      dc: b10bc41f     	cmn	x0, #0x2f1
      e0: 540000a9     	b.ls	0xf4 <f3_export_stream_encode_03+0xf4>
      e4: a9497bfd     	ldp	x29, x30, [sp, #0x90]
      e8: f94053f3     	ldr	x19, [sp, #0xa0]
      ec: 9102c3ff     	add	sp, sp, #0xb0
      f0: 14000000     	b	0xf0 <f3_export_stream_encode_03+0xf0>
		00000000000000f0:  R_AARCH64_JUMP26	f3_stream_abort_03
      f4: 910bc00f     	add	x15, x0, #0x2f0
      f8: eb0001df     	cmp	x14, x0
      fc: fa4381e0     	ccmp	x15, x3, #0x0, hi
     100: 54ffff28     	b.hi	0xe4 <f3_export_stream_encode_03+0xe4>
     104: b100455f     	cmn	x10, #0x11
     108: 54fffee8     	b.hi	0xe4 <f3_export_stream_encode_03+0xe4>
     10c: eb0a01df     	cmp	x14, x10
     110: 54000089     	b.ls	0x120 <f3_export_stream_encode_03+0x120>
     114: 9100414a     	add	x10, x10, #0x10
     118: eb03015f     	cmp	x10, x3
     11c: 54fffe48     	b.hi	0xe4 <f3_export_stream_encode_03+0xe4>
     120: f941000a     	ldr	x10, [x0, #0x200]
     124: f941040b     	ldr	x11, [x0, #0x208]
     128: b400012a     	cbz	x10, 0x14c <f3_export_stream_encode_03+0x14c>
     12c: b400010b     	cbz	x11, 0x14c <f3_export_stream_encode_03+0x14c>
     130: ab0b015f     	cmn	x10, x11
     134: 54fffd82     	b.hs	0xe4 <f3_export_stream_encode_03+0xe4>
     138: eb0a01df     	cmp	x14, x10
     13c: 54000089     	b.ls	0x14c <f3_export_stream_encode_03+0x14c>
     140: 8b0a016e     	add	x14, x11, x10
     144: eb0301df     	cmp	x14, x3
     148: 54fffce8     	b.hi	0xe4 <f3_export_stream_encode_03+0xe4>
     14c: eb0201ff     	cmp	x15, x2
     150: 54000069     	b.ls	0x15c <f3_export_stream_encode_03+0x15c>
     154: eb00019f     	cmp	x12, x0
     158: 54fffc68     	b.hi	0xe4 <f3_export_stream_encode_03+0xe4>
     15c: b4000101     	cbz	x1, 0x17c <f3_export_stream_encode_03+0x17c>
     160: b101643f     	cmn	x1, #0x59
     164: 54fffc08     	b.hi	0xe4 <f3_export_stream_encode_03+0xe4>
     168: eb0101ff     	cmp	x15, x1
     16c: 54000089     	b.ls	0x17c <f3_export_stream_encode_03+0x17c>
     170: 9101602c     	add	x12, x1, #0x58
     174: eb00019f     	cmp	x12, x0
     178: 54fffb68     	b.hi	0xe4 <f3_export_stream_encode_03+0xe4>
     17c: 3400010d     	cbz	w13, 0x19c <f3_export_stream_encode_03+0x19c>
     180: ab09011f     	cmn	x8, x9
     184: 54fffb02     	b.hs	0xe4 <f3_export_stream_encode_03+0xe4>
     188: eb0801ff     	cmp	x15, x8
     18c: 54000089     	b.ls	0x19c <f3_export_stream_encode_03+0x19c>
     190: 8b08012c     	add	x12, x9, x8
     194: eb00019f     	cmp	x12, x0
     198: 54fffa68     	b.hi	0xe4 <f3_export_stream_encode_03+0xe4>
     19c: f9000fa0     	str	x0, [x29, #0x18]
     1a0: aa0803e0     	mov	x0, x8
     1a4: a90187e2     	stp	x2, x1, [sp, #0x18]
     1a8: aa0903e1     	mov	x1, x9
     1ac: aa0a03e2     	mov	x2, x10
     1b0: f90017e3     	str	x3, [sp, #0x28]
     1b4: aa0b03e3     	mov	x3, x11
     1b8: a900a3e9     	stp	x9, x8, [sp, #0x8]
     1bc: 94000000     	bl	0x1bc <f3_export_stream_encode_03+0x1bc>
		00000000000001bc:  R_AARCH64_CALL26	.text.overlap
     1c0: a940afea     	ldp	x10, x11, [sp, #0x8]
     1c4: 2a0003e8     	mov	w8, w0
     1c8: a941a7ec     	ldp	x12, x9, [sp, #0x18]
     1cc: f94017e3     	ldr	x3, [sp, #0x28]
     1d0: f9400fa0     	ldr	x0, [x29, #0x18]
     1d4: 35fff888     	cbnz	w8, 0xe4 <f3_export_stream_encode_03+0xe4>
     1d8: b9401988     	ldr	w8, [x12, #0x18]
     1dc: b942c80d     	ldr	w13, [x0, #0x2c8]
     1e0: 6b0d011f     	cmp	w8, w13
     1e4: 54fff801     	b.ne	0xe4 <f3_export_stream_encode_03+0xe4>
     1e8: b9401d8d     	ldr	w13, [x12, #0x1c]
     1ec: b942cc0e     	ldr	w14, [x0, #0x2cc]
     1f0: 6b0e01bf     	cmp	w13, w14
     1f4: 54fff781     	b.ne	0xe4 <f3_export_stream_encode_03+0xe4>
     1f8: b940218e     	ldr	w14, [x12, #0x20]
     1fc: b942e80f     	ldr	w15, [x0, #0x2e8]
     200: 6b0f01df     	cmp	w14, w15
     204: 54fff701     	b.ne	0xe4 <f3_export_stream_encode_03+0xe4>
     208: f940098c     	ldr	x12, [x12, #0x10]
     20c: fd417000     	ldr	d0, [x0, #0x2e0]
     210: d100c3a1     	sub	x1, x29, #0x30
     214: a93d2bab     	stp	x11, x10, [x29, #-0x30]
     218: 910123e2     	add	x2, sp, #0x48
     21c: aa0003f3     	mov	x19, x0
     220: f81e03ac     	stur	x12, [x29, #-0x20]
     224: 293d37a8     	stp	w8, w13, [x29, #-0x18]
     228: 90000008     	adrp	x8, 0x0 <f3_export_stream_encode_03>
		0000000000000228:  R_AARCH64_ADR_GOT_PAGE	f3_stream_sink_write_03
     22c: fc1f03a0     	stur	d0, [x29, #-0x10]
     230: 293f7fae     	stp	w14, wzr, [x29, #-0x8]
     234: f9400108     	ldr	x8, [x8]
		0000000000000234:  R_AARCH64_LD64_GOT_LO12_NC	f3_stream_sink_write_03
     238: f941080a     	ldr	x10, [x0, #0x210]
     23c: a904a3e0     	stp	x0, x8, [sp, #0x48]
     240: aa0903e0     	mov	x0, x9
     244: f9002fea     	str	x10, [sp, #0x58]
     248: 94000000     	bl	0x248 <f3_export_stream_encode_03+0x248>
		0000000000000248:  R_AARCH64_CALL26	iq4_jpeg_stream_export_rgb32_01
     24c: b9400268     	ldr	w8, [x19]
     250: 71000d1f     	cmp	w8, #0x3
     254: 54000081     	b.ne	0x264 <f3_export_stream_encode_03+0x264>
     258: f9400fa8     	ldr	x8, [x29, #0x18]
     25c: 91040100     	add	x0, x8, #0x100
     260: 17ffff7b     	b	0x4c <f3_export_stream_encode_03+0x4c>
     264: 34000080     	cbz	w0, 0x274 <f3_export_stream_encode_03+0x274>
     268: f9400fa0     	ldr	x0, [x29, #0x18]
     26c: 94000000     	bl	0x26c <f3_export_stream_encode_03+0x26c>
		000000000000026c:  R_AARCH64_CALL26	f3_stream_abort_03
     270: 17ffff77     	b	0x4c <f3_export_stream_encode_03+0x4c>
     274: f94017e8     	ldr	x8, [sp, #0x28]
     278: 0f000420     	movi	v0.2s, #0x1
     27c: f9400fa0     	ldr	x0, [x29, #0x18]
     280: 9100c3e1     	add	x1, sp, #0x30
     284: 2943250a     	ldp	w10, w9, [x8, #0x18]
     288: f9400508     	ldr	x8, [x8, #0x8]
     28c: fd001be0     	str	d0, [sp, #0x30]
     290: 7100053f     	cmp	w9, #0x1
     294: f90023e8     	str	x8, [sp, #0x40]
     298: 1a9f17e9     	cset	w9, eq
     29c: 29072be9     	stp	w9, w10, [sp, #0x38]
     2a0: 94000000     	bl	0x2a0 <f3_export_stream_encode_03+0x2a0>
		00000000000002a0:  R_AARCH64_CALL26	f3_stream_finish_03
     2a4: 17ffff6a     	b	0x4c <f3_export_stream_encode_03+0x4c>

Disassembly of section .text.f4_sha_block:

0000000000000000 <f4_sha_block>:
       0: d10503ff     	sub	sp, sp, #0x140
       4: a91067fd     	stp	x29, x25, [sp, #0x100]
       8: a9115ff8     	stp	x24, x23, [sp, #0x110]
       c: a91257f6     	stp	x22, x21, [sp, #0x120]
      10: a9134ff4     	stp	x20, x19, [sp, #0x130]
      14: 4c400020     	ld4	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x1]
      18: aa1f03e8     	mov	x8, xzr
      1c: 910003e9     	mov	x9, sp
      20: 2f08a424     	ushll	v4.8h, v1.8b, #0x0
      24: 2f08a445     	ushll	v5.8h, v2.8b, #0x0
      28: 2f08a406     	ushll	v6.8h, v0.8b, #0x0
      2c: 6f08a407     	ushll2	v7.8h, v0.16b, #0x0
      30: 6f08a430     	ushll2	v16.8h, v1.16b, #0x0
      34: 6f08a451     	ushll2	v17.8h, v2.16b, #0x0
      38: 2f08a474     	ushll	v20.8h, v3.8b, #0x0
      3c: 6f08a460     	ushll2	v0.8h, v3.16b, #0x0
      40: 2e613892     	shll	v18.4s, v4.4h, #16
      44: 2f18a4b3     	ushll	v19.4s, v5.4h, #0x8
      48: 6f10a4d5     	ushll2	v21.4s, v6.8h, #0x0
      4c: 6f10a4f6     	ushll2	v22.4s, v7.8h, #0x0
      50: 2f10a4c6     	ushll	v6.4s, v6.4h, #0x0
      54: 6e613a17     	shll2	v23.4s, v16.8h, #16
      58: 2f10a4e7     	ushll	v7.4s, v7.4h, #0x0
      5c: 2e613a10     	shll	v16.4s, v16.4h, #16
      60: 6e613884     	shll2	v4.4s, v4.8h, #16
      64: 4eb31e52     	orr	v18.16b, v18.16b, v19.16b
      68: 6f18a633     	ushll2	v19.4s, v17.8h, #0x8
      6c: 2f18a631     	ushll	v17.4s, v17.4h, #0x8
      70: 6f18a4a5     	ushll2	v5.4s, v5.8h, #0x8
      74: 4f3854c6     	shl	v6.4s, v6.4s, #0x18
      78: 4f3856c1     	shl	v1.4s, v22.4s, #0x18
      7c: 4f3854e7     	shl	v7.4s, v7.4s, #0x18
      80: 2f10a683     	ushll	v3.4s, v20.4h, #0x0
      84: 4eb31ee2     	orr	v2.16b, v23.16b, v19.16b
      88: 4eb11e10     	orr	v16.16b, v16.16b, v17.16b
      8c: 4f3856b1     	shl	v17.4s, v21.4s, #0x18
      90: 4ea51c84     	orr	v4.16b, v4.16b, v5.16b
      94: 4ea61e45     	orr	v5.16b, v18.16b, v6.16b
      98: 6f10a406     	ushll2	v6.4s, v0.8h, #0x0
      9c: 2f10a400     	ushll	v0.4s, v0.4h, #0x0
      a0: 4ea11c41     	orr	v1.16b, v2.16b, v1.16b
      a4: 4ea71e02     	orr	v2.16b, v16.16b, v7.16b
      a8: 6f10a687     	ushll2	v7.4s, v20.8h, #0x0
      ac: 4eb11c84     	orr	v4.16b, v4.16b, v17.16b
      b0: 4ea31ca3     	orr	v3.16b, v5.16b, v3.16b
      b4: 4ea01c40     	orr	v0.16b, v2.16b, v0.16b
      b8: 4ea61c21     	orr	v1.16b, v1.16b, v6.16b
      bc: 4ea71c82     	orr	v2.16b, v4.16b, v7.16b
      c0: ad0107e0     	stp	q0, q1, [sp, #0x20]
      c4: ad000be3     	stp	q3, q2, [sp]
      c8: b94003ea     	ldr	w10, [sp]
      cc: 8b08012b     	add	x11, x9, x8
      d0: 91001108     	add	x8, x8, #0x4
      d4: b940056c     	ldr	w12, [x11, #0x4]
      d8: b940396d     	ldr	w13, [x11, #0x38]
      dc: b9402570     	ldr	w16, [x11, #0x24]
      e0: f103011f     	cmp	x8, #0xc0
      e4: 138c1d8e     	ror	w14, w12, #0x7
      e8: 138d45af     	ror	w15, w13, #0x11
      ec: 0b10014a     	add	w10, w10, w16
      f0: 4acc49ce     	eor	w14, w14, w12, ror #18
      f4: 4acd4def     	eor	w15, w15, w13, ror #19
      f8: 4a4c0dce     	eor	w14, w14, w12, lsr #3
      fc: 4a4d29ed     	eor	w13, w15, w13, lsr #10
     100: 0b0a01ca     	add	w10, w14, w10
     104: 0b0d014a     	add	w10, w10, w13
     108: b900416a     	str	w10, [x11, #0x40]
     10c: 2a0c03ea     	mov	w10, w12
     110: 54fffde1     	b.ne	0xcc <f4_sha_block+0xcc>
     114: 29402c0a     	ldp	w10, w11, [x0]
     118: 29432408     	ldp	w8, w9, [x0, #0x18]
     11c: 29413c10     	ldp	w16, w15, [x0, #0x8]
     120: 2942340e     	ldp	w14, w13, [x0, #0x10]
     124: aa1f03ec     	mov	x12, xzr
     128: 90000011     	adrp	x17, 0x0 <f4_sha_block>
		0000000000000128:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.f4_sha_block.k
     12c: 91000231     	add	x17, x17, #0x0
		000000000000012c:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.f4_sha_block.k
     130: 910003e2     	mov	x2, sp
     134: 2a0903f3     	mov	w19, w9
     138: 2a0803f5     	mov	w21, w8
     13c: 2a0d03f6     	mov	w22, w13
     140: 2a0e03f4     	mov	w20, w14
     144: 2a0f03e7     	mov	w7, w15
     148: 2a1003f8     	mov	w24, w16
     14c: 2a0b03f9     	mov	w25, w11
     150: 2a0a03f7     	mov	w23, w10
     154: 2a1403e3     	mov	w3, w20
     158: 2a1503f2     	mov	w18, w21
     15c: 2a1703e6     	mov	w6, w23
     160: 2a1603e1     	mov	w1, w22
     164: 13941a94     	ror	w20, w20, #0x6
     168: 0a0302d5     	and	w21, w22, w3
     16c: 0a230256     	bic	w22, w18, w3
     170: 13970af7     	ror	w23, w23, #0x2
     174: 2a1803e4     	mov	w4, w24
     178: 2a1502d5     	orr	w21, w22, w21
     17c: b86c6a36     	ldr	w22, [x17, x12]
     180: 4ac32e94     	eor	w20, w20, w3, ror #11
     184: 0b150273     	add	w19, w19, w21
     188: 4ac636f5     	eor	w21, w23, w6, ror #13
     18c: b86c6858     	ldr	w24, [x2, x12]
     190: 0b160273     	add	w19, w19, w22
     194: 4a190096     	eor	w22, w4, w25
     198: 4ac36694     	eor	w20, w20, w3, ror #25
     19c: 4ac65ab5     	eor	w21, w21, w6, ror #22
     1a0: 0a0602d6     	and	w22, w22, w6
     1a4: 0a190097     	and	w23, w4, w25
     1a8: 0b180273     	add	w19, w19, w24
     1ac: 4a1702d6     	eor	w22, w22, w23
     1b0: 9100118c     	add	x12, x12, #0x4
     1b4: 0b140273     	add	w19, w19, w20
     1b8: 0b1502d5     	add	w21, w22, w21
     1bc: 2a1903e5     	mov	w5, w25
     1c0: 0b070274     	add	w20, w19, w7
     1c4: 0b1302b7     	add	w23, w21, w19
     1c8: f104019f     	cmp	x12, #0x100
     1cc: 2a1203f3     	mov	w19, w18
     1d0: 2a0103f5     	mov	w21, w1
     1d4: 2a0303f6     	mov	w22, w3
     1d8: 2a0403e7     	mov	w7, w4
     1dc: 2a1903f8     	mov	w24, w25
     1e0: 2a0603f9     	mov	w25, w6
     1e4: 54fffb81     	b.ne	0x154 <f4_sha_block+0x154>
     1e8: 0b0a02ea     	add	w10, w23, w10
     1ec: 0b0b00cb     	add	w11, w6, w11
     1f0: 0b080028     	add	w8, w1, w8
     1f4: 29002c0a     	stp	w10, w11, [x0]
     1f8: 0b1000aa     	add	w10, w5, w16
     1fc: 0b0f008b     	add	w11, w4, w15
     200: 29012c0a     	stp	w10, w11, [x0, #0x8]
     204: 0b0e028a     	add	w10, w20, w14
     208: 0b0d006b     	add	w11, w3, w13
     20c: a9534ff4     	ldp	x20, x19, [sp, #0x130]
     210: 0b090249     	add	w9, w18, w9
     214: a95257f6     	ldp	x22, x21, [sp, #0x120]
     218: 29022c0a     	stp	w10, w11, [x0, #0x10]
     21c: a9515ff8     	ldp	x24, x23, [sp, #0x110]
     220: 29032408     	stp	w8, w9, [x0, #0x18]
     224: a95067fd     	ldp	x29, x25, [sp, #0x100]
     228: 910503ff     	add	sp, sp, #0x140
     22c: d65f03c0     	ret
