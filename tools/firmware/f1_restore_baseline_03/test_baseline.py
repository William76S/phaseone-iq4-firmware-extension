"""Finite synthetic contracts only; never SDK, shell, target or device execution."""
import dataclasses,hashlib,json,pathlib,struct,sys,unittest
ROOT=pathlib.Path(__file__).resolve().parents[3];sys.path.insert(0,str(ROOT/'tools/firmware'))
from f1_restore_baseline_03 import contract as c
from f1_restore_baseline_03 import facts
from f1_restore_baseline_03.workflow import Collector,ReviewedReply,ReceiptPins
PINS=ReceiptPins(*[hashlib.sha256(x.encode()).hexdigest() for x in ('source','exe','build','controller','echo')])
def marked(p,body):return ('IQ4B_'+p.nonce+body+'IQ4E_'+p.nonce).encode()
def frame(text,discriminator=2):
 h=bytearray(20);struct.pack_into('<I',h,0,discriminator);h[4:8]=bytes([1,71,3,0]);struct.pack_into('<I',h,8,len(text));struct.pack_into('<H',h,12,20);struct.pack_into('<I',h,16,20+len(text));b=bytes(h)+text;return struct.pack('<I',len(b))+b
def formatted(data,offset=0):
 rows=[]
 for i in range(0,len(data),16):
  part=data[i:i+16];cells=[f'{x:03o}'for x in part]+['   ']*(16-len(part));rows.append(f'{offset+i:07x} '+' '.join(cells)+'\n')
 return ''.join(rows)+f'{offset+len(data):07x}\n'
def stat(pid=123,comm='p1linux',ppid=100,ticks=555):return f'{pid} ({comm}) S '+str(ppid)+' '+' '.join(['0']*17+[str(ticks)]+['0']*25)+'\n'
class Fake:
 def __init__(self,fault=''):
  self.fault=fault;self.saved={};self.calls=[];self.sha_calls=0;self.stat_calls=0;self.eofs={};self.metadata_calls={};self.files={c.RUNNER:b'#!/bin/sh\necho synthetic\n',c.INITTAB:b'::respawn:synthetic\n'}
 def save(self,label,data):
  c.require(label not in self.saved,'exclusive private filename collision');self.saved[label]=data;return pathlib.Path('/synthetic/private')/label
 def transact(self,p):
  self.calls.append(p);l=p.label
  if l=='baseline_regular_metadata':
   n=self.metadata_calls.get(p.path,0)+1;self.metadata_calls[p.path]=n;size=len(self.files[p.path]);ino=50 if self.fault=='metadata' and n>2 else 10;body=f'{size}:81ed:0:0:755:1:{ino}\n'
  elif l=='baseline_regular_octets_chunk' or l=='baseline_regular_octets_eof':
   data=self.files[p.path]
   if self.fault=='secondpass' and self.eofs.get(p.path,0)>0:data=bytes([data[0]^1])+data[1:]
   if l.endswith('eof'):
    self.eofs[p.path]=self.eofs.get(p.path,0)+1
    if self.fault=='not_eof':data+=b'X'
   part=data[p.offset:p.offset+p.count]
   if self.fault=='short' and l.endswith('chunk'):part=part[:-1]
   body=formatted(part,p.offset)
  elif l=='baseline_regular_sha256':
   data=self.files[p.path]
   if self.fault=='secondpass' and self.eofs.get(p.path,0)>1:data=bytes([data[0]^1])+data[1:]
   body=('0'*64 if self.fault=='digest' else hashlib.sha256(data).hexdigest())+'  '+p.path+'\n'
  elif l=='baseline_user_stat':
   self.stat_calls+=1;body=stat(ticks=556 if self.fault=='ticks' and self.stat_calls>1 else 555)
  elif l=='baseline_parent_stat':body=stat(100,'sh',1,444)
  elif l=='runtime_exe_readlink':body='/mnt/qspi/User/p1linux\n' if p.pid==123 else '/bin/busybox.nosuid\n'
  elif l=='runtime_exe_sha256':body=('0'*64 if self.fault=='user_sha' else c.USER_SHA)+'  /proc/'+str(p.pid)+'/exe\n'
  elif l=='original_metadata':body='11874544:81ed:0:0:755:1:101\n'
  elif l in c.PROC_BINARY:
   data={'baseline_user_cmdline':b'/run/media/storage/User/p1linux\0','baseline_parent_cmdline':b'/bin/sh\0/p1/scripts/boot_run_p1linux.sh\0','baseline_user_environment':b'PATH=/bin:/usr/bin\0X=private-value\0'}[l];body=formatted(data)
  elif l=='baseline_user_status':body='Name:\tp1linux\nUmask:\t0022\nUid:\t0\t0\t0\t0\nGid:\t0\t0\t0\t0\nThreads:\t30\n'
  elif l=='baseline_user_maps':body='00400000-01000000 r-xp 00000000 1f:00 3 /mnt/qspi/User/p1linux\n70000000-70010000 r-xp 00000000 01:00 7 /lib/libpthread-2.28.so\n'
  elif l=='baseline_pthread_sha256':body='a'*64+'  '+c.PTHREAD_PATH+'\n'
  elif l=='baseline_user_mountinfo':body='1 0 1:0 / / rw - ext2 /dev/ram0 rw\n2 1 0:20 / /run rw - tmpfs tmpfs rw\n'
  elif l=='baseline_kernel_cmdline':body='root=/dev/ram0 ro synthetic\n'
  else:raise AssertionError(l)
  text=marked(p,body);raw=frame(text);proof={**vars(PINS),'profile':l,'request_sha256':hashlib.sha256(p.encode()).hexdigest(),'raw_response_sha256':hashlib.sha256(raw).hexdigest(),'native_host_pid':999}
  return ReviewedReply(raw,text,proof,True,True,True,True)
