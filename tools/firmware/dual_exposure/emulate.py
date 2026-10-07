#!/usr/bin/env python3
"""Bounded offline A64 factory stepper -> patched adapter -> factory state path.
No User/FWP is emitted and no camera is opened. Allocation, base/child drawing
objects, mutex/event delivery, configured limits, language/text and timer are
fixtures. Factory stepper construction/listener tags/tap/repeat dispatch,
getters/setters, readout bounds, shutter maths and complete Dual update execute.
"""
from pathlib import Path
import hashlib, importlib.util, json, struct, sys
ROOT=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(ROOT/'tools/firmware/dual_exposure_02'))
from emulate_native import Native, bits, unbits, undbits
from unicorn import UC_HOOK_CODE
from unicorn.arm64_const import *

def module(name,path):
    s=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(s);sys.modules[name]=m;s.loader.exec_module(m);return m
m=module('dual_contract_linker',ROOT/'tools/firmware/f1_user_elf_append_02/elf_append.py')
symbols=('iq4_dual_after_open_01','iq4_dual_open_wrapper_01','iq4_dual_long_tick_02','iq4_dual_long_tick_wrapper_02','iq4_dual_label_ctor_03','iq4_dual_attach_03','iq4_dual_attach_wrapper_03','iq4_dual_range_03','iq4_dual_range_wrapper_03','iq4_dual_clamp_base_04','iq4_dual_clamp_base_wrapper_04','iq4_dual_display_ev_04','iq4_dual_display_ev_wrapper_04')
m.REQUIRED_SYMBOLS=symbols
m.ALIASES={'iq4_stock_dual_quantize_02':(0x71b804,'native original quantizer'),'iq4_stock_dual_update_01':(0x5384cc,'native original update'),'iq4_stock_dual_format_04':(0x409f30,'native original snprintf')}
obj=Path(sys.argv[1]).resolve(); out=Path(sys.argv[2]).resolve()
link=m.Linker((ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes(),[(str(obj.relative_to(ROOT)),obj.read_bytes())]);link.relocate()

class UI(Native):
    D=0x10000000;L=0x10001000;M=0x10002000;C=0x10005000;S=0x10006000;CFG=0x1000a000
    EVENT=0x1001b000;VT=0x1001c000;FUN=0x10018000
    def __init__(self):
        super().__init__();self.u.mem_map(0x10000000,0x100000)
        self.u.mem_map(m.NEW_RX_VA,(link.rx_size+4095)&~4095)
        self.u.mem_map(link.rw_va,(link.rw_size+4095)&~4095)
        for s in link.sections:self.u.mem_write(s.va,bytes(s.data))
        for key,index in link.got.items():self.p(link.rw_va+link.got_offset+8*index,link.symbol(key))
        self.sym=link.symbol_addresses;self.alloc=0x10030000;self.controls=[];self.listeners=[];self.attached=0;self.label_width=0;self.formatted=0
        self.nots=0;self.ratio_events=0;self.long_events=0;self.updates=0;self.nativebusy=0;self.minimum=-108;self.maximum=169;self.base_min=4;self.base_max=169;self.readout_ms=100;self.quantizer=0
        functions={0x71e7fc:'config_base',0x40c064:'numeric_cast',0x717584:'config_cache_init',0x712790:'scoped_lock',0x7127c4:'scoped_unlock',0x40c424:'numeric_base',0x70ab3c:'subscription',0x70f12c:'subscription_bind',0x409e60:'alloc',0x4ad230:'label_ctor',0x4ab740:'base_ctor',0x4ae624:'panel_ctor',0x4d1550:'button_ctor',0x4ab898:'attach_child',0x4af694:'enable',0x4d024c:'attach',0x70be10:'timer',0x70bf9c:'timer',0x70bf3c:'timer',0x70c130:'elapsed',0x40c310:'lock',0x40c340:'unlock',0x70f2f8:'notify',0x414b28:'readout',0x409f30:'format',0x457b10:'text',self.FUN:'busy',self.FUN+4:'long_min',self.FUN+8:'long_max',self.FUN+12:'panel_attach',self.FUN+16:'touch_listener',self.FUN+20:'key_listener',self.FUN+24:'range',self.FUN+28:'underlying',self.FUN+32:'language',self.FUN+36:'status_event'}
        for name in ('memcmp','memcpy'):
            functions[link.used_imports[name]['va']]=name
        for pc,name in functions.items():self.u.hook_add(UC_HOOK_CODE,self.stub,name,begin=pc,end=pc)
        for pc,name in ((0x5384cc,'update'),(0x71b804,'quantize')):self.u.hook_add(UC_HOOK_CODE,self.observe,name,begin=pc,end=pc)
        self.p(self.D,0xba2608);self.p(self.D+0xb0,self.M);self.p(self.M+0x790,self.C);self.p(self.C+0x30,self.S);self.p(self.C+0x38,self.CFG)
        self.p(self.D+0x3c8,self.L);self.p(self.L,0xb846f0);self.p(self.D+0x3d8,self.CFG+0x118);self.p(self.D+0x3e0,self.CFG+0x1468);self.p(self.D+0x3e8,self.CFG+0x1370)
        self.p(self.CFG+0x1370,0xbc1088);self.p(self.CFG+0x1378,self.S+0x1080);self.p(self.S+0x1080,0x9f8508);self.p(self.D+0x380,0x10019000);self.p(0x10019000,self.VT);self.p(self.VT+0x40,self.FUN)
        self.p(self.CFG+0x1468,self.VT+0x200);self.p(self.VT+0x2f8,self.FUN+4);self.p(self.VT+0x300,self.FUN+8)
        self.p(self.CFG+0x118,self.VT+0x400);self.p(self.VT+0x4f0,self.FUN+24);self.p(self.VT+0x518,self.FUN+28)
        self.p(self.S+0xe8,self.VT+0x600);self.p(self.VT+0x648,0x40c8b4)
        self.p(self.M+0x788,0x1001e000);self.p(0x1001e010,0x1001e100);self.p(0x1001e100,self.VT+0x800);self.p(self.VT+0x810,self.FUN+32)
        self.p(self.VT+0xac8,self.FUN+12);self.p(self.VT+0xb10,self.FUN+16);self.p(self.VT+0xb00,self.FUN+20)
        self.u.mem_write(self.D+0x128,b'\1');self.i(self.D+0x404,4);self.i(self.D+0x408,169);self.base(104);self.ratio(8)
        for pc,name in ((0x536eb4,'iq4_dual_label_ctor_03'),(0x536ed4,'iq4_dual_attach_wrapper_03'),(0x537e68,'iq4_dual_open_wrapper_01'),(0x538540,'iq4_dual_long_tick_wrapper_02'),(0x5387a0,'iq4_dual_range_wrapper_03'),(0x538810,'iq4_dual_clamp_base_wrapper_04'),(0x53865c,'iq4_dual_display_ev_wrapper_04')):
            delta=(self.sym[name]-pc)//4;self.u.mem_write(pc,struct.pack('<I',0x94000000|(delta&0x3ffffff)))
    def p(self,a,v):self.u.mem_write(a,struct.pack('<Q',v))
    def i(self,a,v):self.u.mem_write(a,struct.pack('<i',v))
    def q(self,a):return struct.unpack('<Q',self.u.mem_read(a,8))[0]
    def integer(self,a):return struct.unpack('<i',self.u.mem_read(a,4))[0]
    def base(self,v):self.i(self.S+0x1a8,v)
    def ratio(self,v=None):
        if v is not None:self.u.mem_write(self.S+0x1140,struct.pack('<f',v))
        return struct.unpack('<f',self.u.mem_read(self.S+0x1140,4))[0]
    def observe(self,u,pc,size,name):
        if name=='update':self.updates+=1
        else:self.quantizer+=1
    def stub(self,u,pc,size,name):
        x=[u.reg_read(UC_ARM64_REG_X0+i) for i in range(8)];r=x[0]
        if name=='alloc':r=self.alloc;self.alloc+=(x[0]+15)&~15;u.mem_write(r,bytes(x[0]))
        elif name=='label_ctor':self.label_width=x[1];self.p(x[0],0xb846f0);self.i(x[0]+0x38,x[1]);self.i(x[0]+0x3c,x[2])
        elif name in ('base_ctor','panel_ctor','button_ctor'):
            self.p(x[0],self.VT+0xa00)
            if name=='button_ctor':self.controls.append(dict(pointer=x[0],glyph=x[7]))
        elif name in ('touch_listener','key_listener'):self.listeners.append(dict(kind=name,widget=x[0],listener=x[1],tag=x[2]))
        elif name=='attach':self.attached=x[1]
        elif name in ('attach_child','panel_attach'):
            if x[1]==self.L:self.i(x[1]+0x44,x[4]);self.i(x[1]+0x48,x[5])
        elif name=='notify':
            self.nots+=1;self.ratio_events+=int(x[0]==self.S+0x1088);self.long_events+=int(x[0]==self.S+0x1168)
        elif name=='range':self.base_min=x[1] if x[1]<(1<<31) else x[1]-(1<<32);self.base_max=x[2] if x[2]<(1<<31) else x[2]-(1<<32)
        elif name=='underlying':r=self.S+0xe8
        elif name=='busy':r=self.nativebusy
        elif name=='long_min':r=self.minimum&0xffffffff
        elif name=='long_max':r=self.maximum&0xffffffff
        elif name=='readout':r=self.readout_ms
        elif name=='language':r=0
        elif name=='elapsed':r=200
        elif name=='memcmp':r=int(bytes(u.mem_read(x[0],x[2]))!=bytes(u.mem_read(x[1],x[2])))
        elif name=='memcpy':u.mem_write(x[0],bytes(u.mem_read(x[1],x[2])))
        elif name=='format':self.formatted=undbits(u.reg_read(UC_ARM64_REG_D0));u.mem_write(x[0],b'EV\0');r=2
        elif name=='status_event':r=self.EVENT
        elif name not in ('config_base','numeric_cast','config_cache_init','scoped_lock','scoped_unlock','lock','unlock','text','timer','attach_child','panel_attach','enable','numeric_base','subscription','subscription_bind'):raise AssertionError(name)
        u.reg_write(UC_ARM64_REG_X0,r);u.reg_write(UC_ARM64_REG_PC,u.reg_read(UC_ARM64_REG_LR))
    def call(self,pc,*args,stack=None,stop=0x1000):
        for i,x in enumerate(args):self.u.reg_write(UC_ARM64_REG_X0+i,x)
        self.u.reg_write(UC_ARM64_REG_SP,0x7001f000);self.u.reg_write(UC_ARM64_REG_LR,stop)
        if stack:
            for offset,value in stack.items():self.p(0x7001f000+offset,value)
        self.u.emu_start(pc,stop,count=250000);assert self.u.reg_read(UC_ARM64_REG_PC)==stop,hex(self.u.reg_read(UC_ARM64_REG_PC))
    def tap(self,tag,kind=1):
        self.i(self.EVENT,kind);self.call(0x4d2058,self.attached,0,self.EVENT,tag)

ui=UI();sp=0x7001f000
# Full original configuration ctor, table args, complete numeric ctor and
# getters. Base/subscriber initialization and cache-init remain explicit traps.
ui.p(ui.VT+0x610,ui.FUN+36);ui.p(ui.VT+0x640,0x40c880)
ui.p(ui.S+0x1160,ui.VT+0x600)
ctor_ranges=[]
for cfg,status in ((ui.CFG+0x118,ui.S+0xe8),(ui.CFG+0x1468,ui.S+0x1160)):
    ui.call(0x71ca38,cfg,status,12,0xc264d8,163,0,0)
    ui.call(0x536168,cfg)
    maximum=ui.u.reg_read(UC_ARM64_REG_W0)
    assert maximum==169 and ui.integer(cfg+0x34)==2
    ctor_ranges.append(dict(config=hex(cfg),minimum=ui.integer(cfg+0x28),maximum=maximum,step=ui.integer(cfg+0x34),vtable=hex(ui.q(cfg))))
# Keep the actual range function and property getter. Cache policy/notices are
# original code; only event delivery is trapped by this fixture.
ui.call(0x537ce0,stack={0x18:ui.D,0x38:ui.C},stop=0x537d54)
assert ui.integer(ui.D+0x408)==169 and ui.integer(ui.D+0x414)==104
ui.i(sp+0x1b8,350);ui.i(sp+0x1b4,70);ui.i(sp+0x198,4)
ui.p(sp+0x1e0,0x1001f000);ui.p(sp+0xa8,ui.D);ui.p(sp+0x170,0x1001f100)
ui.u.reg_write(UC_ARM64_REG_X19,ui.L);ui.call(0x536e88,stop=0x536ed8)
assert ui.label_width==154 and ui.attached!=ui.L
assert ui.integer(ui.L+0x44)==12 and ui.integer(ui.L+0x48)==10
assert [x['glyph'] for x in ui.controls]==[0xb8bcd0,0xb8bcd8]
assert [x['tag'] for x in ui.listeners if x['kind']=='touch_listener']==[1,2]
ui.call(0x537e5c,stack={0x18:ui.D},stop=0x537e6c)
assert ui.ratio()==8 and ui.integer(ui.D+0x408)==169
native=Native()
query_ticks=[];range_calls=[];clamp_writes=[];pending={};short_notifications=[];factory_bound_calls=[]
def watch_query(u,pc,size,data):
    tick=u.reg_read(UC_ARM64_REG_W0)
    if tick>=0x80000000:tick-=0x100000000
    query_ticks.append(tick)
    assert 0<=tick<=166,('ordinary seconds query',tick)
def watch_range(u,pc,size,data):
    range_calls.append(dict(config=hex(u.reg_read(UC_ARM64_REG_X0)),minimum=u.reg_read(UC_ARM64_REG_W1),maximum=u.reg_read(UC_ARM64_REG_W2)))
def watch_factory_bounds(u,pc,size,data):
    factory_bound_calls.append(dict(minimum=u.reg_read(UC_ARM64_REG_W1),maximum=u.reg_read(UC_ARM64_REG_W2)))
def watch_clamp(u,pc,size,data):
    pending.clear();pending.update(original_value=u.reg_read(UC_ARM64_REG_W1),ratio=ui.ratio())
def watch_setter(u,pc,size,data):
    if u.reg_read(UC_ARM64_REG_X0)==ui.S+0xe8:
        clamp_writes.append(dict(pending,actual_value=u.reg_read(UC_ARM64_REG_W1),original_setter='0x40c8b4'))
def watch_notify(u,pc,size,data):
    if u.reg_read(UC_ARM64_REG_X0)==ui.S+0xf0:short_notifications.append(ui.integer(ui.S+0x1a8))
for pc,callback in ((0x5387a0,watch_factory_bounds),(0x71b538,watch_query),(0x536108,watch_range),(ui.sym['iq4_dual_clamp_base_wrapper_04'],watch_clamp),(0x40c8b4,watch_setter),(0x70f2f8,watch_notify)):
    ui.u.hook_add(UC_HOOK_CODE,callback,None,begin=pc,end=pc)
cycles=[]
def record(direction,n):
    assert ui.ratio()==unbits(bits(2**(n/3))) and abs(ui.formatted-n/3)<1e-6
    short=ui.integer(ui.S+0x1a8);long=ui.integer(ui.S+0x1220)
    seconds=unbits(bits(native.seconds(short)*ui.ratio()))
    assert 0<=short<=166 and seconds<=1 and long==native.tick(seconds)
    cycles.append(dict(direction=direction,third=n,ratio=ui.ratio(),short_tick=short,long_tick=long,requested_EV=ui.formatted,requested_long_seconds=seconds,native_configuration_max=ui.integer(ui.D+0x408)))
# Actual default3EV both directions first, then the supported1/3..5EV bounds.
ui.tap(1);record('first-left',8)
ui.tap(2);record('first-right',9)
for n in range(10,16):ui.tap(2);record('right',n)
count=ui.ratio_events;ui.tap(2);assert ui.ratio_events==count
for n in range(14,0,-1):ui.tap(1);record('left',n)
count=ui.ratio_events;ui.tap(1);assert ui.ratio_events==count
for n in range(2,16):ui.tap(2);record('right',n)
count=ui.ratio_events;ui.tap(2,32);assert ui.ratio_events==count
ui.tap(1,32);record('held-left',14)
ui.tap(2,32);record('held-right',15)
ui.nativebusy=1;count=ui.ratio_events;ui.tap(1);assert ui.ratio_events==count;ui.nativebusy=0
# Set current short using the original bare setter. The original OnOpen getter
# snapshots it into D+414; no invented config getter clamp is installed.
limits=[]
for minimum in (0,4):
    ui.i(ui.CFG+0x1490,minimum)
    ui.call(0x40c8b4,ui.S+0xe8,4)
    ui.call(0x537d38,stack={0x18:ui.D,0x38:ui.C},stop=0x537d54)
    ui.call(0x538684,ui.D);ui.call(0x5384cc,ui.D)
    short=ui.integer(ui.S+0x1a8);long=ui.integer(ui.S+0x1220)
    requested=unbits(bits(native.seconds(short)*32))
    assert short==(62 if minimum==0 else 64) and long==native.tick(requested)
    assert requested<=native.seconds(minimum) and long>=minimum
    assert any(x.get('original_value')==42 and x['actual_value']==short for x in clamp_writes)
    limits.append(dict(native_long_min_tick=minimum,short_tick=short,long_tick=long,requested_long_seconds=requested,native_readout_lower_tick=ui.integer(ui.D+0x418),ordinary_query_max=166))
# Fast source/configuration sentinel168 is admitted as factory data but the
# extension clamps the short setter to ordinary tick166 before stock update.
ui.i(ui.CFG+0x1490,0);ui.call(0x40c8b4,ui.S+0xe8,168)
ui.call(0x537d38,stack={0x18:ui.D,0x38:ui.C},stop=0x537d54)
ui.call(0x538684,ui.D);ui.call(0x5384cc,ui.D)
assert ui.integer(ui.S+0x1a8)==166
fast_endpoint=dict(factory_selected_tick=168,extension_short_tick=166,seconds=native.seconds(166),requested_long_seconds=unbits(bits(native.seconds(166)*32)))
# One tighter native readout constraint, using the real factory conversion
# and bounds code. Keep the long limit at1s and request just1/3EV.
ui.readout_ms=200
ui.u.reg_write(UC_ARM64_REG_S0,bits(2**(1/3)));ui.call(0x44136c,ui.S+0x1080)
ui.call(0x40c8b4,ui.S+0xe8,4)
ui.call(0x537d38,stack={0x18:ui.D,0x38:ui.C},stop=0x537d54)
ui.call(0x538684,ui.D);ui.call(0x5384cc,ui.D)
factory_min=factory_bound_calls[-1]['minimum']
assert factory_min>6 and ui.integer(ui.D+0x418)>=factory_min and ui.integer(ui.S+0x1a8)>=factory_min
readout_case=dict(readout_ms_fixture=200,native_minimum_tick=factory_min,extension_minimum_tick=ui.integer(ui.D+0x418),final_short_tick=ui.integer(ui.S+0x1a8),requested_ratio=ui.ratio(),requested_long_seconds=unbits(bits(native.seconds(ui.integer(ui.S+0x1a8))*ui.ratio())))
assert readout_case['requested_long_seconds']<=1
result=dict(schema='iq4_dual_5ev_real_domain_native_A64_02',object=dict(path=str(obj.relative_to(ROOT)),bytes=obj.stat().st_size,sha256=hashlib.sha256(obj.read_bytes()).hexdigest()),original_stock_sha256=m.BASE_SHA,native_import_bindings=link.used_imports,native_configuration_ctor_ranges=ctor_ranges,actual_full_config_ctor='0x71ca38',actual_numeric_constructor='0x71e184',actual_max_getter='0x536168',actual_Open_domain_getter_window='0x537ce0..0x537d54',actual_Open_bounds_then_update='0x537e5c..0x537e6c',cycles=cycles,limits=limits,fast_endpoint=fast_endpoint,ordinary_seconds_query_ticks=sorted(set(query_ticks)),native_range_calls=range_calls,original_factory_bound_calls=factory_bound_calls,stricter_native_readout_case=readout_case,post_bounds_bare_setter_writes=clamp_writes,native_short_notifications=short_notifications,arrow_glyphs=ui.controls,listeners=ui.listeners,label_width=ui.label_width,label_flags=ui.integer(ui.L+0x44),label_inset=ui.integer(ui.L+0x48),default_ratio=8,maximum_ratio=32,actual_native_stepper_ctor=True,actual_tap_and_hold_repeat=True,actual_float_and_u32_setters=True,actual_complete_native_range_function=True,actual_complete_stock_dual_update=True,requested_long_seconds_cap=1.0,original_sequence_busy_refusal=True,fixtures=['allocation','base/child UI construction and rendering','numeric base and subscriber initialization','config cache initial subscription','mutex/event delivery','readout100ms','timer200ms','language/text sink'],target_executed=False,camera_accessed=False,optical_exposure_measured=False,IIQ_metadata_validated=False)
out.write_text(json.dumps(result,indent=2)+'\n')
print('Full native max169 config ctor/Open ->15 ratios native taps/holds ->native range+bared setter clamp+notify ->stock quantizer passed; requested-seconds cap only, no device.')
