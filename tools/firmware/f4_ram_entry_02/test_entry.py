"""Host-only fault fixtures using verbatim production C functions.

The test library contains no main/launch/proc/device/SDK operation. Its paths,
metadata and original SHA bind a temporary host fixture, never camera paths.
"""
import ctypes
import hashlib
import importlib.util
import json
import multiprocessing
import os
from pathlib import Path
import shutil
import socket
import subprocess
import sys
import tempfile
import threading
import time
import unittest

HERE=Path(__file__).resolve().parent
SPEC=importlib.util.spec_from_file_location('f4_generate02',HERE/'generate.py')
GEN=importlib.util.module_from_spec(SPEC);SPEC.loader.exec_module(GEN)
EXTRACTED=['all_write','hash_fd','plain_fd','file_hash','fsync_dir','runner_check',
           'mutation_lock','restore_core','create_bytes','env_valid','ack']

def extracted_functions(source):
    chunks=[]
    for name in EXTRACTED:
        start=source.index('static int '+name+'(')
        # Every production function starts on a new line. Preserve each span
        # exactly; the next static declaration is not part of this function.
        end=source.find('\nstatic ',start+1)
        if end<0:raise AssertionError('Missing next function boundary')
        chunks.append(source[start:end]+'\n')
    return ''.join(chunks)

def hold_lock(library,ready,release):
    lib=ctypes.CDLL(library);fd=lib.fixture_lock()
    ready.send(fd>=0);release.recv()
    if fd>=0:os.close(fd)

