#!/usr/bin/env python3
"""Host scratch files only. Cross build is inspected, never executed."""
import hashlib,json,os,pathlib,subprocess,tempfile
ROOT=pathlib.Path(__file__).resolve().parents[3]
HERE=pathlib.Path(__file__).resolve().parent
OUT=ROOT/'analysis/sdk_reference/f1_scratch_restore_probe_host_01'
def main():
    OUT.mkdir(parents=True,exist_ok=False);commands=[]
    def run(args,env=None):
        args=list(map(str,args));commands.append(args)
        return subprocess.run(args,cwd=ROOT,env=env,capture_output=True,text=True)
    host=OUT/'probe_host'
    p=run(['/usr/bin/clang','-std=c11','-O2','-Wall','-Wextra','-Werror','-DF1_SCRATCH_HOST_FIXTURE',HERE/'probe.c','-o',host])
    assert p.returncode==0,p.stderr
    results=[]
    with tempfile.TemporaryDirectory(prefix='iq4-f1-scratch-host-') as tmp:
        parent=pathlib.Path(tmp);parent.chmod(0o700);s=parent.stat()
        env=dict(os.environ,IQ4_F1_HOST_FIXTURE_PARENT=str(parent))
        base=[host,'--run-scratch',os.major(s.st_dev),os.minor(s.st_dev),s.st_ino]
        for label,args,expected in [('default_off',[host],0),('bad_nonce',base+['bad'],2),('wrong_parent_inode',[host,'--run-scratch',os.major(s.st_dev),os.minor(s.st_dev),s.st_ino+1,'0123456789ab'],2)]:
            p=run(args,env);assert p.returncode==expected,(label,p.stdout,p.stderr)
            assert not list(parent.iterdir());results.append({'case':label,'exit':p.returncode,'stdout':p.stdout})
        conflict=parent/'.iq4_f1_scratch01_0123456789ab';conflict.write_bytes(b'foreign marker, preserve\n')
        p=run(base+['0123456789ab'],env);assert p.returncode==2 and conflict.read_bytes()==b'foreign marker, preserve\n'
        conflict.unlink();results.append({'case':'existing_foreign_path_refused_preserved','exit':p.returncode,'stdout':p.stdout})
        p=run(base+['fedcba987654'],env);assert p.returncode==0,(p.stdout,p.stderr)
        j=json.loads(p.stdout);assert j['same_fs_restore_exact_inode_and_bytes'] and j['cleanup_complete'] and not list(parent.iterdir())
        results.append({'case':'scratch_hardlink_rename_file_directory_fsync_original_inode_restore_cleanup','exit':p.returncode,'stdout':p.stdout})
    lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_bytes())
    zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
    assert hashlib.sha256(zig.read_bytes()).hexdigest()==lock['zig_binary_sha256']
    target=OUT/'iq4_f1_scratch_probe_aarch64'
    p=run([zig,'cc','-target',lock['target'],'-std=c11','-O2','-Wall','-Wextra','-Werror','-fPIE','-pie',HERE/'probe.c','-o',target])
    assert p.returncode==0,p.stderr
    b=target.read_bytes();assert b[:6]==b'\x7fELF\x02\x01' and int.from_bytes(b[18:20],'little')==183
    r={'action':'F1_scratch_probe_host_fixtures_and_target_cross_compile_only','host_cases':results,'commands':commands,'source_sha256':hashlib.sha256((HERE/'probe.c').read_bytes()).hexdigest(),'target':{'path':str(target.relative_to(ROOT)),'bytes':len(b),'sha256':hashlib.sha256(b).hexdigest(),'AArch64_ELF':True,'executed':False},'host_scratch_only':True,'actual_camera_access':False,'actual_recovery_gate':False,'SDK_started':False,'installer_emitted':False}
    (OUT/'VALIDATION.json').write_text(json.dumps(r,indent=2)+'\n')
    print(json.dumps({'host_cases':len(results),'target':r['target'],'actual_camera_gate':False}))
if __name__=='__main__':main()
