#!/usr/bin/env python3
"""Pack explicit Root parameters and fixed private RAM files; never execute.

The caller supplies reviewed actual values. This file checks source identity,
local receipt bytes and exact wire layout; it cannot establish a device lease.
No populated sample is emitted by preparation or ordinary package generation.
"""
from pathlib import Path
import argparse,json,re,struct
import contract
from build_prepare import ROOT,HERE,OUT
from stager import append_plan,STATE
def integer(v,lo=1,hi=2**64-1):
 if type(v)is not int or not lo<=v<=hi:raise ValueError('Actual finite integer')
 return v
def digest(v):
 if type(v)is not str or re.fullmatch('[0-9a-f]{64}',v)is None or v=='0'*64:raise ValueError('Receipt SHA')
 return v.encode()+b'\0'
def ctext(v,n):
 if type(v)is not str or '\0'in v or len(v.encode('ascii'))>=n:raise ValueError('Bounded fixed ASCII')
 return v.encode()+bytes(n-len(v))
def receipts(d):
 out={}
 for name,r in d.items():
  if type(r)is not dict or set(r)!={'path','sha256'}:raise ValueError('Receipt descriptor')
  body=contract.receipt(r['path'])
  if not 0<len(body)<=65536 or contract.sha(body)!=r['sha256']:raise ValueError('Receipt changed/extent')
  digest(r['sha256']);out[name]=body
 return out
def pack_prepare(d):
 if set(d)!={'near_hint','generation','root_admission_sha','unwind_review_sha','provider'}:raise ValueError('Exact preparation fields')
 p=d['provider'];names=('queue','manager','data','lv','popup');addresses=('provider','provider_vtable','getter','present')
 if type(p)is not dict or set(p)!={'profile','actual_UserSHA','owner_review_sha256','hook_quiescence_receipt_sha256','owner',*addresses,'inline_surface_offset','getter_shape'}or type(p['profile'])is not int or p['profile']!=1 or p['actual_UserSHA']!='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb':raise ValueError('Root reviewed exact provider profile required')
 if set(p['owner'])!=set(names):raise ValueError('Actual owner chain fields')
 near=integer(d['near_hint']);offset=integer(p['inline_surface_offset'],8,4088)
 if near%4096 or offset%8 or type(p['getter_shape'])is not int or p['getter_shape']not in(1,2):raise ValueError('Actual near/getter alignment')
 b=bytearray(472);struct.pack_into('<IIQQ',b,0,10,472,near,integer(d['generation']));b[24:89]=digest(d['root_admission_sha']);b[89:154]=digest(d['unwind_review_sha'])
 struct.pack_into('<II',b,160,10,1);b[168:233]=digest(p['actual_UserSHA']);b[233:298]=digest(p['owner_review_sha256']);b[298:363]=digest(p['hook_quiescence_receipt_sha256'])
 struct.pack_into('<5Q',b,368,*(integer(p['owner'][k],4096,2**63-1)for k in names));struct.pack_into('<7Q',b,408,*(integer(p[k],4096,2**63-1)for k in addresses),0,0,0);struct.pack_into('<II',b,464,offset,p['getter_shape']);return bytes(b)
def pack_controller(d,operation):
 names=('pid_ticks','user_dev','user_ino','module_dev','module_ino','module_bias','near_page','near_bytes','own_bridge','trampoline_slot')
 hashes=('proc_version_sha','root_receipt_sha','provider_receipt_sha','off_clean_receipt_sha','preparation_receipt_sha','prepared_input_sha')
 required={'pid','ui_tid','kernel_profile',*names,'own_executable','prepared_publication','prepared_generation',*hashes}
 if type(d)is not dict or set(d)!=required or d['kernel_profile']!=1:raise ValueError('Exact current Root controller contract')
 identity=json.loads((ROOT/'analysis/firmware/f1_scaler_hook_install_build_11/BUILD_PREPARATION.json').read_text())['module'];bias=integer(d['module_bias'],4096,2**63-1)
 if d['own_bridge']!=bias+identity['bridge_va']or d['trampoline_slot']!=bias+identity['trampoline_slot_va']or d['prepared_publication']!=bias+308552 or d['near_bytes']!=65536 or d['near_page']%4096 or not -(1<<27)<=d['near_page']-0x47f910<(1<<27):raise ValueError('Actual linked/near relations')
 ranges=d['own_executable'];expected=[[bias+p[3],bias+p[3]+p[6]]for p in identity['RX_LOADs']]
 if ranges!=expected or not 1<=len(ranges)<=8:raise ValueError('Exact actual module RX PHDRs')
 b=bytearray(960);struct.pack_into('<4I',b,0,10,integer(d['pid'],2,10000000),integer(d['ui_tid'],2,2**32-1),1);struct.pack_into('<10Q',b,16,*(integer(d[k])for k in names))
 for i,(a,z)in enumerate(ranges):struct.pack_into('<2Q',b,96+16*i,a,z)
 struct.pack_into('<I',b,224,len(ranges));b[228:388]=ctext(STATE+'/observe.so',160);b[388:548]=ctext(STATE+'/hook10.'+operation,160)
 for i,k in enumerate(hashes[:4]):b[548+65*i:613+65*i]=digest(d[k])
 struct.pack_into('<2Q',b,808,integer(d['prepared_publication']),integer(d['prepared_generation']));b[824:889]=digest(d['preparation_receipt_sha']);b[889:954]=digest(d['prepared_input_sha']);return bytes(b)
def main():
 a=argparse.ArgumentParser();a.add_argument('--input-json',type=Path);a.add_argument('--emit-root-parameters',action='store_true');args=a.parse_args()
 if not args.emit_root_parameters:print(json.dumps({'prep_only':True,'commands':[],'actual_hardware_qualification_created':False}));return
 raise SystemExit("Actual input/staging emission is outside this local preparation freeze")
if __name__=='__main__':main()
