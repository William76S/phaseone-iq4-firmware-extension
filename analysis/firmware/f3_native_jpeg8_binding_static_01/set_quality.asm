INPUT_SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
STATIC_ONLY_NEAREST_LABELS_NOT_AUTHORITATIVE

/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000009770a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm>:
  9a2fc8: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  9a2fcc: 7100003f     	cmp	w1, #0x0
  9a2fd0: 910003fd     	mov	x29, sp
  9a2fd4: a90153f3     	stp	x19, x20, [sp, #0x10]
  9a2fd8: 2a0203f3     	mov	w19, w2
  9a2fdc: a9025bf5     	stp	x21, x22, [sp, #0x20]
  9a2fe0: aa0003f6     	mov	x22, x0
  9a2fe4: 5400086d     	b.le	0x9a30f0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c050>
  9a2fe8: 7101903f     	cmp	w1, #0x64
  9a2fec: 5400076d     	b.le	0x9a30d8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c038>
  9a2ff0: d2800014     	mov	x20, #0x0               // =0
  9a2ff4: 52800003     	mov	w3, #0x0                // =0
  9a2ff8: 90002195     	adrp	x21, 0xdd2000
  9a2ffc: 9104c2b5     	add	x21, x21, #0x130
  9a3000: 52800001     	mov	w1, #0x0                // =0
  9a3004: aa1503e2     	mov	x2, x21
  9a3008: 2a1303e4     	mov	w4, w19
  9a300c: aa1603e0     	mov	x0, x22
  9a3010: 97fffebc     	bl	0x9a2b00 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2ba60>
  9a3014: b94026c1     	ldr	w1, [x22, #0x24]
  9a3018: 7101903f     	cmp	w1, #0x64
  9a301c: 540000e0     	b.eq	0x9a3038 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2bf98>
  9a3020: f94002c2     	ldr	x2, [x22]
  9a3024: 528002a4     	mov	w4, #0x15               // =21
  9a3028: aa1603e0     	mov	x0, x22
  9a302c: f9400043     	ldr	x3, [x2]
  9a3030: 29050444     	stp	w4, w1, [x2, #0x28]
  9a3034: d63f0060     	blr	x3
  9a3038: f9403ec0     	ldr	x0, [x22, #0x78]
  9a303c: b40006a0     	cbz	x0, 0x9a3110 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c070>
  9a3040: d29eb867     	mov	x7, #0xf5c3             // =62915
  9a3044: d29ff9a8     	mov	x8, #0xffcd             // =65485
  9a3048: f2ab8507     	movk	x7, #0x5c28, lsl #16
  9a304c: 910402b5     	add	x21, x21, #0x100
  9a3050: f2d851e7     	movk	x7, #0xc28f, lsl #32
  9a3054: d2800002     	mov	x2, #0x0                // =0
  9a3058: f2a00628     	movk	x8, #0x31, lsl #16
  9a305c: f2e51ea7     	movk	x7, #0x28f5, lsl #48
  9a3060: d28c79a6     	mov	x6, #0x63cd             // =25549
  9a3064: d503201f     	nop
  9a3068: b8627aa3     	ldr	w3, [x21, x2, lsl #2]
  9a306c: 52800021     	mov	w1, #0x1                // =1
  9a3070: 9b147c63     	mul	x3, x3, x20
  9a3074: f100c47f     	cmp	x3, #0x31
  9a3078: 540001ed     	b.le	0x9a30b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c014>
  9a307c: 9100c864     	add	x4, x3, #0x32
  9a3080: d28fffe5     	mov	x5, #0x7fff             // =32767
  9a3084: eb08007f     	cmp	x3, x8
  9a3088: d342fc84     	lsr	x4, x4, #2
  9a308c: 540000ac     	b.gt	0x9a30a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c000>
  9a3090: eb06007f     	cmp	x3, x6
  9a3094: 9bc77c83     	umulh	x3, x4, x7
  9a3098: 1a9fd7e1     	cset	w1, gt
  9a309c: d342fc65     	lsr	x5, x3, #2
  9a30a0: 7100027f     	cmp	w19, #0x0
  9a30a4: 12003ca3     	and	w3, w5, #0xffff
  9a30a8: 7a401824     	ccmp	w1, #0x0, #0x4, ne
  9a30ac: 52801fe1     	mov	w1, #0xff               // =255
  9a30b0: 1a810061     	csel	w1, w3, w1, eq
  9a30b4: 78227801     	strh	w1, [x0, x2, lsl #1]
  9a30b8: 91000442     	add	x2, x2, #0x1
  9a30bc: f101005f     	cmp	x2, #0x40
  9a30c0: 54fffd41     	b.ne	0x9a3068 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2bfc8>
  9a30c4: a94153f3     	ldp	x19, x20, [sp, #0x10]
  9a30c8: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  9a30cc: b900801f     	str	wzr, [x0, #0x80]
  9a30d0: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  9a30d4: d65f03c0     	ret
  9a30d8: 7100c43f     	cmp	w1, #0x31
  9a30dc: 5400010c     	b.gt	0x9a30fc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c05c>
  9a30e0: 52827103     	mov	w3, #0x1388             // =5000
  9a30e4: 1ac10c63     	sdiv	w3, w3, w1
  9a30e8: 93407c74     	sxtw	x20, w3
  9a30ec: 17ffffc3     	b	0x9a2ff8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2bf58>
  9a30f0: d2827114     	mov	x20, #0x1388            // =5000
  9a30f4: 2a1403e3     	mov	w3, w20
  9a30f8: 17ffffc0     	b	0x9a2ff8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2bf58>
  9a30fc: 52800c83     	mov	w3, #0x64               // =100
  9a3100: 4b010061     	sub	w1, w3, w1
  9a3104: 531f7823     	lsl	w3, w1, #1
  9a3108: 93407c74     	sxtw	x20, w3
  9a310c: 17ffffbb     	b	0x9a2ff8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2bf58>
  9a3110: aa1603e0     	mov	x0, x22
  9a3114: 94000313     	bl	0x9a3d60 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2ccc0>
  9a3118: f9003ec0     	str	x0, [x22, #0x78]
  9a311c: 17ffffc9     	b	0x9a3040 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2bfa0>
