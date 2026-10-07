#!/usr/bin/env python3
from pathlib import Path
import json,subprocess,hashlib
R=Path(__file__).resolve().parents[3];D=Path(__file__).resolve().parent;O=R/'analysis/firmware/jpeg_pair_delete_61';B=O/'build';B.mkdir(exist_ok=True);Z=R/'build/toolchains/zig-aarch64-macos-0.15.2/zig';commands=[]
def row(p):return dict(path=str(p.relative_to(R)),bytes=p.stat().st_size,sha256=hashlib.sha256(p.read_bytes()).hexdigest())
def run(args,label):
 args=list(map(str,args));q=subprocess.run(args,cwd=R,capture_output=True,text=True);commands.append(dict(label=label,argv=args,exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(B/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,(label,q.stdout,q.stderr)
run(['python3',D/'collect.py'],'collect')
sdk='/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk'
for name,flags in [('normal',[]),('san',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
 exe=B/('test_'+name);run(['/usr/bin/clang++','-isysroot',sdk,'-isystem',sdk+'/usr/include/c++/v1','-std=c++17','-O1','-Wall','-Wextra','-Werror',*flags,D/'test_pair.cpp','-o',exe],'build_host_'+name);run([exe],'run_host_'+name)
for name,ext in [('pair','cpp'),('wrappers','S')]:
 args=[Z,'c++'if ext=='cpp'else'cc','-target','aarch64-linux-gnu.2.28','-Os','-g0','-fPIC','-ffreestanding','-mno-outline-atomics','-funwind-tables','-fno-stack-protector'];
 if ext=='cpp':args+=['-std=c++17','-fexceptions','-fno-rtti','-Wall','-Wextra','-Werror']
 run(args+['-MMD','-MF',B/(name+'.d'),'-c',D/(name+'.'+ext),'-o',B/(name+'.o')],'target_'+name)
(B/'BUILD.json').write_text(json.dumps(dict(objects=[row(B/'pair.o'),row(B/'wrappers.o')],commands=row(B/'COMMANDS.json'),camera_accessed=False),indent=2)+'\n');print('Target pair-delete objects ready')
