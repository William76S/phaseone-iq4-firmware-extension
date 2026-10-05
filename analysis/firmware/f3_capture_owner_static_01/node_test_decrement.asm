  8c2668: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c266c: 910003fd     	mov	x29, sp
  8c2670: f9000fe0     	str	x0, [sp, #0x18]
  8c2674: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2678: f9404400     	ldr	x0, [x0, #0x88]
  8c267c: f100001f     	cmp	x0, #0x0
  8c2680: 54000141     	b.ne	0x8c26a8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1be7c>
  8c2684: 52800f83     	mov	w3, #0x7c               // =124
  8c2688: b0002780     	adrp	x0, 0xdb3000
  8c268c: 913aa002     	add	x2, x0, #0xea8
  8c2690: b0002780     	adrp	x0, 0xdb3000
  8c2694: 913e6001     	add	x1, x0, #0xf98
  8c2698: b0002780     	adrp	x0, 0xdb3000
  8c269c: 913b8000     	add	x0, x0, #0xee0
  8c26a0: 97ed1fb8     	bl	0x40a580 <printf@plt>
  8c26a4: 97faa819     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c26a8: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c26ac: 9109a000     	add	x0, x0, #0x268
  8c26b0: f9400000     	ldr	x0, [x0]
  8c26b4: f9416c02     	ldr	x2, [x0, #0x2d8]
  8c26b8: f9400fe0     	ldr	x0, [sp, #0x18]
  8c26bc: f9404400     	ldr	x0, [x0, #0x88]
  8c26c0: aa0003e1     	mov	x1, x0
  8c26c4: aa0203e0     	mov	x0, x2
  8c26c8: 97f8b8b0     	bl	0x6f0988 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2908>
  8c26cc: d503201f     	nop
  8c26d0: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c26d4: d65f03c0     	ret
