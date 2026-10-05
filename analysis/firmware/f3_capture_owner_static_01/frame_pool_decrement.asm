  8c387c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  8c3880: 910003fd     	mov	x29, sp
  8c3884: f9000bf3     	str	x19, [sp, #0x10]
  8c3888: f90017e0     	str	x0, [sp, #0x28]
  8c388c: f90013e1     	str	x1, [sp, #0x20]
  8c3890: 9100e3e0     	add	x0, sp, #0x38
  8c3894: 97f93bbf     	bl	0x712790 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24710>
  8c3898: f94013e0     	ldr	x0, [sp, #0x20]
  8c389c: f100001f     	cmp	x0, #0x0
  8c38a0: 54000141     	b.ne	0x8c38c8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d09c>
  8c38a4: 52800d23     	mov	w3, #0x69               // =105
  8c38a8: b0002780     	adrp	x0, 0xdb4000
  8c38ac: 91026002     	add	x2, x0, #0x98
  8c38b0: b0002780     	adrp	x0, 0xdb4000
  8c38b4: 9103c001     	add	x1, x0, #0xf0
  8c38b8: 90002780     	adrp	x0, 0xdb3000
  8c38bc: 913b8000     	add	x0, x0, #0xee0
  8c38c0: 97ed1b30     	bl	0x40a580 <printf@plt>
  8c38c4: 97faa391     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c38c8: f94013e0     	ldr	x0, [sp, #0x20]
  8c38cc: b9401800     	ldr	w0, [x0, #0x18]
  8c38d0: 7100001f     	cmp	w0, #0x0
  8c38d4: 54000201     	b.ne	0x8c3914 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d0e8>
  8c38d8: f94017e0     	ldr	x0, [sp, #0x28]
  8c38dc: f9404001     	ldr	x1, [x0, #0x80]
  8c38e0: f94013e2     	ldr	x2, [sp, #0x20]
  8c38e4: f94013e0     	ldr	x0, [sp, #0x20]
  8c38e8: b9401800     	ldr	w0, [x0, #0x18]
  8c38ec: 2a0003e6     	mov	w6, w0
  8c38f0: aa0203e5     	mov	x5, x2
  8c38f4: aa0103e4     	mov	x4, x1
  8c38f8: b0002780     	adrp	x0, 0xdb4000
  8c38fc: 9103e003     	add	x3, x0, #0xf8
  8c3900: 52800da2     	mov	w2, #0x6d               // =109
  8c3904: b0002780     	adrp	x0, 0xdb4000
  8c3908: 91026001     	add	x1, x0, #0x98
  8c390c: 52800080     	mov	w0, #0x4                // =4
  8c3910: 97fa0b0f     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8c3914: f94013e0     	ldr	x0, [sp, #0x20]
  8c3918: b9401801     	ldr	w1, [x0, #0x18]
  8c391c: 51000421     	sub	w1, w1, #0x1
  8c3920: b9001801     	str	w1, [x0, #0x18]
  8c3924: f94013e0     	ldr	x0, [sp, #0x20]
  8c3928: b9401800     	ldr	w0, [x0, #0x18]
  8c392c: 7100001f     	cmp	w0, #0x0
  8c3930: 540001a1     	b.ne	0x8c3964 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d138>
  8c3934: f94017e0     	ldr	x0, [sp, #0x28]
  8c3938: 91002002     	add	x2, x0, #0x8
  8c393c: f94013e0     	ldr	x0, [sp, #0x20]
  8c3940: f100001f     	cmp	x0, #0x0
  8c3944: 54000080     	b.eq	0x8c3954 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d128>
  8c3948: f94013e0     	ldr	x0, [sp, #0x20]
  8c394c: 91012000     	add	x0, x0, #0x48
  8c3950: 14000002     	b	0x8c3958 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d12c>
  8c3954: d2800000     	mov	x0, #0x0                // =0
  8c3958: aa0003e1     	mov	x1, x0
  8c395c: aa0203e0     	mov	x0, x2
  8c3960: 9400052d     	bl	0x8c4e14 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1e5e8>
  8c3964: 9100e3e0     	add	x0, sp, #0x38
  8c3968: 97f93b97     	bl	0x7127c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24744>
  8c396c: 14000006     	b	0x8c3984 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d158>
  8c3970: aa0003f3     	mov	x19, x0
  8c3974: 9100e3e0     	add	x0, sp, #0x38
  8c3978: 97f93b93     	bl	0x7127c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24744>
  8c397c: aa1303e0     	mov	x0, x19
  8c3980: 97ed1b74     	bl	0x40a750 <_Unwind_Resume@plt>
  8c3984: f9400bf3     	ldr	x19, [sp, #0x10]
  8c3988: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  8c398c: d65f03c0     	ret
