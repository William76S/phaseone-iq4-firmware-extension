  5b5478: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  5b547c: 910003fd     	mov	x29, sp
  5b5480: f9000bf3     	str	x19, [sp, #0x10]
  5b5484: f9001fe0     	str	x0, [sp, #0x38]
  5b5488: f9001be1     	str	x1, [sp, #0x30]
  5b548c: b9002fe2     	str	w2, [sp, #0x2c]
  5b5490: b9002be3     	str	w3, [sp, #0x28]
  5b5494: f9401fe0     	ldr	x0, [sp, #0x38]
  5b5498: 97ffffd6     	bl	0x5b53f0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xbc340>
  5b549c: f9401fe0     	ldr	x0, [sp, #0x38]
  5b54a0: 91002000     	add	x0, x0, #0x8
  5b54a4: f9401be1     	ldr	x1, [sp, #0x30]
  5b54a8: 94056721     	bl	0x70f12c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x210ac>
  5b54ac: 90003040     	adrp	x0, 0xbbd000
  5b54b0: 9108a001     	add	x1, x0, #0x228
  5b54b4: f9401fe0     	ldr	x0, [sp, #0x38]
  5b54b8: f9000001     	str	x1, [x0]
  5b54bc: 90003040     	adrp	x0, 0xbbd000
  5b54c0: 910b4001     	add	x1, x0, #0x2d0
  5b54c4: f9401fe0     	ldr	x0, [sp, #0x38]
  5b54c8: f9000401     	str	x1, [x0, #0x8]
  5b54cc: 90003040     	adrp	x0, 0xbbd000
  5b54d0: 910c4001     	add	x1, x0, #0x310
  5b54d4: f9401fe0     	ldr	x0, [sp, #0x38]
  5b54d8: f9001001     	str	x1, [x0, #0x20]
  5b54dc: f9401fe0     	ldr	x0, [sp, #0x38]
  5b54e0: b9402fe1     	ldr	w1, [sp, #0x2c]
  5b54e4: b900c001     	str	w1, [x0, #0xc0]
  5b54e8: f9401fe0     	ldr	x0, [sp, #0x38]
  5b54ec: b9402fe1     	ldr	w1, [sp, #0x2c]
  5b54f0: b900c401     	str	w1, [x0, #0xc4]
  5b54f4: f9401fe0     	ldr	x0, [sp, #0x38]
  5b54f8: b9402be1     	ldr	w1, [sp, #0x28]
  5b54fc: b900c801     	str	w1, [x0, #0xc8]
  5b5500: f9401fe0     	ldr	x0, [sp, #0x38]
  5b5504: f900681f     	str	xzr, [x0, #0xd0]
  5b5508: f9401fe0     	ldr	x0, [sp, #0x38]
  5b550c: f9006c1f     	str	xzr, [x0, #0xd8]
  5b5510: f9401fe0     	ldr	x0, [sp, #0x38]
  5b5514: 52800061     	mov	w1, #0x3                // =3
  5b5518: b9001801     	str	w1, [x0, #0x18]
  5b551c: 14000006     	b	0x5b5534 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xbc484>
  5b5520: aa0003f3     	mov	x19, x0
  5b5524: f9401fe0     	ldr	x0, [sp, #0x38]
  5b5528: 97ffffbe     	bl	0x5b5420 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xbc370>
  5b552c: aa1303e0     	mov	x0, x19
  5b5530: 97f95488     	bl	0x40a750 <_Unwind_Resume@plt>
  5b5534: f9400bf3     	ldr	x19, [sp, #0x10]
  5b5538: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  5b553c: d65f03c0     	ret
