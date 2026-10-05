  4921fc: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
  492200: 910003fd     	mov	x29, sp
  492204: f9000bf3     	str	x19, [sp, #0x10]
  492208: f9002fe0     	str	x0, [sp, #0x58]
  49220c: f9002be1     	str	x1, [sp, #0x50]
  492210: f90027e2     	str	x2, [sp, #0x48]
  492214: f90023e3     	str	x3, [sp, #0x40]
  492218: f9001fe4     	str	x4, [sp, #0x38]
  49221c: f9001be5     	str	x5, [sp, #0x30]
  492220: f90017e6     	str	x6, [sp, #0x28]
  492224: f90013e7     	str	x7, [sp, #0x20]
  492228: f9402fe5     	ldr	x5, [sp, #0x58]
  49222c: b9406be1     	ldr	w1, [sp, #0x68]
  492230: b94093e0     	ldr	w0, [sp, #0x90]
  492234: 0b000020     	add	w0, w1, w0
  492238: f94027e4     	ldr	x4, [sp, #0x48]
  49223c: f9402be3     	ldr	x3, [sp, #0x50]
  492240: f94023e2     	ldr	x2, [sp, #0x40]
  492244: 2a0003e1     	mov	w1, w0
  492248: aa0503e0     	mov	x0, x5
  49224c: 97ffd371     	bl	0x487010 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x51064>
  492250: 90003760     	adrp	x0, 0xb7e000
  492254: 91338001     	add	x1, x0, #0xce0
  492258: f9402fe0     	ldr	x0, [sp, #0x58]
  49225c: f9000001     	str	x1, [x0]
  492260: f9402fe0     	ldr	x0, [sp, #0x58]
  492264: f9401be1     	ldr	x1, [sp, #0x30]
  492268: f903bc01     	str	x1, [x0, #0x778]
  49226c: f9402fe0     	ldr	x0, [sp, #0x58]
  492270: f9401fe1     	ldr	x1, [sp, #0x38]
  492274: f903c001     	str	x1, [x0, #0x780]
  492278: f9402fe0     	ldr	x0, [sp, #0x58]
  49227c: f94017e1     	ldr	x1, [sp, #0x28]
  492280: f903c401     	str	x1, [x0, #0x788]
  492284: f9402fe0     	ldr	x0, [sp, #0x58]
  492288: f94013e1     	ldr	x1, [sp, #0x20]
  49228c: f903cc01     	str	x1, [x0, #0x798]
  492290: f9402fe0     	ldr	x0, [sp, #0x58]
  492294: f94033e1     	ldr	x1, [sp, #0x60]
  492298: f903d001     	str	x1, [x0, #0x7a0]
  49229c: f9402fe0     	ldr	x0, [sp, #0x58]
  4922a0: 391ea01f     	strb	wzr, [x0, #0x7a8]
  4922a4: f9402fe0     	ldr	x0, [sp, #0x58]
  4922a8: f9403be1     	ldr	x1, [sp, #0x70]
  4922ac: f903d801     	str	x1, [x0, #0x7b0]
  4922b0: f9402fe0     	ldr	x0, [sp, #0x58]
  4922b4: f9403fe1     	ldr	x1, [sp, #0x78]
  4922b8: f903dc01     	str	x1, [x0, #0x7b8]
  4922bc: f9402fe0     	ldr	x0, [sp, #0x58]
  4922c0: f94043e1     	ldr	x1, [sp, #0x80]
  4922c4: f903e401     	str	x1, [x0, #0x7c8]
  4922c8: f9402fe0     	ldr	x0, [sp, #0x58]
  4922cc: f94047e1     	ldr	x1, [sp, #0x88]
  4922d0: f903e801     	str	x1, [x0, #0x7d0]
  4922d4: f9402fe0     	ldr	x0, [sp, #0x58]
  4922d8: 391f601f     	strb	wzr, [x0, #0x7d8]
  4922dc: f9402fe0     	ldr	x0, [sp, #0x58]
  4922e0: f9404fe1     	ldr	x1, [sp, #0x98]
  4922e4: f903f001     	str	x1, [x0, #0x7e0]
  4922e8: f9402fe0     	ldr	x0, [sp, #0x58]
  4922ec: f940d800     	ldr	x0, [x0, #0x1b0]
  4922f0: d2800001     	mov	x1, #0x0                // =0
  4922f4: 97fff47f     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  4922f8: aa0003e3     	mov	x3, x0
  4922fc: f9402fe0     	ldr	x0, [sp, #0x58]
  492300: b941a800     	ldr	w0, [x0, #0x1a8]
  492304: 2a0003e1     	mov	w1, w0
  492308: aa0103e0     	mov	x0, x1
  49230c: d37ef400     	lsl	x0, x0, #2
  492310: 8b010000     	add	x0, x0, x1
  492314: d37df000     	lsl	x0, x0, #3
  492318: aa0003e2     	mov	x2, x0
  49231c: 52800001     	mov	w1, #0x0                // =0
  492320: aa0303e0     	mov	x0, x3
  492324: 97fddf9f     	bl	0x40a1a0 <memset@plt>
  492328: f9402fe0     	ldr	x0, [sp, #0x58]
  49232c: f943c400     	ldr	x0, [x0, #0x788]
  492330: aa0003e2     	mov	x2, x0
  492334: 90003760     	adrp	x0, 0xb7e000
  492338: 911da001     	add	x1, x0, #0x768
  49233c: aa0203e0     	mov	x0, x2
  492340: 9410e02b     	bl	0x8ca3ec <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x23bc0>
  492344: 2a0003e1     	mov	w1, w0
  492348: f9402fe0     	ldr	x0, [sp, #0x58]
  49234c: b9079001     	str	w1, [x0, #0x790]
  492350: f9402fe0     	ldr	x0, [sp, #0x58]
  492354: f943dc00     	ldr	x0, [x0, #0x7b8]
  492358: aa0003e2     	mov	x2, x0
  49235c: 90003760     	adrp	x0, 0xb7e000
  492360: 911da001     	add	x1, x0, #0x768
  492364: aa0203e0     	mov	x0, x2
  492368: 9410e021     	bl	0x8ca3ec <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x23bc0>
  49236c: 2a0003e1     	mov	w1, w0
  492370: f9402fe0     	ldr	x0, [sp, #0x58]
  492374: b907c001     	str	w1, [x0, #0x7c0]
  492378: 14000006     	b	0x492390 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c3e4>
  49237c: aa0003f3     	mov	x19, x0
  492380: f9402fe0     	ldr	x0, [sp, #0x58]
  492384: 97ffd435     	bl	0x487458 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x514ac>
  492388: aa1303e0     	mov	x0, x19
  49238c: 97fde0f1     	bl	0x40a750 <_Unwind_Resume@plt>
  492390: f9400bf3     	ldr	x19, [sp, #0x10]
  492394: a8c67bfd     	ldp	x29, x30, [sp], #0x60
  492398: d65f03c0     	ret
  49239c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4923a0: 910003fd     	mov	x29, sp
  4923a4: f9000fe0     	str	x0, [sp, #0x18]
  4923a8: 90003760     	adrp	x0, 0xb7e000
  4923ac: 91338001     	add	x1, x0, #0xce0
  4923b0: f9400fe0     	ldr	x0, [sp, #0x18]
  4923b4: f9000001     	str	x1, [x0]
  4923b8: f9400fe0     	ldr	x0, [sp, #0x18]
  4923bc: 97ffd427     	bl	0x487458 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x514ac>
  4923c0: d503201f     	nop
  4923c4: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4923c8: d65f03c0     	ret
  4923cc: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4923d0: 910003fd     	mov	x29, sp
  4923d4: f9000fe0     	str	x0, [sp, #0x18]
  4923d8: f9400fe0     	ldr	x0, [sp, #0x18]
  4923dc: 97fffff0     	bl	0x49239c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c3f0>
  4923e0: d280fd01     	mov	x1, #0x7e8              // =2024
  4923e4: f9400fe0     	ldr	x0, [sp, #0x18]
  4923e8: 97fdde7e     	bl	0x409de0 <_ZdlPvm@plt>
  4923ec: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4923f0: d65f03c0     	ret
  4923f4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4923f8: 910003fd     	mov	x29, sp
  4923fc: f9000fe0     	str	x0, [sp, #0x18]
  492400: d2800001     	mov	x1, #0x0                // =0
  492404: f9400fe0     	ldr	x0, [sp, #0x18]
  492408: 9400018c     	bl	0x492a38 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5ca8c>
  49240c: d503201f     	nop
  492410: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  492414: d65f03c0     	ret
  492418: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  49241c: 910003fd     	mov	x29, sp
  492420: f9000fe0     	str	x0, [sp, #0x18]
  492424: f9400fe2     	ldr	x2, [sp, #0x18]
  492428: f9400fe0     	ldr	x0, [sp, #0x18]
  49242c: f943cc00     	ldr	x0, [x0, #0x798]
  492430: 91002000     	add	x0, x0, #0x8
  492434: aa0003e1     	mov	x1, x0
  492438: aa0203e0     	mov	x0, x2
  49243c: 97ffd4e0     	bl	0x4877bc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x51810>
  492440: f9400fe2     	ldr	x2, [sp, #0x18]
  492444: f9400fe0     	ldr	x0, [sp, #0x18]
  492448: f943e400     	ldr	x0, [x0, #0x7c8]
  49244c: 91002000     	add	x0, x0, #0x8
  492450: aa0003e1     	mov	x1, x0
  492454: aa0203e0     	mov	x0, x2
  492458: 97ffd4d9     	bl	0x4877bc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x51810>
  49245c: f9400fe2     	ldr	x2, [sp, #0x18]
  492460: f9400fe0     	ldr	x0, [sp, #0x18]
  492464: f943c000     	ldr	x0, [x0, #0x780]
  492468: 91078000     	add	x0, x0, #0x1e0
  49246c: aa0003e1     	mov	x1, x0
  492470: aa0203e0     	mov	x0, x2
  492474: 97ffd4d2     	bl	0x4877bc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x51810>
  492478: f9400fe2     	ldr	x2, [sp, #0x18]
  49247c: f9400fe0     	ldr	x0, [sp, #0x18]
  492480: f9419400     	ldr	x0, [x0, #0x328]
  492484: 9111a000     	add	x0, x0, #0x468
  492488: aa0003e1     	mov	x1, x0
  49248c: aa0203e0     	mov	x0, x2
  492490: 97ffd4cb     	bl	0x4877bc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x51810>
  492494: d503201f     	nop
  492498: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  49249c: d65f03c0     	ret
