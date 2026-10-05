// INPUT SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
// STATIC PSEUDOCODE; recovered types/ABI and flow across tail branches require instruction verification.
// Linked VA 009225c0

undefined8 NativeRawReaderJobManager(undefined8 *param_1,undefined8 *param_2,int param_3)

{
  if (param_3 != 1) {
    if (param_3 == 0) {
      *param_1 = &UNK_00dc6dc8;
      return 0;
    }
    if (param_3 != 2) {
      return 0;
    }
    param_2 = (undefined8 *)*param_2;
  }
  *param_1 = param_2;
  return 0;
}

