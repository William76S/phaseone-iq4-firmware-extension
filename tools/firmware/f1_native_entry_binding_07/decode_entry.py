#!/usr/bin/env python3
"""Decode exact copied own UI status only; no process/device/library access."""
from pathlib import Path
import json,struct,sys
def decode(first,second):
 if len(first)!=104 or first!=second:raise ValueError('Two identical complete UI07 publications required')
 seq,size=struct.unpack_from('<II',first);v=struct.unpack_from('<6I6Q6I',first,8)
 keys=('schema','bytes','phase','mask_state_known','mask_enabled','reserved','callbacks','open_requests','selections','rejected','generation','detach_epoch','selected','retained_until_User_exit','stock_toolbar_1_8_preserved','embedded_popup_preserved','stock_paint_restored','ui_mutation_attempted');m=dict(zip(keys,v))
 if seq%2 or size!=104 or m['schema']!=7 or m['bytes']!=96 or m['reserved']or not 0<=m['phase']<=8 or not 0<=m['selected']<=4:raise ValueError('Finite UI07 header/state')
 for k in('mask_state_known','mask_enabled','stock_paint_restored','ui_mutation_attempted'):
  if m[k]not in(0,1):raise ValueError('Finite flag')
 if m['mask_state_known']!=0 or m['mask_enabled']!=0:raise ValueError('UI binding does not attest or enable rendering')
 if any(m[k]!=1 for k in('retained_until_User_exit','stock_toolbar_1_8_preserved','embedded_popup_preserved')):raise ValueError('Required retention/source preservation metadata')
 return {'scope':'UI07 copied own state; process/provenance independently required','sequence':seq,'metadata':m,'mask_state':'unknown_to_entry_binder','selected_is_request_mode_not_rendering_proof':True,'full_source_mapping_verified':False,'fresh_stock_blit_verified':False,'surface_lease_verified':False}
if __name__=='__main__':
 if len(sys.argv)!=3:raise SystemExit('Two independently copied complete UI07 publication files required')
 print(json.dumps(decode(Path(sys.argv[1]).read_bytes(),Path(sys.argv[2]).read_bytes()),indent=2))
