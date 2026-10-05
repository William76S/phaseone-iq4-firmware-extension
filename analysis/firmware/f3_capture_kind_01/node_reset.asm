
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000008a682c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_>:
  8c32d8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c32dc: 910003fd     	mov	x29, sp
  8c32e0: f9000fe0     	str	x0, [sp, #0x18]
  8c32e4: b001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c32e8: 9109a000     	add	x0, x0, #0x268
  8c32ec: f9400000     	ldr	x0, [x0]
  8c32f0: f9400fe1     	ldr	x1, [sp, #0x18]
  8c32f4: 94000abd     	bl	0x8c5de8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f5bc>
  8c32f8: d503201f     	nop
  8c32fc: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c3300: d65f03c0     	ret
  8c3304: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c3308: 910003fd     	mov	x29, sp
  8c330c: b9001fe0     	str	w0, [sp, #0x1c]
  8c3310: b9001be1     	str	w1, [sp, #0x18]
  8c3314: b9401fe0     	ldr	w0, [sp, #0x1c]
  8c3318: 7100041f     	cmp	w0, #0x1
  8c331c: 540013e1     	b.ne	0x8c3598 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1cd6c>
  8c3320: b9401be1     	ldr	w1, [sp, #0x18]
  8c3324: 529fffe0     	mov	w0, #0xffff             // =65535
  8c3328: 6b00003f     	cmp	w1, w0
  8c332c: 54001361     	b.ne	0x8c3598 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1cd6c>
  8c3330: 52800004     	mov	w4, #0x0                // =0
  8c3334: 52800003     	mov	w3, #0x0                // =0
  8c3338: 52800002     	mov	w2, #0x0                // =0
  8c333c: 12800001     	mov	w1, #-0x1               // =-1
  8c3340: b001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c3344: 9109e000     	add	x0, x0, #0x278
  8c3348: 97ed3c21     	bl	0x4123cc <.text+0x719c>
  8c334c: 12800004     	mov	w4, #-0x1               // =-1
  8c3350: 12800003     	mov	w3, #-0x1               // =-1
  8c3354: 12800002     	mov	w2, #-0x1               // =-1
  8c3358: 12800001     	mov	w1, #-0x1               // =-1
  8c335c: b001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c3360: 910a0000     	add	x0, x0, #0x280
  8c3364: 97ed3c1a     	bl	0x4123cc <.text+0x719c>
  8c3368: 52800004     	mov	w4, #0x0                // =0
  8c336c: 52800003     	mov	w3, #0x0                // =0
  8c3370: 12800002     	mov	w2, #-0x1               // =-1
  8c3374: 12800001     	mov	w1, #-0x1               // =-1
  8c3378: b001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c337c: 910a2000     	add	x0, x0, #0x288
  8c3380: 97ed3c13     	bl	0x4123cc <.text+0x719c>
  8c3384: 12800004     	mov	w4, #-0x1               // =-1
  8c3388: 52800003     	mov	w3, #0x0                // =0
  8c338c: 12800002     	mov	w2, #-0x1               // =-1
  8c3390: 12800001     	mov	w1, #-0x1               // =-1
  8c3394: b001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c3398: 910a4000     	add	x0, x0, #0x290
  8c339c: 97ed3c0c     	bl	0x4123cc <.text+0x719c>
  8c33a0: 12800fe4     	mov	w4, #-0x80              // =-128
  8c33a4: 52800003     	mov	w3, #0x0                // =0
  8c33a8: 12800fe2     	mov	w2, #-0x80              // =-128
  8c33ac: 12800001     	mov	w1, #-0x1               // =-1
  8c33b0: b001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c33b4: 910a6000     	add	x0, x0, #0x298
  8c33b8: 97ed3c05     	bl	0x4123cc <.text+0x719c>
  8c33bc: 52800004     	mov	w4, #0x0                // =0
  8c33c0: 12800003     	mov	w3, #-0x1               // =-1
  8c33c4: 52800002     	mov	w2, #0x0                // =0
  8c33c8: 12800001     	mov	w1, #-0x1               // =-1
  8c33cc: b001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c33d0: 910a8000     	add	x0, x0, #0x2a0
  8c33d4: 97ed3bfe     	bl	0x4123cc <.text+0x719c>
  8c33d8: 12800004     	mov	w4, #-0x1               // =-1
  8c33dc: 52800003     	mov	w3, #0x0                // =0
  8c33e0: 52800002     	mov	w2, #0x0                // =0
