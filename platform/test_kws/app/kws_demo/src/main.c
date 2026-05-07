#include "platform_info.h"
#include "ervp_printf.h"
#include "ervp_printf_section.h"
#include "ervp_core_id.h"
#include "ervp_mcom_input.h"
#include "PmodOLED.h"

#include "ervp_matrix.h"
#include "ervp_matrix_element.h"

#include "npx_struct.h"
#include "npx_parser.h"
#include "npx_network.h"
#include "npx_sample.h"
#include "npx_preprocess.h"
#include "npx_tensor.h"

#include "mic3.h"
#include "ui.h"
#include "map_your_matrix_hw.h"

#define FNAME_MAX 256

char app_name[FNAME_MAX] = "kws_app";

char net_fname[FNAME_MAX];
char opt_fname[FNAME_MAX];
char parameter_fname[FNAME_MAX];
char tv_fname[FNAME_MAX];
char pre_fname[FNAME_MAX];

#define SKIP_SIM 1

int show_kws_result(npx_network_t *net, const npx_layerio_tsseq_t *output_tsseq, int min_acc_value, const npx_rawinput_t *sample);

int main()
{
  if (EXCLUSIVE_ID == 0)
  {
    int btn_idx;

    ervp_mop_mapping_t* mop_mapping = matrix_op_mapping_alloc();
    map_your_matrix_function(mop_mapping);

    sprintf(net_fname, "%s_network.cfg", app_name);
    sprintf(opt_fname, "%s_operator.cfg", app_name);
    sprintf(pre_fname, "%s_preprocess.cfg", app_name);
    sprintf(parameter_fname, "%s_parameter_quant.bin", app_name);

    printf_section(SKIP_SIM, "Test App: %s", net_fname);

    npx_network_t *net = npx_parse_network_cfg(net_fname, opt_fname);
    npx_network_load_parameters(net, parameter_fname);
    npx_network_map_matrix_operator(net, -1, mop_mapping);
    npx_network_print(net);

    OledInit();
    mic3_set_env();
    init_btn();

    printf("\nPress the push button BTNC for KWS or BTNU for exit!\n");
    while(1)
    {
      btn_idx = wait_for_push_btn();
      if(btn_idx==1)
      {
        mic3_start();
        mic3_wait_until_buffer_full();
        const npx_rawinput_t *npx_sample = mic3_get_sample();
        mic3_draw_waveform();

        const npx_layerio_tsseq_t *input_tsseq = npx_preprocess(pre_fname, net, npx_sample->tensor, npx_sample->scaled);
        npx_network_reset(net);

        npx_layerio_state_t state;
        state.input_tsseq = input_tsseq;
        state.output_tsseq = npx_inference(net, state.input_tsseq, 0, net->num_layer);
        show_kws_result(net, state.output_tsseq, -1, npx_sample);
        printf("\nPress the push button BTNC for KWS or BTNU for exit!\n");
      }
      else if(btn_idx==2)
      {
        break;
      }
    }
  }

  return 0;
}

int show_kws_result(npx_network_t *net, const npx_layerio_tsseq_t *output_tsseq, int min_acc_value, const npx_rawinput_t *sample)
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

    printf("\ntimestep: %d - ", i);
    for (int j = 0; j < net->classes; j++)
      printf("%d ", matrix_read_fixed_element(output_matrix, j, 0));
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
  if (sample)
  {
    int correct = ((max_index == sample->label) && (max_value >= (output_tsseq->timesteps - 1)));
    if (correct)
      printf("\nTarget keyword detected: %d (label:%d) / spikes: %d", max_index, sample->label, max_value);
    else
      printf("\nNo target keyword detected: %d (label:%d) / spikes: %d", max_index, sample->label, max_value);
  }

  free(output_acc);
  free(output_matrix);

  return max_index;
}

