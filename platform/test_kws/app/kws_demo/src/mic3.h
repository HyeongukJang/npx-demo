#ifndef __MIC3_H__
#define __MIC3_H__

#include "npx_struct.h"

#ifdef __cplusplus
extern "C" {
#endif

void mic3_set_env();
void mic3_start();
void mic3_wait_until_buffer_full();
npx_rawinput_t *mic3_get_sample();
void mic3_draw_waveform();

#ifdef __cplusplus
} // exter "C"
#endif

#endif // __MIC3_H__
