  4e58b8: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  4e58bc: 910003fd     	mov	x29, sp
  4e58c0: a90153f3     	stp	x19, x20, [sp, #0x10]
  4e58c4: f90017e0     	str	x0, [sp, #0x28]
  4e58c8: f90013e1     	str	x1, [sp, #0x20]
  4e58cc: f94017e0     	ldr	x0, [sp, #0x28]
  4e58d0: 91006014     	add	x20, x0, #0x18
  4e58d4: d2800400     	mov	x0, #0x20               // =32
  4e58d8: 97fc9162     	bl	0x409e60 <_Znwm@plt>
  4e58dc: aa0003f3     	mov	x19, x0
  4e58e0: f94013e1     	ldr	x1, [sp, #0x20]
  4e58e4: aa1303e0     	mov	x0, x19
  4e58e8: 94000271     	bl	0x4e62ac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb0300>
  4e58ec: aa1303e1     	mov	x1, x19
  4e58f0: aa1403e0     	mov	x0, x20
  4e58f4: 9400027e     	bl	0x4e62ec <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb0340>
  4e58f8: f94013e0     	ldr	x0, [sp, #0x20]
  4e58fc: f9400000     	ldr	x0, [x0]
  4e5900: 9101c000     	add	x0, x0, #0x70
  4e5904: f9400001     	ldr	x1, [x0]
  4e5908: f94013e0     	ldr	x0, [sp, #0x20]
  4e590c: d63f0020     	blr	x1
  4e5910: f9001fe0     	str	x0, [sp, #0x38]
  4e5914: f9401fe0     	ldr	x0, [sp, #0x38]
  4e5918: f100001f     	cmp	x0, #0x0
  4e591c: 54000140     	b.eq	0x4e5944 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf998>
  4e5920: d2800700     	mov	x0, #0x38               // =56
  4e5924: 97fc914f     	bl	0x409e60 <_Znwm@plt>
  4e5928: aa0003f3     	mov	x19, x0
  4e592c: f94017e0     	ldr	x0, [sp, #0x28]
  4e5930: 91018000     	add	x0, x0, #0x60
  4e5934: aa0003e2     	mov	x2, x0
  4e5938: f9401fe1     	ldr	x1, [sp, #0x38]
  4e593c: aa1303e0     	mov	x0, x19
  4e5940: 940001e5     	bl	0x4e60d4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb0128>
  4e5944: f94017e0     	ldr	x0, [sp, #0x28]
  4e5948: 91018000     	add	x0, x0, #0x60
  4e594c: 9408a66b     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  4e5950: 1400000d     	b	0x4e5984 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf9d8>
  4e5954: aa0003f4     	mov	x20, x0
  4e5958: d2800401     	mov	x1, #0x20               // =32
  4e595c: aa1303e0     	mov	x0, x19
  4e5960: 97fc9120     	bl	0x409de0 <_ZdlPvm@plt>
  4e5964: aa1403e0     	mov	x0, x20
  4e5968: 97fc937a     	bl	0x40a750 <_Unwind_Resume@plt>
  4e596c: aa0003f4     	mov	x20, x0
  4e5970: d2800701     	mov	x1, #0x38               // =56
  4e5974: aa1303e0     	mov	x0, x19
  4e5978: 97fc911a     	bl	0x409de0 <_ZdlPvm@plt>
  4e597c: aa1403e0     	mov	x0, x20
  4e5980: 97fc9374     	bl	0x40a750 <_Unwind_Resume@plt>
  4e5984: a94153f3     	ldp	x19, x20, [sp, #0x10]
  4e5988: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  4e598c: d65f03c0     	ret
