
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  71b500: f9400be0     	ldr	x0, [sp, #0x10]
  71b504: 97f3ba8b     	bl	0x409f30 <snprintf@plt>
  71b508: f9400be0     	ldr	x0, [sp, #0x10]
  71b50c: 14000009     	b	0x71b530 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1804>
  71b510: b9401be1     	ldr	w1, [sp, #0x18]
  71b514: bd401fe0     	ldr	s0, [sp, #0x1c]
  71b518: 1e22c000     	fcvt	d0, s0
  71b51c: d0002840     	adrp	x0, 0xc25000
  71b520: 91378002     	add	x2, x0, #0xde0
  71b524: f9400be0     	ldr	x0, [sp, #0x10]
  71b528: 97f3ba82     	bl	0x409f30 <snprintf@plt>
  71b52c: f9400be0     	ldr	x0, [sp, #0x10]
  71b530: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  71b534: d65f03c0     	ret
  71b538: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  71b53c: 910003fd     	mov	x29, sp
  71b540: b9001fe0     	str	w0, [sp, #0x1c]
  71b544: b9401fe1     	ldr	w1, [sp, #0x1c]
  71b548: 320107e0     	mov	w0, #-0x7fffffff        // =-2147483647
  71b54c: 6b00003f     	cmp	w1, w0
  71b550: 54000080     	b.eq	0x71b560 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1834>
  71b554: b9401fe0     	ldr	w0, [sp, #0x1c]
  71b558: 3102d01f     	cmn	w0, #0xb4
  71b55c: 54000081     	b.ne	0x71b56c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1840>
  71b560: 52836000     	mov	w0, #0x1b00             // =6912
  71b564: 72a8e600     	movk	w0, #0x4730, lsl #16
  71b568: 140000a4     	b	0x71b7f8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1acc>
  71b56c: b9401fe1     	ldr	w1, [sp, #0x1c]
  71b570: 52800040     	mov	w0, #0x2                // =2
  71b574: 72b00000     	movk	w0, #0x8000, lsl #16
  71b578: 6b00003f     	cmp	w1, w0
  71b57c: 54000080     	b.eq	0x71b58c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1860>
  71b580: b9401fe0     	ldr	w0, [sp, #0x1c]
  71b584: 3102e81f     	cmn	w0, #0xba
  71b588: 54000081     	b.ne	0x71b598 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x186c>
  71b58c: 52838000     	mov	w0, #0x1c00             // =7168
  71b590: 72a8e600     	movk	w0, #0x4730, lsl #16
  71b594: 14000099     	b	0x71b7f8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1acc>
  71b598: 52800020     	mov	w0, #0x1                // =1
  71b59c: b9002fe0     	str	w0, [sp, #0x2c]
  71b5a0: b9402fe0     	ldr	w0, [sp, #0x2c]
  71b5a4: 11000401     	add	w1, w0, #0x1
  71b5a8: 52801460     	mov	w0, #0xa3               // =163
  71b5ac: 6b00003f     	cmp	w1, w0
  71b5b0: 54000d42     	b.hs	0x71b758 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1a2c>
  71b5b4: f0002840     	adrp	x0, 0xc26000
  71b5b8: 91136002     	add	x2, x0, #0x4d8
  71b5bc: b9402fe1     	ldr	w1, [sp, #0x2c]
  71b5c0: aa0103e0     	mov	x0, x1
  71b5c4: d37ef400     	lsl	x0, x0, #2
  71b5c8: 8b010000     	add	x0, x0, x1
  71b5cc: d37ef400     	lsl	x0, x0, #2
  71b5d0: 8b000040     	add	x0, x2, x0
  71b5d4: b9400802     	ldr	w2, [x0, #0x8]
  71b5d8: f0002840     	adrp	x0, 0xc26000
  71b5dc: 91136003     	add	x3, x0, #0x4d8
  71b5e0: b9402fe1     	ldr	w1, [sp, #0x2c]
  71b5e4: aa0103e0     	mov	x0, x1
  71b5e8: d37ef400     	lsl	x0, x0, #2
  71b5ec: 8b010000     	add	x0, x0, x1
  71b5f0: d37ef400     	lsl	x0, x0, #2
  71b5f4: 8b000060     	add	x0, x3, x0
  71b5f8: b9400803     	ldr	w3, [x0, #0x8]
  71b5fc: b9402fe0     	ldr	w0, [sp, #0x2c]
  71b600: 11000401     	add	w1, w0, #0x1
  71b604: f0002840     	adrp	x0, 0xc26000
  71b608: 91136004     	add	x4, x0, #0x4d8
  71b60c: 2a0103e1     	mov	w1, w1
  71b610: aa0103e0     	mov	x0, x1
  71b614: d37ef400     	lsl	x0, x0, #2
  71b618: 8b010000     	add	x0, x0, x1
  71b61c: d37ef400     	lsl	x0, x0, #2
  71b620: 8b000080     	add	x0, x4, x0
  71b624: b9400800     	ldr	w0, [x0, #0x8]
  71b628: 4b000060     	sub	w0, w3, w0
  71b62c: 531f7c01     	lsr	w1, w0, #31
  71b630: 0b000021     	add	w1, w1, w0
  71b634: 13017c20     	asr	w0, w1, #1
  71b638: 4b0003e0     	neg	w0, w0
  71b63c: 0b000040     	add	w0, w2, w0
  71b640: b90027e0     	str	w0, [sp, #0x24]
  71b644: f0002840     	adrp	x0, 0xc26000
  71b648: 91136002     	add	x2, x0, #0x4d8
  71b64c: b9402fe1     	ldr	w1, [sp, #0x2c]
  71b650: aa0103e0     	mov	x0, x1
  71b654: d37ef400     	lsl	x0, x0, #2
  71b658: 8b010000     	add	x0, x0, x1
  71b65c: d37ef400     	lsl	x0, x0, #2
  71b660: 8b000040     	add	x0, x2, x0
  71b664: b9400802     	ldr	w2, [x0, #0x8]
  71b668: b9402fe0     	ldr	w0, [sp, #0x2c]
  71b66c: 51000401     	sub	w1, w0, #0x1
  71b670: f0002840     	adrp	x0, 0xc26000
  71b674: 91136003     	add	x3, x0, #0x4d8
  71b678: 2a0103e1     	mov	w1, w1
  71b67c: aa0103e0     	mov	x0, x1
  71b680: d37ef400     	lsl	x0, x0, #2
  71b684: 8b010000     	add	x0, x0, x1
  71b688: d37ef400     	lsl	x0, x0, #2
  71b68c: 8b000060     	add	x0, x3, x0
  71b690: b9400803     	ldr	w3, [x0, #0x8]
  71b694: f0002840     	adrp	x0, 0xc26000
  71b698: 91136004     	add	x4, x0, #0x4d8
  71b69c: b9402fe1     	ldr	w1, [sp, #0x2c]
  71b6a0: aa0103e0     	mov	x0, x1
  71b6a4: d37ef400     	lsl	x0, x0, #2
  71b6a8: 8b010000     	add	x0, x0, x1
  71b6ac: d37ef400     	lsl	x0, x0, #2
  71b6b0: 8b000080     	add	x0, x4, x0
  71b6b4: b9400800     	ldr	w0, [x0, #0x8]
  71b6b8: 4b000060     	sub	w0, w3, w0
  71b6bc: 531f7c01     	lsr	w1, w0, #31
  71b6c0: 0b000020     	add	w0, w1, w0
  71b6c4: 13017c01     	asr	w1, w0, #1
  71b6c8: 2a0103e0     	mov	w0, w1
  71b6cc: 0b000040     	add	w0, w2, w0
  71b6d0: b90023e0     	str	w0, [sp, #0x20]
  71b6d4: 910083e1     	add	x1, sp, #0x20
  71b6d8: 910093e0     	add	x0, sp, #0x24
  71b6dc: 97f51281     	bl	0x4600e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x2a134>
  71b6e0: b9400000     	ldr	w0, [x0]
  71b6e4: b9401fe1     	ldr	w1, [sp, #0x1c]
  71b6e8: 6b00003f     	cmp	w1, w0
  71b6ec: 5400014b     	b.lt	0x71b714 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x19e8>
  71b6f0: 910083e1     	add	x1, sp, #0x20
  71b6f4: 910093e0     	add	x0, sp, #0x24
  71b6f8: 97f58b40     	bl	0x47e3f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x4844c>
  71b6fc: b9400000     	ldr	w0, [x0]
  71b700: b9401fe1     	ldr	w1, [sp, #0x1c]
  71b704: 6b00003f     	cmp	w1, w0
  71b708: 5400006a     	b.ge	0x71b714 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x19e8>
  71b70c: 52800020     	mov	w0, #0x1                // =1
  71b710: 14000002     	b	0x71b718 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x19ec>
  71b714: 52800000     	mov	w0, #0x0                // =0
  71b718: 7100001f     	cmp	w0, #0x0
  71b71c: 54000160     	b.eq	0x71b748 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1a1c>
  71b720: f0002840     	adrp	x0, 0xc26000
  71b724: 91136002     	add	x2, x0, #0x4d8
  71b728: b9402fe1     	ldr	w1, [sp, #0x2c]
  71b72c: aa0103e0     	mov	x0, x1
  71b730: d37ef400     	lsl	x0, x0, #2
  71b734: 8b010000     	add	x0, x0, x1
  71b738: d37ef400     	lsl	x0, x0, #2
  71b73c: 8b000040     	add	x0, x2, x0
  71b740: b9400000     	ldr	w0, [x0]
  71b744: 1400002d     	b	0x71b7f8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1acc>
  71b748: b9402fe0     	ldr	w0, [sp, #0x2c]
  71b74c: 11000400     	add	w0, w0, #0x1
  71b750: b9002fe0     	str	w0, [sp, #0x2c]
  71b754: 17ffff93     	b	0x71b5a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1874>
  71b758: b9401fe0     	ldr	w0, [sp, #0x1c]
  71b75c: 7100001f     	cmp	w0, #0x0
  71b760: 5400010d     	b.le	0x71b780 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1a54>
  71b764: d0002840     	adrp	x0, 0xc25000
  71b768: 9137a003     	add	x3, x0, #0xde8
  71b76c: 52803b62     	mov	w2, #0x1db              // =475
  71b770: d0002840     	adrp	x0, 0xc25000
  71b774: 91388001     	add	x1, x0, #0xe20
  71b778: 52800040     	mov	w0, #0x2                // =2
  71b77c: 9400ab74     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  71b780: b9401fe0     	ldr	w0, [sp, #0x1c]
  71b784: 7100001f     	cmp	w0, #0x0
  71b788: 5400014d     	b.le	0x71b7b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1a84>
  71b78c: b9401fe0     	ldr	w0, [sp, #0x1c]
  71b790: 1e620001     	scvtf	d1, w0
  71b794: 1e651000     	fmov	d0, #12.00000000
  71b798: 1e601820     	fdiv	d0, d1, d0
  71b79c: 52800040     	mov	w0, #0x2                // =2
  71b7a0: 9400049c     	bl	0x71ca10 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2ce4>
  71b7a4: 1e624000     	fcvt	s0, d0
  71b7a8: bd002be0     	str	s0, [sp, #0x28]
  71b7ac: 14000012     	b	0x71b7f4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1ac8>
  71b7b0: b9401fe0     	ldr	w0, [sp, #0x1c]
  71b7b4: 7100001f     	cmp	w0, #0x0
  71b7b8: 540001aa     	b.ge	0x71b7ec <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1ac0>
  71b7bc: b9401fe0     	ldr	w0, [sp, #0x1c]
  71b7c0: 1e620001     	scvtf	d1, w0
  71b7c4: 1e651000     	fmov	d0, #12.00000000
  71b7c8: 1e601820     	fdiv	d0, d1, d0
  71b7cc: 52800040     	mov	w0, #0x2                // =2
  71b7d0: 94000490     	bl	0x71ca10 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2ce4>
  71b7d4: 1e604001     	fmov	d1, d0
  71b7d8: 1e6e1000     	fmov	d0, #1.00000000
  71b7dc: 1e611800     	fdiv	d0, d0, d1
  71b7e0: 1e624000     	fcvt	s0, d0
  71b7e4: bd002be0     	str	s0, [sp, #0x28]
  71b7e8: 14000003     	b	0x71b7f4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1ac8>
  71b7ec: 1e2e1000     	fmov	s0, #1.00000000
  71b7f0: bd002be0     	str	s0, [sp, #0x28]
  71b7f4: b9402be0     	ldr	w0, [sp, #0x28]
  71b7f8: 1e270000     	fmov	s0, w0
  71b7fc: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  71b800: d65f03c0     	ret
  71b804: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  71b808: 910003fd     	mov	x29, sp
  71b80c: bd001fe0     	str	s0, [sp, #0x1c]
  71b810: 52836000     	mov	w0, #0x1b00             // =6912
  71b814: 72a8e600     	movk	w0, #0x4730, lsl #16
  71b818: 1e270001     	fmov	s1, w0
  71b81c: bd401fe0     	ldr	s0, [sp, #0x1c]
  71b820: 1e203820     	fsub	s0, s1, s0
  71b824: 52836000     	mov	w0, #0x1b00             // =6912
  71b828: 72a8e600     	movk	w0, #0x4730, lsl #16
  71b82c: 1e270001     	fmov	s1, w0
  71b830: 1e211800     	fdiv	s0, s0, s1
  71b834: 97f62da1     	bl	0x4a6eb8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x70f0c>
  71b838: 1e22c000     	fcvt	d0, s0
  71b83c: 90002860     	adrp	x0, 0xc27000
  71b840: fd46e801     	ldr	d1, [x0, #0xdd0]
  71b844: 1e612010     	fcmpe	d0, d1
  71b848: 1a9f57e0     	cset	w0, mi
  71b84c: 12001c00     	and	w0, w0, #0xff
  71b850: 7100001f     	cmp	w0, #0x0
  71b854: 54000060     	b.eq	0x71b860 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1b34>
  71b858: 320107e0     	mov	w0, #-0x7fffffff        // =-2147483647
  71b85c: 14000083     	b	0x71ba68 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1d3c>
  71b860: 52838000     	mov	w0, #0x1c00             // =7168
  71b864: 72a8e600     	movk	w0, #0x4730, lsl #16
  71b868: 1e270001     	fmov	s1, w0
  71b86c: bd401fe0     	ldr	s0, [sp, #0x1c]
  71b870: 1e203820     	fsub	s0, s1, s0
  71b874: 52838000     	mov	w0, #0x1c00             // =7168
  71b878: 72a8e600     	movk	w0, #0x4730, lsl #16
  71b87c: 1e270001     	fmov	s1, w0
  71b880: 1e211800     	fdiv	s0, s0, s1
  71b884: 97f62d8d     	bl	0x4a6eb8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x70f0c>
  71b888: 1e22c000     	fcvt	d0, s0
  71b88c: 90002860     	adrp	x0, 0xc27000
  71b890: fd46e801     	ldr	d1, [x0, #0xdd0]
  71b894: 1e612010     	fcmpe	d0, d1
  71b898: 1a9f57e0     	cset	w0, mi
  71b89c: 12001c00     	and	w0, w0, #0xff
  71b8a0: 7100001f     	cmp	w0, #0x0
  71b8a4: 54000080     	b.eq	0x71b8b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1b88>
  71b8a8: 52800040     	mov	w0, #0x2                // =2
  71b8ac: 72b00000     	movk	w0, #0x8000, lsl #16
  71b8b0: 1400006e     	b	0x71ba68 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1d3c>
  71b8b4: 52800020     	mov	w0, #0x1                // =1
  71b8b8: b9002fe0     	str	w0, [sp, #0x2c]
  71b8bc: b9402fe0     	ldr	w0, [sp, #0x2c]
  71b8c0: 11000401     	add	w1, w0, #0x1
  71b8c4: 52801460     	mov	w0, #0xa3               // =163
  71b8c8: 6b00003f     	cmp	w1, w0
  71b8cc: 54000cc2     	b.hs	0x71ba64 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1d38>
  71b8d0: f0002840     	adrp	x0, 0xc26000
  71b8d4: 91136002     	add	x2, x0, #0x4d8
  71b8d8: b9402fe1     	ldr	w1, [sp, #0x2c]
  71b8dc: aa0103e0     	mov	x0, x1
  71b8e0: d37ef400     	lsl	x0, x0, #2
  71b8e4: 8b010000     	add	x0, x0, x1
  71b8e8: d37ef400     	lsl	x0, x0, #2
  71b8ec: 8b000040     	add	x0, x2, x0
  71b8f0: bd400001     	ldr	s1, [x0]
  71b8f4: f0002840     	adrp	x0, 0xc26000
  71b8f8: 91136002     	add	x2, x0, #0x4d8
  71b8fc: b9402fe1     	ldr	w1, [sp, #0x2c]
  71b900: aa0103e0     	mov	x0, x1
  71b904: d37ef400     	lsl	x0, x0, #2
  71b908: 8b010000     	add	x0, x0, x1
  71b90c: d37ef400     	lsl	x0, x0, #2
  71b910: 8b000040     	add	x0, x2, x0
  71b914: bd400002     	ldr	s2, [x0]
  71b918: b9402fe0     	ldr	w0, [sp, #0x2c]
  71b91c: 11000401     	add	w1, w0, #0x1
  71b920: f0002840     	adrp	x0, 0xc26000
  71b924: 91136002     	add	x2, x0, #0x4d8
  71b928: 2a0103e1     	mov	w1, w1
  71b92c: aa0103e0     	mov	x0, x1
  71b930: d37ef400     	lsl	x0, x0, #2
  71b934: 8b010000     	add	x0, x0, x1
  71b938: d37ef400     	lsl	x0, x0, #2
  71b93c: 8b000040     	add	x0, x2, x0
  71b940: bd400000     	ldr	s0, [x0]
  71b944: 1e203842     	fsub	s2, s2, s0
  71b948: 1e201000     	fmov	s0, #2.00000000
  71b94c: 1e201840     	fdiv	s0, s2, s0
  71b950: 1e203820     	fsub	s0, s1, s0
  71b954: bd002be0     	str	s0, [sp, #0x28]
  71b958: f0002840     	adrp	x0, 0xc26000
  71b95c: 91136002     	add	x2, x0, #0x4d8
  71b960: b9402fe1     	ldr	w1, [sp, #0x2c]
  71b964: aa0103e0     	mov	x0, x1
  71b968: d37ef400     	lsl	x0, x0, #2
  71b96c: 8b010000     	add	x0, x0, x1
  71b970: d37ef400     	lsl	x0, x0, #2
  71b974: 8b000040     	add	x0, x2, x0
  71b978: bd400001     	ldr	s1, [x0]
  71b97c: b9402fe0     	ldr	w0, [sp, #0x2c]
  71b980: 51000401     	sub	w1, w0, #0x1
  71b984: f0002840     	adrp	x0, 0xc26000
  71b988: 91136002     	add	x2, x0, #0x4d8
  71b98c: 2a0103e1     	mov	w1, w1
  71b990: aa0103e0     	mov	x0, x1
  71b994: d37ef400     	lsl	x0, x0, #2
  71b998: 8b010000     	add	x0, x0, x1
  71b99c: d37ef400     	lsl	x0, x0, #2
  71b9a0: 8b000040     	add	x0, x2, x0
  71b9a4: bd400002     	ldr	s2, [x0]
  71b9a8: f0002840     	adrp	x0, 0xc26000
  71b9ac: 91136002     	add	x2, x0, #0x4d8
  71b9b0: b9402fe1     	ldr	w1, [sp, #0x2c]
  71b9b4: aa0103e0     	mov	x0, x1
  71b9b8: d37ef400     	lsl	x0, x0, #2
  71b9bc: 8b010000     	add	x0, x0, x1
  71b9c0: d37ef400     	lsl	x0, x0, #2
  71b9c4: 8b000040     	add	x0, x2, x0
  71b9c8: bd400000     	ldr	s0, [x0]
  71b9cc: 1e203842     	fsub	s2, s2, s0
  71b9d0: 1e201000     	fmov	s0, #2.00000000
  71b9d4: 1e201840     	fdiv	s0, s2, s0
  71b9d8: 1e202820     	fadd	s0, s1, s0
  71b9dc: bd0027e0     	str	s0, [sp, #0x24]
  71b9e0: 910093e1     	add	x1, sp, #0x24
  71b9e4: 9100a3e0     	add	x0, sp, #0x28
  71b9e8: 97f58a9a     	bl	0x47e450 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x484a4>
  71b9ec: bd400000     	ldr	s0, [x0]
  71b9f0: bd401fe1     	ldr	s1, [sp, #0x1c]
  71b9f4: 1e202030     	fcmpe	s1, s0
  71b9f8: 5400014b     	b.lt	0x71ba20 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1cf4>
  71b9fc: 910093e1     	add	x1, sp, #0x24
  71ba00: 9100a3e0     	add	x0, sp, #0x28
  71ba04: 97f63e6c     	bl	0x4ab3b4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75408>
  71ba08: bd400000     	ldr	s0, [x0]
  71ba0c: bd401fe1     	ldr	s1, [sp, #0x1c]
  71ba10: 1e202030     	fcmpe	s1, s0
  71ba14: 54000068     	b.hi	0x71ba20 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1cf4>
  71ba18: 52800020     	mov	w0, #0x1                // =1
  71ba1c: 14000002     	b	0x71ba24 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1cf8>
  71ba20: 52800000     	mov	w0, #0x0                // =0
  71ba24: 7100001f     	cmp	w0, #0x0
  71ba28: 54000160     	b.eq	0x71ba54 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1d28>
  71ba2c: f0002840     	adrp	x0, 0xc26000
  71ba30: 91136002     	add	x2, x0, #0x4d8
  71ba34: b9402fe1     	ldr	w1, [sp, #0x2c]
  71ba38: aa0103e0     	mov	x0, x1
  71ba3c: d37ef400     	lsl	x0, x0, #2
  71ba40: 8b010000     	add	x0, x0, x1
  71ba44: d37ef400     	lsl	x0, x0, #2
  71ba48: 8b000040     	add	x0, x2, x0
  71ba4c: b9400800     	ldr	w0, [x0, #0x8]
  71ba50: 14000006     	b	0x71ba68 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1d3c>
  71ba54: b9402fe0     	ldr	w0, [sp, #0x2c]
  71ba58: 11000400     	add	w0, w0, #0x1
  71ba5c: b9002fe0     	str	w0, [sp, #0x2c]
  71ba60: 17ffff97     	b	0x71b8bc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1b90>
  71ba64: 52800000     	mov	w0, #0x0                // =0
  71ba68: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  71ba6c: d65f03c0     	ret
  71ba70: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  71ba74: 910003fd     	mov	x29, sp
  71ba78: bd001fe0     	str	s0, [sp, #0x1c]
  71ba7c: 52800020     	mov	w0, #0x1                // =1
  71ba80: b9002fe0     	str	w0, [sp, #0x2c]
  71ba84: b9402fe0     	ldr	w0, [sp, #0x2c]
  71ba88: 11000401     	add	w1, w0, #0x1
  71ba8c: 52800a20     	mov	w0, #0x51               // =81
  71ba90: 6b00003f     	cmp	w1, w0
  71ba94: 54000cc2     	b.hs	0x71bc2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1f00>
  71ba98: d0002840     	adrp	x0, 0xc25000
  71ba9c: 913a0002     	add	x2, x0, #0xe80
  71baa0: b9402fe1     	ldr	w1, [sp, #0x2c]
  71baa4: aa0103e0     	mov	x0, x1
  71baa8: d37ef400     	lsl	x0, x0, #2
  71baac: 8b010000     	add	x0, x0, x1
  71bab0: d37ef400     	lsl	x0, x0, #2
  71bab4: 8b000040     	add	x0, x2, x0
  71bab8: bd400001     	ldr	s1, [x0]
  71babc: d0002840     	adrp	x0, 0xc25000
  71bac0: 913a0002     	add	x2, x0, #0xe80
  71bac4: b9402fe1     	ldr	w1, [sp, #0x2c]
  71bac8: aa0103e0     	mov	x0, x1
  71bacc: d37ef400     	lsl	x0, x0, #2
  71bad0: 8b010000     	add	x0, x0, x1
  71bad4: d37ef400     	lsl	x0, x0, #2
  71bad8: 8b000040     	add	x0, x2, x0
  71badc: bd400002     	ldr	s2, [x0]
  71bae0: b9402fe0     	ldr	w0, [sp, #0x2c]
  71bae4: 11000401     	add	w1, w0, #0x1
  71bae8: d0002840     	adrp	x0, 0xc25000
  71baec: 913a0002     	add	x2, x0, #0xe80
  71baf0: 2a0103e1     	mov	w1, w1
  71baf4: aa0103e0     	mov	x0, x1
  71baf8: d37ef400     	lsl	x0, x0, #2
  71bafc: 8b010000     	add	x0, x0, x1
  71bb00: d37ef400     	lsl	x0, x0, #2
  71bb04: 8b000040     	add	x0, x2, x0
  71bb08: bd400000     	ldr	s0, [x0]
  71bb0c: 1e203842     	fsub	s2, s2, s0
  71bb10: 1e201000     	fmov	s0, #2.00000000
  71bb14: 1e201840     	fdiv	s0, s2, s0
  71bb18: 1e203820     	fsub	s0, s1, s0
  71bb1c: bd002be0     	str	s0, [sp, #0x28]
  71bb20: d0002840     	adrp	x0, 0xc25000
  71bb24: 913a0002     	add	x2, x0, #0xe80
  71bb28: b9402fe1     	ldr	w1, [sp, #0x2c]
  71bb2c: aa0103e0     	mov	x0, x1
  71bb30: d37ef400     	lsl	x0, x0, #2
  71bb34: 8b010000     	add	x0, x0, x1
  71bb38: d37ef400     	lsl	x0, x0, #2
  71bb3c: 8b000040     	add	x0, x2, x0
  71bb40: bd400001     	ldr	s1, [x0]
  71bb44: b9402fe0     	ldr	w0, [sp, #0x2c]
  71bb48: 51000401     	sub	w1, w0, #0x1
  71bb4c: d0002840     	adrp	x0, 0xc25000
  71bb50: 913a0002     	add	x2, x0, #0xe80
  71bb54: 2a0103e1     	mov	w1, w1
  71bb58: aa0103e0     	mov	x0, x1
  71bb5c: d37ef400     	lsl	x0, x0, #2
  71bb60: 8b010000     	add	x0, x0, x1
  71bb64: d37ef400     	lsl	x0, x0, #2
  71bb68: 8b000040     	add	x0, x2, x0
  71bb6c: bd400002     	ldr	s2, [x0]
  71bb70: d0002840     	adrp	x0, 0xc25000
  71bb74: 913a0002     	add	x2, x0, #0xe80
  71bb78: b9402fe1     	ldr	w1, [sp, #0x2c]
  71bb7c: aa0103e0     	mov	x0, x1
  71bb80: d37ef400     	lsl	x0, x0, #2
  71bb84: 8b010000     	add	x0, x0, x1
  71bb88: d37ef400     	lsl	x0, x0, #2
  71bb8c: 8b000040     	add	x0, x2, x0
  71bb90: bd400000     	ldr	s0, [x0]
  71bb94: 1e203842     	fsub	s2, s2, s0
  71bb98: 1e201000     	fmov	s0, #2.00000000
  71bb9c: 1e201840     	fdiv	s0, s2, s0
  71bba0: 1e202820     	fadd	s0, s1, s0
  71bba4: bd0027e0     	str	s0, [sp, #0x24]
  71bba8: 910093e1     	add	x1, sp, #0x24
  71bbac: 9100a3e0     	add	x0, sp, #0x28
  71bbb0: 97f58a28     	bl	0x47e450 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x484a4>
  71bbb4: bd400000     	ldr	s0, [x0]
  71bbb8: bd401fe1     	ldr	s1, [sp, #0x1c]
  71bbbc: 1e202030     	fcmpe	s1, s0
  71bbc0: 5400014b     	b.lt	0x71bbe8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1ebc>
  71bbc4: 910093e1     	add	x1, sp, #0x24
  71bbc8: 9100a3e0     	add	x0, sp, #0x28
  71bbcc: 97f63dfa     	bl	0x4ab3b4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75408>
  71bbd0: bd400000     	ldr	s0, [x0]
  71bbd4: bd401fe1     	ldr	s1, [sp, #0x1c]
  71bbd8: 1e202030     	fcmpe	s1, s0
  71bbdc: 54000068     	b.hi	0x71bbe8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1ebc>
  71bbe0: 52800020     	mov	w0, #0x1                // =1
  71bbe4: 14000002     	b	0x71bbec <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1ec0>
  71bbe8: 52800000     	mov	w0, #0x0                // =0
  71bbec: 7100001f     	cmp	w0, #0x0
  71bbf0: 54000160     	b.eq	0x71bc1c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1ef0>
  71bbf4: d0002840     	adrp	x0, 0xc25000
  71bbf8: 913a0002     	add	x2, x0, #0xe80
  71bbfc: b9402fe1     	ldr	w1, [sp, #0x2c]
  71bc00: aa0103e0     	mov	x0, x1
  71bc04: d37ef400     	lsl	x0, x0, #2
  71bc08: 8b010000     	add	x0, x0, x1
  71bc0c: d37ef400     	lsl	x0, x0, #2
  71bc10: 8b000040     	add	x0, x2, x0
  71bc14: b9400800     	ldr	w0, [x0, #0x8]
  71bc18: 14000006     	b	0x71bc30 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1f04>
  71bc1c: b9402fe0     	ldr	w0, [sp, #0x2c]
  71bc20: 11000400     	add	w0, w0, #0x1
  71bc24: b9002fe0     	str	w0, [sp, #0x2c]
  71bc28: 17ffff97     	b	0x71ba84 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1d58>
  71bc2c: 52800000     	mov	w0, #0x0                // =0
  71bc30: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  71bc34: d65f03c0     	ret
  71bc38: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  71bc3c: 910003fd     	mov	x29, sp
  71bc40: b9001fe0     	str	w0, [sp, #0x1c]
  71bc44: 52800020     	mov	w0, #0x1                // =1
  71bc48: b9002fe0     	str	w0, [sp, #0x2c]
  71bc4c: b9402fe0     	ldr	w0, [sp, #0x2c]
  71bc50: 11000401     	add	w1, w0, #0x1
  71bc54: 52800a20     	mov	w0, #0x51               // =81
  71bc58: 6b00003f     	cmp	w1, w0
  71bc5c: 54000d42     	b.hs	0x71be04 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x20d8>
  71bc60: d0002840     	adrp	x0, 0xc25000
  71bc64: 913a0002     	add	x2, x0, #0xe80
  71bc68: b9402fe1     	ldr	w1, [sp, #0x2c]
  71bc6c: aa0103e0     	mov	x0, x1
  71bc70: d37ef400     	lsl	x0, x0, #2
  71bc74: 8b010000     	add	x0, x0, x1
  71bc78: d37ef400     	lsl	x0, x0, #2
  71bc7c: 8b000040     	add	x0, x2, x0
  71bc80: b9400802     	ldr	w2, [x0, #0x8]
  71bc84: d0002840     	adrp	x0, 0xc25000
  71bc88: 913a0003     	add	x3, x0, #0xe80
  71bc8c: b9402fe1     	ldr	w1, [sp, #0x2c]
  71bc90: aa0103e0     	mov	x0, x1
  71bc94: d37ef400     	lsl	x0, x0, #2
  71bc98: 8b010000     	add	x0, x0, x1
  71bc9c: d37ef400     	lsl	x0, x0, #2
  71bca0: 8b000060     	add	x0, x3, x0
  71bca4: b9400803     	ldr	w3, [x0, #0x8]
  71bca8: b9402fe0     	ldr	w0, [sp, #0x2c]
  71bcac: 11000401     	add	w1, w0, #0x1
  71bcb0: d0002840     	adrp	x0, 0xc25000
  71bcb4: 913a0004     	add	x4, x0, #0xe80
  71bcb8: 2a0103e1     	mov	w1, w1
  71bcbc: aa0103e0     	mov	x0, x1
  71bcc0: d37ef400     	lsl	x0, x0, #2
  71bcc4: 8b010000     	add	x0, x0, x1
  71bcc8: d37ef400     	lsl	x0, x0, #2
  71bccc: 8b000080     	add	x0, x4, x0
  71bcd0: b9400800     	ldr	w0, [x0, #0x8]
  71bcd4: 4b000060     	sub	w0, w3, w0
  71bcd8: 531f7c01     	lsr	w1, w0, #31
  71bcdc: 0b000021     	add	w1, w1, w0
  71bce0: 13017c20     	asr	w0, w1, #1
  71bce4: 4b0003e0     	neg	w0, w0
  71bce8: 0b000040     	add	w0, w2, w0
  71bcec: b90027e0     	str	w0, [sp, #0x24]
  71bcf0: d0002840     	adrp	x0, 0xc25000
  71bcf4: 913a0002     	add	x2, x0, #0xe80
  71bcf8: b9402fe1     	ldr	w1, [sp, #0x2c]
  71bcfc: aa0103e0     	mov	x0, x1
  71bd00: d37ef400     	lsl	x0, x0, #2
  71bd04: 8b010000     	add	x0, x0, x1
  71bd08: d37ef400     	lsl	x0, x0, #2
  71bd0c: 8b000040     	add	x0, x2, x0
  71bd10: b9400802     	ldr	w2, [x0, #0x8]
  71bd14: b9402fe0     	ldr	w0, [sp, #0x2c]
  71bd18: 51000401     	sub	w1, w0, #0x1
  71bd1c: d0002840     	adrp	x0, 0xc25000
  71bd20: 913a0003     	add	x3, x0, #0xe80
  71bd24: 2a0103e1     	mov	w1, w1
  71bd28: aa0103e0     	mov	x0, x1
  71bd2c: d37ef400     	lsl	x0, x0, #2
  71bd30: 8b010000     	add	x0, x0, x1
  71bd34: d37ef400     	lsl	x0, x0, #2
  71bd38: 8b000060     	add	x0, x3, x0
  71bd3c: b9400803     	ldr	w3, [x0, #0x8]
  71bd40: d0002840     	adrp	x0, 0xc25000
  71bd44: 913a0004     	add	x4, x0, #0xe80
  71bd48: b9402fe1     	ldr	w1, [sp, #0x2c]
  71bd4c: aa0103e0     	mov	x0, x1
  71bd50: d37ef400     	lsl	x0, x0, #2
  71bd54: 8b010000     	add	x0, x0, x1
  71bd58: d37ef400     	lsl	x0, x0, #2
  71bd5c: 8b000080     	add	x0, x4, x0
  71bd60: b9400800     	ldr	w0, [x0, #0x8]
  71bd64: 4b000060     	sub	w0, w3, w0
  71bd68: 531f7c01     	lsr	w1, w0, #31
  71bd6c: 0b000020     	add	w0, w1, w0
  71bd70: 13017c01     	asr	w1, w0, #1
  71bd74: 2a0103e0     	mov	w0, w1
  71bd78: 0b000040     	add	w0, w2, w0
  71bd7c: b90023e0     	str	w0, [sp, #0x20]
  71bd80: 910083e1     	add	x1, sp, #0x20
  71bd84: 910093e0     	add	x0, sp, #0x24
  71bd88: 97f510d6     	bl	0x4600e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x2a134>
  71bd8c: b9400000     	ldr	w0, [x0]
  71bd90: b9401fe1     	ldr	w1, [sp, #0x1c]
  71bd94: 6b00003f     	cmp	w1, w0
  71bd98: 5400014b     	b.lt	0x71bdc0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2094>
  71bd9c: 910083e1     	add	x1, sp, #0x20
  71bda0: 910093e0     	add	x0, sp, #0x24
  71bda4: 97f58995     	bl	0x47e3f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x4844c>
  71bda8: b9400000     	ldr	w0, [x0]
  71bdac: b9401fe1     	ldr	w1, [sp, #0x1c]
  71bdb0: 6b00003f     	cmp	w1, w0
  71bdb4: 5400006a     	b.ge	0x71bdc0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2094>
  71bdb8: 52800020     	mov	w0, #0x1                // =1
  71bdbc: 14000002     	b	0x71bdc4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2098>
  71bdc0: 52800000     	mov	w0, #0x0                // =0
  71bdc4: 7100001f     	cmp	w0, #0x0
  71bdc8: 54000160     	b.eq	0x71bdf4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x20c8>
  71bdcc: d0002840     	adrp	x0, 0xc25000
  71bdd0: 913a0002     	add	x2, x0, #0xe80
  71bdd4: b9402fe1     	ldr	w1, [sp, #0x2c]
  71bdd8: aa0103e0     	mov	x0, x1
  71bddc: d37ef400     	lsl	x0, x0, #2
  71bde0: 8b010000     	add	x0, x0, x1
  71bde4: d37ef400     	lsl	x0, x0, #2
  71bde8: 8b000040     	add	x0, x2, x0
  71bdec: b9400000     	ldr	w0, [x0]
  71bdf0: 14000023     	b	0x71be7c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2150>
  71bdf4: b9402fe0     	ldr	w0, [sp, #0x2c]
  71bdf8: 11000400     	add	w0, w0, #0x1
  71bdfc: b9002fe0     	str	w0, [sp, #0x2c]
  71be00: 17ffff93     	b	0x71bc4c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1f20>
  71be04: b9401fe0     	ldr	w0, [sp, #0x1c]
  71be08: 7100001f     	cmp	w0, #0x0
  71be0c: 5400014d     	b.le	0x71be34 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2108>
  71be10: b9401fe0     	ldr	w0, [sp, #0x1c]
  71be14: 1e620001     	scvtf	d1, w0
  71be18: 1e671000     	fmov	d0, #24.00000000
  71be1c: 1e601820     	fdiv	d0, d1, d0
  71be20: 52800040     	mov	w0, #0x2                // =2
  71be24: 940002fb     	bl	0x71ca10 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2ce4>
  71be28: 1e624000     	fcvt	s0, d0
  71be2c: bd002be0     	str	s0, [sp, #0x28]
  71be30: 14000012     	b	0x71be78 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x214c>
  71be34: b9401fe0     	ldr	w0, [sp, #0x1c]
  71be38: 7100001f     	cmp	w0, #0x0
  71be3c: 540001aa     	b.ge	0x71be70 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2144>
  71be40: b9401fe0     	ldr	w0, [sp, #0x1c]
  71be44: 1e620001     	scvtf	d1, w0
  71be48: 1e671000     	fmov	d0, #24.00000000
  71be4c: 1e601820     	fdiv	d0, d1, d0
  71be50: 52800040     	mov	w0, #0x2                // =2
  71be54: 940002ef     	bl	0x71ca10 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2ce4>
  71be58: 1e604001     	fmov	d1, d0
  71be5c: 1e6e1000     	fmov	d0, #1.00000000
  71be60: 1e611800     	fdiv	d0, d0, d1
  71be64: 1e624000     	fcvt	s0, d0
  71be68: bd002be0     	str	s0, [sp, #0x28]
  71be6c: 14000003     	b	0x71be78 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x214c>
  71be70: 1e2e1000     	fmov	s0, #1.00000000
  71be74: bd002be0     	str	s0, [sp, #0x28]
  71be78: b9402be0     	ldr	w0, [sp, #0x28]
  71be7c: 1e270000     	fmov	s0, w0
  71be80: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  71be84: d65f03c0     	ret
  71be88: d10083ff     	sub	sp, sp, #0x20
  71be8c: bd000fe0     	str	s0, [sp, #0xc]
  71be90: 52800020     	mov	w0, #0x1                // =1
  71be94: b9001fe0     	str	w0, [sp, #0x1c]
  71be98: b9401fe0     	ldr	w0, [sp, #0x1c]
  71be9c: 11000401     	add	w1, w0, #0x1
  71bea0: 52800920     	mov	w0, #0x49               // =73
  71bea4: 6b00003f     	cmp	w1, w0
  71bea8: 54000b62     	b.hs	0x71c014 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x22e8>
  71beac: 90002860     	adrp	x0, 0xc27000
  71beb0: 911fc002     	add	x2, x0, #0x7f0
  71beb4: b9401fe1     	ldr	w1, [sp, #0x1c]
  71beb8: aa0103e0     	mov	x0, x1
  71bebc: d37ef400     	lsl	x0, x0, #2
  71bec0: 8b010000     	add	x0, x0, x1
  71bec4: d37ef400     	lsl	x0, x0, #2
  71bec8: 8b000040     	add	x0, x2, x0
  71becc: bd400001     	ldr	s1, [x0]
  71bed0: 90002860     	adrp	x0, 0xc27000
  71bed4: 911fc002     	add	x2, x0, #0x7f0
  71bed8: b9401fe1     	ldr	w1, [sp, #0x1c]
  71bedc: aa0103e0     	mov	x0, x1
  71bee0: d37ef400     	lsl	x0, x0, #2
  71bee4: 8b010000     	add	x0, x0, x1
  71bee8: d37ef400     	lsl	x0, x0, #2
  71beec: 8b000040     	add	x0, x2, x0
  71bef0: bd400002     	ldr	s2, [x0]
  71bef4: b9401fe0     	ldr	w0, [sp, #0x1c]
  71bef8: 11000401     	add	w1, w0, #0x1
  71befc: 90002860     	adrp	x0, 0xc27000
  71bf00: 911fc002     	add	x2, x0, #0x7f0
  71bf04: 2a0103e1     	mov	w1, w1
  71bf08: aa0103e0     	mov	x0, x1
  71bf0c: d37ef400     	lsl	x0, x0, #2
  71bf10: 8b010000     	add	x0, x0, x1
  71bf14: d37ef400     	lsl	x0, x0, #2
  71bf18: 8b000040     	add	x0, x2, x0
  71bf1c: bd400000     	ldr	s0, [x0]
  71bf20: 1e203842     	fsub	s2, s2, s0
  71bf24: 1e201000     	fmov	s0, #2.00000000
  71bf28: 1e201840     	fdiv	s0, s2, s0
  71bf2c: 1e203820     	fsub	s0, s1, s0
  71bf30: bd001be0     	str	s0, [sp, #0x18]
  71bf34: 90002860     	adrp	x0, 0xc27000
  71bf38: 911fc002     	add	x2, x0, #0x7f0
  71bf3c: b9401fe1     	ldr	w1, [sp, #0x1c]
  71bf40: aa0103e0     	mov	x0, x1
  71bf44: d37ef400     	lsl	x0, x0, #2
  71bf48: 8b010000     	add	x0, x0, x1
  71bf4c: d37ef400     	lsl	x0, x0, #2
  71bf50: 8b000040     	add	x0, x2, x0
  71bf54: bd400001     	ldr	s1, [x0]
  71bf58: b9401fe0     	ldr	w0, [sp, #0x1c]
  71bf5c: 51000401     	sub	w1, w0, #0x1
  71bf60: 90002860     	adrp	x0, 0xc27000
  71bf64: 911fc002     	add	x2, x0, #0x7f0
  71bf68: 2a0103e1     	mov	w1, w1
  71bf6c: aa0103e0     	mov	x0, x1
  71bf70: d37ef400     	lsl	x0, x0, #2
  71bf74: 8b010000     	add	x0, x0, x1
  71bf78: d37ef400     	lsl	x0, x0, #2
  71bf7c: 8b000040     	add	x0, x2, x0
  71bf80: bd400002     	ldr	s2, [x0]
  71bf84: 90002860     	adrp	x0, 0xc27000
  71bf88: 911fc002     	add	x2, x0, #0x7f0
  71bf8c: b9401fe1     	ldr	w1, [sp, #0x1c]
  71bf90: aa0103e0     	mov	x0, x1
  71bf94: d37ef400     	lsl	x0, x0, #2
  71bf98: 8b010000     	add	x0, x0, x1
  71bf9c: d37ef400     	lsl	x0, x0, #2
  71bfa0: 8b000040     	add	x0, x2, x0
  71bfa4: bd400000     	ldr	s0, [x0]
  71bfa8: 1e203842     	fsub	s2, s2, s0
  71bfac: 1e201000     	fmov	s0, #2.00000000
  71bfb0: 1e201840     	fdiv	s0, s2, s0
  71bfb4: 1e202820     	fadd	s0, s1, s0
  71bfb8: bd0017e0     	str	s0, [sp, #0x14]
  71bfbc: bd4017e0     	ldr	s0, [sp, #0x14]
  71bfc0: bd400fe1     	ldr	s1, [sp, #0xc]
  71bfc4: 1e202030     	fcmpe	s1, s0
  71bfc8: 540001eb     	b.lt	0x71c004 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x22d8>
  71bfcc: bd401be0     	ldr	s0, [sp, #0x18]
  71bfd0: bd400fe1     	ldr	s1, [sp, #0xc]
  71bfd4: 1e202030     	fcmpe	s1, s0
  71bfd8: 54000168     	b.hi	0x71c004 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x22d8>
  71bfdc: 90002860     	adrp	x0, 0xc27000
  71bfe0: 911fc002     	add	x2, x0, #0x7f0
  71bfe4: b9401fe1     	ldr	w1, [sp, #0x1c]
  71bfe8: aa0103e0     	mov	x0, x1
  71bfec: d37ef400     	lsl	x0, x0, #2
  71bff0: 8b010000     	add	x0, x0, x1
  71bff4: d37ef400     	lsl	x0, x0, #2
  71bff8: 8b000040     	add	x0, x2, x0
  71bffc: b9400800     	ldr	w0, [x0, #0x8]
  71c000: 14000006     	b	0x71c018 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x22ec>
  71c004: b9401fe0     	ldr	w0, [sp, #0x1c]
  71c008: 11000400     	add	w0, w0, #0x1
  71c00c: b9001fe0     	str	w0, [sp, #0x1c]
  71c010: 17ffffa2     	b	0x71be98 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x216c>
  71c014: 52800780     	mov	w0, #0x3c               // =60
  71c018: 910083ff     	add	sp, sp, #0x20
  71c01c: d65f03c0     	ret
  71c020: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  71c024: 910003fd     	mov	x29, sp
  71c028: fd000fe0     	str	d0, [sp, #0x18]
  71c02c: fd400fe0     	ldr	d0, [sp, #0x18]
  71c030: 1e624000     	fcvt	s0, d0
  71c034: 97fffdf4     	bl	0x71b804 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1ad8>
  71c038: b90037e0     	str	w0, [sp, #0x34]
  71c03c: b94037e0     	ldr	w0, [sp, #0x34]
  71c040: 531f7c01     	lsr	w1, w0, #31
  71c044: 0b000020     	add	w0, w1, w0
  71c048: 13017c00     	asr	w0, w0, #1
  71c04c: b90033e0     	str	w0, [sp, #0x30]
