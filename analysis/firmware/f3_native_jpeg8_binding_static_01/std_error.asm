INPUT_SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
STATIC_ONLY_NEAREST_LABELS_NOT_AUTHORITATIVE

/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000009770a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm>:
  9a20f0: 52800fc8     	mov	w8, #0x7e               // =126
  9a20f4: 90000007     	adrp	x7, 0x9a2000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2af60>
  9a20f8: f0ffffe6     	adrp	x6, 0x9a1000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x29f60>
  9a20fc: 910300e7     	add	x7, x7, #0xc0
  9a2100: 913ce0c6     	add	x6, x6, #0xf38
  9a2104: 90000005     	adrp	x5, 0x9a2000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2af60>
  9a2108: f0ffffe4     	adrp	x4, 0x9a1000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x29f60>
  9a210c: 910220a5     	add	x5, x5, #0x88
  9a2110: 913ee084     	add	x4, x4, #0xfb8
  9a2114: f0ffffe3     	adrp	x3, 0x9a1000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x29f60>
  9a2118: d0002162     	adrp	x2, 0xdd0000
  9a211c: 913ea063     	add	x3, x3, #0xfa8
  9a2120: 91248042     	add	x2, x2, #0x920
  9a2124: a9001807     	stp	x7, x6, [x0]
  9a2128: a9011005     	stp	x5, x4, [x0, #0x10]
  9a212c: f9001003     	str	x3, [x0, #0x20]
  9a2130: b900281f     	str	wzr, [x0, #0x28]
  9a2134: b9007c1f     	str	wzr, [x0, #0x7c]
  9a2138: a908081f     	stp	xzr, x2, [x0, #0x80]
  9a213c: b9009008     	str	w8, [x0, #0x90]
  9a2140: a909fc1f     	stp	xzr, xzr, [x0, #0x98]
  9a2144: d65f03c0     	ret
