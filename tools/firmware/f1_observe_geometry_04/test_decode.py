#!/usr/bin/env python3
"""Exact OWN wire controls from host C++ output, no target/process reader."""
import json,struct,sys
from pathlib import Path
from decode_observation import SIZE,USER_SHA256,USER_BYTES,decode_samples

def main():
    p=Path(sys.argv[1]);raw=p.read_bytes();assert len(raw)==SIZE
    passed=0
    def good(a,b=None,old=None):
        nonlocal passed
        r=decode_samples(a,a if b is None else b,old,old);passed+=1;return r
    def bad(a,b=None,old=None):
        nonlocal passed
        try:decode_samples(a,a if b is None else b,old,old)
        except ValueError:passed+=1;return
        raise AssertionError('invalid own publication accepted')
    def change(offset,fmt,value):
        a=bytearray(raw);struct.pack_into(fmt,a,offset,value);return bytes(a)
    r=good(raw);assert r['geometry_epoch']==1 and r['scalars']['locked_slot_dimensions_candidate']==[1024,764] and not r['full_source_mapping_verified']
    old=struct.pack('<4I',2,440,4,0)+raw[160:584];assert good(raw,old=old)['old_new_exact_observation_pair_verified']
    default=bytearray(SIZE);struct.pack_into('<4I',default,0,0,SIZE,4,0);struct.pack_into('<4I',default,16,4,744,8,0)
    default[72:104]=bytes.fromhex(USER_SHA256);struct.pack_into('<Q',default,104,USER_BYTES);struct.pack_into('<2I',default,160,1,424)
    assert good(bytes(default))['result']=='not_attempted'
    failure=bytearray(raw);struct.pack_into('<2I',failure,24,1,0);struct.pack_into('<Q',failure,40,0);struct.pack_into('<2Q',failure,56,0,1);failure[112:136]=bytes(24);failure[584:]=bytes(176)
    assert good(bytes(failure))['scalars']is None
    bad(raw[:-1]);bad(raw,bytes(default));bad(bytearray(raw));bad(raw,old=struct.pack('<4I',2,440,3,0)+raw[160:584])
    for offset,fmt,value in [(0,'<I',1),(4,'<I',759),(8,'<I',3),(12,'<I',1),(16,'<I',3),(20,'<I',743),(24,'<I',5),(24,'<I',8),(28,'<I',0),(32,'<Q',65),(40,'<Q',2),(48,'<Q',2),(56,'<Q',0),(64,'<Q',1),(104,'<Q',USER_BYTES-1),(112,'<Q',0),(120,'<Q',2),(128,'<Q',123456),(136,'<I',3),(140,'<I',1),(144,'<I',1),(148,'<I',1),(152,'<I',1),(156,'<I',1),(160,'<I',2),(168,'<I',3),(712,'<I',17),(720,'<I',2),(752,'<I',0),(756,'<I',1),(692,'<i',-1),(708,'<I',4),(672,'<i',45),(664,'<f',float('nan')),(668,'<f',0.0)]:bad(change(offset,fmt,value))
    assert good(change(704,'<I',0))['scalars']['software_completion_id_candidate']==0
    a=bytearray(raw);a[72]^=1;bad(bytes(a))
    a=bytearray(failure);a[584]=1;bad(bytes(a))
    a=bytearray(raw);struct.pack_into('<i',a,656,-3);bad(bytes(a))
    a=bytearray(old);a[160]^=1;bad(raw,old=bytes(a))
    print(json.dumps({'schema':'f1_geometry04_decoder_controls','checks':passed,'passed':True,'target_loaded':False,'process_or_device_reads':0}))
if __name__=='__main__':main()
