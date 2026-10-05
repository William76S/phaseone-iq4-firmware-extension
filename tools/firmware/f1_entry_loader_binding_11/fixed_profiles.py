"""Finite CLI formatter for a new native derivative; no SDK or execution."""
from pathlib import Path
import importlib.util,re,sys
ROOT=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(ROOT/'tools/sdk/readonly_backup_stage2'))
from workflow import Plan,original,USER_SHA
FLAGS={'loader11_preflight':'--preflight','loader11_entry_read':'--entry-read','loader11_hook_read':'--hook-read','loader11_stage_ui_marker':'--stage-ui-marker','loader11_stage_launcher':'--stage-launcher','loader11_arm':'--arm','loader11_disable':'--disable','loader11_hook_install':'--hook-install','loader11_hook_restore':'--hook-restore'}
TOOL='/run/iq4_f1_observe02/entrytool'
READONLY={'loader11_preflight','loader11_entry_read','loader11_hook_read'}
OWN_RAM={'loader11_stage_ui_marker','loader11_stage_launcher'}
def plan(label,nonce):
 if label not in FLAGS or type(nonce)is not str or re.fullmatch('[0-9a-f]{8,12}',nonce)is None:raise ValueError('Fixed Loader11 CLI/nonce only')
 c=original._command(label,TOOL+' '+FLAGS[label]+' 2>&1',nonce)
 if len(c.host_text.encode('ascii'))>242:raise ValueError('Native command bound')
 return Plan(label,c.host_text,nonce,0,'',0,0,USER_SHA),c
def scope(label):
 if label not in FLAGS:raise ValueError('Fixed label')
 if label in READONLY:return 'readonly_fixed_publication_or_preflight'
 if label in OWN_RAM:return 'new_owned_RAM_only_no_runner_or_User_exit'
 if label=='loader11_arm':return 'RAM_runner_one_load_requires_actual_originals_and_verified_restore_no_User_exit_sent'
 if label=='loader11_disable':return 'restore_RAM_runner_retained_module_not_unloaded'
 return 'native_text_transaction_requires_actual_protected_contract_and_kernel_recovery_review'
def serialize(p):
 return p.encode()
