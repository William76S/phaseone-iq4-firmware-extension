// INPUT SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
// STATIC PSEUDOCODE; recovered types/ABI and flow across tail branches require instruction verification.
// Linked VA 00919d58

/* WARNING: Type propagation algorithm not settling */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void NativeRenderPipelineProcess
               (long param_1,long param_2,long param_3,long param_4,long param_5,float *param_6,
               undefined8 param_7,char *param_8,undefined8 *param_9)

{
  long *plVar1;
  int *piVar2;
  uint uVar3;
  uint uVar4;
  bool bVar5;
  undefined8 *******pppppppuVar6;
  undefined8 *******pppppppuVar7;
  undefined8 *******pppppppuVar8;
  char cVar9;
  undefined4 uVar10;
  int iVar11;
  int iVar12;
  int iVar13;
  int iVar14;
  long lVar15;
  ulong uVar16;
  long lVar17;
  undefined8 *******pppppppuVar18;
  long lVar19;
  undefined1 (*pauVar20) [16];
  undefined8 uVar21;
  code *pcVar22;
  undefined1 (*pauVar23) [16];
  undefined8 *******pppppppuVar24;
  ulong uVar25;
  long *plVar26;
  long *plVar27;
  long *plVar28;
  ulong uVar29;
  ulong uVar30;
  float fVar31;
  float fVar32;
  float fVar33;
  long lVar34;
  undefined1 auVar35 [16];
  undefined1 auVar36 [16];
  long lStack_370;
  undefined1 (*pauStack_350) [16];
  undefined1 *puStack_348;
  long *plStack_318;
  int iStack_300;
  int iStack_2fc;
  ulong uStack_2e8;
  int iStack_2e0;
  long *plStack_2a0;
  long *plStack_298;
  long *plStack_290;
  long *plStack_288;
  long lStack_280;
  long lStack_278;
  long lStack_270;
  long lStack_260;
  int *piStack_258;
  int *piStack_250;
  long lStack_240;
  long lStack_238;
  undefined8 *******pppppppuStack_230;
  long lStack_228;
  undefined8 *******pppppppuStack_220;
  undefined8 *******pppppppuStack_218;
  undefined8 *******pppppppuStack_210;
  undefined1 uStack_201;
  undefined1 auStack_1f8 [88];
  undefined1 auStack_1a0 [88];
  undefined1 auStack_148 [120];
  float *pfStack_d0;
  undefined1 (*pauStack_c8) [16];
  undefined7 uStack_c0;
  undefined1 uStack_b9;
  undefined7 uStack_b8;
  undefined1 uStack_b1;
  undefined1 auStack_b0 [4];
  undefined4 uStack_ac;
  undefined4 uStack_a8;
  undefined8 uStack_a4;
  undefined8 uStack_9c;
  undefined4 uStack_94;
  undefined4 uStack_90;
  undefined4 uStack_8c;
  long lStack_88;
  undefined4 uStack_80;
  undefined1 auStack_78 [32];
  undefined1 auStack_58 [4];
  undefined8 uStack_54;
  undefined8 uStack_4c;
  undefined8 uStack_44;
  undefined4 uStack_3c;
  undefined4 uStack_38;
  undefined4 uStack_34;
  long lStack_30;
  undefined4 uStack_28;
  undefined1 auStack_20 [32];
  
  func_0x0040a8f0();
  if (*(ulong *)(param_1 + 8) == 0) {
    func_0x0074654c(4,&UNK_00dc64b0,0x2d,&UNK_00dc6480);
    return;
  }
  if (param_8 == (char *)0x0) {
    func_0x0074654c(4,&UNK_00dc64b0,0x33,&UNK_00dc64f8);
    return;
  }
  if ((*(ulong *)(param_1 + 8) & 3) != 0) {
    func_0x0074654c(4,&UNK_00dc64b0,0x39,&UNK_00dc6528);
    return;
  }
  lStack_280 = 0;
  lStack_278 = 0;
  lStack_270 = 0;
  lVar15 = func_0x00409e60(0xb0);
  lStack_280 = lVar15;
  lStack_278 = lVar15;
  lStack_270 = lVar15 + 0xb0;
  IcImageBufferDefault();
  IcImageBufferDefault(lVar15 + 0x58);
  lStack_278 = lVar15 + 0xb0;
  func_0x00916fa8(auStack_148,param_6,param_2,param_3);
  auVar35 = func_0x00916ef8(auStack_148);
  uVar25 = auVar35._8_8_;
  uVar29 = auVar35._0_8_ >> 0x20;
  uVar30 = (long)uVar25 >> 0x20;
  if (param_2 == param_3) {
    uStack_2e8 = 0;
  }
  else {
    uVar10 = func_0x00916f80(auStack_148);
    IcImageBufferAttach(param_3,uVar25 & 0xffffffff,uVar30 & 0xffffffff,uVar29 & 0xffffffff,uVar10,
                        0x20,*(undefined8 *)(param_1 + 8));
    iVar11 = IcImageBufferByteSize(param_3);
    uStack_2e8 = (ulong)iVar11;
  }
  if ((param_4 != 0) && (cVar9 = func_0x00904348(param_4), cVar9 == '\0')) {
    IcImageBufferAttach(param_4,uVar25 & 0xffffffff,uVar30 & 0xffffffff,uVar29 & 0xffffffff,0xc,0x20
                        ,*(long *)(param_1 + 8) + uStack_2e8);
    iVar11 = IcImageBufferByteSize(param_4);
    uStack_2e8 = uStack_2e8 + (long)iVar11;
  }
  if (param_5 != 0) {
    iVar12 = func_0x0090e540(*param_6);
    uVar10 = IcImageBufferValidWidth(param_2);
    iVar13 = IcImageBufferValidHeight(param_2);
    iVar11 = 0;
    if (iVar12 << 1 != 0) {
      iVar11 = iVar13 / (iVar12 << 1);
    }
    IcImageBufferAttach(param_5,uVar10,iVar11,0,0xd,0x20,*(long *)(param_1 + 8) + uStack_2e8);
    iVar11 = IcImageBufferByteSize(param_5);
    uStack_2e8 = uStack_2e8 + (long)iVar11;
  }
  uVar16 = func_0x00916dd0(auStack_148);
  if (uVar16 < 2) {
    if (*(ulong *)(param_1 + 0x10) < uStack_2e8) {
LAB_0091aef4:
      func_0x0074654c(4,&UNK_00dc64b0,0x68,&UNK_00dc6560);
      func_0x00916ad0(auStack_148);
      lVar19 = lStack_278;
      lVar17 = lStack_278;
      for (lVar15 = lStack_280; lVar15 != lVar19; lVar15 = lVar15 + 0x58) {
        IcImageBufferDestroy(lVar15);
        lVar17 = lStack_280;
      }
      goto LAB_0091aa10;
    }
  }
  else {
    IcImageBufferAttach(lStack_280,uVar25 & 0xffffffff,uVar30 & 0xffffffff,uVar29 & 0xffffffff,3,
                        0x20,*(long *)(param_1 + 8) + uStack_2e8);
    iVar11 = IcImageBufferByteSize(lStack_280);
    IcImageBufferAttach(lStack_280 + 0x58,uVar25 & 0xffffffff,uVar30 & 0xffffffff,
                        uVar29 & 0xffffffff,3,0x20,
                        *(long *)(param_1 + 8) + uStack_2e8 + (long)iVar11);
    iVar12 = IcImageBufferByteSize(lStack_280 + 0x58);
    uStack_2e8 = uStack_2e8 + (long)iVar11 + (long)iVar12;
    if (*(ulong *)(param_1 + 0x10) < uStack_2e8) goto LAB_0091aef4;
  }
  iVar11 = func_0x00716c1c(param_7);
  lStack_260 = 0;
  piStack_258 = (int *)0x0;
  piStack_250 = (int *)0x0;
  IcImageBufferDefault(auStack_1f8);
  func_0x00904148(auStack_1f8,param_2,1);
  IcImageBufferDefault(auStack_1a0);
  if (param_4 != 0) {
    func_0x00904148(auStack_1a0,param_4,1);
  }
  iVar12 = func_0x00916dd0(auStack_148);
  if (iVar12 + -1 < 0) {
    func_0x0040a8f0();
  }
  else {
    if (*param_8 == '\0') {
      iStack_300 = 0;
      iStack_2fc = 0;
      uVar25 = (ulong)iVar11;
      pppppppuVar24 = (undefined8 *******)((long)iVar11 * 0x58);
      do {
        func_0x00916de0(&plStack_2a0,auStack_148,iStack_300);
        plVar27 = plStack_298;
        plVar28 = plStack_2a0;
        lVar15 = _UNK_00dc6478;
        if (plStack_298 != (long *)0x0) {
          if (_UNK_00dc6478 == 0) {
            iVar13 = (int)plStack_298[1];
            *(int *)(plStack_298 + 1) = iVar13 + -1;
          }
          else {
            plVar26 = plStack_298 + 1;
            do {
              iVar13 = (int)*plVar26;
              cVar9 = '\x01';
              bVar5 = (bool)ExclusiveMonitorPass(plVar26,0x10);
              if (bVar5) {
                *(int *)plVar26 = iVar13 + -1;
                cVar9 = ExclusiveMonitorsStatus();
              }
            } while (cVar9 != '\0');
          }
          if (iVar13 == 1) {
            (**(code **)(*plStack_298 + 0x10))(plStack_298);
            if (lVar15 == 0) {
              iVar13 = *(int *)((long)plVar27 + 0xc);
              *(int *)((long)plVar27 + 0xc) = iVar13 + -1;
            }
            else {
              piVar2 = (int *)((long)plVar27 + 0xc);
              do {
                iVar13 = *piVar2;
                cVar9 = '\x01';
                bVar5 = (bool)ExclusiveMonitorPass(piVar2,0x10);
                if (bVar5) {
                  *piVar2 = iVar13 + -1;
                  cVar9 = ExclusiveMonitorsStatus();
                }
              } while (cVar9 != '\0');
            }
            if (iVar13 == 1) {
              (**(code **)(*plVar27 + 0x18))(plVar27);
            }
          }
        }
        uStack_c0 = 0;
        uStack_b9 = 0;
        if (*(code **)(param_1 + 0x28) == (code *)0x0) {
          pppppppuStack_230 = (undefined8 *******)0x0;
        }
        else {
          (**(code **)(param_1 + 0x28))(&pfStack_d0,param_1 + 0x18,2);
          pppppppuStack_230 = (undefined8 *******)0x0;
          uStack_b8 = (undefined7)*(undefined8 *)(param_1 + 0x30);
          uStack_b1 = (undefined1)((ulong)*(undefined8 *)(param_1 + 0x30) >> 0x38);
          uStack_c0 = (undefined7)*(undefined8 *)(param_1 + 0x28);
          uStack_b9 = (undefined1)((ulong)*(undefined8 *)(param_1 + 0x28) >> 0x38);
          if (*(code **)(param_1 + 0x28) != (code *)0x0) {
            (**(code **)(param_1 + 0x28))(&lStack_240,&pfStack_d0,2);
            lStack_228 = CONCAT17(uStack_b1,uStack_b8);
            pppppppuStack_230 = (undefined8 *******)CONCAT17(uStack_b9,uStack_c0);
          }
        }
        lVar15 = plVar28[1];
        lVar17 = plVar28[2];
        plVar28[1] = lStack_240;
        plVar28[2] = lStack_238;
        pcVar22 = (code *)plVar28[3];
        lVar19 = plVar28[4];
        plVar28[3] = (long)pppppppuStack_230;
        plVar28[4] = lStack_228;
        lStack_240 = lVar15;
        lStack_238 = lVar17;
        pppppppuStack_230 = (undefined8 *******)pcVar22;
        lStack_228 = lVar19;
        if (pcVar22 != (code *)0x0) {
          (*pcVar22)(&lStack_240,&lStack_240,3);
        }
        if ((code *)CONCAT17(uStack_b9,uStack_c0) != (code *)0x0) {
          (*(code *)CONCAT17(uStack_b9,uStack_c0))(&pfStack_d0,&pfStack_d0,3);
        }
        if (*(code **)(*plVar28 + 0x20) == (code *)&UNK_00912648) {
          pppppppuStack_218 = (undefined8 *******)0xf;
          uStack_201 = 0;
          pppppppuStack_220 = &pppppppuStack_210;
          iVar13 = _ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7compareEPKc
                             (&pppppppuStack_220,&UNK_00dc6590);
        }
        else {
          (**(code **)(*plVar28 + 0x20))(&pppppppuStack_220,plVar28);
          iVar13 = _ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7compareEPKc
                             (&pppppppuStack_220,&UNK_00dc6590);
          if ((undefined8 ********)pppppppuStack_220 != &pppppppuStack_210) {
            func_0x0040a5b0(pppppppuStack_220);
          }
        }
        if (iVar13 == 0) {
          func_0x0040a8f0();
          if (param_9 == (undefined8 *)0x0) {
            func_0x0074654c(4,&UNK_00dc64b0,0x98,&UNK_00dc65b8);
            func_0x0040a8f0();
          }
          else {
            fVar32 = *param_6;
            fVar31 = param_6[1];
            *(undefined8 *)(param_6 + 0xa6) = *param_9;
            fVar33 = param_6[2];
            iVar13 = IcImageBufferValidWidth(*param_9);
            if (((int)(fVar32 * fVar31 * 0.125) == iVar13) &&
               (iVar13 = IcImageBufferValidHeight(*param_9),
               (int)(fVar32 * fVar33 * 0.125) == iVar13)) {
              func_0x0040a8f0();
            }
            else {
              func_0x0074654c(4,&UNK_00dc64b0,0x93,&UNK_00dc65a0);
              func_0x0040a8f0();
            }
          }
          pcVar22 = *(code **)(*plVar28 + 0x20);
          if (pcVar22 != (code *)&UNK_00912648) goto LAB_0091aac4;
LAB_0091a114:
          pfStack_d0 = (float *)&uStack_c0;
          uStack_c0 = _UNK_00dc5518;
          uStack_b9 = UNK_00dc551f;
          uStack_b8 = _UNK_00dc5520;
          pauStack_c8 = (undefined1 (*) [16])0xf;
          uStack_b1 = 0;
          iVar13 = _ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7compareEPKc
                             (&pfStack_d0,&UNK_00dc65d0);
        }
        else {
          pcVar22 = *(code **)(*plVar28 + 0x20);
          if (pcVar22 == (code *)&UNK_00912648) goto LAB_0091a114;
LAB_0091aac4:
          (*pcVar22)(&pfStack_d0,plVar28);
          iVar13 = _ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7compareEPKc
                             (&pfStack_d0,&UNK_00dc65d0);
          if (pfStack_d0 != (float *)&uStack_c0) {
            func_0x0040a5b0(pfStack_d0);
          }
        }
        if (iVar13 == 0) {
          func_0x0040a8f0();
          if (param_9 == (undefined8 *)0x0) {
            func_0x0074654c(4,&UNK_00dc64b0,0xb3,&UNK_00dc65b8);
          }
          else {
            *(undefined8 *)(param_6 + 0xa8) = param_9[1];
            fVar32 = *param_6;
            fVar31 = param_6[1];
            *(undefined8 *)(param_6 + 0xaa) = param_9[2];
            fVar33 = param_6[2];
            *(undefined8 *)(param_6 + 0xac) = param_9[3];
            iVar13 = IcImageBufferValidWidth(param_9[1]);
            if (((int)(fVar32 * fVar31 * 0.5) != iVar13) ||
               (iVar13 = IcImageBufferValidHeight(param_9[1]),
               (int)(fVar32 * fVar33 * 0.5) != iVar13)) {
              func_0x0074654c(4,&UNK_00dc64b0,0xae,&UNK_00dc65a0);
            }
          }
          func_0x0040a8f0();
        }
        lVar15 = func_0x0040a8f0();
        puStack_348 = auStack_1f8;
        if (iStack_300 != 0) {
          puStack_348 = (undefined1 *)(lStack_280 + (long)iStack_2fc * 0x58);
        }
        lStack_370 = param_3;
        if (iVar12 + -1 != iStack_300) {
          lStack_370 = lStack_280 + (long)(1 - iStack_2fc) * 0x58;
        }
        uVar10 = 3;
        if (*(code **)(*plVar28 + 0x48) != (code *)&UNK_00912630) {
          uVar10 = (**(code **)(*plVar28 + 0x48))(plVar28,3);
        }
        func_0x00903ee0(lStack_370,uVar10,0xffffffff,0xffffffff);
        auVar35 = func_0x00916e38(auStack_148,iStack_300);
        uVar29 = auVar35._0_8_;
        auVar36 = func_0x00916e78(auStack_148,iStack_300);
        plVar27 = auVar36._8_8_;
        uVar21 = auVar36._0_8_;
        func_0x00904420(lStack_370,uVar21,plVar27);
        func_0x00904420(auStack_1a0,uVar21,plVar27);
        if (iStack_300 == 0) {
          func_0x00904420(puStack_348,uVar29,auVar35._8_8_);
          if (uVar25 == 0) goto LAB_0091ab2c;
LAB_0091a2f8:
          pppppppuStack_230 = (undefined8 *******)0x0;
          lStack_238 = 0;
          lStack_240 = 0;
          if (0x2e8ba2e8ba2e8ba < uVar25) {
            func_0x00409d50();
            goto LAB_0091afd0;
          }
          lVar17 = func_0x00409e60(pppppppuVar24);
          pppppppuStack_230 = (undefined8 *******)(lVar17 + (long)pppppppuVar24);
          uVar30 = uVar25;
          lStack_240 = lVar17;
          lStack_238 = lVar17;
          do {
            IcImageBufferDefault(lVar17);
            lVar17 = lVar17 + 0x58;
            uVar30 = uVar30 - 1;
          } while (uVar30 != 0);
          pppppppuStack_220 = (undefined8 *******)0x0;
          pppppppuStack_218 = (undefined8 *******)0x0;
          pppppppuStack_210 = (undefined8 *******)0x0;
          lStack_238 = lVar17;
          pppppppuVar18 = (undefined8 *******)func_0x00409e60(pppppppuVar24);
          pppppppuStack_210 = pppppppuVar18 + (long)iVar11 * 0xb;
          uVar30 = uVar25;
          pppppppuStack_220 = pppppppuVar18;
          pppppppuStack_218 = pppppppuVar18;
          do {
            IcImageBufferDefault(pppppppuVar18);
            pppppppuVar18 = pppppppuVar18 + 0xb;
            uVar30 = uVar30 - 1;
            plVar27 = (long *)0x0;
          } while (uVar30 != 0);
        }
        else {
          func_0x00904420(puStack_348,uVar21,plVar27);
          if (uVar25 != 0) goto LAB_0091a2f8;
LAB_0091ab2c:
          lStack_240 = 0;
          pppppppuVar18 = (undefined8 *******)0x0;
          lStack_238 = 0;
          pppppppuStack_220 = (undefined8 *******)0x0;
          pppppppuStack_230 = pppppppuVar24;
          pppppppuStack_210 = pppppppuVar24;
        }
        pppppppuStack_218 = pppppppuVar18;
        uVar10 = IcImageBufferValidWidth(lStack_370);
        iVar14 = IcImageBufferValidHeight(lStack_370);
        iVar13 = 0;
        if (iVar11 != 0) {
          iVar13 = (iVar11 + iVar14 + -1) / iVar11;
        }
        lVar17 = *(long *)(param_1 + 8) + uStack_2e8;
        uVar3 = iVar13 + 7U & 0xfffffff8;
        uVar30 = 0;
        if (uVar25 != 0) {
          uVar30 = (*(long *)(param_1 + 0x10) - uStack_2e8) / uVar25;
        }
        uVar30 = uVar30 & 0xffffffffffffffe0;
        if (uVar25 == 0) {
          plVar27 = (long *)0x0;
          pauStack_350 = (undefined1 (*) [16])0x0;
          plStack_318 = (long *)0x0;
LAB_0091ad64:
          pcVar22 = *(code **)(*plVar28 + 0x50);
          if (pcVar22 != (code *)&UNK_00904eb0) {
LAB_0091ab80:
            (*pcVar22)(plVar28,param_6);
            if (0 < iVar11) goto LAB_0091a4d8;
          }
        }
        else {
          if (0x13b13b13b13b13b < uVar25) {
LAB_0091afd0:
            uVar21 = func_0x00409d50();
            do {
              func_0x00916ad0(auStack_148);
              func_0x00919bd8(&lStack_280);
              func_0x0040a750(uVar21);
              func_0x00409d00();
              for (plVar28 = plVar27; plVar27 != plVar28; plVar28 = plVar28 + 0xb) {
                IcImageBufferDestroy(plVar28);
              }
              uVar21 = func_0x0040aa80();
              if ((code *)CONCAT17(uStack_b9,uStack_c0) != (code *)0x0) {
                (*(code *)CONCAT17(uStack_b9,uStack_c0))(&pfStack_d0,&pfStack_d0,3);
              }
              plVar27 = plStack_318;
              if (pauStack_350 != (undefined1 (*) [16])0x0) {
                func_0x0040a5b0();
              }
              for (; plVar28 != plVar27; plVar27 = plVar27 + 0x1a) {
                IcImageBufferDestroy(plVar27 + 0xf);
                IcImageBufferDestroy(plVar27 + 4);
              }
              if (plStack_318 != (long *)0x0) {
                func_0x0040a5b0();
              }
              func_0x00919bd8(&pppppppuStack_220);
              func_0x00919bd8(&lStack_240);
              IcImageBufferDestroy(auStack_1a0);
              IcImageBufferDestroy(auStack_1f8);
              plVar27 = plVar28;
              if (lStack_260 != 0) {
                func_0x0040a5b0();
              }
            } while( true );
          }
          plStack_318 = (long *)func_0x00409e60((long)iVar11 * 0xd0);
          uVar16 = uVar25;
          plVar27 = plStack_318;
          do {
            *plVar27 = 0;
            plVar27[1] = 0;
            plVar27[2] = 0;
            plVar27[3] = 0;
            IcImageBufferDefault(plVar27 + 4);
            IcImageBufferDefault(plVar27 + 0xf);
            plVar27 = plVar27 + 0x1a;
            uVar16 = uVar16 - 1;
          } while (uVar16 != 0);
          pauStack_350 = (undefined1 (*) [16])func_0x00409e60(uVar25 * 0x10);
          pauVar20 = pauStack_350;
          do {
            pauVar23 = pauVar20 + 1;
            *(undefined8 *)(*pauVar20 + 8) = 0;
            *(undefined8 *)*pauVar20 = 0;
            pauVar20 = pauVar23;
          } while (pauVar23 != pauStack_350 + uVar25);
          if (iVar11 < 1) goto LAB_0091ad64;
          if (iStack_300 == 0) {
            pauVar20 = pauStack_350;
            do {
              *pauVar20 = auVar35;
              pauVar20 = pauVar20 + 1;
            } while (pauStack_350 + (ulong)(iVar11 - 1) + 1 != pauVar20);
            pcVar22 = *(code **)(*plVar28 + 0x50);
          }
          else {
            pauVar20 = pauStack_350;
            do {
              *(int *)*pauVar20 = (int)uVar29;
              *(int *)(*pauVar20 + 4) = auVar35._4_4_;
              pauVar23 = pauVar20 + 1;
              *(long *)(*pauVar20 + 8) = auVar35._8_8_;
              uVar29 = (ulong)((int)uVar29 + uVar3);
              pauVar20 = pauVar23;
            } while (pauVar23 != pauStack_350 + (ulong)(iVar11 - 1) + 1);
            pcVar22 = *(code **)(*plVar28 + 0x50);
          }
          if (pcVar22 != (code *)&UNK_00904eb0) goto LAB_0091ab80;
LAB_0091a4d8:
          if (*param_8 == '\0') {
            iVar13 = 0;
            uVar29 = 0;
            plVar26 = plStack_318;
            lVar19 = lVar17;
            do {
              uStack_c0 = (undefined7)lVar19;
              uStack_b9 = (undefined1)((ulong)lVar19 >> 0x38);
              uStack_b8 = (undefined7)uVar30;
              uStack_b1 = (undefined1)(uVar30 >> 0x38);
              pauStack_c8 = pauStack_350 + uVar29;
              lVar34 = lStack_240 + uVar29 * 0x58;
              pppppppuVar18 = pppppppuStack_220 + uVar29 * 0xb;
              pfStack_d0 = param_6;
              IcImageBufferDefault(auStack_b0);
              IcImageBufferDefault(auStack_58);
              plVar26[2] = CONCAT17(uStack_b9,uStack_c0);
              plVar26[3] = CONCAT17(uStack_b1,uStack_b8);
              *(undefined1 *)(plVar26 + 4) = auStack_b0[0];
              plVar1 = plVar26 + 4;
              *(undefined4 *)(plVar26 + 5) = uStack_a8;
              *(undefined4 *)((long)plVar26 + 0x24) = uStack_ac;
              plVar26[1] = (long)pauStack_c8;
              *plVar26 = (long)pfStack_d0;
              *(undefined8 *)((long)plVar26 + 0x2c) = uStack_a4;
              *(undefined8 *)((long)plVar26 + 0x34) = uStack_9c;
              *(undefined4 *)((long)plVar26 + 0x3c) = uStack_94;
              *(undefined4 *)(plVar26 + 8) = uStack_90;
              *(undefined4 *)((long)plVar26 + 0x44) = uStack_8c;
              plVar26[9] = lStack_88;
              *(undefined4 *)(plVar26 + 10) = uStack_80;
              _ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_assignERKS4_
                        (plVar26 + 0xb,auStack_78);
              *(undefined1 *)(plVar26 + 0xf) = auStack_58[0];
              *(undefined8 *)((long)plVar26 + 0x7c) = uStack_54;
              *(undefined8 *)((long)plVar26 + 0x84) = uStack_4c;
              *(undefined8 *)((long)plVar26 + 0x8c) = uStack_44;
              *(undefined4 *)((long)plVar26 + 0x94) = uStack_3c;
              *(undefined4 *)(plVar26 + 0x13) = uStack_38;
              *(undefined4 *)((long)plVar26 + 0x9c) = uStack_34;
              plVar26[0x14] = lStack_30;
              *(undefined4 *)(plVar26 + 0x15) = uStack_28;
              _ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_assignERKS4_
                        (plVar26 + 0x16,auStack_20);
              IcImageBufferDestroy(auStack_58);
              IcImageBufferDestroy(auStack_b0);
              iVar14 = IcImageBufferValidHeight(lStack_370);
              uVar4 = iVar14 - iVar13;
              if ((int)uVar3 < iVar14 - iVar13) {
                uVar4 = uVar3;
              }
              if (param_5 != 0) {
                func_0x00904148(plVar26 + 0xf,param_5,1);
              }
              func_0x00904148(plVar1,auStack_1a0,1);
              func_0x00904010(plVar1,uVar10,uVar4);
              func_0x00904018(plVar1,0,iVar13);
              func_0x00904148(lVar34,puStack_348,1);
              func_0x00904010(lVar34,uVar10,uVar4);
              func_0x00904018(lVar34,0,iVar13);
              func_0x00904148(pppppppuVar18,lStack_370,1);
              func_0x00904010(pppppppuVar18,uVar10,uVar4);
              func_0x00904018(pppppppuVar18,0,iVar13);
              uStack_c0 = 0;
              uStack_b9 = 0;
              pfStack_d0 = (float *)func_0x00409e60(0x28);
              uStack_c0 = 0x919b30;
              uStack_b9 = 0;
              uStack_b8 = 0x919b10;
              uStack_b1 = 0;
              *(long **)pfStack_d0 = plVar28;
              *(float **)(pfStack_d0 + 6) = param_6;
              *(long **)(pfStack_d0 + 8) = plVar26;
              *(long *)(pfStack_d0 + 2) = lVar34;
              *(undefined8 ********)(pfStack_d0 + 4) = pppppppuVar18;
              func_0x00716cb4(param_7,uVar29 & 0xffffffff,&pfStack_d0);
              if ((code *)CONCAT17(uStack_b9,uStack_c0) != (code *)0x0) {
                (*(code *)CONCAT17(uStack_b9,uStack_c0))(&pfStack_d0,&pfStack_d0,3);
              }
              if (iVar11 <= (int)uVar29 + 1) break;
              uVar29 = uVar29 + 1;
              plVar26 = plVar26 + 0x1a;
              iVar13 = iVar13 + uVar3;
              lVar19 = lVar19 + uVar30;
            } while (*param_8 == '\0');
          }
        }
        func_0x00716e60(param_7);
        lVar19 = func_0x0040a8f0();
        iStack_2e0 = (int)(lVar15 / 1000000);
        iStack_2e0 = (int)(lVar19 / 1000000) - iStack_2e0;
        pfStack_d0 = (float *)CONCAT44(pfStack_d0._4_4_,iStack_2e0);
        if (piStack_258 == piStack_250) {
          func_0x00919c38(&lStack_260,piStack_258,&pfStack_d0);
        }
        else {
          *piStack_258 = iStack_2e0;
          piStack_258 = piStack_258 + 1;
        }
        lVar15 = *plVar28;
        if (*(char *)(param_6 + 0xa4) != '\0') {
          lVar19 = *(long *)(param_1 + 0x10);
          if (*(code **)(lVar15 + 0x20) == (code *)&UNK_00912648) {
            pfStack_d0 = (float *)&uStack_c0;
            uStack_c0 = _UNK_00dc5518;
            uStack_b9 = UNK_00dc551f;
            uStack_b8 = _UNK_00dc5520;
            pauStack_c8 = (undefined1 (*) [16])0xf;
            uStack_b1 = 0;
            iVar13 = _ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7compareEPKc(&pfStack_d0)
            ;
            if (iVar13 == 0) {
LAB_0091a830:
              func_0x0040a8f0();
              if (param_9 != (undefined8 *)0x0) {
                func_0x0097c010(param_9,lStack_370,0,lVar17,lVar19 - uStack_2e8);
              }
              func_0x0040a8f0();
            }
LAB_0091a858:
            lVar15 = *plVar28;
          }
          else {
            (**(code **)(lVar15 + 0x20))(&pfStack_d0,plVar28);
            iVar13 = _ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7compareEPKc
                               (&pfStack_d0,&UNK_00dc5518);
            if (iVar13 == 0) {
              if (pfStack_d0 != (float *)&uStack_c0) {
                func_0x0040a5b0();
              }
              goto LAB_0091a830;
            }
            if (pfStack_d0 == (float *)&uStack_c0) goto LAB_0091a858;
            func_0x0040a5b0();
            lVar15 = *plVar28;
          }
        }
        if ((*(code **)(lVar15 + 0x28) == (code *)&UNK_00904ea8) ||
           (cVar9 = (**(code **)(lVar15 + 0x28))(plVar28), cVar9 == '\0')) {
          iStack_2fc = 1 - iStack_2fc;
        }
        plVar28 = plStack_318;
        if (pauStack_350 != (undefined1 (*) [16])0x0) {
          func_0x0040a5b0();
        }
        for (; plVar28 != plVar27; plVar28 = plVar28 + 0x1a) {
          IcImageBufferDestroy(plVar28 + 0xf);
          IcImageBufferDestroy(plVar28 + 4);
        }
        pppppppuVar18 = pppppppuStack_220;
        pppppppuVar6 = pppppppuStack_218;
        pppppppuVar7 = pppppppuStack_218;
        if (plStack_318 != (long *)0x0) {
          func_0x0040a5b0();
          pppppppuVar18 = pppppppuStack_220;
          pppppppuVar6 = pppppppuStack_218;
          pppppppuVar7 = pppppppuStack_218;
        }
        for (; pppppppuVar8 = pppppppuStack_218, pppppppuVar18 != pppppppuStack_218;
            pppppppuVar18 = pppppppuVar18 + 0xb) {
          pppppppuStack_218 = pppppppuVar7;
          IcImageBufferDestroy(pppppppuVar18);
          pppppppuVar6 = pppppppuStack_220;
          pppppppuVar7 = pppppppuStack_218;
          pppppppuStack_218 = pppppppuVar8;
        }
        lVar15 = lStack_240;
        lVar17 = lStack_238;
        lVar19 = lStack_238;
        pppppppuStack_218 = pppppppuVar7;
        if (pppppppuVar6 != (undefined8 *******)0x0) {
          func_0x0040a5b0(pppppppuVar6);
          lVar15 = lStack_240;
          lVar17 = lStack_238;
          lVar19 = lStack_238;
        }
        for (; lVar34 = lStack_238, lVar15 != lStack_238; lVar15 = lVar15 + 0x58) {
          lStack_238 = lVar19;
          IcImageBufferDestroy(lVar15);
          lVar17 = lStack_240;
          lVar19 = lStack_238;
          lStack_238 = lVar34;
        }
        lStack_238 = lVar19;
        if (lVar17 != 0) {
          func_0x0040a5b0(lVar17);
        }
        iStack_300 = iStack_300 + 1;
      } while ((iVar12 != iStack_300) && (*param_8 == '\0'));
    }
    iVar11 = 0;
    func_0x0040a8f0();
LAB_0091a968:
    do {
      func_0x00916de0(&plStack_290,auStack_148,iVar11);
      plVar27 = plStack_288;
      plVar28 = plStack_290;
      lVar15 = _UNK_00dc6478;
      if (plStack_288 == (long *)0x0) {
LAB_0091a9a4:
        pcVar22 = *(code **)(*plVar28 + 0x20);
        if (pcVar22 != (code *)&UNK_00912648) {
LAB_0091ac58:
          (*pcVar22)(&pfStack_d0,plVar28);
          if (pfStack_d0 != (float *)&uStack_c0) {
            func_0x0040a5b0();
            iVar11 = iVar11 + 1;
            if (iVar12 == iVar11) {
              IcImageBufferDestroy(auStack_1a0);
              IcImageBufferDestroy(auStack_1f8);
              goto joined_r0x0091ac98;
            }
            goto LAB_0091a968;
          }
        }
      }
      else {
        if (_UNK_00dc6478 == 0) {
          lVar17 = plStack_288[1];
          *(int *)(plStack_288 + 1) = (int)lVar17 + -1;
          if ((int)lVar17 == 1) goto LAB_0091ac08;
          goto LAB_0091a9a4;
        }
        plVar26 = plStack_288 + 1;
        do {
          lVar17 = *plVar26;
          cVar9 = '\x01';
          bVar5 = (bool)ExclusiveMonitorPass(plVar26,0x10);
          if (bVar5) {
            *(int *)plVar26 = (int)lVar17 + -1;
            cVar9 = ExclusiveMonitorsStatus();
          }
        } while (cVar9 != '\0');
        if ((int)lVar17 != 1) goto LAB_0091a9a4;
LAB_0091ac08:
        (**(code **)(*plStack_288 + 0x10))(plStack_288);
        if (lVar15 == 0) {
          iVar13 = *(int *)((long)plVar27 + 0xc);
          *(int *)((long)plVar27 + 0xc) = iVar13 + -1;
        }
        else {
          piVar2 = (int *)((long)plVar27 + 0xc);
          do {
            iVar13 = *piVar2;
            cVar9 = '\x01';
            bVar5 = (bool)ExclusiveMonitorPass(piVar2,0x10);
            if (bVar5) {
              *piVar2 = iVar13 + -1;
              cVar9 = ExclusiveMonitorsStatus();
            }
          } while (cVar9 != '\0');
        }
        if (iVar13 != 1) goto LAB_0091a9a4;
        (**(code **)(*plVar27 + 0x18))(plVar27);
        pcVar22 = *(code **)(*plVar28 + 0x20);
        if (pcVar22 != (code *)&UNK_00912648) goto LAB_0091ac58;
      }
      iVar11 = iVar11 + 1;
    } while (iVar12 != iVar11);
  }
  IcImageBufferDestroy(auStack_1a0);
  IcImageBufferDestroy(auStack_1f8);
joined_r0x0091ac98:
  if (lStack_260 != 0) {
    func_0x0040a5b0();
  }
  func_0x00916ad0(auStack_148);
  lVar19 = lStack_278;
  lVar17 = lStack_278;
  for (lVar15 = lStack_280; lVar15 != lVar19; lVar15 = lVar15 + 0x58) {
    IcImageBufferDestroy(lVar15);
    lVar17 = lStack_280;
  }
LAB_0091aa10:
  if (lVar17 != 0) {
    func_0x0040a5b0(lVar17);
  }
  return;
}

