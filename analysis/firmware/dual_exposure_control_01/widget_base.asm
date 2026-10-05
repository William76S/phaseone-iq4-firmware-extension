
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000435fac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_>:
  4ab740: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  4ab744: 910003fd     	mov	x29, sp
  4ab748: f90017e0     	str	x0, [sp, #0x28]
  4ab74c: b90027e1     	str	w1, [sp, #0x24]
  4ab750: b90023e2     	str	w2, [sp, #0x20]
  4ab754: 39007fe3     	strb	w3, [sp, #0x1f]
  4ab758: f94017e0     	ldr	x0, [sp, #0x28]
  4ab75c: 94098326     	bl	0x70c3f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1e374>
  4ab760: b00036c0     	adrp	x0, 0xb84000
  4ab764: 91128001     	add	x1, x0, #0x4a0
  4ab768: f94017e0     	ldr	x0, [sp, #0x28]
  4ab76c: f9000001     	str	x1, [x0]
  4ab770: f94017e0     	ldr	x0, [sp, #0x28]
  4ab774: 9100a000     	add	x0, x0, #0x28
  4ab778: b94027e1     	ldr	w1, [sp, #0x24]
  4ab77c: b94023e2     	ldr	w2, [sp, #0x20]
  4ab780: 2a0203e4     	mov	w4, w2
  4ab784: 2a0103e3     	mov	w3, w1
  4ab788: 52800002     	mov	w2, #0x0                // =0
  4ab78c: 52800001     	mov	w1, #0x0                // =0
  4ab790: 97feb158     	bl	0x457cf0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21d44>
  4ab794: f94017e0     	ldr	x0, [sp, #0x28]
  4ab798: 39407fe1     	ldrb	w1, [sp, #0x1f]
  4ab79c: 39010001     	strb	w1, [x0, #0x40]
  4ab7a0: f94017e0     	ldr	x0, [sp, #0x28]
  4ab7a4: 3901041f     	strb	wzr, [x0, #0x41]
  4ab7a8: f94017e0     	ldr	x0, [sp, #0x28]
  4ab7ac: 3901081f     	strb	wzr, [x0, #0x42]
  4ab7b0: f94017e0     	ldr	x0, [sp, #0x28]
  4ab7b4: b900441f     	str	wzr, [x0, #0x44]
  4ab7b8: f94017e0     	ldr	x0, [sp, #0x28]
  4ab7bc: b900481f     	str	wzr, [x0, #0x48]
  4ab7c0: f94017e0     	ldr	x0, [sp, #0x28]
  4ab7c4: f900281f     	str	xzr, [x0, #0x50]
  4ab7c8: f94017e0     	ldr	x0, [sp, #0x28]
  4ab7cc: b900581f     	str	wzr, [x0, #0x58]
  4ab7d0: f94017e0     	ldr	x0, [sp, #0x28]
  4ab7d4: f900301f     	str	xzr, [x0, #0x60]
  4ab7d8: f94017e0     	ldr	x0, [sp, #0x28]
  4ab7dc: b900681f     	str	wzr, [x0, #0x68]
  4ab7e0: f94017e0     	ldr	x0, [sp, #0x28]
  4ab7e4: 3901b01f     	strb	wzr, [x0, #0x6c]
  4ab7e8: f94017e0     	ldr	x0, [sp, #0x28]
  4ab7ec: 52800021     	mov	w1, #0x1                // =1
  4ab7f0: 3901b401     	strb	w1, [x0, #0x6d]
  4ab7f4: f94017e0     	ldr	x0, [sp, #0x28]
  4ab7f8: 3901b81f     	strb	wzr, [x0, #0x6e]
  4ab7fc: f94017e0     	ldr	x0, [sp, #0x28]
  4ab800: 52800021     	mov	w1, #0x1                // =1
  4ab804: 3901bc01     	strb	w1, [x0, #0x6f]
  4ab808: f94017e0     	ldr	x0, [sp, #0x28]
  4ab80c: 52800021     	mov	w1, #0x1                // =1
  4ab810: 3901c001     	strb	w1, [x0, #0x70]
  4ab814: f94017e0     	ldr	x0, [sp, #0x28]
  4ab818: 3901c41f     	strb	wzr, [x0, #0x71]
  4ab81c: f94017e0     	ldr	x0, [sp, #0x28]
  4ab820: 9101c800     	add	x0, x0, #0x72
  4ab824: 940005d9     	bl	0x4acf88 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76fdc>
  4ab828: d503201f     	nop
  4ab82c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  4ab830: d65f03c0     	ret
  4ab834: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4ab838: 910003fd     	mov	x29, sp
  4ab83c: f9000fe0     	str	x0, [sp, #0x18]
  4ab840: b00036c0     	adrp	x0, 0xb84000
  4ab844: 91128001     	add	x1, x0, #0x4a0
  4ab848: f9400fe0     	ldr	x0, [sp, #0x18]
  4ab84c: f9000001     	str	x1, [x0]
  4ab850: f9400fe0     	ldr	x0, [sp, #0x18]
  4ab854: 9100a000     	add	x0, x0, #0x28
  4ab858: 97feb113     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4ab85c: f9400fe0     	ldr	x0, [sp, #0x18]
  4ab860: 940982f6     	bl	0x70c438 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1e3b8>
  4ab864: d503201f     	nop
  4ab868: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4ab86c: d65f03c0     	ret
  4ab870: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4ab874: 910003fd     	mov	x29, sp
  4ab878: f9000fe0     	str	x0, [sp, #0x18]
  4ab87c: f9400fe0     	ldr	x0, [sp, #0x18]
  4ab880: 97ffffed     	bl	0x4ab834 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75888>
  4ab884: d2801001     	mov	x1, #0x80               // =128
  4ab888: f9400fe0     	ldr	x0, [sp, #0x18]
  4ab88c: 97fd7955     	bl	0x409de0 <_ZdlPvm@plt>
  4ab890: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4ab894: d65f03c0     	ret
  4ab898: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  4ab89c: 910003fd     	mov	x29, sp
  4ab8a0: f90017e0     	str	x0, [sp, #0x28]
  4ab8a4: f90013e1     	str	x1, [sp, #0x20]
  4ab8a8: b9001fe2     	str	w2, [sp, #0x1c]
  4ab8ac: b9001be3     	str	w3, [sp, #0x18]
  4ab8b0: b90017e4     	str	w4, [sp, #0x14]
  4ab8b4: b90013e5     	str	w5, [sp, #0x10]
  4ab8b8: b94013e4     	ldr	w4, [sp, #0x10]
  4ab8bc: b94017e3     	ldr	w3, [sp, #0x14]
  4ab8c0: b9401be2     	ldr	w2, [sp, #0x18]
  4ab8c4: b9401fe1     	ldr	w1, [sp, #0x1c]
  4ab8c8: f94013e0     	ldr	x0, [sp, #0x20]
  4ab8cc: 9400002e     	bl	0x4ab984 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x759d8>
  4ab8d0: f94017e3     	ldr	x3, [sp, #0x28]
  4ab8d4: f94017e0     	ldr	x0, [sp, #0x28]
  4ab8d8: f9400000     	ldr	x0, [x0]
  4ab8dc: 91014000     	add	x0, x0, #0x50
  4ab8e0: f9400002     	ldr	x2, [x0]
  4ab8e4: f94013e1     	ldr	x1, [sp, #0x20]
  4ab8e8: aa0303e0     	mov	x0, x3
  4ab8ec: d63f0040     	blr	x2
  4ab8f0: d503201f     	nop
  4ab8f4: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  4ab8f8: d65f03c0     	ret
  4ab8fc: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4ab900: 910003fd     	mov	x29, sp
  4ab904: f9000fe0     	str	x0, [sp, #0x18]
  4ab908: b90017e1     	str	w1, [sp, #0x14]
  4ab90c: f9400fe0     	ldr	x0, [sp, #0x18]
  4ab910: b94017e1     	ldr	w1, [sp, #0x14]
  4ab914: b9004401     	str	w1, [x0, #0x44]
  4ab918: f9400fe0     	ldr	x0, [sp, #0x18]
  4ab91c: f9400000     	ldr	x0, [x0]
  4ab920: 9102a000     	add	x0, x0, #0xa8
  4ab924: f9400002     	ldr	x2, [x0]
  4ab928: 52800001     	mov	w1, #0x0                // =0
  4ab92c: f9400fe0     	ldr	x0, [sp, #0x18]
  4ab930: d63f0040     	blr	x2
  4ab934: d503201f     	nop
  4ab938: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4ab93c: d65f03c0     	ret
  4ab940: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4ab944: 910003fd     	mov	x29, sp
  4ab948: f9000fe0     	str	x0, [sp, #0x18]
  4ab94c: b90017e1     	str	w1, [sp, #0x14]
  4ab950: b94017e1     	ldr	w1, [sp, #0x14]
  4ab954: f9400fe0     	ldr	x0, [sp, #0x18]
  4ab958: b9004801     	str	w1, [x0, #0x48]
  4ab95c: f9400fe0     	ldr	x0, [sp, #0x18]
  4ab960: f9400000     	ldr	x0, [x0]
  4ab964: 9102a000     	add	x0, x0, #0xa8
  4ab968: f9400002     	ldr	x2, [x0]
  4ab96c: 52800001     	mov	w1, #0x0                // =0
  4ab970: f9400fe0     	ldr	x0, [sp, #0x18]
  4ab974: d63f0040     	blr	x2
  4ab978: d503201f     	nop
  4ab97c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4ab980: d65f03c0     	ret
  4ab984: d10083ff     	sub	sp, sp, #0x20
  4ab988: f9000fe0     	str	x0, [sp, #0x18]
  4ab98c: b90017e1     	str	w1, [sp, #0x14]
  4ab990: b90013e2     	str	w2, [sp, #0x10]
  4ab994: b9000fe3     	str	w3, [sp, #0xc]
  4ab998: b9000be4     	str	w4, [sp, #0x8]
  4ab99c: f9400fe0     	ldr	x0, [sp, #0x18]
  4ab9a0: b94017e1     	ldr	w1, [sp, #0x14]
  4ab9a4: b9003001     	str	w1, [x0, #0x30]
  4ab9a8: f9400fe0     	ldr	x0, [sp, #0x18]
  4ab9ac: b94013e1     	ldr	w1, [sp, #0x10]
  4ab9b0: b9003401     	str	w1, [x0, #0x34]
  4ab9b4: f9400fe0     	ldr	x0, [sp, #0x18]
  4ab9b8: b9400fe1     	ldr	w1, [sp, #0xc]
  4ab9bc: b9004401     	str	w1, [x0, #0x44]
  4ab9c0: b9400be1     	ldr	w1, [sp, #0x8]
  4ab9c4: f9400fe0     	ldr	x0, [sp, #0x18]
  4ab9c8: b9004801     	str	w1, [x0, #0x48]
  4ab9cc: d503201f     	nop
  4ab9d0: 910083ff     	add	sp, sp, #0x20
  4ab9d4: d65f03c0     	ret
  4ab9d8: a9b87bfd     	stp	x29, x30, [sp, #-0x80]!
  4ab9dc: 910003fd     	mov	x29, sp
  4ab9e0: a90153f3     	stp	x19, x20, [sp, #0x10]
  4ab9e4: aa0803f4     	mov	x20, x8
  4ab9e8: f90017e0     	str	x0, [sp, #0x28]
  4ab9ec: f94017e0     	ldr	x0, [sp, #0x28]
  4ab9f0: 94000583     	bl	0x4acffc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x77050>
  4ab9f4: f9003fe0     	str	x0, [sp, #0x78]
  4ab9f8: f9403fe0     	ldr	x0, [sp, #0x78]
  4ab9fc: f100001f     	cmp	x0, #0x0
  4aba00: 540000e1     	b.ne	0x4aba1c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75a70>
  4aba04: f94017e0     	ldr	x0, [sp, #0x28]
  4aba08: 9100a000     	add	x0, x0, #0x28
  4aba0c: aa0003e1     	mov	x1, x0
  4aba10: aa1403e0     	mov	x0, x20
  4aba14: 97feb0d0     	bl	0x457d54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21da8>
  4aba18: 14000028     	b	0x4abab8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75b0c>
  4aba1c: f9403fe0     	ldr	x0, [sp, #0x78]
  4aba20: f9400000     	ldr	x0, [x0]
  4aba24: 9102e000     	add	x0, x0, #0xb8
  4aba28: f9400001     	ldr	x1, [x0]
  4aba2c: 910123e0     	add	x0, sp, #0x48
  4aba30: aa0003e8     	mov	x8, x0
  4aba34: f9403fe0     	ldr	x0, [sp, #0x78]
  4aba38: d63f0020     	blr	x1
  4aba3c: f94017e0     	ldr	x0, [sp, #0x28]
  4aba40: f9400000     	ldr	x0, [x0]
  4aba44: 9104c000     	add	x0, x0, #0x130
  4aba48: f9400013     	ldr	x19, [x0]
  4aba4c: 910123e1     	add	x1, sp, #0x48
  4aba50: 910183e0     	add	x0, sp, #0x60
  4aba54: 97feb0c0     	bl	0x457d54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21da8>
  4aba58: 910183e0     	add	x0, sp, #0x60
  4aba5c: 9100c3e1     	add	x1, sp, #0x30
  4aba60: aa0103e8     	mov	x8, x1
  4aba64: aa0003e1     	mov	x1, x0
  4aba68: f94017e0     	ldr	x0, [sp, #0x28]
  4aba6c: d63f0260     	blr	x19
  4aba70: 910183e0     	add	x0, sp, #0x60
  4aba74: 97feb08c     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4aba78: 9100c3e0     	add	x0, sp, #0x30
  4aba7c: aa0003e1     	mov	x1, x0
  4aba80: aa1403e0     	mov	x0, x20
  4aba84: 97feb0b4     	bl	0x457d54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21da8>
  4aba88: 9100c3e0     	add	x0, sp, #0x30
  4aba8c: 97feb086     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4aba90: 910123e0     	add	x0, sp, #0x48
  4aba94: 97feb084     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4aba98: 14000008     	b	0x4abab8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75b0c>
  4aba9c: aa0003f3     	mov	x19, x0
  4abaa0: 910183e0     	add	x0, sp, #0x60
  4abaa4: 97feb080     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4abaa8: 910123e0     	add	x0, sp, #0x48
  4abaac: 97feb07e     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4abab0: aa1303e0     	mov	x0, x19
  4abab4: 97fd7b27     	bl	0x40a750 <_Unwind_Resume@plt>
  4abab8: aa1403e0     	mov	x0, x20
  4ababc: a94153f3     	ldp	x19, x20, [sp, #0x10]
  4abac0: a8c87bfd     	ldp	x29, x30, [sp], #0x80
  4abac4: d65f03c0     	ret
  4abac8: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
  4abacc: 910003fd     	mov	x29, sp
  4abad0: f9000bf3     	str	x19, [sp, #0x10]
  4abad4: aa0803f3     	mov	x19, x8
  4abad8: f90017e0     	str	x0, [sp, #0x28]
  4abadc: f90013e1     	str	x1, [sp, #0x20]
  4abae0: f94017e0     	ldr	x0, [sp, #0x28]
  4abae4: 9100a000     	add	x0, x0, #0x28
  4abae8: aa0003e1     	mov	x1, x0
  4abaec: aa1303e0     	mov	x0, x19
  4abaf0: 97feb099     	bl	0x457d54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21da8>
  4abaf4: f94013e0     	ldr	x0, [sp, #0x20]
  4abaf8: 97fee277     	bl	0x4644d4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x2e528>
  4abafc: f90027e0     	str	x0, [sp, #0x48]
  4abb00: 910123e0     	add	x0, sp, #0x48
  4abb04: 9100c3e1     	add	x1, sp, #0x30
  4abb08: aa0103e8     	mov	x8, x1
  4abb0c: aa0003e1     	mov	x1, x0
  4abb10: aa1303e0     	mov	x0, x19
  4abb14: 94000546     	bl	0x4ad02c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x77080>
  4abb18: 9100c3e0     	add	x0, sp, #0x30
  4abb1c: 97feb062     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4abb20: f94017e0     	ldr	x0, [sp, #0x28]
  4abb24: b9404400     	ldr	w0, [x0, #0x44]
  4abb28: 7100001f     	cmp	w0, #0x0
  4abb2c: 54000ae0     	b.eq	0x4abc88 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75cdc>
  4abb30: f94017e0     	ldr	x0, [sp, #0x28]
  4abb34: b9404400     	ldr	w0, [x0, #0x44]
  4abb38: 12000000     	and	w0, w0, #0x1
  4abb3c: 7100001f     	cmp	w0, #0x0
  4abb40: 540002e0     	b.eq	0x4abb9c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75bf0>
  4abb44: f94013e0     	ldr	x0, [sp, #0x20]
  4abb48: b9400801     	ldr	w1, [x0, #0x8]
  4abb4c: f94017e0     	ldr	x0, [sp, #0x28]
  4abb50: b9404800     	ldr	w0, [x0, #0x48]
  4abb54: 0b000020     	add	w0, w1, w0
  4abb58: b9000a60     	str	w0, [x19, #0x8]
  4abb5c: f94017e0     	ldr	x0, [sp, #0x28]
  4abb60: b9404400     	ldr	w0, [x0, #0x44]
  4abb64: 121f0000     	and	w0, w0, #0x2
  4abb68: 7100001f     	cmp	w0, #0x0
  4abb6c: 54000380     	b.eq	0x4abbdc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75c30>
  4abb70: f94013e0     	ldr	x0, [sp, #0x20]
  4abb74: b9401001     	ldr	w1, [x0, #0x10]
  4abb78: f94017e0     	ldr	x0, [sp, #0x28]
  4abb7c: b9404800     	ldr	w0, [x0, #0x48]
  4abb80: 531f7800     	lsl	w0, w0, #1
  4abb84: 4b000020     	sub	w0, w1, w0
  4abb88: b9001260     	str	w0, [x19, #0x10]
  4abb8c: b9401261     	ldr	w1, [x19, #0x10]
  4abb90: f94017e0     	ldr	x0, [sp, #0x28]
  4abb94: b9003801     	str	w1, [x0, #0x38]
  4abb98: 14000011     	b	0x4abbdc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75c30>
  4abb9c: f94017e0     	ldr	x0, [sp, #0x28]
  4abba0: b9404400     	ldr	w0, [x0, #0x44]
  4abba4: 121f0000     	and	w0, w0, #0x2
  4abba8: 7100001f     	cmp	w0, #0x0
  4abbac: 54000180     	b.eq	0x4abbdc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75c30>
  4abbb0: f94013e0     	ldr	x0, [sp, #0x20]
  4abbb4: b9400801     	ldr	w1, [x0, #0x8]
  4abbb8: f94013e0     	ldr	x0, [sp, #0x20]
  4abbbc: b9401000     	ldr	w0, [x0, #0x10]
  4abbc0: 0b000021     	add	w1, w1, w0
  4abbc4: b9401260     	ldr	w0, [x19, #0x10]
  4abbc8: 4b000021     	sub	w1, w1, w0
  4abbcc: f94017e0     	ldr	x0, [sp, #0x28]
  4abbd0: b9404800     	ldr	w0, [x0, #0x48]
  4abbd4: 4b000020     	sub	w0, w1, w0
  4abbd8: b9000a60     	str	w0, [x19, #0x8]
  4abbdc: f94017e0     	ldr	x0, [sp, #0x28]
  4abbe0: b9404400     	ldr	w0, [x0, #0x44]
  4abbe4: 121e0000     	and	w0, w0, #0x4
  4abbe8: 7100001f     	cmp	w0, #0x0
  4abbec: 540002e0     	b.eq	0x4abc48 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75c9c>
  4abbf0: f94013e0     	ldr	x0, [sp, #0x20]
  4abbf4: b9400c01     	ldr	w1, [x0, #0xc]
  4abbf8: f94017e0     	ldr	x0, [sp, #0x28]
  4abbfc: b9404800     	ldr	w0, [x0, #0x48]
  4abc00: 0b000020     	add	w0, w1, w0
  4abc04: b9000e60     	str	w0, [x19, #0xc]
  4abc08: f94017e0     	ldr	x0, [sp, #0x28]
  4abc0c: b9404400     	ldr	w0, [x0, #0x44]
  4abc10: 121d0000     	and	w0, w0, #0x8
  4abc14: 7100001f     	cmp	w0, #0x0
  4abc18: 54000380     	b.eq	0x4abc88 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75cdc>
  4abc1c: f94013e0     	ldr	x0, [sp, #0x20]
  4abc20: b9401401     	ldr	w1, [x0, #0x14]
  4abc24: f94017e0     	ldr	x0, [sp, #0x28]
  4abc28: b9404800     	ldr	w0, [x0, #0x48]
  4abc2c: 531f7800     	lsl	w0, w0, #1
  4abc30: 4b000020     	sub	w0, w1, w0
  4abc34: b9001660     	str	w0, [x19, #0x14]
  4abc38: b9401661     	ldr	w1, [x19, #0x14]
  4abc3c: f94017e0     	ldr	x0, [sp, #0x28]
  4abc40: b9003c01     	str	w1, [x0, #0x3c]
  4abc44: 14000011     	b	0x4abc88 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75cdc>
  4abc48: f94017e0     	ldr	x0, [sp, #0x28]
  4abc4c: b9404400     	ldr	w0, [x0, #0x44]
  4abc50: 121d0000     	and	w0, w0, #0x8
  4abc54: 7100001f     	cmp	w0, #0x0
  4abc58: 54000180     	b.eq	0x4abc88 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75cdc>
  4abc5c: f94013e0     	ldr	x0, [sp, #0x20]
  4abc60: b9400c01     	ldr	w1, [x0, #0xc]
  4abc64: f94013e0     	ldr	x0, [sp, #0x20]
  4abc68: b9401400     	ldr	w0, [x0, #0x14]
  4abc6c: 0b000021     	add	w1, w1, w0
  4abc70: b9401660     	ldr	w0, [x19, #0x14]
  4abc74: 4b000021     	sub	w1, w1, w0
  4abc78: f94017e0     	ldr	x0, [sp, #0x28]
  4abc7c: b9404800     	ldr	w0, [x0, #0x48]
  4abc80: 4b000020     	sub	w0, w1, w0
  4abc84: b9000e60     	str	w0, [x19, #0xc]
  4abc88: d503201f     	nop
  4abc8c: aa1303e0     	mov	x0, x19
  4abc90: f9400bf3     	ldr	x19, [sp, #0x10]
  4abc94: a8c57bfd     	ldp	x29, x30, [sp], #0x50
  4abc98: d65f03c0     	ret
  4abc9c: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
  4abca0: 910003fd     	mov	x29, sp
  4abca4: f9000bf3     	str	x19, [sp, #0x10]
  4abca8: f9001fe0     	str	x0, [sp, #0x38]
  4abcac: f9001be1     	str	x1, [sp, #0x30]
  4abcb0: f90017e2     	str	x2, [sp, #0x28]
  4abcb4: f9401fe0     	ldr	x0, [sp, #0x38]
  4abcb8: f9400000     	ldr	x0, [x0]
  4abcbc: 9102e000     	add	x0, x0, #0xb8
  4abcc0: f9400001     	ldr	x1, [x0]
  4abcc4: 910103e0     	add	x0, sp, #0x40
  4abcc8: aa0003e8     	mov	x8, x0
  4abccc: f9401fe0     	ldr	x0, [sp, #0x38]
  4abcd0: d63f0020     	blr	x1
  4abcd4: 910163e0     	add	x0, sp, #0x58
  4abcd8: f94017e1     	ldr	x1, [sp, #0x28]
  4abcdc: 97feaf19     	bl	0x457940 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21994>
  4abce0: 910163e1     	add	x1, sp, #0x58
  4abce4: 910103e0     	add	x0, sp, #0x40
  4abce8: aa0103e2     	mov	x2, x1
  4abcec: aa0003e1     	mov	x1, x0
  4abcf0: f9401be0     	ldr	x0, [sp, #0x30]
  4abcf4: 97ff48c4     	bl	0x47e004 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x48058>
  4abcf8: 910103e0     	add	x0, sp, #0x40
  4abcfc: 97feafea     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4abd00: 14000006     	b	0x4abd18 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75d6c>
  4abd04: aa0003f3     	mov	x19, x0
  4abd08: 910103e0     	add	x0, sp, #0x40
  4abd0c: 97feafe6     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4abd10: aa1303e0     	mov	x0, x19
  4abd14: 97fd7a8f     	bl	0x40a750 <_Unwind_Resume@plt>
  4abd18: f9400bf3     	ldr	x19, [sp, #0x10]
  4abd1c: a8c67bfd     	ldp	x29, x30, [sp], #0x60
  4abd20: d65f03c0     	ret
  4abd24: a9ac7bfd     	stp	x29, x30, [sp, #-0x140]!
  4abd28: 910003fd     	mov	x29, sp
  4abd2c: f9000bf3     	str	x19, [sp, #0x10]
  4abd30: f90027e0     	str	x0, [sp, #0x48]
  4abd34: f90023e1     	str	x1, [sp, #0x40]
  4abd38: f9001fe2     	str	x2, [sp, #0x38]
  4abd3c: f9001be3     	str	x3, [sp, #0x30]
  4abd40: 3900bfe4     	strb	w4, [sp, #0x2f]
  4abd44: 3904ffff     	strb	wzr, [sp, #0x13f]
  4abd48: f94027e0     	ldr	x0, [sp, #0x48]
  4abd4c: 3941bc00     	ldrb	w0, [x0, #0x6f]
  4abd50: 52000000     	eor	w0, w0, #0x1
  4abd54: 12001c00     	and	w0, w0, #0xff
  4abd58: 7100001f     	cmp	w0, #0x0
  4abd5c: 540000a0     	b.eq	0x4abd70 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75dc4>
  4abd60: f94027e0     	ldr	x0, [sp, #0x48]
  4abd64: 3901b41f     	strb	wzr, [x0, #0x6d]
  4abd68: 52800013     	mov	w19, #0x0               // =0
  4abd6c: 1400009b     	b	0x4abfd8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x7602c>
  4abd70: f94027e0     	ldr	x0, [sp, #0x48]
  4abd74: f9400000     	ldr	x0, [x0]
  4abd78: 9104c000     	add	x0, x0, #0x130
  4abd7c: f9400013     	ldr	x19, [x0]
  4abd80: 910263e0     	add	x0, sp, #0x98
  4abd84: f9401fe1     	ldr	x1, [sp, #0x38]
  4abd88: 97feaff3     	bl	0x457d54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21da8>
  4abd8c: 910263e0     	add	x0, sp, #0x98
  4abd90: 910203e1     	add	x1, sp, #0x80
  4abd94: aa0103e8     	mov	x8, x1
  4abd98: aa0003e1     	mov	x1, x0
  4abd9c: f94027e0     	ldr	x0, [sp, #0x48]
  4abda0: d63f0260     	blr	x19
  4abda4: 910263e0     	add	x0, sp, #0x98
  4abda8: 97feafbf     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4abdac: f94027e0     	ldr	x0, [sp, #0x48]
  4abdb0: 3941b000     	ldrb	w0, [x0, #0x6c]
  4abdb4: 7100001f     	cmp	w0, #0x0
  4abdb8: 54000180     	b.eq	0x4abde8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75e3c>
  4abdbc: 9102c3e2     	add	x2, sp, #0xb0
  4abdc0: f001cfa0     	adrp	x0, 0x3ea2000 <_ZNSt5ctypeIcE2idE+0x2f3eed8>
  4abdc4: 91204001     	add	x1, x0, #0x810
  4abdc8: aa0203e0     	mov	x0, x2
  4abdcc: 97feaedd     	bl	0x457940 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21994>
  4abdd0: 9102c3e1     	add	x1, sp, #0xb0
  4abdd4: 910203e0     	add	x0, sp, #0x80
  4abdd8: aa0103e2     	mov	x2, x1
  4abddc: aa0003e1     	mov	x1, x0
  4abde0: f94023e0     	ldr	x0, [sp, #0x40]
  4abde4: 97febb95     	bl	0x45ac38 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x24c8c>
  4abde8: 910203e0     	add	x0, sp, #0x80
  4abdec: aa0003e1     	mov	x1, x0
  4abdf0: f9401be0     	ldr	x0, [sp, #0x30]
  4abdf4: 97ff494a     	bl	0x47e31c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x48370>
  4abdf8: 12001c00     	and	w0, w0, #0xff
  4abdfc: 7100001f     	cmp	w0, #0x0
  4abe00: 54000e20     	b.eq	0x4abfc4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76018>
  4abe04: f94027e0     	ldr	x0, [sp, #0x48]
  4abe08: f9400000     	ldr	x0, [x0]
  4abe0c: 9102c000     	add	x0, x0, #0xb0
  4abe10: f9400001     	ldr	x1, [x0]
  4abe14: f94027e0     	ldr	x0, [sp, #0x48]
  4abe18: d63f0020     	blr	x1
  4abe1c: 12001c00     	and	w0, w0, #0xff
  4abe20: 7100001f     	cmp	w0, #0x0
  4abe24: 54000081     	b.ne	0x4abe34 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75e88>
  4abe28: 3940bfe0     	ldrb	w0, [sp, #0x2f]
  4abe2c: 7100001f     	cmp	w0, #0x0
  4abe30: 54000060     	b.eq	0x4abe3c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75e90>
  4abe34: 52800020     	mov	w0, #0x1                // =1
  4abe38: 14000002     	b	0x4abe40 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75e94>
  4abe3c: 52800000     	mov	w0, #0x0                // =0
  4abe40: 7100001f     	cmp	w0, #0x0
  4abe44: 540004e0     	b.eq	0x4abee0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75f34>
  4abe48: f94027e0     	ldr	x0, [sp, #0x48]
  4abe4c: f9400000     	ldr	x0, [x0]
  4abe50: 91028000     	add	x0, x0, #0xa0
  4abe54: f9400013     	ldr	x19, [x0]
  4abe58: 910203e1     	add	x1, sp, #0x80
  4abe5c: 9102e3e0     	add	x0, sp, #0xb8
  4abe60: 97feafbd     	bl	0x457d54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21da8>
  4abe64: 910343e0     	add	x0, sp, #0xd0
  4abe68: f9401be1     	ldr	x1, [sp, #0x30]
  4abe6c: 97feafba     	bl	0x457d54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21da8>
  4abe70: 910343e1     	add	x1, sp, #0xd0
  4abe74: 9102e3e0     	add	x0, sp, #0xb8
  4abe78: 910143e2     	add	x2, sp, #0x50
  4abe7c: aa0203e8     	mov	x8, x2
  4abe80: aa0103e3     	mov	x3, x1
  4abe84: aa0003e2     	mov	x2, x0
  4abe88: f94023e1     	ldr	x1, [sp, #0x40]
  4abe8c: f94027e0     	ldr	x0, [sp, #0x48]
  4abe90: d63f0260     	blr	x19
  4abe94: 910343e0     	add	x0, sp, #0xd0
  4abe98: 97feaf83     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4abe9c: 9102e3e0     	add	x0, sp, #0xb8
  4abea0: 97feaf81     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4abea4: 52800020     	mov	w0, #0x1                // =1
  4abea8: 3900bfe0     	strb	w0, [sp, #0x2f]
  4abeac: 52800020     	mov	w0, #0x1                // =1
  4abeb0: 3904ffe0     	strb	w0, [sp, #0x13f]
  4abeb4: 910143e1     	add	x1, sp, #0x50
  4abeb8: 9103a3e0     	add	x0, sp, #0xe8
  4abebc: 97feafa6     	bl	0x457d54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21da8>
  4abec0: 9103a3e0     	add	x0, sp, #0xe8
  4abec4: aa0003e1     	mov	x1, x0
  4abec8: f94023e0     	ldr	x0, [sp, #0x40]
  4abecc: 97ff03d6     	bl	0x46ce24 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x36e78>
  4abed0: 9103a3e0     	add	x0, sp, #0xe8
  4abed4: 97feaf74     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4abed8: 910143e0     	add	x0, sp, #0x50
  4abedc: 97feaf72     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4abee0: f94027e1     	ldr	x1, [sp, #0x48]
  4abee4: 9101a3e0     	add	x0, sp, #0x68
  4abee8: 9400046c     	bl	0x4ad098 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x770ec>
  4abeec: 9101a3e0     	add	x0, sp, #0x68
  4abef0: 94098472     	bl	0x70d0b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1f038>
  4abef4: aa0003e1     	mov	x1, x0
  4abef8: 9101a3e0     	add	x0, sp, #0x68
  4abefc: 9400048b     	bl	0x4ad128 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x7717c>
  4abf00: f94037e0     	ldr	x0, [sp, #0x68]
  4abf04: 91012000     	add	x0, x0, #0x48
  4abf08: f9400013     	ldr	x19, [x0]
  4abf0c: 9101a3e0     	add	x0, sp, #0x68
  4abf10: 94098471     	bl	0x70d0d4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1f054>
  4abf14: aa0003e1     	mov	x1, x0
  4abf18: 9101a3e0     	add	x0, sp, #0x68
  4abf1c: d63f0260     	blr	x19
  4abf20: 12001c00     	and	w0, w0, #0xff
  4abf24: 7100001f     	cmp	w0, #0x0
  4abf28: 540004a0     	b.eq	0x4abfbc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76010>
  4abf2c: 9101a3e0     	add	x0, sp, #0x68
  4abf30: 94000487     	bl	0x4ad14c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x771a0>
  4abf34: f9009be0     	str	x0, [sp, #0x130]
  4abf38: f9409be0     	ldr	x0, [sp, #0x130]
  4abf3c: f9400000     	ldr	x0, [x0]
  4abf40: 91026000     	add	x0, x0, #0x98
  4abf44: f9400013     	ldr	x19, [x0]
  4abf48: 910203e1     	add	x1, sp, #0x80
  4abf4c: 910403e0     	add	x0, sp, #0x100
  4abf50: 97feaf81     	bl	0x457d54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21da8>
  4abf54: 910463e0     	add	x0, sp, #0x118
  4abf58: f9401be1     	ldr	x1, [sp, #0x30]
  4abf5c: 97feaf7e     	bl	0x457d54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21da8>
  4abf60: 910463e1     	add	x1, sp, #0x118
  4abf64: 910403e0     	add	x0, sp, #0x100
  4abf68: 3940bfe4     	ldrb	w4, [sp, #0x2f]
  4abf6c: aa0103e3     	mov	x3, x1
  4abf70: aa0003e2     	mov	x2, x0
  4abf74: f94023e1     	ldr	x1, [sp, #0x40]
  4abf78: f9409be0     	ldr	x0, [sp, #0x130]
  4abf7c: d63f0260     	blr	x19
  4abf80: 12001c01     	and	w1, w0, #0xff
  4abf84: 3944ffe0     	ldrb	w0, [sp, #0x13f]
  4abf88: 2a000020     	orr	w0, w1, w0
  4abf8c: 3904ffe0     	strb	w0, [sp, #0x13f]
  4abf90: 910463e0     	add	x0, sp, #0x118
  4abf94: 97feaf44     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4abf98: 910403e0     	add	x0, sp, #0x100
  4abf9c: 97feaf42     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4abfa0: f94037e0     	ldr	x0, [sp, #0x68]
  4abfa4: 9100c000     	add	x0, x0, #0x30
  4abfa8: f9400002     	ldr	x2, [x0]
  4abfac: 9101a3e0     	add	x0, sp, #0x68
  4abfb0: 52800001     	mov	w1, #0x0                // =0
  4abfb4: d63f0040     	blr	x2
  4abfb8: 17ffffd2     	b	0x4abf00 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x75f54>
  4abfbc: 9101a3e0     	add	x0, sp, #0x68
  4abfc0: 94000444     	bl	0x4ad0d0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x77124>
  4abfc4: f94027e0     	ldr	x0, [sp, #0x48]
  4abfc8: 3901b41f     	strb	wzr, [x0, #0x6d]
  4abfcc: 3944fff3     	ldrb	w19, [sp, #0x13f]
  4abfd0: 910203e0     	add	x0, sp, #0x80
  4abfd4: 97feaf34     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4abfd8: 2a1303e0     	mov	w0, w19
  4abfdc: 14000021     	b	0x4ac060 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x760b4>
  4abfe0: aa0003f3     	mov	x19, x0
  4abfe4: 910263e0     	add	x0, sp, #0x98
  4abfe8: 97feaf2f     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4abfec: aa1303e0     	mov	x0, x19
  4abff0: 97fd79d8     	bl	0x40a750 <_Unwind_Resume@plt>
  4abff4: aa0003f3     	mov	x19, x0
  4abff8: 910343e0     	add	x0, sp, #0xd0
  4abffc: 97feaf2a     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4ac000: 9102e3e0     	add	x0, sp, #0xb8
  4ac004: 97feaf28     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4ac008: 14000012     	b	0x4ac050 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x760a4>
  4ac00c: aa0003f3     	mov	x19, x0
  4ac010: 9103a3e0     	add	x0, sp, #0xe8
  4ac014: 97feaf24     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4ac018: 910143e0     	add	x0, sp, #0x50
  4ac01c: 97feaf22     	bl	0x457ca4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21cf8>
  4ac020: 1400000c     	b	0x4ac050 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x760a4>
  4ac024: aa0003f3     	mov	x19, x0
