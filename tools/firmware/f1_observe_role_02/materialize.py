#!/usr/bin/env python3
"""Mechanically derive new fixed role sources from frozen Entry02. No execution."""
from pathlib import Path
import ast,difflib,hashlib,json
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/sdk_reference/f1_observe_role_build_02'
def sha(b):return hashlib.sha256(b).hexdigest()
def derive(old:str)->str:
    n=old.replace('char *env[258]','char *env[259]');assert n!=old and old.count('char *env[258]')==2
    a='/run/f4launch';assert n.count(a)==1;n=n.replace(a,'/run/f1launch')
    a='int fd=-1;int preload=absent(S_PATH("disabled"))&&module_gate()&&tool_gate()&&fcntl(198,F_GETFD)<0&&errno==EBADF;'
    b=a+'\n for(size_t i=0;i<count;i++)if(!strncmp(env[i],"IQ4_F1_MODULE_ENTRY_01=",sizeof("IQ4_F1_MODULE_ENTRY_01=")-1))preload=0;'
    assert n.count(a)==1;n=n.replace(a,b)
    a='static char setting[]="LD_PRELOAD=" F4_MODULE;';b=a+'\n static char observe_setting[]="IQ4_F1_MODULE_ENTRY_01=OBSERVE";';assert n.count(a)==1;n=n.replace(a,b)
    a='if(preload){env[count]=setting;env[count+1]=NULL;execve(F4_ARGV0,argv,env);env[count]=NULL;if(owned_198)close(198);}'
    b='if(preload){env[count]=setting;env[count+1]=observe_setting;env[count+2]=NULL;execve(F4_ARGV0,argv,env);env[count]=NULL;if(owned_198)close(198);}'
    assert n.count(a)==1;n=n.replace(a,b)
    a='char b[32];ssize_t got=recv(client,b,sizeof(b),MSG_DONTWAIT|MSG_TRUNC);';assert n.count(a)==1;n=n.replace(a,a+'\n   unsigned ctor_startup=0;int ctor_packet=f1_status_decode((const uint8_t*)b,(size_t)(got>0?got:0),&ctor_startup);')
    a='authorized&&got==5&&!memcmp(b,"F4M2\\n",5)&&proc_exe((uint64_t)peer_pid,F4_USER)';assert n.count(a)==1;n=n.replace(a,'authorized&&ctor_packet&&proc_exe((uint64_t)peer_pid,F4_USER)')
    a='char record[160];int bytes=snprintf(record,sizeof(record),"{\\"constructor_marker\\":true,\\"pid\\":%ld,\\"start_ticks\\":%llu,\\"hardware_access\\":false}\\n",(long)peer_pid,(unsigned long long)tick);'
    b='char record[256];int bytes=snprintf(record,sizeof(record),"{\\"schema\\":\\"iq4_f1_ctor_status_v2\\",\\"constructor_seen\\":true,\\"pid\\":%ld,\\"start_ticks\\":%llu,\\"startup_code\\":%u,\\"user_gate_ready\\":%s,\\"ui_ready\\":false,\\"mask_enabled\\":false}\\n",(long)peer_pid,(unsigned long long)tick,ctor_startup,ctor_startup==4?"true":"false");'
    assert n.count(a)==1;n=n.replace(a,b)
    n=n.replace('constructor_marker_observed_no_hardware_or_unload_claim','F1_ctor_status_observed_not_UI_or_mask_ready')
    n=n.replace('"config.h"','"config.h"\n#include "status.h"');return n
def config()->str:
    s=(ROOT/'tools/firmware/f4_ram_entry_02/config.preview.h').read_text()
    s=s.replace('/run/iq4_f4_entry02','/run/iq4_f1_observe02').replace('/run/f4launch','/run/f1launch').replace('/marker.so','/observe.so')
    s=s.replace('.iq4_f4_original02','.iq4_f1_original02').replace('.iq4_f4_candidate02','.iq4_f1_candidate02');return s
def proof_contract()->str:
    # Preserve the actual recovery validator; literal substitutions bind the
    # NEW observed paths rather than translating proof about different paths.
    p=ROOT/'tools/firmware/f4_ram_entry_02/generate.py'
    s=p.read_text();t=ast.parse(s);names={'RUNNER_SHA','USER_SHA','REQUIRED'}
    pieces=['import hashlib,re\ndef sha(b): return hashlib.sha256(b).hexdigest()\n']
    for n in t.body:
        if isinstance(n,ast.Assign) and any(isinstance(x,ast.Name) and x.id in names for x in n.targets):pieces.append(ast.get_source_segment(s,n)+'\n')
        elif isinstance(n,ast.FunctionDef) and n.name in {'integer','hexsha','exact_fields','validate_proof'}:pieces.append(ast.get_source_segment(s,n)+'\n')
    result='\n'.join(pieces)
    changes={'iq4_f4_ram_gate_v2':'iq4_f1_observe_role_gate_v2','RAM_marker_once':'RAM_F1_observe_once','constructor_marker_source_reviewed':'authenticated_observe_constructor_source_reviewed','/run/f4launch':'/run/f1launch','/run/iq4_f4_entry02':'/run/iq4_f1_observe02','.iq4_f4_original02':'.iq4_f1_original02','.iq4_f4_candidate02':'.iq4_f1_candidate02'}
    for a,b in changes.items():assert a in result;result=result.replace(a,b)
    return '# Mechanically derived fixed role recovery contract. No device API.\n'+result
def main():
    old=ROOT/'tools/firmware/f4_ram_entry_02/entry.c';source=old.read_text()
    lock=json.loads((ROOT/'tools/firmware/f1_module_entry_01/SOURCE_SHA256.json').read_text());r=next(r for r in lock['frozen_refs'] if r['path']==str(old.relative_to(ROOT)));assert sha(old.read_bytes())==r['sha256']
    OUT.mkdir(parents=True,exist_ok=True);(OUT/'.gitignore').write_text('*.o\n*.so\n*.elf\nentrytool\nhost_*\nenabled_package/\n')
    derived=derive(source);(OUT/'entry.c').write_text(derived);(OUT/'config.h').write_text(config());(OUT/'role_config.h').write_text((HERE/'role_config.preview.h').read_text());(OUT/'status.h').write_bytes((HERE/'status.h').read_bytes());(OUT/'proof_contract.py').write_text(proof_contract())
    (OUT/'entry.diff.txt').write_text(''.join(difflib.unified_diff(source.splitlines(True),derived.splitlines(True),fromfile='frozen/f4_ram_entry_02/entry.c',tofile='new/f1_observe_role_02/entry.c')))
    print(json.dumps({'generated_preview_only':True,'installer_emitted':False,'source_entry_sha256':sha(source.encode()),'new_entry_sha256':sha(derived.encode()),'F4_ENABLED':0,'F1_ROLE_ENABLED':0}))
if __name__=='__main__':main()
