  8df1a0: d140abff     	sub	sp, sp, #0x2a, lsl #12  // =0x2a000
  8df1a4: a9007bfd     	stp	x29, x30, [sp]
  8df1a8: 910003fd     	mov	x29, sp
  8df1ac: f9000bf3     	str	x19, [sp, #0x10]
  8df1b0: fd000fe8     	str	d8, [sp, #0x18]
  8df1b4: f9001fe0     	str	x0, [sp, #0x38]
  8df1b8: f9001be1     	str	x1, [sp, #0x30]
  8df1bc: f90017e2     	str	x2, [sp, #0x28]
  8df1c0: f9401fe0     	ldr	x0, [sp, #0x38]
  8df1c4: 97ecb3a8     	bl	0x40c064 <.text+0xe34>
  8df1c8: aa0003e3     	mov	x3, x0
  8df1cc: 900026e0     	adrp	x0, 0xdbb000
  8df1d0: 913f0002     	add	x2, x0, #0xfc0
  8df1d4: 528020c1     	mov	w1, #0x106              // =262
  8df1d8: 900026e0     	adrp	x0, 0xdbb000
  8df1dc: 9134c000     	add	x0, x0, #0xd30
  8df1e0: 97f99caf     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  8df1e4: 9140abe0     	add	x0, sp, #0x2a, lsl #12  // =0x2a000
  8df1e8: 9135e000     	add	x0, x0, #0xd78
  8df1ec: f9401be1     	ldr	x1, [sp, #0x30]
  8df1f0: 97eed7be     	bl	0x4950e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f13c>
  8df1f4: 9140abe0     	add	x0, sp, #0x2a, lsl #12  // =0x2a000
  8df1f8: 9135e000     	add	x0, x0, #0xd78
  8df1fc: 97eed7fc     	bl	0x4951ec <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f240>
  8df200: 97eed7a5     	bl	0x495094 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f0e8>
  8df204: 9140a3e1     	add	x1, sp, #0x28, lsl #12  // =0x28000
  8df208: f916d820     	str	x0, [x1, #0x2db0]
  8df20c: 9140abe0     	add	x0, sp, #0x2a, lsl #12  // =0x2a000
  8df210: 9135a000     	add	x0, x0, #0xd68
  8df214: f9401be1     	ldr	x1, [sp, #0x30]
  8df218: 97eed7fb     	bl	0x495204 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f258>
  8df21c: 9140abe0     	add	x0, sp, #0x2a, lsl #12  // =0x2a000
  8df220: 9135a000     	add	x0, x0, #0xd68
  8df224: 97eed825     	bl	0x4952b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f30c>
  8df228: 97eed7a1     	bl	0x4950ac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f100>
  8df22c: 9140a3e1     	add	x1, sp, #0x28, lsl #12  // =0x28000
  8df230: f916b020     	str	x0, [x1, #0x2d60]
  8df234: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df238: f956b000     	ldr	x0, [x0, #0x2d60]
  8df23c: f100001f     	cmp	x0, #0x0
  8df240: 54000141     	b.ne	0x8df268 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x38a3c>
  8df244: 528021a3     	mov	w3, #0x10d              // =269
  8df248: 900026e0     	adrp	x0, 0xdbb000
  8df24c: 9134c002     	add	x2, x0, #0xd30
  8df250: 900026e0     	adrp	x0, 0xdbb000
  8df254: 913f6001     	add	x1, x0, #0xfd8
  8df258: 900026e0     	adrp	x0, 0xdbb000
  8df25c: 913f8000     	add	x0, x0, #0xfe0
  8df260: 97ecacc8     	bl	0x40a580 <printf@plt>
  8df264: 97fa3529     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8df268: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df26c: f956d800     	ldr	x0, [x0, #0x2db0]
  8df270: f9400000     	ldr	x0, [x0]
  8df274: f100001f     	cmp	x0, #0x0
  8df278: 54000141     	b.ne	0x8df2a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x38a74>
  8df27c: 528021c3     	mov	w3, #0x10e              // =270
  8df280: 900026e0     	adrp	x0, 0xdbb000
  8df284: 9134c002     	add	x2, x0, #0xd30
  8df288: b00026e0     	adrp	x0, 0xdbc000
  8df28c: 91002001     	add	x1, x0, #0x8
  8df290: 900026e0     	adrp	x0, 0xdbb000
  8df294: 913f8000     	add	x0, x0, #0xfe0
  8df298: 97ecacba     	bl	0x40a580 <printf@plt>
  8df29c: 97fa351b     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8df2a0: 9140abe0     	add	x0, sp, #0x2a, lsl #12  // =0x2a000
  8df2a4: 91354000     	add	x0, x0, #0xd50
  8df2a8: f9401be1     	ldr	x1, [sp, #0x30]
  8df2ac: 97eeba01     	bl	0x48dab0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57b04>
  8df2b0: 9140abe0     	add	x0, sp, #0x2a, lsl #12  // =0x2a000
  8df2b4: 91354000     	add	x0, x0, #0xd50
  8df2b8: d2800001     	mov	x1, #0x0                // =0
  8df2bc: 97eeba3b     	bl	0x48dba8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57bfc>
  8df2c0: 12001c00     	and	w0, w0, #0xff
  8df2c4: 52000000     	eor	w0, w0, #0x1
  8df2c8: 12001c00     	and	w0, w0, #0xff
  8df2cc: 7100001f     	cmp	w0, #0x0
  8df2d0: 54000140     	b.eq	0x8df2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x38acc>
  8df2d4: 52802223     	mov	w3, #0x111              // =273
  8df2d8: 900026e0     	adrp	x0, 0xdbb000
  8df2dc: 9134c002     	add	x2, x0, #0xd30
  8df2e0: b00026e0     	adrp	x0, 0xdbc000
  8df2e4: 91008001     	add	x1, x0, #0x20
  8df2e8: 900026e0     	adrp	x0, 0xdbb000
  8df2ec: 913f8000     	add	x0, x0, #0xfe0
  8df2f0: 97ecaca4     	bl	0x40a580 <printf@plt>
  8df2f4: 97fa3505     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8df2f8: 9140abe0     	add	x0, sp, #0x2a, lsl #12  // =0x2a000
  8df2fc: 91354000     	add	x0, x0, #0xd50
  8df300: 97eeba35     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  8df304: 91008000     	add	x0, x0, #0x20
  8df308: 9140a3e1     	add	x1, sp, #0x28, lsl #12  // =0x28000
  8df30c: f916d420     	str	x0, [x1, #0x2da8]
  8df310: f9401fe0     	ldr	x0, [sp, #0x38]
  8df314: f940d800     	ldr	x0, [x0, #0x1b0]
  8df318: 9140abe1     	add	x1, sp, #0x2a, lsl #12  // =0x2a000
  8df31c: 91314021     	add	x1, x1, #0xc50
  8df320: 52802002     	mov	w2, #0x100              // =256
  8df324: 97f8ce5c     	bl	0x712c94 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24c14>
  8df328: f9401fe0     	ldr	x0, [sp, #0x38]
  8df32c: 910b2001     	add	x1, x0, #0x2c8
  8df330: f9401fe0     	ldr	x0, [sp, #0x38]
  8df334: f9428402     	ldr	x2, [x0, #0x508]
  8df338: f9401fe0     	ldr	x0, [sp, #0x38]
  8df33c: f9428803     	ldr	x3, [x0, #0x510]
  8df340: f9401fe0     	ldr	x0, [sp, #0x38]
  8df344: f9428c04     	ldr	x4, [x0, #0x518]
  8df348: 910243e0     	add	x0, sp, #0x90
  8df34c: 97fbe6b9     	bl	0x7d8e30 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x1ce68>
  8df350: 9140abe1     	add	x1, sp, #0x2a, lsl #12  // =0x2a000
  8df354: 91314021     	add	x1, x1, #0xc50
  8df358: 910243e0     	add	x0, sp, #0x90
  8df35c: aa0103e3     	mov	x3, x1
  8df360: 52800022     	mov	w2, #0x1                // =1
  8df364: f94017e1     	ldr	x1, [sp, #0x28]
  8df368: 97fbe570     	bl	0x7d8928 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x1c960>
  8df36c: 12001c00     	and	w0, w0, #0xff
  8df370: 52000000     	eor	w0, w0, #0x1
  8df374: 12001c00     	and	w0, w0, #0xff
  8df378: 7100001f     	cmp	w0, #0x0
  8df37c: 540001a0     	b.eq	0x8df3b0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x38b84>
  8df380: f9401fe0     	ldr	x0, [sp, #0x38]
  8df384: 97ecb338     	bl	0x40c064 <.text+0xe34>
  8df388: aa0003e4     	mov	x4, x0
  8df38c: b00026e0     	adrp	x0, 0xdbc000
  8df390: 91010003     	add	x3, x0, #0x40
  8df394: 52802382     	mov	w2, #0x11c              // =284
  8df398: 900026e0     	adrp	x0, 0xdbb000
  8df39c: 9134c001     	add	x1, x0, #0xd30
  8df3a0: 52800040     	mov	w0, #0x2                // =2
  8df3a4: 97f99c6a     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8df3a8: 52800013     	mov	w19, #0x0               // =0
  8df3ac: 14000152     	b	0x8df8f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x390c8>
  8df3b0: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df3b4: f956d800     	ldr	x0, [x0, #0x2db0]
  8df3b8: f9400001     	ldr	x1, [x0]
  8df3bc: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df3c0: f956d800     	ldr	x0, [x0, #0x2db0]
  8df3c4: 9140b000     	add	x0, x0, #0x2c, lsl #12  // =0x2c000
  8df3c8: b9588802     	ldr	w2, [x0, #0x1888]
  8df3cc: 910243e0     	add	x0, sp, #0x90
  8df3d0: 97fbe5aa     	bl	0x7d8a78 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x1cab0>
  8df3d4: 12001c00     	and	w0, w0, #0xff
  8df3d8: 52000000     	eor	w0, w0, #0x1
  8df3dc: 12001c00     	and	w0, w0, #0xff
  8df3e0: 7100001f     	cmp	w0, #0x0
  8df3e4: 540001a0     	b.eq	0x8df418 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x38bec>
  8df3e8: f9401fe0     	ldr	x0, [sp, #0x38]
  8df3ec: 97ecb31e     	bl	0x40c064 <.text+0xe34>
  8df3f0: aa0003e4     	mov	x4, x0
  8df3f4: b00026e0     	adrp	x0, 0xdbc000
  8df3f8: 9101a003     	add	x3, x0, #0x68
  8df3fc: 52802462     	mov	w2, #0x123              // =291
  8df400: 900026e0     	adrp	x0, 0xdbb000
  8df404: 9134c001     	add	x1, x0, #0xd30
  8df408: 52800040     	mov	w0, #0x2                // =2
  8df40c: 97f99c50     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8df410: 52800013     	mov	w19, #0x0               // =0
  8df414: 14000138     	b	0x8df8f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x390c8>
  8df418: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df41c: f956b001     	ldr	x1, [x0, #0x2d60]
  8df420: 910243e0     	add	x0, sp, #0x90
  8df424: 97fbe5a7     	bl	0x7d8ac0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x1caf8>
  8df428: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df42c: f956d800     	ldr	x0, [x0, #0x2db0]
  8df430: 91004000     	add	x0, x0, #0x10
  8df434: d2800001     	mov	x1, #0x0                // =0
  8df438: 97f70325     	bl	0x6a00cc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x1a701c>
  8df43c: aa0003e1     	mov	x1, x0
  8df440: 910243e0     	add	x0, sp, #0x90
  8df444: 97fbe5b7     	bl	0x7d8b20 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x1cb58>
  8df448: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df44c: f956d801     	ldr	x1, [x0, #0x2db0]
  8df450: d2860d00     	mov	x0, #0x3068             // =12392
  8df454: f2a00040     	movk	x0, #0x2, lsl #16
  8df458: 8b000021     	add	x1, x1, x0
  8df45c: 910243e0     	add	x0, sp, #0x90
  8df460: 97fbe5b4     	bl	0x7d8b30 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x1cb68>
  8df464: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df468: f956d800     	ldr	x0, [x0, #0x2db0]
  8df46c: 9100a001     	add	x1, x0, #0x28
  8df470: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df474: f956b000     	ldr	x0, [x0, #0x2d60]
  8df478: b9445c02     	ldr	w2, [x0, #0x45c]
  8df47c: 910243e0     	add	x0, sp, #0x90
  8df480: 97fbe5b6     	bl	0x7d8b58 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x1cb90>
  8df484: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df488: f956d801     	ldr	x1, [x0, #0x2db0]
  8df48c: d29b1200     	mov	x0, #0xd890             // =55440
  8df490: f2a00040     	movk	x0, #0x2, lsl #16
  8df494: 8b000020     	add	x0, x1, x0
  8df498: 97f06706     	bl	0x4f90b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv>
  8df49c: aa0003e1     	mov	x1, x0
  8df4a0: 910243e0     	add	x0, sp, #0x90
  8df4a4: 97fbe5b5     	bl	0x7d8b78 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x1cbb0>
  8df4a8: 910243e0     	add	x0, sp, #0x90
  8df4ac: 97fbe5c3     	bl	0x7d8bb8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x1cbf0>
  8df4b0: 12001c00     	and	w0, w0, #0xff
  8df4b4: 52000000     	eor	w0, w0, #0x1
  8df4b8: 12001c00     	and	w0, w0, #0xff
  8df4bc: 7100001f     	cmp	w0, #0x0
  8df4c0: 540001a0     	b.eq	0x8df4f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x38cc8>
  8df4c4: f9401fe0     	ldr	x0, [sp, #0x38]
  8df4c8: 97ecb2e7     	bl	0x40c064 <.text+0xe34>
  8df4cc: aa0003e4     	mov	x4, x0
  8df4d0: b00026e0     	adrp	x0, 0xdbc000
  8df4d4: 9102a003     	add	x3, x0, #0xa8
  8df4d8: 52802622     	mov	w2, #0x131              // =305
  8df4dc: 900026e0     	adrp	x0, 0xdbb000
  8df4e0: 9134c001     	add	x1, x0, #0xd30
  8df4e4: 52800040     	mov	w0, #0x2                // =2
  8df4e8: 97f99c19     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8df4ec: 52800013     	mov	w19, #0x0               // =0
  8df4f0: 14000101     	b	0x8df8f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x390c8>
  8df4f4: 528001c0     	mov	w0, #0xe                // =14
  8df4f8: 9140a3e1     	add	x1, sp, #0x28, lsl #12  // =0x28000
  8df4fc: b92da420     	str	w0, [x1, #0x2da4]
  8df500: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df504: f956d400     	ldr	x0, [x0, #0x2da8]
  8df508: f9400801     	ldr	x1, [x0, #0x10]
  8df50c: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df510: f956d400     	ldr	x0, [x0, #0x2da8]
  8df514: b9400400     	ldr	w0, [x0, #0x4]
  8df518: 2a0003e2     	mov	w2, w0
  8df51c: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df520: f956d400     	ldr	x0, [x0, #0x2da8]
  8df524: b9400800     	ldr	w0, [x0, #0x8]
  8df528: 2a0003e3     	mov	w3, w0
  8df52c: 910243e0     	add	x0, sp, #0x90
  8df530: 9140a3e4     	add	x4, sp, #0x28, lsl #12  // =0x28000
  8df534: b96da484     	ldr	w4, [x4, #0x2da4]
  8df538: 97fbe5a4     	bl	0x7d8bc8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x1cc00>
  8df53c: 12001c00     	and	w0, w0, #0xff
  8df540: 52000000     	eor	w0, w0, #0x1
  8df544: 12001c00     	and	w0, w0, #0xff
  8df548: 7100001f     	cmp	w0, #0x0
  8df54c: 540001a0     	b.eq	0x8df580 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x38d54>
  8df550: f9401fe0     	ldr	x0, [sp, #0x38]
  8df554: 97ecb2c4     	bl	0x40c064 <.text+0xe34>
  8df558: aa0003e4     	mov	x4, x0
  8df55c: b00026e0     	adrp	x0, 0xdbc000
  8df560: 9103e003     	add	x3, x0, #0xf8
  8df564: 52802702     	mov	w2, #0x138              // =312
  8df568: 900026e0     	adrp	x0, 0xdbb000
  8df56c: 9134c001     	add	x1, x0, #0xd30
  8df570: 52800040     	mov	w0, #0x2                // =2
  8df574: 97f99bf6     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8df578: 52800013     	mov	w19, #0x0               // =0
  8df57c: 140000de     	b	0x8df8f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x390c8>
  8df580: 910243e0     	add	x0, sp, #0x90
  8df584: 97fbe5a3     	bl	0x7d8c10 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x1cc48>
  8df588: 12001c00     	and	w0, w0, #0xff
  8df58c: 52000000     	eor	w0, w0, #0x1
  8df590: 12001c00     	and	w0, w0, #0xff
  8df594: 7100001f     	cmp	w0, #0x0
  8df598: 540001a0     	b.eq	0x8df5cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x38da0>
  8df59c: f9401fe0     	ldr	x0, [sp, #0x38]
  8df5a0: 97ecb2b1     	bl	0x40c064 <.text+0xe34>
  8df5a4: aa0003e4     	mov	x4, x0
  8df5a8: b00026e0     	adrp	x0, 0xdbc000
  8df5ac: 9104e003     	add	x3, x0, #0x138
  8df5b0: 528027c2     	mov	w2, #0x13e              // =318
  8df5b4: 900026e0     	adrp	x0, 0xdbb000
  8df5b8: 9134c001     	add	x1, x0, #0xd30
  8df5bc: 52800040     	mov	w0, #0x2                // =2
  8df5c0: 97f99be3     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8df5c4: 52800013     	mov	w19, #0x0               // =0
  8df5c8: 140000cb     	b	0x8df8f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x390c8>
  8df5cc: 910243e0     	add	x0, sp, #0x90
  8df5d0: 97fbe51a     	bl	0x7d8a38 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x1ca70>
  8df5d4: 12001c00     	and	w0, w0, #0xff
  8df5d8: 52000000     	eor	w0, w0, #0x1
  8df5dc: 12001c00     	and	w0, w0, #0xff
  8df5e0: 7100001f     	cmp	w0, #0x0
  8df5e4: 540001a0     	b.eq	0x8df618 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x38dec>
  8df5e8: f9401fe0     	ldr	x0, [sp, #0x38]
  8df5ec: 97ecb29e     	bl	0x40c064 <.text+0xe34>
  8df5f0: aa0003e4     	mov	x4, x0
  8df5f4: b00026e0     	adrp	x0, 0xdbc000
  8df5f8: 91060003     	add	x3, x0, #0x180
  8df5fc: 52802882     	mov	w2, #0x144              // =324
  8df600: 900026e0     	adrp	x0, 0xdbb000
  8df604: 9134c001     	add	x1, x0, #0xd30
  8df608: 52800040     	mov	w0, #0x2                // =2
  8df60c: 97f99bd0     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8df610: 52800013     	mov	w19, #0x0               // =0
  8df614: 140000b8     	b	0x8df8f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x390c8>
  8df618: 52820000     	mov	w0, #0x1000             // =4096
  8df61c: 9140a3e1     	add	x1, sp, #0x28, lsl #12  // =0x28000
  8df620: b92da020     	str	w0, [x1, #0x2da0]
  8df624: 9101e3e0     	add	x0, sp, #0x78
  8df628: 97fd1852     	bl	0x825770 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x697a8>
  8df62c: f9401fe0     	ldr	x0, [sp, #0x38]
  8df630: 910b2000     	add	x0, x0, #0x2c8
  8df634: 9101e3e1     	add	x1, sp, #0x78
  8df638: 97fd23ef     	bl	0x8285f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6c62c>
  8df63c: 9140a3e1     	add	x1, sp, #0x28, lsl #12  // =0x28000
  8df640: b92dbc20     	str	w0, [x1, #0x2dbc]
  8df644: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df648: b96dbc03     	ldr	w3, [x0, #0x2dbc]
  8df64c: b00026e0     	adrp	x0, 0xdbc000
  8df650: 9106e002     	add	x2, x0, #0x1b8
  8df654: 52802961     	mov	w1, #0x14b              // =331
  8df658: 900026e0     	adrp	x0, 0xdbb000
  8df65c: 9134c000     	add	x0, x0, #0xd30
  8df660: 97f99b8f     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  8df664: f9401fe0     	ldr	x0, [sp, #0x38]
  8df668: 910b2000     	add	x0, x0, #0x2c8
  8df66c: 97fd24fb     	bl	0x828a58 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6ca90>
  8df670: 9140a3e1     	add	x1, sp, #0x28, lsl #12  // =0x28000
  8df674: f916cc20     	str	x0, [x1, #0x2d98]
  8df678: 910183e0     	add	x0, sp, #0x60
  8df67c: 97fd183d     	bl	0x825770 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x697a8>
  8df680: f9401fe0     	ldr	x0, [sp, #0x38]
  8df684: f9416007     	ldr	x7, [x0, #0x2c0]
  8df688: f9401fe0     	ldr	x0, [sp, #0x38]
  8df68c: f9416000     	ldr	x0, [x0, #0x2c0]
  8df690: f9400000     	ldr	x0, [x0]
  8df694: 9100a000     	add	x0, x0, #0x28
  8df698: f9400006     	ldr	x6, [x0]
  8df69c: 910183e0     	add	x0, sp, #0x60
  8df6a0: 52800025     	mov	w5, #0x1                // =1
  8df6a4: 52800024     	mov	w4, #0x1                // =1
  8df6a8: 52800023     	mov	w3, #0x1                // =1
  8df6ac: f94017e2     	ldr	x2, [sp, #0x28]
  8df6b0: aa0003e1     	mov	x1, x0
  8df6b4: aa0703e0     	mov	x0, x7
  8df6b8: d63f00c0     	blr	x6
  8df6bc: 12001c00     	and	w0, w0, #0xff
  8df6c0: 7100001f     	cmp	w0, #0x0
  8df6c4: 54001000     	b.eq	0x8df8c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x39098>
  8df6c8: 910103e0     	add	x0, sp, #0x40
  8df6cc: 52800021     	mov	w1, #0x1                // =1
  8df6d0: 97f8b1d0     	bl	0x70be10 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1dd90>
  8df6d4: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df6d8: b96dbc00     	ldr	w0, [x0, #0x2dbc]
  8df6dc: 113ffc00     	add	w0, w0, #0xfff
  8df6e0: 12144c00     	and	w0, w0, #0xfffff000
  8df6e4: 9140a3e1     	add	x1, sp, #0x28, lsl #12  // =0x28000
  8df6e8: b92d9420     	str	w0, [x1, #0x2d94]
  8df6ec: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df6f0: b96d9400     	ldr	w0, [x0, #0x2d94]
  8df6f4: 9140a3e1     	add	x1, sp, #0x28, lsl #12  // =0x28000
  8df6f8: b92dbc20     	str	w0, [x1, #0x2dbc]
  8df6fc: f9401be0     	ldr	x0, [sp, #0x30]
  8df700: 9140a3e1     	add	x1, sp, #0x28, lsl #12  // =0x28000
  8df704: b96d9421     	ldr	w1, [x1, #0x2d94]
  8df708: b9005001     	str	w1, [x0, #0x50]
  8df70c: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df710: b96dbc00     	ldr	w0, [x0, #0x2dbc]
  8df714: 7140041f     	cmp	w0, #0x1, lsl #12       // =0x1000
  8df718: 54000369     	b.ls	0x8df784 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x38f58>
  8df71c: 910183e0     	add	x0, sp, #0x60
  8df720: 52820002     	mov	w2, #0x1000             // =4096
  8df724: 9140a3e1     	add	x1, sp, #0x28, lsl #12  // =0x28000
  8df728: f956cc21     	ldr	x1, [x1, #0x2d98]
  8df72c: 97fd1863     	bl	0x8258b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x698f0>
  8df730: 7140041f     	cmp	w0, #0x1, lsl #12       // =0x1000
  8df734: 1a9f07e0     	cset	w0, ne
  8df738: 12001c00     	and	w0, w0, #0xff
  8df73c: 7100001f     	cmp	w0, #0x0
  8df740: 54000180     	b.eq	0x8df770 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x38f44>
  8df744: f94017e5     	ldr	x5, [sp, #0x28]
  8df748: 52820004     	mov	w4, #0x1000             // =4096
  8df74c: b00026e0     	adrp	x0, 0xdbc000
  8df750: 91074003     	add	x3, x0, #0x1d0
  8df754: 52802ba2     	mov	w2, #0x15d              // =349
  8df758: 900026e0     	adrp	x0, 0xdbb000
  8df75c: 9134c001     	add	x1, x0, #0xd30
  8df760: 52800080     	mov	w0, #0x4                // =4
  8df764: 97f99b7a     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8df768: 52800013     	mov	w19, #0x0               // =0
  8df76c: 14000053     	b	0x8df8b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3908c>
  8df770: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df774: b96dbc00     	ldr	w0, [x0, #0x2dbc]
  8df778: 51400400     	sub	w0, w0, #0x1, lsl #12   // =0x1000
  8df77c: 9140a3e1     	add	x1, sp, #0x28, lsl #12  // =0x28000
  8df780: b92dbc20     	str	w0, [x1, #0x2dbc]
  8df784: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df788: f956cc00     	ldr	x0, [x0, #0x2d98]
  8df78c: 91400401     	add	x1, x0, #0x1, lsl #12   // =0x1000
  8df790: 910183e0     	add	x0, sp, #0x60
  8df794: 9140a3e2     	add	x2, sp, #0x28, lsl #12  // =0x28000
  8df798: b96dbc42     	ldr	w2, [x2, #0x2dbc]
  8df79c: 97fd1847     	bl	0x8258b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x698f0>
  8df7a0: 2a0003e1     	mov	w1, w0
  8df7a4: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df7a8: b96dbc00     	ldr	w0, [x0, #0x2dbc]
  8df7ac: 6b01001f     	cmp	w0, w1
  8df7b0: 1a9f07e0     	cset	w0, ne
  8df7b4: 12001c00     	and	w0, w0, #0xff
  8df7b8: 7100001f     	cmp	w0, #0x0
  8df7bc: 540001a0     	b.eq	0x8df7f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x38fc4>
  8df7c0: f94017e5     	ldr	x5, [sp, #0x28]
  8df7c4: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df7c8: b96dbc04     	ldr	w4, [x0, #0x2dbc]
  8df7cc: b00026e0     	adrp	x0, 0xdbc000
  8df7d0: 91074003     	add	x3, x0, #0x1d0
  8df7d4: 52802ca2     	mov	w2, #0x165              // =357
  8df7d8: 900026e0     	adrp	x0, 0xdbb000
  8df7dc: 9134c001     	add	x1, x0, #0xd30
  8df7e0: 52800080     	mov	w0, #0x4                // =4
  8df7e4: 97f99b5a     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8df7e8: 52800013     	mov	w19, #0x0               // =0
  8df7ec: 14000033     	b	0x8df8b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3908c>
  8df7f0: 910103e0     	add	x0, sp, #0x40
  8df7f4: 97f8b1bb     	bl	0x70bee0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1de60>
  8df7f8: 910103e0     	add	x0, sp, #0x40
  8df7fc: 97f8b24d     	bl	0x70c130 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1e0b0>
  8df800: 9140a3e1     	add	x1, sp, #0x28, lsl #12  // =0x28000
  8df804: b92d9020     	str	w0, [x1, #0x2d90]
  8df808: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df80c: b96d9400     	ldr	w0, [x0, #0x2d94]
  8df810: 1e230000     	ucvtf	s0, w0
  8df814: 52a93000     	mov	w0, #0x49800000         // =1233125376
  8df818: 1e270001     	fmov	s1, w0
  8df81c: 1e211800     	fdiv	s0, s0, s1
  8df820: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df824: bd2d8c00     	str	s0, [x0, #0x2d8c]
  8df828: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df82c: b96d9000     	ldr	w0, [x0, #0x2d90]
  8df830: 7100001f     	cmp	w0, #0x0
  8df834: 54000081     	b.ne	0x8df844 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x39018>
  8df838: 52800020     	mov	w0, #0x1                // =1
  8df83c: 9140a3e1     	add	x1, sp, #0x28, lsl #12  // =0x28000
  8df840: b92d9020     	str	w0, [x1, #0x2d90]
  8df844: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df848: bd6d8c00     	ldr	s0, [x0, #0x2d8c]
  8df84c: 52a88f40     	mov	w0, #0x447a0000         // =1148846080
  8df850: 1e270001     	fmov	s1, w0
  8df854: 1e210808     	fmul	s8, s0, s1
  8df858: 910103e0     	add	x0, sp, #0x40
  8df85c: 97f8b235     	bl	0x70c130 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1e0b0>
  8df860: 1e230000     	ucvtf	s0, w0
  8df864: 1e201900     	fdiv	s0, s8, s0
  8df868: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df86c: bd2d8800     	str	s0, [x0, #0x2d88]
  8df870: 9140a3e0     	add	x0, sp, #0x28, lsl #12  // =0x28000
  8df874: bd6d8c00     	ldr	s0, [x0, #0x2d8c]
  8df878: 1e22c008     	fcvt	d8, s0
  8df87c: 910103e0     	add	x0, sp, #0x40
  8df880: 97f8b22c     	bl	0x70c130 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1e0b0>
  8df884: 9140a3e1     	add	x1, sp, #0x28, lsl #12  // =0x28000
  8df888: bd6d8820     	ldr	s0, [x1, #0x2d88]
  8df88c: 1e22c000     	fcvt	d0, s0
  8df890: 1e604001     	fmov	d1, d0
  8df894: 2a0003e3     	mov	w3, w0
  8df898: 1e604100     	fmov	d0, d8
  8df89c: b00026e0     	adrp	x0, 0xdbc000
  8df8a0: 91080002     	add	x2, x0, #0x200
  8df8a4: 52802e81     	mov	w1, #0x174              // =372
  8df8a8: 900026e0     	adrp	x0, 0xdbb000
  8df8ac: 9134c000     	add	x0, x0, #0xd30
  8df8b0: 97f99afb     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  8df8b4: 52800033     	mov	w19, #0x1               // =1
  8df8b8: 910103e0     	add	x0, sp, #0x40
  8df8bc: 97f8b169     	bl	0x70be60 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1dde0>
  8df8c0: 14000009     	b	0x8df8e4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x390b8>
  8df8c4: b00026e0     	adrp	x0, 0xdbc000
  8df8c8: 9108c003     	add	x3, x0, #0x230
  8df8cc: 52802f82     	mov	w2, #0x17c              // =380
  8df8d0: 900026e0     	adrp	x0, 0xdbb000
  8df8d4: 9134c001     	add	x1, x0, #0xd30
  8df8d8: 52800080     	mov	w0, #0x4                // =4
  8df8dc: 97f99b1c     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8df8e0: 52800013     	mov	w19, #0x0               // =0
  8df8e4: 910183e0     	add	x0, sp, #0x60
  8df8e8: 97fd17b3     	bl	0x8257b4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x697ec>
  8df8ec: 9101e3e0     	add	x0, sp, #0x78
  8df8f0: 97fd17b1     	bl	0x8257b4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x697ec>
  8df8f4: 910243e0     	add	x0, sp, #0x90
  8df8f8: 97fbe57a     	bl	0x7d8ee0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x1cf18>
  8df8fc: 9140abe0     	add	x0, sp, #0x2a, lsl #12  // =0x2a000
  8df900: 91354000     	add	x0, x0, #0xd50
  8df904: 97eeb884     	bl	0x48db14 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57b68>
  8df908: 9140abe0     	add	x0, sp, #0x2a, lsl #12  // =0x2a000
  8df90c: 9135a000     	add	x0, x0, #0xd68
  8df910: 97eed656     	bl	0x495268 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f2bc>
  8df914: 9140abe0     	add	x0, sp, #0x2a, lsl #12  // =0x2a000
  8df918: 9135e000     	add	x0, x0, #0xd78
  8df91c: 97eed620     	bl	0x49519c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f1f0>
  8df920: 2a1303e0     	mov	w0, w19
  8df924: 14000021     	b	0x8df9a8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3917c>
  8df928: aa0003f3     	mov	x19, x0
  8df92c: 910103e0     	add	x0, sp, #0x40
  8df930: 97f8b14c     	bl	0x70be60 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1dde0>
  8df934: 14000002     	b	0x8df93c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x39110>
  8df938: aa0003f3     	mov	x19, x0
  8df93c: 910183e0     	add	x0, sp, #0x60
  8df940: 97fd179d     	bl	0x8257b4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x697ec>
  8df944: 14000002     	b	0x8df94c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x39120>
  8df948: aa0003f3     	mov	x19, x0
  8df94c: 9101e3e0     	add	x0, sp, #0x78
  8df950: 97fd1799     	bl	0x8257b4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x697ec>
  8df954: 14000002     	b	0x8df95c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x39130>
  8df958: aa0003f3     	mov	x19, x0
  8df95c: 910243e0     	add	x0, sp, #0x90
  8df960: 97fbe560     	bl	0x7d8ee0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x1cf18>
  8df964: 14000002     	b	0x8df96c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x39140>
  8df968: aa0003f3     	mov	x19, x0
  8df96c: 9140abe0     	add	x0, sp, #0x2a, lsl #12  // =0x2a000
  8df970: 91354000     	add	x0, x0, #0xd50
  8df974: 97eeb868     	bl	0x48db14 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57b68>
  8df978: 14000002     	b	0x8df980 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x39154>
  8df97c: aa0003f3     	mov	x19, x0
  8df980: 9140abe0     	add	x0, sp, #0x2a, lsl #12  // =0x2a000
  8df984: 9135a000     	add	x0, x0, #0xd68
  8df988: 97eed638     	bl	0x495268 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f2bc>
  8df98c: 14000002     	b	0x8df994 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x39168>
  8df990: aa0003f3     	mov	x19, x0
  8df994: 9140abe0     	add	x0, sp, #0x2a, lsl #12  // =0x2a000
  8df998: 9135e000     	add	x0, x0, #0xd78
  8df99c: 97eed600     	bl	0x49519c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f1f0>
  8df9a0: aa1303e0     	mov	x0, x19
  8df9a4: 97ecab6b     	bl	0x40a750 <_Unwind_Resume@plt>
  8df9a8: f9400bf3     	ldr	x19, [sp, #0x10]
  8df9ac: a9407bfd     	ldp	x29, x30, [sp]
  8df9b0: fd400fe8     	ldr	d8, [sp, #0x18]
  8df9b4: 913703ff     	add	sp, sp, #0xdc0
  8df9b8: 9140abff     	add	sp, sp, #0x2a, lsl #12  // =0x2a000
  8df9bc: d65f03c0     	ret
