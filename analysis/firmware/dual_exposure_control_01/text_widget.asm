
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000435fac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_>:
  4ad230: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  4ad234: 910003fd     	mov	x29, sp
  4ad238: f9001fe0     	str	x0, [sp, #0x38]
  4ad23c: b90037e1     	str	w1, [sp, #0x34]
  4ad240: b90033e2     	str	w2, [sp, #0x30]
  4ad244: f90017e3     	str	x3, [sp, #0x28]
  4ad248: b90027e4     	str	w4, [sp, #0x24]
  4ad24c: f9000fe5     	str	x5, [sp, #0x18]
  4ad250: 39008fe6     	strb	w6, [sp, #0x23]
  4ad254: b90017e7     	str	w7, [sp, #0x14]
  4ad258: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad25c: 52800003     	mov	w3, #0x0                // =0
  4ad260: b94033e2     	ldr	w2, [sp, #0x30]
  4ad264: b94037e1     	ldr	w1, [sp, #0x34]
  4ad268: 97fff936     	bl	0x4ab740 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75794>
  4ad26c: f00036a0     	adrp	x0, 0xb84000
  4ad270: 911bc001     	add	x1, x0, #0x6f0
  4ad274: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad278: f9000001     	str	x1, [x0]
  4ad27c: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad280: f9400fe1     	ldr	x1, [sp, #0x18]
  4ad284: f9004001     	str	x1, [x0, #0x80]
  4ad288: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad28c: 12800001     	mov	w1, #-0x1               // =-1
  4ad290: b9008801     	str	w1, [x0, #0x88]
  4ad294: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad298: 91023002     	add	x2, x0, #0x8c
  4ad29c: b001cfa0     	adrp	x0, 0x3ea2000 <_ZNSt5ctypeIcE2idE+0x2f3eed8>
  4ad2a0: 9122e001     	add	x1, x0, #0x8b8
  4ad2a4: aa0203e0     	mov	x0, x2
  4ad2a8: 97fea9a6     	bl	0x457940 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21994>
  4ad2ac: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad2b0: 91024002     	add	x2, x0, #0x90
  4ad2b4: b001cfa0     	adrp	x0, 0x3ea2000 <_ZNSt5ctypeIcE2idE+0x2f3eed8>
  4ad2b8: 9124a001     	add	x1, x0, #0x928
  4ad2bc: aa0203e0     	mov	x0, x2
  4ad2c0: 97fea9a0     	bl	0x457940 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21994>
  4ad2c4: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad2c8: b94017e1     	ldr	w1, [sp, #0x14]
  4ad2cc: b9009401     	str	w1, [x0, #0x94]
  4ad2d0: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad2d4: b94043e1     	ldr	w1, [sp, #0x40]
  4ad2d8: b9009801     	str	w1, [x0, #0x98]
  4ad2dc: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad2e0: b94027e1     	ldr	w1, [sp, #0x24]
  4ad2e4: b9009c01     	str	w1, [x0, #0x9c]
  4ad2e8: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad2ec: f94017e1     	ldr	x1, [sp, #0x28]
  4ad2f0: f9005001     	str	x1, [x0, #0xa0]
  4ad2f4: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad2f8: 39408fe1     	ldrb	w1, [sp, #0x23]
  4ad2fc: 97fea9d7     	bl	0x457a58 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21aac>
  4ad300: d503201f     	nop
  4ad304: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  4ad308: d65f03c0     	ret
  4ad30c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  4ad310: 910003fd     	mov	x29, sp
  4ad314: f9001fe0     	str	x0, [sp, #0x38]
  4ad318: b90037e1     	str	w1, [sp, #0x34]
  4ad31c: b90033e2     	str	w2, [sp, #0x30]
  4ad320: b9002fe3     	str	w3, [sp, #0x2c]
  4ad324: b9002be4     	str	w4, [sp, #0x28]
  4ad328: f90013e5     	str	x5, [sp, #0x20]
  4ad32c: 39007fe6     	strb	w6, [sp, #0x1f]
  4ad330: b9001be7     	str	w7, [sp, #0x18]
  4ad334: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad338: 52800003     	mov	w3, #0x0                // =0
  4ad33c: b94033e2     	ldr	w2, [sp, #0x30]
  4ad340: b94037e1     	ldr	w1, [sp, #0x34]
  4ad344: 97fff8ff     	bl	0x4ab740 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75794>
  4ad348: f00036a0     	adrp	x0, 0xb84000
  4ad34c: 911bc001     	add	x1, x0, #0x6f0
  4ad350: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad354: f9000001     	str	x1, [x0]
  4ad358: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad35c: f900401f     	str	xzr, [x0, #0x80]
  4ad360: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad364: b9402be1     	ldr	w1, [sp, #0x28]
  4ad368: b9008801     	str	w1, [x0, #0x88]
  4ad36c: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad370: 91023002     	add	x2, x0, #0x8c
  4ad374: b001cfa0     	adrp	x0, 0x3ea2000 <_ZNSt5ctypeIcE2idE+0x2f3eed8>
  4ad378: 9122e001     	add	x1, x0, #0x8b8
  4ad37c: aa0203e0     	mov	x0, x2
  4ad380: 97fea970     	bl	0x457940 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21994>
  4ad384: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad388: 91024002     	add	x2, x0, #0x90
  4ad38c: b001cfa0     	adrp	x0, 0x3ea2000 <_ZNSt5ctypeIcE2idE+0x2f3eed8>
  4ad390: 9124a001     	add	x1, x0, #0x928
  4ad394: aa0203e0     	mov	x0, x2
  4ad398: 97fea96a     	bl	0x457940 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21994>
  4ad39c: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad3a0: b9401be1     	ldr	w1, [sp, #0x18]
  4ad3a4: b9009401     	str	w1, [x0, #0x94]
  4ad3a8: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad3ac: b94043e1     	ldr	w1, [sp, #0x40]
  4ad3b0: b9009801     	str	w1, [x0, #0x98]
  4ad3b4: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad3b8: b9402fe1     	ldr	w1, [sp, #0x2c]
  4ad3bc: b9009c01     	str	w1, [x0, #0x9c]
  4ad3c0: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad3c4: f94013e1     	ldr	x1, [sp, #0x20]
  4ad3c8: f9005001     	str	x1, [x0, #0xa0]
  4ad3cc: f9401fe0     	ldr	x0, [sp, #0x38]
  4ad3d0: 39407fe1     	ldrb	w1, [sp, #0x1f]
  4ad3d4: 97fea9a1     	bl	0x457a58 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21aac>
  4ad3d8: d503201f     	nop
  4ad3dc: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  4ad3e0: d65f03c0     	ret
  4ad3e4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4ad3e8: 910003fd     	mov	x29, sp
  4ad3ec: f9000fe0     	str	x0, [sp, #0x18]
  4ad3f0: f00036a0     	adrp	x0, 0xb84000
  4ad3f4: 911bc001     	add	x1, x0, #0x6f0
  4ad3f8: f9400fe0     	ldr	x0, [sp, #0x18]
  4ad3fc: f9000001     	str	x1, [x0]
  4ad400: f9400fe0     	ldr	x0, [sp, #0x18]
  4ad404: 97fff90c     	bl	0x4ab834 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75888>
  4ad408: d503201f     	nop
  4ad40c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4ad410: d65f03c0     	ret
  4ad414: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4ad418: 910003fd     	mov	x29, sp
  4ad41c: f9000fe0     	str	x0, [sp, #0x18]
  4ad420: f9400fe0     	ldr	x0, [sp, #0x18]
  4ad424: 97fffff0     	bl	0x4ad3e4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x77438>
  4ad428: d2801501     	mov	x1, #0xa8               // =168
  4ad42c: f9400fe0     	ldr	x0, [sp, #0x18]
  4ad430: 97fd726c     	bl	0x409de0 <_ZdlPvm@plt>
  4ad434: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4ad438: d65f03c0     	ret
  4ad43c: d10043ff     	sub	sp, sp, #0x10
  4ad440: f90007e0     	str	x0, [sp, #0x8]
  4ad444: d503201f     	nop
  4ad448: 910043ff     	add	sp, sp, #0x10
  4ad44c: d65f03c0     	ret
  4ad450: d10883ff     	sub	sp, sp, #0x220
  4ad454: a9017bfd     	stp	x29, x30, [sp, #0x10]
  4ad458: 910043fd     	add	x29, sp, #0x10
  4ad45c: a90253f3     	stp	x19, x20, [sp, #0x20]
  4ad460: aa0803f4     	mov	x20, x8
  4ad464: f90027e0     	str	x0, [sp, #0x48]
  4ad468: f90023e1     	str	x1, [sp, #0x40]
  4ad46c: f9001fe2     	str	x2, [sp, #0x38]
  4ad470: f9001be3     	str	x3, [sp, #0x30]
  4ad474: f9010fff     	str	xzr, [sp, #0x218]
  4ad478: f94027e0     	ldr	x0, [sp, #0x48]
  4ad47c: b9408800     	ldr	w0, [x0, #0x88]
  4ad480: 3100041f     	cmn	w0, #0x1
  4ad484: 540001e0     	b.eq	0x4ad4c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x77514>
  4ad488: f94027e0     	ldr	x0, [sp, #0x48]
  4ad48c: f9405003     	ldr	x3, [x0, #0xa0]
  4ad490: f94027e0     	ldr	x0, [sp, #0x48]
  4ad494: f9405000     	ldr	x0, [x0, #0xa0]
  4ad498: f9400000     	ldr	x0, [x0]
  4ad49c: 91004000     	add	x0, x0, #0x10
  4ad4a0: f9400002     	ldr	x2, [x0]
  4ad4a4: f94027e0     	ldr	x0, [sp, #0x48]
  4ad4a8: b9408800     	ldr	w0, [x0, #0x88]
  4ad4ac: 2a0003e1     	mov	w1, w0
  4ad4b0: aa0303e0     	mov	x0, x3
  4ad4b4: d63f0040     	blr	x2
  4ad4b8: f9010fe0     	str	x0, [sp, #0x218]
  4ad4bc: 14000004     	b	0x4ad4cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x77520>
  4ad4c0: f94027e0     	ldr	x0, [sp, #0x48]
  4ad4c4: f9404000     	ldr	x0, [x0, #0x80]
  4ad4c8: f9010fe0     	str	x0, [sp, #0x218]
  4ad4cc: f94027e0     	ldr	x0, [sp, #0x48]
  4ad4d0: f9405002     	ldr	x2, [x0, #0xa0]
  4ad4d4: f94027e0     	ldr	x0, [sp, #0x48]
  4ad4d8: b9409c00     	ldr	w0, [x0, #0x9c]
  4ad4dc: 2a0003e1     	mov	w1, w0
  4ad4e0: aa0203e0     	mov	x0, x2
  4ad4e4: 94083134     	bl	0x6b99b4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x195f4>
  4ad4e8: f90103e0     	str	x0, [sp, #0x200]
  4ad4ec: f9410fe0     	ldr	x0, [sp, #0x218]
  4ad4f0: f100001f     	cmp	x0, #0x0
  4ad4f4: 54001f60     	b.eq	0x4ad8e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x77934>
  4ad4f8: f94103e0     	ldr	x0, [sp, #0x200]
  4ad4fc: f100001f     	cmp	x0, #0x0
  4ad500: 54001f00     	b.eq	0x4ad8e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x77934>
  4ad504: 52800200     	mov	w0, #0x10               // =16
  4ad508: b901ffe0     	str	w0, [sp, #0x1fc]
  4ad50c: 52800020     	mov	w0, #0x1                // =1
  4ad510: b90217e0     	str	w0, [sp, #0x214]
  4ad514: b90053ff     	str	wzr, [sp, #0x50]
  4ad518: b90213ff     	str	wzr, [sp, #0x210]
  4ad51c: b98213e0     	ldrsw	x0, [sp, #0x210]
  4ad520: f9410fe1     	ldr	x1, [sp, #0x218]
  4ad524: 8b000020     	add	x0, x1, x0
  4ad528: 39400000     	ldrb	w0, [x0]
  4ad52c: 7100001f     	cmp	w0, #0x0
  4ad530: 54000400     	b.eq	0x4ad5b0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x77604>
  4ad534: b98213e0     	ldrsw	x0, [sp, #0x210]
  4ad538: f9410fe1     	ldr	x1, [sp, #0x218]
  4ad53c: 8b000020     	add	x0, x1, x0
  4ad540: 39400000     	ldrb	w0, [x0]
  4ad544: 7100281f     	cmp	w0, #0xa
  4ad548: 540002c1     	b.ne	0x4ad5a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x775f4>
  4ad54c: b94213e0     	ldr	w0, [sp, #0x210]
  4ad550: 11000402     	add	w2, w0, #0x1
  4ad554: b98217e0     	ldrsw	x0, [sp, #0x214]
  4ad558: d37ef400     	lsl	x0, x0, #2
  4ad55c: 910143e1     	add	x1, sp, #0x50
  4ad560: b8206822     	str	w2, [x1, x0]
  4ad564: b94217e0     	ldr	w0, [sp, #0x214]
  4ad568: 11000400     	add	w0, w0, #0x1
  4ad56c: b90217e0     	str	w0, [sp, #0x214]
  4ad570: b94217e0     	ldr	w0, [sp, #0x214]
  4ad574: 71003c1f     	cmp	w0, #0xf
  4ad578: 5400014d     	b.le	0x4ad5a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x775f4>
  4ad57c: 52800204     	mov	w4, #0x10               // =16
  4ad580: f00036a0     	adrp	x0, 0xb84000
  4ad584: 911a2003     	add	x3, x0, #0x688
  4ad588: 52800b82     	mov	w2, #0x5c               // =92
  4ad58c: f00036a0     	adrp	x0, 0xb84000
  4ad590: 911ae001     	add	x1, x0, #0x6b8
  4ad594: 52800080     	mov	w0, #0x4                // =4
  4ad598: 940a63ed     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  4ad59c: 14000005     	b	0x4ad5b0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x77604>
  4ad5a0: b94213e0     	ldr	w0, [sp, #0x210]
  4ad5a4: 11000400     	add	w0, w0, #0x1
  4ad5a8: b90213e0     	str	w0, [sp, #0x210]
  4ad5ac: 17ffffdc     	b	0x4ad51c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x77570>
  4ad5b0: b94213e0     	ldr	w0, [sp, #0x210]
  4ad5b4: 11000402     	add	w2, w0, #0x1
  4ad5b8: b98217e0     	ldrsw	x0, [sp, #0x214]
  4ad5bc: d37ef400     	lsl	x0, x0, #2
  4ad5c0: 910143e1     	add	x1, sp, #0x50
  4ad5c4: b8206822     	str	w2, [x1, x0]
  4ad5c8: b94217e0     	ldr	w0, [sp, #0x214]
  4ad5cc: 7100041f     	cmp	w0, #0x1
  4ad5d0: 54000421     	b.ne	0x4ad654 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x776a8>
  4ad5d4: 9106e3e0     	add	x0, sp, #0x1b8
  4ad5d8: f9401be1     	ldr	x1, [sp, #0x30]
  4ad5dc: 97fea9de     	bl	0x457d54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21da8>
  4ad5e0: f94027e0     	ldr	x0, [sp, #0x48]
  4ad5e4: 91023001     	add	x1, x0, #0x8c
  4ad5e8: 910743e0     	add	x0, sp, #0x1d0
  4ad5ec: 97fea8d5     	bl	0x457940 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21994>
  4ad5f0: f94027e0     	ldr	x0, [sp, #0x48]
  4ad5f4: 91024001     	add	x1, x0, #0x90
  4ad5f8: 910763e0     	add	x0, sp, #0x1d8
  4ad5fc: 97fea8d1     	bl	0x457940 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21994>
  4ad600: f94027e0     	ldr	x0, [sp, #0x48]
  4ad604: b9409404     	ldr	w4, [x0, #0x94]
  4ad608: f94027e0     	ldr	x0, [sp, #0x48]
  4ad60c: b9409805     	ldr	w5, [x0, #0x98]
  4ad610: 910763e3     	add	x3, sp, #0x1d8
  4ad614: 910743e2     	add	x2, sp, #0x1d0
  4ad618: 9106e3e1     	add	x1, sp, #0x1b8
  4ad61c: f9410fe0     	ldr	x0, [sp, #0x218]
  4ad620: f90003e0     	str	x0, [sp]
  4ad624: 2a0503e7     	mov	w7, w5
  4ad628: 2a0403e6     	mov	w6, w4
  4ad62c: aa0303e5     	mov	x5, x3
  4ad630: aa0203e4     	mov	x4, x2
  4ad634: aa0103e3     	mov	x3, x1
  4ad638: f94103e2     	ldr	x2, [sp, #0x200]
  4ad63c: f9401fe1     	ldr	x1, [sp, #0x38]
  4ad640: f94023e0     	ldr	x0, [sp, #0x40]
  4ad644: 97ff365f     	bl	0x47afc0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x45014>
  4ad648: 9106e3e0     	add	x0, sp, #0x1b8
  4ad64c: 97fea996     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4ad650: 140000a4     	b	0x4ad8e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x77934>
  4ad654: 910683e0     	add	x0, sp, #0x1a0
  4ad658: f9401fe1     	ldr	x1, [sp, #0x38]
  4ad65c: 97fea9be     	bl	0x457d54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21da8>
  4ad660: f9410fe1     	ldr	x1, [sp, #0x218]
  4ad664: f94103e0     	ldr	x0, [sp, #0x200]
