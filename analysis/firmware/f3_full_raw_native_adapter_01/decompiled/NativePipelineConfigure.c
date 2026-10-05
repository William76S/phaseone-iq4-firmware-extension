// INPUT SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
// STATIC PSEUDOCODE; recovered types/ABI and flow across tail branches require instruction verification.
// Linked VA 00916fa8

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void NativePipelineConfigure(undefined8 *param_1,float *param_2,undefined8 param_3)

{
  int *piVar1;
  long *plVar2;
  long lVar3;
  undefined8 *puVar4;
  float fVar5;
  float fVar6;
  float fVar7;
  char cVar8;
  bool bVar9;
  int iVar10;
  int iVar11;
  long *plVar12;
  undefined4 *puVar13;
  undefined8 *puVar14;
  ulong uVar15;
  long lVar16;
  int iVar17;
  ulong uVar18;
  undefined4 *puVar19;
  undefined4 *puVar20;
  long lVar21;
  long lVar22;
  long *plVar23;
  float fVar24;
  undefined8 uVar25;
  undefined8 uVar26;
  float fVar27;
  undefined1 auVar28 [16];
  int iStack_14;
  undefined8 uStack_10;
  long *plStack_8;
  
  puVar14 = param_1 + 1;
  *param_1 = &UNK_00dc5f58;
  param_1[1] = 0;
  param_1[2] = 0;
  param_1[3] = 0;
  param_1[4] = 0;
  param_1[5] = 0;
  param_1[6] = 0;
  param_1[7] = 0;
  param_1[8] = 0;
  param_1[9] = 0;
  param_1[10] = 0;
  param_1[0xb] = 0;
  param_1[0xc] = 0;
  param_1[0xd] = 0;
  param_1[0xe] = 0;
  iVar10 = func_0x009043a0(param_3);
  if (iVar10 == 0xd) {
    if ((double)*param_2 <= _UNK_00dc6348) {
      plVar12 = (long *)func_0x00409e60(0x38);
      plVar12[1] = 0x100000001;
      *plVar12 = (long)&UNK_00dc5fe8;
      func_0x0096c450(plVar12 + 2);
      uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
      puVar4 = (undefined8 *)param_1[2];
      if (puVar4 == (undefined8 *)param_1[3]) {
        plStack_8 = plVar12;
        func_0x009195f0(puVar14,puVar4,&uStack_10);
      }
      else {
        *puVar4 = uStack_10;
        puVar4[1] = 0;
        plStack_8 = (long *)0x0;
        puVar4[1] = plVar12;
        param_1[2] = puVar4 + 2;
        uStack_10 = 0;
      }
      plVar12 = plStack_8;
      lVar22 = _UNK_00dc6340;
      if (plStack_8 != (long *)0x0) {
        if (_UNK_00dc6340 == 0) {
          iVar10 = (int)plStack_8[1];
          *(int *)(plStack_8 + 1) = iVar10 + -1;
        }
        else {
          plVar23 = plStack_8 + 1;
          do {
            iVar10 = (int)*plVar23;
            cVar8 = '\x01';
            bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
            if (bVar9) {
              *(int *)plVar23 = iVar10 + -1;
              cVar8 = ExclusiveMonitorsStatus();
            }
          } while (cVar8 != '\0');
        }
        if (iVar10 == 1) {
          (**(code **)(*plStack_8 + 0x10))(plStack_8);
          if (lVar22 == 0) goto LAB_00918638;
          piVar1 = (int *)((long)plVar12 + 0xc);
          do {
            iVar10 = *piVar1;
            cVar8 = '\x01';
            bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
            if (bVar9) {
              *piVar1 = iVar10 + -1;
              cVar8 = ExclusiveMonitorsStatus();
            }
          } while (cVar8 != '\0');
          goto LAB_00917d44;
        }
      }
    }
    else {
      plVar12 = (long *)func_0x00409e60(0x38);
      plVar12[1] = 0x100000001;
      *plVar12 = (long)&UNK_00dc5f78;
      func_0x0091c478(plVar12 + 2);
      uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
      puVar4 = (undefined8 *)param_1[2];
      if (puVar4 == (undefined8 *)param_1[3]) {
        plStack_8 = plVar12;
        func_0x009195f0(puVar14,puVar4,&uStack_10);
      }
      else {
        *puVar4 = uStack_10;
        puVar4[1] = 0;
        plStack_8 = (long *)0x0;
        puVar4[1] = plVar12;
        param_1[2] = puVar4 + 2;
        uStack_10 = 0;
      }
      plVar12 = plStack_8;
      lVar22 = _UNK_00dc6340;
      if (plStack_8 != (long *)0x0) {
        if (_UNK_00dc6340 == 0) {
          iVar10 = (int)plStack_8[1];
          *(int *)(plStack_8 + 1) = iVar10 + -1;
        }
        else {
          plVar23 = plStack_8 + 1;
          do {
            iVar10 = (int)*plVar23;
            cVar8 = '\x01';
            bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
            if (bVar9) {
              *(int *)plVar23 = iVar10 + -1;
              cVar8 = ExclusiveMonitorsStatus();
            }
          } while (cVar8 != '\0');
        }
        if (iVar10 == 1) {
          (**(code **)(*plStack_8 + 0x10))(plStack_8);
          if (lVar22 == 0) {
            iVar10 = *(int *)((long)plVar12 + 0xc);
            *(int *)((long)plVar12 + 0xc) = iVar10 + -1;
          }
          else {
            piVar1 = (int *)((long)plVar12 + 0xc);
            do {
              iVar10 = *piVar1;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
              if (bVar9) {
                *piVar1 = iVar10 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
          if (iVar10 == 1) {
            (**(code **)(*plVar12 + 0x18))(plVar12);
          }
        }
      }
      plVar12 = (long *)func_0x00409e60(0x38);
      plVar12[1] = 0x100000001;
      *plVar12 = (long)&UNK_00dc5fb0;
      func_0x0096a8d0(plVar12 + 2);
      uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
      puVar4 = (undefined8 *)param_1[2];
      if (puVar4 == (undefined8 *)param_1[3]) {
        plStack_8 = plVar12;
        func_0x009195f0(puVar14,puVar4,&uStack_10);
      }
      else {
        *puVar4 = uStack_10;
        puVar4[1] = 0;
        plStack_8 = (long *)0x0;
        puVar4[1] = plVar12;
        param_1[2] = puVar4 + 2;
        uStack_10 = 0;
      }
      plVar12 = plStack_8;
      lVar22 = _UNK_00dc6340;
      if (plStack_8 != (long *)0x0) {
        if (_UNK_00dc6340 == 0) {
          iVar10 = (int)plStack_8[1];
          *(int *)(plStack_8 + 1) = iVar10 + -1;
        }
        else {
          plVar23 = plStack_8 + 1;
          do {
            iVar10 = (int)*plVar23;
            cVar8 = '\x01';
            bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
            if (bVar9) {
              *(int *)plVar23 = iVar10 + -1;
              cVar8 = ExclusiveMonitorsStatus();
            }
          } while (cVar8 != '\0');
        }
        if (iVar10 == 1) {
          (**(code **)(*plStack_8 + 0x10))(plStack_8);
          if (lVar22 == 0) goto LAB_00918638;
          piVar1 = (int *)((long)plVar12 + 0xc);
          do {
            iVar10 = *piVar1;
            cVar8 = '\x01';
            bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
            if (bVar9) {
              *piVar1 = iVar10 + -1;
              cVar8 = ExclusiveMonitorsStatus();
            }
          } while (cVar8 != '\0');
LAB_00917d44:
          if (iVar10 == 1) {
            (**(code **)(*plVar12 + 0x18))(plVar12);
          }
        }
      }
    }
  }
  else {
    if (0.5 < *param_2) {
      plVar12 = (long *)func_0x00409e60(0x38);
      plVar12[1] = 0x100000001;
      *plVar12 = (long)&UNK_00dc60c8;
      func_0x0091c448(plVar12 + 2);
      uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
      puVar4 = (undefined8 *)param_1[2];
      if (puVar4 == (undefined8 *)param_1[3]) {
        plStack_8 = plVar12;
        func_0x009195f0(puVar14,puVar4,&uStack_10);
      }
      else {
        *puVar4 = uStack_10;
        puVar4[1] = 0;
        plStack_8 = (long *)0x0;
        puVar4[1] = plVar12;
        param_1[2] = puVar4 + 2;
        uStack_10 = 0;
      }
      plVar12 = plStack_8;
      lVar22 = _UNK_00dc6340;
      if (plStack_8 != (long *)0x0) {
        if (_UNK_00dc6340 == 0) {
          iVar10 = (int)plStack_8[1];
          *(int *)(plStack_8 + 1) = iVar10 + -1;
        }
        else {
          plVar23 = plStack_8 + 1;
          do {
            iVar10 = (int)*plVar23;
            cVar8 = '\x01';
            bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
            if (bVar9) {
              *(int *)plVar23 = iVar10 + -1;
              cVar8 = ExclusiveMonitorsStatus();
            }
          } while (cVar8 != '\0');
        }
        if (iVar10 == 1) {
          (**(code **)(*plStack_8 + 0x10))(plStack_8);
          if (lVar22 == 0) {
            iVar10 = *(int *)((long)plVar12 + 0xc);
            *(int *)((long)plVar12 + 0xc) = iVar10 + -1;
          }
          else {
            piVar1 = (int *)((long)plVar12 + 0xc);
            do {
              iVar10 = *piVar1;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
              if (bVar9) {
                *piVar1 = iVar10 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
          if (iVar10 == 1) {
            (**(code **)(*plVar12 + 0x18))(plVar12);
          }
        }
      }
      if (0 < (int)param_2[0x10]) {
        plVar12 = (long *)func_0x00409e60(0x38);
        plVar12[1] = 0x100000001;
        *plVar12 = (long)&UNK_00dc6100;
        func_0x0091cba8(plVar12 + 2);
        uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
        puVar4 = (undefined8 *)param_1[2];
        if (puVar4 == (undefined8 *)param_1[3]) {
          plStack_8 = plVar12;
          func_0x009195f0(puVar14,puVar4,&uStack_10);
        }
        else {
          *puVar4 = uStack_10;
          puVar4[1] = 0;
          plStack_8 = (long *)0x0;
          puVar4[1] = plVar12;
          param_1[2] = puVar4 + 2;
          uStack_10 = 0;
        }
        plVar12 = plStack_8;
        lVar22 = _UNK_00dc6340;
        if (plStack_8 != (long *)0x0) {
          if (_UNK_00dc6340 == 0) {
            iVar10 = (int)plStack_8[1];
            *(int *)(plStack_8 + 1) = iVar10 + -1;
          }
          else {
            plVar23 = plStack_8 + 1;
            do {
              iVar10 = (int)*plVar23;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
              if (bVar9) {
                *(int *)plVar23 = iVar10 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
          if (iVar10 == 1) {
            (**(code **)(*plStack_8 + 0x10))(plStack_8);
            if (lVar22 == 0) {
              iVar10 = *(int *)((long)plVar12 + 0xc);
              *(int *)((long)plVar12 + 0xc) = iVar10 + -1;
            }
            else {
              piVar1 = (int *)((long)plVar12 + 0xc);
              do {
                iVar10 = *piVar1;
                cVar8 = '\x01';
                bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                if (bVar9) {
                  *piVar1 = iVar10 + -1;
                  cVar8 = ExclusiveMonitorsStatus();
                }
              } while (cVar8 != '\0');
            }
            if (iVar10 == 1) {
              (**(code **)(*plVar12 + 0x18))(plVar12);
            }
          }
        }
      }
      plVar12 = (long *)func_0x00409e60(0x38);
      plVar12[1] = 0x100000001;
      *plVar12 = (long)&UNK_00dc6138;
      func_0x009382d0(plVar12 + 2);
      uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
      puVar4 = (undefined8 *)param_1[2];
      if (puVar4 == (undefined8 *)param_1[3]) {
        plStack_8 = plVar12;
        func_0x009195f0(puVar14,puVar4,&uStack_10);
      }
      else {
        *puVar4 = uStack_10;
        puVar4[1] = 0;
        plStack_8 = (long *)0x0;
        puVar4[1] = plVar12;
        param_1[2] = puVar4 + 2;
        uStack_10 = 0;
      }
      plVar12 = plStack_8;
      lVar22 = _UNK_00dc6340;
      if (plStack_8 != (long *)0x0) {
        if (_UNK_00dc6340 == 0) {
          iVar10 = (int)plStack_8[1];
          *(int *)(plStack_8 + 1) = iVar10 + -1;
        }
        else {
          plVar23 = plStack_8 + 1;
          do {
            iVar10 = (int)*plVar23;
            cVar8 = '\x01';
            bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
            if (bVar9) {
              *(int *)plVar23 = iVar10 + -1;
              cVar8 = ExclusiveMonitorsStatus();
            }
          } while (cVar8 != '\0');
        }
        if (iVar10 == 1) {
          (**(code **)(*plStack_8 + 0x10))(plStack_8);
          if (lVar22 == 0) {
            iVar10 = *(int *)((long)plVar12 + 0xc);
            *(int *)((long)plVar12 + 0xc) = iVar10 + -1;
          }
          else {
            piVar1 = (int *)((long)plVar12 + 0xc);
            do {
              iVar10 = *piVar1;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
              if (bVar9) {
                *piVar1 = iVar10 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
          if (iVar10 == 1) {
            (**(code **)(*plVar12 + 0x18))(plVar12);
          }
        }
      }
      if (*(char *)(param_2 + 0x11) == '\0') {
        plVar12 = (long *)func_0x00409e60(0x48);
        plVar12[1] = 0x100000001;
        *plVar12 = (long)&UNK_00dc61a8;
        func_0x00923d68(plVar12 + 2);
        uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
        puVar4 = (undefined8 *)param_1[2];
        if (puVar4 == (undefined8 *)param_1[3]) {
          plStack_8 = plVar12;
          func_0x009195f0(puVar14,puVar4,&uStack_10);
        }
        else {
          *puVar4 = uStack_10;
          puVar4[1] = 0;
          plStack_8 = (long *)0x0;
          puVar4[1] = plVar12;
          param_1[2] = puVar4 + 2;
          uStack_10 = 0;
        }
        plVar12 = plStack_8;
        lVar22 = _UNK_00dc6340;
        if (plStack_8 != (long *)0x0) {
          if (_UNK_00dc6340 == 0) {
            iVar10 = (int)plStack_8[1];
            *(int *)(plStack_8 + 1) = iVar10 + -1;
          }
          else {
            plVar23 = plStack_8 + 1;
            do {
              iVar10 = (int)*plVar23;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
              if (bVar9) {
                *(int *)plVar23 = iVar10 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
          if (iVar10 == 1) {
            (**(code **)(*plStack_8 + 0x10))(plStack_8);
            if (lVar22 == 0) {
              iVar10 = *(int *)((long)plVar12 + 0xc);
              *(int *)((long)plVar12 + 0xc) = iVar10 + -1;
            }
            else {
              piVar1 = (int *)((long)plVar12 + 0xc);
              do {
                iVar10 = *piVar1;
                cVar8 = '\x01';
                bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                if (bVar9) {
                  *piVar1 = iVar10 + -1;
                  cVar8 = ExclusiveMonitorsStatus();
                }
              } while (cVar8 != '\0');
            }
            if (iVar10 == 1) {
              (**(code **)(*plVar12 + 0x18))(plVar12);
            }
          }
        }
        if (0 < (int)param_2[0x62]) {
          plVar12 = (long *)func_0x00409e60(0x40);
          plVar12[1] = 0x100000001;
          *plVar12 = (long)&UNK_00dc61e0;
          func_0x00939bb8(plVar12 + 2);
          uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
          puVar4 = (undefined8 *)param_1[2];
          if (puVar4 == (undefined8 *)param_1[3]) {
            plStack_8 = plVar12;
            func_0x009195f0(puVar14,puVar4,&uStack_10);
          }
          else {
            *puVar4 = uStack_10;
            puVar4[1] = 0;
            plStack_8 = (long *)0x0;
            puVar4[1] = plVar12;
            param_1[2] = puVar4 + 2;
            uStack_10 = 0;
          }
          plVar12 = plStack_8;
          lVar22 = _UNK_00dc6340;
          if (plStack_8 != (long *)0x0) {
            if (_UNK_00dc6340 == 0) {
              iVar10 = (int)plStack_8[1];
              *(int *)(plStack_8 + 1) = iVar10 + -1;
            }
            else {
              plVar23 = plStack_8 + 1;
              do {
                iVar10 = (int)*plVar23;
                cVar8 = '\x01';
                bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
                if (bVar9) {
                  *(int *)plVar23 = iVar10 + -1;
                  cVar8 = ExclusiveMonitorsStatus();
                }
              } while (cVar8 != '\0');
            }
            if (iVar10 == 1) {
              (**(code **)(*plStack_8 + 0x10))(plStack_8);
              if (lVar22 == 0) goto LAB_00918770;
              piVar1 = (int *)((long)plVar12 + 0xc);
              do {
                iVar10 = *piVar1;
                cVar8 = '\x01';
                bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                if (bVar9) {
                  *piVar1 = iVar10 + -1;
                  cVar8 = ExclusiveMonitorsStatus();
                }
              } while (cVar8 != '\0');
              goto LAB_0091761c;
            }
          }
        }
      }
      else {
        plVar12 = (long *)func_0x00409e60(0x38);
        plVar12[1] = 0x100000001;
        *plVar12 = (long)&UNK_00dc6170;
        func_0x0091c850(plVar12 + 2);
        uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
        puVar4 = (undefined8 *)param_1[2];
        if (puVar4 == (undefined8 *)param_1[3]) {
          plStack_8 = plVar12;
          func_0x009195f0(puVar14,puVar4,&uStack_10);
        }
        else {
          *puVar4 = uStack_10;
          puVar4[1] = 0;
          plStack_8 = (long *)0x0;
          puVar4[1] = plVar12;
          param_1[2] = puVar4 + 2;
          uStack_10 = 0;
        }
        plVar12 = plStack_8;
        lVar22 = _UNK_00dc6340;
        if (plStack_8 != (long *)0x0) {
          if (_UNK_00dc6340 == 0) {
            iVar10 = (int)plStack_8[1];
            *(int *)(plStack_8 + 1) = iVar10 + -1;
          }
          else {
            plVar23 = plStack_8 + 1;
            do {
              iVar10 = (int)*plVar23;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
              if (bVar9) {
                *(int *)plVar23 = iVar10 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
          if (iVar10 == 1) {
            (**(code **)(*plStack_8 + 0x10))(plStack_8);
            if (lVar22 == 0) {
LAB_00918770:
              iVar10 = *(int *)((long)plVar12 + 0xc);
              *(int *)((long)plVar12 + 0xc) = iVar10 + -1;
            }
            else {
              piVar1 = (int *)((long)plVar12 + 0xc);
              do {
                iVar10 = *piVar1;
                cVar8 = '\x01';
                bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                if (bVar9) {
                  *piVar1 = iVar10 + -1;
                  cVar8 = ExclusiveMonitorsStatus();
                }
              } while (cVar8 != '\0');
            }
LAB_0091761c:
            if (iVar10 == 1) {
              (**(code **)(*plVar12 + 0x18))(plVar12);
            }
          }
        }
      }
      if (0.001 < ABS(param_2[100])) {
        plVar12 = (long *)func_0x00409e60(0x50);
        plVar12[1] = 0x100000001;
        *plVar12 = (long)&UNK_00dc6058;
        func_0x00988dd0(plVar12 + 2);
        uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
        puVar4 = (undefined8 *)param_1[2];
        if (puVar4 == (undefined8 *)param_1[3]) {
          plStack_8 = plVar12;
          func_0x009195f0(puVar14,puVar4,&uStack_10);
        }
        else {
          *puVar4 = uStack_10;
          puVar4[1] = 0;
          plStack_8 = (long *)0x0;
          puVar4[1] = plVar12;
          param_1[2] = puVar4 + 2;
          uStack_10 = 0;
        }
        plVar12 = plStack_8;
        lVar22 = _UNK_00dc6340;
        if (plStack_8 != (long *)0x0) {
          if (_UNK_00dc6340 == 0) {
            iVar10 = (int)plStack_8[1];
            *(int *)(plStack_8 + 1) = iVar10 + -1;
          }
          else {
            plVar23 = plStack_8 + 1;
            do {
              iVar10 = (int)*plVar23;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
              if (bVar9) {
                *(int *)plVar23 = iVar10 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
          if (iVar10 == 1) {
            (**(code **)(*plStack_8 + 0x10))(plStack_8);
            if (lVar22 == 0) {
              iVar10 = *(int *)((long)plVar12 + 0xc);
              *(int *)((long)plVar12 + 0xc) = iVar10 + -1;
            }
            else {
              piVar1 = (int *)((long)plVar12 + 0xc);
              do {
                iVar10 = *piVar1;
                cVar8 = '\x01';
                bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                if (bVar9) {
                  *piVar1 = iVar10 + -1;
                  cVar8 = ExclusiveMonitorsStatus();
                }
              } while (cVar8 != '\0');
            }
            if (iVar10 == 1) {
              (**(code **)(*plVar12 + 0x18))(plVar12);
            }
          }
        }
      }
      if ((0.001 < param_2[0x65]) || (0.001 < param_2[0x66])) {
        plVar12 = (long *)func_0x00409e60(0x100);
        plVar12[1] = 0x100000001;
        *plVar12 = (long)&UNK_00dc6090;
        func_0x0097d210(plVar12 + 2);
        uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
        puVar4 = (undefined8 *)param_1[2];
        if (puVar4 == (undefined8 *)param_1[3]) {
          plStack_8 = plVar12;
          func_0x009195f0(puVar14,puVar4,&uStack_10);
        }
        else {
          *puVar4 = uStack_10;
          puVar4[1] = 0;
          plStack_8 = (long *)0x0;
          puVar4[1] = plVar12;
          param_1[2] = puVar4 + 2;
          uStack_10 = 0;
        }
        plVar12 = plStack_8;
        lVar22 = _UNK_00dc6340;
        if (plStack_8 != (long *)0x0) {
          if (_UNK_00dc6340 == 0) {
            iVar10 = (int)plStack_8[1];
            *(int *)(plStack_8 + 1) = iVar10 + -1;
          }
          else {
            plVar23 = plStack_8 + 1;
            do {
              iVar10 = (int)*plVar23;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
              if (bVar9) {
                *(int *)plVar23 = iVar10 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
          if (iVar10 == 1) {
            (**(code **)(*plStack_8 + 0x10))(plStack_8);
            if (lVar22 == 0) {
              iVar10 = *(int *)((long)plVar12 + 0xc);
              *(int *)((long)plVar12 + 0xc) = iVar10 + -1;
            }
            else {
              piVar1 = (int *)((long)plVar12 + 0xc);
              do {
                iVar10 = *piVar1;
                cVar8 = '\x01';
                bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                if (bVar9) {
                  *piVar1 = iVar10 + -1;
                  cVar8 = ExclusiveMonitorsStatus();
                }
              } while (cVar8 != '\0');
            }
            if (iVar10 == 1) {
              (**(code **)(*plVar12 + 0x18))(plVar12);
            }
          }
        }
      }
      if (0.001 < ABS(param_2[0x61])) {
        plVar12 = (long *)func_0x00409e60(0x38);
        plVar12[1] = 0x100000001;
        *plVar12 = (long)&UNK_00dc6218;
        func_0x009279d8(plVar12 + 2);
        uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
        puVar4 = (undefined8 *)param_1[2];
        if (puVar4 == (undefined8 *)param_1[3]) {
          plStack_8 = plVar12;
          func_0x009195f0(puVar14,puVar4,&uStack_10);
        }
        else {
          *puVar4 = uStack_10;
          puVar4[1] = 0;
          plStack_8 = (long *)0x0;
          puVar4[1] = plVar12;
          param_1[2] = puVar4 + 2;
          uStack_10 = 0;
        }
        plVar12 = plStack_8;
        lVar22 = _UNK_00dc6340;
        if (plStack_8 != (long *)0x0) {
          if (_UNK_00dc6340 == 0) {
            iVar10 = (int)plStack_8[1];
            *(int *)(plStack_8 + 1) = iVar10 + -1;
          }
          else {
            plVar23 = plStack_8 + 1;
            do {
              iVar10 = (int)*plVar23;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
              if (bVar9) {
                *(int *)plVar23 = iVar10 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
          if (iVar10 == 1) {
            (**(code **)(*plStack_8 + 0x10))(plStack_8);
            if (lVar22 == 0) goto LAB_00918760;
            piVar1 = (int *)((long)plVar12 + 0xc);
            do {
              iVar10 = *piVar1;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
              if (bVar9) {
                *piVar1 = iVar10 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
            goto LAB_009178a4;
          }
        }
      }
    }
    else {
      plVar12 = (long *)func_0x00409e60(0x38);
      plVar12[1] = 0x100000001;
      *plVar12 = (long)&UNK_00dc6020;
      func_0x0090ac10(plVar12 + 2);
      uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
      puVar4 = (undefined8 *)param_1[2];
      if (puVar4 == (undefined8 *)param_1[3]) {
        plStack_8 = plVar12;
        func_0x009195f0(puVar14,puVar4,&uStack_10);
      }
      else {
        *puVar4 = uStack_10;
        puVar4[1] = 0;
        plStack_8 = (long *)0x0;
        puVar4[1] = plVar12;
        param_1[2] = puVar4 + 2;
        uStack_10 = 0;
      }
      plVar12 = plStack_8;
      lVar22 = _UNK_00dc6340;
      if (plStack_8 != (long *)0x0) {
        if (_UNK_00dc6340 == 0) {
          iVar10 = (int)plStack_8[1];
          *(int *)(plStack_8 + 1) = iVar10 + -1;
        }
        else {
          plVar23 = plStack_8 + 1;
          do {
            iVar10 = (int)*plVar23;
            cVar8 = '\x01';
            bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
            if (bVar9) {
              *(int *)plVar23 = iVar10 + -1;
              cVar8 = ExclusiveMonitorsStatus();
            }
          } while (cVar8 != '\0');
        }
        if (iVar10 == 1) {
          (**(code **)(*plStack_8 + 0x10))(plStack_8);
          if (lVar22 == 0) {
            iVar10 = *(int *)((long)plVar12 + 0xc);
            *(int *)((long)plVar12 + 0xc) = iVar10 + -1;
          }
          else {
            piVar1 = (int *)((long)plVar12 + 0xc);
            do {
              iVar10 = *piVar1;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
              if (bVar9) {
                *piVar1 = iVar10 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
          if (iVar10 == 1) {
            (**(code **)(*plVar12 + 0x18))(plVar12);
          }
        }
      }
      if (0.001 < ABS(param_2[100])) {
        plVar12 = (long *)func_0x00409e60(0x50);
        plVar12[1] = 0x100000001;
        *plVar12 = (long)&UNK_00dc6058;
        func_0x00988dd0(plVar12 + 2);
        uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
        puVar4 = (undefined8 *)param_1[2];
        if (puVar4 == (undefined8 *)param_1[3]) {
          plStack_8 = plVar12;
          func_0x009195f0(puVar14,puVar4,&uStack_10);
        }
        else {
          *puVar4 = uStack_10;
          puVar4[1] = 0;
          plStack_8 = (long *)0x0;
          puVar4[1] = plVar12;
          param_1[2] = puVar4 + 2;
          uStack_10 = 0;
        }
        plVar12 = plStack_8;
        lVar22 = _UNK_00dc6340;
        if (plStack_8 != (long *)0x0) {
          if (_UNK_00dc6340 == 0) {
            iVar10 = (int)plStack_8[1];
            *(int *)(plStack_8 + 1) = iVar10 + -1;
          }
          else {
            plVar23 = plStack_8 + 1;
            do {
              iVar10 = (int)*plVar23;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
              if (bVar9) {
                *(int *)plVar23 = iVar10 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
          if (iVar10 == 1) {
            (**(code **)(*plStack_8 + 0x10))(plStack_8);
            if (lVar22 == 0) {
              iVar10 = *(int *)((long)plVar12 + 0xc);
              *(int *)((long)plVar12 + 0xc) = iVar10 + -1;
            }
            else {
              piVar1 = (int *)((long)plVar12 + 0xc);
              do {
                iVar10 = *piVar1;
                cVar8 = '\x01';
                bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                if (bVar9) {
                  *piVar1 = iVar10 + -1;
                  cVar8 = ExclusiveMonitorsStatus();
                }
              } while (cVar8 != '\0');
            }
            if (iVar10 == 1) {
              (**(code **)(*plVar12 + 0x18))(plVar12);
            }
          }
        }
      }
      if ((0.001 < param_2[0x65]) || (0.001 < param_2[0x66])) {
        plVar12 = (long *)func_0x00409e60(0x100);
        plVar12[1] = 0x100000001;
        *plVar12 = (long)&UNK_00dc6090;
        func_0x0097d210(plVar12 + 2);
        uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
        puVar4 = (undefined8 *)param_1[2];
        if (puVar4 == (undefined8 *)param_1[3]) {
          plStack_8 = plVar12;
          func_0x009195f0(puVar14,puVar4,&uStack_10);
        }
        else {
          *puVar4 = uStack_10;
          puVar4[1] = 0;
          plStack_8 = (long *)0x0;
          puVar4[1] = plVar12;
          param_1[2] = puVar4 + 2;
          uStack_10 = 0;
        }
        plVar12 = plStack_8;
        lVar22 = _UNK_00dc6340;
        if (plStack_8 != (long *)0x0) {
          if (_UNK_00dc6340 == 0) {
            iVar10 = (int)plStack_8[1];
            *(int *)(plStack_8 + 1) = iVar10 + -1;
          }
          else {
            plVar23 = plStack_8 + 1;
            do {
              iVar10 = (int)*plVar23;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
              if (bVar9) {
                *(int *)plVar23 = iVar10 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
          if (iVar10 == 1) {
            (**(code **)(*plStack_8 + 0x10))(plStack_8);
            if (lVar22 == 0) {
LAB_00918760:
              iVar10 = *(int *)((long)plVar12 + 0xc);
              *(int *)((long)plVar12 + 0xc) = iVar10 + -1;
            }
            else {
              piVar1 = (int *)((long)plVar12 + 0xc);
              do {
                iVar10 = *piVar1;
                cVar8 = '\x01';
                bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                if (bVar9) {
                  *piVar1 = iVar10 + -1;
                  cVar8 = ExclusiveMonitorsStatus();
                }
              } while (cVar8 != '\0');
            }
LAB_009178a4:
            if (iVar10 == 1) {
              (**(code **)(*plVar12 + 0x18))(plVar12);
            }
          }
        }
      }
    }
    if (*(char *)((long)param_2 + 0x291) == '\0') {
      plVar12 = (long *)func_0x00409e60(0x38);
      plVar12[1] = 0x100000001;
      *plVar12 = (long)&UNK_00dc6250;
      func_0x00907068(plVar12 + 2);
      uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
      puVar4 = (undefined8 *)param_1[2];
      if (puVar4 == (undefined8 *)param_1[3]) {
        plStack_8 = plVar12;
        func_0x009195f0(puVar14,puVar4,&uStack_10);
      }
      else {
        *puVar4 = uStack_10;
        puVar4[1] = 0;
        plStack_8 = (long *)0x0;
        puVar4[1] = plVar12;
        param_1[2] = puVar4 + 2;
        uStack_10 = 0;
      }
      plVar12 = plStack_8;
      lVar22 = _UNK_00dc6340;
      if (plStack_8 != (long *)0x0) {
        if (_UNK_00dc6340 == 0) {
          iVar10 = (int)plStack_8[1];
          *(int *)(plStack_8 + 1) = iVar10 + -1;
        }
        else {
          plVar23 = plStack_8 + 1;
          do {
            iVar10 = (int)*plVar23;
            cVar8 = '\x01';
            bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
            if (bVar9) {
              *(int *)plVar23 = iVar10 + -1;
              cVar8 = ExclusiveMonitorsStatus();
            }
          } while (cVar8 != '\0');
        }
        if (iVar10 == 1) {
          (**(code **)(*plStack_8 + 0x10))(plStack_8);
          if (lVar22 == 0) {
            iVar10 = *(int *)((long)plVar12 + 0xc);
            *(int *)((long)plVar12 + 0xc) = iVar10 + -1;
          }
          else {
            piVar1 = (int *)((long)plVar12 + 0xc);
            do {
              iVar10 = *piVar1;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
              if (bVar9) {
                *piVar1 = iVar10 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
          if (iVar10 == 1) {
            (**(code **)(*plVar12 + 0x18))(plVar12);
          }
        }
      }
      if ((*(long *)(param_2 + 0x6c) != 0) && (param_2[0x6e] != 0.0)) {
        plVar12 = (long *)func_0x00409e60(0x38);
        plVar12[1] = 0x100000001;
        *plVar12 = (long)&UNK_00dc6288;
        func_0x0091b2c0(plVar12 + 2);
        uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
        plStack_8 = plVar12;
        func_0x00919850(puVar14,&uStack_10);
        if (plStack_8 != (long *)0x0) {
          func_0x006c93bc();
        }
      }
      if ((0 < (int)param_2[9]) || (0 < (int)param_2[10])) {
        plVar12 = (long *)func_0x00409e60(0x38);
        plVar12[1] = 0x100000001;
        *plVar12 = (long)&UNK_00dc62c0;
        func_0x00937b68(plVar12 + 2);
        uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
        puVar4 = (undefined8 *)param_1[2];
        if (puVar4 == (undefined8 *)param_1[3]) {
          plStack_8 = plVar12;
          func_0x009195f0(puVar14,puVar4,&uStack_10);
        }
        else {
          *puVar4 = uStack_10;
          puVar4[1] = 0;
          plStack_8 = (long *)0x0;
          puVar4[1] = plVar12;
          param_1[2] = puVar4 + 2;
          uStack_10 = 0;
        }
        plVar12 = plStack_8;
        lVar22 = _UNK_00dc6340;
        if (plStack_8 != (long *)0x0) {
          if (_UNK_00dc6340 == 0) {
            iVar10 = (int)plStack_8[1];
            *(int *)(plStack_8 + 1) = iVar10 + -1;
          }
          else {
            plVar23 = plStack_8 + 1;
            do {
              iVar10 = (int)*plVar23;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
              if (bVar9) {
                *(int *)plVar23 = iVar10 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
          if (iVar10 == 1) {
            (**(code **)(*plStack_8 + 0x10))(plStack_8);
            if (lVar22 == 0) {
              iVar10 = *(int *)((long)plVar12 + 0xc);
              *(int *)((long)plVar12 + 0xc) = iVar10 + -1;
            }
            else {
              piVar1 = (int *)((long)plVar12 + 0xc);
              do {
                iVar10 = *piVar1;
                cVar8 = '\x01';
                bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
                if (bVar9) {
                  *piVar1 = iVar10 + -1;
                  cVar8 = ExclusiveMonitorsStatus();
                }
              } while (cVar8 != '\0');
            }
            if (iVar10 == 1) {
              (**(code **)(*plVar12 + 0x18))(plVar12);
            }
          }
        }
      }
      plVar12 = (long *)func_0x00409e60(0x38);
      plVar12[1] = 0x100000001;
      *plVar12 = (long)&UNK_00dc62f8;
      func_0x00909548(plVar12 + 2);
      uStack_10 = (**(code **)(*plVar12 + 0x20))(plVar12,&UNK_00c18550);
      puVar4 = (undefined8 *)param_1[2];
      if (puVar4 == (undefined8 *)param_1[3]) {
        plStack_8 = plVar12;
        func_0x009195f0(puVar14,puVar4,&uStack_10);
      }
      else {
        *puVar4 = uStack_10;
        puVar4[1] = 0;
        plStack_8 = (long *)0x0;
        puVar4[1] = plVar12;
        param_1[2] = puVar4 + 2;
        uStack_10 = 0;
      }
      plVar12 = plStack_8;
      lVar22 = _UNK_00dc6340;
      if (plStack_8 != (long *)0x0) {
        if (_UNK_00dc6340 == 0) {
          iVar10 = (int)plStack_8[1];
          *(int *)(plStack_8 + 1) = iVar10 + -1;
        }
        else {
          plVar23 = plStack_8 + 1;
          do {
            iVar10 = (int)*plVar23;
            cVar8 = '\x01';
            bVar9 = (bool)ExclusiveMonitorPass(plVar23,0x10);
            if (bVar9) {
              *(int *)plVar23 = iVar10 + -1;
              cVar8 = ExclusiveMonitorsStatus();
            }
          } while (cVar8 != '\0');
        }
        if (iVar10 == 1) {
          (**(code **)(*plStack_8 + 0x10))(plStack_8);
          if (lVar22 == 0) {
LAB_00918638:
            iVar10 = *(int *)((long)plVar12 + 0xc);
            *(int *)((long)plVar12 + 0xc) = iVar10 + -1;
          }
          else {
            piVar1 = (int *)((long)plVar12 + 0xc);
            do {
              iVar10 = *piVar1;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
              if (bVar9) {
                *piVar1 = iVar10 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
          goto LAB_00917d44;
        }
      }
    }
  }
  lVar16 = param_1[1];
  lVar22 = param_1[4];
  uVar18 = param_1[2] - lVar16 >> 4;
  uVar15 = param_1[5] - lVar22 >> 4;
  if (uVar15 < uVar18) {
    func_0x00919398(param_1 + 4,uVar18 - uVar15);
    lVar16 = param_1[1];
    lVar22 = param_1[4];
    uVar18 = param_1[2] - lVar16 >> 4;
  }
  else if ((uVar18 < uVar15) && (lVar3 = lVar22 + (param_1[2] - lVar16), param_1[5] != lVar3)) {
    param_1[5] = lVar3;
  }
  fVar27 = *param_2;
  iVar17 = (int)uVar18;
  iVar10 = iVar17 + -1;
  fVar5 = param_2[0xae];
  fVar6 = param_2[0xaf];
  lVar21 = (long)iVar10 * 0x10;
  fVar7 = param_2[0xb1];
  lVar3 = lVar22 + lVar21;
  fVar24 = param_2[0xb0];
  if (0.5 < fVar27) {
    *(uint *)(lVar22 + lVar21) = (uint)fVar5 & 0xfffffffe;
    *(uint *)(lVar3 + 0xc) =
         (((int)fVar5 + (int)fVar7) - ((uint)fVar5 & 0xfffffffe)) + 1 & 0xfffffffe;
    *(uint *)(lVar3 + 4) = (uint)fVar6 & 0xfffffffe;
    *(uint *)(lVar3 + 8) =
         (((int)fVar6 + (int)fVar24) - ((uint)fVar6 & 0xfffffffe)) + 1 & 0xfffffffe;
    puVar20 = (undefined4 *)param_1[7];
    puVar13 = (undefined4 *)param_1[8];
    uVar15 = (long)puVar13 - (long)puVar20 >> 2;
    if (uVar15 < uVar18) goto LAB_00917b20;
LAB_00917204:
    if ((uVar18 < uVar15) && (puVar13 != puVar20 + uVar18)) {
      param_1[8] = puVar20 + uVar18;
    }
    puVar13 = (undefined4 *)param_1[10];
    puVar19 = (undefined4 *)param_1[0xb];
    *puVar20 = 0;
    uVar15 = (long)puVar19 - (long)puVar13 >> 2;
    bVar9 = uVar15 <= uVar18;
    if (uVar15 < uVar18) {
LAB_00917b54:
      func_0x009194d8(param_1 + 10,uVar18 - uVar15);
      lVar16 = param_1[1];
      *(undefined4 *)param_1[10] = 0;
      goto joined_r0x00917b70;
    }
  }
  else {
    puVar20 = (undefined4 *)param_1[7];
    puVar13 = (undefined4 *)param_1[8];
    uVar26 = NEON_scvtf(CONCAT44(fVar6,fVar5),4);
    uVar25 = NEON_scvtf(*(undefined8 *)(param_2 + 0xb0),4);
    uVar15 = (long)puVar13 - (long)puVar20 >> 2;
    *(ulong *)(lVar22 + lVar21) =
         CONCAT44((int)((float)((ulong)uVar26 >> 0x20) * fVar27),(int)((float)uVar26 * fVar27));
    *(ulong *)(lVar3 + 8) =
         CONCAT44((int)((float)((ulong)uVar25 >> 0x20) * fVar27),(int)((float)uVar25 * fVar27));
    if (uVar18 <= uVar15) goto LAB_00917204;
LAB_00917b20:
    func_0x009194d8(param_1 + 7,uVar18 - uVar15);
    lVar16 = param_1[1];
    lVar22 = param_1[2];
    puVar13 = (undefined4 *)param_1[10];
    puVar19 = (undefined4 *)param_1[0xb];
    *(undefined4 *)param_1[7] = 0;
    uVar18 = lVar22 - lVar16 >> 4;
    uVar15 = (long)puVar19 - (long)puVar13 >> 2;
    bVar9 = uVar15 <= uVar18;
    if (uVar15 < uVar18) goto LAB_00917b54;
  }
  if ((!bVar9) && (puVar19 != puVar13 + uVar18)) {
    param_1[0xb] = puVar13 + uVar18;
  }
  *puVar13 = 0;
joined_r0x00917b70:
  if (iVar10 < 1) {
    if (*param_2 <= 0.5) {
      uVar25 = *(undefined8 *)(param_2 + 0xb0);
      param_1[0xd] = 0;
      param_1[0xe] = uVar25;
    }
  }
  else {
    while( true ) {
      plVar23 = *(long **)(lVar16 + lVar21 + 8);
      plVar12 = *(long **)(lVar16 + lVar21);
      uStack_10 = *(undefined8 *)(param_1[4] + lVar21);
      plStack_8 = (long *)((undefined8 *)(param_1[4] + lVar21))[1];
      if (plVar23 != (long *)0x0) {
        if (_UNK_00dc6340 == 0) {
          *(int *)(plVar23 + 1) = (int)plVar23[1] + 1;
        }
        else {
          plVar2 = plVar23 + 1;
          do {
            cVar8 = '\x01';
            bVar9 = (bool)ExclusiveMonitorPass(plVar2,0x10);
            if (bVar9) {
              *(int *)plVar2 = (int)*plVar2 + 1;
              cVar8 = ExclusiveMonitorsStatus();
            }
          } while (cVar8 != '\0');
        }
      }
      auVar28 = (**(code **)(*plVar12 + 0x30))(plVar12,&uStack_10);
      *(undefined1 (*) [16])(param_1[4] + lVar21 + -0x10) = auVar28;
      lVar22 = _UNK_00dc6340;
      if (plVar23 != (long *)0x0) {
        if (_UNK_00dc6340 == 0) {
          iVar11 = (int)plVar23[1];
          *(int *)(plVar23 + 1) = iVar11 + -1;
        }
        else {
          plVar12 = plVar23 + 1;
          do {
            iVar11 = (int)*plVar12;
            cVar8 = '\x01';
            bVar9 = (bool)ExclusiveMonitorPass(plVar12,0x10);
            if (bVar9) {
              *(int *)plVar12 = iVar11 + -1;
              cVar8 = ExclusiveMonitorsStatus();
            }
          } while (cVar8 != '\0');
        }
        if (iVar11 == 1) {
          (**(code **)(*plVar23 + 0x10))(plVar23);
          if (lVar22 == 0) {
            iVar11 = *(int *)((long)plVar23 + 0xc);
            *(int *)((long)plVar23 + 0xc) = iVar11 + -1;
          }
          else {
            piVar1 = (int *)((long)plVar23 + 0xc);
            do {
              iVar11 = *piVar1;
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
              if (bVar9) {
                *piVar1 = iVar11 + -1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
          if (iVar11 == 1) {
            (**(code **)(*plVar23 + 0x18))(plVar23);
          }
        }
      }
      if (lVar21 == ((long)iVar10 - (ulong)(iVar17 - 2)) * 0x10) break;
      lVar21 = lVar21 + -0x10;
      lVar16 = param_1[1];
    }
    if (*param_2 <= 0.5) {
      puVar14 = (undefined8 *)param_1[4];
      uVar25 = *(undefined8 *)(param_2 + 0xb0);
      param_1[0xd] = 0;
      lVar16 = param_1[1];
      param_1[0xe] = uVar25;
      *puVar14 = 0;
      puVar14[1] = uVar25;
    }
    else {
      lVar16 = param_1[1];
    }
  }
  if (1 < (int)(param_1[2] - lVar16 >> 4)) {
    lVar22 = 4;
    iVar10 = 1;
    do {
      while( true ) {
        plVar23 = *(long **)(lVar16 + lVar22 * 4 + 8);
        iVar17 = *(int *)(param_1[7] + lVar22 + -4);
        plVar12 = *(long **)(lVar16 + lVar22 * 4);
        iVar11 = *(int *)(param_1[10] + lVar22 + -4);
        if (plVar23 != (long *)0x0) {
          if (_UNK_00dc6340 == 0) {
            *(int *)(plVar23 + 1) = (int)plVar23[1] + 1;
          }
          else {
            plVar2 = plVar23 + 1;
            do {
              cVar8 = '\x01';
              bVar9 = (bool)ExclusiveMonitorPass(plVar2,0x10);
              if (bVar9) {
                *(int *)plVar2 = (int)*plVar2 + 1;
                cVar8 = ExclusiveMonitorsStatus();
              }
            } while (cVar8 != '\0');
          }
        }
        (**(code **)(*plVar12 + 0x38))(plVar12,&iStack_14,&uStack_10);
        lVar16 = param_1[10];
        *(int *)(param_1[7] + lVar22) = iStack_14 + iVar17;
        *(int *)(lVar16 + lVar22) = (int)uStack_10 + iVar11;
        lVar16 = _UNK_00dc6340;
        if (plVar23 != (long *)0x0) break;
LAB_009179cc:
        lVar16 = param_1[1];
        iVar10 = iVar10 + 1;
        lVar22 = lVar22 + 4;
        if ((int)(param_1[2] - lVar16 >> 4) <= iVar10) {
          return;
        }
      }
      if (_UNK_00dc6340 == 0) {
        lVar3 = plVar23[1];
        *(int *)(plVar23 + 1) = (int)lVar3 + -1;
        if ((int)lVar3 == 1) goto LAB_00917a3c;
        goto LAB_009179cc;
      }
      plVar12 = plVar23 + 1;
      do {
        lVar3 = *plVar12;
        cVar8 = '\x01';
        bVar9 = (bool)ExclusiveMonitorPass(plVar12,0x10);
        if (bVar9) {
          *(int *)plVar12 = (int)lVar3 + -1;
          cVar8 = ExclusiveMonitorsStatus();
        }
      } while (cVar8 != '\0');
      if ((int)lVar3 != 1) goto LAB_009179cc;
LAB_00917a3c:
      (**(code **)(*plVar23 + 0x10))(plVar23);
      if (lVar16 == 0) {
        iVar17 = *(int *)((long)plVar23 + 0xc);
        *(int *)((long)plVar23 + 0xc) = iVar17 + -1;
      }
      else {
        piVar1 = (int *)((long)plVar23 + 0xc);
        do {
          iVar17 = *piVar1;
          cVar8 = '\x01';
          bVar9 = (bool)ExclusiveMonitorPass(piVar1,0x10);
          if (bVar9) {
            *piVar1 = iVar17 + -1;
            cVar8 = ExclusiveMonitorsStatus();
          }
        } while (cVar8 != '\0');
      }
      if (iVar17 != 1) goto LAB_009179cc;
      iVar10 = iVar10 + 1;
      lVar22 = lVar22 + 4;
      (**(code **)(*plVar23 + 0x18))(plVar23);
      lVar16 = param_1[1];
    } while (iVar10 < (int)(param_1[2] - lVar16 >> 4));
  }
  return;
}

