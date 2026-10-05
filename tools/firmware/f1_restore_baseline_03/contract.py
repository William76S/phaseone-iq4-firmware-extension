"""Fixed readonly recovery-baseline plans/parsers. No SDK or process execution."""
from dataclasses import dataclass
from pathlib import Path
import hashlib,re,sys
ROOT=Path(__file__).resolve().parents[3];SDK=ROOT/'tools/sdk'
sys.path.insert(0,str(SDK/'readonly_backup_stage2'));from workflow import Plan,original,USER_SHA,reassemble_records
# Explicit loader avoids colliding with this module's own generic name.
import importlib.util
_spec=importlib.util.spec_from_file_location('f1_original_octet_contract',SDK/'read_hex_octets_01/contract.py')
octets=importlib.util.module_from_spec(_spec);_spec.loader.exec_module(octets)
RUNNER='/p1/scripts/boot_run_p1linux.sh';INITTAB='/etc/inittab'
RUNNER_SHA='fe57b899f3a583e1058e4e856cf80704d902d6989b802154d02e77bc93305e88'
REGULAR={RUNNER:('runner',5105,RUNNER_SHA),INITTAB:('inittab',516,'da1a356326c458b73d1abb187e9eb537c7d9ac86b7bb4cf3c567edb43115f535')}
MAX_PROC_BINARY=4096
PROC_BINARY={'baseline_user_cmdline':'cmdline','baseline_user_environment':'environ','baseline_parent_cmdline':'cmdline'}
PROC_TEXT={'baseline_user_stat':'stat','baseline_user_status':'status','baseline_user_maps':'maps','baseline_user_mountinfo':'mountinfo','baseline_parent_stat':'stat'}
FIXED_TEXT={'baseline_kernel_cmdline':'/proc/cmdline'}
PROBE_PATH='/run/iq4_f1_baseline03/readfacts'
PTHREAD_PATH='/lib/libpthread-2.28.so'
def require(v,message):original._require(v,message)
def pid(v):require(type(v) is int and 1<v<=999999999,'actually observed PID required');return v
def nonce(v):require(type(v) is str and re.fullmatch('[0-9a-f]{8,12}',v) is not None,'finite nonce');return v
def command(label,os,token,expected_bytes=None,offset=None):
 nonce(token);c=original._command(label,os,token,expected_bytes,offset)
 require(len(c.host_text.encode('ascii'))<=242,'native safe line span');return c
def plan(label,token,process=0,path='',offset=0,count=0):
 nonce(token);require(path in ('',RUNNER,INITTAB,*original.USER_PATHS),'fixed baseline pathname')
 require(type(process) is int and type(offset) is int and type(count) is int,'finite integral spans')
 if label in ('runtime_exe_readlink','runtime_exe_sha256'):
  pid(process);require(path=='' and offset==count==0,'existing fixed process identity');c=command(label,('/usr/bin/readlink ' if label=='runtime_exe_readlink' else '/usr/bin/sha256sum ')+'/proc/'+str(process)+'/exe',token)
 elif label=='original_metadata':
  require(path in original.USER_PATHS and process==offset==count==0,'existing exact User metadata');c=original.metadata_command(path,token)
 elif label in ('baseline_regular_metadata','baseline_regular_sha256'):
  require(path in REGULAR and process==offset==count==0,'fixed ordinary original read')
  os=('/bin/stat -L -c %s:%f:%u:%g:%a:%Y:%i ' if label.endswith('metadata') else '/usr/bin/sha256sum ')+path
  c=command(label,os,token)
 elif label in ('baseline_regular_octets_chunk','baseline_regular_octets_eof'):
  require(path in REGULAR and process==0 and 0<=offset<65536,'fixed regular original extent')
  require((label.endswith('chunk') and 1<=count<=4096 and offset+count<=65536) or (label.endswith('eof') and count==2),'finite regular byte count')
  c=command(label,'/usr/bin/hexdump -v -b -s '+str(offset)+' -n '+str(count)+' '+path+' 2>&1',token,count if label.endswith('chunk') else 1,offset)
 elif label in PROC_BINARY:
  pid(process);require(path=='' and offset==0 and count==MAX_PROC_BINARY+1,'single bounded proc overflow sentinel')
  # No -s against zero-size pseudo-files. Strict body parsing rejects errors,
  # cap bytes, malformed terminal and incomplete captures.
  c=command(label,'/usr/bin/hexdump -v -b -n '+str(count)+' /proc/'+str(process)+'/'+PROC_BINARY[label]+' 2>&1',token,None,0)
 elif label in PROC_TEXT:
  pid(process);require(path=='' and offset==count==0,'fixed process text read')
  c=command(label,'/bin/cat /proc/'+str(process)+'/'+PROC_TEXT[label]+' 2>&1',token)
 elif label in FIXED_TEXT:
  require(process==offset==count==0 and path=='','fixed kernel text read');c=command(label,'/bin/cat '+FIXED_TEXT[label]+' 2>&1',token)
 elif label in ('baseline_syscall_facts','baseline_syscall_probe_sha'):
  require(process==offset==count==0 and path=='','fixed staged read-only probe')
  c=command(label,PROBE_PATH if label.endswith('facts') else '/usr/bin/sha256sum '+PROBE_PATH,token)
 elif label=='baseline_pthread_sha256':
  require(process==offset==count==0 and path=='','fixed original provider digest');c=command(label,'/usr/bin/sha256sum '+PTHREAD_PATH,token)
 else:raise original.ContractError('baseline profile not whitelisted')
 return Plan(label,c.host_text,token,process,path,offset,count,USER_SHA),c
