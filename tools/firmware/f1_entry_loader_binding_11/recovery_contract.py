# Own new-identity mechanical validator; frozen recovery source unchanged.
# Mechanically derived fixed role recovery contract. No device API.
import hashlib,re
def sha(b): return hashlib.sha256(b).hexdigest()

RUNNER_SHA='fe57b899f3a583e1058e4e856cf80704d902d6989b802154d02e77bc93305e88'

USER_SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'

REQUIRED=[
 'root_review_completed','readonly_sys_transport_complete','eeprom_double_original_complete',
 'actual_user_hash_and_executable_verified','runner_double_original_complete','private_backup_acl_verified',
 'actual_ram_root_verified','no_persistent_covering_mount','tmpfs_exec_verified',
 'actual_tools_hashes_and_supported_options_verified','native_user_exit_stock_respawn_verified',
 'cold_boot_original_runner_verified','independent_probe_after_sdk_close_verified',
 'original_argv_environment_and_umask_restart_baseline_verified','runner_no_xattrs_verified',
 'foreign_debug_upgrade_respawn_flags_absent','authenticated_observe_constructor_source_reviewed',
 'same_fs_hardlink_atomic_rename_fsync_probe_verified',
 'current_baseline03_syscall_identity_verified',
 'scratch_restore_probe_actual_roundtrip_verified',
 'public_artifact_stager_and_cleanup_route_verified',
 'display06_complete_source_and_exceptions_reviewed',
 'current_single_controller_lease_and_backup_handles_held',
 'actual_base64_decoder_roundtrip_verified',
 'ui10_native_entry_source_and_constructor_registry_reviewed',
 'ui10_actual_button_placement_input_route_and_retained_lifetime_verified',
 'ui10_full_production_preparer_and_combined_tracer_source_reviewed',
]

def integer(v,low,high): return type(v) is int and low<=v<=high

def hexsha(v): return type(v) is str and re.fullmatch('[0-9a-f]{64}',v) and v!='0'*64

def exact_fields(value,expected):
 return isinstance(value,dict) and all(type(value.get(k)) is type(v) and value[k]==v for k,v in expected.items())

def validate_proof(proof,runner_a,runner_b,receipt_loader):
 if not isinstance(proof,dict) or proof.get('schema')!='iq4_f1_entry_loader_gate_v11':raise ValueError('Unknown proof schema')
 if proof.get('profile')!='RAM_F1_production_default_off_11':raise ValueError('Only new UI10 entry-only one-shot is implemented')
 if any(type(proof.get(k)) is not bool or not proof[k] for k in REQUIRED):raise ValueError('Actual gate evidence incomplete; enabled output refused')
 if proof.get('camera_operator')!='root_windows_unique_executor':raise ValueError('Single executor identity absent')
 runner=proof.get('runner',{}); user=proof.get('user',{}); mount=proof.get('mount',{})
 if runner_a!=runner_b or sha(runner_a)!=RUNNER_SHA or len(runner_a)!=5105:raise ValueError('Exact original runner copies differ')
 if not exact_fields(runner,{'sha256':RUNNER_SHA,'size':5105,'uid':0,'gid':0,'mode':493,'major':1,'minor':0,'xattrs':[]}):raise ValueError('Runner metadata/hash not exact')
 if not integer(runner.get('inode'),1,2**64-1) or not integer(runner.get('nlink'),1,1):raise ValueError('Runner inode/nlink invalid')
 if not exact_fields(user,{'sha256':USER_SHA,'size':11874544,'uid':0,'gid':0,'mode':493}):raise ValueError('User metadata/hash not exact')
 if user.get('canonical_path')!='/mnt/qspi/User/p1linux' or user.get('argv0')!='/run/media/storage/User/p1linux' or user.get('argv_tail')!=[]:raise ValueError('Original User argv/path unsupported')
 if not integer(user.get('pid'),2,10000000) or not integer(user.get('start_ticks'),1,2**64-1) or not integer(user.get('umask'),0,511):raise ValueError('Actual User PID/start ticks/umask invalid')
 if user.get('parent_ppid')!=1 or user.get('parent_exe')!='/bin/busybox.nosuid' or user.get('parent_argv')!=['/bin/sh','/p1/scripts/boot_run_p1linux.sh']:raise ValueError('Stock init runner parent contract unverified')
 if mount.get('root_source') not in ['/dev/ram0','/dev/root'] or mount.get('root_fstype') not in ['ext2','ext4'] or not exact_fields(mount,{'root_major':1,'root_minor':0,'cmdline_root':'/dev/ram0'}):raise ValueError('Actual RAM root not supported')
 if mount.get('run_fstype')!='tmpfs' or mount.get('run_major')!=0 or not integer(mount.get('run_minor'),1,2**20):raise ValueError('Actual tmpfs identity absent')
 for k in ['root_mount_id','run_mount_id']:
  if not integer(mount.get(k),1,2**31-1):raise ValueError('Actual mount IDs absent')
 expected=['/run/f1launch','/run/iq4_f1_observe02','/p1/scripts/.iq4_f1_original02','/p1/scripts/.iq4_f1_candidate02']
 paths=proof.get('actual_absent_paths')
 if type(paths) is not list or any(type(v) is not str for v in paths) or sorted(paths)!=sorted(expected):raise ValueError('Owned new paths not proven absent')
 receipts=proof.get('receipts')
 if not isinstance(receipts,dict) or set(receipts)!=set(REQUIRED):raise ValueError('Every actual gate needs an independent receipt')
 for name,r in receipts.items():
  if not isinstance(r,dict) or not hexsha(r.get('sha256')) or not isinstance(r.get('path'),str):raise ValueError('Receipt descriptor invalid')
  b=receipt_loader(r['path'])
  if sha(b)!=r['sha256']:raise ValueError('Receipt bytes changed: '+name)
  # Generator validates provenance bytes; Root must establish their actual
  # device meaning. It does not make host-authored booleans into hardware facts.
 return proof
