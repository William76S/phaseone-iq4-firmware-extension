#!/usr/bin/env python3
from pathlib import Path
import argparse,subprocess,json,hashlib
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent

def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists();out.mkdir(parents=True);cmds=[]
 def run(argv):
  q=subprocess.run(list(map(str,argv)),cwd=ROOT,capture_output=True,text=True);cmds.append(dict(argv=list(map(str,argv)),exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(out/'COMMANDS.json').write_text(json.dumps(cmds,indent=2)+'\n');assert q.returncode==0,q.stderr;return q.stdout.strip()
 sdk=run(['/usr/bin/xcrun','--show-sdk-path']);cc='/Library/Developer/CommandLineTools/usr/bin/clang';base=ROOT/'tools/firmware/f3_stream_export_04'
 sources=[HERE/'test_capacity.c',base/'stream_export.c',base/'jpeg_export.c',ROOT/'src/codec/stream_rgb32.c',ROOT/'src/codec/export_pixels.c',ROOT/'src/codec/export_geometry.c']
 tests=[]
 for name,flags,lib in [('old',['-DIQ4_OLD_CAPACITY_COUNTEREXAMPLE'],'libjpeg8'),('new',['-include',HERE/'limits.h'],'libjpeg8'),('san',['-include',HERE/'limits.h','-fsanitize=address,undefined','-fno-omit-frame-pointer'],'libjpeg8_sanitized')]:
  exe=out/('capacity_'+name);run([cc,'-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror',*flags,*sources,ROOT/('evidence/codec/build/'+lib+'/.libs/libjpeg.a'),'-o',exe]);tests.append(dict(name=name,stdout=run([exe])))
 spec=json.loads((ROOT/'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_JPEG_DEV_02.json').read_text());objects=[]
 targets=[o for o in spec['objects']if o['path'].endswith('/stream.o')or o['path'].endswith('/stream_export.o')or o['path'].endswith('/coordinator.o')]
 assert len(targets)==2,targets
 for target in targets:
  old=ROOT/target['path'];data=json.loads((old.parent/'COMMANDS.json').read_text());data=data.get('commands',[])if isinstance(data,dict)else data
  calls=[x['argv']for x in data if '-c'in x.get('argv',[])and '-o'in x['argv']and Path(x['argv'][x['argv'].index('-o')+1]).resolve()==old.resolve()]
  assert len(calls)==1,(old,len(calls));argv=calls[0][:];new=out/old.name;argv[argv.index('-o')+1]=str(new)
  if '-MF'in argv:argv[argv.index('-MF')+1]=str(new)+'.d'
  argv[argv.index('-c'):argv.index('-c')]=['-include',str(HERE/'limits.h')];run(argv);objects.append(dict(replaces=target,replacement=row(new)))
 (out/'BUILD.json').write_text(json.dumps(dict(objects=objects,tests=tests,limit=1073741824,file_ceiling_only=True,no_full_packet_allocation=True,target_executed=False),indent=2)+'\n');print(json.dumps(objects,indent=2))
if __name__=='__main__':main()
