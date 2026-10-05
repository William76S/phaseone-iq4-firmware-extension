#!/usr/bin/env python3
"""Default public inert build. Private binding only from actual opaque originals.

Actual originals/config/ELF/build logs stay in Windows single-user DACL storage.
No device API, transport, target execution, decoder or credential output.
"""
from pathlib import Path
import argparse
import hashlib
import json
import os
import re
import stat
import subprocess
import sys

HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2]
OUT=ROOT/'analysis/firmware/record1_ram_restore_01'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
ZIG_SHA='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
USER_SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
COMMON_GATES=['new_root_sole_authorization','device_identity_and_single_executor_verified',
 'native_readonly_transport_complete','full_original_double_read_EOF_device_hash_verified',
 'actual_source_extent_independently_verified','actual_canonical_leaf_metadata_verified',
 'actual_kernel_and_at24_provider_contract_verified','current_User_hash_PID_start_ticks_verified',
 'private_single_user_DACL_verified','existing_record1_exact_range_verified','RAM_target_state_mount_verified',
 'maintenance_lease_no_other_controls_verified','whole_snapshot_stability_verified']
WRITE_GATES=['Root_exact16_recovery_route_reviewed','standalone_RAM_tool_readonly_probe_verified']
CLEAR_GATES=['same_original_transport_verified','clear_restore_coldboot_original_baseline_route_reviewed']
SHA=re.compile('[0-9a-f]{64}')

def sha(b):return hashlib.sha256(b).hexdigest()
def integer(v,lo,hi):return type(v) is int and lo<=v<=hi
def dump(p,j):p.write_text(json.dumps(j,indent=2)+'\n')

def private_acl(path):
    if os.name!='nt':return False
    # Fixed script, literal path via environment; no interpolation or exported
    # SID/ACL/raw contents. Administrators/SYSTEM remain trusted platform owners.
    script=r'''$ErrorActionPreference='Stop';$p=$env:IQ4_R1_ACL_PATH;
$a=Get-Acl -LiteralPath $p;
$sid=[Security.Principal.WindowsIdentity]::GetCurrent().User.Value;
$owner=([Security.Principal.NTAccount]$a.Owner).Translate([Security.Principal.SecurityIdentifier]).Value;
$ok=($owner -eq $sid);$allow=@($sid,'S-1-5-18','S-1-5-32-544');
foreach($r in $a.Access){$id=$r.IdentityReference.Translate([Security.Principal.SecurityIdentifier]).Value;if($allow -notcontains $id){$ok=$false}}
if($ok){'PRIVATE_OK'}else{'PRIVATE_REFUSED'}'''
    env=dict(os.environ);env['IQ4_R1_ACL_PATH']=str(path)
    r=subprocess.run(['powershell.exe','-NoProfile','-NonInteractive','-Command',script],env=env,capture_output=True,text=True,timeout=15)
    return r.returncode==0 and r.stdout.strip()=='PRIVATE_OK'

def read_stable(p):
    s=p.lstat()
    if not stat.S_ISREG(s.st_mode) or s.st_size!=0x4000 or (getattr(s,'st_file_attributes',0)&0x400):raise ValueError('private snapshot shape')
    with p.open('rb') as f:
        a=os.fstat(f.fileno());b=f.read(0x4001);z=os.fstat(f.fileno())
    if (s.st_dev,s.st_ino)!=(a.st_dev,a.st_ino) or len(b)!=0x4000 or (a.st_dev,a.st_ino,a.st_size,a.st_mtime_ns)!=(z.st_dev,z.st_ino,z.st_size,z.st_mtime_ns):raise ValueError('private snapshot changed')
    return b

def require_gate_receipts(proof,receipt):
    if not isinstance(proof,dict) or proof.get('schema')!='iq4_record1_private_binding_v1' or proof.get('operator')!='root_windows_unique_executor':raise ValueError('proof schema')
    role=proof.get('role')
    if role not in ('read','transport_trial','clear','restore'):raise ValueError('finite role')
    gates=COMMON_GATES+([] if role=='read' else WRITE_GATES)+(CLEAR_GATES if role=='clear' else [])
    if any(proof.get(k) is not True for k in gates):raise ValueError('actual receipts absent')
    if not isinstance(proof.get('receipts'),dict) or any(k not in proof['receipts'] for k in gates):raise ValueError('actual provenance absent')
    for k in gates:
        r=proof['receipts'][k]
        if not isinstance(r,dict) or type(r.get('path')) is not str or type(r.get('sha256')) is not str or not SHA.fullmatch(r['sha256']) or sha(receipt(r['path']))!=r['sha256']:raise ValueError('receipt mismatch')
    return role

