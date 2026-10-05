  8c2850: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c2854: 910003fd     	mov	x29, sp
  8c2858: f9000fe0     	str	x0, [sp, #0x18]
  8c285c: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2860: f9404800     	ldr	x0, [x0, #0x90]
  8c2864: f100001f     	cmp	x0, #0x0
  8c2868: 54000141     	b.ne	0x8c2890 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1c064>
  8c286c: 52801403     	mov	w3, #0xa0               // =160
  8c2870: b0002780     	adrp	x0, 0xdb3000
  8c2874: 913aa002     	add	x2, x0, #0xea8
  8c2878: b0002780     	adrp	x0, 0xdb3000
  8c287c: 913ea001     	add	x1, x0, #0xfa8
  8c2880: b0002780     	adrp	x0, 0xdb3000
  8c2884: 913b8000     	add	x0, x0, #0xee0
  8c2888: 97ed1f3e     	bl	0x40a580 <printf@plt>
  8c288c: 97faa79f     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c2890: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c2894: 9109a000     	add	x0, x0, #0x268
  8c2898: f9400000     	ldr	x0, [x0]
  8c289c: f9417002     	ldr	x2, [x0, #0x2e0]
  8c28a0: f9400fe0     	ldr	x0, [sp, #0x18]
  8c28a4: f9404800     	ldr	x0, [x0, #0x90]
  8c28a8: aa0003e1     	mov	x1, x0
  8c28ac: aa0203e0     	mov	x0, x2
  8c28b0: 94000438     	bl	0x8c3990 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d164>
  8c28b4: f9400fe0     	ldr	x0, [sp, #0x18]
  8c28b8: f900481f     	str	xzr, [x0, #0x90]
  8c28bc: d503201f     	nop
  8c28c0: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c28c4: d65f03c0     	ret
