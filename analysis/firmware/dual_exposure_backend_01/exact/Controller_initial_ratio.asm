
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  793bf0: f8005061     	stur	x1, [x3, #0x5]
  793bf4: 97fdedc1     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  793bf8: f9506661     	ldr	x1, [x19, #0x20c8]
  793bfc: f9407682     	ldr	x2, [x20, #0xe8]
  793c00: aa0103e0     	mov	x0, x1
  793c04: f9400021     	ldr	x1, [x1]
  793c08: bd514040     	ldr	s0, [x2, #0x1140]
  793c0c: f9404021     	ldr	x1, [x1, #0x80]
  793c10: d63f0020     	blr	x1
  793c14: f9505a64     	ldr	x4, [x19, #0x20b0]
  793c18: 52800003     	mov	w3, #0x0                // =0
  793c1c: 52808f22     	mov	w2, #0x479              // =1145
  793c20: 52800001     	mov	w1, #0x0                // =0
  793c24: aa0403e0     	mov	x0, x4
