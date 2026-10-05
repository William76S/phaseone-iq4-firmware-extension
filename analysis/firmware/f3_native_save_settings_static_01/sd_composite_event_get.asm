  495448: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  49544c: 910003fd     	mov	x29, sp
  495450: f9000fe0     	str	x0, [sp, #0x18]
  495454: 910083e0     	add	x0, sp, #0x20
  495458: 97fddbae     	bl	0x40c310 <.text+0x10e0>
  49545c: f9400fe0     	ldr	x0, [sp, #0x18]
  495460: b940c000     	ldr	w0, [x0, #0xc0]
  495464: b9002fe0     	str	w0, [sp, #0x2c]
  495468: 910083e0     	add	x0, sp, #0x20
  49546c: 97fddbb5     	bl	0x40c340 <.text+0x1110>
  495470: b9402fe0     	ldr	w0, [sp, #0x2c]
  495474: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  495478: d65f03c0     	ret
  49547c: d10043ff     	sub	sp, sp, #0x10
  495480: f90007e0     	str	x0, [sp, #0x8]
  495484: f94007e0     	ldr	x0, [sp, #0x8]
  495488: 91002000     	add	x0, x0, #0x8
  49548c: 910043ff     	add	sp, sp, #0x10
  495490: d65f03c0     	ret
  495494: d1002000     	sub	x0, x0, #0x8
  495498: 17fffff9     	b	0x49547c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f4d0>
  49549c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
