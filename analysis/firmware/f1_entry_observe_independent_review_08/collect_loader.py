"""Read frozen Loader08 bytes only; no build, generate, staging or target API."""
from pathlib import Path
import hashlib,json,re
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2]
FOLDER=ROOT/'tools/firmware/f1_entry_loader_binding_08';OLD=ROOT/'tools/firmware/f1_entry_loader_binding_07'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 output=HERE/'LOADER_STATIC_REVIEW.json';assert not output.exists()
 source=FOLDER/'SOURCE_SHA256.json';m=json.loads(source.read_bytes());checked=[]
 for group in('members','frozen_refs','review_artifacts'):
  for r in m[group]:
   p=ROOT/r['path'];assert p.stat().st_size==r['bytes']and sha(p)==r['sha256'],r['path'];checked.append(r)
 assert not any(m[k]for k in('device_or_SDK_or_Windows_or_network_used','target_executed','mask_enabled','paint_installed','UI_entry_installed','frozen_sources_modified'))
 build=json.loads((ROOT/'analysis/firmware/f1_entry_loader_build_08/BUILD_PREPARATION.json').read_bytes());row=build['entry_observe_so']
 assert row['sha256']=='e569a6c391a4e3d37439d32f774f74dede3c1863d751250d2939abfaaa935f99'and row['bytes']==97000 and row['publication_bytes']==496 and row['publication_va']==287208
 assert row['publication_load']==[1,6,90592,287200,287200,4444,15996,65536]
 config=(FOLDER/'config.preview.h').read_text();assert '#define F4_ENABLED 0'in config and '#define F1_ENTRY_BYTES 496U'in config and '#define F1_ENTRY_VA 287208ULL'in config
 entry=(FOLDER/'entry.c').read_bytes();old=(OLD/'entry.c').read_bytes();assert entry==old.replace(b'ui07.entry',b'ui08.entry').replace(b'iq4_f1_entry_ctor_status_v7',b'iq4_f1_entry_ctor_status_v8'),'More than marker/status schema changed in actual restorer/launcher'
 newread=(FOLDER/'entry_read.inc').read_bytes();oldread=(OLD/'entry_read.inc').read_bytes();assert newread==oldread.replace(b'iq4_f1_entry_copied_read_v7',b'iq4_f1_entry_copied_read_v8'),'Unexpected finite reader lifetime/map change'
 text=entry.decode();launch=text[text.index('static int launch(void){'):text.index('static int disable(void){')]
 assert launch.index('if(!restore())')<launch.index('if(!runner_parent_gate()')<launch.index('execve(')
 assert launch.count('execve(F4_ARGV0,argv,env)')==2 and'if(owned_198)close(198)'in launch and'env[count]=NULL'in launch
 restore=text[text.index('static int restore_core(void){'):text.index('static int create_bytes(')]
 assert 'runner_check(F4_RUNNER,0,1)'in restore and'runner_check(F4_ORIGINAL,0,1)'in restore and'rename(F4_ORIGINAL,F4_RUNNER)'in restore and'fsync_dir(F4_SCRIPT_DIR)'in restore
 gen=(FOLDER/'generate.py').read_text();assert "source['publication_bytes']!=496"in gen and "source['publication_va']!=287208"in gen and "entry_publication_bytes=source['publication_bytes']"in gen and "entry_publication_relative_va=source['publication_va']"in gen
 decoder=(FOLDER/'decode_read.py').read_text();assert "'publication_bytes':496"in decoder and'if emitted or normal_returns or serial or any(first[336:])'in decoder and'if paint or epoch or addresses' in decoder
 read=newread.decode();assert 'first[F1_ENTRY_BYTES],second[F1_ENTRY_BYTES]'in read and'before==end&&!(end&1)'in read and'!memcmp(first,second,sizeof first)'in read
 assert 'actual!=ticks'in read and'f1_same_file(&module,&after)'in read and'again!=address'in read
 checks=json.loads((ROOT/'analysis/firmware/f1_entry_loader_build_08/LOCAL_CHECKS.json').read_bytes());assert checks['passed']
 out=dict(schema='iq4_f1_loader08_independent_static_review',source_bytes=source.stat().st_size,source_sha256=sha(source),checked_reference_rows=len(checked),same_restorer_and_launcher_body_except_fixed_ui08_marker_and_ctor_status_schema=True,same_reader_lifetime_and_map_body_except_schema_v8=True,only_new_observe_SO_sha256=row['sha256'],publication_relative_va=287208,publication_bytes=496,preview_enabled=0,restore_original_inode_hash_before_exec_present=True,original_environment_fallback_present=True,actual_double_even_sequence_copy_and_PIDtick_rechecks_present=True,scalar_boundary_only_decoder_no_source_paint_epoch_claims=True,source_recorded_local_controls=len(checks['checks']),local_controls_not_rerun_by_this_review=True,actual_hardware_observed=False,SDK_or_Windows_or_network_used=False,new_or_old_build_executed=False,actual_approval_created=False,mask_paint_accepted=False)
 output.write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out,indent=2))
if __name__=='__main__':main()
