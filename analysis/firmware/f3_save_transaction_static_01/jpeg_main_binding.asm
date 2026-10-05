  424b80: 52800022     	mov	w2, #0x1                // =1
  424b84: 52800141     	mov	w1, #0xa                // =10
  424b88: f94233e0     	ldr	x0, [sp, #0x460]
  424b8c: 940ca632     	bl	0x74e454 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x34728>
  424b90: aa0003f4     	mov	x20, x0
  424b94: d2807e00     	mov	x0, #0x3f0              // =1008
  424b98: f2a0c800     	movk	x0, #0x640, lsl #16
  424b9c: 97ff94b1     	bl	0x409e60 <_Znwm@plt>
  424ba0: aa0003f3     	mov	x19, x0
  424ba4: f94d83e0     	ldr	x0, [sp, #0x1b00]
  424ba8: 91004000     	add	x0, x0, #0x10
  424bac: f9400000     	ldr	x0, [x0]
  424bb0: f942cbe1     	ldr	x1, [sp, #0x590]
  424bb4: aa1403e5     	mov	x5, x20
  424bb8: f94f77e4     	ldr	x4, [sp, #0x1ee8]
  424bbc: f94f6fe3     	ldr	x3, [sp, #0x1ed8]
  424bc0: aa0103e2     	mov	x2, x1
  424bc4: aa0003e1     	mov	x1, x0
  424bc8: aa1303e0     	mov	x0, x19
  424bcc: 9412ef57     	bl	0x8e0928 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3a0fc>
  424bd0: f9083bf3     	str	x19, [sp, #0x1070]
