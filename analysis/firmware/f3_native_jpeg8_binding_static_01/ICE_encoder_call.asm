INPUT_SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
STATIC_ONLY_NEAREST_LABELS_NOT_AUTHORITATIVE

/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  7b8134: 9101a3e0     	add	x0, sp, #0x68
  7b8138: 52800021     	mov	w1, #0x1                // =1
  7b813c: 97fd4f35     	bl	0x70be10 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1dd90>
  7b8140: f94227e0     	ldr	x0, [sp, #0x448]
  7b8144: 52800141     	mov	w1, #0xa                // =10
  7b8148: b9000001     	str	w1, [x0]
  7b814c: f9402fe1     	ldr	x1, [sp, #0x58]
  7b8150: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b8154: 8b000020     	add	x0, x1, x0
  7b8158: f97c9414     	ldr	x20, [x0, #0x7928]
  7b815c: f9402fe1     	ldr	x1, [sp, #0x58]
  7b8160: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b8164: 8b000020     	add	x0, x1, x0
  7b8168: f97c9400     	ldr	x0, [x0, #0x7928]
  7b816c: f9400000     	ldr	x0, [x0]
  7b8170: 9100a000     	add	x0, x0, #0x28
  7b8174: f9400013     	ldr	x19, [x0]
  7b8178: 910383e0     	add	x0, sp, #0xe0
  7b817c: 94053093     	bl	0x9043c8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5db9c>
  7b8180: aa0003e1     	mov	x1, x0
  7b8184: b9860be0     	ldrsw	x0, [sp, #0x608]
  7b8188: 8b000035     	add	x21, x1, x0
  7b818c: f94227e0     	ldr	x0, [sp, #0x448]
  7b8190: b9400416     	ldr	w22, [x0, #0x4]
  7b8194: f94227e0     	ldr	x0, [sp, #0x448]
  7b8198: b9400817     	ldr	w23, [x0, #0x8]
  7b819c: b94477f8     	ldr	w24, [sp, #0x474]
  7b81a0: f94227e0     	ldr	x0, [sp, #0x448]
  7b81a4: f9400819     	ldr	x25, [x0, #0x10]
  7b81a8: b9442ffa     	ldr	w26, [sp, #0x42c]
  7b81ac: 910383e0     	add	x0, sp, #0xe0
  7b81b0: 940530ae     	bl	0x904468 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc3c>
  7b81b4: 2a0003e7     	mov	w7, w0
  7b81b8: 2a1a03e6     	mov	w6, w26
  7b81bc: aa1903e5     	mov	x5, x25
  7b81c0: 2a1803e4     	mov	w4, w24
  7b81c4: 2a1703e3     	mov	w3, w23
  7b81c8: 2a1603e2     	mov	w2, w22
  7b81cc: aa1503e1     	mov	x1, x21
  7b81d0: aa1403e0     	mov	x0, x20
  7b81d4: d63f0260     	blr	x19
  7b81d8: b90433e0     	str	w0, [sp, #0x430]
