  7b77e0: b9065fe0     	str	w0, [sp, #0x65c]
  7b77e4: 39591fe0     	ldrb	w0, [sp, #0x647]
  7b77e8: 52000000     	eor	w0, w0, #0x1
  7b77ec: 12001c00     	and	w0, w0, #0xff
  7b77f0: 7100001f     	cmp	w0, #0x0
  7b77f4: 54001120     	b.eq	0x7b7a18 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9dcec>
  7b77f8: f90317ff     	str	xzr, [sp, #0x628]
  7b77fc: f90313ff     	str	xzr, [sp, #0x620]
  7b7800: f94223e0     	ldr	x0, [sp, #0x440]
  7b7804: f100001f     	cmp	x0, #0x0
  7b7808: 540000e0     	b.eq	0x7b7824 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9daf8>
  7b780c: f9422fe0     	ldr	x0, [sp, #0x458]
  7b7810: 94042b6c     	bl	0x8c25c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd94>
  7b7814: f90327e0     	str	x0, [sp, #0x648]
  7b7818: f94223e0     	ldr	x0, [sp, #0x440]
  7b781c: 97f3761e     	bl	0x495094 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f0e8>
  7b7820: f90317e0     	str	x0, [sp, #0x628]
  7b7824: f9422fe0     	ldr	x0, [sp, #0x458]
  7b7828: f100001f     	cmp	x0, #0x0
  7b782c: 54000140     	b.eq	0x7b7854 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9db28>
  7b7830: f9422fe0     	ldr	x0, [sp, #0x458]
  7b7834: 94042bc7     	bl	0x8c2750 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bf24>
  7b7838: f9032be0     	str	x0, [sp, #0x650]
  7b783c: f9432be0     	ldr	x0, [sp, #0x650]
  7b7840: f100001f     	cmp	x0, #0x0
  7b7844: 54000080     	b.eq	0x7b7854 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9db28>
  7b7848: f9432be0     	ldr	x0, [sp, #0x650]
  7b784c: 97f37618     	bl	0x4950ac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f100>
  7b7850: f90313e0     	str	x0, [sp, #0x620]
  7b7854: f94313e0     	ldr	x0, [sp, #0x620]
  7b7858: f100001f     	cmp	x0, #0x0
  7b785c: 54000080     	b.eq	0x7b786c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9db40>
  7b7860: f94317e0     	ldr	x0, [sp, #0x628]
  7b7864: f100001f     	cmp	x0, #0x0
  7b7868: 54000381     	b.ne	0x7b78d8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9dbac>
  7b786c: f94313e0     	ldr	x0, [sp, #0x620]
  7b7870: f100001f     	cmp	x0, #0x0
  7b7874: 54000060     	b.eq	0x7b7880 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9db54>
  7b7878: f9422fe0     	ldr	x0, [sp, #0x458]
  7b787c: 94042bd9     	bl	0x8c27e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bfb4>
  7b7880: f94317e0     	ldr	x0, [sp, #0x628]
  7b7884: f100001f     	cmp	x0, #0x0
  7b7888: 54000060     	b.eq	0x7b7894 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9db68>
  7b788c: f9422fe0     	ldr	x0, [sp, #0x458]
  7b7890: 94042b76     	bl	0x8c2668 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1be3c>
  7b7894: 391003ff     	strb	wzr, [sp, #0x400]
  7b7898: f9402fe1     	ldr	x1, [sp, #0x58]
  7b789c: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b78a0: 8b000020     	add	x0, x1, x0
  7b78a4: f97c8c00     	ldr	x0, [x0, #0x7918]
  7b78a8: 91078013     	add	x19, x0, #0x1e0
  7b78ac: 911003e1     	add	x1, sp, #0x400
  7b78b0: 9112a3e0     	add	x0, sp, #0x4a8
  7b78b4: 97f35d2f     	bl	0x48ed70 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x58dc4>
  7b78b8: 9112a3e0     	add	x0, sp, #0x4a8
  7b78bc: aa0003e1     	mov	x1, x0
  7b78c0: aa1303e0     	mov	x0, x19
  7b78c4: 97f361cd     	bl	0x48fff8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5a04c>
  7b78c8: 9112a3e0     	add	x0, sp, #0x4a8
  7b78cc: 97f35d20     	bl	0x48ed4c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x58da0>
  7b78d0: 52800013     	mov	w19, #0x0               // =0
  7b78d4: 14000297     	b	0x7b8330 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9e604>
  7b78d8: f9402fe1     	ldr	x1, [sp, #0x58]
  7b78dc: d28f2700     	mov	x0, #0x7938             // =31032
  7b78e0: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b78e4: 8b000020     	add	x0, x1, x0
  7b78e8: f94313e3     	ldr	x3, [sp, #0x620]
  7b78ec: f94317e2     	ldr	x2, [sp, #0x628]
  7b78f0: aa0003e1     	mov	x1, x0
  7b78f4: f9402fe0     	ldr	x0, [sp, #0x58]
  7b78f8: 94000c79     	bl	0x7baadc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa0db0>
  7b78fc: f94317e0     	ldr	x0, [sp, #0x628]
  7b7900: 9140b000     	add	x0, x0, #0x2c, lsl #12  // =0x2c000
  7b7904: b9588c00     	ldr	w0, [x0, #0x188c]
