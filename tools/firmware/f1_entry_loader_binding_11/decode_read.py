#!/usr/bin/env python3
"""Exact 496B UI10 OFF-boundary publication; no firmware/device access."""
from pathlib import Path
import json,math,re,struct,sys
import contract
RESULTS={0:'Disabled',1:'WrongOwner',5:'ReadFailed',7:'UnknownLease',14:'BoundaryObserved'}
ADDR_NAMES=('queue','LV','Surface','Draw','provider','provider_VT','getter','manager_frame')
def decode(raw,expected_pid,expected_ticks):
 r=contract.strict_json(raw);fields={'schema','pid','start_ticks','module_sha256','publication_va','publication_bytes','sequence','first_hex','second_hex','firmware_calls','target_memory_writes','mask_state_not_inferred'}
 if type(r)is not dict or set(r)!=fields:raise ValueError('Exact UI10 copy shape')
 for k,v in {'schema':'iq4_f1_entry_copied_read_v11','pid':expected_pid,'start_ticks':expected_ticks,'module_sha256':contract.ENTRY_SO,'publication_bytes':496,'firmware_calls':0,'target_memory_writes':0,'mask_state_not_inferred':True}.items():
  if type(r[k])is not type(v)or r[k]!=v:raise ValueError('UI10 exact copy identity/scope')
 if type(expected_pid)is not int or not 2<=expected_pid<=10000000 or type(expected_ticks)is not int or not 0<expected_ticks<2**64:raise ValueError('Independent PID/start identity')
 if type(r['publication_va'])is not int or not 4096<=r['publication_va']<=2**63-496 or type(r['sequence'])is not int or not 0<=r['sequence']<2**32 or r['sequence']&1:raise ValueError('Copied address/sequence')
 if any(type(r[k])is not str or re.fullmatch('[0-9a-f]{992}',r[k])is None for k in('first_hex','second_hex')):raise ValueError('Exactly 496 lower-case bytes per copy')
 first,second=(bytes.fromhex(r[k])for k in('first_hex','second_hex'))
 if first!=second:raise ValueError('Own publication changed between copies')
 seq,size,schema,status_size,result,emitted,normal_returns,reserved,serial=struct.unpack_from('<8IQ',first)
 if seq!=r['sequence']or size!=496 or schema!=10 or status_size!=328 or reserved or result not in RESULTS:raise ValueError('Exact observed ABI/result')
 if emitted or normal_returns or serial or any(first[336:]):raise ValueError('Native callback/write ingress is outside this boundary-only module')
 # WriteFacts 296B starts at 40. The exact target/host layout is pinned in
 # sourceClosure, not read from a caller-provided schema or pointer.
 addresses=dict(zip(ADDR_NAMES,struct.unpack_from('<8Q',first,40)))
 paint,epoch=struct.unpack_from('<2Q',first,104)
 if paint or epoch or addresses['manager_frame']:raise ValueError('Boundary candidates cannot claim paint/frame/epoch')
 source_w,source_h,rotation=struct.unpack_from('<3i',first,120)
 def rect(off):return dict(zip(('x','y','width','height'),struct.unpack_from('<4i',first,off)))
 geometry={name:rect(off)for name,off in [('source_rectangle',132),('clipped_source_rectangle',148),('image_viewport',164),('display_bounds',180),('clip',196),('original_locked_roi',248)]}
 if source_w or source_h or any(first[132:180])or any(first[196:212])or any(first[232:280]):raise ValueError('Boundary cannot claim complete source, ROI or clean pixels')
 bits=struct.unpack_from('<2I',first,212);floats=struct.unpack_from('<2f',first,212);pan=struct.unpack_from('<2i',first,220);anim=struct.unpack_from('<I',first,228)[0]
 present=struct.unpack_from('<Q',first,280)[0];getter_words=list(struct.unpack_from('<6I',first,288));present_words=list(struct.unpack_from('<4I',first,312));gw,pw=struct.unpack_from('<2I',first,328)
 if gw not in(0,2,6)or pw not in(0,4):raise ValueError('Fixed observed instruction extents')
 if any(getter_words[gw:])or any(present_words[pw:]):raise ValueError('Unread instruction tail must remain zero')
 if result==14:
  if any(not 4096<=addresses[k]<2**63 for k in ADDR_NAMES[:-1])or not 4096<=present<2**63:raise ValueError('Complete boundary candidate addresses')
  bounds=geometry['display_bounds']
  if bounds['x']or bounds['y']or not 0<bounds['width']<=4096 or not 0<bounds['height']<=4096:raise ValueError('Finite Surface bounds')
  add=getter_words[0]if gw>=2 and getter_words[1]==0xd65f03c0 else getter_words[3]if gw==6 and getter_words[0:3]==[0xd10043ff,0xf90007e0,0xf94007e0]and getter_words[4:]==[0x910043ff,0xd65f03c0]else 0
  if (add&0xffc003ff)!=0x91000000:raise ValueError('Exact inline getter candidate')
  offset=(add>>10)&4095
  if offset&7 or addresses['Surface']!=addresses['provider']+offset:raise ValueError('Current derived inline Surface alias')
 return {'schema':'iq4_f1_entry_boundary_candidate_decoded_v11','result':RESULTS[result],'sequence':seq,
  'addresses':addresses,'present_target':present,'getter_words_read':gw,'present_words_read':pw,
  'getter_words_hex':['0x%08x'%x for x in getter_words[:gw]],'present_words_hex':['0x%08x'%x for x in present_words[:pw]],
  'geometry':geometry,'scale':floats[0]if math.isfinite(floats[0])else None,'normal_fit_scale':floats[1]if math.isfinite(floats[1])else None,
  'scale_bits_hex':['0x%08x'%x for x in bits],'pan':list(pan),'pan_animation':anim,'rotation':rotation,
  'boundary_surface_candidates_only':True,'full_source_mapping_verified':False,'fresh_stock_write_verified':False,
  'surface_lease_verified':False,'mask_enabled':False,'copied_identity_fields_matched':True,'hardware_origin_authenticated_here':False}
if __name__=='__main__':
 if len(sys.argv)!=4:raise SystemExit('Saved UI10 copied-read JSON plus independently held PID/start ticks required')
 print(json.dumps(decode(Path(sys.argv[1]).read_bytes(),int(sys.argv[2]),int(sys.argv[3])),indent=2,allow_nan=False))
