#include "platform_info.h"
#include "ervp_printf.h"
#include "ervp_printf_section.h"
#include "ervp_core_id.h"
#include "ervp_malloc.h"
#include "ervp_image.h"

#include "arducam.h"
#include "oled_rgb.h"

#include "ui.h"

#include "npx_parser.h"
#include "npx_network.h"
#include "npx_sample.h"
#include "npx_preprocess.h"
#include "npx_arducam.h"
#include "npx_tensor.h"

#include "map_your_matrix_hw.h"

#define FNAME_MAX 256

char app_name[FNAME_MAX] = "gtsrb_app";

char net_fname[FNAME_MAX];
char opt_fname[FNAME_MAX];
char parameter_fname[FNAME_MAX];
char sample_fname[FNAME_MAX];
char tv_fname[FNAME_MAX];
char pre_fname[FNAME_MAX];

ErvpImage *arducam_image;
ErvpImage *window_image;
npx_rawinput_t *npx_sample;

ErvpImage *inference_image;
NpxTensorInfo *resized;

#define SKIP_SIM 1

int npx_result(npx_network_t *net, const npx_layerio_tsseq_t *output_tsseq, int min_acc_value);

int main()
{
  if (EXCLUSIVE_ID == 0)
  {
    ervp_mop_mapping_t* mop_mapping = matrix_op_mapping_alloc();
    map_your_matrix_function(mop_mapping);

    int sample_index = 0;
    sprintf(net_fname, "%s_network.cfg", app_name);
    sprintf(opt_fname, "%s_operator.cfg", app_name);
    sprintf(pre_fname, "%s_preprocess.cfg", app_name);
    sprintf(parameter_fname, "%s_parameter_quant.bin", app_name);

    printf_section(SKIP_SIM, "Test App: %s", net_fname);

    npx_network_t *net = npx_parse_network_cfg(net_fname, opt_fname);
    npx_network_load_parameters(net, parameter_fname);
    npx_network_map_matrix_operator(net, -1, mop_mapping);

    arducam_init(ARDUCAM_RGB_565_QVGA);
    arducam_image = arducam_alloc_image(arducam_image);

    oled_rgb_start();
    oled_rgb_clear();

    init_btnc();

    while(1)
    {
#if 0
      sprintf(sample_fname, "%s_sample_%03d.bin", app_name, sample_index);
      if(!fakefile_exists(sample_fname))
        break;
      printf_subsection(SKIP_SIM, "Iteration %d", sample_index);
      npx_sample = npx_load_sample(sample_fname, pre_fname);
      sample_index++;
#else
      printf("\nPress the push button BTNC(E18) for Inference!\n");
      display_init();
      while(1)
      {
        arducam_config_spi();
        arducam_single_capture(arducam_image);
        flush_cache();

        oled_rgb_config_spi();
        oled_rgb_draw_rvx_image(arducam_image);
        oled_rgb_draw_rectangle(16, 0, 79, 63, RGB(0xFF,0,0), 0, 0);

        if(check_btnc() == 1)
          break;
      }

#if 1 // crop center 
      int window_size = arducam_image->height;
      window_image = image_generate_center_window(arducam_image, window_size, window_size, window_image);
      npx_sample = npx_make_tensor_from_image(window_image);
      free(window_image->window_info);
      //image_free(window_image);
#else
      npx_sample = npx_make_tensor_from_image(arducam_image);
#endif
#endif

#if 0
#if 1
      resized = npx_tensor_resize(npx_sample->tensor, resized, 32, 32);
      inference_image = npx_make_rgb565image_from_tensor(resized);
      //inference_image = npx_make_rgb565image_from_tensor(npx_sample->tensor);
      oled_rgb_draw_rvx_image(inference_image);
      image_free(inference_image);
#else
      oled_rgb_draw_rvx_image(window_image);
#endif
#endif

      const npx_layerio_tsseq_t *input_tsseq = npx_preprocess(pre_fname, net, npx_sample->tensor, npx_sample->scaled);
      npx_network_reset(net);

      npx_layerio_state_t state;
      state.input_tsseq = input_tsseq;
      state.output_tsseq = NULL;
      state.output_tsseq = npx_inference(net, state.input_tsseq, 0, net->num_layer);
      int class_id = npx_result(net, state.output_tsseq, -1);
      
      npx_tensor_free(npx_sample->tensor);
      free(npx_sample);

      // diplay result on oled bw
      display_result(class_id);

      printf("\nPress btnc to restart!");
      wait_for_push_btnc();
    }
  }

  return 0;
}

int npx_result(npx_network_t *net, const npx_layerio_tsseq_t *output_tsseq, int min_acc_value)
{
  assert(output_tsseq);
  assert(output_tsseq->sequence[0]->num_dim == 2);
  assert(output_tsseq->sequence[0]->size[0] == 1);
  assert(output_tsseq->sequence[0]->size[1] == net->classes);

  int *output_acc = (int *)calloc(net->classes, sizeof(int));
  ErvpMatrixInfo *output_matrix = NULL;
  for (int i = 0; i < output_tsseq->timesteps; i++)
  {
    const NpxTensorInfo *const output_tensor = output_tsseq->sequence[i];
    output_matrix = npx_tensor_to_matrix_info(output_tensor, output_matrix);
    for (int j = 0; j < net->classes; j++)
      output_acc[j] += matrix_read_fixed_element(output_matrix, j, 0);
  }
  int max_index = -1;
  int max_value = -1; 
  for (int j = 0; j < net->classes; j++)
  {
    int value = output_acc[j];
    if (value >= min_acc_value)
      if (value > max_value)
      {
        max_index = j;
        max_value = value;
      }
  }
  printf("\nclassification result: %d", max_index);

  free(output_acc);
  free(output_matrix);

  return max_index;
}

