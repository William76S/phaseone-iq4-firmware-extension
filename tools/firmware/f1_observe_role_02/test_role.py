"""SDK-free tests of actual derived source/receipt gates and retained restore code."""
import ast,hashlib,importlib.util,json,sys,unittest
from pathlib import Path
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2]
def load(name,path):
 s=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(s);sys.modules[name]=m;s.loader.exec_module(m);return m
M=load('f1_materialize',HERE/'materialize.py');OLD=load('old_entry_tests',ROOT/'tools/firmware/f4_ram_entry_02/test_entry.py');G=load('old_role_gen',ROOT/'tools/firmware/f4_ram_entry_02/generate.py')
C={};exec(M.proof_contract(),C)
class FixedRole(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  sys.path.insert(0,str(ROOT/'tools/firmware'));from inspect_boot import Ext2
  cls.runner={n['path']:b for n,b in Ext2((ROOT/'analysis/firmware/P1_ramdisk.ext2').read_bytes()).walk()}['/p1/scripts/boot_run_p1linux.sh']
 def proof(self):
  receipts={k:{'path':'hostfixture/'+k,'sha256':G.sha(k.encode())}for k in C['REQUIRED']}
  return dict(schema='iq4_f1_observe_role_gate_v2',profile='RAM_F1_observe_once',camera_operator='root_windows_unique_executor',**{k:True for k in C['REQUIRED']},runner=dict(sha256=G.RUNNER_SHA,size=5105,uid=0,gid=0,mode=493,major=1,minor=0,xattrs=[],inode=123,nlink=1),user=dict(sha256=G.USER_SHA,size=11874544,uid=0,gid=0,mode=493,canonical_path='/mnt/qspi/User/p1linux',argv0='/run/media/storage/User/p1linux',argv_tail=[],pid=1234,start_ticks=567,umask=18,parent_ppid=1,parent_exe='/bin/busybox.nosuid',parent_argv=['/bin/sh','/p1/scripts/boot_run_p1linux.sh']),mount=dict(root_source='/dev/ram0',root_fstype='ext2',root_major=1,root_minor=0,cmdline_root='/dev/ram0',run_fstype='tmpfs',run_major=0,run_minor=33,root_mount_id=11,run_mount_id=22),actual_absent_paths=['/run/f1launch','/run/iq4_f1_observe02','/p1/scripts/.iq4_f1_original02','/p1/scripts/.iq4_f1_candidate02'],receipts=receipts)
 def validate(self,p):return C['validate_proof'](p,self.runner,self.runner,lambda s:s.rsplit('/',1)[-1].encode())
 def test_exact_restore_functions_retained(self):
  old=(ROOT/'tools/firmware/f4_ram_entry_02/entry.c').read_text();new=M.derive(old)
  self.assertEqual(OLD.extracted_functions(old),OLD.extracted_functions(new))
 def test_restoration_precedes_connection_and_exec(self):
  new=M.derive((ROOT/'tools/firmware/f4_ram_entry_02/entry.c').read_text());start=new.index('static int launch(');end=new.find('\nstatic ',start+1);body=new[start:end]
  self.assertLess(body.index('restore()'),body.index('module_gate()'));self.assertLess(body.index('restore()'),body.index('connect_control('));self.assertLess(body.index('restore()'),body.index('execve('))
 def test_environment_capacity_and_restore(self):
  new=M.derive((ROOT/'tools/firmware/f4_ram_entry_02/entry.c').read_text());self.assertEqual(new.count('char *env[259]'),2)
  self.assertIn('env[count]=setting;env[count+1]=observe_setting;env[count+2]=NULL;execve(F4_ARGV0,argv,env);env[count]=NULL;',new)
  self.assertIn('sizeof("IQ4_F1_MODULE_ENTRY_01=")-1',new)
  original=['PATH=/bin','HOME=/root'];env=original.copy()+['LD_PRELOAD=/fixed','IQ4_F1_MODULE_ENTRY_01=OBSERVE'];fallback=env[:len(original)];self.assertEqual(fallback,original)
 def test_runner_candidate_matches_actual_new_launcher(self):
  new=M.derive((ROOT/'tools/firmware/f4_ram_entry_02/entry.c').read_text());self.assertNotIn('/run/f4launch',new)
  self.assertIn('    /run/f1launch   ${P1LINUX_ARGS}',new);self.assertIn('#define F4_LAUNCHER "/run/f1launch"',M.config())
 def test_own_new_paths_accepted_only_fixture(self):self.validate(self.proof())
 def test_every_actual_receipt_required(self):
  for k in C['REQUIRED']:
   p=self.proof();p[k]=False
   with self.assertRaises(ValueError,msg=k):self.validate(p)
 def test_old_role_absence_rejected(self):
  p=self.proof();p['actual_absent_paths']=['/run/f4launch','/run/iq4_f4_entry02','/p1/scripts/.iq4_f4_original02','/p1/scripts/.iq4_f4_candidate02']
  with self.assertRaises(ValueError):self.validate(p)
 def test_receipt_content_tamper(self):
  p=self.proof();p['receipts'][C['REQUIRED'][0]]['sha256']='1'*64
  with self.assertRaises(ValueError):self.validate(p)
 def test_cold_recovery_not_inferred(self):
  p=self.proof();p['cold_boot_original_runner_verified']=False
  with self.assertRaises(ValueError):self.validate(p)
 def test_no_foreign_or_missing_env_mutation(self):
  new=M.derive((ROOT/'tools/firmware/f4_ram_entry_02/entry.c').read_text());self.assertIn('preload=0;',new);self.assertLess(new.index('IQ4_F1_MODULE_ENTRY_01='),new.index('int owned_198'))
 def test_validator_only_expected_literal_changes(self):
  old=G.validate_proof.__code__;new=C['validate_proof'].__code__;self.assertEqual(old.co_code,new.co_code)
  self.assertEqual(old.co_names,new.co_names);self.assertEqual(len(old.co_consts),len(new.co_consts))
 # Run verbatim production restore/hash/ack fault functions in local temp files.
class RetainedRestore(OLD.CFixtures):pass
if __name__=='__main__':unittest.main()
