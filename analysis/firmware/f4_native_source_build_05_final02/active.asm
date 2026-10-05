
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000006ee080 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_>:
  712000: f0004200     	adrp	x0, 0xf55000
  712004: 910ea000     	add	x0, x0, #0x3a8
  712008: f9400000     	ldr	x0, [x0]
  71200c: f100001f     	cmp	x0, #0x0
  712010: 1a9f07e0     	cset	w0, ne
  712014: 12001c00     	and	w0, w0, #0xff
  712018: d65f03c0     	ret
