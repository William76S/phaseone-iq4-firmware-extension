
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000004f90b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv>:
  69b2a0: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
  69b2a4: 910003fd     	mov	x29, sp
  69b2a8: f9000bf3     	str	x19, [sp, #0x10]
  69b2ac: f90027e0     	str	x0, [sp, #0x48]
  69b2b0: f90023e1     	str	x1, [sp, #0x40]
  69b2b4: f9001fe2     	str	x2, [sp, #0x38]
  69b2b8: f9001be3     	str	x3, [sp, #0x30]
  69b2bc: f90017e4     	str	x4, [sp, #0x28]
  69b2c0: b0002b20     	adrp	x0, 0xc00000
  69b2c4: 91006001     	add	x1, x0, #0x18
  69b2c8: f94027e0     	ldr	x0, [sp, #0x48]
  69b2cc: f9000001     	str	x1, [x0]
  69b2d0: f94027e0     	ldr	x0, [sp, #0x48]
  69b2d4: f9401fe1     	ldr	x1, [sp, #0x38]
  69b2d8: f9000401     	str	x1, [x0, #0x8]
  69b2dc: f94027e0     	ldr	x0, [sp, #0x48]
  69b2e0: f9401be1     	ldr	x1, [sp, #0x30]
  69b2e4: f9000801     	str	x1, [x0, #0x10]
  69b2e8: f94027e0     	ldr	x0, [sp, #0x48]
  69b2ec: f94017e1     	ldr	x1, [sp, #0x28]
  69b2f0: f9000c01     	str	x1, [x0, #0x18]
  69b2f4: f94027e0     	ldr	x0, [sp, #0x48]
  69b2f8: 91008008     	add	x8, x0, #0x20
  69b2fc: f94023e0     	ldr	x0, [sp, #0x40]
  69b300: 91002001     	add	x1, x0, #0x8
  69b304: 52800007     	mov	w7, #0x0                // =0
  69b308: 90002b20     	adrp	x0, 0xbff000
  69b30c: 912f2006     	add	x6, x0, #0xbc8
  69b310: 52800685     	mov	w5, #0x34               // =52
  69b314: 90002b20     	adrp	x0, 0xbff000
  69b318: 912f4004     	add	x4, x0, #0xbd0
  69b31c: 52800663     	mov	w3, #0x33               // =51
  69b320: 528099c2     	mov	w2, #0x4ce              // =1230
  69b324: aa0803e0     	mov	x0, x8
  69b328: 97fbf1b7     	bl	0x597a04 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x9e954>
  69b32c: f94027e0     	ldr	x0, [sp, #0x48]
  69b330: 91054008     	add	x8, x0, #0x150
  69b334: f94023e0     	ldr	x0, [sp, #0x40]
  69b338: 91038001     	add	x1, x0, #0xe0
  69b33c: 52800027     	mov	w7, #0x1                // =1
  69b340: 90002b20     	adrp	x0, 0xbff000
  69b344: 912f2006     	add	x6, x0, #0xbc8
  69b348: 52800685     	mov	w5, #0x34               // =52
  69b34c: 90002b20     	adrp	x0, 0xbff000
  69b350: 912f4004     	add	x4, x0, #0xbd0
  69b354: 52800663     	mov	w3, #0x33               // =51
  69b358: 528099e2     	mov	w2, #0x4cf              // =1231
  69b35c: aa0803e0     	mov	x0, x8
  69b360: 97fbf1a9     	bl	0x597a04 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x9e954>
  69b364: f94027e0     	ldr	x0, [sp, #0x48]
  69b368: 910a0008     	add	x8, x0, #0x280
  69b36c: f94023e0     	ldr	x0, [sp, #0x40]
  69b370: f940dc00     	ldr	x0, [x0, #0x1b8]
  69b374: aa0003e1     	mov	x1, x0
  69b378: 52800027     	mov	w7, #0x1                // =1
  69b37c: 90002b20     	adrp	x0, 0xbff000
  69b380: 912f2006     	add	x6, x0, #0xbc8
  69b384: 52800685     	mov	w5, #0x34               // =52
  69b388: 90002b20     	adrp	x0, 0xbff000
  69b38c: 912f4004     	add	x4, x0, #0xbd0
  69b390: 52800663     	mov	w3, #0x33               // =51
  69b394: 52801ba2     	mov	w2, #0xdd               // =221
  69b398: aa0803e0     	mov	x0, x8
  69b39c: 97fbf19a     	bl	0x597a04 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x9e954>
  69b3a0: f94027e0     	ldr	x0, [sp, #0x48]
  69b3a4: 910ec008     	add	x8, x0, #0x3b0
  69b3a8: f94023e0     	ldr	x0, [sp, #0x40]
  69b3ac: f940e000     	ldr	x0, [x0, #0x1c0]
  69b3b0: aa0003e1     	mov	x1, x0
  69b3b4: 52800007     	mov	w7, #0x0                // =0
  69b3b8: 90002b20     	adrp	x0, 0xbff000
  69b3bc: 912f2006     	add	x6, x0, #0xbc8
  69b3c0: 52800685     	mov	w5, #0x34               // =52
  69b3c4: 90002b20     	adrp	x0, 0xbff000
  69b3c8: 912f4004     	add	x4, x0, #0xbd0
  69b3cc: 52800663     	mov	w3, #0x33               // =51
  69b3d0: 52809a62     	mov	w2, #0x4d3              // =1235
  69b3d4: aa0803e0     	mov	x0, x8
  69b3d8: 97fbf18b     	bl	0x597a04 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x9e954>
  69b3dc: f94027e0     	ldr	x0, [sp, #0x48]
  69b3e0: 91138008     	add	x8, x0, #0x4e0
  69b3e4: f94023e0     	ldr	x0, [sp, #0x40]
  69b3e8: 91072001     	add	x1, x0, #0x1c8
  69b3ec: 52800007     	mov	w7, #0x0                // =0
  69b3f0: 90002b20     	adrp	x0, 0xbff000
  69b3f4: 912f2006     	add	x6, x0, #0xbc8
  69b3f8: 52800685     	mov	w5, #0x34               // =52
  69b3fc: 90002b20     	adrp	x0, 0xbff000
  69b400: 912f4004     	add	x4, x0, #0xbd0
  69b404: 52800663     	mov	w3, #0x33               // =51
  69b408: 52809a62     	mov	w2, #0x4d3              // =1235
  69b40c: aa0803e0     	mov	x0, x8
  69b410: 97fbf17d     	bl	0x597a04 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x9e954>
  69b414: f94027e0     	ldr	x0, [sp, #0x48]
  69b418: f94023e1     	ldr	x1, [sp, #0x40]
  69b41c: f9030801     	str	x1, [x0, #0x610]
  69b420: 14000016     	b	0x69b478 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x1a23c8>
  69b424: aa0003f3     	mov	x19, x0
  69b428: f94027e0     	ldr	x0, [sp, #0x48]
  69b42c: 910ec000     	add	x0, x0, #0x3b0
  69b430: 97fc06a9     	bl	0x59ced4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xa3e24>
  69b434: 14000002     	b	0x69b43c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x1a238c>
  69b438: aa0003f3     	mov	x19, x0
  69b43c: f94027e0     	ldr	x0, [sp, #0x48]
  69b440: 910a0000     	add	x0, x0, #0x280
  69b444: 97fc06a4     	bl	0x59ced4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xa3e24>
  69b448: 14000002     	b	0x69b450 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x1a23a0>
  69b44c: aa0003f3     	mov	x19, x0
  69b450: f94027e0     	ldr	x0, [sp, #0x48]
  69b454: 91054000     	add	x0, x0, #0x150
  69b458: 97fc069f     	bl	0x59ced4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xa3e24>
  69b45c: 14000002     	b	0x69b464 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x1a23b4>
  69b460: aa0003f3     	mov	x19, x0
  69b464: f94027e0     	ldr	x0, [sp, #0x48]
  69b468: 91008000     	add	x0, x0, #0x20
  69b46c: 97fc069a     	bl	0x59ced4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xa3e24>
  69b470: aa1303e0     	mov	x0, x19
  69b474: 97f5bcb7     	bl	0x40a750 <_Unwind_Resume@plt>
  69b478: f9400bf3     	ldr	x19, [sp, #0x10]
  69b47c: a8c57bfd     	ldp	x29, x30, [sp], #0x50
  69b480: d65f03c0     	ret
  69b484: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  69b488: 910003fd     	mov	x29, sp
  69b48c: f9000fe0     	str	x0, [sp, #0x18]
  69b490: b0002b20     	adrp	x0, 0xc00000
  69b494: 91006001     	add	x1, x0, #0x18
  69b498: f9400fe0     	ldr	x0, [sp, #0x18]
  69b49c: f9000001     	str	x1, [x0]
  69b4a0: f9400fe0     	ldr	x0, [sp, #0x18]
  69b4a4: 91138000     	add	x0, x0, #0x4e0
  69b4a8: 97fc068b     	bl	0x59ced4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xa3e24>
  69b4ac: f9400fe0     	ldr	x0, [sp, #0x18]
  69b4b0: 910ec000     	add	x0, x0, #0x3b0
  69b4b4: 97fc0688     	bl	0x59ced4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xa3e24>
  69b4b8: f9400fe0     	ldr	x0, [sp, #0x18]
  69b4bc: 910a0000     	add	x0, x0, #0x280
  69b4c0: 97fc0685     	bl	0x59ced4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xa3e24>
  69b4c4: f9400fe0     	ldr	x0, [sp, #0x18]
  69b4c8: 91054000     	add	x0, x0, #0x150
  69b4cc: 97fc0682     	bl	0x59ced4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xa3e24>
  69b4d0: f9400fe0     	ldr	x0, [sp, #0x18]
  69b4d4: 91008000     	add	x0, x0, #0x20
  69b4d8: 97fc067f     	bl	0x59ced4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xa3e24>
  69b4dc: d503201f     	nop
  69b4e0: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  69b4e4: d65f03c0     	ret
  69b4e8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  69b4ec: 910003fd     	mov	x29, sp
  69b4f0: f9000fe0     	str	x0, [sp, #0x18]
  69b4f4: f9400fe0     	ldr	x0, [sp, #0x18]
  69b4f8: 97ffffe3     	bl	0x69b484 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x1a23d4>
  69b4fc: d280c301     	mov	x1, #0x618              // =1560
  69b500: f9400fe0     	ldr	x0, [sp, #0x18]
  69b504: 97f5ba37     	bl	0x409de0 <_ZdlPvm@plt>
  69b508: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  69b50c: d65f03c0     	ret
