
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  7a2dec: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
  7a2df0: 910003fd     	mov	x29, sp
  7a2df4: f90027e0     	str	x0, [sp, #0x48]
  7a2df8: f90023e1     	str	x1, [sp, #0x40]
  7a2dfc: f9001fe2     	str	x2, [sp, #0x38]
  7a2e00: f9001be3     	str	x3, [sp, #0x30]
  7a2e04: f90017e4     	str	x4, [sp, #0x28]
  7a2e08: f90013e5     	str	x5, [sp, #0x20]
  7a2e0c: f9000fe6     	str	x6, [sp, #0x18]
  7a2e10: f9000be7     	str	x7, [sp, #0x10]
  7a2e14: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e18: 97fffaae     	bl	0x7a18d0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87ba4>
  7a2e1c: f0002e80     	adrp	x0, 0xd75000
  7a2e20: 91168001     	add	x1, x0, #0x5a0
  7a2e24: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e28: f9000001     	str	x1, [x0]
  7a2e2c: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e30: f94023e1     	ldr	x1, [sp, #0x40]
  7a2e34: f9000801     	str	x1, [x0, #0x10]
  7a2e38: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e3c: f9401be1     	ldr	x1, [sp, #0x30]
  7a2e40: f9000c01     	str	x1, [x0, #0x18]
  7a2e44: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e48: f94017e1     	ldr	x1, [sp, #0x28]
  7a2e4c: f9001001     	str	x1, [x0, #0x20]
  7a2e50: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e54: f9400be1     	ldr	x1, [sp, #0x10]
  7a2e58: f9001401     	str	x1, [x0, #0x28]
  7a2e5c: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e60: f9400fe1     	ldr	x1, [sp, #0x18]
  7a2e64: f9001801     	str	x1, [x0, #0x30]
  7a2e68: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e6c: f9401fe1     	ldr	x1, [sp, #0x38]
  7a2e70: f9001c01     	str	x1, [x0, #0x38]
  7a2e74: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e78: f94013e1     	ldr	x1, [sp, #0x20]
  7a2e7c: f9002001     	str	x1, [x0, #0x40]
  7a2e80: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e84: b900481f     	str	wzr, [x0, #0x48]
  7a2e88: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e8c: b9004c1f     	str	wzr, [x0, #0x4c]
  7a2e90: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e94: b900501f     	str	wzr, [x0, #0x50]
  7a2e98: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e9c: b900541f     	str	wzr, [x0, #0x54]
  7a2ea0: f94027e0     	ldr	x0, [sp, #0x48]
  7a2ea4: b900581f     	str	wzr, [x0, #0x58]
  7a2ea8: f94027e0     	ldr	x0, [sp, #0x48]
  7a2eac: b9005c1f     	str	wzr, [x0, #0x5c]
  7a2eb0: f94027e0     	ldr	x0, [sp, #0x48]
  7a2eb4: b900601f     	str	wzr, [x0, #0x60]
  7a2eb8: f94027e0     	ldr	x0, [sp, #0x48]
  7a2ebc: b900641f     	str	wzr, [x0, #0x64]
  7a2ec0: f94027e0     	ldr	x0, [sp, #0x48]
  7a2ec4: 9101a001     	add	x1, x0, #0x68
  7a2ec8: f0002e80     	adrp	x0, 0xd75000
  7a2ecc: 910ca000     	add	x0, x0, #0x328
  7a2ed0: aa0103e2     	mov	x2, x1
  7a2ed4: aa0003e3     	mov	x3, x0
  7a2ed8: a9400460     	ldp	x0, x1, [x3]
  7a2edc: a9000440     	stp	x0, x1, [x2]
  7a2ee0: b9401060     	ldr	w0, [x3, #0x10]
  7a2ee4: b9001040     	str	w0, [x2, #0x10]
  7a2ee8: f94027e0     	ldr	x0, [sp, #0x48]
  7a2eec: b9007c1f     	str	wzr, [x0, #0x7c]
  7a2ef0: f94027e0     	ldr	x0, [sp, #0x48]
  7a2ef4: b900801f     	str	wzr, [x0, #0x80]
  7a2ef8: f94027e0     	ldr	x0, [sp, #0x48]
  7a2efc: b900841f     	str	wzr, [x0, #0x84]
  7a2f00: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f04: b900881f     	str	wzr, [x0, #0x88]
  7a2f08: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f0c: b9008c1f     	str	wzr, [x0, #0x8c]
  7a2f10: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f14: b900901f     	str	wzr, [x0, #0x90]
  7a2f18: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f1c: b900941f     	str	wzr, [x0, #0x94]
  7a2f20: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f24: f0002e81     	adrp	x1, 0xd75000
  7a2f28: 910c2021     	add	x1, x1, #0x308
  7a2f2c: f9000401     	str	x1, [x0, #0x8]
  7a2f30: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f34: f9402000     	ldr	x0, [x0, #0x40]
  7a2f38: 910a4000     	add	x0, x0, #0x290
  7a2f3c: 97f1c690     	bl	0x41497c <.text+0x974c>
  7a2f40: 12001c01     	and	w1, w0, #0xff
  7a2f44: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f48: 39029001     	strb	w1, [x0, #0xa4]
  7a2f4c: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f50: f9402000     	ldr	x0, [x0, #0x40]
  7a2f54: 91226000     	add	x0, x0, #0x898
  7a2f58: 97f8e368     	bl	0x5dbcf8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xe2c48>
  7a2f5c: 2a0003e1     	mov	w1, w0
  7a2f60: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f64: b900a001     	str	w1, [x0, #0xa0]
  7a2f68: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f6c: f9402000     	ldr	x0, [x0, #0x40]
  7a2f70: 911f0000     	add	x0, x0, #0x7c0
  7a2f74: 97f1c682     	bl	0x41497c <.text+0x974c>
  7a2f78: 12001c01     	and	w1, w0, #0xff
  7a2f7c: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f80: 39027c01     	strb	w1, [x0, #0x9f]
  7a2f84: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f88: f9402000     	ldr	x0, [x0, #0x40]
  7a2f8c: 91372000     	add	x0, x0, #0xdc8
  7a2f90: 97f1c67b     	bl	0x41497c <.text+0x974c>
  7a2f94: 12001c01     	and	w1, w0, #0xff
  7a2f98: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f9c: 39027801     	strb	w1, [x0, #0x9e]
  7a2fa0: f94027e0     	ldr	x0, [sp, #0x48]
  7a2fa4: f9402000     	ldr	x0, [x0, #0x40]
  7a2fa8: 9125e000     	add	x0, x0, #0x978
  7a2fac: 97f1c674     	bl	0x41497c <.text+0x974c>
  7a2fb0: 12001c01     	and	w1, w0, #0xff
  7a2fb4: f94027e0     	ldr	x0, [sp, #0x48]
  7a2fb8: 39027401     	strb	w1, [x0, #0x9d]
  7a2fbc: f94027e0     	ldr	x0, [sp, #0x48]
  7a2fc0: f9402000     	ldr	x0, [x0, #0x40]
  7a2fc4: 9106e000     	add	x0, x0, #0x1b8
  7a2fc8: 97f1c66d     	bl	0x41497c <.text+0x974c>
  7a2fcc: 12001c01     	and	w1, w0, #0xff
  7a2fd0: f94027e0     	ldr	x0, [sp, #0x48]
  7a2fd4: 39027001     	strb	w1, [x0, #0x9c]
  7a2fd8: f94027e0     	ldr	x0, [sp, #0x48]
  7a2fdc: f9402000     	ldr	x0, [x0, #0x40]
  7a2fe0: 91304000     	add	x0, x0, #0xc10
  7a2fe4: 97f1c6d1     	bl	0x414b28 <.text+0x98f8>
  7a2fe8: 2a0003e1     	mov	w1, w0
  7a2fec: f94027e0     	ldr	x0, [sp, #0x48]
  7a2ff0: b9009801     	str	w1, [x0, #0x98]
  7a2ff4: f94027e0     	ldr	x0, [sp, #0x48]
  7a2ff8: f9402000     	ldr	x0, [x0, #0x40]
  7a2ffc: 91294000     	add	x0, x0, #0xa50
  7a3000: 97f1c6ca     	bl	0x414b28 <.text+0x98f8>
  7a3004: 2a0003e1     	mov	w1, w0
  7a3008: f94027e0     	ldr	x0, [sp, #0x48]
  7a300c: b900a801     	str	w1, [x0, #0xa8]
  7a3010: f94027e0     	ldr	x0, [sp, #0x48]
  7a3014: f9402000     	ldr	x0, [x0, #0x40]
  7a3018: 912cc000     	add	x0, x0, #0xb30
  7a301c: 97f1c6c3     	bl	0x414b28 <.text+0x98f8>
  7a3020: 2a0003e1     	mov	w1, w0
  7a3024: f94027e0     	ldr	x0, [sp, #0x48]
  7a3028: b900ac01     	str	w1, [x0, #0xac]
  7a302c: d503201f     	nop
  7a3030: a8c57bfd     	ldp	x29, x30, [sp], #0x50
  7a3034: d65f03c0     	ret
  7a3038: d10043ff     	sub	sp, sp, #0x10
  7a303c: f90007e0     	str	x0, [sp, #0x8]
  7a3040: d0002e80     	adrp	x0, 0xd75000
  7a3044: 91168001     	add	x1, x0, #0x5a0
  7a3048: f94007e0     	ldr	x0, [sp, #0x8]
  7a304c: f9000001     	str	x1, [x0]
  7a3050: d503201f     	nop
  7a3054: 910043ff     	add	sp, sp, #0x10
  7a3058: d65f03c0     	ret
  7a305c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7a3060: 910003fd     	mov	x29, sp
  7a3064: f9000fe0     	str	x0, [sp, #0x18]
  7a3068: f9400fe0     	ldr	x0, [sp, #0x18]
  7a306c: 97fffff3     	bl	0x7a3038 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8930c>
  7a3070: d2801601     	mov	x1, #0xb0               // =176
  7a3074: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3078: 97f19b5a     	bl	0x409de0 <_ZdlPvm@plt>
  7a307c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7a3080: d65f03c0     	ret
  7a3084: d10043ff     	sub	sp, sp, #0x10
  7a3088: f90007e0     	str	x0, [sp, #0x8]
  7a308c: f94007e0     	ldr	x0, [sp, #0x8]
  7a3090: b9404801     	ldr	w1, [x0, #0x48]
  7a3094: f94007e0     	ldr	x0, [sp, #0x8]
  7a3098: b9404c00     	ldr	w0, [x0, #0x4c]
  7a309c: 4b000020     	sub	w0, w1, w0
  7a30a0: 910043ff     	add	sp, sp, #0x10
  7a30a4: d65f03c0     	ret
  7a30a8: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  7a30ac: 910003fd     	mov	x29, sp
  7a30b0: f9000bf3     	str	x19, [sp, #0x10]
  7a30b4: f90017e0     	str	x0, [sp, #0x28]
  7a30b8: f94017e0     	ldr	x0, [sp, #0x28]
  7a30bc: f9400c13     	ldr	x19, [x0, #0x18]
  7a30c0: f94017e0     	ldr	x0, [sp, #0x28]
  7a30c4: f9400800     	ldr	x0, [x0, #0x10]
  7a30c8: 97fff9fb     	bl	0x7a18b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87b88>
  7a30cc: aa0003e1     	mov	x1, x0
  7a30d0: aa1303e0     	mov	x0, x19
  7a30d4: 94021a88     	bl	0x829af4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6db2c>
  7a30d8: f94017e0     	ldr	x0, [sp, #0x28]
  7a30dc: f9402000     	ldr	x0, [x0, #0x40]
  7a30e0: 910a4000     	add	x0, x0, #0x290
  7a30e4: 97f1c626     	bl	0x41497c <.text+0x974c>
  7a30e8: 12001c01     	and	w1, w0, #0xff
  7a30ec: f94017e0     	ldr	x0, [sp, #0x28]
  7a30f0: 39029001     	strb	w1, [x0, #0xa4]
  7a30f4: f94017e0     	ldr	x0, [sp, #0x28]
  7a30f8: f9402000     	ldr	x0, [x0, #0x40]
  7a30fc: 91226000     	add	x0, x0, #0x898
  7a3100: 97f8e2fe     	bl	0x5dbcf8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xe2c48>
  7a3104: 2a0003e1     	mov	w1, w0
  7a3108: f94017e0     	ldr	x0, [sp, #0x28]
  7a310c: b900a001     	str	w1, [x0, #0xa0]
  7a3110: f94017e0     	ldr	x0, [sp, #0x28]
  7a3114: f9402000     	ldr	x0, [x0, #0x40]
  7a3118: 911f0000     	add	x0, x0, #0x7c0
  7a311c: 97f1c618     	bl	0x41497c <.text+0x974c>
  7a3120: 12001c01     	and	w1, w0, #0xff
  7a3124: f94017e0     	ldr	x0, [sp, #0x28]
  7a3128: 39027c01     	strb	w1, [x0, #0x9f]
  7a312c: f94017e0     	ldr	x0, [sp, #0x28]
  7a3130: f9402000     	ldr	x0, [x0, #0x40]
  7a3134: 91372000     	add	x0, x0, #0xdc8
  7a3138: 97f1c611     	bl	0x41497c <.text+0x974c>
  7a313c: 12001c01     	and	w1, w0, #0xff
  7a3140: f94017e0     	ldr	x0, [sp, #0x28]
  7a3144: 39027801     	strb	w1, [x0, #0x9e]
  7a3148: f94017e0     	ldr	x0, [sp, #0x28]
  7a314c: f9402000     	ldr	x0, [x0, #0x40]
  7a3150: 9125e000     	add	x0, x0, #0x978
  7a3154: 97f1c60a     	bl	0x41497c <.text+0x974c>
  7a3158: 12001c01     	and	w1, w0, #0xff
  7a315c: f94017e0     	ldr	x0, [sp, #0x28]
  7a3160: 39027401     	strb	w1, [x0, #0x9d]
  7a3164: f94017e0     	ldr	x0, [sp, #0x28]
  7a3168: f9402000     	ldr	x0, [x0, #0x40]
  7a316c: 9106e000     	add	x0, x0, #0x1b8
  7a3170: 97f1c603     	bl	0x41497c <.text+0x974c>
  7a3174: 12001c01     	and	w1, w0, #0xff
  7a3178: f94017e0     	ldr	x0, [sp, #0x28]
  7a317c: 39027001     	strb	w1, [x0, #0x9c]
  7a3180: f94017e0     	ldr	x0, [sp, #0x28]
  7a3184: f9402000     	ldr	x0, [x0, #0x40]
  7a3188: 91304000     	add	x0, x0, #0xc10
  7a318c: 97f1c667     	bl	0x414b28 <.text+0x98f8>
  7a3190: 2a0003e1     	mov	w1, w0
  7a3194: f94017e0     	ldr	x0, [sp, #0x28]
  7a3198: b9009801     	str	w1, [x0, #0x98]
  7a319c: f94017e0     	ldr	x0, [sp, #0x28]
  7a31a0: f9402000     	ldr	x0, [x0, #0x40]
  7a31a4: 91294000     	add	x0, x0, #0xa50
  7a31a8: 97f1c660     	bl	0x414b28 <.text+0x98f8>
  7a31ac: 2a0003e1     	mov	w1, w0
  7a31b0: f94017e0     	ldr	x0, [sp, #0x28]
  7a31b4: b900a801     	str	w1, [x0, #0xa8]
  7a31b8: f94017e0     	ldr	x0, [sp, #0x28]
  7a31bc: f9402000     	ldr	x0, [x0, #0x40]
  7a31c0: 912cc000     	add	x0, x0, #0xb30
  7a31c4: 97f1c659     	bl	0x414b28 <.text+0x98f8>
  7a31c8: 2a0003e1     	mov	w1, w0
  7a31cc: f94017e0     	ldr	x0, [sp, #0x28]
  7a31d0: b900ac01     	str	w1, [x0, #0xac]
  7a31d4: f94017e0     	ldr	x0, [sp, #0x28]
  7a31d8: f9402000     	ldr	x0, [x0, #0x40]
  7a31dc: 91038000     	add	x0, x0, #0xe0
  7a31e0: 52800021     	mov	w1, #0x1                // =1
  7a31e4: 97f1c5f3     	bl	0x4149b0 <.text+0x9780>
  7a31e8: f94017e0     	ldr	x0, [sp, #0x28]
  7a31ec: f9402000     	ldr	x0, [x0, #0x40]
  7a31f0: 910a4000     	add	x0, x0, #0x290
  7a31f4: 52800021     	mov	w1, #0x1                // =1
  7a31f8: 97f1c5ee     	bl	0x4149b0 <.text+0x9780>
  7a31fc: f94017e0     	ldr	x0, [sp, #0x28]
  7a3200: f9402000     	ldr	x0, [x0, #0x40]
  7a3204: 91226000     	add	x0, x0, #0x898
  7a3208: 52800021     	mov	w1, #0x1                // =1
  7a320c: 97f8e2c8     	bl	0x5dbd2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xe2c7c>
  7a3210: f94017e0     	ldr	x0, [sp, #0x28]
  7a3214: f9402000     	ldr	x0, [x0, #0x40]
  7a3218: 911f0000     	add	x0, x0, #0x7c0
  7a321c: 52800021     	mov	w1, #0x1                // =1
  7a3220: 97f1c5e4     	bl	0x4149b0 <.text+0x9780>
  7a3224: f94017e0     	ldr	x0, [sp, #0x28]
  7a3228: f9402000     	ldr	x0, [x0, #0x40]
  7a322c: 91372000     	add	x0, x0, #0xdc8
  7a3230: 52800001     	mov	w1, #0x0                // =0
  7a3234: 97f1c5df     	bl	0x4149b0 <.text+0x9780>
  7a3238: f94017e0     	ldr	x0, [sp, #0x28]
  7a323c: f9402000     	ldr	x0, [x0, #0x40]
  7a3240: 9125e000     	add	x0, x0, #0x978
  7a3244: 52800021     	mov	w1, #0x1                // =1
  7a3248: 97f1c5da     	bl	0x4149b0 <.text+0x9780>
  7a324c: f94017e0     	ldr	x0, [sp, #0x28]
  7a3250: f9402000     	ldr	x0, [x0, #0x40]
  7a3254: 9106e000     	add	x0, x0, #0x1b8
  7a3258: 52800021     	mov	w1, #0x1                // =1
  7a325c: 97f1c5d5     	bl	0x4149b0 <.text+0x9780>
  7a3260: f94017e0     	ldr	x0, [sp, #0x28]
  7a3264: f9402000     	ldr	x0, [x0, #0x40]
  7a3268: 91304000     	add	x0, x0, #0xc10
  7a326c: 52800021     	mov	w1, #0x1                // =1
  7a3270: 97f1d0ce     	bl	0x4175a8 <.text+0xc378>
  7a3274: f94017e0     	ldr	x0, [sp, #0x28]
  7a3278: f9402000     	ldr	x0, [x0, #0x40]
  7a327c: 9133c000     	add	x0, x0, #0xcf0
  7a3280: 52800021     	mov	w1, #0x1                // =1
  7a3284: 97f1c5cb     	bl	0x4149b0 <.text+0x9780>
  7a3288: f94017e0     	ldr	x0, [sp, #0x28]
  7a328c: f9401800     	ldr	x0, [x0, #0x30]
  7a3290: 39408000     	ldrb	w0, [x0, #0x20]
  7a3294: 7100001f     	cmp	w0, #0x0
  7a3298: 54000060     	b.eq	0x7a32a4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x89578>
  7a329c: 52800000     	mov	w0, #0x0                // =0
  7a32a0: 14000002     	b	0x7a32a8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8957c>
  7a32a4: 52800020     	mov	w0, #0x1                // =1
  7a32a8: f94017e1     	ldr	x1, [sp, #0x28]
  7a32ac: b9008020     	str	w0, [x1, #0x80]
