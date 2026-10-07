#!/usr/bin/env python3
from pathlib import Path
import argparse,hashlib,json,shlex,subprocess
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
BASE=ROOT/'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_22.json'
def row(p):
    p=p.resolve();assert p.is_relative_to(ROOT),p;b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
    ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve()
    assert out.is_relative_to(ROOT) and not out.exists();out.mkdir(parents=True)
    assert row(BASE)['sha256']=='89e55e72db5f8746ba41f0fa9bb5c01012ab9cceeaddc06ba437950217fb1cfd'
    base=json.loads(BASE.read_text());compiler=ROOT/base['compiler']['path'];assert row(compiler)==base['compiler']
    exact=json.loads((HERE/'EXACT.json').read_text());assert row(ROOT/exact['stock']['path'])==exact['stock'];commands=[];objects=[]
    def run(argv,label):
        argv=list(map(str,argv));r=subprocess.run(argv,cwd=ROOT,capture_output=True,text=True);commands.append(dict(label=label,argv=argv,exit=r.returncode,stdout=r.stdout,stderr=r.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert r.returncode==0,(label,r.stderr,r.stdout);return r.stdout
    cases=[[],['stage'],['pin'],['title'],['ui'],['dto']]
    cases.extend([kind,str(i)]for kind,n in [('alloc',4),('ctor',4),('append',3)]for i in range(1,n+1))
    for kind,extra in [('normal',[]),('san',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
        exe=out/('test_'+kind);run(['/usr/bin/clang','-std=c11','-O1','-Wall','-Wextra','-Werror',*extra,HERE/'test_menu.c','-o',exe],'compile_'+kind)
        for args in cases:run([exe,*args],kind+'_'+('_'.join(args)or'baseline'))
    for source,name in [('menu.c','menu.o'),('wrapper.S','wrapper.o')]:
        flags=base['C_flags']if source.endswith('.c')else['-target','aarch64-linux-gnu.2.28','-g0','-fPIC','-funwind-tables']
        run([compiler,'cc',*flags,'-MMD','-MF',out/(name+'.d'),'-c',HERE/source,'-o',out/name],name);objects.append(row(out/name))
        (out/(name+'.asm')).write_text(run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',out/name],name+'_inspect'))
        run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',out/name],name+'_undefined')
    run([ROOT/'build/dual-exposure-host-venv/bin/python',HERE/'prove_wrapper.py','--build',out],'actual_A64_before_append_after')
    (out/'wrapper.eh_frame.txt').write_text(run(['/Library/Developer/CommandLineTools/usr/bin/llvm-dwarfdump','--eh-frame',out/'wrapper.o'],'unwind_CFA_inspect'))
    headers={}
    for name in ['menu.o','wrapper.o']:
        dep=(out/(name+'.d')).read_text().replace('\\\n',' ')
        for s in shlex.split(dep.split(':',1)[1]):
            p=Path(s);p=p if p.is_absolute()else ROOT/p
            if p.suffix in ['.h','.inc']:headers[str(p.resolve())]=row(p)
    manifest=out/'SOURCE_SHA256.json';manifest.write_text(json.dumps(dict(schema='iq4_stock_half_menu_sources_02',
        members=[row(p)for p in sorted(HERE.iterdir())if p.is_file()],target_header_closure=list(headers.values()),
        baseline=row(BASE),compiler=row(compiler),stock=exact['stock'],objects=objects,commands=row(out/'COMMANDS.json'),
        A64_proof=row(out/'A64_WRAPPER.json'),producer_definition_linked=False,target_executed=False,camera_accessed=False),indent=2)+'\n')
    link=dict(schema='iq4_stock_half_menu_link_02',objects=objects,aliases=exact['aliases'],BL_hooks=[exact['BL_hook']],auxiliary_hooks=[],
        required_functions=['iq4_stock_jpeg_size_child_02','iq4_stock_jpeg_after_menu_append_01','iq4_stock_jpeg_extended_size_get_02','iq4_stock_jpeg_extended_size_set_02','iq4_stock_jpeg_quality_get_02'],
        source_manifest=str(manifest.relative_to(ROOT)),source_manifest_sha256=row(manifest)['sha256'],
        removes_objects=[exact['excludes_52_wrapper_object']],reuses_objects=[exact['reuses_52_export_menu_object']],replaces_BL_sites=[0x4f0528],
        original_size_position_replaced=True,original_size_DTO_unchanged=True,native_enum2_used=False,
        requires_real_53_producer=True,producer_definition_linked=False,target_executed=False,camera_accessed=False)
    (out/'LINK.json').write_text(json.dumps(link,indent=2)+'\n')
    result=dict(schema='iq4_stock_half_menu_build_02',objects=objects,manifest=row(manifest),link=row(out/'LINK.json'),
        normal_cases=len(cases),ASan_UBSan_cases=len(cases),A64_wrapper_cases=2,
        selected_from_real_API_only=True,setter_rejection_does_not_publish_fake_choice=True,
        quality_display_from_real_getter=True,quality_read_only=True,production_quality_target=100,
        host_producer_state_is_fixture=True,producer_definition_linked=False,
        target_executed=False,camera_accessed=False,hardware_accepted=False)
    (out/'BUILD.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(dict(build=row(out/'BUILD.json'),link=row(out/'LINK.json'),manifest=row(manifest),objects=objects)))
if __name__=='__main__':main()
