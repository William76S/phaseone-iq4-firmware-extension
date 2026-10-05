
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_native_jpeg8_binding_build_01/native_jpeg82.o:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000000000 <iq4_native_jpeg82_unadmitted_table_01>:
       0: 52841e09     	mov	w9, #0x20f0             // =8432
       4: 5286970b     	mov	w11, #0x34b8            // =13496
       8: b900511f     	str	wzr, [x8, #0x50]
       c: 72a01349     	movk	w9, #0x9a, lsl #16
      10: 72a0134b     	movk	w11, #0x9a, lsl #16
      14: 9101612a     	add	x10, x9, #0x58
      18: a9002909     	stp	x9, x10, [x8]
      1c: 913b612a     	add	x10, x9, #0xed8
      20: a901290b     	stp	x11, x10, [x8, #0x10]
      24: 9114a16a     	add	x10, x11, #0x528
      28: 9117416b     	add	x11, x11, #0x5d0
      2c: a9022d0a     	stp	x10, x11, [x8, #0x20]
      30: b277012a     	orr	x10, x9, #0x200
      34: 91056129     	add	x9, x9, #0x158
      38: a903250a     	stp	x10, x9, [x8, #0x30]
      3c: 52800a49     	mov	w9, #0x52               // =82
      40: b9004109     	str	w9, [x8, #0x40]
      44: 52804909     	mov	w9, #0x248              // =584
      48: f9002509     	str	x9, [x8, #0x48]
      4c: d65f03c0     	ret

0000000000000050 <iq4_native_jpeg82_bind_01>:
      50: b4000c23     	cbz	x3, 0x1d4 <iq4_native_jpeg82_bind_01+0x184>
      54: d10283ff     	sub	sp, sp, #0xa0
      58: a9047bfd     	stp	x29, x30, [sp, #0x40]
      5c: a9056ffc     	stp	x28, x27, [sp, #0x50]
      60: a90667fa     	stp	x26, x25, [sp, #0x60]
      64: a9075ff8     	stp	x24, x23, [sp, #0x70]
      68: a90857f6     	stp	x22, x21, [sp, #0x80]
      6c: a9094ff4     	stp	x20, x19, [sp, #0x90]
      70: 910103fd     	add	x29, sp, #0x40
      74: 6f00e400     	movi	v0.2d, #0000000000000000
      78: aa0303f3     	mov	x19, x3
      7c: aa0003e8     	mov	x8, x0
      80: 52800020     	mov	w0, #0x1                // =1
      84: f900287f     	str	xzr, [x3, #0x50]
      88: ad008060     	stp	q0, q0, [x3, #0x10]
      8c: ad018060     	stp	q0, q0, [x3, #0x30]
      90: 3d800060     	str	q0, [x3]
      94: b4000aa8     	cbz	x8, 0x1e8 <iq4_native_jpeg82_bind_01+0x198>
      98: aa0103f5     	mov	x21, x1
      9c: b4000a61     	cbz	x1, 0x1e8 <iq4_native_jpeg82_bind_01+0x198>
      a0: aa0203f4     	mov	x20, x2
      a4: aa1f03e9     	mov	x9, xzr
      a8: 9000000a     	adrp	x10, 0x0 <iq4_native_jpeg82_unadmitted_table_01>
		00000000000000a8:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst32
      ac: 9100014a     	add	x10, x10, #0x0
		00000000000000ac:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.cst32
      b0: 3869690b     	ldrb	w11, [x8, x9]
      b4: 3869694c     	ldrb	w12, [x10, x9]
      b8: 6b0c017f     	cmp	w11, w12
      bc: 54000901     	b.ne	0x1dc <iq4_native_jpeg82_bind_01+0x18c>
      c0: 91000529     	add	x9, x9, #0x1
      c4: f100813f     	cmp	x9, #0x20
      c8: 54ffff41     	b.ne	0xb0 <iq4_native_jpeg82_bind_01+0x60>
      cc: aa1f03f7     	mov	x23, xzr
      d0: 52800308     	mov	w8, #0x18               // =24
      d4: 90000009     	adrp	x9, 0x0 <iq4_native_jpeg82_unadmitted_table_01>
		00000000000000d4:  R_AARCH64_ADR_PREL_PG_HI21	.data.rel.ro
      d8: 91000129     	add	x9, x9, #0x0
		00000000000000d8:  R_AARCH64_ADD_ABS_LO12_NC	.data.rel.ro
      dc: 9b0826fb     	madd	x27, x23, x8, x9
      e0: aa0903fa     	mov	x26, x9
      e4: f940077c     	ldr	x28, [x27, #0x8]
      e8: b400041c     	cbz	x28, 0x168 <iq4_native_jpeg82_bind_01+0x118>
      ec: f9400378     	ldr	x24, [x27]
      f0: aa1f03f9     	mov	x25, xzr
      f4: 14000004     	b	0x104 <iq4_native_jpeg82_bind_01+0xb4>
      f8: 8b1902d9     	add	x25, x22, x25
      fc: eb1c033f     	cmp	x25, x28
     100: 54000342     	b.hs	0x168 <iq4_native_jpeg82_bind_01+0x118>
     104: cb190388     	sub	x8, x28, x25
     108: 52800809     	mov	w9, #0x40               // =64
     10c: 8b190301     	add	x1, x24, x25
     110: f101011f     	cmp	x8, #0x40
     114: 910003e2     	mov	x2, sp
     118: aa1403e0     	mov	x0, x20
     11c: 9a893116     	csel	x22, x8, x9, lo
     120: aa1603e3     	mov	x3, x22
     124: d63f02a0     	blr	x21
     128: 7100041f     	cmp	w0, #0x1
     12c: 540006e1     	b.ne	0x208 <iq4_native_jpeg82_bind_01+0x1b8>
     130: eb19039f     	cmp	x28, x25
     134: 54fffe20     	b.eq	0xf8 <iq4_native_jpeg82_bind_01+0xa8>
     138: f9400b68     	ldr	x8, [x27, #0x10]
     13c: f10006df     	cmp	x22, #0x1
     140: 910003ea     	mov	x10, sp
     144: 9a9f86c9     	csinc	x9, x22, xzr, hi
     148: 8b190108     	add	x8, x8, x25
     14c: 3840154b     	ldrb	w11, [x10], #0x1
     150: 3840150c     	ldrb	w12, [x8], #0x1
     154: 6b0c017f     	cmp	w11, w12
     158: 54000461     	b.ne	0x1e4 <iq4_native_jpeg82_bind_01+0x194>
     15c: f1000529     	subs	x9, x9, #0x1
     160: 54ffff61     	b.ne	0x14c <iq4_native_jpeg82_bind_01+0xfc>
     164: 17ffffe5     	b	0xf8 <iq4_native_jpeg82_bind_01+0xa8>
     168: 910006f7     	add	x23, x23, #0x1
     16c: 52800308     	mov	w8, #0x18               // =24
     170: aa1a03e9     	mov	x9, x26
     174: f10026ff     	cmp	x23, #0x9
     178: 54fffb21     	b.ne	0xdc <iq4_native_jpeg82_bind_01+0x8c>
     17c: 52841e08     	mov	w8, #0x20f0             // =8432
     180: 5286970a     	mov	w10, #0x34b8            // =13496
     184: 2a1f03e0     	mov	w0, wzr
     188: 72a01348     	movk	w8, #0x9a, lsl #16
     18c: 72a0134a     	movk	w10, #0x9a, lsl #16
     190: 91016109     	add	x9, x8, #0x58
     194: a9002668     	stp	x8, x9, [x19]
     198: 913b6109     	add	x9, x8, #0xed8
     19c: a901266a     	stp	x10, x9, [x19, #0x10]
     1a0: 9114a149     	add	x9, x10, #0x528
     1a4: 9117414a     	add	x10, x10, #0x5d0
     1a8: a9022a69     	stp	x9, x10, [x19, #0x20]
     1ac: b2770109     	orr	x9, x8, #0x200
     1b0: 91056108     	add	x8, x8, #0x158
     1b4: a9032269     	stp	x9, x8, [x19, #0x30]
     1b8: 52800a48     	mov	w8, #0x52               // =82
     1bc: b9004268     	str	w8, [x19, #0x40]
     1c0: 52804908     	mov	w8, #0x248              // =584
     1c4: f9002668     	str	x8, [x19, #0x48]
     1c8: 52800028     	mov	w8, #0x1                // =1
     1cc: b9005268     	str	w8, [x19, #0x50]
     1d0: 14000006     	b	0x1e8 <iq4_native_jpeg82_bind_01+0x198>
     1d4: 52800020     	mov	w0, #0x1                // =1
     1d8: d65f03c0     	ret
     1dc: 52800040     	mov	w0, #0x2                // =2
     1e0: 14000002     	b	0x1e8 <iq4_native_jpeg82_bind_01+0x198>
     1e4: 52800080     	mov	w0, #0x4                // =4
     1e8: a9494ff4     	ldp	x20, x19, [sp, #0x90]
     1ec: a94857f6     	ldp	x22, x21, [sp, #0x80]
     1f0: a9475ff8     	ldp	x24, x23, [sp, #0x70]
     1f4: a94667fa     	ldp	x26, x25, [sp, #0x60]
     1f8: a9456ffc     	ldp	x28, x27, [sp, #0x50]
     1fc: a9447bfd     	ldp	x29, x30, [sp, #0x40]
     200: 910283ff     	add	sp, sp, #0xa0
     204: d65f03c0     	ret
     208: 52800060     	mov	w0, #0x3                // =3
     20c: 17fffff7     	b	0x1e8 <iq4_native_jpeg82_bind_01+0x198>
