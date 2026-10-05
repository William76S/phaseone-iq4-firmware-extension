#!/usr/bin/env python3
"""Host fault tests and own AArch64 object compilation only; no target execution."""
import argparse,hashlib,json,struct,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--out',type=Path,required=True);p.add_argument('--zig',type=Path,default=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig');a=p.parse_args()
    lock=json.loads((HERE/'SOURCE_LOCK.json').read_text());
    for row in lock['files']+lock['dependencies']:
        path=ROOT/row['path'];assert path.stat().st_size==row['size'] and sha(path)==row['sha256'],row['path']
    target=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());assert sha(a.zig)==target['zig_binary_sha256']
    out=a.out.resolve();out.mkdir(parents=True,exist_ok=False);commands=[]
    def run(args):
        commands.append([str(x) for x in args]);r=subprocess.run(commands[-1],cwd=ROOT,capture_output=True,text=True)
        if r.returncode:raise SystemExit(r.stdout+r.stderr)
        return r.stdout
    assert run([a.zig,'version']).strip()==target['version'];sdk=run(['xcrun','--show-sdk-path']).strip()
    pool=ROOT/'tools/firmware/f4_owned_copy_pool_01/owned_copy_pool.cpp';host=[]
    common=['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-UNDEBUG','-pthread','-isystem',sdk+'/usr/include/c++/v1']
    for key,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
        exe=out/('host_'+key);run([*common,*flags,'-DIQ4_F4_ADAPTER_SYNTHETIC_HOST=1',HERE/'adapter.cpp',pool,HERE/'test_adapter.cpp','-o',exe]);receipt=run([exe])
        assert receipt=='30 synthetic adapter fault groups passed; zero device/vendor execution\n',receipt
        (out/(key+'.txt')).write_text(receipt);host.append({'name':key,'return_code':0,'receipt':receipt,'binary_sha256':sha(exe)})
    objects=[]
    for src in [HERE/'adapter.cpp',HERE/'runtime_linux.cpp',pool]:
        obj=out/(src.stem+'.aarch64.o');run([a.zig,'c++','-target',target['target'],'-std=c++17','-O2','-fPIC','-Wall','-Wextra','-Wpedantic','-Werror','-pthread','-c',src,'-o',obj])
        raw=obj.read_bytes();assert raw[:7]==b'\x7fELF\x02\x01\x01' and struct.unpack_from('<H',raw,16)[0]==1 and struct.unpack_from('<H',raw,18)[0]==183
        objects.append({'path':obj.name,'size':len(raw),'sha256':sha(obj),'format':'ELF64LE AArch64 relocatable','executed':False})
    dis=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-t',out/'adapter.aarch64.o']);assert 'copy_synthetic' not in dis and 'configure_synthetic' not in dis
    (out/'production_symbols.txt').write_text(dis)
    # No shared module/installer/launch/hook/constructor is produced by this increment.
    report={'action':'host_fault_tests_and_production_aarch64_objects','host_tests':host,'target_objects':objects,'source_lock_sha256':sha(HERE/'SOURCE_LOCK.json'),'commands':commands,
            'sdk_loaded':False,'camera_access':False,'vendor_executed':False,'target_executed':False,'deployment_performed':False,'native_abi_runtime_verified':False,
            'production_pixel_copy_available':False,'hardware_layout_color_capacity_receipts_present':False,'real_60fps_proven':False}
    (out/'HOST_VALIDATION.json').write_text(json.dumps(report,indent=2)+'\n');print('30/30 normal + 30/30 ASan/UBSan; 3 production AArch64 objects, none executed')
if __name__=='__main__':main()
