// INPUT SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
// STATIC PSEUDOCODE; recovered types/ABI and flow across tail branches require instruction verification.
// Linked VA 00960478

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void NativePreviewRawSourceConfigure(long param_1,undefined4 param_2,undefined8 param_3)

{
  int *piVar1;
  char cVar2;
  bool bVar3;
  long lVar4;
  uint uVar5;
  int iVar6;
  long *plVar7;
  long lVar8;
  undefined8 uVar9;
  long lVar10;
  long *plVar11;
  long *plVar12;
  long *plStack_10;
  long *plStack_8;
  
  func_0x00944e88(&plStack_10,param_3);
  plVar12 = plStack_8;
  plVar7 = plStack_10;
  plVar11 = *(long **)(param_1 + 0x1b0);
  plStack_10 = (long *)0x0;
  plStack_8 = (long *)0x0;
  *(long **)(param_1 + 0x1b0) = plVar12;
  *(long **)(param_1 + 0x1a8) = plVar7;
  lVar4 = _UNK_00dcb4f0;
  if (plVar11 != (long *)0x0) {
    if (_UNK_00dcb4f0 == 0) {
      iVar6 = (int)plVar11[1];
      *(int *)(plVar11 + 1) = iVar6 + -1;
    }
    else {
      plVar7 = plVar11 + 1;
      do {
        iVar6 = (int)*plVar7;
        cVar2 = '\x01';
        bVar3 = (bool)ExclusiveMonitorPass(plVar7,0x10);
        if (bVar3) {
          *(int *)plVar7 = iVar6 + -1;
          cVar2 = ExclusiveMonitorsStatus();
        }
      } while (cVar2 != '\0');
    }
    if (iVar6 == 1) {
      (**(code **)(*plVar11 + 0x10))(plVar11);
      if (lVar4 == 0) {
        iVar6 = *(int *)((long)plVar11 + 0xc);
        *(int *)((long)plVar11 + 0xc) = iVar6 + -1;
      }
      else {
        piVar1 = (int *)((long)plVar11 + 0xc);
        do {
          iVar6 = *piVar1;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(piVar1,0x10);
          if (bVar3) {
            *piVar1 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 == 1) {
        (**(code **)(*plVar11 + 0x18))(plVar11);
      }
    }
    plVar7 = plStack_8;
    if (plStack_8 != (long *)0x0) {
      if (lVar4 == 0) {
        iVar6 = (int)plStack_8[1];
        *(int *)(plStack_8 + 1) = iVar6 + -1;
      }
      else {
        plVar12 = plStack_8 + 1;
        do {
          iVar6 = (int)*plVar12;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(plVar12,0x10);
          if (bVar3) {
            *(int *)plVar12 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 == 1) {
        (**(code **)(*plStack_8 + 0x10))(plStack_8);
        if (lVar4 == 0) {
          iVar6 = *(int *)((long)plVar7 + 0xc);
          *(int *)((long)plVar7 + 0xc) = iVar6 + -1;
        }
        else {
          piVar1 = (int *)((long)plVar7 + 0xc);
          do {
            iVar6 = *piVar1;
            cVar2 = '\x01';
            bVar3 = (bool)ExclusiveMonitorPass(piVar1,0x10);
            if (bVar3) {
              *piVar1 = iVar6 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar6 == 1) {
          (**(code **)(*plVar7 + 0x18))(plVar7);
          plVar7 = *(long **)(param_1 + 0x1a8);
          goto LAB_00960510;
        }
      }
    }
    plVar7 = *(long **)(param_1 + 0x1a8);
  }
LAB_00960510:
  uVar5 = (**(code **)(*plVar7 + 0x30))(plVar7);
  lVar4 = *(long *)(param_1 + 0x20);
  lVar10 = param_1 + 0x18;
  if (*(long *)(param_1 + 0x20) != 0) {
    do {
      while (lVar8 = lVar4, uVar5 <= *(uint *)(lVar8 + 0x20)) {
        lVar4 = *(long *)(lVar8 + 0x10);
        lVar10 = lVar8;
        if (*(long *)(lVar8 + 0x10) == 0) goto LAB_00960548;
      }
      lVar4 = *(long *)(lVar8 + 0x18);
    } while (*(long *)(lVar8 + 0x18) != 0);
LAB_00960548:
    if ((param_1 + 0x18 != lVar10) && (*(uint *)(lVar10 + 0x20) <= uVar5)) goto LAB_0096055c;
  }
  func_0x0074654c(4,&UNK_00dcb598,0x85,&UNK_00dcb578);
LAB_0096055c:
  uVar9 = *(undefined8 *)(param_1 + 0x1a8);
  plVar7 = (long *)func_0x00409e60(0xb8);
  plVar7[1] = 0x100000001;
  *plVar7 = (long)&UNK_00dcb428;
  func_0x0093e0e0(plVar7 + 2,uVar9);
  uVar9 = (**(code **)(*plVar7 + 0x20))(plVar7,&UNK_00c18550);
  plVar12 = *(long **)(param_1 + 0x1c8);
  *(undefined8 *)(param_1 + 0x1c0) = uVar9;
  *(long **)(param_1 + 0x1c8) = plVar7;
  lVar4 = _UNK_00dcb4f0;
  if (plVar12 != (long *)0x0) {
    if (_UNK_00dcb4f0 == 0) {
      iVar6 = (int)plVar12[1];
      *(int *)(plVar12 + 1) = iVar6 + -1;
    }
    else {
      plVar7 = plVar12 + 1;
      do {
        iVar6 = (int)*plVar7;
        cVar2 = '\x01';
        bVar3 = (bool)ExclusiveMonitorPass(plVar7,0x10);
        if (bVar3) {
          *(int *)plVar7 = iVar6 + -1;
          cVar2 = ExclusiveMonitorsStatus();
        }
      } while (cVar2 != '\0');
    }
    if (iVar6 == 1) {
      (**(code **)(*plVar12 + 0x10))(plVar12);
      if (lVar4 == 0) {
        iVar6 = *(int *)((long)plVar12 + 0xc);
        *(int *)((long)plVar12 + 0xc) = iVar6 + -1;
      }
      else {
        piVar1 = (int *)((long)plVar12 + 0xc);
        do {
          iVar6 = *piVar1;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(piVar1,0x10);
          if (bVar3) {
            *piVar1 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 == 1) {
        (**(code **)(*plVar12 + 0x18))(plVar12);
      }
    }
  }
  *(undefined4 *)(param_1 + 0x1b8) = param_2;
  return;
}

