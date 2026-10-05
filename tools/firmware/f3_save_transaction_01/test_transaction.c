#include "transaction.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
/* Owned synthetic encoder bytes; these fixtures do not claim real JPEG entropy decode. */
static uint8_t input[131073],stored[131073],scratch[65536];
static const uint8_t header[]={255,216,255,192,0,17,8,0,48,0,64,3,1,17,0,2,17,0,3,17,0,
                             255,218,0,12,3,1,0,2,0,3,0,0,63,0};
struct Mock {unsigned phase,fail_phase,unknown_phase,short_phase,corrupt,swap_inode,swap_stat,
             raw_checks,stale_raw,removed,published,calls_after_unknown,unknown,write_open,read_open;
             size_t written,read_off;struct F3File file;};
static struct F3Io io(struct Mock*m,unsigned phase,uint64_t n) {
    if(m->unknown)++m->calls_after_unknown;
    m->phase=phase;
    if(m->unknown_phase==phase){m->unknown=1;return(struct F3Io){F3_IO_UNKNOWN,0};}
    if(m->fail_phase==phase)return(struct F3Io){F3_IO_FAIL,0};
    return(struct F3Io){F3_IO_DONE,m->short_phase==phase?n-1:n};
}
static struct F3Io raw(void*v,const struct F3Job*j) {
    struct Mock*m=v;++m->raw_checks;
    assert(j->raw.task_nonce==9&&j->raw.bytes==1000);
    return io(m,m->raw_checks==1?1:15,m->stale_raw&&m->raw_checks==2?0:1);
}
static struct F3Io openw(void*v,const struct F3Job*j,struct F3File*f) {
    struct Mock*m=v;*f=(struct F3File){11,22,j->raw.card_epoch,j->raw.task_nonce,0};m->file=*f;
    struct F3Io r=io(m,2,1);if(r.state==F3_IO_DONE)m->write_open=1;return r;
}
static struct F3Io writefile(void*v,const uint8_t*p,uint32_t n) {
    struct Mock*m=v;assert(m->write_open);struct F3Io r=io(m,4,n);
    if(r.state==F3_IO_DONE){assert(m->written+r.value<=sizeof(stored));memcpy(stored+m->written,p,(size_t)r.value);m->written+=(size_t)r.value;}
    return r;
}
static struct F3Io closew(void*v) {
    struct Mock*m=v;assert(m->write_open);struct F3Io r=io(m,6,1);
    if(r.state!=F3_IO_UNKNOWN)m->write_open=0;return r;
}
static struct F3Io openr(void*v,const struct F3File*f,struct F3File*out) {
    struct Mock*m=v;assert(!m->write_open);*out=*f;out->bytes=m->written;if(m->swap_inode)++out->inode;
    m->file=*out;struct F3Io r=io(m,7,1);if(r.state==F3_IO_DONE)m->read_open=1;return r;
}
static struct F3Io readfile(void*v,uint8_t*p,uint32_t n) {
    struct Mock*m=v;assert(m->read_open);struct F3Io r=io(m,9,n);
    if(r.state==F3_IO_DONE){assert(m->read_off+r.value<=m->written);memcpy(p,stored+m->read_off,(size_t)r.value);m->read_off+=(size_t)r.value;if(m->corrupt)p[0]^=1;}
    return r;
}
static struct F3Io statfile(void*v,struct F3File*out) {
    struct Mock*m=v;assert(m->read_open);*out=m->file;if(m->swap_stat)++out->bytes;return io(m,11,1);
}
static struct F3Io closer(void*v) {
    struct Mock*m=v;assert(m->read_open);struct F3Io r=io(m,13,1);if(r.state!=F3_IO_UNKNOWN)m->read_open=0;return r;
}
static struct F3Io publish(void*v,const struct F3File*f) {
    struct Mock*m=v;assert(!m->write_open&&!m->read_open&&f->bytes==sizeof(input));
    struct F3Io r=io(m,14,1);if(r.state==F3_IO_DONE)m->published=1;return r;
}
static struct F3Io remove_raw(void*v,const struct F3Job*j) {
    struct Mock*m=v;assert(m->published&&j->purpose==F3_NEW_CAPTURE&&j->newly_created_raw_stage&&m->raw_checks==2);
    struct F3Io r=io(m,16,1);if(r.state==F3_IO_DONE)m->removed=1;return r;
}
static struct F3Ports ports(struct Mock*m) {
    return(struct F3Ports){m,raw,openw,writefile,closew,openr,readfile,statfile,closer,publish,remove_raw};
}
static struct F3Job job(unsigned mode) {
    struct F3Job j={0};j.boot_epoch=1;j.capture_id=2;j.mode=mode;j.purpose=F3_NEW_CAPTURE;
    j.newly_created_raw_stage=1;j.source_raw_width=14204;j.source_raw_height=10652;
    j.render_width=j.output_width=64;j.render_height=j.output_height=48;j.render_source_kind=1;
    j.raw=(struct F3File){11,12,13,9,1000};j.render_source=j.raw;j.encoded=input;j.encoded_bytes=sizeof(input);return j;
}
static struct F3Result run(struct Mock*m,struct F3Job*j) {struct F3Ports p=ports(m);struct F3Session s={1,0,0};return f3_checked_save_01(&s,j,&p,scratch,sizeof(scratch));}
int main(void) {
    memset(input,2,sizeof(input));memcpy(input,header,sizeof(header));input[sizeof(input)-2]=255;input[sizeof(input)-1]=217;
    unsigned tests=0;struct Mock m={0};struct F3Job j=job(F3_JPEG_ONLY);struct F3Result r=run(&m,&j);
    assert(r.status==F3_JPEG_ONLY_DONE&&r.raw_removed&&r.published&&r.verified_bytes==sizeof(input)&&r.write_calls==3&&r.read_calls==3);++tests;
    m=(struct Mock){0};j=job(F3_RAW_JPEG);r=run(&m,&j);assert(r.status==F3_JPEG_WITH_RAW&&!m.removed);++tests;
    m=(struct Mock){0};j=job(F3_RAW);j.encoded=0;r=run(&m,&j);assert(r.status==F3_RAW_RETAINED&&m.phase==1&&!r.write_calls);++tests;
    m=(struct Mock){0};j=job(F3_JPEG_ONLY);j.purpose=F3_MANUAL_EXISTING_RAW;j.newly_created_raw_stage=0;r=run(&m,&j);assert(r.status==F3_JPEG_WITH_RAW&&!m.removed);++tests;
    m=(struct Mock){0};j=job(F3_JPEG_ONLY);j.newly_created_raw_stage=0;r=run(&m,&j);assert(r.status==F3_JPEG_WITH_RAW&&!m.removed);++tests;
    const unsigned phases[]={1,2,4,6,7,9,11,13,14,15,16};
    for(size_t i=0;i<sizeof(phases)/sizeof(phases[0]);++i){
        m=(struct Mock){0};m.fail_phase=phases[i];j=job(F3_JPEG_ONLY);r=run(&m,&j);
        assert(r.status==F3_FAILED_RAW_RETAINED&&!m.removed&&!m.write_open&&!m.read_open);++tests;
        m=(struct Mock){0};m.unknown_phase=phases[i];r=run(&m,&j);
        assert(r.status==F3_UNKNOWN_HOLD&&!m.calls_after_unknown&&!m.removed);++tests;
    }
    m=(struct Mock){0};m.short_phase=4;j=job(F3_JPEG_ONLY);r=run(&m,&j);assert(r.status==F3_FAILED_RAW_RETAINED&&!m.published&&!m.removed&&r.close_write_calls==1);++tests;
    m=(struct Mock){0};m.short_phase=9;r=run(&m,&j);assert(r.status==F3_FAILED_RAW_RETAINED&&!m.published&&!m.removed&&r.close_read_calls==1);++tests;
    m=(struct Mock){0};m.corrupt=1;r=run(&m,&j);assert(r.status==F3_FAILED_RAW_RETAINED&&!m.published&&!m.removed);++tests;
    m=(struct Mock){0};m.swap_inode=1;r=run(&m,&j);assert(r.failure_step==8&&!m.published&&!m.removed);++tests;
    m=(struct Mock){0};m.swap_stat=1;r=run(&m,&j);assert(r.failure_step==11&&!m.published&&!m.removed);++tests;
    m=(struct Mock){0};j=job(F3_JPEG_ONLY);j.render_source.inode++;r=run(&m,&j);assert(r.status==F3_REJECTED&&!m.write_open);++tests;
    m=(struct Mock){0};j=job(F3_JPEG_ONLY);j.render_source_kind=0;r=run(&m,&j);assert(r.status==F3_REJECTED&&!m.write_open);++tests;
    m=(struct Mock){0};j=job(F3_JPEG_ONLY);j.output_width=65;r=run(&m,&j);assert(r.status==F3_REJECTED&&!m.write_open);++tests;
    m=(struct Mock){0};j=job(F3_JPEG_ONLY);input[sizeof(input)-1]=0;r=run(&m,&j);assert(r.status==F3_REJECTED&&!m.write_open);input[sizeof(input)-1]=217;++tests;
    m=(struct Mock){0};j=job(F3_JPEG_ONLY);input[4]=255;input[5]=255;r=run(&m,&j);assert(r.status==F3_REJECTED&&!m.write_open);input[4]=0;input[5]=17;++tests;
    m=(struct Mock){0};j=job(F3_JPEG_ONLY);struct F3Ports p=ports(&m);struct F3Session s={1,0,0};p.remove_owned_raw_stage=0;r=f3_checked_save_01(&s,&j,&p,scratch,sizeof(scratch));assert(r.published&&r.status==F3_FAILED_RAW_RETAINED&&!m.removed);++tests;
    m=(struct Mock){0};m.unknown_phase=4;p=ports(&m);s=(struct F3Session){1,0,0};
    r=f3_checked_save_01(&s,&j,&p,scratch,sizeof(scratch));assert(r.status==F3_UNKNOWN_HOLD&&s.hold&&s.in_progress);
    unsigned old_phase=m.phase;uint32_t old_checks=m.raw_checks;
    m.unknown_phase=0;++j.capture_id;
    r=f3_checked_save_01(&s,&j,&p,scratch,sizeof(scratch));assert(r.status==F3_UNKNOWN_HOLD&&m.phase==old_phase&&m.raw_checks==old_checks&&!m.calls_after_unknown);++tests;
    m=(struct Mock){0};p=ports(&m);s=(struct F3Session){2,0,0};r=f3_checked_save_01(&s,&j,&p,scratch,sizeof(scratch));assert(r.status==F3_REJECTED&&!m.raw_checks);++tests;
    printf("{\"owned_host_fault_groups\":%u,\"passed\":true,\"target_executed\":false,\"native_ports_bound\":false}\n",tests);
    return 0;
}
