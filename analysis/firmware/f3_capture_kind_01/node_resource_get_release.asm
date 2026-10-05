
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000008a682c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_>:
  8c253c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c2540: 910003fd     	mov	x29, sp
  8c2544: f9000fe0     	str	x0, [sp, #0x18]
  8c2548: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c254c: 9109a000     	add	x0, x0, #0x268
  8c2550: f9400000     	ldr	x0, [x0]
  8c2554: f9400fe1     	ldr	x1, [sp, #0x18]
  8c2558: 94000c86     	bl	0x8c5770 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1ef44>
  8c255c: d503201f     	nop
  8c2560: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c2564: d65f03c0     	ret
  8c2568: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c256c: 910003fd     	mov	x29, sp
  8c2570: f9000fe0     	str	x0, [sp, #0x18]
  8c2574: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c2578: 9109a000     	add	x0, x0, #0x268
  8c257c: f9400000     	ldr	x0, [x0]
  8c2580: f9400fe1     	ldr	x1, [sp, #0x18]
  8c2584: 94000c85     	bl	0x8c5798 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1ef6c>
  8c2588: d503201f     	nop
  8c258c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c2590: d65f03c0     	ret
  8c2594: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c2598: 910003fd     	mov	x29, sp
  8c259c: f9000fe0     	str	x0, [sp, #0x18]
  8c25a0: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c25a4: 9109a000     	add	x0, x0, #0x268
  8c25a8: f9400000     	ldr	x0, [x0]
  8c25ac: f9400fe1     	ldr	x1, [sp, #0x18]
  8c25b0: 94000c85     	bl	0x8c57c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1ef98>
  8c25b4: d503201f     	nop
  8c25b8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c25bc: d65f03c0     	ret
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
  8c26d8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c26dc: 910003fd     	mov	x29, sp
  8c26e0: f9000fe0     	str	x0, [sp, #0x18]
  8c26e4: f9400fe0     	ldr	x0, [sp, #0x18]
  8c26e8: f9404400     	ldr	x0, [x0, #0x88]
  8c26ec: f100001f     	cmp	x0, #0x0
  8c26f0: 54000141     	b.ne	0x8c2718 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1beec>
  8c26f4: 52801083     	mov	w3, #0x84               // =132
  8c26f8: b0002780     	adrp	x0, 0xdb3000
  8c26fc: 913aa002     	add	x2, x0, #0xea8
  8c2700: b0002780     	adrp	x0, 0xdb3000
  8c2704: 913e6001     	add	x1, x0, #0xf98
  8c2708: b0002780     	adrp	x0, 0xdb3000
  8c270c: 913b8000     	add	x0, x0, #0xee0
  8c2710: 97ed1f9c     	bl	0x40a580 <printf@plt>
  8c2714: 97faa7fd     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c2718: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c271c: 9109a000     	add	x0, x0, #0x268
  8c2720: f9400000     	ldr	x0, [x0]
  8c2724: f9416c02     	ldr	x2, [x0, #0x2d8]
  8c2728: f9400fe0     	ldr	x0, [sp, #0x18]
  8c272c: f9404400     	ldr	x0, [x0, #0x88]
  8c2730: aa0003e1     	mov	x1, x0
  8c2734: aa0203e0     	mov	x0, x2
  8c2738: 97f8b8d9     	bl	0x6f0a9c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2a1c>
  8c273c: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2740: f900441f     	str	xzr, [x0, #0x88]
  8c2744: d503201f     	nop
  8c2748: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c274c: d65f03c0     	ret
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
