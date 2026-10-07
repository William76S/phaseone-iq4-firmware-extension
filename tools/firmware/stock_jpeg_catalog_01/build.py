#!/usr/bin/env python3
from pathlib import Path
import argparse,hashlib,json,shlex,subprocess
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
BASE=ROOT/'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_22.json'
def row(p):
    p=p.resolve();assert p.is_relative_to(ROOT);b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
    ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve()
    assert out.is_relative_to(ROOT) and not out.exists();out.mkdir(parents=True)
    assert row(BASE)['sha256']=='89e55e72db5f8746ba41f0fa9bb5c01012ab9cceeaddc06ba437950217fb1cfd'
    base=json.loads(BASE.read_text());compiler=ROOT/base['compiler']['path'];assert row(compiler)==base['compiler']
    exact=json.loads((HERE/'EXACT.json').read_text());assert row(ROOT/exact['stock']['path'])==exact['stock'];commands=[];objects=[]
    def run(argv,label):
        argv=list(map(str,argv));r=subprocess.run(argv,cwd=ROOT,capture_output=True,text=True);commands.append(dict(label=label,argv=argv,exit=r.returncode,stdout=r.stdout,stderr=r.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert r.returncode==0,(label,r.stderr,r.stdout);return r.stdout
    for src,name in [('select.c','select.o'),('wrappers.S','wrappers.o')]:
        flags=base['C_flags'] if src.endswith('.c') else ['-target','aarch64-linux-gnu.2.28','-g0','-fPIC','-funwind-tables']
        run([compiler,'cc',*flags,'-MMD','-MF',out/(name+'.d'),'-c',HERE/src,'-o',out/name],name);objects.append(row(out/name))
        (out/(name+'.asm')).write_text(run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',out/name],name+'_inspect'))
        run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',out/name],name+'_undefined')
    run([ROOT/'build/dual-exposure-host-venv/bin/python',HERE/'prove.py','--build',out],'actual_A64_native_selection')
    (out/'wrappers.eh_frame.txt').write_text(run(['/Library/Developer/CommandLineTools/usr/bin/llvm-dwarfdump','--eh-frame',out/'wrappers.o'],'native_parent_CFA_inspect'))
    headers={}
    for name in ['select.o','wrappers.o']:
        dep=(out/(name+'.d')).read_text().replace('\\\n',' ')
        for s in shlex.split(dep.split(':',1)[1]):
            p=Path(s);p=p if p.is_absolute() else ROOT/p
            if p.suffix in ['.h','.inc']:headers[str(p.resolve())]=row(p)
    members=[row(p) for p in sorted(HERE.iterdir()) if p.is_file()]
    manifest=out/'SOURCE_SHA256.json';manifest.write_text(json.dumps(dict(schema='iq4_stock_jpeg_catalog_sources_01',members=members,target_header_closure=list(headers.values()),compiler=row(compiler),baseline=row(BASE),stock=exact['stock'],objects=objects,A64_proof=row(out/'A64_SELECTION.json'),commands=row(out/'COMMANDS.json'),camera_accessed=False,target_executed=False),indent=2)+'\n')
    link=dict(schema='iq4_stock_jpeg_catalog_link_01',objects=objects,aliases=exact['aliases'],BL_hooks=[],auxiliary_hooks=exact['auxiliary_hooks'],required_functions=['iq4_stock_jpeg_catalog_select_01'],source_manifest=str(manifest.relative_to(ROOT)),source_manifest_sha256=row(manifest)['sha256'],camera_accessed=False,target_executed=False)
    (out/'LINK.json').write_text(json.dumps(link,indent=2)+'\n')
    result=dict(schema='iq4_stock_jpeg_catalog_build_01',objects=objects,source_manifest=row(manifest),link=row(out/'LINK.json'),A64_proof=row(out/'A64_SELECTION.json'),actual_A64_native_selector_cases=6,destination_set_rescan_supplied_by_core=True,completion_bit_changed_in_this_component=False,file_enumeration_executed_in_proof=False,target_executed=False,camera_accessed=False,hardware_accepted=False)
    (out/'BUILD.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(dict(build=row(out/'BUILD.json'),link=row(out/'LINK.json'),manifest=row(manifest),objects=objects)))
if __name__=='__main__':main()
