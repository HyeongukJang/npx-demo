#include "ervp_printf.h"
#include "ervp_assert.h"
#include "ervp_malloc.h"
#include "ervp_color_format.h"

#include <string.h>

#include "npx_arducam.h"

npx_rawinput_t *npx_make_tensor_from_image(const ErvpImage* const image)
{
  assert(image->format == IMAGE_FMT_RGB_565_PACKED);

  int channels = 3;
  int height = image->height;
  int width = image->width;

  npx_rawinput_t *npx_sample;

  npx_sample = (npx_rawinput_t *)malloc(sizeof(npx_rawinput_t));
  assert(npx_sample);
  npx_sample->type = MATRIX3D;
  npx_sample->tensor = npx_tensor_alloc_wo_data(3);
  npx_sample->tensor->size[0] = width;
  npx_sample->tensor->size[1] = height;
  npx_sample->tensor->size[2] = channels;
  npx_tensor_set_datatype(npx_sample->tensor, MATRIX_DATATYPE_UINT08);
  npx_tensor_alloc_data(npx_sample->tensor);

  // image to tensor convert
  uint8_t (*pt)[height][width] = npx_sample->tensor->addr;
  for(int h=0; h<height; h++)
  {
    uint16_t *rgb565_row_base = image_get_row_base(image, 0, h);

    for(int w=0; w<width; w++)
    {
      uint16_t rgb565 = rgb565_row_base[w];
      pt[0][h][w] = extract_r_from_rgb565(rgb565);
      pt[1][h][w] = extract_g_from_rgb565(rgb565);
      pt[2][h][w] = extract_b_from_rgb565(rgb565);
    }
  }

  // scale
  npx_sample->scaled = 255;

  npx_sample->label = -1;

  return npx_sample;
}

ErvpImage *npx_make_rgb565image_from_tensor(NpxTensorInfo *tensor)
{
  int channels = tensor->size[2];
  int height = tensor->size[1];
  int width = tensor->size[0];

  assert(tensor!=NULL);
  assert(tensor->num_dim==3);
  assert(channels==3);

  ErvpImage *image = image_alloc(width, height, IMAGE_FMT_RGB_565_PACKED);
  assert(image);

  printf("\nc: %d / h: %d / w: %d", channels, height, width);

  uint8_t (*pt)[height][width] = tensor->addr;
  for(int h=0; h<height; h++)
  {
    uint16_t *rgb565_row_base = image_get_row_base(image, 0, h);

    for(int w=0; w<width; w++)
    {
      rgb565_row_base[w] = gen_rgb565(pt[0][h][w], pt[1][h][w], pt[2][h][w]);
    }
  }

  return image;
}