def marked(c,reply):return original.extract_marked_text(c,reply)
def metadata(c,reply,path):
 # Retain the positive regular metadata parser; a copied fixed path wrapper
 # does not expand the frozen EEPROM/User parser's own allowed paths.
 require(path in REGULAR and c==plan('baseline_regular_metadata',c.begin_marker[5:],path=path)[1],'metadata command identity')
 body=marked(c,reply);m=re.fullmatch(r'([0-9]+):([0-9a-f]+):([0-9]+):([0-9]+):([0-7]+):([0-9]+):([0-9]+)\n',body)
 require(m is not None,'exact stat output');values=[int(m[1]),int(m[2],16),int(m[3]),int(m[4]),int(m[5],8),int(m[6]),int(m[7])]
 size,mode,uid,gid,permissions,mtime,inode=values;require(0<size<=65536 and mode&0xf000==0x8000 and inode>0,'positive regular original')
 return dict(size=size,mode=mode,uid=uid,gid=gid,permissions=permissions,mtime=mtime,inode=inode)
def digest(c,reply,path):
 require(path in REGULAR or path in (PROBE_PATH,PTHREAD_PATH),'fixed digest path');body=marked(c,reply)
 m=re.fullmatch(r'([0-9a-f]{64})  '+re.escape(path)+r'\n',body);require(m is not None,'exact whole-file digest');return m[1]
def _octet_body(c,reply,offset,expected):
 # Exact frozen parser body, using a command identity adapter only. It is
 # materialized by derive_parser.py with its original source SHA pinned.
 from .derived_octet_parser import parse_fixed_octets
 return parse_fixed_octets(c,reply,offset,expected)
def parse_regular_octets(c,reply,path,offset,count,eof=False):
 label='baseline_regular_octets_eof' if eof else 'baseline_regular_octets_chunk'
 expected=plan(label,c.begin_marker[5:],path=path,offset=offset,count=count)[1]
 require(c==expected,'regular octet request identity');return _octet_body(c,reply,offset,1 if eof else count)
def proc_binary(c,reply,label,process):
 require(c==plan(label,c.begin_marker[5:],process=process,count=MAX_PROC_BINARY+1)[1],'proc octet command identity')
 body=marked(c,reply);require(body.endswith('\n') and '\r' not in body,'complete canonical proc octets')
 final=body[:-1].split('\n')[-1];require(re.fullmatch('[0-9a-f]{7}',final) is not None,'proc terminal address')
 count=int(final,16);require(0<count<=MAX_PROC_BINARY,'pseudo-file reached overflow sentinel or empty')
 value=_octet_body(c,reply,0,count);require(value.endswith(b'\0'),'complete NUL-terminated proc vector');return value
def vector(value,environment=False):
 require(type(value) is bytes and 0<len(value)<=MAX_PROC_BINARY and value.endswith(b'\0'),'bounded full NUL vector')
 parts=value[:-1].split(b'\0');require(all(parts) and len(parts)<=256,'empty entry or excessive vector')
 if environment:
  keys=[]
  for p in parts:
   key,sep,val=p.partition(b'=');require(sep==b'=' and re.fullmatch(rb'[A-Za-z_][A-Za-z_0-9]*',key) is not None,'invalid environment key')
   require(key not in keys,'duplicate environment key');keys.append(key)
  return {'entries':len(parts),'sha256':hashlib.sha256(value).hexdigest(),'bytes':len(value),'loader_variables_present':any(k.startswith(b'LD_') for k in keys),'observe_variable_present':b'IQ4_F1_MODULE_ENTRY_01' in keys}
 return parts
