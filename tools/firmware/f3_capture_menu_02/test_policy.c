#include "policy.h"
#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <string.h>
static void *mode_thread(void *p) {
    unsigned i;(void)p;for(i=0;i<100000;++i) assert(iq4_f3_mode_set_on_ui_01(i%3));
    assert(iq4_f3_mode_set_on_ui_01(F3_JPEG_ONLY));return 0;
}
static void *scale_thread(void *p) {
    unsigned i;(void)p;for(i=0;i<100000;++i) assert(iq4_f3_scale_set_on_ui_01(i%3));
    assert(iq4_f3_scale_set_on_ui_01(F3_50_PERCENT01));return 0;
}
int main(void) {
    struct F3PolicySlot01 s={0};struct F3CapturePolicy01 a,b;
    uint32_t mode,scale;pthread_t m,t;
    assert(!iq4_f3_policy_begin_01(0,1,2,3,14204,10652));
    assert(!iq4_f3_policy_begin_01(&s,0,2,3,14204,10652));
    assert(!iq4_f3_policy_begin_01(&s,1,2,0,14204,10652));
    assert(!iq4_f3_policy_begin_01(&s,1,2,3,0,10652));
    for(mode=0;mode<3;++mode) for(scale=0;scale<3;++scale) {
        struct F3PolicySlot01 slot={0};
        assert(iq4_f3_mode_set_on_ui_01(mode) && iq4_f3_scale_set_on_ui_01(scale));
        assert(iq4_f3_policy_begin_01(&slot,1,2,3,14204,10652));
        assert(iq4_f3_policy_read_01(&slot,1,2,3,&a));
        assert(a.mode==mode && a.scale_index==scale);
        assert(a.want_raw==(mode!=F3_JPEG_ONLY) && a.want_jpeg==(mode!=F3_RAW));
        assert(a.raw_backup_allowed==(mode!=F3_JPEG_ONLY));
        assert(a.output_width==(scale==0?14204u:scale==1?10653u:7102u));
        assert(a.output_height==(scale==0?10652u:scale==1?7989u:5326u));
        assert(iq4_f3_mode_set_on_ui_01((mode+1)%3) && iq4_f3_scale_set_on_ui_01((scale+1)%3));
        assert(!iq4_f3_policy_begin_01(&slot,1,2,3,14204,10652));
        assert(iq4_f3_policy_read_01(&slot,1,2,3,&b) && !memcmp(&a,&b,sizeof a));
        assert(!iq4_f3_policy_read_01(&slot,1,2,4,&b));
        assert(!iq4_f3_policy_finish_01(&slot,1,3,3,F3_IO_DONE));
        assert(!iq4_f3_policy_finish_01(&slot,1,2,3,99));
        assert(iq4_f3_policy_finish_01(&slot,1,2,3,F3_IO_DONE));
        assert(!iq4_f3_policy_read_01(&slot,1,2,3,&b));
        assert(!iq4_f3_policy_begin_01(&slot,1,4,5,14204,10652));
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
        assert(a.mode<3 && a.scale_index<3);
        assert(a.output_width==((uint64_t)a.source_width*a.scale_percent+50)/100);
        assert(a.output_height==((uint64_t)a.source_height*a.scale_percent+50)/100);
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
        assert(iq4_f3_policy_begin_01(&slot,1,2,3,UINT32_MAX,UINT32_MAX));
        assert(slot.policy.output_width==UINT32_MAX && slot.policy.output_height==UINT32_MAX);
        assert(iq4_f3_policy_finish_01(&slot,1,2,3,F3_IO_FAIL));
    }
    {
        struct F3PolicySlot01 odd={0},half={0};
        assert(iq4_f3_scale_set_on_ui_01(F3_75_PERCENT01));
        assert(iq4_f3_policy_begin_01(&odd,1,2,3,139,101));
        assert(odd.policy.output_width==104 && odd.policy.output_height==76);
        /* Native ceil139*0.75=105 is not the public width104. The native
         * consumer remains unbound; it must refuse that mismatch, not crop. */
        assert(odd.policy.output_width!=105);
        assert(iq4_f3_scale_set_on_ui_01(F3_50_PERCENT01));
        assert(iq4_f3_policy_begin_01(&half,1,4,5,139,101));
        assert(half.policy.output_width==70 && half.policy.output_height==51);
    }
    puts("PASS: immutable once-per-node policy/unknown owner/CAS concurrency; no actual source lease");return 0;
}
