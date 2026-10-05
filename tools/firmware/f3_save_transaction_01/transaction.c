#include "transaction.h"
#define MAX_ENCODED (256u*1024u*1024u)
#define CHUNK 65536u
static int same(const struct F3File*a,const struct F3File*b,int size) {
    return a->device==b->device&&a->inode==b->inode&&a->card_epoch==b->card_epoch&&
           a->task_nonce==b->task_nonce&&(!size||a->bytes==b->bytes);
}
static int valid(const struct F3File*a) {
    return a->device&&a->inode&&a->card_epoch&&a->task_nonce&&a->bytes;
}
static int equal_bytes(const uint8_t*a,const uint8_t*b,size_t n) {
    for(size_t i=0;i<n;++i)if(a[i]!=b[i])return 0;
    return 1;
}
/* Header/SOF and terminal EOI validation only, not a JPEG entropy decoder or RAW-detail proof. */
int f3_jpeg_shape_01(const uint8_t*p,size_t n,uint32_t*w,uint32_t*h) {
    if(!p||!w||!h||n<16||p[0]!=255||p[1]!=216||p[n-2]!=255||p[n-1]!=217)return 0;
    size_t i=2;int found=0;
    while(i+1<n-2) {
        if(p[i++]!=255)return 0;
        while(i<n-2&&p[i]==255)++i;
        if(i>=n-2)return 0;
        unsigned marker=p[i++];
        if(marker==0||marker==216||marker==217||marker==1||(marker>=208&&marker<=215))return 0;
        if(i+2>n-2)return 0;
        size_t len=((size_t)p[i]<<8)|p[i+1];
        if(len<2||len>n-2-i)return 0;
        if((marker>=192&&marker<=195)||(marker>=197&&marker<=199)||(marker>=201&&marker<=203)||
           (marker>=205&&marker<=207)) {
            if(found||len<8||p[i+2]!=8)return 0;
            *h=((uint32_t)p[i+3]<<8)|p[i+4];*w=((uint32_t)p[i+5]<<8)|p[i+6];
            unsigned components=p[i+7];
            if(!*w||!*h||components!=3||len!=8u+3u*components)return 0;
            found=1;
        }
        if(marker==218)return found;
        i+=len;
    }
    return 0;
}
static int observed(struct F3Result*r,struct F3Io io,unsigned step) {
    if(io.state==F3_IO_DONE)return 1;
    r->failure_step=step;
    r->status=io.state==F3_IO_FAIL?F3_FAILED_RAW_RETAINED:F3_UNKNOWN_HOLD;
    return 0;
}
static int cw(struct F3Result*r,const struct F3Ports*p,unsigned step) {
    ++r->close_write_calls;
    struct F3Io x=p->close_write(p->context);
    if(x.state==F3_IO_DONE||x.state==F3_IO_FAIL)r->write_open=0;
    return observed(r,x,step);
}
static int cr(struct F3Result*r,const struct F3Ports*p,unsigned step) {
    ++r->close_read_calls;
    struct F3Io x=p->close_read(p->context);
    if(x.state==F3_IO_DONE||x.state==F3_IO_FAIL)r->read_open=0;
    return observed(r,x,step);
}
static struct F3Result run(const struct F3Job*j,const struct F3Ports*p,uint8_t*scratch,size_t cap) {
    struct F3Result r={0};uint32_t w=0,h=0;
    r.status=F3_REJECTED;
    if(!j||!p||!j->boot_epoch||!j->capture_id||!valid(&j->raw)||
       j->mode>F3_JPEG_ONLY||(j->purpose!=F3_NEW_CAPTURE&&j->purpose!=F3_MANUAL_EXISTING_RAW)||
       j->newly_created_raw_stage>1||
       (j->purpose==F3_MANUAL_EXISTING_RAW&&j->newly_created_raw_stage))return r;
    if(!p->check_raw)return r;
    ++r.check_raw_calls;
    if(!observed(&r,p->check_raw(p->context,j),1))return r;
    if(j->mode==F3_RAW){r.status=F3_RAW_RETAINED;return r;}
    if(!scratch||cap<CHUNK||!j->encoded||!j->encoded_bytes||j->encoded_bytes>MAX_ENCODED||
       !j->source_raw_width||!j->source_raw_height||j->render_source_kind!=1||
       !same(&j->render_source,&j->raw,1)||
       j->render_width!=j->output_width||j->render_height!=j->output_height||
       !j->output_width||!j->output_height||
       j->output_width>j->source_raw_width||j->output_height>j->source_raw_height||
       !f3_jpeg_shape_01(j->encoded,(size_t)j->encoded_bytes,&w,&h)||
       w!=j->output_width||h!=j->output_height)return r;
    if(!p->open_exclusive||!p->write||!p->close_write||!p->open_read||!p->read||
       !p->stat_read||!p->close_read||!p->publish)return r;
    if(!observed(&r,p->open_exclusive(p->context,j,&r.jpeg),2))return r;
    r.write_open=1;
    if(!r.jpeg.device||!r.jpeg.inode||r.jpeg.card_epoch!=j->raw.card_epoch||
       r.jpeg.task_nonce!=j->raw.task_nonce||same(&r.jpeg,&j->raw,0)||r.jpeg.bytes!=0){
        r.status=F3_FAILED_RAW_RETAINED;r.failure_step=3;cw(&r,p,3);return r;
    }
    for(uint64_t off=0;off<j->encoded_bytes;) {
        uint32_t n=(uint32_t)(j->encoded_bytes-off);if(n>CHUNK)n=CHUNK;
        ++r.write_calls;struct F3Io x=p->write(p->context,j->encoded+off,n);
        if(!observed(&r,x,4)) {
            if(r.status!=F3_UNKNOWN_HOLD)cw(&r,p,5);
            return r;
        }
        if(x.value!=n){r.status=F3_FAILED_RAW_RETAINED;r.failure_step=4;cw(&r,p,5);return r;}
        off+=n;
    }
    if(!cw(&r,p,6))return r;
    r.jpeg.bytes=j->encoded_bytes;
    struct F3File actual={0};
    if(!observed(&r,p->open_read(p->context,&r.jpeg,&actual),7))return r;
    r.read_open=1;
    if(!same(&r.jpeg,&actual,1)){r.status=F3_FAILED_RAW_RETAINED;r.failure_step=8;cr(&r,p,8);return r;}
    for(uint64_t off=0;off<j->encoded_bytes;) {
        uint32_t n=(uint32_t)(j->encoded_bytes-off);if(n>CHUNK)n=CHUNK;
        ++r.read_calls;struct F3Io x=p->read(p->context,scratch,n);
        if(!observed(&r,x,9)){if(r.status!=F3_UNKNOWN_HOLD)cr(&r,p,10);return r;}
        if(x.value!=n||!equal_bytes(scratch,j->encoded+off,n)){
            r.status=F3_FAILED_RAW_RETAINED;r.failure_step=9;cr(&r,p,10);return r;
        }
        off+=n;r.verified_bytes=off;
    }
    if(!observed(&r,p->stat_read(p->context,&actual),11)){
        if(r.status!=F3_UNKNOWN_HOLD)cr(&r,p,12);
        return r;
    }
    if(!same(&r.jpeg,&actual,1)){r.status=F3_FAILED_RAW_RETAINED;r.failure_step=11;cr(&r,p,12);return r;}
    if(!cr(&r,p,13))return r;
    if(!observed(&r,p->publish(p->context,&r.jpeg),14))return r;
    r.published=1;r.status=F3_JPEG_WITH_RAW;
    /* A manual existing-IIQ export never deletes source even in JPEG_ONLY mode. */
    if(j->mode!=F3_JPEG_ONLY||j->purpose!=F3_NEW_CAPTURE||!j->newly_created_raw_stage)return r;
    ++r.check_raw_calls;
    if(!observed(&r,p->check_raw(p->context,j),15))return r;
    if(!p->remove_owned_raw_stage){r.status=F3_FAILED_RAW_RETAINED;r.failure_step=16;return r;}
    if(!observed(&r,p->remove_owned_raw_stage(p->context,j),16))return r;
    r.raw_removed=1;r.status=F3_JPEG_ONLY_DONE;
    return r;
}
struct F3Result f3_checked_save_01(struct F3Session*s,const struct F3Job*j,
                                 const struct F3Ports*p,uint8_t*scratch,size_t cap) {
    struct F3Result r={0};r.status=F3_REJECTED;
    if(!s||!j||!s->boot_epoch||s->boot_epoch!=j->boot_epoch)return r;
    if(s->hold||s->in_progress){r.status=F3_UNKNOWN_HOLD;return r;}
    s->in_progress=1;
    r=run(j,p,scratch,cap);
    if(r.status==F3_UNKNOWN_HOLD)s->hold=1;
    else s->in_progress=0;
    return r;
}
