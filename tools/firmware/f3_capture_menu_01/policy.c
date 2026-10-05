#include "policy.h"

/* Independent UI selections packed into one atomic word: coherent per-capture
 * snapshot, CAS updates of one selection never overwrite the other. BSS=RAW/full.
 * No other format state exists in the menu or native adapter. */
static uint32_t requested_settings;
uint32_t iq4_f3_mode_get_01(void) {
    return __atomic_load_n(&requested_settings,__ATOMIC_ACQUIRE)&3u;
}
uint32_t iq4_f3_scale_get_01(void) {
    return (__atomic_load_n(&requested_settings,__ATOMIC_ACQUIRE)>>2)&3u;
}
static int set_field(uint32_t value,uint32_t mask,uint32_t shift) {
    uint32_t old=__atomic_load_n(&requested_settings,__ATOMIC_RELAXED),next;
    do { next=(old&~mask)|(value<<shift); }
    while(!__atomic_compare_exchange_n(&requested_settings,&old,next,0,__ATOMIC_RELEASE,__ATOMIC_RELAXED));
    return 1;
}
int iq4_f3_mode_set_on_ui_01(uint32_t mode) {
    if(mode>F3_JPEG_ONLY) return 0;
    return set_field(mode,3u,0);
}
int iq4_f3_scale_set_on_ui_01(uint32_t scale) {
    if(scale>F3_50_PERCENT01) return 0;
    return set_field(scale,12u,2);
}
static int identity(const struct F3PolicySlot01 *s,uint64_t boot,uint64_t capture,uint64_t source) {
    return s && boot && capture && source && s->policy.boot_epoch==boot &&
        s->policy.capture_id==capture && s->policy.source_token==source;
}
int iq4_f3_policy_begin_01(struct F3PolicySlot01 *s,uint64_t boot,uint64_t capture,
                          uint64_t source,uint32_t w,uint32_t h) {
    uint32_t packed,mode,scale,percent,ow,oh;
    if(!s || s->status!=F3_POLICY_EMPTY01 || !boot || !capture || !source || !w || !h) return 0;
    /* This is the only capture-path read of the current selection. */
    packed=__atomic_load_n(&requested_settings,__ATOMIC_ACQUIRE);
    mode=packed&3u;scale=(packed>>2)&3u;
    if(mode>F3_JPEG_ONLY || scale>F3_50_PERCENT01) return 0;
    percent=scale==F3_FULL01?100u:(scale==F3_75_PERCENT01?75u:50u);
    ow=(uint32_t)((uint64_t)w*percent/100u);
    oh=(uint32_t)((uint64_t)h*percent/100u);
    if(!ow || !oh || ow>w || oh>h) return 0;
    s->policy.boot_epoch=boot;s->policy.capture_id=capture;s->policy.source_token=source;
    s->policy.mode=mode;s->policy.scale_index=scale;s->policy.scale_percent=percent;
    s->policy.source_width=w;s->policy.source_height=h;
    s->policy.output_width=ow;s->policy.output_height=oh;
    s->policy.want_raw=mode!=F3_JPEG_ONLY;s->policy.want_jpeg=mode!=F3_RAW;
    s->policy.raw_backup_allowed=mode!=F3_JPEG_ONLY;
    s->status=F3_POLICY_ACTIVE01;return 1;
}
int iq4_f3_policy_read_01(const struct F3PolicySlot01 *s,uint64_t boot,uint64_t capture,
                         uint64_t source,struct F3CapturePolicy01 *out) {
    if(!out || !identity(s,boot,capture,source) || s->status!=F3_POLICY_ACTIVE01) return 0;
    *out=s->policy;return 1;
}
int iq4_f3_policy_finish_01(struct F3PolicySlot01 *s,uint64_t boot,uint64_t capture,
                           uint64_t source,uint32_t io_state) {
    if(!identity(s,boot,capture,source) || s->status!=F3_POLICY_ACTIVE01) return 0;
    if(io_state==F3_IO_UNKNOWN) {s->status=F3_POLICY_HOLD01;return 1;}
    if(io_state!=F3_IO_DONE && io_state!=F3_IO_FAIL) return 0;
    s->status=F3_POLICY_FINISHED01;return 1;
}
