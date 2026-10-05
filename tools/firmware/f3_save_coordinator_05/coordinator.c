#include "coordinator.h"
#include <string.h>
static const struct F3SaveResult05*held(struct F3Save05*c,uint32_t step){c->state=3;c->session.hold=1;c->result.saved.status=F3_UNKNOWN_HOLD;c->result.saved.failure_step=step;f3_card_hold_05(c->card);return &c->result;}
static int exact_done(struct F3Io r){return r.state==F3_IO_DONE&&r.value==1;}
static int native_clear(const struct f3_native_adapter*a){return !a->generator_alive&&!a->rgb32_alive&&!a->planar_alive&&!a->join_needed&&!a->job.owner_held&&!a->job.sink_active;}
static enum f3_result sink(void*v,const struct f3_plane*p){struct F3Save05*c=v;
 if(!p||!p->allocation||p->plane_offset>=p->allocation_bytes||p->allocation_bytes-p->plane_offset>SIZE_MAX)return F3_BAD_PLANE;
 Iq4Rgb32Input input={p->allocation+p->plane_offset,(size_t)(p->allocation_bytes-p->plane_offset),(size_t)p->stride,p->width,p->height,c->request.quality};
 const struct F3StreamResult*r=f3_stream_encode_rgb32_02(&c->stream,c->request.codec,&input,&c->encoder);
 if(!r)return F3_NATIVE_FAILURE;c->result.saved=r->saved;
 return r->saved.status==F3_JPEG_WITH_RAW?F3_OK:F3_NATIVE_FAILURE;
}
const struct F3SaveResult05*f3_save_run_05(struct F3Save05*c,struct F3Fs*fs,struct F3Card05*card,const struct F3SaveOwners05*owners,const struct F3SaveRequest05*r){
 if(!c)return 0;if(c->state)return &c->result;
 c->result.saved.status=F3_REJECTED;
 if(!fs||!card||!owners||!owners->source_valid||!owners->close_source_reader||!owners->close_arena||!owners->release_source_lease||!r||r->job.mode>F3_JPEG_ONLY||!r->job.boot_epoch||!r->job.capture_id||r->job.encoded||r->job.encoded_bytes||!fs->stage_sealed||fs->raw_fd<0||fs->hold||card->hold)return &c->result;
 if(r->job.mode!=F3_RAW&&(!r->source||!r->plan||!r->input||!r->render_ops||!r->codec||!r->arena||!r->arena_bytes||!r->readback_scratch||r->readback_bytes<F3_STREAM_SCRATCH||!r->jpeg_budget||r->quality<1||r->quality>100))return &c->result;
 c->fs=fs;c->card=card;c->owners=*owners;c->request=*r;c->immutable=r->job;c->session.boot_epoch=r->job.boot_epoch;c->result.public_mode=r->job.mode;c->state=1;c->result.phase=1;
 if(!f3_card_valid_05(card)||!exact_done(owners->source_valid(owners->context)))return held(c,21);
 struct F3Ports ports=f3_fs_ports_03(fs);
 struct F3Io raw=ports.check_raw(ports.context,&c->immutable);if(raw.state==F3_IO_UNKNOWN)return held(c,22);if(!exact_done(raw)){c->result.saved.status=F3_FAILED_RAW_RETAINED;goto finish;}
 if(c->immutable.mode==F3_RAW){c->result.saved.status=F3_RAW_RETAINED;c->result.render_cleanup_confirmed=1;goto finish;}
 struct F3Job internal=c->immutable;internal.mode=F3_RAW_JPEG;
 c->result.phase=2;
 if(!f3_stream_begin_02(&c->stream,&c->session,&internal,&ports,r->jpeg_budget,r->readback_scratch,r->readback_bytes)){c->result.saved=c->stream.result.saved;if(c->result.saved.status==F3_UNKNOWN_HOLD)return held(c,23);goto finish;}
 enum f3_result rendered=f3_native_render(&c->native,r->render_ops,r->source,r->plan,r->input,r->arena,r->arena_bytes,sink,c);
 c->result.renderer_result=rendered;c->result.phase=3;
 if(rendered==F3_CLEANUP_FAILURE||!native_clear(&c->native))return held(c,24);
 c->result.render_cleanup_confirmed=1;
 if(c->stream.state==3||c->session.hold||fs->hold||card->hold)return held(c,25);
 if(c->stream.state==1)c->result.saved=f3_stream_abort_02(&c->stream)->saved;
 if(c->result.saved.status==F3_UNKNOWN_HOLD)return held(c,26);
 if(rendered!=F3_OK){if(c->result.saved.published){/* Published JPEG can coexist with retained RAW after late render cleanup error. */c->result.saved.status=F3_FAILED_RAW_RETAINED;}goto finish;}
 if(c->result.saved.status!=F3_JPEG_WITH_RAW||!c->result.saved.published||!c->stream.result.jpeg_structure_checked||!c->stream.result.encoder_finish_checked)return held(c,27);
 if(!f3_card_valid_05(card)||!exact_done(owners->source_valid(owners->context)))return held(c,28);
 c->result.phase=4;
 if(c->immutable.mode==F3_JPEG_ONLY&&c->immutable.purpose==F3_NEW_CAPTURE){
  if(!c->immutable.newly_created_raw_stage||!fs->owned_stage)return held(c,29);
  /* Frozen FS04 body rechecks complete owned RAW hash immediately before unlink.
   * No reader/source/card lease has been released; generator/CIB/workers are clear. */
  struct F3Io removed=ports.remove_owned_raw_stage(ports.context,&c->immutable);
  if(removed.state==F3_IO_UNKNOWN)return held(c,30);
  if(!exact_done(removed)){c->result.saved.status=F3_FAILED_RAW_RETAINED;goto finish;}
  c->result.saved.raw_removed=1;c->result.saved.status=F3_JPEG_ONLY_DONE;
 }
finish:
 c->result.phase=5;
 if(c->session.hold||fs->hold||card->hold||!f3_card_valid_05(card))return held(c,31);
 if(!exact_done(owners->close_source_reader(owners->context)))return held(c,32);c->result.reader_closed=1;
 if(!exact_done(owners->close_arena(owners->context)))return held(c,33);c->result.arena_closed=1;
 if(!f3_fs_release_raw_03(fs))return held(c,34);c->result.raw_fd_closed=1;
 if(f3_card_close_dirs_05(card)!=F3_CARD_OK)return held(c,35);c->result.directories_closed=1;
 /* All actual file/arena/source-reader FDs are now closed. Only here release
  * the independent source lease and then native SDWrite/XQDWrite requests. */
 if(!exact_done(owners->release_source_lease(owners->context)))return held(c,36);c->result.source_lease_released=1;
 if(f3_card_release_requests_05(card)!=F3_CARD_OK)return held(c,37);c->result.card_requests_released=1;
 c->state=2;c->result.phase=6;return &c->result;
}
