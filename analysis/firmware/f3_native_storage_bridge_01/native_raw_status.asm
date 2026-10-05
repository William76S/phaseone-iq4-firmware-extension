  8dbbac: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  8dbbb0: 910003fd     	mov	x29, sp
  8dbbb4: f9000fe0     	str	x0, [sp, #0x18]
  8dbbb8: b90017e1     	str	w1, [sp, #0x14]
  8dbbbc: f9400fe0     	ldr	x0, [sp, #0x18]
  8dbbc0: b9400800     	ldr	w0, [x0, #0x8]
  8dbbc4: b94017e1     	ldr	w1, [sp, #0x14]
  8dbbc8: 6b00003f     	cmp	w1, w0
  8dbbcc: 54000143     	b.lo	0x8dbbf4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x353c8>
  8dbbd0: 52802883     	mov	w3, #0x144              // =324
  8dbbd4: f00026e0     	adrp	x0, 0xdba000
  8dbbd8: 911e0002     	add	x2, x0, #0x780
  8dbbdc: f00026e0     	adrp	x0, 0xdba000
  8dbbe0: 911fe001     	add	x1, x0, #0x7f8
  8dbbe4: f00026e0     	adrp	x0, 0xdba000
  8dbbe8: 911f4000     	add	x0, x0, #0x7d0
  8dbbec: 97ecba65     	bl	0x40a580 <printf@plt>
  8dbbf0: 97fa42c6     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8dbbf4: b94017e1     	ldr	w1, [sp, #0x14]
  8dbbf8: f9400fe0     	ldr	x0, [sp, #0x18]
  8dbbfc: 97ffff96     	bl	0x8dba54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35228>
  8dbc00: b9002fe0     	str	w0, [sp, #0x2c]
  8dbc04: f9400fe0     	ldr	x0, [sp, #0x18]
  8dbc08: f9400801     	ldr	x1, [x0, #0x10]
  8dbc0c: b94017e0     	ldr	w0, [sp, #0x14]
  8dbc10: d37df000     	lsl	x0, x0, #3
  8dbc14: 8b000020     	add	x0, x1, x0
  8dbc18: f9400000     	ldr	x0, [x0]
  8dbc1c: 97f86be2     	bl	0x6f6ba4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x8b24>
  8dbc20: f90013e0     	str	x0, [sp, #0x20]
  8dbc24: f9400fe0     	ldr	x0, [sp, #0x18]
  8dbc28: f9400801     	ldr	x1, [x0, #0x10]
  8dbc2c: b94017e0     	ldr	w0, [sp, #0x14]
  8dbc30: d37df000     	lsl	x0, x0, #3
  8dbc34: 8b000020     	add	x0, x1, x0
  8dbc38: f9400000     	ldr	x0, [x0]
  8dbc3c: 91002000     	add	x0, x0, #0x8
  8dbc40: 97f1fe30     	bl	0x55b500 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x62450>
  8dbc44: 7100041f     	cmp	w0, #0x1
  8dbc48: 540000e0     	b.eq	0x8dbc64 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35438>
  8dbc4c: 7100081f     	cmp	w0, #0x2
  8dbc50: 54000360     	b.eq	0x8dbcbc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35490>
  8dbc54: 7100001f     	cmp	w0, #0x0
  8dbc58: 540005e1     	b.ne	0x8dbd14 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x354e8>
  8dbc5c: 52800020     	mov	w0, #0x1                // =1
  8dbc60: 1400002e     	b	0x8dbd18 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x354ec>
  8dbc64: f9400fe0     	ldr	x0, [sp, #0x18]
  8dbc68: f9400801     	ldr	x1, [x0, #0x10]
  8dbc6c: b94017e0     	ldr	w0, [sp, #0x14]
  8dbc70: d37df000     	lsl	x0, x0, #3
  8dbc74: 8b000020     	add	x0, x1, x0
  8dbc78: f9400000     	ldr	x0, [x0]
  8dbc7c: 9111a000     	add	x0, x0, #0x468
  8dbc80: 97ece33f     	bl	0x41497c <.text+0x974c>
  8dbc84: 12001c00     	and	w0, w0, #0xff
  8dbc88: 52000000     	eor	w0, w0, #0x1
  8dbc8c: 12001c00     	and	w0, w0, #0xff
  8dbc90: 7100001f     	cmp	w0, #0x0
  8dbc94: 54000060     	b.eq	0x8dbca0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35474>
  8dbc98: 52800000     	mov	w0, #0x0                // =0
  8dbc9c: 1400001f     	b	0x8dbd18 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x354ec>
  8dbca0: b9402fe0     	ldr	w0, [sp, #0x2c]
  8dbca4: 7100001f     	cmp	w0, #0x0
  8dbca8: 54000061     	b.ne	0x8dbcb4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35488>
  8dbcac: 52800000     	mov	w0, #0x0                // =0
  8dbcb0: 1400001a     	b	0x8dbd18 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x354ec>
  8dbcb4: 52800040     	mov	w0, #0x2                // =2
  8dbcb8: 14000018     	b	0x8dbd18 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x354ec>
  8dbcbc: f9400fe0     	ldr	x0, [sp, #0x18]
  8dbcc0: f9400801     	ldr	x1, [x0, #0x10]
  8dbcc4: b94017e0     	ldr	w0, [sp, #0x14]
  8dbcc8: d37df000     	lsl	x0, x0, #3
  8dbccc: 8b000020     	add	x0, x1, x0
  8dbcd0: f9400000     	ldr	x0, [x0]
  8dbcd4: 9111a000     	add	x0, x0, #0x468
  8dbcd8: 97ece329     	bl	0x41497c <.text+0x974c>
  8dbcdc: 12001c00     	and	w0, w0, #0xff
  8dbce0: 52000000     	eor	w0, w0, #0x1
  8dbce4: 12001c00     	and	w0, w0, #0xff
  8dbce8: 7100001f     	cmp	w0, #0x0
  8dbcec: 54000060     	b.eq	0x8dbcf8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x354cc>
  8dbcf0: 52800020     	mov	w0, #0x1                // =1
  8dbcf4: 14000009     	b	0x8dbd18 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x354ec>
  8dbcf8: b9402fe0     	ldr	w0, [sp, #0x2c]
  8dbcfc: 7100001f     	cmp	w0, #0x0
  8dbd00: 54000061     	b.ne	0x8dbd0c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x354e0>
  8dbd04: 52800020     	mov	w0, #0x1                // =1
  8dbd08: 14000004     	b	0x8dbd18 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x354ec>
  8dbd0c: 52800040     	mov	w0, #0x2                // =2
  8dbd10: 14000002     	b	0x8dbd18 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x354ec>
  8dbd14: 52800020     	mov	w0, #0x1                // =1
  8dbd18: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  8dbd1c: d65f03c0     	ret
