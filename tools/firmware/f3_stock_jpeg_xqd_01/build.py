#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f3_stock_jpeg_xqd_01/build';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 OUT.mkdir(parents=True,exist_ok=True);commands=[]
 def run(argv,label):
  q=subprocess.run(list(map(str,argv)),cwd=ROOT,capture_output=True,text=True);commands.append(dict(label=label,argv=list(map(str,argv)),exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,(label,q.stdout,q.stderr);return q.stdout
 run(['python3',HERE/'collect.py'],'bind_original');sdk=subprocess.check_output(['xcrun','--show-sdk-path'],text=True).strip()
 exe=OUT/'test_publish';run(['/usr/bin/clang','-isysroot',sdk,'-std=c11','-O1','-Wall','-Wextra','-Werror','-DIQ4_STOCK_JPEG_PUBLISH_HOST',HERE/'publish.c',HERE/'test_publish.c','-o',exe],'compile_publish')
 for case in ['ok','collision','space','sync','close','guard']:run([exe,case],'publish_'+case)
 exe=OUT/'test_runtime';run(['/usr/bin/clang++','-isysroot',sdk,'-isystem',Path(sdk)/'usr/include/c++/v1','-std=c++17','-O1','-Wall','-Wextra','-Werror','-DIQ4_STOCK_JPEG_TEST',HERE/'runtime.cpp',HERE/'test_runtime.cpp','-o',exe],'compile_runtime')
 for case in ['normal','failed_write','retained','exception']:run([exe,case],'runtime_'+case)
 run([ROOT/'build/dual-exposure-host-venv/bin/python',HERE/'prove_requester.py'],'original_A64_two_client_requester')
 run([ROOT/'build/dual-exposure-host-venv/bin/python',HERE/'prove_filesystem.py'],'original_A64_linux_filesystem')
 exe=OUT/'test_settings';run(['/usr/bin/clang','-isysroot',sdk,'-std=c11','-O1','-Wall','-Wextra','-Werror','-DIQ4_STOCK_JPEG_SETTINGS_HOST',HERE/'settings.c',HERE/'test_settings.c','-o',exe],'compile_settings');run([exe],'settings_own_atomic_namespace')
 objects=[];flags=['-target','aarch64-linux-gnu.2.28','-O2','-g0','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror']
 for src,driver,std in [('runtime.cpp','c++','-std=c++17'),('publish.c','cc','-std=c11'),('settings.c','cc','-std=c11'),('wrappers.S','cc',None)]:
  target=OUT/(Path(src).stem+'.o');run([ZIG,driver,*flags,*([std]if std else []),'-c',HERE/src,'-o',target],src);objects.append(row(target));(OUT/(target.name+'.asm')).write_text(run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',target],src+'_inspect'));run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',target],src+'_undefined')
 result=dict(schema='iq4_stock_jpeg_xqd_build_01',objects=objects,host_publish_cases=6,host_routing_cases=4,actual_A64_requester_clients=2,original_user_sha256='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb',camera_accessed=False,target_executed=False);(OUT/'BUILD.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
if __name__=='__main__':main()