def validate(proof,a,b,receipt):
    role=require_gate_receipts(proof,receipt)
    # Explicit adapter compatibility limit; st_size==0 or package geometry is
    # never a substitute for independent actual extent/EOF evidence.
    if type(proof.get('actual_extent')) is not int or proof['actual_extent']!=0x4000:raise ValueError('unsupported actual extent')
    if a!=b or len(a)!=proof['actual_extent'] or sha(a)!=proof.get('whole_original_sha256'):raise ValueError('originals mismatch')
    sys.path.insert(0,str(HERE.parent))
    from audit_security_record1_range import _record1_payload_interval
    from validate_security_eeprom_structure import validate_system_image
    system=a[0x400:0xc00]
    if validate_system_image(system)['structure_valid'] is not True:raise ValueError('unsupported structure')
    interval=_record1_payload_interval(system)
    if interval is None or interval[1]-interval[0]!=16:raise ValueError('existing16 absent')
    offset=0x400+interval[0];opaque=a[offset:offset+16]
    if role=='clear' and opaque==b'\xff'*16:raise ValueError('already undefined original')
    leaf=proof.get('leaf');meta=proof.get('metadata',{});user=proof.get('User',{});state=proof.get('RAM_state',{})
    if type(leaf) is not str or not re.fullmatch('/sys/devices/[A-Za-z0-9_@./:-]+/eeprom',leaf) or any(p in ('','..','.') for p in leaf[1:].split('/')):raise ValueError('canonical leaf invalid')
    for k,lo,hi in [('inode',1,2**64-1),('major',0,2**20),('minor',1,2**20),('mode',0,0o777),('stat_size',0,0x4000)]:
        if not integer(meta.get(k),lo,hi):raise ValueError('metadata invalid')
    if type(meta.get('uid')) is not int or type(meta.get('gid')) is not int or meta['uid']!=0 or meta['gid']!=0 or meta.get('kind')!='regular_binary_attribute':raise ValueError('metadata owner/type')
    if proof.get('actual_driver')!='at24' or type(proof.get('actual_kernel')) is not str or not re.fullmatch('[A-Za-z0-9._+-]{1,96}',proof['actual_kernel']):raise ValueError('provider identity absent')
    if user.get('sha256')!=USER_SHA or user.get('canonical_path')!='/mnt/qspi/User/p1linux' or not integer(user.get('pid'),2,10000000) or not integer(user.get('start_ticks'),1,2**64-1):raise ValueError('User identity absent')
    if state.get('path')!='/run/iq4_record1_01' or state.get('fstype')!='tmpfs' or type(state.get('major')) is not int or state['major']!=0 or not integer(state.get('minor'),1,2**20):raise ValueError('actual RAM state absent')
    return offset,opaque,role

def private_config(proof,offset,opaque,role):
    s=(HERE/'config.preview.h').read_text()
    # Values containing the opaque record only ever exist in protected output;
    # no single-value/header/ELF hash appears in public stdout/manifest.
    replacements={'R1_BOUND_READ':'1','R1_BOUND_WRITE':'0' if role=='read' else '1',
      'R1_LEAF':json.dumps(proof['leaf']),'R1_WHOLE_SHA':json.dumps(proof['whole_original_sha256']),
      'R1_ORIGINAL_BYTES':'{'+','.join(str(v) for v in opaque)+'}',
      'R1_OFFSET':str(offset)+'U','R1_ACTUAL_EXTENT':str(proof['actual_extent'])+'U',
      'R1_USER_PID':str(proof['User']['pid'])+'ULL','R1_USER_START_TICKS':str(proof['User']['start_ticks'])+'ULL',
      'R1_KERNEL':json.dumps(proof['actual_kernel']),'R1_ALLOW_ACTION':str({'read':0,'transport_trial':1,'clear':2,'restore':3}[role]),
      'R1_STATE_DEV_MINOR':str(proof['RAM_state']['minor'])+'U'}
    for source,field,suffix in [('R1_EEP_DEV_MAJOR','major','U'),('R1_EEP_DEV_MINOR','minor','U'),('R1_EEP_INODE','inode','ULL'),('R1_EEP_MODE','mode','U'),('R1_EEP_STAT_SIZE','stat_size','LL')]:replacements[source]=str(proof['metadata'][field])+suffix
    for k,v in replacements.items():s=re.sub(r'^#define '+k+r' .+$','#define '+k+' '+v,s,flags=re.M)
    return s

