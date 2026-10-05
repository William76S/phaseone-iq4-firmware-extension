// INPUT SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
// STATIC PSEUDOCODE; recovered types/ABI and flow across tail branches require instruction verification.
// Linked VA 007d9630

uint NativeReaderRawPayload(long param_1,undefined8 param_2,uint param_3)

{
  uint uVar1;
  char cVar2;
  uint uVar3;
  
  cVar2 = func_0x008259a8(param_1 + 0x62c10);
  if (cVar2 == '\0') {
    func_0x0040a580(&UNK_00b7b848,&UNK_00d867c0,&UNK_00d86790,0x24a);
    func_0x0076c708();
    uVar1 = *(uint *)(param_1 + 0x3a56c);
  }
  else {
    uVar1 = *(uint *)(param_1 + 0x3a56c);
  }
  if (param_3 < uVar1) {
    func_0x0040a580(&UNK_00b7b848,&UNK_00d867d0,&UNK_00d86790,0x24e);
    func_0x0076c708();
  }
  func_0x007cc180(param_1 + 0x380a0);
  uVar3 = (**(code **)(**(long **)(param_1 + 0x450c8) + 0x18))
                    (*(long **)(param_1 + 0x450c8),param_2,uVar1);
  if (uVar1 != uVar3) {
    uVar3 = 0;
  }
  return uVar3;
}

