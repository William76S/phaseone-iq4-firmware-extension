"""Fixed public RAM artifacts only. Returns plans; never runs a shell/device."""
import base64,hashlib,re
STATE='/run/iq4_f1_observe02'
def stage_plan(blobs,enabled):
 if not enabled:return {'enabled':False,'commands':[],'target_executed':False}
 if set(blobs)!={'entrytool','observe.so','entry.sha256','install.sh','disable.sh'}:raise ValueError('Five fixed public files only')
 if any(type(b)is not bytes or not 0<len(b)<=1048576 for b in blobs.values()):raise ValueError('Bounded nonempty public bytes')
 if blobs['entry.sha256']!=(hashlib.sha256(blobs['entrytool']).hexdigest()+'\n').encode():raise ValueError('Actual entry digest required')
 rows=[]
 def add(cmd,role,**expected):
  text='"Sys '+cmd+'"'
  if len(text.encode())>242 or any(c in text for c in('\n','\0','=')):raise ValueError('Fixed native lexer limit')
  rows.append({'text':text,'role':role,'max_source_bytes':242,**expected})
 add('mkdir -m 700 '+STATE,'create_owned_directory_no_p')
 for name,b in blobs.items():
  path=STATE+'/'+name;add("printf '' >"+path,'create_after_actual_new_empty_dir_check',expected_file_bytes=0)
  prefix="printf '";suffix="' | base64 -d >>"+path+' && wc -c <'+path
  maxraw=3*((242-len(('"Sys '+prefix+suffix+'"').encode()))//4)
  if maxraw<3:raise ValueError('Packet cannot fit')
  off=0
  while len(b)-off>=3:
   n=min(maxraw,3*((len(b)-off)//3));encoded=base64.b64encode(b[off:off+n]).decode();assert '='not in encoded
   off+=n;add(prefix+encoded+suffix,'append_fixed_base64_full_triples',expected_file_bytes=off,stdout_contract='decimal_size_LF_after_ACK_and_complete_EOF',no_retry_without_size_identity=True)
  if off<len(b):
   literal=''.join('\\%03o'%v for v in b[off:]);add("printf '"+literal+"' >>"+path+' && wc -c <'+path,'append_fixed_octal_one_or_two_tail',expected_file_bytes=len(b),stdout_contract='decimal_size_LF_after_ACK_and_complete_EOF',no_retry_without_size_identity=True)
  add('sha256sum '+path,'verify_actual_complete_whole_hash_before_next_mutation',expected_sha256=hashlib.sha256(b).hexdigest(),expected_file_bytes=len(b))
  add('chmod '+('600'if name=='entry.sha256'else'500')+' '+path,'fixed_owned_mode_after_hash_acceptance')
 add(STATE+'/entrytool --stage-launcher','same_fs_link_launcher_no_runner_change')
 add(STATE+'/entrytool --preflight','recheck_current_actual_identity_before_runner_change')
 return {'schema':'iq4_f1_fixed_public_ram_stager_v6','enabled':True,'commands':rows,'codec':'busybox_base64_no_padding_octal_tail_v1','network_required':False,'arbitrary_command_or_path_accepted':False,'target_executed':False,'mask_enabled':False}
