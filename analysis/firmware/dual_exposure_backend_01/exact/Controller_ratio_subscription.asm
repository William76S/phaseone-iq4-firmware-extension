
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  79954c: aa1303e2     	mov	x2, x19
  799550: 97fddbf5     	bl	0x710524 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x224a4>
  799554: d2801100     	mov	x0, #0x88               // =136
  799558: 97f1c242     	bl	0x409e60 <_Znwm@plt>
  79955c: f9407681     	ldr	x1, [x20, #0xe8]
  799560: d2821103     	mov	x3, #0x1088             // =4232
  799564: aa0003f8     	mov	x24, x0
  799568: aa1303e2     	mov	x2, x19
  79956c: 8b030021     	add	x1, x1, x3
  799570: 97fddbed     	bl	0x710524 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x224a4>
  799574: d2800021     	mov	x1, #0x1                // =1
  799578: a90bfe9f     	stp	xzr, xzr, [x20, #0xb8]
