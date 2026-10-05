// INPUT SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
// STATIC PSEUDOCODE; recovered types/ABI and flow across tail branches require instruction verification.
// Linked VA 0095ffe0

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined8 NativeICDimensionService(uint param_1,uint param_2)

{
  float *pfVar1;
  undefined8 uVar2;
  int iVar3;
  float *pfVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  float *pfVar8;
  float *pfVar9;
  float fVar10;
  float fVar11;
  float fVar12;
  float fVar13;
  int iVar14;
  int iVar15;
  float fVar16;
  float fVar17;
  
  if (pfRam00000000041fd250 == (float *)0x0) {
    pfVar4 = (float *)func_0x00409e60(0x198);
    func_0x0095fb48();
    pfRam00000000041fd250 = pfVar4;
  }
  pfVar4 = pfRam00000000041fd250;
  if (param_1 < 0x7a61 && param_2 < 0x7582) {
    pfVar1 = pfRam00000000041fd250 + 0x61;
    fVar10 = (float)func_0x0040a230((float)(int)param_1 * 0.0056497175,0x43310000);
    fVar11 = (float)func_0x0040a230((float)(int)param_1,0x43310000);
    iVar6 = (int)fVar10 + 2;
    iVar14 = (int)fVar11 + 2;
    fVar10 = (float)func_0x0040a230((float)(int)param_2 * 0.00591716,0x43320000);
    iVar15 = (int)fVar10 + 1;
    fVar10 = (float)func_0x0040a230((float)(int)param_2,0x43290000);
    fVar11 = (float)iVar15;
    fVar10 = (float)(int)fVar10;
    pfVar8 = pfVar4;
    do {
      iVar5 = 0x18;
      fVar17 = 0.5;
      fVar16 = 0.0;
      iVar7 = iVar6;
      iVar3 = iVar14;
      do {
        iVar14 = iVar15;
        iVar6 = iVar3;
        fVar12 = (float)func_0x0040a230((float)(iVar6 * iVar7),0x43330000);
        fVar11 = (float)func_0x0040a230(fVar11 * fVar12,0x43330000);
        iVar15 = (int)fVar11;
        fVar11 = (float)iVar15;
        fVar10 = (float)func_0x0040a230(fVar10 * 53.0 + 1.0,0x43290000);
        fVar10 = (float)(int)fVar10;
        fVar13 = (float)func_0x0040a230(fVar10 * fVar11,0x42800000);
        fVar12 = fVar16 + fVar17;
        fVar17 = fVar17 * 0.5;
        if (fVar13 < 32.0) {
          fVar12 = fVar16;
        }
        fVar16 = fVar12;
        iVar5 = iVar5 + -1;
        iVar7 = iVar6;
        iVar3 = iVar14;
      } while (iVar5 != 0);
      pfVar9 = pfVar8 + 1;
      *pfVar8 = fVar16;
      uVar2 = _UNK_00dcb298;
      pfVar8 = pfVar9;
    } while (pfVar9 != pfVar1);
    *(undefined8 *)(pfVar4 + 0x61) = _UNK_00dcb290;
    pfVar4[99] = 0.9999998;
    *(undefined8 *)(pfVar4 + 100) = uVar2;
    return 0;
  }
  return 1;
}

