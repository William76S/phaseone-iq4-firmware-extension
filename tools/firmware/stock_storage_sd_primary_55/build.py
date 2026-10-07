#!/usr/bin/env python3
import argparse,hashlib,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT) and not out.exists();out.mkdir(parents=True)
 stock=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';assert row(stock)['sha256']=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb';data=stock.read_bytes();zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';commands=[]
 def run(argv,label):
  q=subprocess.run(list(map(str,argv)),cwd=ROOT,capture_output=True,text=True);commands.append(dict(label=label,argv=list(map(str,argv)),exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,(label,q.stdout,q.stderr);return q.stdout
 sdk=subprocess.check_output(['xcrun','--show-sdk-path'],text=True).strip()
 for san in(False,True):
  exe=out/('test_san'if san else'test');flags=['-fsanitize=address,undefined','-fno-omit-frame-pointer']if san else[];run(['/usr/bin/clang++','-isysroot',sdk,'-isystem',Path(sdk)/'usr/include/c++/v1','-std=c++17','-O2','-Wall','-Wextra','-Werror','-DIQ4_SD_PRIMARY_TEST55',*flags,HERE/'primary.cpp',HERE/'test_primary.cpp','-o',exe],'host_compile');print(run([exe],'host_execute').strip(),flush=True)
 flags=['-target','aarch64-linux-gnu.2.28','-O2','-g0','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer'];objects=[]
 for name,driver in [('primary.cpp','c++'),('wrapper.S','cc')]:
  obj=out/(Path(name).stem+'.o');run([zig,driver,*flags,*(['-std=c++17']if driver=='c++'else[]),'-c',HERE/name,'-o',obj],'target_compile');objects.append(row(obj))
 aliases=[dict(symbol='iq4_stock_storage_original_policy_55',va=0x6a9aa4,kind='exact native Storage observer policy',original_first16_LE=data[0x2a9aa4:0x2a9ab4].hex())]
 hooks=[dict(va=0x6a9a94,old_hex=data[0x2a9a94:0x2a9a98].hex(),original_target=0x6a9aa4,target_symbol='iq4_stock_storage_policy_wrapper_55')];assert hooks[0]['old_hex']=='04000094'
 manifest=dict(schema='iq4_SD_primary_normalizer_source_55',members=[row(HERE/p)for p in ['primary.cpp','wrapper.S','test_primary.cpp','pins.h','build.py']]+[row(ROOT/'tools/firmware/native_runtime_01/self_read.h')],stock=row(stock),compiler=row(zig),commands=row(out/'COMMANDS.json'),camera_accessed=False);p=out/'SOURCE_SHA256.json';p.write_text(json.dumps(manifest,indent=2)+'\n');lock=row(p)
 link=dict(schema='iq4_SD_primary_normalizer_link_55',objects=objects,aliases=aliases,BL_hooks=hooks,auxiliary_hooks=[],required_functions=['iq4_stock_storage_normalize_sd_55','iq4_stock_storage_after_policy_55','iq4_stock_storage_normalize_idle_55'],source_manifest=lock['path'],source_manifest_sha256=lock['sha256'],camera_accessed=False,target_executed=False,SD_only_actual_mode='native Primary5, SD raw2, XQD raw0')
 (out/'LINK.json').write_text(json.dumps(link,indent=2)+'\n');print(json.dumps(dict(link=row(out/'LINK.json'),target_executed=False)))
if __name__=='__main__':main()
