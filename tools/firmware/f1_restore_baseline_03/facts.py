"""Strict fixed syscall snapshot parser; output remains private, no policy enable."""
import json
from .contract import require,marked,original
PATHS=("/","/p1","/p1/scripts","/run","/run/media/storage","/run/media/storage/User","/mnt/qspi","/mnt/qspi/User","/p1/scripts/boot_run_p1linux.sh","/etc/inittab","/mnt/qspi/User/p1linux","/run/media/storage/User/p1linux","/run/boot_is_user","/run/essential_boot_done","/run/boot_is_factory","/run/p1linux_respawn_reboot","/run/p1linux_respawn_run_install_mode","/run/p1linux_respawn_do_nothing","/run/media/storage/debug","/mnt/qspi/debug","/run/media/storage/User/p1linux.bin","/mnt/qspi/User/p1linux.bin","/run/f1launch","/run/iq4_f1_observe02","/p1/scripts/.iq4_f1_original02","/p1/scripts/.iq4_f1_candidate02")
FIELDS=('index','follow','rc','errno','stable','dev_major','dev_minor','inode','mode','uid','gid','size','nlink','mtime_sec','mtime_nsec','ctime_sec','ctime_nsec')
def unique(pairs):
 out={}
 for key,value in pairs:require(key not in out,'duplicate private JSON key');out[key]=value
 return out
def node(row,index,follow):
 require(type(row) is dict and set(row)==set(FIELDS),'exact syscall node fields');require(type(row['index'])is int and row['index']==index and type(row['follow'])is bool and row['follow']is follow,'fixed syscall path index')
 require(type(row['rc'])is int and row['rc']in (-1,0) and type(row['stable'])is bool,'actual syscall rc/stability')
 for k in FIELDS:
  if k not in ('follow','stable','rc'):require(type(row[k])is int,'integral syscall field')
 require(0<=row['errno']<=4095 and ((row['rc']==0 and row['errno']==0)or(row['rc']==-1 and row['errno']>0 and row['stable']is False)),'actual errno must not be interpreted as absence')
 for k in ('dev_major','dev_minor','inode','mode','uid','gid','nlink'):require(0<=row[k]<2**64,'finite syscall scalar')
 for k in ('mtime_nsec','ctime_nsec'):require(0<=row[k]<10**9,'actual nanoseconds')
 require(-(2**63)<=row['size']<2**63,'signed size');return {**row,'path':PATHS[index]}
def parse_body(body):
 require(type(body)is str and 0<len(body.encode('ascii'))<=32700 and body.endswith('\n')and '\0'not in body,'complete private syscall JSON')
 try:value=json.loads(body,object_pairs_hook=unique)
 except (ValueError,TypeError):raise original.ContractError('invalid private syscall JSON')from None
 require(type(value)is dict and set(value)=={'schema','uid','euid','file_write_calls','device_control_calls','nodes','followed_alias_parents','runner_xattrs'},'exact fixed syscall shape')
 require(value['schema']=='iq4_f1_fixed_syscall_facts_v3','fixed syscall schema')
 for k in ('uid','euid','file_write_calls','device_control_calls'):require(type(value[k])is int and 0<=value[k]<=0xffffffff,'fixed syscall counters')
 require(value['file_write_calls']==value['device_control_calls']==0,'readonly helper contract')
 require(type(value['nodes'])is list and len(value['nodes'])==len(PATHS),'complete fixed path snapshot');value['nodes']=[node(r,i,False)for i,r in enumerate(value['nodes'])]
 require(type(value['followed_alias_parents'])is list and len(value['followed_alias_parents'])==2,'both actual alias parents');value['followed_alias_parents']=[node(r,i,True)for r,i in zip(value['followed_alias_parents'],(4,5))]
 x=value['runner_xattrs'];require(type(x)is dict and set(x)=={'fd_opened','name_bytes','errno','stable','attribute_values_read'},'fixed runner xattr observation')
 for k in ('fd_opened','stable','attribute_values_read'):require(type(x[k])is bool,'actual xattr booleans')
 require(x['attribute_values_read']is False and type(x['name_bytes'])is int and -1<=x['name_bytes']<=1048576 and type(x['errno'])is int and 0<=x['errno']<=4095,'actual xattr result bounds')
 require((x['name_bytes']>=0 and x['errno']==0 and x['fd_opened'])or(x['name_bytes']==-1 and x['errno']>0),'xattr rc/errno consistency')
 value.update(cold_boot_recovery_verified=False,stock_respawn_verified=False,UI_owner_observed=False,mask_enabled=False)
 return value
def parse(command,reply):return parse_body(marked(command,reply))
