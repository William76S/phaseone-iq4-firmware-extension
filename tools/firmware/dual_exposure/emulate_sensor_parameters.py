#!/usr/bin/env python3
"""New UI Ratio values -> original controller and sensor parameter paths.
Original A64 executes; timing values are synthetic and all register I/O traps
log memory-only operations. This is not camera exposure or IIQ/C1 acceptance.
"""
from pathlib import Path
import hashlib, importlib.util, json, sys
ROOT=Path(__file__).resolve().parents[3]
SOURCE=ROOT/'analysis/firmware/dual_capture_semantics_01/emulate_sensor.py'
spec=importlib.util.spec_from_file_location('dual50_native_sensor',SOURCE)
m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
from unicorn.arm64_const import UC_ARM64_REG_W0
receipt=Path(sys.argv[1]).resolve();out=Path(sys.argv[2]).resolve()
assert receipt.is_relative_to(ROOT) and out.is_relative_to(ROOT)
j=json.loads(receipt.read_text());assert j['maximum_ratio']==32 and all(c['maximum']==169 for c in j['native_configuration_ctor_ranges'])
ui={}
for index,c in enumerate(j['cycles']):
    if c['third'] not in ui:ui[c['third']]=(index,c)
assert sorted(ui)==list(range(1,16))
cases=[]
for chip,vt,integration in [('IMX411',0xd90028,0x822a98),('IMX461',0xd8eee0,0x81c17c)]:
 for n,(index,c) in sorted(ui.items()):
    s=m.Sensor(chip,vt,integration)
    ratio=c['ratio'];short_us=2500
    s.f(s.STATUS+0x1140,ratio);s.f(s.SENSOR+0x138,8.0)
    s.call(0x79cb08,s.CONTROLLER,s.STATUS+0x1088,stop=0x79cbb0)
    assert s.floating(s.SENSOR+0x138)==ratio
    s.call(s.integration_dispatch,s.SENSOR,short_us)
    assert s.u.reg_read(UC_ARM64_REG_W0)==1
    hdr=[x for x in s.logs if x['format'].startswith('Setup HDR Times')]
    assert len(hdr)==1 and len(s.products)==1
    product=s.products[0];t=hdr[0]['values']
    assert product['short_us']==short_us and t[:2]==[product['requested_long_us'],short_us]
    assert product['requested_long_us']<=1_000_000
    actual=s.floating(s.SENSOR+0x134)
    assert t[2]>0 and t[3]>0 and abs(actual-t[2]/t[3])<0.00001
    cases.append(dict(chip=chip,UI_cycle_index=index,UI_thirds=n,UI_Ratio=ratio,native_controller_callback='0x79cb08..0x79cbb0',native_sensor_ratio=s.floating(s.SENSOR+0x138),native_mode_dispatch=hex(s.integration_dispatch),native_integration=hex(integration),fixture_short_us=short_us,requested_long_us=product['requested_long_us'],quantized_short_us=t[3],quantized_long_us=t[2],quantized_ratio=actual,register_operations=s.ops))
result=dict(schema='iq4_dual50_UI_native_sensor_parameters_01',new_UI_object=j['object'],UI_receipt=dict(path=str(receipt.relative_to(ROOT)),sha256=hashlib.sha256(receipt.read_bytes()).hexdigest()),stock_sha256=m.SHA,fixture_source=dict(path=str(SOURCE.relative_to(ROOT)),sha256=hashlib.sha256(SOURCE.read_bytes()).hexdigest()),cases=cases,synthetic_timing=dict(H=7200,lines=15000,clock_ticks_per_us=72,mode=3,short_us=2500),all_15_UI_float_values_reach_original_sensor_ratio_setter=True,original_native_mode_dispatch_and_integration_execute=True,requested_long_cap_verified_in_UI_separately=True,UI_notification_delivery_fixture=True,controller_event_invocation_explicit=True,short_us_is_fixture_not_automatic_UI_capture_conversion=True,sensor_IO_sent=False,hardware_executed=False,actual_optical_exposure_measured=False,IIQ_metadata_validated=False,CaptureOne_merge_validated=False)
out.write_text(json.dumps(result,indent=2)+'\n')
print('All15 new UI Ratio float values reach original controller/sensor setter+mode/integration for two original sensor types; synthetic timing, no I/O.')
