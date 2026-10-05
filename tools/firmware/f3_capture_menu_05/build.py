#!/usr/bin/env python3
import argparse,difflib,hashlib,importlib.util,json,pathlib,subprocess
ROOT=pathlib.Path(__file__).resolve().parents[3];HERE=pathlib.Path(__file__).resolve().parent;OLD=ROOT/'tools/firmware/f3_capture_menu_04'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';ZSHA='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c';CC='/Library/Developer/CommandLineTools/usr/bin/clang'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def normalize(s):
 return s.replace('../f3_capture_menu_04/menu.h','menu.h').replace('../f3_capture_menu_04/policy.h','policy.h').replace('../f3_capture_menu_04/code_pins.h','code_pins.h').replace('"JPEG (SD only)","RAW + JPEG (SD only)"','"JPEG","RAW + JPEG"').replace('v.requested_mode==F3_JPEG_ONLY&&!v.raw_removed?"JPEG saved; RAW kept":"JPEG saved"','"JPEG saved"')
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=pathlib.Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists()and row(ZIG)['sha256']==ZSHA
 assert normalize((HERE/'runtime.c').read_text())==(OLD/'runtime.c').read_text();lock=json.loads((OLD/'SOURCE_SHA256.json').read_text());assert all(row(ROOT/x['path'])==x for x in lock['files'])
 out.mkdir(parents=True);commands=[];tests=[]
 def run(argv,kind):
  q=subprocess.run([str(x)for x in argv],cwd=ROOT,text=True,capture_output=True);r=dict(kind=kind,argv=[str(x)for x in argv],exit=q.returncode,stdout=q.stdout,stderr=q.stderr);commands.append(r);(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,r;return q.stdout
 assert run([ZIG,'version'],'compiler_identity').strip()=='0.15.2';sdk=run(['/usr/bin/xcrun','--show-sdk-path'],'host_sdk_identity').strip()
 for variant,extra in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=out/('scope_'+variant);run([CC,'-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror',*extra,HERE/'test_scope.c',OLD/'policy.c',ROOT/'src/codec/export_geometry.c','-o',exe],'own_host_compile');tests.append(dict(variant=variant,stdout=run([exe],'own_host_synthetic_execution')))
 obj=out/'menu.o';run([ZIG,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-Wall','-Wextra','-Werror','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-MMD','-MF',out/'menu.o.d','-c',HERE/'runtime.c','-o',obj],'cross_compile_only')
 spec=importlib.util.spec_from_file_location('inspect_f4',ROOT/'tools/firmware/f4_native_source_02/build.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);ins=m.inspect(obj);old=json.loads((ROOT/'analysis/firmware/f3_capture_menu_build_04/BUILD.json').read_text());oldins=[x for x in old['objects']if pathlib.Path(x['path']).name=='menu.o'];assert len(oldins)==1 and ins['undefined_symbols']==oldins[0]['undefined_symbols']
 s=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',obj],'static_disassembly_only');(out/'menu.o.asm').write_text('\n'.join(x.rstrip()for x in s.splitlines())+'\n')
 (out/'SOURCE_DIFF.patch').write_text(''.join(difflib.unified_diff((OLD/'runtime.c').read_text().splitlines(keepends=True),(HERE/'runtime.c').read_text().splitlines(keepends=True),fromfile='frozen_menu04/runtime.c',tofile='new_menu05/runtime.c')))
 j=dict(schema='iq4_f3_menu05_build',source_inputs=[row(p)for p in sorted(HERE.iterdir())if p.is_file()and p.name!='SOURCE_SHA256.json'],frozen_inputs=[row(OLD/x)for x in ['SOURCE_SHA256.json','LINK_INPUT.json','runtime.c','policy.c','code_pins.h']],objects=[ins],tests=tests,normalized_runtime_identical=True,undefined_symbols_identical=True,only_scope_strings_and_RAW_kept_status_changed=True,camera_access=False,target_executed=False,sdk_loaded=False)
 (out/'BUILD.json').write_text(json.dumps(j,indent=2)+'\n');print(json.dumps(dict(object=row(obj),groups_each=8,target_executed=False),indent=2))
if __name__=='__main__':main()