class Tests(unittest.TestCase):
 def collector(self,fault=''):
  f=Fake(fault);return f,Collector(f.transact,f.save,PINS,chunk=7)
 def test_complete_collection_preserves_originals_and_unique_private_paths(self):
  f,w=self.collector();r=w.collect(123)
  self.assertEqual(r['current_user_whole_identity']['sha256'],c.USER_SHA);self.assertEqual(r['parent_exe'],'/bin/busybox.nosuid');self.assertFalse(r['cold_boot_recovery_verified']);self.assertFalse(r['UI_owner_observed']);self.assertEqual(r['camera_write_commands'],0)
  self.assertEqual(f.saved['runner_first_original'],f.saved['runner_second_original']);self.assertEqual(len([k for k in f.saved if k.startswith('baseline_user_stat_private')]),2);json.dumps(r)
  self.assertNotIn('private-value',json.dumps(r));self.assertGreater(len(w.ledger),10)
 def test_secondpass_preserves_both_without_pass(self):
  f,w=self.collector('secondpass')
  with self.assertRaises(c.original.ContractError):w.double_original(c.RUNNER)
  self.assertEqual(set(f.saved),{'runner_first_original','runner_second_original'});self.assertNotEqual(*f.saved.values())
 def test_extent_digest_metadata_and_ticks_failures(self):
  for fault in ('not_eof','short','digest','metadata','ticks','user_sha'):
   with self.subTest(fault=fault):
    f,w=self.collector(fault)
    with self.assertRaises(c.original.ContractError):w.collect(123)
    self.assertNotIn('baseline03_private_summary.json',f.saved)
 def test_receipt_truthy_not_boolean_rejected(self):
  for value in ('yes',1,[True],{'yes':True}):
   f,w=self.collector();base=f.transact
   w.transact=lambda p:dataclasses.replace(base(p),complete_private_schema=value)
   with self.assertRaises(c.original.ContractError):w.next('baseline_user_stat',process=123)
 def test_each_source_binding_rejected(self):
  for name in vars(PINS):
   f,w=self.collector();base=f.transact
   def bad(p,name=name):
    r=base(p);return dataclasses.replace(r,provenance={**r.provenance,name:'0'*64})
   w.transact=bad
   with self.assertRaises(c.original.ContractError):w.next('baseline_user_stat',process=123)
 def test_raw_final_discriminator_and_formatter_mismatch(self):
  for kind in ('no_final','upper_u32','text'):
   f,w=self.collector();base=f.transact
   def bad(p):
    r=base(p);raw=r.records[:-1] if kind=='no_final' else frame(r.text,0x102) if kind=='upper_u32' else r.records
    return dataclasses.replace(r,records=raw,text=r.text+b'X' if kind=='text' else r.text)
   w.transact=bad
   with self.assertRaises(c.original.ContractError):w.next('baseline_user_stat',process=123)
 def test_proc4096_accepted4097_rejected_and_no_seek(self):
  p,cmd=c.plan('baseline_user_environment','0123456789ab',process=123,count=4097);self.assertNotIn(' -s ',cmd.host_text)
  for n in (4096,4097):
   value=b'A'*(n-1)+b'\0';reply=marked(p,formatted(value))
   if n==4096:self.assertEqual(c.proc_binary(cmd,reply,p.label,123),value)
   else:
    with self.assertRaises(c.original.ContractError):c.proc_binary(cmd,reply,p.label,123)
 def test_nonterminated_duplicate_environment_and_empty_entries(self):
  for value in (b'PATH=x',b'PATH=x\0PATH=y\0',b'PATH=x\0\0',b'BAD KEY=x\0'):
   with self.assertRaises(c.original.ContractError):c.vector(value,True)
 def test_changed_terminal_short_extra_duplicate_rows(self):
  p,cmd=c.plan('baseline_regular_octets_chunk','0123456789ab',path=c.RUNNER,count=17);body=formatted(bytes(range(17)))
  for value in (body[:-8],body+'0000011\n',body.replace('0000011','0000010'),body.splitlines(True)[0]+body):
   with self.assertRaises(c.original.ContractError):c.parse_regular_octets(cmd,marked(p,value),p.path,0,17)
 def test_unknown_path_and_setter_not_whitelisted(self):
  for label,path in (('baseline_regular_metadata','/etc/shadow'),('baseline_regular_octets_chunk','/sys/foo/eeprom'),('native_permission_read_PinCode',''),('original_Locked_bool_set_0','')):
   with self.assertRaises(c.original.ContractError):c.plan(label,'0123456789ab',path=path,count=1)
 def test_invalid_pid_and_span_types(self):
  for pid in (0,1,True,-1,1000000000):
   with self.assertRaises(c.original.ContractError):c.plan('baseline_user_stat','0123456789ab',process=pid)
  for off,count in ((-1,1),(0,0),(0,4097),(65535,2),(True,1),(0,True)):
   with self.assertRaises(c.original.ContractError):c.plan('baseline_regular_octets_chunk','0123456789ab',path=c.RUNNER,offset=off,count=count)
 def test_deleted_role_map_is_explicit(self):
  r=c.module_maps('70000000-70001000 r-xp 00000000 00:00 0 /run/iq4_f1_observe02/observe.so (deleted)\n');self.assertTrue(r[0]['deleted'])
 def test_process_row22_and_duplicate_status(self):
  self.assertEqual(c.process_stat(stat(),123)['start_ticks'],555)
  for value in (stat().rstrip('\n'),stat(comm='other'),stat(pid=124)):
   with self.assertRaises(c.original.ContractError):c.process_stat(value,123)
  with self.assertRaises(c.original.ContractError):c.process_status('Umask: 0022\nUmask: 0022\nUid: 0 0 0 0\nGid: 0 0 0 0\nThreads: 1\n')
 def test_pins_and_capture_metadata_types(self):
  with self.assertRaises(c.original.ContractError):Collector(lambda p:None,lambda *a:None,None)
  with self.assertRaises(c.original.ContractError):Collector(lambda p:None,lambda *a:None,dataclasses.replace(PINS,native_exe_sha256='wrong'))
