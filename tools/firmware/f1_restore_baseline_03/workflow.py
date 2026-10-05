"""Finite baseline collector with injected reviewed transport/private saving.

No SDK import, process start, camera call, installer or setter. Transactions
must already be reviewed by the exact private native/controller pipeline.
"""
from dataclasses import dataclass
import hashlib,json,re
from pathlib import Path
from . import contract as c
@dataclass(frozen=True)
class ReviewedReply:
 records:bytes
 text:bytes
 provenance:dict
 complete_private_schema:bool
 private_owner_dacl:bool
 normal_cleanup:bool
 idle_before_after:bool
@dataclass(frozen=True)
class ReceiptPins:
 source_manifest_sha256:str
 native_exe_sha256:str
 build_evidence_sha256:str
 controller_source_sha256:str
 echo_summary_sha256:str
 target_serial_sha256:str='7ec3641aa6b361045a2de7cc2c2e6f95c9697d7c278b2e5e8581fe0bc3297941'
 def validate(self):
  for value in vars(self).values():c.require(type(value) is str and re.fullmatch('[0-9a-f]{64}',value) is not None,'actual artifact SHA pin')
  c.require(self.target_serial_sha256=='7ec3641aa6b361045a2de7cc2c2e6f95c9697d7c278b2e5e8581fe0bc3297941','fixed owned target serial digest')
