"""Supplemental exact B/BL/BLR-site patch for a linked User; no target execution.

The frozen append02 backend remains unchanged. A STR replacement is a B to a
wrapper that replays the original store and branches back; a BLR replacement
is a BL to its actual argument-compatible native wrapper. Only explicit
four-byte sites, actual linked executable symbols and actual FDE PCs qualify.
"""
import hashlib,struct
BASE_SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
def apply_exact_auxiliary_hooks(stock,payload,report,hooks,Elf):
 assert hashlib.sha256(stock).hexdigest()==BASE_SHA and hashlib.sha256(payload).hexdigest()==report['candidate_sha256']
 original=Elf(stock,2);candidate=Elf(payload,2);out=bytearray(payload);seen={h['va']for h in report['hooks']};new=[]
 fde_pcs={pc for pc,_ in report['own_fde_pairs']}
 for h in hooks:
  va=h['va'];kind=h['branch_kind'];name=h['target_symbol'];before=bytes.fromhex(h['old_hex']);assert kind in('B','BL')and len(before)==4 and va%4==0 and va not in seen;seen.add(va)
  oldoff=original.va_offset(va,4);off=candidate.va_offset(va,4);assert stock[oldoff:oldoff+4]==before==out[off:off+4]
  target=report['own_symbols'][name];assert target%4==0 and target in fde_pcs and any(p[0]==1 and p[1]&1 and p[3]<=target< p[3]+p[5]for p in candidate.ph)
  delta=target-va;assert delta%4==0 and -(1<<27)<=delta<(1<<27);word=(0x14000000 if kind=='B'else 0x94000000)|((delta//4)&0x3ffffff);patched=struct.pack('<I',word);out[off:off+4]=patched
  new.append(dict(va=va,file_offset=off,old_bytes=before.hex(),new_bytes=patched.hex(),new_target=target,symbol=name,branch_kind=kind,original_instruction_replayed_or_original_callee_preserved_by_wrapper=True))
 report['auxiliary_hooks']=new;report['allowed_original_spans']+= [(h['file_offset'],4,'exact auxiliary '+h['branch_kind']+' '+h['symbol'])for h in new]
 allowed=report['allowed_original_spans']
 for i,(x,y)in enumerate(zip(stock,out)):
  if x!=y:assert any(start<=i<start+n for start,n,_ in allowed),i
 report['candidate_sha256']=hashlib.sha256(out).hexdigest();report['candidate_bytes']=len(out);report['supplemental_original_body_preservation_verified']=True;report['auxiliary_ELF_inspection_only']=True
 return bytes(out)
