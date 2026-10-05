// INPUT SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
// STATIC PSEUDOCODE; recovered types/ABI and flow across tail branches require instruction verification.
// Linked VA 00944e88

undefined8 * NativeRawSourceFactory(undefined8 *param_1,long param_2)

{
  int iVar1;
  undefined1 **ppuVar2;
  long *plVar3;
  undefined8 **ppuVar4;
  undefined4 *puVar5;
  ulong *puVar6;
  bool bVar7;
  long lVar8;
  long *plVar9;
  long lVar10;
  undefined8 uVar11;
  long lVar12;
  long lVar13;
  long lVar14;
  undefined8 *puVar15;
  undefined8 *puVar16;
  ulong *puVar17;
  long unaff_x23;
  undefined1 **ppuVar18;
  undefined8 **ppuVar19;
  undefined4 *puVar20;
  undefined1 auVar21 [16];
  long **pplStack_d8;
  long **pplStack_d0;
  undefined8 **ppuStack_c8;
  undefined1 **ppuStack_c0;
  ulong uStack_b8;
  ulong *puStack_b0;
  ulong *puStack_a8;
  ulong *puStack_a0;
  long lStack_98;
  undefined1 **ppuStack_90;
  undefined8 uStack_88;
  long *plStack_80;
  undefined8 *puStack_78;
  undefined8 *puStack_70;
  long lStack_68;
  long *plStack_60;
  undefined8 uStack_58;
  long *plStack_50;
  undefined8 *puStack_48;
  undefined8 *puStack_40;
  long lStack_38;
  undefined8 *puStack_30;
  undefined4 auStack_28 [2];
  undefined4 *puStack_20;
  undefined4 *puStack_18;
  undefined4 *puStack_10;
  long lStack_8;
  
  lVar12 = *(long *)(param_2 + 0x10);
  if (lVar12 == 0) {
LAB_009452c0:
    *param_1 = 0;
    param_1[1] = 0;
    return param_1;
  }
  lVar10 = param_2 + 8;
  lVar14 = lVar12;
  lVar13 = lVar10;
  do {
    while (lVar8 = lVar14, *(uint *)(lVar8 + 0x20) < 0x103) {
      lVar14 = *(long *)(lVar8 + 0x18);
      if (*(long *)(lVar8 + 0x18) == 0) goto LAB_00944ed0;
    }
    lVar14 = *(long *)(lVar8 + 0x10);
    lVar13 = lVar8;
  } while (*(long *)(lVar8 + 0x10) != 0);
LAB_00944ed0:
  if ((lVar10 == lVar13) || (lVar14 = lVar10, 0x103 < *(uint *)(lVar13 + 0x20))) goto LAB_009452c0;
  do {
    while (lVar13 = lVar12, *(uint *)(lVar13 + 0x20) < 0x103) {
      lVar12 = *(long *)(lVar13 + 0x18);
      if (*(long *)(lVar13 + 0x18) == 0) goto LAB_00944f08;
    }
    lVar12 = *(long *)(lVar13 + 0x10);
    lVar14 = lVar13;
  } while (*(long *)(lVar13 + 0x10) != 0);
LAB_00944f08:
  if ((lVar10 == lVar14) || (0x103 < *(uint *)(lVar14 + 0x20))) {
    lVar12 = func_0x00409e60(0x40);
    *(undefined4 *)(lVar12 + 0x20) = 0x103;
    *(undefined8 *)(lVar12 + 0x28) = 0;
    *(undefined8 *)(lVar12 + 0x30) = 0;
    *(undefined8 *)(lVar12 + 0x38) = 0;
    auVar21 = func_0x007be648(param_2,lVar14,lVar12 + 0x20);
    lVar14 = auVar21._8_8_;
    unaff_x23 = auVar21._0_8_;
    if (lVar14 == 0) {
      func_0x0040a5b0(lVar12);
      lVar14 = unaff_x23;
      if (unaff_x23 == -0x28) goto LAB_009452c0;
    }
    else {
      bVar7 = unaff_x23 != 0 || lVar10 == lVar14;
      if (unaff_x23 == 0 && lVar10 != lVar14) {
        bVar7 = *(uint *)(lVar12 + 0x20) < *(uint *)(lVar14 + 0x20);
      }
      func_0x0040b020(bVar7,lVar12,lVar14,lVar10);
      *(long *)(param_2 + 0x28) = *(long *)(param_2 + 0x28) + 1;
      lVar14 = lVar12;
    }
  }
  if (*(int *)(lVar14 + 0x28) != 1) {
    uVar11 = func_0x00941f30();
    do {
      func_0x007bd21c(unaff_x23,plStack_80);
      func_0x0040a5b0();
      uVar11 = func_0x0040a750(uVar11);
      func_0x007bd21c(lVar10,plStack_50);
    } while( true );
  }
  iVar1 = *(int *)(lVar14 + 0x30);
  if (iVar1 == 0x19) {
    plVar9 = (long *)func_0x00409e60(0x68);
    lVar12 = *(long *)(param_2 + 0x10);
    puStack_18 = auStack_28;
    *plVar9 = (long)&UNK_00dc8d40;
    plVar9[1] = 0x100000001;
    auStack_28[0] = 0;
    puStack_20 = (undefined4 *)0x0;
    lStack_8 = 0;
    puStack_10 = puStack_18;
    if (lVar12 != 0) {
      ppuStack_90 = (undefined1 **)&puStack_30;
      puStack_20 = (undefined4 *)func_0x00948118(&puStack_30,lVar12,puStack_18,&ppuStack_90);
      puVar5 = puStack_20;
      do {
        puStack_18 = puVar5;
        puVar20 = puStack_20;
        puVar5 = *(undefined4 **)(puStack_18 + 4);
      } while (*(undefined4 **)(puStack_18 + 4) != (undefined4 *)0x0);
      do {
        puStack_10 = puVar20;
        puVar20 = *(undefined4 **)(puStack_10 + 6);
      } while (*(undefined4 **)(puStack_10 + 6) != (undefined4 *)0x0);
      lStack_8 = *(long *)(param_2 + 0x28);
    }
    plVar3 = plVar9 + 4;
    plVar9[2] = (long)&UNK_00dc8b90;
    *(undefined4 *)(plVar9 + 4) = 0;
    plVar9[5] = 0;
    plVar9[6] = (long)plVar3;
    plStack_50 = plVar9 + 3;
    plVar9[7] = (long)plVar3;
    plVar9[8] = 0;
    *(undefined1 *)(plVar9 + 9) = 0;
    plVar9[0xb] = 0;
    plVar9[10] = 0;
    plVar9[0xc] = 0;
    uStack_58 = 0;
    plStack_60 = (long *)0x0;
    if (puStack_20 == (undefined4 *)0x0) {
      plVar9[2] = (long)&UNK_00dc8bd8;
    }
    else {
      lVar10 = func_0x00947df0(plStack_50,puStack_20,plVar3,&plStack_60);
      plVar3 = plStack_50;
      lVar12 = lVar10;
      do {
        lVar14 = lVar12;
        lVar12 = *(long *)(lVar14 + 0x10);
      } while (lVar12 != 0);
      plVar9[6] = lVar14;
      lVar12 = lVar10;
      do {
        lVar14 = lVar12;
        lVar12 = *(long *)(lVar14 + 0x18);
      } while (lVar12 != 0);
      plVar9[7] = lVar14;
      plVar9[8] = lStack_8;
      plVar9[5] = lVar10;
      ppuVar2 = (undefined1 **)plStack_60;
      while (ppuVar2 != (undefined1 **)0x0) {
        func_0x007bd21c(plVar3,ppuVar2[3]);
        ppuVar18 = (undefined1 **)ppuVar2[2];
        func_0x0040a5b0(ppuVar2);
        ppuVar2 = ppuVar18;
      }
      plVar9[2] = (long)&UNK_00dc8bd8;
      puVar5 = puStack_20;
      while (puVar5 != (undefined4 *)0x0) {
        func_0x007bd21c(&puStack_30,*(undefined8 *)(puVar5 + 6));
        puVar20 = *(undefined4 **)(puVar5 + 4);
        func_0x0040a5b0(puVar5);
        puVar5 = puVar20;
      }
    }
LAB_009456b8:
    uVar11 = (**(code **)(*plVar9 + 0x20))(plVar9,&UNK_00c18550);
    *param_1 = uVar11;
    param_1[1] = plVar9;
    return param_1;
  }
  if (iVar1 == 0x1b) {
    plVar9 = (long *)func_0x00409e60(0x68);
    lVar12 = *(long *)(param_2 + 0x10);
    puStack_18 = auStack_28;
    *plVar9 = (long)&UNK_00dc8d78;
    plVar9[1] = 0x100000001;
    auStack_28[0] = 0;
    puStack_20 = (undefined4 *)0x0;
    lStack_8 = 0;
    puStack_10 = puStack_18;
    if (lVar12 != 0) {
      ppuStack_90 = (undefined1 **)&puStack_30;
      puStack_20 = (undefined4 *)func_0x00948118(&puStack_30,lVar12,puStack_18,&ppuStack_90);
      puVar5 = puStack_20;
      do {
        puStack_18 = puVar5;
        puVar20 = puStack_20;
        puVar5 = *(undefined4 **)(puStack_18 + 4);
      } while (*(undefined4 **)(puStack_18 + 4) != (undefined4 *)0x0);
      do {
        puStack_10 = puVar20;
        puVar20 = *(undefined4 **)(puStack_10 + 6);
      } while (*(undefined4 **)(puStack_10 + 6) != (undefined4 *)0x0);
      lStack_8 = *(long *)(param_2 + 0x28);
    }
    plVar3 = plVar9 + 4;
    plVar9[2] = (long)&UNK_00dc8b90;
    *(undefined4 *)(plVar9 + 4) = 0;
    plVar9[5] = 0;
    plVar9[6] = (long)plVar3;
    plStack_50 = plVar9 + 3;
    plVar9[7] = (long)plVar3;
    plVar9[8] = 0;
    *(undefined1 *)(plVar9 + 9) = 0;
    plVar9[0xb] = 0;
    plVar9[10] = 0;
    plVar9[0xc] = 0;
    uStack_58 = 0;
    plStack_60 = (long *)0x0;
    if (puStack_20 == (undefined4 *)0x0) {
      plVar9[2] = (long)&UNK_00dc8c20;
    }
    else {
      lVar10 = func_0x00947df0(plStack_50,puStack_20,plVar3,&plStack_60);
      plVar3 = plStack_50;
      lVar12 = lVar10;
      do {
        lVar14 = lVar12;
        lVar12 = *(long *)(lVar14 + 0x10);
      } while (lVar12 != 0);
      plVar9[6] = lVar14;
      lVar12 = lVar10;
      do {
        lVar14 = lVar12;
        lVar12 = *(long *)(lVar14 + 0x18);
      } while (lVar12 != 0);
      plVar9[7] = lVar14;
      plVar9[8] = lStack_8;
      plVar9[5] = lVar10;
      ppuVar2 = (undefined1 **)plStack_60;
      while (ppuVar2 != (undefined1 **)0x0) {
        func_0x007bd21c(plVar3,ppuVar2[3]);
        ppuVar18 = (undefined1 **)ppuVar2[2];
        func_0x0040a5b0(ppuVar2);
        ppuVar2 = ppuVar18;
      }
      plVar9[2] = (long)&UNK_00dc8c20;
      puVar5 = puStack_20;
      while (puVar5 != (undefined4 *)0x0) {
        func_0x007bd21c(&puStack_30,*(undefined8 *)(puVar5 + 6));
        puVar20 = *(undefined4 **)(puVar5 + 4);
        func_0x0040a5b0(puVar5);
        puVar5 = puVar20;
      }
    }
    goto LAB_009456b8;
  }
  if (iVar1 == 0x1c) {
    plVar9 = (long *)func_0x00409e60(0x68);
    lVar12 = *(long *)(param_2 + 0x10);
    puStack_48 = &uStack_58;
    *plVar9 = (long)&UNK_00dc8db0;
    plVar9[1] = 0x100000001;
    uStack_58 = (ulong)uStack_58._4_4_ << 0x20;
    plStack_50 = (undefined8 *)0x0;
    lStack_38 = 0;
    puStack_40 = puStack_48;
    if (lVar12 == 0) {
      puStack_18 = auStack_28;
      auStack_28[0] = 0;
      puStack_20 = (undefined4 *)0x0;
      lStack_8 = 0;
      puStack_10 = puStack_18;
    }
    else {
      ppuStack_c8 = &plStack_60;
      plStack_50 = (long *)func_0x00948118(&plStack_60,lVar12,puStack_48,&ppuStack_c8);
      puVar15 = plStack_50;
      do {
        puStack_48 = puVar15;
        puVar16 = plStack_50;
        puVar15 = (undefined8 *)puStack_48[2];
      } while ((undefined8 *)puStack_48[2] != (undefined8 *)0x0);
      do {
        puStack_40 = puVar16;
        puVar16 = (undefined8 *)puStack_40[3];
      } while ((undefined8 *)puStack_40[3] != (undefined8 *)0x0);
      lStack_38 = *(long *)(param_2 + 0x28);
      puStack_18 = auStack_28;
      auStack_28[0] = 0;
      puStack_20 = (undefined4 *)0x0;
      lStack_8 = 0;
      puStack_10 = puStack_18;
      if (plStack_50 != (undefined8 *)0x0) {
        ppuStack_c0 = (undefined1 **)&puStack_30;
        puStack_20 = (undefined4 *)func_0x00948118(&puStack_30,plStack_50,puStack_18,&ppuStack_c0);
        puVar5 = puStack_20;
        do {
          puStack_18 = puVar5;
          puVar20 = puStack_20;
          puVar5 = *(undefined4 **)(puStack_18 + 4);
        } while (*(undefined4 **)(puStack_18 + 4) != (undefined4 *)0x0);
        do {
          puStack_10 = puVar20;
          puVar20 = *(undefined4 **)(puStack_10 + 6);
        } while (*(undefined4 **)(puStack_10 + 6) != (undefined4 *)0x0);
        lStack_8 = lStack_38;
      }
    }
    plVar3 = plVar9 + 4;
    plVar9[2] = (long)&UNK_00dc8b90;
    *(undefined4 *)(plVar9 + 4) = 0;
    plVar9[5] = 0;
    plVar9[6] = (long)plVar3;
    plStack_80 = plVar9 + 3;
    plVar9[7] = (long)plVar3;
    plVar9[8] = 0;
    *(undefined1 *)(plVar9 + 9) = 0;
    plVar9[0xb] = 0;
    plVar9[10] = 0;
    plVar9[0xc] = 0;
    uStack_88 = 0;
    ppuStack_90 = (undefined1 **)0x0;
    if (puStack_20 != (undefined4 *)0x0) {
      lVar10 = func_0x00947df0(plStack_80,puStack_20,plVar3,&ppuStack_90);
      plVar3 = plStack_80;
      lVar12 = lVar10;
      do {
        lVar14 = lVar12;
        lVar12 = *(long *)(lVar14 + 0x10);
      } while (lVar12 != 0);
      plVar9[6] = lVar14;
      lVar12 = lVar10;
      do {
        lVar14 = lVar12;
        lVar12 = *(long *)(lVar14 + 0x18);
      } while (lVar12 != 0);
      plVar9[7] = lVar14;
      plVar9[8] = lStack_8;
      plVar9[5] = lVar10;
      ppuVar2 = ppuStack_90;
      while (ppuVar2 != (undefined1 **)0x0) {
        func_0x007bd21c(plVar3,ppuVar2[3]);
        ppuVar18 = (undefined1 **)ppuVar2[2];
        func_0x0040a5b0(ppuVar2);
        ppuVar2 = ppuVar18;
      }
      plVar9[2] = (long)&UNK_00dc8c20;
      puVar5 = puStack_20;
      while (puVar5 != (undefined4 *)0x0) {
        func_0x007bd21c(&puStack_30,*(undefined8 *)(puVar5 + 6));
        puVar20 = *(undefined4 **)(puVar5 + 4);
        func_0x0040a5b0(puVar5);
        puVar5 = puVar20;
      }
    }
    plVar9[2] = (long)&UNK_00dc8a28;
    plVar3 = plStack_50;
    while (plVar3 != (undefined8 *)0x0) {
      func_0x007bd21c(&plStack_60,plVar3[3]);
      puVar15 = (undefined8 *)plVar3[2];
      func_0x0040a5b0(plVar3);
      plVar3 = puVar15;
    }
LAB_00945518:
    uVar11 = (**(code **)(*plVar9 + 0x20))(plVar9,&UNK_00c18550);
    *param_1 = uVar11;
    param_1[1] = plVar9;
    return param_1;
  }
  if (iVar1 == 0x1d) {
    plVar9 = (long *)func_0x00409e60(0x68);
    lVar12 = *(long *)(param_2 + 0x10);
    puStack_48 = &uStack_58;
    *plVar9 = (long)&UNK_00dc8de8;
    plVar9[1] = 0x100000001;
    uStack_58 = (ulong)uStack_58._4_4_ << 0x20;
    plStack_50 = (undefined8 *)0x0;
    lStack_38 = 0;
    puStack_40 = puStack_48;
    if (lVar12 == 0) {
      puStack_18 = auStack_28;
      auStack_28[0] = 0;
      puStack_20 = (undefined4 *)0x0;
      lStack_8 = 0;
      puStack_10 = puStack_18;
    }
    else {
      ppuStack_c8 = &plStack_60;
      plStack_50 = (long *)func_0x00948118(&plStack_60,lVar12,puStack_48,&ppuStack_c8);
      puVar15 = plStack_50;
      do {
        puStack_48 = puVar15;
        puVar16 = plStack_50;
        puVar15 = (undefined8 *)puStack_48[2];
      } while ((undefined8 *)puStack_48[2] != (undefined8 *)0x0);
      do {
        puStack_40 = puVar16;
        puVar16 = (undefined8 *)puStack_40[3];
      } while ((undefined8 *)puStack_40[3] != (undefined8 *)0x0);
      lStack_38 = *(long *)(param_2 + 0x28);
      puStack_18 = auStack_28;
      auStack_28[0] = 0;
      puStack_20 = (undefined4 *)0x0;
      lStack_8 = 0;
      puStack_10 = puStack_18;
      if (plStack_50 != (undefined8 *)0x0) {
        ppuStack_c0 = (undefined1 **)&puStack_30;
        puStack_20 = (undefined4 *)func_0x00948118(&puStack_30,plStack_50,puStack_18,&ppuStack_c0);
        puVar5 = puStack_20;
        do {
          puStack_18 = puVar5;
          puVar20 = puStack_20;
          puVar5 = *(undefined4 **)(puStack_18 + 4);
        } while (*(undefined4 **)(puStack_18 + 4) != (undefined4 *)0x0);
        do {
          puStack_10 = puVar20;
          puVar20 = *(undefined4 **)(puStack_10 + 6);
        } while (*(undefined4 **)(puStack_10 + 6) != (undefined4 *)0x0);
        lStack_8 = lStack_38;
      }
    }
    plVar3 = plVar9 + 4;
    plVar9[2] = (long)&UNK_00dc8b90;
    *(undefined4 *)(plVar9 + 4) = 0;
    plVar9[5] = 0;
    plVar9[6] = (long)plVar3;
    plStack_80 = plVar9 + 3;
    plVar9[7] = (long)plVar3;
    plVar9[8] = 0;
    *(undefined1 *)(plVar9 + 9) = 0;
    plVar9[0xb] = 0;
    plVar9[10] = 0;
    plVar9[0xc] = 0;
    uStack_88 = 0;
    ppuStack_90 = (undefined1 **)0x0;
    if (puStack_20 != (undefined4 *)0x0) {
      lVar10 = func_0x00947df0(plStack_80,puStack_20,plVar3,&ppuStack_90);
      plVar3 = plStack_80;
      lVar12 = lVar10;
      do {
        lVar14 = lVar12;
        lVar12 = *(long *)(lVar14 + 0x10);
      } while (lVar12 != 0);
      plVar9[6] = lVar14;
      lVar12 = lVar10;
      do {
        lVar14 = lVar12;
        lVar12 = *(long *)(lVar14 + 0x18);
      } while (lVar12 != 0);
      plVar9[7] = lVar14;
      plVar9[8] = lStack_8;
      plVar9[5] = lVar10;
      ppuVar2 = ppuStack_90;
      while (ppuVar2 != (undefined1 **)0x0) {
        func_0x007bd21c(plVar3,ppuVar2[3]);
        ppuVar18 = (undefined1 **)ppuVar2[2];
        func_0x0040a5b0(ppuVar2);
        ppuVar2 = ppuVar18;
      }
      plVar9[2] = (long)&UNK_00dc8c20;
      puVar5 = puStack_20;
      while (puVar5 != (undefined4 *)0x0) {
        func_0x007bd21c(&puStack_30,*(undefined8 *)(puVar5 + 6));
        puVar20 = *(undefined4 **)(puVar5 + 4);
        func_0x0040a5b0(puVar5);
        puVar5 = puVar20;
      }
    }
    plVar9[2] = (long)&UNK_00dc8a70;
    plVar3 = plStack_50;
    while (plVar3 != (undefined8 *)0x0) {
      func_0x007bd21c(&plStack_60,plVar3[3]);
      puVar15 = (undefined8 *)plVar3[2];
      func_0x0040a5b0(plVar3);
      plVar3 = puVar15;
    }
    goto LAB_00945518;
  }
  if (iVar1 == 0x1e) {
    plVar9 = (long *)func_0x00409e60(0x68);
    lVar12 = *(long *)(param_2 + 0x10);
    puStack_48 = &uStack_58;
    *plVar9 = (long)&UNK_00dc8e20;
    plVar9[1] = 0x100000001;
    uStack_58 = (ulong)uStack_58._4_4_ << 0x20;
    plStack_50 = (undefined8 *)0x0;
    lStack_38 = 0;
    puStack_40 = puStack_48;
    if (lVar12 == 0) {
      puStack_18 = auStack_28;
      auStack_28[0] = 0;
      puStack_20 = (undefined4 *)0x0;
      lStack_8 = 0;
      puStack_10 = puStack_18;
    }
    else {
      ppuStack_c8 = &plStack_60;
      plStack_50 = (long *)func_0x00948118(&plStack_60,lVar12,puStack_48,&ppuStack_c8);
      puVar15 = plStack_50;
      do {
        puStack_48 = puVar15;
        puVar16 = plStack_50;
        puVar15 = (undefined8 *)puStack_48[2];
      } while ((undefined8 *)puStack_48[2] != (undefined8 *)0x0);
      do {
        puStack_40 = puVar16;
        puVar16 = (undefined8 *)puStack_40[3];
      } while ((undefined8 *)puStack_40[3] != (undefined8 *)0x0);
      lStack_38 = *(long *)(param_2 + 0x28);
      puStack_18 = auStack_28;
      auStack_28[0] = 0;
      puStack_20 = (undefined4 *)0x0;
      lStack_8 = 0;
      puStack_10 = puStack_18;
      if (plStack_50 != (undefined8 *)0x0) {
        ppuStack_c0 = (undefined1 **)&puStack_30;
        puStack_20 = (undefined4 *)func_0x00948118(&puStack_30,plStack_50,puStack_18,&ppuStack_c0);
        puVar5 = puStack_20;
        do {
          puStack_18 = puVar5;
          puVar20 = puStack_20;
          puVar5 = *(undefined4 **)(puStack_18 + 4);
        } while (*(undefined4 **)(puStack_18 + 4) != (undefined4 *)0x0);
        do {
          puStack_10 = puVar20;
          puVar20 = *(undefined4 **)(puStack_10 + 6);
        } while (*(undefined4 **)(puStack_10 + 6) != (undefined4 *)0x0);
        lStack_8 = lStack_38;
      }
    }
    plVar3 = plVar9 + 4;
    plVar9[2] = (long)&UNK_00dc8b90;
    *(undefined4 *)(plVar9 + 4) = 0;
    plVar9[5] = 0;
    plVar9[6] = (long)plVar3;
    plStack_80 = plVar9 + 3;
    plVar9[7] = (long)plVar3;
    plVar9[8] = 0;
    *(undefined1 *)(plVar9 + 9) = 0;
    plVar9[0xb] = 0;
    plVar9[10] = 0;
    plVar9[0xc] = 0;
    uStack_88 = 0;
    ppuStack_90 = (undefined1 **)0x0;
    if (puStack_20 != (undefined4 *)0x0) {
      lVar10 = func_0x00947df0(plStack_80,puStack_20,plVar3,&ppuStack_90);
      plVar3 = plStack_80;
      lVar12 = lVar10;
      do {
        lVar14 = lVar12;
        lVar12 = *(long *)(lVar14 + 0x10);
      } while (lVar12 != 0);
      plVar9[6] = lVar14;
      lVar12 = lVar10;
      do {
        lVar14 = lVar12;
        lVar12 = *(long *)(lVar14 + 0x18);
      } while (lVar12 != 0);
      plVar9[7] = lVar14;
      plVar9[8] = lStack_8;
      plVar9[5] = lVar10;
      ppuVar2 = ppuStack_90;
      while (ppuVar2 != (undefined1 **)0x0) {
        func_0x007bd21c(plVar3,ppuVar2[3]);
        ppuVar18 = (undefined1 **)ppuVar2[2];
        func_0x0040a5b0(ppuVar2);
        ppuVar2 = ppuVar18;
      }
      plVar9[2] = (long)&UNK_00dc8c20;
      puVar5 = puStack_20;
      while (puVar5 != (undefined4 *)0x0) {
        func_0x007bd21c(&puStack_30,*(undefined8 *)(puVar5 + 6));
        puVar20 = *(undefined4 **)(puVar5 + 4);
        func_0x0040a5b0(puVar5);
        puVar5 = puVar20;
      }
    }
    plVar9[2] = (long)&UNK_00dc8c68;
    plVar3 = plStack_50;
    while (plVar3 != (undefined8 *)0x0) {
      func_0x007bd21c(&plStack_60,plVar3[3]);
      puVar15 = (undefined8 *)plVar3[2];
      func_0x0040a5b0(plVar3);
      plVar3 = puVar15;
    }
    goto LAB_00945518;
  }
  if (iVar1 != 0x1f) {
    if (iVar1 != 0x20) {
      if (iVar1 != 0x21) {
        if (iVar1 != 0x22) {
          if (iVar1 != 0x23) goto LAB_009452c0;
          plVar9 = (long *)func_0x00409e60(0x68);
          lVar12 = *(long *)(param_2 + 0x10);
          puStack_78 = &uStack_88;
          *plVar9 = (long)&UNK_00dc8f38;
          plVar9[1] = 0x100000001;
          uStack_88 = (ulong)uStack_88._4_4_ << 0x20;
          plStack_80 = (undefined8 *)0x0;
          lStack_68 = 0;
          puStack_70 = puStack_78;
          if (lVar12 == 0) {
            uStack_58 = (ulong)uStack_58._4_4_ << 0x20;
LAB_0094683c:
            puStack_48 = &uStack_58;
            lStack_38 = 0;
            plStack_50 = (undefined8 *)0x0;
            puStack_18 = auStack_28;
            auStack_28[0] = 0;
            puStack_20 = (undefined4 *)0x0;
            lStack_8 = 0;
            puStack_40 = puStack_48;
            puStack_10 = puStack_18;
          }
          else {
            pplStack_d8 = (long **)&ppuStack_90;
            plStack_80 = (long *)func_0x00948118(&ppuStack_90,lVar12,puStack_78,&pplStack_d8);
            puVar15 = plStack_80;
            do {
              puStack_78 = puVar15;
              puVar16 = plStack_80;
              puVar15 = (undefined8 *)puStack_78[2];
            } while ((undefined8 *)puStack_78[2] != (undefined8 *)0x0);
            do {
              puStack_70 = puVar16;
              puVar16 = (undefined8 *)puStack_70[3];
            } while ((undefined8 *)puStack_70[3] != (undefined8 *)0x0);
            lStack_68 = *(long *)(param_2 + 0x28);
            puStack_48 = &uStack_58;
            uStack_58 = (ulong)uStack_58._4_4_ << 0x20;
            plStack_50 = (long *)0x0;
            lStack_38 = 0;
            if (plStack_80 == (undefined8 *)0x0) goto LAB_0094683c;
            pplStack_d0 = &plStack_60;
            puStack_40 = puStack_48;
            plStack_50 = (long *)func_0x00948118(&plStack_60,plStack_80,puStack_48,&pplStack_d0);
            puVar15 = plStack_50;
            do {
              puStack_48 = puVar15;
              puVar16 = plStack_50;
              puVar15 = (undefined8 *)puStack_48[2];
            } while ((undefined8 *)puStack_48[2] != (undefined8 *)0x0);
            do {
              puStack_40 = puVar16;
              puVar16 = (undefined8 *)puStack_40[3];
            } while ((undefined8 *)puStack_40[3] != (undefined8 *)0x0);
            puStack_18 = auStack_28;
            lStack_38 = lStack_68;
            auStack_28[0] = 0;
            puStack_20 = (undefined4 *)0x0;
            lStack_8 = 0;
            puStack_10 = puStack_18;
            if (plStack_50 != (undefined8 *)0x0) {
              ppuStack_c8 = &puStack_30;
              puStack_20 = (undefined4 *)
                           func_0x00948118(&puStack_30,plStack_50,puStack_18,&ppuStack_c8);
              puVar5 = puStack_20;
              do {
                puStack_18 = puVar5;
                puVar20 = puStack_20;
                puVar5 = *(undefined4 **)(puStack_18 + 4);
              } while (*(undefined4 **)(puStack_18 + 4) != (undefined4 *)0x0);
              do {
                puStack_10 = puVar20;
                puVar20 = *(undefined4 **)(puStack_10 + 6);
              } while (*(undefined4 **)(puStack_10 + 6) != (undefined4 *)0x0);
              lStack_8 = lStack_38;
            }
          }
          plVar3 = plVar9 + 4;
          plVar9[2] = (long)&UNK_00dc8b90;
          *(undefined4 *)(plVar9 + 4) = 0;
          plVar9[5] = 0;
          plVar9[6] = (long)plVar3;
          puStack_b0 = (ulong *)(plVar9 + 3);
          plVar9[7] = (long)plVar3;
          plVar9[8] = 0;
          *(undefined1 *)(plVar9 + 9) = 0;
          plVar9[0xb] = 0;
          plVar9[10] = 0;
          plVar9[0xc] = 0;
          uStack_b8 = 0;
          ppuStack_c0 = (undefined1 **)0x0;
          if (puStack_20 != (undefined4 *)0x0) {
            lVar10 = func_0x00947df0(puStack_b0,puStack_20,plVar3,&ppuStack_c0);
            puVar6 = puStack_b0;
            lVar12 = lVar10;
            do {
              lVar14 = lVar12;
              lVar12 = *(long *)(lVar14 + 0x10);
            } while (lVar12 != 0);
            plVar9[6] = lVar14;
            lVar12 = lVar10;
            do {
              lVar14 = lVar12;
              lVar12 = *(long *)(lVar14 + 0x18);
            } while (lVar12 != 0);
            plVar9[7] = lVar14;
            plVar9[8] = lStack_8;
            plVar9[5] = lVar10;
            ppuVar4 = (undefined8 **)ppuStack_c0;
            while (ppuVar4 != (undefined8 **)0x0) {
              func_0x007bd21c(puVar6,ppuVar4[3]);
              ppuVar19 = (undefined8 **)ppuVar4[2];
              func_0x0040a5b0(ppuVar4);
              ppuVar4 = ppuVar19;
            }
            plVar9[2] = (long)&UNK_00dc8c20;
            puVar5 = puStack_20;
            while (puVar5 != (undefined4 *)0x0) {
              func_0x007bd21c(&puStack_30,*(undefined8 *)(puVar5 + 6));
              puVar20 = *(undefined4 **)(puVar5 + 4);
              func_0x0040a5b0(puVar5);
              puVar5 = puVar20;
            }
          }
          plVar9[2] = (long)&UNK_00dc8c68;
          plVar3 = plStack_50;
          while (plVar3 != (undefined8 *)0x0) {
            func_0x007bd21c(&plStack_60,plVar3[3]);
            puVar15 = (undefined8 *)plVar3[2];
            func_0x0040a5b0(plVar3);
            plVar3 = puVar15;
          }
          plVar9[2] = (long)&UNK_00dc8b48;
          puVar15 = plStack_80;
          while (puVar15 != (undefined8 *)0x0) {
            func_0x007bd21c(&ppuStack_90,puVar15[3]);
            puVar16 = (undefined8 *)puVar15[2];
            func_0x0040a5b0(puVar15);
            puVar15 = puVar16;
          }
          goto LAB_00945284;
        }
        plVar9 = (long *)func_0x00409e60(0x68);
        lVar12 = *(long *)(param_2 + 0x10);
        puStack_78 = &uStack_88;
        *plVar9 = (long)&UNK_00dc8f00;
        plVar9[1] = 0x100000001;
        uStack_88 = (ulong)uStack_88._4_4_ << 0x20;
        plStack_80 = (undefined8 *)0x0;
        lStack_68 = 0;
        puStack_70 = puStack_78;
        if (lVar12 == 0) {
          uStack_58 = (ulong)uStack_58._4_4_ << 0x20;
LAB_00946808:
          puStack_48 = &uStack_58;
          lStack_38 = 0;
          plStack_50 = (undefined8 *)0x0;
          puStack_18 = auStack_28;
          auStack_28[0] = 0;
          puStack_20 = (undefined4 *)0x0;
          lStack_8 = 0;
          puStack_40 = puStack_48;
          puStack_10 = puStack_18;
        }
        else {
          pplStack_d8 = (long **)&ppuStack_90;
          plStack_80 = (long *)func_0x00948118(&ppuStack_90,lVar12,puStack_78,&pplStack_d8);
          puVar15 = plStack_80;
          do {
            puStack_78 = puVar15;
            puVar16 = plStack_80;
            puVar15 = (undefined8 *)puStack_78[2];
          } while ((undefined8 *)puStack_78[2] != (undefined8 *)0x0);
          do {
            puStack_70 = puVar16;
            puVar16 = (undefined8 *)puStack_70[3];
          } while ((undefined8 *)puStack_70[3] != (undefined8 *)0x0);
          lStack_68 = *(long *)(param_2 + 0x28);
          puStack_48 = &uStack_58;
          uStack_58 = (ulong)uStack_58._4_4_ << 0x20;
          plStack_50 = (long *)0x0;
          lStack_38 = 0;
          if (plStack_80 == (undefined8 *)0x0) goto LAB_00946808;
          pplStack_d0 = &plStack_60;
          puStack_40 = puStack_48;
          plStack_50 = (long *)func_0x00948118(&plStack_60,plStack_80,puStack_48,&pplStack_d0);
          puVar15 = plStack_50;
          do {
            puStack_48 = puVar15;
            puVar16 = plStack_50;
            puVar15 = (undefined8 *)puStack_48[2];
          } while ((undefined8 *)puStack_48[2] != (undefined8 *)0x0);
          do {
            puStack_40 = puVar16;
            puVar16 = (undefined8 *)puStack_40[3];
          } while ((undefined8 *)puStack_40[3] != (undefined8 *)0x0);
          puStack_18 = auStack_28;
          lStack_38 = lStack_68;
          auStack_28[0] = 0;
          puStack_20 = (undefined4 *)0x0;
          lStack_8 = 0;
          puStack_10 = puStack_18;
          if (plStack_50 != (undefined8 *)0x0) {
            ppuStack_c8 = &puStack_30;
            puStack_20 = (undefined4 *)
                         func_0x00948118(&puStack_30,plStack_50,puStack_18,&ppuStack_c8);
            puVar5 = puStack_20;
            do {
              puStack_18 = puVar5;
              puVar20 = puStack_20;
              puVar5 = *(undefined4 **)(puStack_18 + 4);
            } while (*(undefined4 **)(puStack_18 + 4) != (undefined4 *)0x0);
            do {
              puStack_10 = puVar20;
              puVar20 = *(undefined4 **)(puStack_10 + 6);
            } while (*(undefined4 **)(puStack_10 + 6) != (undefined4 *)0x0);
            lStack_8 = lStack_38;
          }
        }
        plVar3 = plVar9 + 4;
        plVar9[2] = (long)&UNK_00dc8b90;
        *(undefined4 *)(plVar9 + 4) = 0;
        plVar9[5] = 0;
        plVar9[6] = (long)plVar3;
        puStack_b0 = (ulong *)(plVar9 + 3);
        plVar9[7] = (long)plVar3;
        plVar9[8] = 0;
        *(undefined1 *)(plVar9 + 9) = 0;
        plVar9[0xb] = 0;
        plVar9[10] = 0;
        plVar9[0xc] = 0;
        uStack_b8 = 0;
        ppuStack_c0 = (undefined1 **)0x0;
        if (puStack_20 != (undefined4 *)0x0) {
          lVar10 = func_0x00947df0(puStack_b0,puStack_20,plVar3,&ppuStack_c0);
          puVar6 = puStack_b0;
          lVar12 = lVar10;
          do {
            lVar14 = lVar12;
            lVar12 = *(long *)(lVar14 + 0x10);
          } while (lVar12 != 0);
          plVar9[6] = lVar14;
          lVar12 = lVar10;
          do {
            lVar14 = lVar12;
            lVar12 = *(long *)(lVar14 + 0x18);
          } while (lVar12 != 0);
          plVar9[7] = lVar14;
          plVar9[8] = lStack_8;
          plVar9[5] = lVar10;
          ppuVar4 = (undefined8 **)ppuStack_c0;
          while (ppuVar4 != (undefined8 **)0x0) {
            func_0x007bd21c(puVar6,ppuVar4[3]);
            ppuVar19 = (undefined8 **)ppuVar4[2];
            func_0x0040a5b0(ppuVar4);
            ppuVar4 = ppuVar19;
          }
          plVar9[2] = (long)&UNK_00dc8c20;
          puVar5 = puStack_20;
          while (puVar5 != (undefined4 *)0x0) {
            func_0x007bd21c(&puStack_30,*(undefined8 *)(puVar5 + 6));
            puVar20 = *(undefined4 **)(puVar5 + 4);
            func_0x0040a5b0(puVar5);
            puVar5 = puVar20;
          }
        }
        plVar9[2] = (long)&UNK_00dc8c68;
        plVar3 = plStack_50;
        while (plVar3 != (undefined8 *)0x0) {
          func_0x007bd21c(&plStack_60,plVar3[3]);
          puVar15 = (undefined8 *)plVar3[2];
          func_0x0040a5b0(plVar3);
          plVar3 = puVar15;
        }
        plVar9[2] = (long)&UNK_00dc8cf8;
        puVar15 = plStack_80;
        while (puVar15 != (undefined8 *)0x0) {
          func_0x007bd21c(&ppuStack_90,puVar15[3]);
          puVar16 = (undefined8 *)puVar15[2];
          func_0x0040a5b0(puVar15);
          puVar15 = puVar16;
        }
        goto LAB_00945284;
      }
      plVar9 = (long *)func_0x00409e60(0x68);
      lVar12 = *(long *)(param_2 + 0x10);
      puStack_78 = &uStack_88;
      *plVar9 = (long)&UNK_00dc8ec8;
      plVar9[1] = 0x100000001;
      uStack_88 = (ulong)uStack_88._4_4_ << 0x20;
      plStack_80 = (undefined8 *)0x0;
      lStack_68 = 0;
      puStack_70 = puStack_78;
      if (lVar12 == 0) {
        uStack_58 = (ulong)uStack_58._4_4_ << 0x20;
LAB_009467d4:
        puStack_48 = &uStack_58;
        lStack_38 = 0;
        plStack_50 = (undefined8 *)0x0;
        puStack_18 = auStack_28;
        auStack_28[0] = 0;
        puStack_20 = (undefined4 *)0x0;
        lStack_8 = 0;
        puStack_40 = puStack_48;
        puStack_10 = puStack_18;
      }
      else {
        pplStack_d8 = (long **)&ppuStack_90;
        plStack_80 = (long *)func_0x00948118(&ppuStack_90,lVar12,&uStack_88,&pplStack_d8);
        puVar15 = plStack_80;
        do {
          puStack_78 = puVar15;
          puVar16 = plStack_80;
          puVar15 = (undefined8 *)puStack_78[2];
        } while ((undefined8 *)puStack_78[2] != (undefined8 *)0x0);
        do {
          puStack_70 = puVar16;
          puVar16 = (undefined8 *)puStack_70[3];
        } while ((undefined8 *)puStack_70[3] != (undefined8 *)0x0);
        lStack_68 = *(long *)(param_2 + 0x28);
        puStack_48 = &uStack_58;
        uStack_58 = (ulong)uStack_58._4_4_ << 0x20;
        plStack_50 = (long *)0x0;
        lStack_38 = 0;
        if (plStack_80 == (undefined8 *)0x0) goto LAB_009467d4;
        pplStack_d0 = &plStack_60;
        puStack_40 = puStack_48;
        plStack_50 = (long *)func_0x00948118(&plStack_60,plStack_80,puStack_48,&pplStack_d0);
        puVar15 = plStack_50;
        do {
          puStack_48 = puVar15;
          puVar16 = plStack_50;
          puVar15 = (undefined8 *)puStack_48[2];
        } while ((undefined8 *)puStack_48[2] != (undefined8 *)0x0);
        do {
          puStack_40 = puVar16;
          puVar16 = (undefined8 *)puStack_40[3];
        } while ((undefined8 *)puStack_40[3] != (undefined8 *)0x0);
        puStack_18 = auStack_28;
        lStack_38 = lStack_68;
        auStack_28[0] = 0;
        puStack_20 = (undefined4 *)0x0;
        lStack_8 = 0;
        puStack_10 = puStack_18;
        if (plStack_50 != (undefined8 *)0x0) {
          ppuStack_c8 = &puStack_30;
          puStack_20 = (undefined4 *)func_0x00948118(&puStack_30,plStack_50,puStack_18,&ppuStack_c8)
          ;
          puVar5 = puStack_20;
          do {
            puStack_18 = puVar5;
            puVar20 = puStack_20;
            puVar5 = *(undefined4 **)(puStack_18 + 4);
          } while (*(undefined4 **)(puStack_18 + 4) != (undefined4 *)0x0);
          do {
            puStack_10 = puVar20;
            puVar20 = *(undefined4 **)(puStack_10 + 6);
          } while (*(undefined4 **)(puStack_10 + 6) != (undefined4 *)0x0);
          lStack_8 = lStack_38;
        }
      }
      plVar3 = plVar9 + 4;
      plVar9[2] = (long)&UNK_00dc8b90;
      *(undefined4 *)(plVar9 + 4) = 0;
      plVar9[5] = 0;
      plVar9[6] = (long)plVar3;
      puStack_b0 = (ulong *)(plVar9 + 3);
      plVar9[7] = (long)plVar3;
      plVar9[8] = 0;
      *(undefined1 *)(plVar9 + 9) = 0;
      plVar9[0xb] = 0;
      plVar9[10] = 0;
      plVar9[0xc] = 0;
      uStack_b8 = 0;
      ppuStack_c0 = (undefined1 **)0x0;
      if (puStack_20 != (undefined4 *)0x0) {
        lVar10 = func_0x00947df0(puStack_b0,puStack_20,plVar3,&ppuStack_c0);
        puVar6 = puStack_b0;
        lVar12 = lVar10;
        do {
          lVar14 = lVar12;
          lVar12 = *(long *)(lVar14 + 0x10);
        } while (lVar12 != 0);
        plVar9[6] = lVar14;
        lVar12 = lVar10;
        do {
          lVar14 = lVar12;
          lVar12 = *(long *)(lVar14 + 0x18);
        } while (lVar12 != 0);
        plVar9[7] = lVar14;
        plVar9[8] = lStack_8;
        plVar9[5] = lVar10;
        ppuVar4 = (undefined8 **)ppuStack_c0;
        while (ppuVar4 != (undefined8 **)0x0) {
          func_0x007bd21c(puVar6,ppuVar4[3]);
          ppuVar19 = (undefined8 **)ppuVar4[2];
          func_0x0040a5b0(ppuVar4);
          ppuVar4 = ppuVar19;
        }
        plVar9[2] = (long)&UNK_00dc8c20;
        puVar5 = puStack_20;
        while (puVar5 != (undefined4 *)0x0) {
          func_0x007bd21c(&puStack_30,*(undefined8 *)(puVar5 + 6));
          puVar20 = *(undefined4 **)(puVar5 + 4);
          func_0x0040a5b0(puVar5);
          puVar5 = puVar20;
        }
      }
      plVar9[2] = (long)&UNK_00dc8c68;
      plVar3 = plStack_50;
      while (plVar3 != (undefined8 *)0x0) {
        func_0x007bd21c(&plStack_60,plVar3[3]);
        puVar15 = (undefined8 *)plVar3[2];
        func_0x0040a5b0(plVar3);
        plVar3 = puVar15;
      }
      plVar9[2] = (long)&UNK_00dc8b00;
      puVar15 = plStack_80;
      while (puVar15 != (undefined8 *)0x0) {
        func_0x007bd21c(&ppuStack_90,puVar15[3]);
        puVar16 = (undefined8 *)puVar15[2];
        func_0x0040a5b0(puVar15);
        puVar15 = puVar16;
      }
      goto LAB_00945284;
    }
    plVar9 = (long *)func_0x00409e60(0x68);
    puStack_a8 = &uStack_b8;
    lVar12 = *(long *)(param_2 + 0x10);
    *plVar9 = (long)&UNK_00dc8e90;
    plVar9[1] = 0x100000001;
    uStack_b8 = uStack_b8 & 0xffffffff00000000;
    puStack_b0 = (ulong *)0x0;
    lStack_98 = 0;
    puStack_a0 = puStack_a8;
    if (lVar12 == 0) {
      uStack_88 = (ulong)uStack_88._4_4_ << 0x20;
LAB_00946790:
      puStack_78 = &uStack_88;
      lStack_68 = 0;
      plStack_80 = (undefined8 *)0x0;
      uStack_58 = (ulong)uStack_58._4_4_ << 0x20;
      puStack_70 = puStack_78;
LAB_009467a4:
      puStack_48 = &uStack_58;
      lStack_38 = 0;
      plStack_50 = (undefined8 *)0x0;
      puStack_18 = auStack_28;
      auStack_28[0] = 0;
      puStack_20 = (undefined4 *)0x0;
      lStack_8 = 0;
      puStack_40 = puStack_48;
      puStack_10 = puStack_18;
    }
    else {
      puStack_b0 = (ulong *)func_0x00948118();
      puVar6 = puStack_b0;
      do {
        puStack_a8 = puVar6;
        puVar17 = puStack_b0;
        puVar6 = (ulong *)puStack_a8[2];
      } while ((ulong *)puStack_a8[2] != (ulong *)0x0);
      do {
        puStack_a0 = puVar17;
        puVar17 = (ulong *)puStack_a0[3];
      } while ((ulong *)puStack_a0[3] != (ulong *)0x0);
      lStack_98 = *(long *)(param_2 + 0x28);
      puStack_78 = &uStack_88;
      uStack_88 = (ulong)uStack_88._4_4_ << 0x20;
      plStack_80 = (long *)0x0;
      lStack_68 = 0;
      if (puStack_b0 == (ulong *)0x0) goto LAB_00946790;
      pplStack_d8 = (long **)&ppuStack_90;
      puStack_70 = puStack_78;
      plStack_80 = (long *)func_0x00948118(&ppuStack_90,puStack_b0,puStack_78,&pplStack_d8);
      puVar15 = plStack_80;
      do {
        puStack_78 = puVar15;
        puVar16 = plStack_80;
        puVar15 = (undefined8 *)puStack_78[2];
      } while ((undefined8 *)puStack_78[2] != (undefined8 *)0x0);
      do {
        puStack_70 = puVar16;
        puVar16 = (undefined8 *)puStack_70[3];
      } while ((undefined8 *)puStack_70[3] != (undefined8 *)0x0);
      puStack_48 = &uStack_58;
      lStack_68 = lStack_98;
      uStack_58 = (ulong)uStack_58._4_4_ << 0x20;
      plStack_50 = (long *)0x0;
      lStack_38 = 0;
      if (plStack_80 == (undefined8 *)0x0) goto LAB_009467a4;
      pplStack_d0 = &plStack_60;
      puStack_40 = puStack_48;
      plStack_50 = (long *)func_0x00948118(&plStack_60,plStack_80,puStack_48,&pplStack_d0);
      puVar15 = plStack_50;
      do {
        puStack_48 = puVar15;
        puVar16 = plStack_50;
        puVar15 = (undefined8 *)puStack_48[2];
      } while ((undefined8 *)puStack_48[2] != (undefined8 *)0x0);
      do {
        puStack_40 = puVar16;
        puVar16 = (undefined8 *)puStack_40[3];
      } while ((undefined8 *)puStack_40[3] != (undefined8 *)0x0);
      puStack_18 = auStack_28;
      lStack_38 = lStack_68;
      auStack_28[0] = 0;
      puStack_20 = (undefined4 *)0x0;
      lStack_8 = 0;
      puStack_10 = puStack_18;
      if (plStack_50 != (undefined8 *)0x0) {
        ppuStack_c8 = &puStack_30;
        puStack_20 = (undefined4 *)func_0x00948118(&puStack_30,plStack_50,puStack_18,&ppuStack_c8);
        puVar5 = puStack_20;
        do {
          puStack_18 = puVar5;
          puVar20 = puStack_20;
          puVar5 = *(undefined4 **)(puStack_18 + 4);
        } while (*(undefined4 **)(puStack_18 + 4) != (undefined4 *)0x0);
        do {
          puStack_10 = puVar20;
          puVar20 = *(undefined4 **)(puStack_10 + 6);
        } while (*(undefined4 **)(puStack_10 + 6) != (undefined4 *)0x0);
        lStack_8 = lStack_38;
      }
    }
    plVar9[2] = (long)&UNK_00dc8b90;
    *(undefined4 *)(plVar9 + 4) = 0;
    plVar9[5] = 0;
    plVar9[6] = (long)(plVar9 + 4);
    plVar9[7] = (long)(plVar9 + 4);
    plVar9[8] = 0;
    *(undefined1 *)(plVar9 + 9) = 0;
    plVar9[10] = 0;
    plVar9[0xb] = 0;
    plVar9[0xc] = 0;
    func_0x00947ff8(plVar9 + 3,&puStack_30);
    plVar9[2] = (long)&UNK_00dc8c20;
    puVar5 = puStack_20;
    while (puVar5 != (undefined4 *)0x0) {
      func_0x007bd21c(&puStack_30,*(undefined8 *)(puVar5 + 6));
      puVar20 = *(undefined4 **)(puVar5 + 4);
      func_0x0040a5b0(puVar5);
      puVar5 = puVar20;
    }
    plVar9[2] = (long)&UNK_00dc8c68;
    puVar15 = plStack_50;
    while (puVar15 != (undefined8 *)0x0) {
      func_0x007bd21c(&plStack_60,puVar15[3]);
      puVar16 = (undefined8 *)puVar15[2];
      func_0x0040a5b0(puVar15);
      puVar15 = puVar16;
    }
    plVar9[2] = (long)&UNK_00dc8cb0;
    puVar15 = plStack_80;
    while (puVar15 != (undefined8 *)0x0) {
      func_0x007bd21c(&ppuStack_90,puVar15[3]);
      puVar16 = (undefined8 *)puVar15[2];
      func_0x0040a5b0(puVar15);
      puVar15 = puVar16;
    }
    plVar9[2] = (long)&UNK_00dc8ab8;
    puVar6 = puStack_b0;
    while (puVar6 != (ulong *)0x0) {
      func_0x007bd21c(&ppuStack_c0,puVar6[3]);
      puVar17 = (ulong *)puVar6[2];
      func_0x0040a5b0(puVar6);
      puVar6 = puVar17;
    }
    goto LAB_00945284;
  }
  plVar9 = (long *)func_0x00409e60(0x68);
  lVar12 = *(long *)(param_2 + 0x10);
  puStack_78 = &uStack_88;
  *plVar9 = (long)&UNK_00dc8e58;
  plVar9[1] = 0x100000001;
  uStack_88 = (ulong)uStack_88._4_4_ << 0x20;
  plStack_80 = (undefined8 *)0x0;
  lStack_68 = 0;
  puStack_70 = puStack_78;
  if (lVar12 == 0) {
    uStack_58 = (ulong)uStack_58._4_4_ << 0x20;
LAB_00946760:
    puStack_48 = &uStack_58;
    lStack_38 = 0;
    plStack_50 = (undefined8 *)0x0;
    puStack_18 = auStack_28;
    auStack_28[0] = 0;
    puStack_20 = (undefined4 *)0x0;
    lStack_8 = 0;
    puStack_40 = puStack_48;
    puStack_10 = puStack_18;
  }
  else {
    pplStack_d0 = (long **)&ppuStack_90;
    plStack_80 = (long *)func_0x00948118(&ppuStack_90,lVar12,puStack_78,&pplStack_d0);
    puVar15 = plStack_80;
    do {
      puStack_78 = puVar15;
      puVar16 = plStack_80;
      puVar15 = (undefined8 *)puStack_78[2];
    } while ((undefined8 *)puStack_78[2] != (undefined8 *)0x0);
    do {
      puStack_70 = puVar16;
      puVar16 = (undefined8 *)puStack_70[3];
    } while ((undefined8 *)puStack_70[3] != (undefined8 *)0x0);
    lStack_68 = *(long *)(param_2 + 0x28);
    puStack_48 = &uStack_58;
    uStack_58 = (ulong)uStack_58._4_4_ << 0x20;
    plStack_50 = (long *)0x0;
    lStack_38 = 0;
    if (plStack_80 == (undefined8 *)0x0) goto LAB_00946760;
    ppuStack_c8 = &plStack_60;
    puStack_40 = puStack_48;
    plStack_50 = (long *)func_0x00948118(&plStack_60,plStack_80,puStack_48,&ppuStack_c8);
    puVar15 = plStack_50;
    do {
      puStack_48 = puVar15;
      puVar16 = plStack_50;
      puVar15 = (undefined8 *)puStack_48[2];
    } while ((undefined8 *)puStack_48[2] != (undefined8 *)0x0);
    do {
      puStack_40 = puVar16;
      puVar16 = (undefined8 *)puStack_40[3];
    } while ((undefined8 *)puStack_40[3] != (undefined8 *)0x0);
    puStack_18 = auStack_28;
    lStack_38 = lStack_68;
    auStack_28[0] = 0;
    puStack_20 = (undefined4 *)0x0;
    lStack_8 = 0;
    puStack_10 = puStack_18;
    if (plStack_50 != (undefined8 *)0x0) {
      ppuStack_c0 = (undefined1 **)&puStack_30;
      puStack_20 = (undefined4 *)func_0x00948118(&puStack_30,plStack_50,puStack_18,&ppuStack_c0);
      puVar5 = puStack_20;
      do {
        puStack_18 = puVar5;
        puVar20 = puStack_20;
        puVar5 = *(undefined4 **)(puStack_18 + 4);
      } while (*(undefined4 **)(puStack_18 + 4) != (undefined4 *)0x0);
      do {
        puStack_10 = puVar20;
        puVar20 = *(undefined4 **)(puStack_10 + 6);
      } while (*(undefined4 **)(puStack_10 + 6) != (undefined4 *)0x0);
      lStack_8 = lStack_38;
    }
  }
  plVar9[2] = (long)&UNK_00dc8b90;
  *(undefined4 *)(plVar9 + 4) = 0;
  plVar9[5] = 0;
  plVar9[6] = (long)(plVar9 + 4);
  plVar9[7] = (long)(plVar9 + 4);
  plVar9[8] = 0;
  *(undefined1 *)(plVar9 + 9) = 0;
  plVar9[10] = 0;
  plVar9[0xb] = 0;
  plVar9[0xc] = 0;
  func_0x00947ff8(plVar9 + 3,&puStack_30);
  plVar9[2] = (long)&UNK_00dc8c20;
  puVar5 = puStack_20;
  while (puVar5 != (undefined4 *)0x0) {
    func_0x007bd21c(&puStack_30,*(undefined8 *)(puVar5 + 6));
    puVar20 = *(undefined4 **)(puVar5 + 4);
    func_0x0040a5b0(puVar5);
    puVar5 = puVar20;
  }
  plVar9[2] = (long)&UNK_00dc8c68;
  puVar15 = plStack_50;
  while (puVar15 != (undefined8 *)0x0) {
    func_0x007bd21c(&plStack_60,puVar15[3]);
    puVar16 = (undefined8 *)puVar15[2];
    func_0x0040a5b0(puVar15);
    puVar15 = puVar16;
  }
  plVar9[2] = (long)&UNK_00dc8cb0;
  puVar15 = plStack_80;
  while (puVar15 != (undefined8 *)0x0) {
    func_0x007bd21c(&ppuStack_90,puVar15[3]);
    puVar16 = (undefined8 *)puVar15[2];
    func_0x0040a5b0(puVar15);
    puVar15 = puVar16;
  }
LAB_00945284:
  uVar11 = (**(code **)(*plVar9 + 0x20))(plVar9,&UNK_00c18550);
  *param_1 = uVar11;
  param_1[1] = plVar9;
  return param_1;
}