class Collector:
 def __init__(self,transact,save,pins,seed='baseline03',chunk=4096):
  c.require(type(chunk) is int and 1<=chunk<=4096,'finite regular chunk');c.require(type(pins) is ReceiptPins,'reviewed build/source/target pins required');pins.validate();self.pins=pins;self.transact,self.save,self.chunk=transact,save,chunk;self.seed=seed;self.index=0;self.ledger=[];self.saved=[]
 def next(self,label,**fields):
  self.index+=1;c.require(self.index<=512,'finite baseline command cap');token=hashlib.sha256((self.seed+':'+str(self.index)+':'+label).encode()).hexdigest()[:12]
  p,cmd=c.plan(label,token,**fields);r=self.transact(p)
  c.require(type(r) is ReviewedReply and all(type(x) is bool and x is True for x in (r.complete_private_schema,r.private_owner_dacl,r.normal_cleanup,r.idle_before_after)),'reviewed actual private receipt required')
  # Use the existing complete LE32 record guard/reassembly, not formatter text.
  c.require(c.reassemble_records(r.records)==r.text,'full raw records/text identity')
  c.require(type(r.provenance) is dict and r.provenance.get('profile')==label and r.provenance.get('request_sha256')==hashlib.sha256(p.encode()).hexdigest(),'receipt exact request binding')
  for name,value in vars(self.pins).items():c.require(type(r.provenance.get(name)) is str and r.provenance[name]==value,'receipt fixed source/artifact/target differs')
  c.require(r.provenance.get('raw_response_sha256')==hashlib.sha256(r.records).hexdigest() and type(r.provenance.get('native_host_pid')) is int and 0<r.provenance['native_host_pid']<=0xffffffff,'receipt raw capture/native PID binding')
  self.ledger.append(r.provenance);return cmd,r.text
 def keep(self,label,data):
  c.require(type(data) is bytes and 0<len(data)<=65536,'private bounded original');value=self.save(label,data);self.saved.append({'label':label,'bytes':len(data),'sha256':hashlib.sha256(data).hexdigest(),'private_path':str(value) if isinstance(value,(str,Path)) else None,'save_result_is_owner_dacl_proof':False});return data
 def ordinary_pass(self,path,baseline):
  cmd,reply=self.next('baseline_regular_metadata',path=path);before=c.metadata(cmd,reply,path);c.require(before==baseline,'regular metadata before pass changed')
  data=bytearray()
  for offset in range(0,before['size'],self.chunk):
   count=min(self.chunk,before['size']-offset);cmd,reply=self.next('baseline_regular_octets_chunk',path=path,offset=offset,count=count);data.extend(c.parse_regular_octets(cmd,reply,path,offset,count))
  n=before['size'];cmd,reply=self.next('baseline_regular_octets_eof',path=path,offset=n-1,count=2);last=c.parse_regular_octets(cmd,reply,path,n-1,2,eof=True);c.require(last==bytes(data[-1:]),'independent crossing EOF differs')
  cmd,reply=self.next('baseline_regular_sha256',path=path);device=c.digest(cmd,reply,path)
  cmd,reply=self.next('baseline_regular_metadata',path=path);after=c.metadata(cmd,reply,path)
  c.require(before==after and len(data)==n and hashlib.sha256(data).hexdigest()==device,'complete ordinary original mismatch')
  return bytes(data)
 def double_original(self,path):
  cmd,reply=self.next('baseline_regular_metadata',path=path);meta=c.metadata(cmd,reply,path)
  first=self.ordinary_pass(path,meta);self.keep(c.REGULAR[path][0]+'_first_original',first)
  second=self.ordinary_pass(path,meta);self.keep(c.REGULAR[path][0]+'_second_original',second)
  c.require(first==second,'independent ordinary originals differ')
  return {'path':path,'metadata':meta,'bytes':len(first),'sha256':hashlib.sha256(first).hexdigest(),'double_complete_equal':True,'EOF_and_device_whole_digest':True,'static_expected_size_matches':len(first)==c.REGULAR[path][1],'static_expected_sha_matches':None if not c.REGULAR[path][2] else hashlib.sha256(first).hexdigest()==c.REGULAR[path][2]}
 def binary_double(self,label,process):
  values=[]
  for i in (1,2):
   cmd,reply=self.next(label,process=process,count=c.MAX_PROC_BINARY+1);value=c.proc_binary(cmd,reply,label,process);self.keep(label+'_private_'+str(i),value);values.append(value)
  c.require(values[0]==values[1],'proc vector changed between complete passes');return values[0]
 def fixed_text(self,label,process=0,limit=32700):
  cmd,reply=self.next(label,process=process);value=c.text(cmd,reply,limit);self.keep(label+'_private_'+str(self.index).zfill(4),value.encode('ascii'));return value
 def collect(self,actual_user_pid):
  # User PID is obtained by the already executable p1linux_pid profile. Full
  # User SHA/length and exact native query/echo/idle are existing receipt inputs,
  # not claims established by this collector's argument.
  c.pid(actual_user_pid);stat_before=c.process_stat(self.fixed_text('baseline_user_stat',actual_user_pid,4096),actual_user_pid)
  cmd,reply=self.next('runtime_exe_readlink',process=actual_user_pid);user_path=c.original.parse_user_exe_path(cmd,reply)
  cmd,reply=self.next('runtime_exe_sha256',process=actual_user_pid);user_sha=c.original.parse_digest(cmd,reply,'/proc/'+str(actual_user_pid)+'/exe');c.require(user_sha==c.USER_SHA,'actual current User whole hash mismatch')
  cmd,reply=self.next('original_metadata',path=user_path);user_meta=c.original.parse_metadata(cmd,reply);c.require(user_meta['size']==11874544,'actual User whole length mismatch')
  runner=self.double_original(c.RUNNER);inittab=self.double_original(c.INITTAB)
  argv=self.binary_double('baseline_user_cmdline',actual_user_pid);env=self.binary_double('baseline_user_environment',actual_user_pid)
  parent=stat_before['ppid'];cmd,reply=self.next('runtime_exe_readlink',process=parent);parent_exe=c.marked(cmd,reply);c.require(parent_exe.endswith('\n') and parent_exe.count('\n')==1 and parent_exe.startswith('/'),'complete parent exe readlink');parent_exe=parent_exe[:-1];parent_argv=self.binary_double('baseline_parent_cmdline',parent)
  parent_stat=c.process_stat(self.fixed_text('baseline_parent_stat',parent,4096),parent,False)
  status=c.process_status(self.fixed_text('baseline_user_status',actual_user_pid,8192));mount=c.mount_rows(self.fixed_text('baseline_user_mountinfo',actual_user_pid));maps=c.module_maps(self.fixed_text('baseline_user_maps',actual_user_pid));boot=self.fixed_text('baseline_kernel_cmdline',limit=4096)
  pthread_sha=None
  if any(x['path']==c.PTHREAD_PATH and x['deleted']is False for x in maps):
   cmd,reply=self.next('baseline_pthread_sha256');pthread_sha=c.digest(cmd,reply,c.PTHREAD_PATH)
  stat_after=c.process_stat(self.fixed_text('baseline_user_stat',actual_user_pid,4096),actual_user_pid);c.require(stat_before==stat_after,'actual User PID/ticks/parent changed')
  cmd,reply=self.next('runtime_exe_sha256',process=actual_user_pid);c.require(c.original.parse_digest(cmd,reply,'/proc/'+str(actual_user_pid)+'/exe')==user_sha,'User changed during collection')
  c.vector(argv);c.vector(parent_argv);environment=c.vector(env,True)
  result={'schema':'iq4_f1_restore_baseline_collection_v3','actual_identity_input_from_prior_private_receipts_required':True,'user_stat':stat_before,'current_user_whole_identity':{'path':user_path,'sha256':user_sha,'metadata':user_meta},'parent_stat':parent_stat,'parent_exe':parent_exe,'ordinary_originals':[runner,inittab],'environment_opaque_summary':environment,'argv_bytes':len(argv),'argv_sha256':hashlib.sha256(argv).hexdigest(),'parent_argv_bytes':len(parent_argv),'parent_argv_sha256':hashlib.sha256(parent_argv).hexdigest(),'process_status':status,'mount_rows':mount,'all_private_maps':maps,'observed_pthread_digest':pthread_sha,'kernel_mount_and_maps_private_captured':True,'syscall_errno_xattr_probe_collected':False,'cold_boot_recovery_verified':False,'stock_respawn_verified':False,'UI_owner_observed':False,'mask_enabled':False,'camera_write_commands':0,'receipt_ledger':self.ledger,'private_saves':self.saved}
  self.save('baseline03_private_summary.json',(json.dumps(result,indent=2)+'\n').encode());return result