def text(c,reply,limit=32700):
 value=marked(c,reply);require(type(value) is str and 0<len(value.encode('ascii'))<=limit and value.endswith('\n') and '\r' not in value and '\0' not in value,'complete bounded ASCII text');return value
def process_stat(value,process,require_user=True):
 require(type(value) is str and value.endswith('\n') and '\n' not in value[:-1] and len(value)<=4096,'complete stat row')
 m=re.fullmatch(r'([1-9][0-9]*) \(([^\n\0]{1,15})\) ([RSDZTWtXxKPI]) (.+)\n',value);require(m is not None and int(m[1])==pid(process),'actual stat identity')
 if require_user:require(m[2]=='p1linux','actual User comm')
 fields=m[4].split(' ');require(len(fields)>=19 and all(re.fullmatch('-?[0-9]+',x) is not None for x in fields),'numeric stat fields')
 ppid=int(fields[0]);ticks=int(fields[18]);require(ppid>0 and ticks>0,'actual parent/ticks');return {'pid':process,'comm':m[2],'ppid':ppid,'start_ticks':ticks}
def process_status(value):
 require(type(value) is str and value.endswith('\n') and len(value)<=8192,'complete process status')
 lines=value.splitlines();out={}
 for key in ('Umask','Uid','Gid','Threads'):
  found=[x[len(key)+1:] for x in lines if x.startswith(key+':')];require(len(found)==1,'unique status field');v=found[0].strip()
  if key=='Umask':require(re.fullmatch('[0-7]{4}',v) is not None,'canonical umask');out['umask']=int(v,8)
  elif key=='Threads':require(re.fullmatch('[1-9][0-9]*',v) is not None,'actual thread count');out['threads']=int(v)
  else:
   parts=v.split();require(len(parts)==4 and all(re.fullmatch('[0-9]+',x) is not None for x in parts),'actual credential fields');out[key.lower()]=[int(x)for x in parts]
 return out
def module_maps(value):
 require(type(value) is str and value.endswith('\n') and len(value)<=32700,'complete maps');found=[]
 allowed={PTHREAD_PATH,'/mnt/qspi/User/p1linux','/run/media/storage/User/p1linux','/run/iq4_f1_observe02/observe.so'}
 for row in value.splitlines():
  m=re.fullmatch(r'([0-9a-f]+)-([0-9a-f]+) ([r-][w-][x-][ps]) ([0-9a-f]+) ([0-9a-f]+):([0-9a-f]+) ([0-9]+)(?: +(.*))?',row)
  require(m is not None,'canonical complete maps row');start,end=int(m[1],16),int(m[2],16);require(start<end,'actual map range');name=m[8] or ''
  deleted=name.endswith(' (deleted)');base=name[:-10] if deleted else name
  found.append({'path':base,'fixed_original_or_role':base in allowed,'deleted':deleted,'start':start,'end':end,'permissions':m[3],'offset':int(m[4],16),'major':int(m[5],16),'minor':int(m[6],16),'inode':int(m[7])})
 require(0<len(found)<=512,'bounded complete private map records');return found
def mount_rows(value):
 require(type(value) is str and value.endswith('\n') and len(value)<=32700,'complete mountinfo');out=[]
 for row in value.splitlines():
  parts=row.split(' - ');require(len(parts)==2,'mountinfo separator');left,right=parts[0].split(),parts[1].split();require(len(left)>=6 and len(right)==3,'complete mountinfo fields')
  require(re.fullmatch('[1-9][0-9]*',left[0]) is not None and re.fullmatch('[0-9]+',left[1]) is not None and re.fullmatch('[0-9]+:[0-9]+',left[2]) is not None,'actual mount ids/device')
  ma,mi=map(int,left[2].split(':'));out.append({'id':int(left[0]),'parent_id':int(left[1]),'major':ma,'minor':mi,'root':left[3],'mountpoint':left[4],'options':left[5],'fstype':right[0],'source':right[1],'super_options':right[2]})
 require(0<len(out)<=256,'bounded complete mount table');return out
