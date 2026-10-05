
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000006ee080 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_>:
  716e60: a9b37bfd     	stp	x29, x30, [sp, #-0xd0]!
  716e64: 910003fd     	mov	x29, sp
  716e68: f9000bf3     	str	x19, [sp, #0x10]
  716e6c: f90017e0     	str	x0, [sp, #0x28]
  716e70: f94017e0     	ldr	x0, [sp, #0x28]
  716e74: 39405000     	ldrb	w0, [x0, #0x14]
  716e78: 52000000     	eor	w0, w0, #0x1
  716e7c: 12001c00     	and	w0, w0, #0xff
  716e80: 7100001f     	cmp	w0, #0x0
  716e84: 54000400     	b.eq	0x716f04 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x28e84>
  716e88: b900cfff     	str	wzr, [sp, #0xcc]
  716e8c: f94017e0     	ldr	x0, [sp, #0x28]
  716e90: b9400801     	ldr	w1, [x0, #0x8]
  716e94: b940cfe0     	ldr	w0, [sp, #0xcc]
  716e98: 6b00003f     	cmp	w1, w0
  716e9c: 54000349     	b.ls	0x716f04 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x28e84>
  716ea0: f94017e0     	ldr	x0, [sp, #0x28]
  716ea4: f9400001     	ldr	x1, [x0]
  716ea8: b980cfe0     	ldrsw	x0, [sp, #0xcc]
  716eac: d37df000     	lsl	x0, x0, #3
  716eb0: 8b000020     	add	x0, x1, x0
  716eb4: f9400000     	ldr	x0, [x0]
  716eb8: 97fffead     	bl	0x71696c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x288ec>
  716ebc: aa0003e3     	mov	x3, x0
  716ec0: f9400060     	ldr	x0, [x3]
  716ec4: 91012000     	add	x0, x0, #0x48
  716ec8: f9400002     	ldr	x2, [x0]
  716ecc: 52800001     	mov	w1, #0x0                // =0
  716ed0: aa0303e0     	mov	x0, x3
  716ed4: d63f0040     	blr	x2
  716ed8: f94017e0     	ldr	x0, [sp, #0x28]
  716edc: f9400001     	ldr	x1, [x0]
  716ee0: b980cfe0     	ldrsw	x0, [sp, #0xcc]
  716ee4: d37df000     	lsl	x0, x0, #3
  716ee8: 8b000020     	add	x0, x1, x0
  716eec: f9400000     	ldr	x0, [x0]
  716ef0: 97fffeba     	bl	0x7169d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x28958>
  716ef4: b940cfe0     	ldr	w0, [sp, #0xcc]
  716ef8: 11000400     	add	w0, w0, #0x1
  716efc: b900cfe0     	str	w0, [sp, #0xcc]
  716f00: 17ffffe3     	b	0x716e8c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x28e0c>
  716f04: 39032fff     	strb	wzr, [sp, #0xcb]
  716f08: 39032fff     	strb	wzr, [sp, #0xcb]
  716f0c: b900c7ff     	str	wzr, [sp, #0xc4]
  716f10: f94017e0     	ldr	x0, [sp, #0x28]
  716f14: b9400801     	ldr	w1, [x0, #0x8]
  716f18: b940c7e0     	ldr	w0, [sp, #0xc4]
  716f1c: 6b00003f     	cmp	w1, w0
  716f20: 540006a9     	b.ls	0x716ff4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x28f74>
  716f24: f94017e0     	ldr	x0, [sp, #0x28]
  716f28: f9400001     	ldr	x1, [x0]
  716f2c: b980c7e0     	ldrsw	x0, [sp, #0xc4]
  716f30: d37df000     	lsl	x0, x0, #3
  716f34: 8b000020     	add	x0, x1, x0
  716f38: f9400000     	ldr	x0, [x0]
  716f3c: 97fffeb0     	bl	0x7169fc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2897c>
  716f40: 12001c00     	and	w0, w0, #0xff
  716f44: 52000000     	eor	w0, w0, #0x1
  716f48: 12001c00     	and	w0, w0, #0xff
  716f4c: 7100001f     	cmp	w0, #0x0
  716f50: 540004a0     	b.eq	0x716fe4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x28f64>
  716f54: 52800020     	mov	w0, #0x1                // =1
  716f58: 39032fe0     	strb	w0, [sp, #0xcb]
  716f5c: f94017e0     	ldr	x0, [sp, #0x28]
  716f60: f9400001     	ldr	x1, [x0]
  716f64: b980c7e0     	ldrsw	x0, [sp, #0xc4]
  716f68: d37df000     	lsl	x0, x0, #3
  716f6c: 8b000020     	add	x0, x1, x0
  716f70: f9400000     	ldr	x0, [x0]
  716f74: 97fffe7e     	bl	0x71696c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x288ec>
  716f78: 91002013     	add	x19, x0, #0x8
  716f7c: 97ffe6e4     	bl	0x710b0c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x22a8c>
  716f80: aa0003e1     	mov	x1, x0
  716f84: 9100e3e0     	add	x0, sp, #0x38
  716f88: aa0103e2     	mov	x2, x1
  716f8c: aa1303e1     	mov	x1, x19
  716f90: 97ffe565     	bl	0x710524 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x224a4>
  716f94: f94017e0     	ldr	x0, [sp, #0x28]
  716f98: f9400001     	ldr	x1, [x0]
  716f9c: b980c7e0     	ldrsw	x0, [sp, #0xc4]
  716fa0: d37df000     	lsl	x0, x0, #3
  716fa4: 8b000020     	add	x0, x1, x0
  716fa8: f9400000     	ldr	x0, [x0]
  716fac: 97fffe94     	bl	0x7169fc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2897c>
  716fb0: 12001c00     	and	w0, w0, #0xff
  716fb4: 52000000     	eor	w0, w0, #0x1
  716fb8: 12001c00     	and	w0, w0, #0xff
  716fbc: 7100001f     	cmp	w0, #0x0
  716fc0: 540000e0     	b.eq	0x716fdc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x28f5c>
  716fc4: 97ffe6d2     	bl	0x710b0c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x22a8c>
  716fc8: aa0003e2     	mov	x2, x0
  716fcc: 9100e3e0     	add	x0, sp, #0x38
  716fd0: aa0003e1     	mov	x1, x0
  716fd4: aa0203e0     	mov	x0, x2
  716fd8: 97f3eaf0     	bl	0x411b98 <.text+0x6968>
  716fdc: 9100e3e0     	add	x0, sp, #0x38
  716fe0: 97ffe58d     	bl	0x710614 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x22594>
  716fe4: b940c7e0     	ldr	w0, [sp, #0xc4]
  716fe8: 11000400     	add	w0, w0, #0x1
  716fec: b900c7e0     	str	w0, [sp, #0xc4]
  716ff0: 17ffffc8     	b	0x716f10 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x28e90>
  716ff4: 39432fe0     	ldrb	w0, [sp, #0xcb]
  716ff8: 7100001f     	cmp	w0, #0x0
  716ffc: 540000e0     	b.eq	0x717018 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x28f98>
  717000: 17ffffc2     	b	0x716f08 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x28e88>
  717004: aa0003f3     	mov	x19, x0
  717008: 9100e3e0     	add	x0, sp, #0x38
  71700c: 97ffe582     	bl	0x710614 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x22594>
  717010: aa1303e0     	mov	x0, x19
  717014: 97f3cdcf     	bl	0x40a750 <_Unwind_Resume@plt>
  717018: d503201f     	nop
  71701c: f9400bf3     	ldr	x19, [sp, #0x10]
  717020: a8cd7bfd     	ldp	x29, x30, [sp], #0xd0
