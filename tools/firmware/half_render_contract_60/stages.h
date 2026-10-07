#ifndef IQ4_HALF_RENDER_STAGE_COUNTS_60_H
#define IQ4_HALF_RENDER_STAGE_COUNTS_60_H
#include <stdint.h>
/* Native WorkingSettings may add processing stages. This checks only the
 * finite counts: the caller still must prove owner, terminal, return, plane
 * and resource lifetime. Never manufacture a completion from counts alone. */
static inline int iq4_half_stage_counts_valid_60(uint32_t stages,uint32_t joins){
 return stages>=1u&&stages<=32u&&joins==stages;
}
#endif
