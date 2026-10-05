#ifndef IQ4_F4_MOVIE_BINDING_02_H
#define IQ4_F4_MOVIE_BINDING_02_H
#include "session.h"
#include "../f3_native_card_bridge_06/card.h"
#include "../movie_card_01/movie.h"
#ifdef __cplusplus
extern "C" {
#endif
typedef struct {void*source;Iq4F4SelfRead02 read;void*read_context;
 struct F3Card05 card;struct F4Movie01 movie;struct F3LeaseCalls05 lease;
 struct F3CardIo05 card_io;struct F3TryCalls06 request;struct F4MovieApi01 api;
 uint32_t destination_fs_id,packet_capacity,max_frames,hold;uint64_t max_file,serial,worker_tid;
 unsigned char*hash_scratch;size_t hash_capacity;unsigned char*packet_scratch;
} Iq4F4MovieBinding02;
/* Finite real production factory. Destination must be explicit 10 SD or11XQD;
 * actual native owner, requestbit, ready mode, rootdir inode/mount are checked
 * by Card06. This does not manufacture a card availability/selection receipt.
 * Same Card06 supersets the05 ABI; don't link two different card.c copies. */
int iq4_f4_movie_binding_init_on_ui_02(Iq4F4MovieBinding02*,void*source,
 Iq4F4SelfRead02,void*,uint32_t destination_fs_id,unsigned char*hash_scratch,
 size_t hash_capacity,unsigned char*packet_scratch,uint32_t packet_capacity,
 uint64_t max_file,uint32_t max_frames);
Iq4F4MoviePorts02 iq4_f4_movie_binding_ports_02(Iq4F4MovieBinding02*);
#ifdef __cplusplus
}
#endif
#endif
