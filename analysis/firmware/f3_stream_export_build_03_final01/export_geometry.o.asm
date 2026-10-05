
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_stream_export_build_03_final01/export_geometry.o:	file format elf64-littleaarch64

Disassembly of section .text.iq4_export_geometry:

0000000000000000 <iq4_export_geometry>:
       0: b40001e4     	cbz	x4, 0x3c <iq4_export_geometry+0x3c>
       4: 6f00e400     	movi	v0.2d, #0000000000000000
       8: 52800028     	mov	w8, #0x1                // =1
       c: ad000080     	stp	q0, q0, [x4]
      10: 34000120     	cbz	w0, 0x34 <iq4_export_geometry+0x34>
      14: 34000101     	cbz	w1, 0x34 <iq4_export_geometry+0x34>
      18: 7100147f     	cmp	w3, #0x5
      1c: 540000c8     	b.hi	0x34 <iq4_export_geometry+0x34>
      20: 7102cc5f     	cmp	w2, #0xb3
      24: 5400010c     	b.gt	0x44 <iq4_export_geometry+0x44>
      28: 34000162     	cbz	w2, 0x54 <iq4_export_geometry+0x54>
      2c: 7101685f     	cmp	w2, #0x5a
      30: 54000120     	b.eq	0x54 <iq4_export_geometry+0x54>
      34: 2a0803e0     	mov	w0, w8
      38: d65f03c0     	ret
      3c: 52800020     	mov	w0, #0x1                // =1
      40: d65f03c0     	ret
      44: 7104385f     	cmp	w2, #0x10e
      48: 54000060     	b.eq	0x54 <iq4_export_geometry+0x54>
      4c: 7102d05f     	cmp	w2, #0xb4
      50: 54ffff21     	b.ne	0x34 <iq4_export_geometry+0x34>
      54: 529ffb89     	mov	w9, #0xffdc             // =65500
      58: 52800068     	mov	w8, #0x3                // =3
      5c: 6b09001f     	cmp	w0, w9
      60: 54fffea8     	b.hi	0x34 <iq4_export_geometry+0x34>
      64: 6b09003f     	cmp	w1, w9
      68: 54fffe68     	b.hi	0x34 <iq4_export_geometry+0x34>
      6c: 71000c7f     	cmp	w3, #0x3
      70: 540000c8     	b.hi	0x88 <iq4_export_geometry+0x88>
      74: 90000008     	adrp	x8, 0x0 <iq4_export_geometry>
		0000000000000074:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst16
      78: 91000108     	add	x8, x8, #0x0
		0000000000000078:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.cst16
      7c: 52800c8b     	mov	w11, #0x64              // =100
      80: b863590a     	ldr	w10, [x8, w3, uxtw #2]
      84: 1400000c     	b	0xb4 <iq4_export_geometry+0xb4>
      88: 7100107f     	cmp	w3, #0x4
      8c: 5283c008     	mov	w8, #0x1e00             // =7680
      90: 5281e009     	mov	w9, #0xf00              // =3840
      94: 9a88012a     	csel	x10, x9, x8, eq
      98: 6b01001f     	cmp	w0, w1
      9c: 1a81800b     	csel	w11, w0, w1, hi
      a0: eb0b015f     	cmp	x10, x11
      a4: 54000089     	b.ls	0xb4 <iq4_export_geometry+0xb4>
      a8: 52800048     	mov	w8, #0x2                // =2
      ac: 2a0803e0     	mov	w0, w8
      b0: d65f03c0     	ret
      b4: d341fd6c     	lsr	x12, x11, #1
      b8: 9ba03148     	umaddl	x8, w10, w0, x12
      bc: 9acb0909     	udiv	x9, x8, x11
      c0: 51000528     	sub	w8, w9, #0x1
      c4: 6b00011f     	cmp	w8, w0
      c8: 52800068     	mov	w8, #0x3                // =3
      cc: 54fffb42     	b.hs	0x34 <iq4_export_geometry+0x34>
      d0: 9ba1314a     	umaddl	x10, w10, w1, x12
      d4: 9acb094a     	udiv	x10, x10, x11
      d8: 5100054b     	sub	w11, w10, #0x1
      dc: 6b01017f     	cmp	w11, w1
      e0: 54fffaa2     	b.hs	0x34 <iq4_export_geometry+0x34>
      e4: 7104385f     	cmp	w2, #0x10e
      e8: 540000a0     	b.eq	0xfc <iq4_export_geometry+0xfc>
      ec: 7101685f     	cmp	w2, #0x5a
      f0: 2a0903eb     	mov	w11, w9
      f4: 2a0a03ec     	mov	w12, w10
      f8: 54000061     	b.ne	0x104 <iq4_export_geometry+0x104>
      fc: 2a0a03eb     	mov	w11, w10
     100: 2a0903ec     	mov	w12, w9
     104: 29000480     	stp	w0, w1, [x4]
     108: 2a1f03e0     	mov	w0, wzr
     10c: 29012889     	stp	w9, w10, [x4, #0x8]
     110: 2902308b     	stp	w11, w12, [x4, #0x10]
     114: 29030c82     	stp	w2, w3, [x4, #0x18]
     118: d65f03c0     	ret
