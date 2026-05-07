#include "platform_info.h"
#include "ervp_assert.h"
#include "ervp_printf.h"
#include "ervp_matrix_op_transform.h"
#include "ervp_blocked_matrix_op.h"

#include "ip_instance_info.h"
#include "dca_neugemm.h"

#include "map_your_matrix_hw.h"

const char matrix_hw_name[] = "DCA";

ervp_hwtask_busy_fx_t i_dca_neugemm00_add(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, const ErvpMatrixInfo *mb_info, ErvpMatrixInfo *mc_info, int options)
{
  return dca_neugemm_add(mop_mapping, i_dca_neugemm00_info, ma_info, mb_info, mc_info, options);
}

ervp_hwtask_busy_fx_t i_dca_neugemm00_sub(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, const ErvpMatrixInfo *mb_info, ErvpMatrixInfo *mc_info, int options)
{
  return dca_neugemm_sub(mop_mapping, i_dca_neugemm00_info, ma_info, mb_info, mc_info, options);
}

ervp_hwtask_busy_fx_t i_dca_neugemm00_ewmult(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, const ErvpMatrixInfo *mb_info, ErvpMatrixInfo *mc_info, int options)
{
  return dca_neugemm_ewmult(mop_mapping, i_dca_neugemm00_info, ma_info, mb_info, mc_info, options);
}

ervp_hwtask_busy_fx_t i_dca_neugemm00_mult(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, const ErvpMatrixInfo *mb_info, ErvpMatrixInfo *mc_info, int options)
{
  return dca_neugemm_mult(mop_mapping, i_dca_neugemm00_info, ma_info, mb_info, mc_info, options);
}

ervp_hwtask_busy_fx_t i_dca_neugemm00_scalar_mult_fixed(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, int scalar_value, ErvpMatrixInfo *mc_info, int options)
{
  return dca_neugemm_scalar_mult_fixed(mop_mapping, i_dca_neugemm00_info, ma_info, scalar_value, mc_info, options);
}

ervp_hwtask_busy_fx_t i_dca_neugemm00_conv_oneblock(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, const ErvpMatrixInfo *mb_info, ErvpMatrixInfo *mc_info, int conv_options)
{
  return dca_neugemm_conv_oneblock(mop_mapping, i_dca_neugemm00_info, ma_info, mb_info, mc_info, conv_options);
}

ervp_hwtask_busy_fx_t i_dca_neugemm00_conv_oneblock_sharedinput(ervp_mop_mapping_t *mop_mapping, int num_output, const ErvpMatrixInfo *input_info, const ErvpMatrixInfo **kernel_info_list, ErvpMatrixInfo **output_info_list, int conv_options)
{
  return dca_neugemm_conv_oneblock_sharedinput(mop_mapping, i_dca_neugemm00_info, num_output, input_info, kernel_info_list, output_info_list, conv_options);
}

ervp_hwtask_busy_fx_t i_dca_neugemm00_conv_oneblock_sharedoutput(ervp_mop_mapping_t *mop_mapping, int num_input, const ErvpMatrixInfo **input_info_list, const ErvpMatrixInfo **kernel_info_list, ErvpMatrixInfo *output_info, int conv_options, int init_ouptut)
{
  return dca_neugemm_conv_oneblock_sharedoutput(mop_mapping, i_dca_neugemm00_info, num_input, input_info_list, kernel_info_list, output_info, conv_options, init_ouptut);
}

////////////////////////////////////////////////////////////////////////////

static ervp_blocked_matrix_info_t* blocked_info_conv;

ervp_hwtask_busy_fx_t i_blocked_matrix_conv(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, const ErvpMatrixInfo *mb_info, ErvpMatrixInfo *mc_info, int conv_options)
{
  return blocked_matrix_conv(blocked_info_conv, ma_info, mb_info, mc_info, conv_options);
}

ervp_hwtask_busy_fx_t i_blocked_matrix_conv_sharedinput(ervp_mop_mapping_t *mop_mapping, int num_output, const ErvpMatrixInfo *input_info, const ErvpMatrixInfo **kernel_info_list, ErvpMatrixInfo **output_info_list, int conv_options)
{
  return blocked_matrix_conv_sharedinput(blocked_info_conv, num_output, input_info, kernel_info_list, output_info_list, conv_options);
}

ervp_hwtask_busy_fx_t i_blocked_matrix_conv_sharedoutput(ervp_mop_mapping_t *mop_mapping, int num_input, const ErvpMatrixInfo **input_info_list, const ErvpMatrixInfo **kernel_info_list, ErvpMatrixInfo *output_info, int conv_options, int init_ouptut)
{
  return blocked_matrix_conv_sharedoutput(blocked_info_conv, num_input, input_info_list, kernel_info_list, output_info, conv_options, init_ouptut);
}

////////////////////////////////////////////////////////////////////////////

void map_your_matrix_function(ervp_mop_mapping_t *mop_mapping)
{
  /* map your own functions */
  blocked_info_conv = blocked_matrix_info_alloc();
  blocked_info_conv->block_size = i_dca_neugemm00_info->num_col;
  blocked_info_conv->subop_mapping = matrix_op_mapping_alloc();
  blocked_info_conv->subop_mapping->matrix_add = i_dca_neugemm00_add;
  blocked_info_conv->subop_mapping->matrix_sub = i_dca_neugemm00_sub;
  blocked_info_conv->subop_mapping->matrix_ewmult = i_dca_neugemm00_ewmult;
  blocked_info_conv->subop_mapping->matrix_mult = i_dca_neugemm00_mult;
  blocked_info_conv->subop_mapping->matrix_scalar_mult_fixed = i_dca_neugemm00_scalar_mult_fixed;
  blocked_info_conv->subop_mapping->matrix_conv = i_dca_neugemm00_conv_oneblock;
  blocked_info_conv->subop_mapping->matrix_conv_sharedinput = i_dca_neugemm00_conv_oneblock_sharedinput;
  blocked_info_conv->subop_mapping->matrix_conv_sharedoutput = i_dca_neugemm00_conv_oneblock_sharedoutput;

  mop_mapping->matrix_add = i_dca_neugemm00_add;
  mop_mapping->matrix_sub = i_dca_neugemm00_sub;
  mop_mapping->matrix_ewmult = i_dca_neugemm00_ewmult;
  mop_mapping->matrix_mult = i_dca_neugemm00_mult;
  mop_mapping->matrix_scalar_mult_fixed = i_dca_neugemm00_scalar_mult_fixed;
  mop_mapping->matrix_conv = i_blocked_matrix_conv;
#if 1
  mop_mapping->matrix_conv_sharedinput = i_blocked_matrix_conv_sharedinput;
  mop_mapping->matrix_conv_sharedoutput = i_blocked_matrix_conv_sharedoutput;
#else
  mop_mapping->matrix_conv_sharedinput = matrix_conv_sharedinput_im2col_tf;
  mop_mapping->matrix_conv_sharedoutput = i_blocked_matrix_conv_sharedoutput;
#endif
}
