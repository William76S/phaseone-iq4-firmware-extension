#!/usr/bin/env python3
"""OWN C++ binary fixture checks; no external process/device reads."""
import json,struct,sys
from pathlib import Path
from decode_observation import SIZE,USER_SHA256,decode_samples
raw=Path(sys.argv[1]).read_bytes();assert len(raw)==SIZE
count=0
def good(b,**kwargs):
    global count
    r=decode_samples(b,b,**kwargs);count+=1;return r
def bad(b,second=None,**kwargs):
    global count
    try:decode_samples(b,b if second is None else second,**kwargs)
    except ValueError:count+=1;return
    raise AssertionError('bad publication accepted')
def change(at,fmt,v):
    b=bytearray(raw);struct.pack_into(fmt,b,at,v);return bytes(b)
r=good(raw);assert r['shape_candidate']=='home_class_candidate_then_lv'and r['embedded_entry_source']['phase']=='lv_not_current'and not r['hardware_verified']
old=struct.pack('<4I',2,440,4,0)+raw[192:616]
assert good(raw,entry_first=old,entry_second=old)['paired_unchanged_entry_publication']
# Explicit synthetic Geometry04 rejection fixture; not a camera receipt.
geo=bytearray(760);struct.pack_into('<4I',geo,0,2,760,4,0);struct.pack_into('<4I',geo,16,4,744,1,0)
struct.pack_into('<5Q',geo,32,1,0,1,0,1);geo[72:104]=bytes.fromhex(USER_SHA256);struct.pack_into('<Q',geo,104,11874544);struct.pack_into('<I',geo,136,4);geo[160:584]=raw[192:616]
assert good(raw,geometry_first=bytes(geo),geometry_second=bytes(geo))['paired_unchanged_geometry04_result']=='owner_rejected'
prior=Path(sys.argv[1]+'.prior.bin').read_bytes();r=good(prior)
assert r['shape_candidate']=='home_class_candidate_then_lv_then_popup'and r['source_relation']=='prior_entry_owner_anchor'and r['snapshot_epoch']==2 and r['source_dispatch_epoch']==1 and r['embedded_entry_source']['original_stack_candidate']['normal_dialogs'][-1]==r['embedded_entry_source']['objects']['lv']and r['selected_dialog_branch_projection']==r['embedded_entry_source']['objects']['stock_popup']
default=bytearray(SIZE);struct.pack_into('<4I',default,0,0,SIZE,5,0);struct.pack_into('<4I',default,16,5,1176,0,0);default[80:112]=bytes.fromhex(USER_SHA256);struct.pack_into('<Q',default,112,11874544);struct.pack_into('<2I',default,192,1,424)
assert good(bytes(default))['result']=='not_attempted'
failure=bytearray(raw);struct.pack_into('<2I',failure,24,5,0);struct.pack_into('<Q',failure,40,0);struct.pack_into('<2Q',failure,64,0,1);struct.pack_into('<2I',failure,128,0,0);failure[168:192]=bytes(24);failure[616:]=bytes(576)
assert good(bytes(failure))['stack_facts']is None
for at,fmt,v in [(0,'<I',1),(4,'<I',1191),(8,'<I',4),(12,'<I',1),(16,'<I',4),(20,'<I',1175),(24,'<I',7),(28,'<I',0),(32,'<Q',65),(40,'<Q',2),(48,'<Q',2),(56,'<Q',1),(64,'<Q',0),(72,'<Q',1),(112,'<Q',11874543),(120,'<I',3),(124,'<I',2),(128,'<I',1),(132,'<I',0),(136,'<I',1),(140,'<I',1),(144,'<I',1),(148,'<I',1),(152,'<I',1),(156,'<I',1),(160,'<I',1),(164,'<I',1),(168,'<Q',2),(176,'<Q',0),(184,'<Q',0),(192,'<I',2),(200,'<I',3),(664,'<I',1),(668,'<I',9),(672,'<I',0),(676,'<I',0),(704,'<Q',0xb9a9d8),(736,'<I',2),(740,'<I',0),(744,'<Q',0),(1191,'<B',1)]:bad(change(at,fmt,v))
bad(raw[:-1]);bad(bytearray(raw));bad(raw,bytes(default));bad(raw,entry_first=old);bad(raw,geometry_first=bytes(geo));bad(raw,entry_first=old,entry_second=old[:-1]);bad(raw,geometry_first=bytes(geo),geometry_second=bytes(760))
b=bytearray(raw);b[80]^=1;bad(bytes(b));b=bytearray(failure);b[616]=1;bad(bytes(b))
print(json.dumps({'schema':'stack05_decoder_controls','checks':count,'passed':True,'target_loaded':False,'process_or_device_reads':0}))