class CFixtures(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.tmp=tempfile.TemporaryDirectory(prefix='iq4_f4_ram02_host_')
        cls.root=Path(cls.tmp.name)
        cls.state=cls.root/'state';cls.scripts=cls.root/'scripts'
        cls.original=b'original runner host fixture\n'
        cls.candidate=b'modified runner host fixture\n'
        assert len(cls.original)==len(cls.candidate)
        source=(HERE/'entry.c').read_text()
        selected=extracted_functions(source)
        cls.selected_sha=hashlib.sha256(selected.encode()).hexdigest()
        config={
            'F4_STATE':str(cls.state),'F4_SCRIPT_DIR':str(cls.scripts),
            'F4_RUNNER':str(cls.scripts/'runner'),
            'F4_ORIGINAL':str(cls.scripts/'original'),
            'F4_RUNNER_SHA':hashlib.sha256(cls.original).hexdigest(),
            'F4_CANDIDATE_SHA':hashlib.sha256(cls.candidate).hexdigest(),
        }
        headers='''#include <errno.h>
#include <fcntl.h>
#include <poll.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/file.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/xattr.h>
#include <unistd.h>
#include "sha256.h"
#ifdef __APPLE__
/* macOS attaches protected provenance even after xattr -c. Only that host
 * platform attribute is excluded by this syscall fixture; foreign attrs
 * remain visible. Production Linux flistxattr is unchanged. */
static ssize_t host_flistxattr(int fd,void *buf,size_t len){
 (void)buf;(void)len;char names[4096];ssize_t n=flistxattr(fd,names,sizeof(names),0);
 if(n<0)return n;ssize_t remaining=0;
 for(size_t i=0;i<(size_t)n;){size_t z=strnlen(names+i,(size_t)n-i);if(z==(size_t)n-i)return -1;if(strcmp(names+i,"com.apple.provenance"))remaining+=(ssize_t)z+1;i+=z+1;}
 return remaining;
}
#define flistxattr(fd,buf,len) host_flistxattr(fd,buf,len)
#endif
static unsigned long long fixture_inode;
static int fixture_major,fixture_minor;
#define F4_RUNNER_INODE fixture_inode
#define F4_RUNNER_MAJOR fixture_major
#define F4_RUNNER_MINOR fixture_minor
#define S_PATH(name) F4_STATE "/" name
'''
        headers+='\n'.join('#define '+k+' '+json.dumps(v) for k,v in config.items())+'\n'
        headers+=f'#define F4_OWNER_UID {os.getuid()}\n#define F4_OWNER_GID {os.getgid()}\n#define F4_RUNNER_SIZE {len(cls.original)}ULL\n'
        exports='''
int fixture_init(void){struct stat s;if(stat(F4_RUNNER,&s))return 0;fixture_inode=s.st_ino;fixture_major=major(s.st_dev);fixture_minor=minor(s.st_dev);return 1;}
int fixture_restore(void){int fd=mutation_lock();if(fd<0)return -1;int okay=restore_core();close(fd);return okay;}
int fixture_lock(void){return mutation_lock();}
int fixture_original(void){return file_hash(F4_RUNNER,F4_RUNNER_SHA,0755,F4_RUNNER_SIZE);}
int fixture_env(const char *p,size_t n){return env_valid(p,n);}
int fixture_ack(int fd){return ack(fd,"F4L2\\n");}
int fixture_create(const char *p,const char *b,size_t n){return create_bytes(p,b,n,0600);}
int fixture_hash(const char *p,char *out,uint64_t limit){int fd=open(p,O_RDONLY|O_NOFOLLOW);if(fd<0)return 0;int okay=hash_fd(fd,out,limit);close(fd);return okay;}
'''
        harness=cls.root/'harness.c';harness.write_text(headers+selected+exports)
        cls.library=cls.root/('fixture.dylib' if sys.platform=='darwin' else 'fixture.so')
        subprocess.run(['cc','-std=c11','-D_GNU_SOURCE','-O1','-g','-shared','-fPIC',
                        '-Wall','-Wextra','-Werror','-I'+str(HERE),str(harness),'-o',str(cls.library)],check=True)
        cls.lib=ctypes.CDLL(str(cls.library))
        cls.lib.fixture_env.argtypes=[ctypes.c_char_p,ctypes.c_size_t]
        cls.lib.fixture_hash.argtypes=[ctypes.c_char_p,ctypes.c_void_p,ctypes.c_uint64]
        cls.lib.fixture_create.argtypes=[ctypes.c_char_p,ctypes.c_char_p,ctypes.c_size_t]

    @classmethod
    def tearDownClass(cls):cls.tmp.cleanup()

    def setUp(self):
        for p in [self.state,self.scripts]:
            if p.exists():shutil.rmtree(p)
            p.mkdir(mode=0o700)
        self.runner=self.scripts/'runner';self.backup=self.scripts/'original'
        self.runner.write_bytes(self.original);self.runner.chmod(0o755)
        self.no_xattrs(self.runner)
        self.assertEqual(self.lib.fixture_init(),1)

    def no_xattrs(self,path):
        if sys.platform=='darwin':subprocess.run(['xattr','-c',str(path)],check=True)

    def armed(self):
        os.link(self.runner,self.backup)
        p=self.scripts/'candidate';p.write_bytes(self.candidate);p.chmod(0o755)
        self.no_xattrs(p)
        os.replace(p,self.runner)

    def test_original_idempotent(self):
        inode=self.runner.stat().st_ino
        self.assertEqual(self.lib.fixture_original(),1)
        self.assertEqual(self.lib.fixture_restore(),1)
        self.assertEqual(self.lib.fixture_restore(),1)
        self.assertEqual(self.runner.stat().st_ino,inode)

    def test_restore_preserves_original_inode_and_open_fd(self):
        inode=self.runner.stat().st_ino
        with self.runner.open('rb') as opened:
            self.armed();self.assertNotEqual(self.runner.stat().st_ino,inode)
            self.assertEqual(self.lib.fixture_restore(),1)
            self.assertEqual(self.runner.stat().st_ino,inode)
            self.assertEqual(opened.read(),self.original)
        self.assertFalse(self.backup.exists())

    def test_unknown_runner_is_never_overwritten(self):
        self.armed();self.runner.write_bytes(b'x'*len(self.candidate))
        before=self.runner.read_bytes()
        self.assertEqual(self.lib.fixture_restore(),0)
        self.assertEqual(self.runner.read_bytes(),before)
        self.assertTrue(self.backup.exists())

    def test_missing_backup_refuses_retains_candidate(self):
        self.armed();self.backup.unlink()
        self.assertEqual(self.lib.fixture_restore(),0)
        self.assertEqual(self.runner.read_bytes(),self.candidate)

    def test_wrong_backup_inode_refuses(self):
        self.armed();os.link(self.backup,self.scripts/'retained_inode');self.backup.unlink();self.backup.write_bytes(self.original);self.backup.chmod(0o755);self.no_xattrs(self.backup)
        self.assertEqual(self.lib.fixture_restore(),0)
        self.assertEqual(self.runner.read_bytes(),self.candidate)

    def test_wrong_permissions_refuse(self):
        self.armed();self.backup.chmod(0o700)
        self.assertEqual(self.lib.fixture_restore(),0)

    @unittest.skipUnless(sys.platform=='darwin','Host xattr fixture uses macOS xattr CLI')
    def test_extended_attributes_refuse(self):
        self.armed();subprocess.run(['xattr','-w','iq4.test','foreign',str(self.backup)],check=True)
        self.assertEqual(self.lib.fixture_restore(),0)

    def test_symlink_runner_refuses(self):
        self.armed();self.runner.unlink();self.runner.symlink_to(self.backup)
        self.assertEqual(self.lib.fixture_restore(),0)
        self.assertTrue(self.runner.is_symlink())

    def test_mutation_lock_blocks_concurrent_process(self):
        ctx=multiprocessing.get_context('spawn');recv,send=ctx.Pipe(False);release,done=ctx.Pipe(False)
        p=ctx.Process(target=hold_lock,args=(str(self.library),send,release));p.start()
        self.assertTrue(recv.poll(5));self.assertTrue(recv.recv())
        self.assertEqual(self.lib.fixture_restore(),-1)
        done.send(True);p.join(5);self.assertEqual(p.exitcode,0)
        self.assertEqual(self.lib.fixture_restore(),1)

    def test_exclusive_creation_retains_existing(self):
        p=self.state/'artifact';name=os.fsencode(p)
        self.assertEqual(self.lib.fixture_create(name,b'first',5),1)
        self.assertEqual(self.lib.fixture_create(name,b'wrong',5),0)
        self.assertEqual(p.read_bytes(),b'first')
        self.assertEqual(p.stat().st_mode&0o7777,0o600)

    def test_sha_vectors_and_extent_guard(self):
        for data in [b'',b'abc',b'a'*55,b'a'*56,b'a'*64,b'a'*1000000]:
            p=self.state/'hash';p.write_bytes(data);out=ctypes.create_string_buffer(65)
            self.assertEqual(self.lib.fixture_hash(os.fsencode(p),out,len(data)),1)
            self.assertEqual(out.value.decode(),hashlib.sha256(data).hexdigest())
            if data:self.assertEqual(self.lib.fixture_hash(os.fsencode(p),out,len(data)-1),0)

    def test_private_environment_accepts_and_rejects(self):
        good=b'PATH=/bin:/usr/bin\x00HOME=/root\x00EMPTY=\x00'
        self.assertEqual(self.lib.fixture_env(good,len(good)),1)
        for b in [b'',b'A=x',b'=x\x00',b'1A=x\x00',b'A=x\x00A=y\x00',b'LD_PRELOAD=x\x00',b'A=x\x00\x00',b'A=x\x00'*257,b'A='+b'x'*16384+b'\x00']:
            self.assertEqual(self.lib.fixture_env(b,len(b)),0,repr(b[:80]))

    def test_exact_ipc_ack_and_wrong_span_rejected(self):
        for answer,expected in [(b'F4OK2\n',1),(b'F4OK2\nX',0),(b'WRONG\n',0),(b'x'*64,0)]:
            a,b=socket.socketpair(socket.AF_UNIX,socket.SOCK_DGRAM)
            a.setblocking(False);b.settimeout(2);got=[]
            def receiver():
                got.append(b.recv(16));b.send(answer)
            worker=threading.Thread(target=receiver);worker.start()
            try:self.assertEqual(self.lib.fixture_ack(a.fileno()),expected)
            finally:worker.join(3);a.close();b.close()
            self.assertEqual(got,[b'F4L2\n']);self.assertFalse(worker.is_alive())

class PlanGuards(unittest.TestCase):
    def test_preview_has_no_commands(self):self.assertEqual(GEN.stage_plan({},False)['commands'],[])

    def blobs(self):
        entry=b'public host synthetic ELF fixture'
        return {'entrytool':entry,'marker.so':b'public marker','entry.sha256':(GEN.sha(entry)+'\n').encode(),'install.sh':b'public script','disable.sh':b'public script'}

    def test_finite_plan_bound_and_private_paths(self):
        p=GEN.stage_plan(self.blobs(),True)
        self.assertTrue(p['only_public_build_artifacts_no_device_credentials'])
        for c in p['commands']:
            text=c['text'];self.assertLessEqual(len(text.encode()),242)
            self.assertNotIn('=',text);self.assertNotIn('\x00',text);self.assertNotIn('\n',text)
            self.assertIn('/run/iq4_f4_entry02',text)

    def test_all_binary_values_survive_frozen_lexers_and_format(self):
        sys.path.insert(0,str(HERE.parent/'sys_exact16_argv_01'))
        from native_lexer_model import finite_native_shell_line, format_octal_only
        b=self.blobs();b['marker.so']=bytes(range(256));plan=GEN.stage_plan(b,True)
        output=[]
        for c in plan['commands']:
            text=c['text']
            if c['role']!='append_fixed_owned_public_artifact' or not text.endswith('/marker.so"'):continue
            parsed=finite_native_shell_line(text.encode())
            self.assertEqual(parsed.tokens[0:2],(b'Sys',b'printf'))
            token=parsed.tokens[2];self.assertEqual(token[:1],b"'");self.assertEqual(token[-1:],b"'")
            output.append(format_octal_only(token[1:-1]))
        self.assertEqual(b''.join(output),bytes(range(256)))

    def test_extra_name_missing_name_wrong_digest_refuse(self):
        for mutation in ['extra','missing','digest','empty']:
            b=self.blobs()
            if mutation=='extra':b['arbitrary']=b'no'
            elif mutation=='missing':b.pop('marker.so')
            elif mutation=='empty':b['entrytool']=b''
            else:b['entry.sha256']=b'0'*64+b'\n'
            with self.assertRaises(ValueError):GEN.stage_plan(b,True)

    def test_actual_gates_refuse_false_missing_or_wrong_types(self):
        base={k:True for k in GEN.REQUIRED};base['schema']='iq4_f4_ram_gate_v2';base['profile']='RAM_marker_once'
        for k in GEN.REQUIRED:
            for value in [False,None,1,'true']:
                p=dict(base);p[k]=value
                with self.assertRaises(ValueError):GEN.validate_proof(p,b'',b'',lambda _:b'')
        with self.assertRaises(ValueError):GEN.validate_proof({},b'',b'',lambda _:b'')

    def test_RAM_scope_validates_identity_without_reading_User_original(self):
        sys.path.insert(0,str(HERE.parent));from inspect_boot import Ext2
        runner={n['path']:b for n,b in Ext2((GEN.ROOT/'analysis/firmware/P1_ramdisk.ext2').read_bytes()).walk()}['/p1/scripts/boot_run_p1linux.sh']
        receipt=b'host synthetic gate parser fixture; not actual hardware evidence\n'
        p={k:True for k in GEN.REQUIRED}
        p.update(schema='iq4_f4_ram_gate_v2',profile='RAM_marker_once',camera_operator='root_windows_unique_executor',
          runner={'sha256':GEN.RUNNER_SHA,'size':5105,'uid':0,'gid':0,'mode':493,'major':1,'minor':0,'xattrs':[],'inode':2347,'nlink':1},
          user={'sha256':GEN.USER_SHA,'size':11874544,'uid':0,'gid':0,'mode':493,'canonical_path':'/mnt/qspi/User/p1linux','argv0':'/run/media/storage/User/p1linux','argv_tail':[],'pid':42,'start_ticks':123,'umask':18,'parent_ppid':1,'parent_exe':'/bin/busybox.nosuid','parent_argv':['/bin/sh','/p1/scripts/boot_run_p1linux.sh']},
          mount={'root_source':'/dev/ram0','root_fstype':'ext4','root_major':1,'root_minor':0,'cmdline_root':'/dev/ram0','run_fstype':'tmpfs','run_major':0,'run_minor':10,'root_mount_id':2,'run_mount_id':10},
          actual_absent_paths=['/run/f4launch','/run/iq4_f4_entry02','/p1/scripts/.iq4_f4_original02','/p1/scripts/.iq4_f4_candidate02'],
          receipts={k:{'path':'synthetic-fixture.json','sha256':GEN.sha(receipt)} for k in GEN.REQUIRED})
        self.assertIs(GEN.validate_proof(p,runner,runner,lambda _:receipt),p)
        with self.assertRaises(ValueError):GEN.validate_proof(p,runner,runner,lambda _:b'changed')
        p['runner']['uid']=False
        with self.assertRaises(ValueError):GEN.validate_proof(p,runner,runner,lambda _:receipt)

    def test_source_restore_precedes_exec_and_no_signal_apis(self):
        source=(HERE/'entry.c').read_text();launch=source.split('static int launch(void){')[1].split('\nstatic ')[0]
        self.assertLess(launch.index('if(!restore())'),launch.index('execve('))
        self.assertIn('MSG_NOSIGNAL',(HERE/'marker.c').read_text())
        for forbidden in ['kill(','raise(','ptrace(','system(','popen(','execvp(','dlopen(','ioctl(']:
            self.assertNotIn(forbidden,source)
        self.assertIn('if(!F4_ENABLED)return fail(',source)

if __name__=='__main__':unittest.main()
