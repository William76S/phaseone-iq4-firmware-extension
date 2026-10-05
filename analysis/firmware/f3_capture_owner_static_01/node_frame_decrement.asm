  8c27e0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c27e4: 910003fd     	mov	x29, sp
  8c27e8: f9000fe0     	str	x0, [sp, #0x18]
  8c27ec: f9400fe0     	ldr	x0, [sp, #0x18]
  8c27f0: f9404800     	ldr	x0, [x0, #0x90]
  8c27f4: f100001f     	cmp	x0, #0x0
  8c27f8: 54000141     	b.ne	0x8c2820 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bff4>
  8c27fc: 52801323     	mov	w3, #0x99               // =153
  8c2800: b0002780     	adrp	x0, 0xdb3000
  8c2804: 913aa002     	add	x2, x0, #0xea8
  8c2808: b0002780     	adrp	x0, 0xdb3000
  8c280c: 913ea001     	add	x1, x0, #0xfa8
  8c2810: b0002780     	adrp	x0, 0xdb3000
  8c2814: 913b8000     	add	x0, x0, #0xee0
  8c2818: 97ed1f5a     	bl	0x40a580 <printf@plt>
  8c281c: 97faa7bb     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c2820: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c2824: 9109a000     	add	x0, x0, #0x268
  8c2828: f9400000     	ldr	x0, [x0]
  8c282c: f9417002     	ldr	x2, [x0, #0x2e0]
  8c2830: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2834: f9404800     	ldr	x0, [x0, #0x90]
  8c2838: aa0003e1     	mov	x1, x0
  8c283c: aa0203e0     	mov	x0, x2
  8c2840: 9400040f     	bl	0x8c387c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d050>
  8c2844: d503201f     	nop
  8c2848: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c284c: d65f03c0     	ret
