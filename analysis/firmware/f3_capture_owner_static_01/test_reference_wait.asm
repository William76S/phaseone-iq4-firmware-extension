  8c5a18: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  8c5a1c: 910003fd     	mov	x29, sp
  8c5a20: f9000fe0     	str	x0, [sp, #0x18]
  8c5a24: f9000be1     	str	x1, [sp, #0x10]
  8c5a28: f9400be0     	ldr	x0, [sp, #0x10]
  8c5a2c: f9404400     	ldr	x0, [x0, #0x88]
  8c5a30: f100001f     	cmp	x0, #0x0
  8c5a34: 54000fe0     	b.eq	0x8c5c30 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f404>
  8c5a38: b9002fff     	str	wzr, [sp, #0x2c]
  8c5a3c: 3900afff     	strb	wzr, [sp, #0x2b]
  8c5a40: f9400be0     	ldr	x0, [sp, #0x10]
  8c5a44: f9404400     	ldr	x0, [x0, #0x88]
  8c5a48: b9401800     	ldr	w0, [x0, #0x18]
  8c5a4c: 7100041f     	cmp	w0, #0x1
  8c5a50: 54000e09     	b.ls	0x8c5c10 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f3e4>
  8c5a54: f0002760     	adrp	x0, 0xdb4000
  8c5a58: 911a8002     	add	x2, x0, #0x6a0
  8c5a5c: 52801481     	mov	w1, #0xa4               // =164
  8c5a60: f0002760     	adrp	x0, 0xdb4000
  8c5a64: 9113e000     	add	x0, x0, #0x4f8
  8c5a68: 97fa028d     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  8c5a6c: b9002fff     	str	wzr, [sp, #0x2c]
  8c5a70: b9402fe0     	ldr	w0, [sp, #0x2c]
  8c5a74: 710f9c1f     	cmp	w0, #0x3e7
  8c5a78: 5400074c     	b.gt	0x8c5b60 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f334>
  8c5a7c: 52800140     	mov	w0, #0xa                // =10
  8c5a80: 97f92bee     	bl	0x710a38 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x229b8>
  8c5a84: f9400be0     	ldr	x0, [sp, #0x10]
  8c5a88: f9404400     	ldr	x0, [x0, #0x88]
  8c5a8c: b9401800     	ldr	w0, [x0, #0x18]
  8c5a90: 7100041f     	cmp	w0, #0x1
  8c5a94: 540003a1     	b.ne	0x8c5b08 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f2dc>
  8c5a98: 52800020     	mov	w0, #0x1                // =1
  8c5a9c: 3900afe0     	strb	w0, [sp, #0x2b]
  8c5aa0: f001c9a0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c5aa4: 910f5000     	add	x0, x0, #0x3d4
  8c5aa8: b9400000     	ldr	w0, [x0]
  8c5aac: b9402fe1     	ldr	w1, [sp, #0x2c]
  8c5ab0: 6b00003f     	cmp	w1, w0
  8c5ab4: 5400054d     	b.le	0x8c5b5c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f330>
  8c5ab8: f001c9a0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c5abc: 910f5000     	add	x0, x0, #0x3d4
  8c5ac0: b9402fe1     	ldr	w1, [sp, #0x2c]
  8c5ac4: b9000001     	str	w1, [x0]
  8c5ac8: f001c9a0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c5acc: 910f5000     	add	x0, x0, #0x3d4
  8c5ad0: b9400001     	ldr	w1, [x0]
  8c5ad4: 2a0103e0     	mov	w0, w1
  8c5ad8: 531e7400     	lsl	w0, w0, #2
  8c5adc: 0b010000     	add	w0, w0, w1
  8c5ae0: 531f7800     	lsl	w0, w0, #1
  8c5ae4: 2a0003e4     	mov	w4, w0
  8c5ae8: f0002760     	adrp	x0, 0xdb4000
  8c5aec: 911b8003     	add	x3, x0, #0x6e0
  8c5af0: 528015c2     	mov	w2, #0xae               // =174
  8c5af4: f0002760     	adrp	x0, 0xdb4000
  8c5af8: 9113e001     	add	x1, x0, #0x4f8
  8c5afc: 52800040     	mov	w0, #0x2                // =2
  8c5b00: 97fa0293     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8c5b04: 14000016     	b	0x8c5b5c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f330>
  8c5b08: b9402fe0     	ldr	w0, [sp, #0x2c]
  8c5b0c: 7100281f     	cmp	w0, #0xa
  8c5b10: 540001e1     	b.ne	0x8c5b4c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f320>
  8c5b14: f9400be0     	ldr	x0, [sp, #0x10]
  8c5b18: b940dc01     	ldr	w1, [x0, #0xdc]
  8c5b1c: f9400be0     	ldr	x0, [sp, #0x10]
  8c5b20: f9404400     	ldr	x0, [x0, #0x88]
  8c5b24: b9401800     	ldr	w0, [x0, #0x18]
  8c5b28: 2a0003e5     	mov	w5, w0
  8c5b2c: 2a0103e4     	mov	w4, w1
  8c5b30: f0002760     	adrp	x0, 0xdb4000
  8c5b34: 911c0003     	add	x3, x0, #0x700
  8c5b38: 528016a2     	mov	w2, #0xb5               // =181
  8c5b3c: f0002760     	adrp	x0, 0xdb4000
  8c5b40: 9113e001     	add	x1, x0, #0x4f8
  8c5b44: 52800040     	mov	w0, #0x2                // =2
  8c5b48: 97fa0281     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8c5b4c: b9402fe0     	ldr	w0, [sp, #0x2c]
  8c5b50: 11000400     	add	w0, w0, #0x1
  8c5b54: b9002fe0     	str	w0, [sp, #0x2c]
  8c5b58: 17ffffc6     	b	0x8c5a70 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f244>
  8c5b5c: d503201f     	nop
  8c5b60: 3940afe0     	ldrb	w0, [sp, #0x2b]
  8c5b64: 52000000     	eor	w0, w0, #0x1
  8c5b68: 12001c00     	and	w0, w0, #0xff
  8c5b6c: 7100001f     	cmp	w0, #0x0
  8c5b70: 54000200     	b.eq	0x8c5bb0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f384>
  8c5b74: f9400be0     	ldr	x0, [sp, #0x10]
  8c5b78: b940dc01     	ldr	w1, [x0, #0xdc]
  8c5b7c: f9400be0     	ldr	x0, [sp, #0x10]
  8c5b80: f9404400     	ldr	x0, [x0, #0x88]
  8c5b84: b9401800     	ldr	w0, [x0, #0x18]
  8c5b88: 2a0003e5     	mov	w5, w0
  8c5b8c: 2a0103e4     	mov	w4, w1
  8c5b90: f0002760     	adrp	x0, 0xdb4000
  8c5b94: 911cc003     	add	x3, x0, #0x730
  8c5b98: 52801762     	mov	w2, #0xbb               // =187
  8c5b9c: f0002760     	adrp	x0, 0xdb4000
  8c5ba0: 9113e001     	add	x1, x0, #0x4f8
  8c5ba4: 52800080     	mov	w0, #0x4                // =4
  8c5ba8: 97fa0269     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8c5bac: 14000019     	b	0x8c5c10 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f3e4>
  8c5bb0: b9402fe0     	ldr	w0, [sp, #0x2c]
  8c5bb4: 7100281f     	cmp	w0, #0xa
  8c5bb8: 540002cd     	b.le	0x8c5c10 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f3e4>
  8c5bbc: b9402fe1     	ldr	w1, [sp, #0x2c]
  8c5bc0: 2a0103e0     	mov	w0, w1
  8c5bc4: 531e7400     	lsl	w0, w0, #2
  8c5bc8: 0b010000     	add	w0, w0, w1
  8c5bcc: 531f7800     	lsl	w0, w0, #1
  8c5bd0: 2a0003e2     	mov	w2, w0
  8c5bd4: f9400be0     	ldr	x0, [sp, #0x10]
  8c5bd8: b940dc01     	ldr	w1, [x0, #0xdc]
  8c5bdc: f9400be0     	ldr	x0, [sp, #0x10]
  8c5be0: f9404400     	ldr	x0, [x0, #0x88]
  8c5be4: b9401800     	ldr	w0, [x0, #0x18]
  8c5be8: 2a0003e6     	mov	w6, w0
  8c5bec: 2a0103e5     	mov	w5, w1
  8c5bf0: 2a0203e4     	mov	w4, w2
  8c5bf4: f0002760     	adrp	x0, 0xdb4000
  8c5bf8: 911e2003     	add	x3, x0, #0x788
  8c5bfc: 52801822     	mov	w2, #0xc1               // =193
  8c5c00: f0002760     	adrp	x0, 0xdb4000
  8c5c04: 9113e001     	add	x1, x0, #0x4f8
  8c5c08: 52808000     	mov	w0, #0x400              // =1024
  8c5c0c: 97fa0250     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8c5c10: f9400be0     	ldr	x0, [sp, #0x10]
  8c5c14: 97fff2b1     	bl	0x8c26d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1beac>
  8c5c18: f9400be0     	ldr	x0, [sp, #0x10]
  8c5c1c: f9404400     	ldr	x0, [x0, #0x88]
  8c5c20: f100001f     	cmp	x0, #0x0
  8c5c24: 54000060     	b.eq	0x8c5c30 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f404>
  8c5c28: f9400be0     	ldr	x0, [sp, #0x10]
  8c5c2c: 97fff28f     	bl	0x8c2668 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1be3c>
  8c5c30: f9400be0     	ldr	x0, [sp, #0x10]
  8c5c34: f9404800     	ldr	x0, [x0, #0x90]
