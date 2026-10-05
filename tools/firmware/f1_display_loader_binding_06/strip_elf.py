"""Finite ELF64/AArch64 strip-only serializer. No native code execution."""
import hashlib,struct
def sha(b):return hashlib.sha256(b).hexdigest()
def tables(b):
 h=struct.unpack_from('<16sHHIQQQIHHHHHH',b)
 if h[0][:7]!=b'\x7fELF\x02\x01\x01'or h[1]!=3 or h[2]!=183 or h[8]!=64 or h[9]!=56 or h[11]!=64 or not 0<h[12]<1024 or not 0<h[13]<h[12]:raise ValueError('Exact finite AArch64 ET_DYN required')
 if h[5]+56*h[10]>len(b)or h[6]+64*h[12]>len(b):raise ValueError('ELF table extent')
 ph=[struct.unpack_from('<IIQQQQQQ',b,h[5]+56*i)for i in range(h[10])]
 sh=[struct.unpack_from('<IIQQQQIIQQ',b,h[6]+64*i)for i in range(h[12])]
 for s in sh:
  if s[1]!=8 and s[4]+s[5]>len(b):raise ValueError('Section extent')
 return h,ph,sh
def strip(b):
 h,ph,sh=tables(b);loads=[p for p in ph if p[0]==1];end=max(p[2]+p[5]for p in loads)
 if loads[0][2]!=0 or loads[0][3]!=0 or end>len(b):raise ValueError('Unmatched LOAD layout')
 last=max(i for i,s in enumerate(sh)if s[2]&2)
 # Keep indices of every ALLOC section. No remapping of dynamic st_shndx or
 # section links, and no changes to dynamic symbol/relocation payloads.
 if any(not sh[i][2]&2 for i in range(1,last+1)):raise ValueError('ALLOC sections must form original index prefix')
 names=sh[h[13]];strings=b[names[4]:names[4]+names[5]]
 kept=sh[:last+1];newnames=list(names);out=bytearray(b[:end]);out.extend(b'\0'*((-len(out))%8));newnames[4]=len(out);out.extend(strings);out.extend(b'\0'*((-len(out))%8));off=len(out);kept.append(tuple(newnames))
 for row in kept:out.extend(struct.pack('<IIQQQQIIQQ',*row))
 # Only the ELF section-directory locator/count changes inside LOAD0.
 # This unavoidable exception is explicit; no claim of whole LOAD0 equality.
 struct.pack_into('<Q',out,40,off);struct.pack_into('<H',out,60,len(kept));struct.pack_into('<H',out,62,last+1)
 result=bytes(out);nh,np,ns=tables(result);assert ph==np
 expected=set(range(40,48))|set(range(60,64));loadproof=[]
 for p in loads:
  delta=[i for i in range(p[2],p[2]+p[5])if b[i]!=result[i]]
  if not set(delta)<=expected:raise ValueError('Any load byte outside ELF directory metadata changed')
  loadproof.append({'file_offset':p[2],'va':p[3],'file_bytes':p[5],'memory_bytes':p[6],'flags':p[1],'changed_file_offsets':delta,'original_sha256':sha(b[p[2]:p[2]+p[5]]),'new_sha256':sha(result[p[2]:p[2]+p[5]])})
 alloc=[]
 for i,s in enumerate(sh):
  if not s[2]&2:continue
  if ns[i]!=s:raise ValueError('ALLOC section header changed')
  name=strings[s[0]:strings.index(0,s[0])].decode()
  if s[1]!=8 and b[s[4]:s[4]+s[5]]!=result[s[4]:s[4]+s[5]]:raise ValueError('ALLOC payload changed')
  alloc.append({'index':i,'name':name,'type':s[1],'flags':s[2],'va':s[3],'bytes':s[5],'identical_header':True,'identical_payload_or_NOBITS':True})
 proof={'schema':'iq4_f1_elf_strip_only_v6','original_bytes':len(b),'new_bytes':len(result),'original_sha256':sha(b),'new_sha256':sha(result),'program_headers_identical':True,'alloc_sections':alloc,'load_segments':loadproof,'all_load_bytes_identical':False,'only_load_exception':'ELF e_shoff/e_shnum/e_shstrndx at file offsets 40..47 and 60..63','dynamic_symbols_relocations_versions_init_TLS_unwind_unchanged':True,'target_executed':False}
 return result,proof
