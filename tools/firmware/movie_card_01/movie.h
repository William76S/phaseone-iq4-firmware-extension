#ifndef IQ4_MOVIE_CARD_01_H
#define IQ4_MOVIE_CARD_01_H
#include "../f3_native_card_bridge_05/card.h"
#include "../../../src/recording/native_mkv.h"
#ifdef __cplusplus
extern "C" {
#endif
enum F4MovieState01 {F4_MOVIE_UNUSED,F4_MOVIE_WRITING,F4_MOVIE_FAILED,
 F4_MOVIE_PUBLISHED,F4_MOVIE_HOLD,F4_MOVIE_PARTIAL_CLOSED};
struct F4MovieApi01 {struct F3Posix fs;
 struct F3SysResult(*write_at)(int,const void*,uint32_t,uint64_t);};
struct F4Movie01 {
 struct F3Card05*card;struct F4MovieApi01 api;struct Iq4Mkv mux;
 uint32_t state,files_closed,structure_checked,published;
 int write_fd,read_fd;uint64_t accepted_bytes,reviewed_bytes;
 struct F3FdStat original,final;char part_leaf[64],final_leaf[64],sha256[65];
};
/* Caller has already acquired actual original card requests. A plain worker
 * may use these held dirs/guards: no native wait/register/release is called.
 * Frames/source and card owners remain caller-owned until worker join plus
 * normal file cleanup; UI/original task releases requests last. */
int f4_movie_begin_01(struct F4Movie01*,struct F3Card05*,
 const struct F4MovieApi01*,uint64_t recording_id,uint64_t unique_nonce,
 uint32_t width,uint32_t height,uint64_t max_file,uint32_t max_packet,uint32_t max_frames);
enum Iq4MkvStatus f4_movie_packet_01(struct F4Movie01*,const uint8_t*,uint32_t,
 uint64_t original_observed_ns,uint64_t local_completion_sequence);
/* One whole readback SHA and full native scanner/JPEG+CRC verification,
 * then atomic noreplace publication and dir fsync. Requires actual stopped
 * producer admission, complete queued/current source-copy/encoder tasks and
 * callback fence; the same persistent worker may finalize serially. A stopped
 * worker must instead have an actual successful join. Never pretend a serial
 * task fence is an OS-thread join. */
enum F3IoState f4_movie_finish_01(struct F4Movie01*,uint8_t*hash_scratch,
 size_t hash_capacity,uint8_t*packet_scratch,uint32_t packet_capacity);
/* Known stopped producer failure: close checked once, preserve original .part.
 * Does not repair/delete/publish/release requests. UNKNOWN refuses cleanup. */
enum F3IoState f4_movie_abort_01(struct F4Movie01*);
void f4_movie_linux_api_01(struct F4MovieApi01*);
#ifdef __cplusplus
}
#endif
#endif
