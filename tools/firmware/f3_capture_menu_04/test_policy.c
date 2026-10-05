#include "policy.h"
#include "../../../src/codec/export_geometry.h"
#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <string.h>
static void *mode_thread(void *p) {
    unsigned i;(void)p;for(i=0;i<100000;++i) assert(iq4_f3_mode_set_on_ui_01(i%3));
    assert(iq4_f3_mode_set_on_ui_01(F3_JPEG_ONLY));return 0;
}
static void *scale_thread(void *p) {
    unsigned i;(void)p;for(i=0;i<100000;++i) assert(iq4_f3_scale_set_on_ui_01(i%6));
    assert(iq4_f3_scale_set_on_ui_01(F3_50_PERCENT01));return 0;
}
int main(void) {
    struct F3PolicySlot01 s={0};struct F3CapturePolicy01 a,b;
    uint32_t mode,scale;pthread_t m,t;
    assert(!iq4_f3_policy_begin_01(0,1,2,3,14204,10652));
    assert(!iq4_f3_policy_begin_01(&s,0,2,3,14204,10652));
    assert(!iq4_f3_policy_begin_01(&s,1,2,0,14204,10652));
    assert(!iq4_f3_policy_begin_01(&s,1,2,3,0,10652));
    for(mode=0;mode<3;++mode) for(scale=0;scale<6;++scale) {
        struct F3PolicySlot01 slot={0};
        assert(iq4_f3_mode_set_on_ui_01(mode) && iq4_f3_scale_set_on_ui_01(scale));
        assert(iq4_f3_policy_begin_01(&slot,1,2,3,14204,10652));
        assert(iq4_f3_policy_read_01(&slot,1,2,3,&a));
        assert(a.mode==mode && a.scale_index==scale);
        assert(a.jpeg_quality==95 && a.automatic_jpeg==(mode!=F3_RAW));
        assert(a.want_raw==(mode!=F3_JPEG_ONLY) && a.want_jpeg==(mode!=F3_RAW));
        assert(a.raw_backup_allowed==(mode!=F3_JPEG_ONLY));
        struct Iq4ExportGeometry g;assert(iq4_export_geometry(14204,10652,0,scale,&g)==IQ4_EXPORT_GEOMETRY_OK);
        assert(a.output_width==(mode==F3_RAW?0:g.output_width));
        assert(a.output_height==(mode==F3_RAW?0:g.output_height));
        assert(iq4_f3_quality_set_on_ui_03(87));
        assert(iq4_f3_mode_set_on_ui_01((mode+1)%3) && iq4_f3_scale_set_on_ui_01((scale+1)%6));
        assert(!iq4_f3_policy_begin_01(&slot,1,2,3,14204,10652));
        assert(iq4_f3_policy_read_01(&slot,1,2,3,&b) && !memcmp(&a,&b,sizeof a));
        assert(!iq4_f3_policy_read_01(&slot,1,2,4,&b));
        assert(!iq4_f3_policy_finish_01(&slot,1,3,3,F3_IO_DONE));
        assert(!iq4_f3_policy_finish_01(&slot,1,2,3,99));
        assert(iq4_f3_policy_finish_01(&slot,1,2,3,F3_IO_DONE));
        assert(!iq4_f3_policy_read_01(&slot,1,2,3,&b));
        assert(!iq4_f3_policy_begin_01(&slot,1,4,5,14204,10652));
        assert(iq4_f3_quality_set_on_ui_03(95));
    }
    assert(iq4_f3_mode_set_on_ui_01(F3_JPEG_ONLY) && iq4_f3_scale_set_on_ui_01(F3_FULL01));
    assert(iq4_f3_policy_begin_01(&s,1,2,3,14204,10652));
    assert(iq4_f3_policy_finish_01(&s,1,2,3,F3_IO_UNKNOWN) && s.status==F3_POLICY_HOLD01);
    assert(!iq4_f3_policy_finish_01(&s,1,2,3,F3_IO_DONE));
    assert(!iq4_f3_policy_begin_01(&s,1,4,5,14204,10652));
    assert(s.policy.source_token==3 && s.policy.want_raw==0 && s.policy.want_jpeg==1);
    assert(!pthread_create(&m,0,mode_thread,0) && !pthread_create(&t,0,scale_thread,0));
    for(mode=0;mode<10000;++mode) {
        struct F3PolicySlot01 slot={0};
        assert(iq4_f3_policy_begin_01(&slot,1,mode+1,3,14204,10652));
        assert(iq4_f3_policy_read_01(&slot,1,mode+1,3,&a));
        assert(a.mode<3 && a.scale_index<6);
        struct F3SettingsSnapshot04 settings;assert(iq4_f3_settings_snapshot_04(&settings));
        assert(settings.mode<3&&settings.size_mode<6&&settings.quality==95);
        struct Iq4ExportGeometry g;assert(iq4_export_geometry(a.source_width,a.source_height,0,a.scale_index,&g)==IQ4_EXPORT_GEOMETRY_OK);
        assert(a.output_width==(a.mode==F3_RAW?0:g.output_width) && a.output_height==(a.mode==F3_RAW?0:g.output_height));
    }
    assert(!pthread_join(m,0) && !pthread_join(t,0));
    assert(iq4_f3_mode_get_01()==F3_JPEG_ONLY && iq4_f3_scale_get_01()==F3_50_PERCENT01);
    {
        struct F3PolicySlot01 slot={0};
        assert(iq4_f3_policy_begin_01(&slot,1,2,3,1,1));
        assert(slot.policy.output_width==1 && slot.policy.output_height==1);
        assert(iq4_f3_policy_finish_01(&slot,1,2,3,F3_IO_DONE));
        slot=(struct F3PolicySlot01){0};
        assert(iq4_f3_scale_set_on_ui_01(F3_FULL01));
        assert(!iq4_f3_policy_begin_01(&slot,1,2,3,UINT32_MAX,UINT32_MAX));
        assert(slot.status==F3_POLICY_EMPTY01);
    }
    {
        struct F3PolicySlot01 raw={0},jpeg={0};
        assert(iq4_f3_mode_set_on_ui_01(F3_RAW));
        assert(iq4_f3_scale_set_on_ui_01(F3_LONG768001));
        assert(iq4_f3_policy_begin_01(&raw,1,2,3,640,480));
        assert(raw.policy.want_raw && !raw.policy.want_jpeg);
        assert(raw.policy.output_width==0 && raw.policy.output_height==0);
        assert(iq4_f3_mode_set_on_ui_01(F3_RAW_JPEG));
        assert(!iq4_f3_policy_begin_01(&jpeg,1,4,5,640,480));
        assert(jpeg.status==F3_POLICY_EMPTY01);
    }
    {
        struct F3PolicySlot01 odd={0},half={0};
        assert(iq4_f3_scale_set_on_ui_01(F3_75_PERCENT01));
        assert(iq4_f3_policy_begin_01(&odd,1,2,3,139,101));
        assert(odd.policy.output_width==104 && odd.policy.output_height==76);
        /* Native ceil139*0.75=105 is not the public width104. The actual
         * consumer must resize exactly or refuse, never silently crop. */
        assert(odd.policy.output_width!=105);
        assert(iq4_f3_scale_set_on_ui_01(F3_50_PERCENT01));
        assert(iq4_f3_policy_begin_01(&half,1,4,5,139,101));
        assert(half.policy.output_width==70 && half.policy.output_height==51);
    }
    puts("PASS: immutable once-per-node policy/unknown owner/CAS concurrency; own UI snapshot is not actual source ownership");return 0;
}
