// INPUT SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
// STATIC PSEUDOCODE; recovered types/ABI and flow across tail branches require instruction verification.
// Linked VA 009227b0

undefined8
NativeRawReaderConstructor
          (undefined8 param_1,undefined8 param_2,long param_3,undefined8 param_4,long param_5,
          long param_6,undefined4 param_7,undefined4 param_8,undefined4 param_9,undefined4 param_10,
          undefined4 param_11,undefined4 param_12,undefined4 param_13,undefined4 param_14,
          undefined4 param_15,undefined4 param_16,undefined4 param_17,undefined4 param_18,
          long *param_19)

{
  long lVar1;
  undefined4 uVar2;
  undefined4 uVar3;
  undefined4 uVar4;
  uint uVar5;
  long lVar6;
  long *plVar7;
  long *plVar8;
  ulong uVar9;
  long lVar10;
  uint uVar11;
  ulong uVar12;
  uint uVar13;
  ulong uVar14;
  uint uVar15;
  long *aplStack_20 [2];
  code *pcStack_10;
  undefined *puStack_8;
  
  func_0x0040a8f0();
  func_0x00922170(param_1,param_4,param_8,param_9,param_12,param_13,param_10,param_11,param_14,
                  param_15,param_16,param_17,0x10,1,0,0,0,0x10);
  func_0x0093c7e0(param_3,param_1);
  lVar6 = func_0x009224b0(param_1);
  uVar2 = func_0x009224d0(param_1);
  uVar3 = func_0x009224c8(param_1);
  uVar4 = func_0x00922540(param_1);
  func_0x0040a8f0();
  uVar12 = param_19[1] - *param_19 >> 2;
  uVar11 = (uint)uVar12;
  if (uVar11 != 0) {
    uVar5 = func_0x00716c1c(param_2);
    uVar14 = (ulong)uVar5;
    if (uVar14 != 0) {
      plVar7 = (long *)func_0x00409e60(uVar14 * 0x58);
      plVar8 = plVar7;
      uVar9 = uVar14;
      do {
        *plVar8 = 0;
        plVar8[1] = 0;
        uVar9 = uVar9 - 1;
        plVar8[2] = 0;
        plVar8[3] = 0;
        plVar8[4] = 0;
        *(undefined4 *)(plVar8 + 9) = 0;
        plVar8[10] = 0;
        plVar8[6] = 0;
        plVar8[5] = 0;
        plVar8[8] = 0;
        plVar8[7] = 0;
        plVar8 = plVar8 + 0xb;
      } while (uVar9 != 0);
      uVar9 = 0;
      if (uVar14 != 0) {
        uVar9 = (((uVar12 & 0xffffffff) - 1) + uVar14) / uVar14;
      }
      if (uVar5 != 0) {
        uVar15 = 0;
        uVar13 = 0;
        plVar8 = plVar7;
        do {
          while( true ) {
            lVar10 = param_19[1];
            if (uVar15 < uVar11) {
              lVar1 = *param_19 + (ulong)uVar15 * 4;
              *plVar8 = lVar1;
              if ((long)(uVar9 & 0xffffffff) < lVar10 - lVar1 >> 2) {
                lVar10 = lVar1 + (uVar9 & 0xffffffff) * 4;
              }
            }
            else {
              *plVar8 = lVar10;
            }
            plVar8[1] = lVar10;
            *(undefined4 *)((long)plVar8 + 0x2c) = uVar2;
            pcStack_10 = (code *)&UNK_009225c0;
            plVar8[4] = lVar6;
            *(undefined4 *)(plVar8 + 5) = param_7;
            *(undefined4 *)(plVar8 + 6) = uVar3;
            *(undefined4 *)((long)plVar8 + 0x34) = uVar4;
            *(undefined4 *)(plVar8 + 7) = param_18;
            *(undefined4 *)((long)plVar8 + 0x3c) = param_9;
            *(undefined4 *)(plVar8 + 8) = param_8;
            *(undefined4 *)((long)plVar8 + 0x44) = 0;
            *(undefined4 *)(plVar8 + 9) = 0;
            plVar8[10] = param_3;
            plVar8[2] = param_5;
            plVar8[3] = param_6;
            puStack_8 = &UNK_009227a8;
            aplStack_20[0] = plVar8;
            func_0x00716cb4(param_2,uVar13,aplStack_20);
            uVar13 = uVar13 + 1;
            if (pcStack_10 == (code *)0x0) break;
            (*pcStack_10)(aplStack_20,aplStack_20,3);
            plVar8 = plVar8 + 0xb;
            uVar15 = uVar15 + (int)uVar9;
            if (uVar5 == uVar13) goto LAB_00922a18;
          }
          plVar8 = plVar8 + 0xb;
          uVar15 = uVar15 + (int)uVar9;
        } while (uVar5 != uVar13);
      }
LAB_00922a18:
      func_0x00716e60(param_2);
      func_0x0040a8f0();
      func_0x0040a5b0(plVar7);
      return param_1;
    }
    func_0x00716e60(param_2);
  }
  func_0x0040a8f0();
  return param_1;
}

