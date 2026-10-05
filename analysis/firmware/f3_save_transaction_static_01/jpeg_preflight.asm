  8e1180: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8e1184: 910003fd     	mov	x29, sp
  8e1188: f9000fe0     	str	x0, [sp, #0x18]
  8e118c: 39005fe1     	strb	w1, [sp, #0x17]
  8e1190: f9400fe0     	ldr	x0, [sp, #0x18]
  8e1194: f940e400     	ldr	x0, [x0, #0x1c8]
  8e1198: 9111a000     	add	x0, x0, #0x468
  8e119c: 97eccdf8     	bl	0x41497c <.text+0x974c>
  8e11a0: 12001c00     	and	w0, w0, #0xff
  8e11a4: 52000000     	eor	w0, w0, #0x1
  8e11a8: 12001c00     	and	w0, w0, #0xff
  8e11ac: 7100001f     	cmp	w0, #0x0
  8e11b0: 54000200     	b.eq	0x8e11f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3a9c4>
  8e11b4: 39405fe0     	ldrb	w0, [sp, #0x17]
  8e11b8: 7100001f     	cmp	w0, #0x0
  8e11bc: 54000160     	b.eq	0x8e11e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3a9bc>
  8e11c0: d2800003     	mov	x3, #0x0                // =0
  8e11c4: 52800002     	mov	w2, #0x0                // =0
  8e11c8: 52800001     	mov	w1, #0x0                // =0
  8e11cc: 528020a0     	mov	w0, #0x105              // =261
  8e11d0: 97ff7985     	bl	0x8bf7e4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x18fb8>
  8e11d4: f9400fe1     	ldr	x1, [sp, #0x18]
  8e11d8: d2a0c800     	mov	x0, #0x6400000          // =104857600
  8e11dc: 8b000020     	add	x0, x1, x0
  8e11e0: 52800021     	mov	w1, #0x1                // =1
  8e11e4: 390fa001     	strb	w1, [x0, #0x3e8]
  8e11e8: 52800000     	mov	w0, #0x0                // =0
  8e11ec: 1400001c     	b	0x8e125c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3aa30>
  8e11f0: f9400fe0     	ldr	x0, [sp, #0x18]
  8e11f4: f940e400     	ldr	x0, [x0, #0x1c8]
  8e11f8: 91372000     	add	x0, x0, #0xdc8
  8e11fc: 97f10f8e     	bl	0x525034 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x2bf84>
  8e1200: aa0003e1     	mov	x1, x0
  8e1204: b2404fe0     	mov	x0, #0xfffff            // =1048575
  8e1208: eb00003f     	cmp	x1, x0
  8e120c: 1a9f87e0     	cset	w0, ls
  8e1210: 12001c00     	and	w0, w0, #0xff
  8e1214: 7100001f     	cmp	w0, #0x0
  8e1218: 54000200     	b.eq	0x8e1258 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3aa2c>
  8e121c: 39405fe0     	ldrb	w0, [sp, #0x17]
  8e1220: 7100001f     	cmp	w0, #0x0
  8e1224: 54000160     	b.eq	0x8e1250 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3aa24>
  8e1228: d2800003     	mov	x3, #0x0                // =0
  8e122c: 52800002     	mov	w2, #0x0                // =0
  8e1230: 52800001     	mov	w1, #0x0                // =0
  8e1234: 528020c0     	mov	w0, #0x106              // =262
  8e1238: 97ff796b     	bl	0x8bf7e4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x18fb8>
  8e123c: f9400fe1     	ldr	x1, [sp, #0x18]
  8e1240: d2a0c800     	mov	x0, #0x6400000          // =104857600
  8e1244: 8b000020     	add	x0, x1, x0
  8e1248: 52800021     	mov	w1, #0x1                // =1
  8e124c: 390fa001     	strb	w1, [x0, #0x3e8]
  8e1250: 52800000     	mov	w0, #0x0                // =0
  8e1254: 14000002     	b	0x8e125c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3aa30>
  8e1258: 52800020     	mov	w0, #0x1                // =1
  8e125c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8e1260: d65f03c0     	ret
  8e1264: a9ac7bfd     	stp	x29, x30, [sp, #-0x140]!
  8e1268: 910003fd     	mov	x29, sp
  8e126c: a90153f3     	stp	x19, x20, [sp, #0x10]
  8e1270: f90017e0     	str	x0, [sp, #0x28]
  8e1274: b90027e1     	str	w1, [sp, #0x24]
  8e1278: f94017e1     	ldr	x1, [sp, #0x28]
  8e127c: d2a0c800     	mov	x0, #0x6400000          // =104857600
  8e1280: 8b000020     	add	x0, x1, x0
  8e1284: 394fa000     	ldrb	w0, [x0, #0x3e8]
  8e1288: 52000000     	eor	w0, w0, #0x1
  8e128c: 12001c00     	and	w0, w0, #0xff
  8e1290: 2a0003e1     	mov	w1, w0
  8e1294: f94017e0     	ldr	x0, [sp, #0x28]
  8e1298: 97ffffba     	bl	0x8e1180 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3a954>
  8e129c: 12001c00     	and	w0, w0, #0xff
  8e12a0: 52000000     	eor	w0, w0, #0x1
  8e12a4: 12001c00     	and	w0, w0, #0xff
  8e12a8: 7100001f     	cmp	w0, #0x0
  8e12ac: 54000120     	b.eq	0x8e12d0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3aaa4>
  8e12b0: f00026c0     	adrp	x0, 0xdbc000
  8e12b4: 912a0002     	add	x2, x0, #0xa80
  8e12b8: 52801e21     	mov	w1, #0xf1               // =241
  8e12bc: f00026c0     	adrp	x0, 0xdbc000
  8e12c0: 9122c000     	add	x0, x0, #0x8b0
  8e12c4: 97f99476     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  8e12c8: 52800073     	mov	w19, #0x3               // =3
  8e12cc: 14000125     	b	0x8e1760 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3af34>
  8e12d0: b94027e3     	ldr	w3, [sp, #0x24]
  8e12d4: f00026c0     	adrp	x0, 0xdbc000
  8e12d8: 912ac002     	add	x2, x0, #0xab0
  8e12dc: 52801ea1     	mov	w1, #0xf5               // =245
  8e12e0: f00026c0     	adrp	x0, 0xdbc000
  8e12e4: 9122c000     	add	x0, x0, #0x8b0
  8e12e8: 97f9946d     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  8e12ec: b94027e0     	ldr	w0, [sp, #0x24]
