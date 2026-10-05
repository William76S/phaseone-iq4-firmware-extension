  8c2750: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c2754: 910003fd     	mov	x29, sp
  8c2758: f9000fe0     	str	x0, [sp, #0x18]
  8c275c: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c2760: 9109a000     	add	x0, x0, #0x268
  8c2764: f9400000     	ldr	x0, [x0]
  8c2768: f9417002     	ldr	x2, [x0, #0x2e0]
  8c276c: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2770: f9404800     	ldr	x0, [x0, #0x90]
  8c2774: aa0003e1     	mov	x1, x0
  8c2778: aa0203e0     	mov	x0, x2
  8c277c: 940003d1     	bl	0x8c36c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1ce94>
  8c2780: aa0003e1     	mov	x1, x0
  8c2784: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2788: f9004801     	str	x1, [x0, #0x90]
  8c278c: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2790: f9404800     	ldr	x0, [x0, #0x90]
  8c2794: f100001f     	cmp	x0, #0x0
  8c2798: 54000141     	b.ne	0x8c27c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bf94>
  8c279c: 52801203     	mov	w3, #0x90               // =144
  8c27a0: b0002780     	adrp	x0, 0xdb3000
  8c27a4: 913aa002     	add	x2, x0, #0xea8
  8c27a8: b0002780     	adrp	x0, 0xdb3000
  8c27ac: 913ea001     	add	x1, x0, #0xfa8
  8c27b0: b0002780     	adrp	x0, 0xdb3000
  8c27b4: 913b8000     	add	x0, x0, #0xee0
  8c27b8: 97ed1f72     	bl	0x40a580 <printf@plt>
  8c27bc: 97faa7d3     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c27c0: f9400fe0     	ldr	x0, [sp, #0x18]
  8c27c4: f9404800     	ldr	x0, [x0, #0x90]
  8c27c8: f9400fe1     	ldr	x1, [sp, #0x18]
  8c27cc: f9000801     	str	x1, [x0, #0x10]
  8c27d0: f9400fe0     	ldr	x0, [sp, #0x18]
  8c27d4: f9404800     	ldr	x0, [x0, #0x90]
  8c27d8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c27dc: d65f03c0     	ret
