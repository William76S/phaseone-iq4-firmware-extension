
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000008a682c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_>:
  8c82c0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  8c82c4: 910003fd     	mov	x29, sp
  8c82c8: f9000bf3     	str	x19, [sp, #0x10]
  8c82cc: f90017e0     	str	x0, [sp, #0x28]
  8c82d0: f94017e0     	ldr	x0, [sp, #0x28]
  8c82d4: 91008001     	add	x1, x0, #0x20
  8c82d8: 9100e3e0     	add	x0, sp, #0x38
  8c82dc: 97ed2639     	bl	0x411bc0 <.text+0x6990>
  8c82e0: f94017e0     	ldr	x0, [sp, #0x28]
  8c82e4: 9400006b     	bl	0x8c8490 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x21c64>
  8c82e8: aa0003f3     	mov	x19, x0
  8c82ec: d503201f     	nop
  8c82f0: 9100e3e0     	add	x0, sp, #0x38
  8c82f4: 97ed2640     	bl	0x411bf4 <.text+0x69c4>
  8c82f8: aa1303e0     	mov	x0, x19
  8c82fc: f9400bf3     	ldr	x19, [sp, #0x10]
  8c8300: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  8c8304: d65f03c0     	ret
  8c8308: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  8c830c: 910003fd     	mov	x29, sp
  8c8310: f9000bf3     	str	x19, [sp, #0x10]
  8c8314: f90017e0     	str	x0, [sp, #0x28]
  8c8318: f90013e1     	str	x1, [sp, #0x20]
  8c831c: f94013e0     	ldr	x0, [sp, #0x20]
  8c8320: f100001f     	cmp	x0, #0x0
  8c8324: 54000061     	b.ne	0x8c8330 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x21b04>
  8c8328: 52800013     	mov	w19, #0x0               // =0
  8c832c: 1400003d     	b	0x8c8420 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x21bf4>
  8c8330: f94017e0     	ldr	x0, [sp, #0x28]
  8c8334: 91008001     	add	x1, x0, #0x20
  8c8338: 9100c3e0     	add	x0, sp, #0x30
  8c833c: 97ed2621     	bl	0x411bc0 <.text+0x6990>
  8c8340: f94017e0     	ldr	x0, [sp, #0x28]
  8c8344: f94013e1     	ldr	x1, [sp, #0x20]
  8c8348: 94000058     	bl	0x8c84a8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x21c7c>
  8c834c: 3900ffe0     	strb	w0, [sp, #0x3f]
  8c8350: 3940ffe0     	ldrb	w0, [sp, #0x3f]
  8c8354: 7100001f     	cmp	w0, #0x0
  8c8358: 540005e0     	b.eq	0x8c8414 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x21be8>
  8c835c: f94017e0     	ldr	x0, [sp, #0x28]
  8c8360: b9407800     	ldr	w0, [x0, #0x78]
  8c8364: 7100041f     	cmp	w0, #0x1
  8c8368: 54000161     	b.ne	0x8c8394 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x21b68>
  8c836c: f94017e0     	ldr	x0, [sp, #0x28]
  8c8370: 97ef348d     	bl	0x4955a4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f5f8>
  8c8374: 12001c00     	and	w0, w0, #0xff
  8c8378: 52000000     	eor	w0, w0, #0x1
  8c837c: 12001c00     	and	w0, w0, #0xff