def compile_target(compiler,out,config,env):
    (out/'config.h').write_text(config)
    parser=ROOT/'tools/firmware/f4_ram_entry_01/readonly_monitor.c'
    log=out/'compiler.private.log'
    with log.open('wb') as output:
        subprocess.run([str(compiler),'cc','-target','aarch64-linux-gnu.2.17','-std=c11','-O2','-Wall','-Wextra','-Werror','-fPIE','-pie','-Wl,--build-id=sha1','-DF4_MONITOR_PARSER_ONLY','-I'+str(out),str(HERE/'target.c'),str(HERE/'engine.c'),str(parser),'-o',str(out/'record1.elf')],check=True,env=env,stdout=output,stderr=output)

def main():
    p=argparse.ArgumentParser();p.add_argument('--emit-private',action='store_true');p.add_argument('--proof',type=Path);p.add_argument('--original-a',type=Path);p.add_argument('--original-b',type=Path);p.add_argument('--out',type=Path);p.add_argument('--private-zig',type=Path);args=p.parse_args()
    if not args.emit_private:
        if sha(ZIG.read_bytes())!=ZIG_SHA:raise ValueError('unknown locked compiler')
        OUT.mkdir(exist_ok=True);(OUT/'.gitignore').write_text('*.elf\n.zig-cache/\n')
        out=OUT/'preview';out.mkdir(exist_ok=True);env=dict(os.environ);env['ZIG_GLOBAL_CACHE_DIR']=str(OUT/'.zig-cache/global');env['ZIG_LOCAL_CACHE_DIR']=str(OUT/'.zig-cache/local')
        compile_target(ZIG,out,(HERE/'config.preview.h').read_text(),env)
        dump(out/'build.json',{'schema':'iq4_record1_unbound_preview_v1','actual_source_extent_proven':False,'bound_read':False,'bound_write':False,'device_accessed':False,'target_executed':False,'private_profile_emitted':False,'target_sha256':sha((out/'record1.elf').read_bytes()),'target_bytes':(out/'record1.elf').stat().st_size,'toolchain_sha256':ZIG_SHA})
        print(json.dumps({'preview_built':True,'private_profile_emitted':False,'device_accessed':False}));return 0
    required=[args.proof,args.original_a,args.original_b,args.out,args.private_zig]
    if os.name!='nt' or not all(required) or any(not private_acl(v) for v in required[:4]):raise ValueError('private output protection unavailable')
    if any(args.out.iterdir()):raise ValueError('private output not empty')
    if args.original_a.resolve()==args.original_b.resolve() or args.original_a.stat().st_ino==args.original_b.stat().st_ino:raise ValueError('independent files absent')
    proof=json.loads(args.proof.read_text())
    def receipt(name):
        path=Path(name)
        if not path.is_absolute() or not private_acl(path) or not path.is_file() or path.stat().st_size>1048576:raise ValueError('private receipt unavailable')
        return path.read_bytes()
    require_gate_receipts(proof,receipt)
    a=read_stable(args.original_a);b=read_stable(args.original_b);offset,opaque,role=validate(proof,a,b,receipt)
    if not private_acl(args.private_zig) or sha(args.private_zig.read_bytes())!=proof.get('private_zig_sha256') or subprocess.check_output([str(args.private_zig),'version'],text=True).strip()!='0.15.2':raise ValueError('private approved compiler unavailable')
    temp=args.out/'.tmp';temp.mkdir()
    if not private_acl(temp):raise ValueError('private compiler temp protection absent')
    env=dict(os.environ);env['ZIG_GLOBAL_CACHE_DIR']=str(args.out/'.zig-cache/global');env['ZIG_LOCAL_CACHE_DIR']=str(args.out/'.zig-cache/local')
    for k in ['TMP','TEMP','TMPDIR']:env[k]=str(temp)
    compile_target(args.private_zig,args.out,private_config(proof,offset,opaque,role),env)
    if any(not private_acl(v) for v in args.out.iterdir()):raise ValueError('created private output protection changed')
    dump(args.out/'build.private.json',{'schema':'iq4_record1_private_artifact_v1','role':role,'config_private_sha256':sha((args.out/'config.h').read_bytes()),'target_private_sha256':sha((args.out/'record1.elf').read_bytes()),'device_accessed':False,'target_executed':False})
    if not private_acl(args.out/'build.private.json'):raise ValueError('private receipt protection changed')
    print(json.dumps({'private_profile_emitted':True,'device_accessed':False,'target_executed':False}));return 0

if __name__=='__main__':
    try:raise SystemExit(main())
    except Exception:
        print(json.dumps({'profile_refused':True,'device_accessed':False,'private_values_exported':False}));raise SystemExit(2)
