#ifndef IQ4_NATIVE_ACTIVITY_01_H
#define IQ4_NATIVE_ACTIVITY_01_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Project actor exclusion only; never a native source/card/file ownership proof.
 * Link exactly one activity.o for JPEG capture/manual and LV movie actors. */
enum Iq4ActivityActor01 {IQ4_ACTIVITY_JPEG01=3,IQ4_ACTIVITY_MOVIE01=4};
enum Iq4ActivityResult01 {IQ4_ACTIVITY_OK01=0,IQ4_ACTIVITY_BUSY01=1,
 IQ4_ACTIVITY_REJECTED01=2,IQ4_ACTIVITY_HELD01=3};
struct Iq4ActivityLease01 {uint64_t word;uintptr_t owner;};
struct Iq4ActivitySnapshot01 {uint64_t generation;uint32_t actor,held;};
/* Nonblocking bounded CAS; no wait, callbacks, allocation or native calls. */
int iq4_activity_try_01(uint32_t actor,const void*unique_owned_context,struct Iq4ActivityLease01*out);
int iq4_activity_valid_01(const struct Iq4ActivityLease01*);
/* UNKNOWN retains this generation permanently. No reset/force-release in target. */
int iq4_activity_hold_01(const struct Iq4ActivityLease01*);
/* Caller must FIRST finish real source/card/file/worker cleanup. The primitive
 * cannot inspect those owners. HELD and stale/foreign leases cannot release. */
int iq4_activity_release_01(const struct Iq4ActivityLease01*);
int iq4_activity_snapshot_01(struct Iq4ActivitySnapshot01*);
#ifdef IQ4_ACTIVITY_SYNTHETIC_HOST
void iq4_activity_fixture_reset_01(uint64_t idle_generation);
#endif
#ifdef __cplusplus
}
#endif
#endif
