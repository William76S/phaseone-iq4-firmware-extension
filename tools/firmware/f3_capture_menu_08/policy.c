#include "../f3_capture_menu_06/policy.h"
#include "../../../src/codec/export_geometry.h"

/* Independent UI selections packed into one atomic word: coherent per-capture
 * snapshot, CAS updates of one selection never overwrite the other. BSS=RAW/full.
 * No other format state exists in the menu or native adapter. */
static uint32_t requested_settings;
int iq4_f3_settings_snapshot_06(struct F3SettingsSnapshot06*out) {
    if(!out)return 0;
    uint32_t packed=__atomic_load_n(&requested_settings,__ATOMIC_ACQUIRE);
    uint32_t sd=packed&3u,xqd=(packed>>2)&3u,size=(packed>>4)&7u,q=(packed>>8)&127u;
    if(!q)q=100;
    if(sd>F3_JPEG_ONLY||xqd>F3_JPEG_ONLY||size>F3_LONG768001||q>100)return 0;
    *out=(struct F3SettingsSnapshot06){sd,xqd,size,q};return 1;
}
int iq4_f3_settings_for_card_06(const struct F3SettingsSnapshot06*s,uint32_t id,struct F3SettingsSnapshot04*out) {
    if(!s||!out||(id!=10&&id!=11)||s->sd_mode>F3_JPEG_ONLY||s->xqd_mode>F3_JPEG_ONLY||
       s->size_mode>F3_LONG768001||!s->quality||s->quality>100)return 0;
    *out=(struct F3SettingsSnapshot04){id==10?s->sd_mode:s->xqd_mode,s->size_mode,s->quality};return 1;
}
int iq4_f3_settings_snapshot_04(struct F3SettingsSnapshot04*out) {
    struct F3SettingsSnapshot06 actual;
    return iq4_f3_settings_snapshot_06(&actual)&&iq4_f3_settings_for_card_06(&actual,10,out);
}
uint32_t iq4_f3_mode_get_01(void) {
    return __atomic_load_n(&requested_settings,__ATOMIC_ACQUIRE)&3u;
}
uint32_t iq4_f3_scale_get_01(void) {
    return (__atomic_load_n(&requested_settings,__ATOMIC_ACQUIRE)>>4)&7u;
}
uint32_t iq4_f3_quality_get_03(void) {
    uint32_t q=(__atomic_load_n(&requested_settings,__ATOMIC_ACQUIRE)>>8)&127u;
    return q?q:100u;
}
static int set_field(uint32_t value,uint32_t mask,uint32_t shift) {
    uint32_t old=__atomic_load_n(&requested_settings,__ATOMIC_RELAXED),next;
    do { next=(old&~mask)|(value<<shift); }
    while(!__atomic_compare_exchange_n(&requested_settings,&old,next,0,__ATOMIC_RELEASE,__ATOMIC_RELAXED));
    return 1;
}
int iq4_f3_mode_set_for_card_on_ui_06(uint32_t id,uint32_t mode) {
    if((id!=10&&id!=11)||mode>F3_JPEG_ONLY)return 0;
    return set_field(mode,id==10?3u:12u,id==10?0u:2u);
}
int iq4_f3_mode_set_on_ui_01(uint32_t mode) {
    return iq4_f3_mode_set_for_card_on_ui_06(10,mode);
}
int iq4_f3_scale_set_on_ui_01(uint32_t scale) {
    if(scale>F3_LONG768001) return 0;
    return set_field(scale,112u,4);
}
int iq4_f3_quality_set_on_ui_03(uint32_t q) {
    if(!q || q>100) return 0;
    return set_field(q,127u<<8,8);
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
    mode=packed&3u;scale=(packed>>4)&7u;
    if(mode>F3_JPEG_ONLY || scale>F3_LONG768001) return 0;
    struct Iq4ExportGeometry geometry;
    /* A JPEG-only size limitation must never prevent the stock RAW mode.
     * Zero output geometry explicitly means that this capture has no JPEG. */
    if(mode!=F3_RAW && iq4_export_geometry(w,h,0,scale,&geometry)!=IQ4_EXPORT_GEOMETRY_OK) return 0;
    percent=scale==F3_FULL01?100u:(scale==F3_75_PERCENT01?75u:(scale==F3_50_PERCENT01?50u:(scale==F3_25_PERCENT01?25u:0u)));
    ow=mode==F3_RAW?0:geometry.output_width; oh=mode==F3_RAW?0:geometry.output_height;
    s->policy.boot_epoch=boot;s->policy.capture_id=capture;s->policy.source_token=source;
    s->policy.mode=mode;s->policy.scale_index=scale;s->policy.scale_percent=percent;
    s->policy.jpeg_quality=(packed>>8)&127u;
    if(!s->policy.jpeg_quality) s->policy.jpeg_quality=100;
    if(s->policy.jpeg_quality>100) return 0;
    s->policy.automatic_jpeg=mode!=F3_RAW;
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
