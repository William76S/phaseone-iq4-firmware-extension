"""Read fixed original bytes and emit independent static evidence. No target execution."""
from pathlib import Path
import hashlib,json,struct

def collect(root,here,out,run,dump):
    raw=(root/'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes()
    lock=json.loads((here/'native_signature_lock.json').read_text())
    assert len(raw)==lock['stock_bytes'] and hashlib.sha256(raw).hexdigest()==lock['stock_sha256']
    hdr=struct.unpack_from('<16sHHIQQQIHHHHHH',raw)
    segments=[struct.unpack_from('<IIQQQQQQ',raw,hdr[5]+i*hdr[9])for i in range(hdr[10])]
    rows=[]
    for region in lock['regions']:
        va=int(region['va'],16);end=int(region['end_exclusive'],16);size=end-va
        covering=[s for s in segments if s[0]==1 and s[3]<=va and end<=s[3]+s[5]]
        assert len(covering)==1
        segment=covering[0];offset=segment[2]+va-segment[3];body=raw[offset:offset+size]
        assert len(body)==region['bytes'] and hashlib.sha256(body).hexdigest()==region['sha256']
        row=dict(region,file_offset=offset,raw_hex=body.hex())
        if region['kind']=='code':
            path=out/(region['name']+'.txt')
            path.write_text(run([dump,'-d','--start-address='+region['va'],'--stop-address='+region['end_exclusive'],root/'analysis/firmware/extracted/P1Linux_6.03.21.bin']))
            row['disassembly']=str(path.relative_to(root))
            row['disassembly_sha256']=hashlib.sha256(path.read_bytes()).hexdigest()
        rows.append(row)
    evidence=dict(lock,regions=rows,stage='static exact bytes only',host_fixture_is_native_execution=False,
        old_display12_reuse_reference='analysis/firmware/f1_stock_display_payload_build_12/EXACT_NATIVE.json')
    (out/'EXACT_NATIVE.json').write_text(json.dumps(evidence,indent=2)+'\n')
    return evidence
