#!/usr/bin/env python3
"""Bounded native-menu fixtures, exact A64 objects and locked LINK input."""
from pathlib import Path
import argparse
import hashlib
import json
import shlex
import subprocess

ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
BASE=ROOT/'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_22.json'

def row(p):
    p=p.resolve()
    assert p.is_relative_to(ROOT),p
    b=p.read_bytes()
    return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())

def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('--output',type=Path,required=True)
    a=ap.parse_args()
    out=a.output.resolve()
    assert out.is_relative_to(ROOT) and not out.exists()
    assert row(BASE)['sha256']=='89e55e72db5f8746ba41f0fa9bb5c01012ab9cceeaddc06ba437950217fb1cfd'
    base=json.loads(BASE.read_text())
    exact=json.loads((HERE/'EXACT.json').read_text())
    assert row(ROOT/exact['stock']['path'])==exact['stock']
    compiler=ROOT/base['compiler']['path']
    assert row(compiler)==base['compiler']
    out.mkdir(parents=True)
    commands=[]
    def run(argv,label):
        argv=list(map(str,argv))
        r=subprocess.run(argv,cwd=ROOT,capture_output=True,text=True)
        commands.append(dict(label=label,argv=argv,exit=r.returncode,stdout=r.stdout,stderr=r.stderr))
        (out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
        assert r.returncode==0,(label,r.stderr)
        return r.stdout
    cases=[[],[['stage']][0],['pin'],['title'],['ui'],['list']]
    cases.extend([kind,str(n)] for kind in ['alloc','ctor','append'] for n in range(1,9))
    for kind,extra in [('normal',[]),('san',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
        exe=out/('test_'+kind)
        run(['/usr/bin/clang','-std=c11','-O1','-Wall','-Wextra','-Werror',*extra,
            HERE/'test_menu.c','-o',exe],'compile_'+kind)
        for args in cases: run([exe,*args],kind+'_'+('_'.join(args)or'baseline'))
    objects=[]
    for source,name in [('menu.c','menu.o'),('wrapper.S','wrapper.o')]:
        flags=base['C_flags'] if source.endswith('.c') else [
            '-target','aarch64-linux-gnu.2.28','-g0','-fPIC','-funwind-tables']
        run([compiler,'cc',*flags,'-MMD','-MF',out/(name+'.d'),'-c',HERE/source,
            '-o',out/name],name)
        objects.append(row(out/name))
        dump=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',out/name],name+'_inspect')
        (out/(name+'.asm')).write_text(dump)
        run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',out/name],name+'_undefined')
    target_headers={}
    for name in ['menu.o','wrapper.o']:
        dep=(out/(name+'.d')).read_text().replace('\\\n',' ')
        for s in shlex.split(dep.split(':',1)[1]):
            p=Path(s)
            if not p.is_absolute(): p=ROOT/p
            if p.suffix in ['.h','.inc']:
                target_headers[str(p.resolve())]=row(p)
    manifest=out/'SOURCE_SHA256.json'
    members=[row(HERE/name) for name in ['menu.c','wrapper.S','test_menu.c',
        'collect.py','build.py','pins.h','EXACT.json','HISTORICAL_ABI.json','README.md']]
    assert not any('f3_capture_menu_' in r['path'] or 'f3_completion_diagnostics_' in r['path']
        for r in members+list(target_headers.values()))
    manifest.write_text(json.dumps(dict(schema='iq4_stock_jpeg_menu_sources_01',
        members=members,target_header_closure=list(target_headers.values()),
        compiler=row(compiler),baseline_inputs=row(BASE),exact_original=row(HERE/'EXACT.json'),
        target_objects=objects,commands=row(out/'COMMANDS.json'),
        camera_accessed=False,target_executed=False),indent=2)+'\n')
    link=dict(schema='iq4_stock_jpeg_menu_link_01',objects=objects,aliases=[],
        BL_hooks=[exact['BL_hook']],auxiliary_hooks=[],
        required_functions=['iq4_stock_jpeg_after_menu_append_01'],
        source_manifest=str(manifest.relative_to(ROOT)),source_manifest_sha256=row(manifest)['sha256'],
        stock_size_child_unchanged=True,old_F3_menu_dependency=False,
        target_executed=False,camera_accessed=False)
    (out/'LINK.json').write_text(json.dumps(link,indent=2)+'\n')
    report=dict(schema='iq4_stock_jpeg_menu_build_01',objects=objects,source_manifest=row(manifest),
        link=row(out/'LINK.json'),commands=row(out/'COMMANDS.json'),normal_cases=len(cases),
        ASan_UBSan_cases=len(cases),original_JPEG_size_child_untouched_in_fixtures=True,
        enum_mapping_and_selected_verified=True,no_attachment_after_construction_failure=True,
        partial_append_ownership_retained=True,busy_and_wrong_UI_rejected=True,
        target_executed=False,camera_accessed=False,hardware_accepted=False)
    (out/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(dict(build=row(out/'BUILD.json'),link=row(out/'LINK.json'),
        manifest=row(manifest),objects=objects)))

if __name__=='__main__': main()
