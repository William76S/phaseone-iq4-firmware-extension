  8c25c0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c25c4: 910003fd     	mov	x29, sp
  8c25c8: f9000fe0     	str	x0, [sp, #0x18]
  8c25cc: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c25d0: 9109a000     	add	x0, x0, #0x268
  8c25d4: f9400000     	ldr	x0, [x0]
  8c25d8: f9416c02     	ldr	x2, [x0, #0x2d8]
  8c25dc: f9400fe0     	ldr	x0, [sp, #0x18]
  8c25e0: f9404400     	ldr	x0, [x0, #0x88]
  8c25e4: aa0003e1     	mov	x1, x0
  8c25e8: aa0203e0     	mov	x0, x2
  8c25ec: 97f8b878     	bl	0x6f07cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x274c>
  8c25f0: aa0003e1     	mov	x1, x0
  8c25f4: f9400fe0     	ldr	x0, [sp, #0x18]
  8c25f8: f9004401     	str	x1, [x0, #0x88]
  8c25fc: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2600: f9404400     	ldr	x0, [x0, #0x88]
  8c2604: f100001f     	cmp	x0, #0x0
  8c2608: 54000061     	b.ne	0x8c2614 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bde8>
  8c260c: d2800000     	mov	x0, #0x0                // =0
  8c2610: 14000014     	b	0x8c2660 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1be34>
  8c2614: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2618: f9404400     	ldr	x0, [x0, #0x88]
  8c261c: f100001f     	cmp	x0, #0x0
  8c2620: 54000141     	b.ne	0x8c2648 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1be1c>
  8c2624: 52800e43     	mov	w3, #0x72               // =114
  8c2628: b0002780     	adrp	x0, 0xdb3000
  8c262c: 913aa002     	add	x2, x0, #0xea8
  8c2630: b0002780     	adrp	x0, 0xdb3000
  8c2634: 913e6001     	add	x1, x0, #0xf98
  8c2638: b0002780     	adrp	x0, 0xdb3000
  8c263c: 913b8000     	add	x0, x0, #0xee0
  8c2640: 97ed1fd0     	bl	0x40a580 <printf@plt>
  8c2644: 97faa831     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c2648: f9400fe0     	ldr	x0, [sp, #0x18]
  8c264c: f9404400     	ldr	x0, [x0, #0x88]
  8c2650: f9400fe1     	ldr	x1, [sp, #0x18]
  8c2654: f9000801     	str	x1, [x0, #0x10]
  8c2658: f9400fe0     	ldr	x0, [sp, #0x18]
  8c265c: f9404400     	ldr	x0, [x0, #0x88]
  8c2660: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c2664: d65f03c0     	ret
