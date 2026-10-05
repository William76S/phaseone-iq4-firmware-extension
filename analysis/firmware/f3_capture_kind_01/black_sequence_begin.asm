
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
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
  7a32b0: f94017e0     	ldr	x0, [sp, #0x28]
  7a32b4: b900481f     	str	wzr, [x0, #0x48]
  7a32b8: f94017e0     	ldr	x0, [sp, #0x28]
  7a32bc: 9101a000     	add	x0, x0, #0x68
  7a32c0: d2800282     	mov	x2, #0x14               // =20
  7a32c4: 52801fe1     	mov	w1, #0xff               // =255
  7a32c8: 97f19bb6     	bl	0x40a1a0 <memset@plt>
  7a32cc: f94017e0     	ldr	x0, [sp, #0x28]
  7a32d0: b9007c1f     	str	wzr, [x0, #0x7c]
  7a32d4: f94017e0     	ldr	x0, [sp, #0x28]
  7a32d8: f9401800     	ldr	x0, [x0, #0x30]
  7a32dc: 97f2b57d     	bl	0x4508d0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x1a924>
  7a32e0: 7100081f     	cmp	w0, #0x2
  7a32e4: 1a9f17e0     	cset	w0, eq
  7a32e8: 12001c00     	and	w0, w0, #0xff
  7a32ec: 3900efe0     	strb	w0, [sp, #0x3b]
  7a32f0: f94017e0     	ldr	x0, [sp, #0x28]
  7a32f4: 52800041     	mov	w1, #0x2                // =2
  7a32f8: b9006801     	str	w1, [x0, #0x68]
  7a32fc: f94017e0     	ldr	x0, [sp, #0x28]
  7a3300: b9006c1f     	str	wzr, [x0, #0x6c]
  7a3304: f94017e0     	ldr	x0, [sp, #0x28]
  7a3308: 52800021     	mov	w1, #0x1                // =1
  7a330c: b9007001     	str	w1, [x0, #0x70]
  7a3310: f94017e0     	ldr	x0, [sp, #0x28]
  7a3314: f9401800     	ldr	x0, [x0, #0x30]
  7a3318: 39403800     	ldrb	w0, [x0, #0xe]
  7a331c: 7100001f     	cmp	w0, #0x0
  7a3320: 54000080     	b.eq	0x7a3330 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x89604>
  7a3324: f94017e0     	ldr	x0, [sp, #0x28]
  7a3328: 52800061     	mov	w1, #0x3                // =3
  7a332c: b9007401     	str	w1, [x0, #0x74]
  7a3330: b9003fff     	str	wzr, [sp, #0x3c]
  7a3334: f94017e1     	ldr	x1, [sp, #0x28]
  7a3338: b9403fe0     	ldr	w0, [sp, #0x3c]
  7a333c: 91006000     	add	x0, x0, #0x18
  7a3340: d37ef400     	lsl	x0, x0, #2
  7a3344: 8b000020     	add	x0, x1, x0
  7a3348: b9400800     	ldr	w0, [x0, #0x8]
  7a334c: 3100041f     	cmn	w0, #0x1
  7a3350: 54001240     	b.eq	0x7a3598 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8986c>
  7a3354: f94017e0     	ldr	x0, [sp, #0x28]
  7a3358: f9401800     	ldr	x0, [x0, #0x30]
  7a335c: 39408000     	ldrb	w0, [x0, #0x20]
  7a3360: 7100001f     	cmp	w0, #0x0
  7a3364: 540003a0     	b.eq	0x7a33d8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x896ac>
  7a3368: f94017e0     	ldr	x0, [sp, #0x28]
  7a336c: f9401003     	ldr	x3, [x0, #0x20]
  7a3370: f94017e1     	ldr	x1, [sp, #0x28]
  7a3374: b9403fe0     	ldr	w0, [sp, #0x3c]
  7a3378: 91006000     	add	x0, x0, #0x18
  7a337c: d37ef400     	lsl	x0, x0, #2
  7a3380: 8b000020     	add	x0, x1, x0
  7a3384: b9400800     	ldr	w0, [x0, #0x8]
  7a3388: 52800202     	mov	w2, #0x10               // =16
  7a338c: 2a0003e1     	mov	w1, w0
  7a3390: aa0303e0     	mov	x0, x3
  7a3394: 9401a83d     	bl	0x80d488 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x514c0>
  7a3398: 2a0003e1     	mov	w1, w0
  7a339c: f94017e0     	ldr	x0, [sp, #0x28]
  7a33a0: b9005001     	str	w1, [x0, #0x50]
  7a33a4: f94017e0     	ldr	x0, [sp, #0x28]
  7a33a8: b9405001     	ldr	w1, [x0, #0x50]
  7a33ac: f94017e0     	ldr	x0, [sp, #0x28]
  7a33b0: b9005401     	str	w1, [x0, #0x54]
  7a33b4: f94017e0     	ldr	x0, [sp, #0x28]
  7a33b8: b9404801     	ldr	w1, [x0, #0x48]
  7a33bc: f94017e0     	ldr	x0, [sp, #0x28]
  7a33c0: b9405000     	ldr	w0, [x0, #0x50]
  7a33c4: 0b000020     	add	w0, w1, w0
  7a33c8: 11000401     	add	w1, w0, #0x1
  7a33cc: f94017e0     	ldr	x0, [sp, #0x28]
  7a33d0: b9004801     	str	w1, [x0, #0x48]
  7a33d4: 14000003     	b	0x7a33e0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x896b4>
  7a33d8: f94017e0     	ldr	x0, [sp, #0x28]
  7a33dc: b900541f     	str	wzr, [x0, #0x54]
  7a33e0: f94017e0     	ldr	x0, [sp, #0x28]
  7a33e4: f9401003     	ldr	x3, [x0, #0x20]
  7a33e8: f94017e1     	ldr	x1, [sp, #0x28]
  7a33ec: b9403fe0     	ldr	w0, [sp, #0x3c]
  7a33f0: 91006000     	add	x0, x0, #0x18
  7a33f4: d37ef400     	lsl	x0, x0, #2
  7a33f8: 8b000020     	add	x0, x1, x0
  7a33fc: b9400800     	ldr	w0, [x0, #0x8]
  7a3400: 528001c2     	mov	w2, #0xe                // =14
  7a3404: 2a0003e1     	mov	w1, w0
  7a3408: aa0303e0     	mov	x0, x3
  7a340c: 9401a81f     	bl	0x80d488 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x514c0>
  7a3410: 2a0003e1     	mov	w1, w0
  7a3414: f94017e0     	ldr	x0, [sp, #0x28]
  7a3418: b9005001     	str	w1, [x0, #0x50]
  7a341c: f94017e0     	ldr	x0, [sp, #0x28]
  7a3420: b9405001     	ldr	w1, [x0, #0x50]
  7a3424: f94017e0     	ldr	x0, [sp, #0x28]
  7a3428: b9005801     	str	w1, [x0, #0x58]
  7a342c: f94017e0     	ldr	x0, [sp, #0x28]
  7a3430: b9404801     	ldr	w1, [x0, #0x48]
  7a3434: f94017e0     	ldr	x0, [sp, #0x28]
  7a3438: b9405000     	ldr	w0, [x0, #0x50]
  7a343c: 0b000020     	add	w0, w1, w0
  7a3440: 11000401     	add	w1, w0, #0x1
  7a3444: f94017e0     	ldr	x0, [sp, #0x28]
  7a3448: b9004801     	str	w1, [x0, #0x48]
  7a344c: f94017e0     	ldr	x0, [sp, #0x28]
  7a3450: f9401003     	ldr	x3, [x0, #0x20]
  7a3454: f94017e1     	ldr	x1, [sp, #0x28]
  7a3458: b9403fe0     	ldr	w0, [sp, #0x3c]
  7a345c: 91006000     	add	x0, x0, #0x18
  7a3460: d37ef400     	lsl	x0, x0, #2
  7a3464: 8b000020     	add	x0, x1, x0
  7a3468: b9400800     	ldr	w0, [x0, #0x8]
  7a346c: 52800182     	mov	w2, #0xc                // =12
  7a3470: 2a0003e1     	mov	w1, w0
  7a3474: aa0303e0     	mov	x0, x3
  7a3478: 9401a804     	bl	0x80d488 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x514c0>
  7a347c: 2a0003e1     	mov	w1, w0
  7a3480: f94017e0     	ldr	x0, [sp, #0x28]
  7a3484: b9005001     	str	w1, [x0, #0x50]
  7a3488: f94017e0     	ldr	x0, [sp, #0x28]
  7a348c: b9405001     	ldr	w1, [x0, #0x50]
  7a3490: f94017e0     	ldr	x0, [sp, #0x28]
  7a3494: b9005c01     	str	w1, [x0, #0x5c]
  7a3498: f94017e0     	ldr	x0, [sp, #0x28]
  7a349c: b9404801     	ldr	w1, [x0, #0x48]
  7a34a0: f94017e0     	ldr	x0, [sp, #0x28]
  7a34a4: b9405000     	ldr	w0, [x0, #0x50]
  7a34a8: 0b000020     	add	w0, w1, w0
  7a34ac: 11000401     	add	w1, w0, #0x1
  7a34b0: f94017e0     	ldr	x0, [sp, #0x28]
  7a34b4: b9004801     	str	w1, [x0, #0x48]
  7a34b8: f94017e1     	ldr	x1, [sp, #0x28]
  7a34bc: b9403fe0     	ldr	w0, [sp, #0x3c]
  7a34c0: 91008000     	add	x0, x0, #0x20
  7a34c4: d37ef400     	lsl	x0, x0, #2
  7a34c8: 8b000020     	add	x0, x1, x0
  7a34cc: 52800041     	mov	w1, #0x2                // =2
  7a34d0: b9000401     	str	w1, [x0, #0x4]
  7a34d4: 3940efe0     	ldrb	w0, [sp, #0x3b]
  7a34d8: 7100001f     	cmp	w0, #0x0
  7a34dc: 54000560     	b.eq	0x7a3588 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8985c>
  7a34e0: f94017e1     	ldr	x1, [sp, #0x28]
  7a34e4: b9403fe0     	ldr	w0, [sp, #0x3c]
  7a34e8: 91006000     	add	x0, x0, #0x18
  7a34ec: d37ef400     	lsl	x0, x0, #2
  7a34f0: 8b000020     	add	x0, x1, x0
  7a34f4: b9400800     	ldr	w0, [x0, #0x8]
  7a34f8: 7100001f     	cmp	w0, #0x0
  7a34fc: 54000461     	b.ne	0x7a3588 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8985c>
  7a3500: f94017e0     	ldr	x0, [sp, #0x28]
  7a3504: f9401003     	ldr	x3, [x0, #0x20]
  7a3508: f94017e1     	ldr	x1, [sp, #0x28]
  7a350c: b9403fe0     	ldr	w0, [sp, #0x3c]
  7a3510: 91006000     	add	x0, x0, #0x18
  7a3514: d37ef400     	lsl	x0, x0, #2
  7a3518: 8b000020     	add	x0, x1, x0
  7a351c: b9400800     	ldr	w0, [x0, #0x8]
  7a3520: 52800162     	mov	w2, #0xb                // =11
  7a3524: 2a0003e1     	mov	w1, w0
  7a3528: aa0303e0     	mov	x0, x3
  7a352c: 9401a7d7     	bl	0x80d488 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x514c0>
  7a3530: 2a0003e1     	mov	w1, w0
  7a3534: f94017e0     	ldr	x0, [sp, #0x28]
  7a3538: b9005001     	str	w1, [x0, #0x50]
  7a353c: f94017e0     	ldr	x0, [sp, #0x28]
  7a3540: b9405001     	ldr	w1, [x0, #0x50]
  7a3544: f94017e0     	ldr	x0, [sp, #0x28]
  7a3548: b9006001     	str	w1, [x0, #0x60]
  7a354c: f94017e0     	ldr	x0, [sp, #0x28]
  7a3550: b9404801     	ldr	w1, [x0, #0x48]
  7a3554: f94017e0     	ldr	x0, [sp, #0x28]
  7a3558: b9405000     	ldr	w0, [x0, #0x50]
  7a355c: 0b000020     	add	w0, w1, w0
  7a3560: 11000401     	add	w1, w0, #0x1
  7a3564: f94017e0     	ldr	x0, [sp, #0x28]
  7a3568: b9004801     	str	w1, [x0, #0x48]
  7a356c: f94017e1     	ldr	x1, [sp, #0x28]
  7a3570: b9403fe0     	ldr	w0, [sp, #0x3c]
  7a3574: 91008000     	add	x0, x0, #0x20
  7a3578: d37ef400     	lsl	x0, x0, #2
  7a357c: 8b000020     	add	x0, x1, x0
  7a3580: 52800061     	mov	w1, #0x3                // =3
  7a3584: b9000401     	str	w1, [x0, #0x4]
  7a3588: b9403fe0     	ldr	w0, [sp, #0x3c]
  7a358c: 11000400     	add	w0, w0, #0x1
  7a3590: b9003fe0     	str	w0, [sp, #0x3c]
  7a3594: 17ffff68     	b	0x7a3334 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x89608>
  7a3598: f94017e0     	ldr	x0, [sp, #0x28]
  7a359c: b900641f     	str	wzr, [x0, #0x64]
  7a35a0: f94017e0     	ldr	x0, [sp, #0x28]
  7a35a4: b9004c1f     	str	wzr, [x0, #0x4c]
  7a35a8: f94017e0     	ldr	x0, [sp, #0x28]
  7a35ac: b9408000     	ldr	w0, [x0, #0x80]
  7a35b0: f94017e1     	ldr	x1, [sp, #0x28]
  7a35b4: 2a0003e0     	mov	w0, w0
  7a35b8: 91005000     	add	x0, x0, #0x14
  7a35bc: d37ef400     	lsl	x0, x0, #2
  7a35c0: 8b000020     	add	x0, x1, x0
  7a35c4: b9400401     	ldr	w1, [x0, #0x4]
  7a35c8: f94017e0     	ldr	x0, [sp, #0x28]
  7a35cc: b9005001     	str	w1, [x0, #0x50]
  7a35d0: f94017e0     	ldr	x0, [sp, #0x28]
  7a35d4: b9404801     	ldr	w1, [x0, #0x48]
  7a35d8: f94017e0     	ldr	x0, [sp, #0x28]
  7a35dc: f9401800     	ldr	x0, [x0, #0x30]
  7a35e0: b9414400     	ldr	w0, [x0, #0x144]
  7a35e4: 6b00003f     	cmp	w1, w0
  7a35e8: 540002c0     	b.eq	0x7a3640 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x89914>
  7a35ec: f94017e0     	ldr	x0, [sp, #0x28]
  7a35f0: b9404801     	ldr	w1, [x0, #0x48]
  7a35f4: f94017e0     	ldr	x0, [sp, #0x28]
  7a35f8: f9401800     	ldr	x0, [x0, #0x30]
  7a35fc: b9414400     	ldr	w0, [x0, #0x144]
  7a3600: 2a0003e5     	mov	w5, w0
  7a3604: 2a0103e4     	mov	w4, w1
  7a3608: d0002e80     	adrp	x0, 0xd75000
  7a360c: 910d0003     	add	x3, x0, #0x340
  7a3610: 52800fe2     	mov	w2, #0x7f               // =127
  7a3614: d0002e80     	adrp	x0, 0xd75000
  7a3618: 910e0001     	add	x1, x0, #0x380
  7a361c: 52800080     	mov	w0, #0x4                // =4
  7a3620: 97fe8bcb     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  7a3624: f94017e0     	ldr	x0, [sp, #0x28]
  7a3628: b9404800     	ldr	w0, [x0, #0x48]
  7a362c: 11000401     	add	w1, w0, #0x1
  7a3630: f94017e0     	ldr	x0, [sp, #0x28]
  7a3634: b9004801     	str	w1, [x0, #0x48]
  7a3638: 52800000     	mov	w0, #0x0                // =0
  7a363c: 14000007     	b	0x7a3658 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8992c>
  7a3640: f94017e0     	ldr	x0, [sp, #0x28]
  7a3644: b9404800     	ldr	w0, [x0, #0x48]
  7a3648: 11000401     	add	w1, w0, #0x1
  7a364c: f94017e0     	ldr	x0, [sp, #0x28]
  7a3650: b9004801     	str	w1, [x0, #0x48]
  7a3654: 52800020     	mov	w0, #0x1                // =1
  7a3658: f9400bf3     	ldr	x19, [sp, #0x10]
  7a365c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  7a3660: d65f03c0     	ret
  7a3664: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7a3668: 910003fd     	mov	x29, sp
  7a366c: f9000fe0     	str	x0, [sp, #0x18]
  7a3670: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3674: f9402000     	ldr	x0, [x0, #0x40]
  7a3678: 91038000     	add	x0, x0, #0xe0
  7a367c: 52800001     	mov	w1, #0x0                // =0
  7a3680: 97f1c4cc     	bl	0x4149b0 <.text+0x9780>
  7a3684: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3688: f9402000     	ldr	x0, [x0, #0x40]
  7a368c: 9133c000     	add	x0, x0, #0xcf0
  7a3690: 52800001     	mov	w1, #0x0                // =0
  7a3694: 97f1c4c7     	bl	0x4149b0 <.text+0x9780>
  7a3698: f9400fe0     	ldr	x0, [sp, #0x18]
  7a369c: f9402000     	ldr	x0, [x0, #0x40]
  7a36a0: 910a4002     	add	x2, x0, #0x290
  7a36a4: f9400fe0     	ldr	x0, [sp, #0x18]
  7a36a8: 39429000     	ldrb	w0, [x0, #0xa4]
  7a36ac: 2a0003e1     	mov	w1, w0
  7a36b0: aa0203e0     	mov	x0, x2
  7a36b4: 97f1c4bf     	bl	0x4149b0 <.text+0x9780>
  7a36b8: f9400fe0     	ldr	x0, [sp, #0x18]
  7a36bc: f9402000     	ldr	x0, [x0, #0x40]
  7a36c0: 91226002     	add	x2, x0, #0x898
  7a36c4: f9400fe0     	ldr	x0, [sp, #0x18]
  7a36c8: b940a000     	ldr	w0, [x0, #0xa0]
  7a36cc: 2a0003e1     	mov	w1, w0
  7a36d0: aa0203e0     	mov	x0, x2
  7a36d4: 97f8e196     	bl	0x5dbd2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xe2c7c>
  7a36d8: f9400fe0     	ldr	x0, [sp, #0x18]
  7a36dc: f9402000     	ldr	x0, [x0, #0x40]
  7a36e0: 911f0002     	add	x2, x0, #0x7c0
  7a36e4: f9400fe0     	ldr	x0, [sp, #0x18]
  7a36e8: 39427c00     	ldrb	w0, [x0, #0x9f]
  7a36ec: 2a0003e1     	mov	w1, w0
  7a36f0: aa0203e0     	mov	x0, x2
  7a36f4: 97f1c4af     	bl	0x4149b0 <.text+0x9780>
  7a36f8: f9400fe0     	ldr	x0, [sp, #0x18]
  7a36fc: f9402000     	ldr	x0, [x0, #0x40]
  7a3700: 91372002     	add	x2, x0, #0xdc8
  7a3704: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3708: 39427800     	ldrb	w0, [x0, #0x9e]
  7a370c: 2a0003e1     	mov	w1, w0
  7a3710: aa0203e0     	mov	x0, x2
  7a3714: 97f1c4a7     	bl	0x4149b0 <.text+0x9780>
  7a3718: f9400fe0     	ldr	x0, [sp, #0x18]
  7a371c: f9402000     	ldr	x0, [x0, #0x40]
  7a3720: 9125e002     	add	x2, x0, #0x978
  7a3724: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3728: 39427400     	ldrb	w0, [x0, #0x9d]
  7a372c: 2a0003e1     	mov	w1, w0
  7a3730: aa0203e0     	mov	x0, x2
  7a3734: 97f1c49f     	bl	0x4149b0 <.text+0x9780>
  7a3738: f9400fe0     	ldr	x0, [sp, #0x18]
  7a373c: f9402000     	ldr	x0, [x0, #0x40]
  7a3740: 9106e002     	add	x2, x0, #0x1b8
  7a3744: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3748: 39427000     	ldrb	w0, [x0, #0x9c]
  7a374c: 2a0003e1     	mov	w1, w0
  7a3750: aa0203e0     	mov	x0, x2
  7a3754: 97f1c497     	bl	0x4149b0 <.text+0x9780>
  7a3758: f9400fe0     	ldr	x0, [sp, #0x18]
  7a375c: f9402000     	ldr	x0, [x0, #0x40]
  7a3760: 91304002     	add	x2, x0, #0xc10
  7a3764: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3768: b9409800     	ldr	w0, [x0, #0x98]
  7a376c: 2a0003e1     	mov	w1, w0
  7a3770: aa0203e0     	mov	x0, x2
  7a3774: 97f1cf8d     	bl	0x4175a8 <.text+0xc378>
  7a3778: f9400fe0     	ldr	x0, [sp, #0x18]
  7a377c: f9402000     	ldr	x0, [x0, #0x40]
  7a3780: 91294002     	add	x2, x0, #0xa50
  7a3784: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3788: b940a800     	ldr	w0, [x0, #0xa8]
  7a378c: 2a0003e1     	mov	w1, w0
  7a3790: aa0203e0     	mov	x0, x2
  7a3794: 97f1cf85     	bl	0x4175a8 <.text+0xc378>
  7a3798: f9400fe0     	ldr	x0, [sp, #0x18]
  7a379c: f9402000     	ldr	x0, [x0, #0x40]
  7a37a0: 912cc002     	add	x2, x0, #0xb30
  7a37a4: f9400fe0     	ldr	x0, [sp, #0x18]
  7a37a8: b940ac00     	ldr	w0, [x0, #0xac]
  7a37ac: 2a0003e1     	mov	w1, w0
  7a37b0: aa0203e0     	mov	x0, x2
  7a37b4: 97f1cf7d     	bl	0x4175a8 <.text+0xc378>
  7a37b8: 52800020     	mov	w0, #0x1                // =1
  7a37bc: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7a37c0: d65f03c0     	ret
  7a37c4: d10043ff     	sub	sp, sp, #0x10
  7a37c8: f90007e0     	str	x0, [sp, #0x8]
  7a37cc: f94007e0     	ldr	x0, [sp, #0x8]
  7a37d0: b9404c00     	ldr	w0, [x0, #0x4c]
  7a37d4: 7100001f     	cmp	w0, #0x0
  7a37d8: 54000720     	b.eq	0x7a38bc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x89b90>
  7a37dc: f94007e0     	ldr	x0, [sp, #0x8]
  7a37e0: b9406401     	ldr	w1, [x0, #0x64]
  7a37e4: f94007e0     	ldr	x0, [sp, #0x8]
  7a37e8: b9405000     	ldr	w0, [x0, #0x50]
  7a37ec: 6b00003f     	cmp	w1, w0
  7a37f0: 540000e2     	b.hs	0x7a380c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x89ae0>
  7a37f4: f94007e0     	ldr	x0, [sp, #0x8]
  7a37f8: b9406400     	ldr	w0, [x0, #0x64]
  7a37fc: 11000401     	add	w1, w0, #0x1
  7a3800: f94007e0     	ldr	x0, [sp, #0x8]
  7a3804: b9006401     	str	w1, [x0, #0x64]
  7a3808: 1400002d     	b	0x7a38bc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x89b90>
  7a380c: f94007e0     	ldr	x0, [sp, #0x8]
  7a3810: b900641f     	str	wzr, [x0, #0x64]
  7a3814: f94007e0     	ldr	x0, [sp, #0x8]
  7a3818: b9408001     	ldr	w1, [x0, #0x80]
  7a381c: f94007e0     	ldr	x0, [sp, #0x8]
  7a3820: b9407c00     	ldr	w0, [x0, #0x7c]
  7a3824: f94007e2     	ldr	x2, [sp, #0x8]
  7a3828: 2a0003e0     	mov	w0, w0
  7a382c: 91008000     	add	x0, x0, #0x20
  7a3830: d37ef400     	lsl	x0, x0, #2
  7a3834: 8b000040     	add	x0, x2, x0
  7a3838: b9400400     	ldr	w0, [x0, #0x4]
  7a383c: 6b00003f     	cmp	w1, w0
  7a3840: 54000201     	b.ne	0x7a3880 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x89b54>
  7a3844: f94007e0     	ldr	x0, [sp, #0x8]
  7a3848: b9407c00     	ldr	w0, [x0, #0x7c]
  7a384c: 11000401     	add	w1, w0, #0x1
  7a3850: f94007e0     	ldr	x0, [sp, #0x8]
  7a3854: b9007c01     	str	w1, [x0, #0x7c]
  7a3858: f94007e0     	ldr	x0, [sp, #0x8]
  7a385c: b9405400     	ldr	w0, [x0, #0x54]
  7a3860: 7100001f     	cmp	w0, #0x0
  7a3864: 54000061     	b.ne	0x7a3870 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x89b44>
  7a3868: 52800020     	mov	w0, #0x1                // =1
  7a386c: 14000002     	b	0x7a3874 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x89b48>
  7a3870: 52800000     	mov	w0, #0x0                // =0
  7a3874: f94007e1     	ldr	x1, [sp, #0x8]
  7a3878: b9008020     	str	w0, [x1, #0x80]
  7a387c: 14000006     	b	0x7a3894 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x89b68>
  7a3880: f94007e0     	ldr	x0, [sp, #0x8]
  7a3884: b9408000     	ldr	w0, [x0, #0x80]
  7a3888: 11000401     	add	w1, w0, #0x1
  7a388c: f94007e0     	ldr	x0, [sp, #0x8]
  7a3890: b9008001     	str	w1, [x0, #0x80]
  7a3894: f94007e0     	ldr	x0, [sp, #0x8]
  7a3898: b9408000     	ldr	w0, [x0, #0x80]
  7a389c: f94007e1     	ldr	x1, [sp, #0x8]
  7a38a0: 2a0003e0     	mov	w0, w0
  7a38a4: 91005000     	add	x0, x0, #0x14
  7a38a8: d37ef400     	lsl	x0, x0, #2
  7a38ac: 8b000020     	add	x0, x1, x0
  7a38b0: b9400401     	ldr	w1, [x0, #0x4]
  7a38b4: f94007e0     	ldr	x0, [sp, #0x8]
  7a38b8: b9005001     	str	w1, [x0, #0x50]
  7a38bc: f94007e0     	ldr	x0, [sp, #0x8]
  7a38c0: b9404c00     	ldr	w0, [x0, #0x4c]
  7a38c4: 11000401     	add	w1, w0, #0x1
  7a38c8: f94007e0     	ldr	x0, [sp, #0x8]
  7a38cc: b9004c01     	str	w1, [x0, #0x4c]
  7a38d0: 52800020     	mov	w0, #0x1                // =1
  7a38d4: 910043ff     	add	sp, sp, #0x10
  7a38d8: d65f03c0     	ret
  7a38dc: d10043ff     	sub	sp, sp, #0x10
  7a38e0: f90007e0     	str	x0, [sp, #0x8]
  7a38e4: f94007e0     	ldr	x0, [sp, #0x8]
  7a38e8: b9404801     	ldr	w1, [x0, #0x48]
  7a38ec: f94007e0     	ldr	x0, [sp, #0x8]
  7a38f0: b9404c00     	ldr	w0, [x0, #0x4c]
  7a38f4: 6b00003f     	cmp	w1, w0
  7a38f8: 1a9f87e0     	cset	w0, ls
  7a38fc: 12001c00     	and	w0, w0, #0xff
  7a3900: 910043ff     	add	sp, sp, #0x10
  7a3904: d65f03c0     	ret
  7a3908: d10043ff     	sub	sp, sp, #0x10
  7a390c: f90007e0     	str	x0, [sp, #0x8]
  7a3910: f94007e0     	ldr	x0, [sp, #0x8]
  7a3914: b9404801     	ldr	w1, [x0, #0x48]
  7a3918: f94007e0     	ldr	x0, [sp, #0x8]
  7a391c: b9004c01     	str	w1, [x0, #0x4c]
  7a3920: 52800020     	mov	w0, #0x1                // =1
  7a3924: 910043ff     	add	sp, sp, #0x10
  7a3928: d65f03c0     	ret
  7a392c: d10043ff     	sub	sp, sp, #0x10
  7a3930: f90007e0     	str	x0, [sp, #0x8]
  7a3934: 52800000     	mov	w0, #0x0                // =0
  7a3938: 910043ff     	add	sp, sp, #0x10
  7a393c: d65f03c0     	ret
  7a3940: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  7a3944: 910003fd     	mov	x29, sp
  7a3948: f9000fe0     	str	x0, [sp, #0x18]
  7a394c: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3950: b9404c00     	ldr	w0, [x0, #0x4c]
  7a3954: 7100001f     	cmp	w0, #0x0
  7a3958: 54000221     	b.ne	0x7a399c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x89c70>
  7a395c: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3960: f9402000     	ldr	x0, [x0, #0x40]
  7a3964: 91304000     	add	x0, x0, #0xc10
  7a3968: 52807d01     	mov	w1, #0x3e8              // =1000
  7a396c: 97f1cf0f     	bl	0x4175a8 <.text+0xc378>
  7a3970: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3974: f9402000     	ldr	x0, [x0, #0x40]
  7a3978: 91294000     	add	x0, x0, #0xa50
  7a397c: 52804021     	mov	w1, #0x201              // =513
  7a3980: 97f1cf0a     	bl	0x4175a8 <.text+0xc378>
  7a3984: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3988: f9402000     	ldr	x0, [x0, #0x40]
  7a398c: 912cc000     	add	x0, x0, #0xb30
  7a3990: 52800201     	mov	w1, #0x10               // =16
  7a3994: 97f1cf05     	bl	0x4175a8 <.text+0xc378>
  7a3998: 14000034     	b	0x7a3a68 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x89d3c>
  7a399c: f9400fe0     	ldr	x0, [sp, #0x18]
  7a39a0: b9407c00     	ldr	w0, [x0, #0x7c]
  7a39a4: f9400fe1     	ldr	x1, [sp, #0x18]
  7a39a8: 2a0003e0     	mov	w0, w0
  7a39ac: 91006000     	add	x0, x0, #0x18
  7a39b0: d37ef400     	lsl	x0, x0, #2
  7a39b4: 8b000020     	add	x0, x1, x0
  7a39b8: b9400800     	ldr	w0, [x0, #0x8]
  7a39bc: f9400fe1     	ldr	x1, [sp, #0x18]
  7a39c0: b9408021     	ldr	w1, [x1, #0x80]
  7a39c4: 52800022     	mov	w2, #0x1                // =1
  7a39c8: 1ac12041     	lsl	w1, w2, w1
  7a39cc: 53185c21     	lsl	w1, w1, #8
  7a39d0: 2a010000     	orr	w0, w0, w1
  7a39d4: b9002fe0     	str	w0, [sp, #0x2c]
  7a39d8: f9400fe0     	ldr	x0, [sp, #0x18]
  7a39dc: f9402000     	ldr	x0, [x0, #0x40]
  7a39e0: 91304000     	add	x0, x0, #0xc10
  7a39e4: 52800021     	mov	w1, #0x1                // =1
  7a39e8: 97f1cef0     	bl	0x4175a8 <.text+0xc378>
  7a39ec: f9400fe0     	ldr	x0, [sp, #0x18]
  7a39f0: f9402000     	ldr	x0, [x0, #0x40]
  7a39f4: 91294002     	add	x2, x0, #0xa50
  7a39f8: b9402fe0     	ldr	w0, [sp, #0x2c]
  7a39fc: 11000400     	add	w0, w0, #0x1
  7a3a00: 2a0003e1     	mov	w1, w0
  7a3a04: aa0203e0     	mov	x0, x2
  7a3a08: 97f1cee8     	bl	0x4175a8 <.text+0xc378>
  7a3a0c: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3a10: f9402000     	ldr	x0, [x0, #0x40]
  7a3a14: 912cc002     	add	x2, x0, #0xb30
  7a3a18: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3a1c: b9406400     	ldr	w0, [x0, #0x64]
  7a3a20: 52800021     	mov	w1, #0x1                // =1
  7a3a24: 1ac02020     	lsl	w0, w1, w0
  7a3a28: 2a0003e1     	mov	w1, w0
  7a3a2c: aa0203e0     	mov	x0, x2
  7a3a30: 97f1cede     	bl	0x4175a8 <.text+0xc378>
  7a3a34: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3a38: b9405000     	ldr	w0, [x0, #0x50]
  7a3a3c: 7100001f     	cmp	w0, #0x0
  7a3a40: 54000141     	b.ne	0x7a3a68 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x89d3c>
  7a3a44: 52801c23     	mov	w3, #0xe1               // =225
  7a3a48: d0002e80     	adrp	x0, 0xd75000
  7a3a4c: 910e0002     	add	x2, x0, #0x380
  7a3a50: d0002e80     	adrp	x0, 0xd75000
  7a3a54: 910f0001     	add	x1, x0, #0x3c0
  7a3a58: d0002e80     	adrp	x0, 0xd75000
  7a3a5c: 910f4000     	add	x0, x0, #0x3d0
  7a3a60: 97f19ac8     	bl	0x40a580 <printf@plt>
  7a3a64: 97ff2329     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  7a3a68: 52800020     	mov	w0, #0x1                // =1
  7a3a6c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  7a3a70: d65f03c0     	ret
  7a3a74: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7a3a78: 910003fd     	mov	x29, sp
  7a3a7c: f9000fe0     	str	x0, [sp, #0x18]
  7a3a80: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3a84: f9401c03     	ldr	x3, [x0, #0x38]
  7a3a88: f9400fe0     	ldr	x0, [sp, #0x18]
  7a3a8c: f9401c00     	ldr	x0, [x0, #0x38]
  7a3a90: f9400000     	ldr	x0, [x0]
  7a3a94: 91012000     	add	x0, x0, #0x48
  7a3a98: f9400002     	ldr	x2, [x0]
  7a3a9c: 52800021     	mov	w1, #0x1                // =1
  7a3aa0: aa0303e0     	mov	x0, x3
  7a3aa4: d63f0040     	blr	x2
  7a3aa8: 52800020     	mov	w0, #0x1                // =1
  7a3aac: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7a3ab0: d65f03c0     	ret
  7a3ab4: d10043ff     	sub	sp, sp, #0x10
  7a3ab8: f90007e0     	str	x0, [sp, #0x8]
  7a3abc: 52800020     	mov	w0, #0x1                // =1
  7a3ac0: 910043ff     	add	sp, sp, #0x10
  7a3ac4: d65f03c0     	ret
