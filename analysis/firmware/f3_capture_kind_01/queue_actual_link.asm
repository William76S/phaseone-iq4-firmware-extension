
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000008a682c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_>:
  8c7804: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c7808: 910003fd     	mov	x29, sp
  8c780c: f9000fe0     	str	x0, [sp, #0x18]
  8c7810: f9000be1     	str	x1, [sp, #0x10]
  8c7814: f9400be0     	ldr	x0, [sp, #0x10]
  8c7818: f100001f     	cmp	x0, #0x0
  8c781c: 54000181     	b.ne	0x8c784c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x21020>
  8c7820: 52800e83     	mov	w3, #0x74               // =116
  8c7824: b0002760     	adrp	x0, 0xdb4000
  8c7828: 9122e002     	add	x2, x0, #0x8b8
  8c782c: b0002760     	adrp	x0, 0xdb4000
  8c7830: 91236001     	add	x1, x0, #0x8d8
  8c7834: b0002760     	adrp	x0, 0xdb4000
  8c7838: 91152000     	add	x0, x0, #0x548
  8c783c: 97ed0b51     	bl	0x40a580 <printf@plt>
  8c7840: 97fa93b2     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c7844: 52800000     	mov	w0, #0x0                // =0
  8c7848: 14000028     	b	0x8c78e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x210bc>
  8c784c: f9400be0     	ldr	x0, [sp, #0x10]
  8c7850: f9400000     	ldr	x0, [x0]
  8c7854: f100001f     	cmp	x0, #0x0
  8c7858: 54000180     	b.eq	0x8c7888 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x2105c>
  8c785c: b0002760     	adrp	x0, 0xdb4000
  8c7860: 9124e004     	add	x4, x0, #0x938
  8c7864: b0002760     	adrp	x0, 0xdb4000
  8c7868: 91238003     	add	x3, x0, #0x8e0
  8c786c: 52800f42     	mov	w2, #0x7a               // =122
  8c7870: b0002760     	adrp	x0, 0xdb4000
  8c7874: 9122e001     	add	x1, x0, #0x8b8
  8c7878: 52800080     	mov	w0, #0x4                // =4
  8c787c: 97f9fb34     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8c7880: 52800000     	mov	w0, #0x0                // =0
  8c7884: 14000019     	b	0x8c78e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x210bc>
  8c7888: f9400fe0     	ldr	x0, [sp, #0x18]
  8c788c: f9400800     	ldr	x0, [x0, #0x10]
  8c7890: f100001f     	cmp	x0, #0x0
  8c7894: 54000120     	b.eq	0x8c78b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x2108c>
  8c7898: f9400fe0     	ldr	x0, [sp, #0x18]
  8c789c: f9400400     	ldr	x0, [x0, #0x8]
  8c78a0: f100001f     	cmp	x0, #0x0
  8c78a4: 540000a0     	b.eq	0x8c78b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x2108c>
  8c78a8: f9400fe0     	ldr	x0, [sp, #0x18]
  8c78ac: f9400800     	ldr	x0, [x0, #0x10]
  8c78b0: f9400be1     	ldr	x1, [sp, #0x10]
  8c78b4: f9000001     	str	x1, [x0]
  8c78b8: f9400fe0     	ldr	x0, [sp, #0x18]
  8c78bc: f9400be1     	ldr	x1, [sp, #0x10]
  8c78c0: f9000801     	str	x1, [x0, #0x10]
  8c78c4: f9400fe0     	ldr	x0, [sp, #0x18]
  8c78c8: f9400400     	ldr	x0, [x0, #0x8]
  8c78cc: f100001f     	cmp	x0, #0x0
  8c78d0: 540000a1     	b.ne	0x8c78e4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x210b8>
  8c78d4: f9400fe0     	ldr	x0, [sp, #0x18]
  8c78d8: f9400801     	ldr	x1, [x0, #0x10]
  8c78dc: f9400fe0     	ldr	x0, [sp, #0x18]
  8c78e0: f9000401     	str	x1, [x0, #0x8]
  8c78e4: 52800020     	mov	w0, #0x1                // =1
  8c78e8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c78ec: d65f03c0     	ret
