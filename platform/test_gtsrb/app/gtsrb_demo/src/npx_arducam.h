#ifndef __NPX_ARDUCAM_H__
#define __NPX_ARDUCAM_H__

#include "ervp_image.h"
#include "npx_struct.h"
#include "npx_tensor.h"

#ifdef __cplusplus
extern "C" {
#endif

npx_rawinput_t *npx_make_tensor_from_image(const ErvpImage* const image);
ErvpImage *npx_make_rgb565image_from_tensor(NpxTensorInfo *tensor);

#ifdef __cplusplus
} // exter "C"
#endif

#endif // __NPX_ARDUCAM_H__
