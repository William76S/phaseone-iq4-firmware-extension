
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

000000000040b230 <.text>:
  422a14: aa0003f3     	mov	x19, x0
  422a18: f9430fe0     	ldr	x0, [sp, #0x618]
  422a1c: f9437be1     	ldr	x1, [sp, #0x6f0]
  422a20: f94a83e7     	ldr	x7, [sp, #0x1500]
  422a24: f94eabe6     	ldr	x6, [sp, #0x1d50]
  422a28: f94e4fe5     	ldr	x5, [sp, #0x1c98]
  422a2c: aa0103e4     	mov	x4, x1
  422a30: f94a7be3     	ldr	x3, [sp, #0x14f0]
  422a34: aa1403e2     	mov	x2, x20
  422a38: aa0003e1     	mov	x1, x0
  422a3c: aa1303e0     	mov	x0, x19
  422a40: 940e00eb     	bl	0x7a2dec <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x890c0>
  422a44: f90987f3     	str	x19, [sp, #0x1308]
  422a48: 528000e0     	mov	w0, #0x7                // =7
  422a4c: b90a4be0     	str	w0, [sp, #0xa48]
  422a50: f94987e0     	ldr	x0, [sp, #0x1308]
  422a54: f9052be0     	str	x0, [sp, #0xa50]
  422a58: 912923e0     	add	x0, sp, #0xa48
  422a5c: aa0003e1     	mov	x1, x0
  422a60: f9498be0     	ldr	x0, [sp, #0x1310]
  422a64: 940040d7     	bl	0x432dc0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6lengthEv+0x1678>
  422a68: d2801700     	mov	x0, #0xb8               // =184
  422a6c: 97ff9cfd     	bl	0x409e60 <_Znwm@plt>
  422a70: aa0003f3     	mov	x19, x0
  422a74: f0002e80     	adrp	x0, 0x9f5000
  422a78: 911cc001     	add	x1, x0, #0x730
  422a7c: aa1303e0     	mov	x0, x19
  422a80: 940bb1ab     	bl	0x70f12c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x210ac>
  422a84: f90983f3     	str	x19, [sp, #0x1300]
  422a88: f9430fe0     	ldr	x0, [sp, #0x618]
  422a8c: 94003437     	bl	0x42fb68 <.text+0x24938>
  422a90: aa0003f4     	mov	x20, x0
  422a94: f9430fe0     	ldr	x0, [sp, #0x618]
  422a98: 9400342e     	bl	0x42fb50 <.text+0x24920>
  422a9c: aa0003f5     	mov	x21, x0
  422aa0: f9430fe0     	ldr	x0, [sp, #0x618]
  422aa4: 9400341f     	bl	0x42fb20 <.text+0x248f0>
  422aa8: aa0003f6     	mov	x22, x0
  422aac: f9430fe0     	ldr	x0, [sp, #0x618]
  422ab0: 94003464     	bl	0x42fc40 <.text+0x24a10>
