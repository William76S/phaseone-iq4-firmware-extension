#!/usr/bin/env python3
import argparse,hashlib,json,shlex,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def row(p):
 p=p.resolve();b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists();out.mkdir(parents=True)
 base=ROOT/'analysis/firmware/jpeg_restart_54_inputs_final/INPUTS_CLEANUP_DRAFT.json';assert row(base)['sha256']=='f8ca847bf0951d66c50ce3d05eb7f4294f2d9d693aae3085e72e32b44f335a14';j=json.loads(base.read_text());commands=[]
 def run(argv,label):
  q=subprocess.run(list(map(str,argv)),cwd=ROOT,capture_output=True,text=True);commands.append(dict(label=label,argv=list(map(str,argv)),exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,(label,q.stdout,q.stderr);return q.stdout
 sdk=subprocess.check_output(['xcrun','--show-sdk-path'],text=True).strip();cases=[[],['stage'],['pin'],['title'],['ui'],['dto']]+[[kind,str(i)]for kind,n in [('alloc',5),('ctor',5),('append',4)]for i in range(1,n+1)]
 for san in(False,True):
  exe=out/('test_san'if san else'test');flags=['-fsanitize=address,undefined','-fno-omit-frame-pointer']if san else[];run(['/usr/bin/clang','-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror',*flags,HERE/'test_menu.c','-o',exe],'compile_host');
  for args in cases:run([exe,*args],'host_'+str(args))
 zig=ROOT/j['compiler']['path'];obj=out/'menu.o';run([zig,'cc',*j['C_flags'],'-MMD','-MF',out/'menu.d','-c',HERE/'menu.c','-o',obj],'target_compile')
 closure=[]
 for s in shlex.split((out/'menu.d').read_text().replace('\\\n',' ').split(':',1)[1]):
  p=Path(s);p=p if p.is_absolute()else ROOT/p
  if p.suffix in('.h','.inc'):closure.append(row(p))
 manifest=dict(schema='iq4_JPEG_status_menu_source_55',members=[row(HERE/x)for x in ['menu.c','pins.h','test_menu.c','build.py']],target_header_closure=closure,baseline=row(base),compiler=row(zig),objects=[row(obj)],commands=row(out/'COMMANDS.json'),normal_cases=len(cases),ASan_UBSan_cases=len(cases),backend_state_in_host_is_fixture=True,camera_accessed=False)
 p=out/'SOURCE_SHA256.json';p.write_text(json.dumps(manifest,indent=2)+'\n');lock=row(p)
 link=dict(schema='iq4_JPEG_status_menu_link_55',objects=[row(obj)],aliases=[],BL_hooks=[],auxiliary_hooks=[],required_functions=['iq4_stock_jpeg_size_child_02','iq4_stock_jpeg_last_failure_55'],source_manifest=lock['path'],source_manifest_sha256=lock['sha256'],original_54_wrapper_reused=True,no_new_hook=True,target_executed=False,camera_accessed=False)
 p=out/'LINK.json';p.write_text(json.dumps(link,indent=2)+'\n');print(json.dumps(dict(link=row(p),cases=len(cases))))
if __name__=='__main__':main()