def node_fixture(index,follow=False,errno=0):
 return dict(index=index,follow=follow,rc=-1 if errno else 0,errno=errno,stable=not errno,dev_major=0 if errno else 1,dev_minor=0,inode=0 if errno else 5,mode=0 if errno else 0o40755,uid=0,gid=0,size=0,nlink=0 if errno else 2,mtime_sec=0,mtime_nsec=0,ctime_sec=0,ctime_nsec=0)
def facts_fixture():
 return dict(schema='iq4_f1_fixed_syscall_facts_v3',uid=0,euid=0,file_write_calls=0,device_control_calls=0,nodes=[node_fixture(i,errno=2 if i>=14 else 0)for i in range(26)],followed_alias_parents=[node_fixture(4,True),node_fixture(5,True)],runner_xattrs=dict(fd_opened=True,name_bytes=0,errno=0,stable=True,attribute_values_read=False))
class FactsTests(unittest.TestCase):
 def test_complete_actual_absence_distinct_from_other_errno(self):
  v=facts_fixture();v['nodes'][14]=node_fixture(14,errno=13);r=facts.parse_body(json.dumps(v)+'\n');self.assertEqual(r['nodes'][14]['errno'],13);self.assertEqual(r['nodes'][15]['errno'],2);self.assertFalse(r['cold_boot_recovery_verified'])
 def test_duplicate_path_index_and_truncation_rejected(self):
  for fault in ('index','truncated','follow','bool'):
   v=facts_fixture()
   if fault=='index':v['nodes'][1]['index']=0
   elif fault=='truncated':v['nodes'].pop()
   elif fault=='follow':v['followed_alias_parents'][0]['follow']=False
   else:v['nodes'][0]['stable']=1
   with self.assertRaises(c.original.ContractError):facts.parse_body(json.dumps(v)+'\n')
 def test_xattr_error_keeps_observation_not_zero_fact(self):
  v=facts_fixture();v['runner_xattrs'].update(fd_opened=False,name_bytes=-1,errno=13,stable=False);r=facts.parse_body(json.dumps(v)+'\n');self.assertEqual(r['runner_xattrs']['errno'],13);self.assertFalse(r['UI_owner_observed'])
 def test_duplicate_keys_writes_and_attribute_values_rejected(self):
  v=facts_fixture()
  with self.assertRaises(c.original.ContractError):facts.parse_body(json.dumps(v)[:-1]+',"uid":0}\n')
  for field in ('write','attribute_values'):
   v=facts_fixture()
   if field=='write':v['file_write_calls']=1
   else:v['runner_xattrs']['attribute_values_read']=True
   with self.assertRaises(c.original.ContractError):facts.parse_body(json.dumps(v)+'\n')
if __name__=='__main__':unittest.main()
