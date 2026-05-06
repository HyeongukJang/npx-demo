// ****************************************************************************
// ****************************************************************************
// Copyright SoC Design Research Group, All rights reservxd.
// Electronics and Telecommunications Research Institute (ETRI)
// 
// THESE DOCUMENTS CONTAIN CONFIDENTIAL INFORMATION AND KNOWLEDGE
// WHICH IS THE PROPERTY OF ETRI. NO PART OF THIS PUBLICATION IS
// TO BE USED FOR ANY OTHER PURPOSE, AND THESE ARE NOT TO BE
// REPRODUCED, COPIED, DISCLOSED, TRANSMITTED, STORED IN A RETRIEVAL
// SYSTEM OR TRANSLATED INTO ANY OTHER HUMAN OR COMPUTER LANGUAGE,
// IN ANY FORM, BY ANY MEANS, IN WHOLE OR IN PART, WITHOUT THE
// COMPLETE PRIOR WRITTEN PERMISSION OF ETRI.
// ****************************************************************************
// 2025-11-05
// Kyuseung Han (han@etri.re.kr)
// ****************************************************************************
// ****************************************************************************

`include "ervp_global.vh"
`include "ervp_endian.vh"
`include "dca_module_memorymap_offset.vh"

`include "dca_matrix_info.vh"
`include "dca_matrix_lsu_inst.vh"



module DCA_MATRIX_MAC_MMIOX_MLSU
(
  clk,
  rstnn,

  control_rmx_core_config,
  control_rmx_core_status,
  control_rmx_clear_request,
  control_rmx_clear_finish,
  control_rmx_log_fifo_wready,
  control_rmx_log_fifo_wrequest,
  control_rmx_log_fifo_wdata,
  control_rmx_inst_fifo_rready,
  control_rmx_inst_fifo_rdata,
  control_rmx_inst_fifo_rrequest,
  control_rmx_operation_finish,
  control_rmx_input_fifo_rready,
  control_rmx_input_fifo_rdata,
  control_rmx_input_fifo_rrequest,
  control_rmx_output_fifo_wready,
  control_rmx_output_fifo_wrequest,
  control_rmx_output_fifo_wdata,

  ma_sinst_wvalid,
	ma_sinst_wdata,
	ma_sinst_wready,
	ma_sinst_decode_finish,
	ma_sinst_execute_finish,
	ma_sinst_busy,
	ma_sload_tensor_row_wvalid,
	ma_sload_tensor_row_wlast,
	ma_sload_tensor_row_wdata,
	ma_sload_tensor_row_wready,
	ma_sstore_tensor_row_rvalid,
	ma_sstore_tensor_row_rlast,
	ma_sstore_tensor_row_rready,
  ma_sstore_tensor_row_rdata,

  mb_sinst_wvalid,
	mb_sinst_wdata,
	mb_sinst_wready,
	mb_sinst_decode_finish,
	mb_sinst_execute_finish,
	mb_sinst_busy,
	mb_sload_tensor_row_wvalid,
	mb_sload_tensor_row_wlast,
	mb_sload_tensor_row_wdata,
	mb_sload_tensor_row_wready,
	mb_sstore_tensor_row_rvalid,
	mb_sstore_tensor_row_rlast,
	mb_sstore_tensor_row_rready,
  mb_sstore_tensor_row_rdata,

  mc_sinst_wvalid,
	mc_sinst_wdata,
	mc_sinst_wready,
	mc_sinst_decode_finish,
	mc_sinst_execute_finish,
	mc_sinst_busy,
	mc_sload_tensor_row_wvalid,
	mc_sload_tensor_row_wlast,
	mc_sload_tensor_row_wdata,
	mc_sload_tensor_row_wready,
	mc_sstore_tensor_row_rvalid,
	mc_sstore_tensor_row_rlast,
	mc_sstore_tensor_row_rready,
	mc_sstore_tensor_row_rdata
);



parameter BW_ADDR = 32;
parameter MA_BW_DATA = 128;
parameter MB_BW_DATA = 128;
parameter MC_BW_DATA = 128;

parameter MATRIX_SIZE_PARA = 8;
parameter TENSOR_PARA = 0;

localparam  DCA_LPARA_4 = 1;
localparam  DCA_LPARA_0 = `BW_DCA_MATRIX_MAC_STATUS;
localparam  DCA_LPARA_2 = `BW_DCA_MATRIX_MAC_LOG;
localparam  DCA_LPARA_3 = `BW_DCA_MATRIX_MAC_INST;
localparam  DCA_LPARA_1 = 32;
localparam  DCA_LPARA_5 = 32;

`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"
`include "dca_tensor_scalar_lpara.vb"

input wire clk;
input wire rstnn;

input wire [(DCA_LPARA_4)-1:0] control_rmx_core_config;
output wire [(DCA_LPARA_0)-1:0] control_rmx_core_status;
input wire control_rmx_clear_request;
output wire control_rmx_clear_finish;
input wire control_rmx_log_fifo_wready;
output wire control_rmx_log_fifo_wrequest;
output wire [(DCA_LPARA_2)-1:0] control_rmx_log_fifo_wdata;
input wire control_rmx_inst_fifo_rready;
input wire [(DCA_LPARA_3)-1:0] control_rmx_inst_fifo_rdata;
output wire control_rmx_inst_fifo_rrequest;
output wire control_rmx_operation_finish;
input wire control_rmx_input_fifo_rready;
input wire [(DCA_LPARA_1)-1:0] control_rmx_input_fifo_rdata;
output wire control_rmx_input_fifo_rrequest;
input wire control_rmx_output_fifo_wready;
output wire control_rmx_output_fifo_wrequest;
output wire [(DCA_LPARA_5)-1:0] control_rmx_output_fifo_wdata;

output wire ma_sinst_wvalid;
output wire [(`BW_DCA_MATRIX_LSU_INST)-1:0] ma_sinst_wdata;
input wire ma_sinst_wready;
input wire ma_sinst_decode_finish;
input wire ma_sinst_execute_finish;
input wire ma_sinst_busy;
input wire ma_sload_tensor_row_wvalid;
input wire ma_sload_tensor_row_wlast;
input wire [(BW_TENSOR_SCALAR*MATRIX_NUM_COL)-1:0] ma_sload_tensor_row_wdata;
output wire ma_sload_tensor_row_wready;
input wire ma_sstore_tensor_row_rvalid;
input wire ma_sstore_tensor_row_rlast;
output wire ma_sstore_tensor_row_rready;
output wire [(BW_TENSOR_SCALAR*MATRIX_NUM_COL)-1:0] ma_sstore_tensor_row_rdata;

output wire mb_sinst_wvalid;
output wire [(`BW_DCA_MATRIX_LSU_INST)-1:0] mb_sinst_wdata;
input wire mb_sinst_wready;
input wire mb_sinst_decode_finish;
input wire mb_sinst_execute_finish;
input wire mb_sinst_busy;
input wire mb_sload_tensor_row_wvalid;
input wire mb_sload_tensor_row_wlast;
input wire [(BW_TENSOR_SCALAR*MATRIX_NUM_COL)-1:0] mb_sload_tensor_row_wdata;
output wire mb_sload_tensor_row_wready;
input wire mb_sstore_tensor_row_rvalid;
input wire mb_sstore_tensor_row_rlast;
output wire mb_sstore_tensor_row_rready;
output wire [(BW_TENSOR_SCALAR*MATRIX_NUM_COL)-1:0] mb_sstore_tensor_row_rdata;

output wire mc_sinst_wvalid;
output wire [(`BW_DCA_MATRIX_LSU_INST)-1:0] mc_sinst_wdata;
input wire mc_sinst_wready;
input wire mc_sinst_decode_finish;
input wire mc_sinst_execute_finish;
input wire mc_sinst_busy;
input wire mc_sload_tensor_row_wvalid;
input wire mc_sload_tensor_row_wlast;
input wire [(BW_TENSOR_SCALAR*MATRIX_NUM_COL)-1:0] mc_sload_tensor_row_wdata;
output wire mc_sload_tensor_row_wready;
input wire mc_sstore_tensor_row_rvalid;
input wire mc_sstore_tensor_row_rlast;
output wire mc_sstore_tensor_row_rready;
output wire [(BW_TENSOR_SCALAR*MATRIX_NUM_COL)-1:0] mc_sstore_tensor_row_rdata;

wire dca_signal_0;
wire [DCA_LPARA_3-1:0] dca_signal_6;
wire dca_signal_5;
wire dca_signal_4;
wire dca_signal_2;
wire dca_signal_3;
wire [DCA_LPARA_2-1:0] dca_signal_1;
wire [DCA_LPARA_0-1:0] dca_signal_7;

assign control_rmx_core_status = dca_signal_7;
assign control_rmx_clear_finish = 0;
assign dca_signal_2 = control_rmx_log_fifo_wready;
assign control_rmx_log_fifo_wrequest = dca_signal_3;
assign control_rmx_log_fifo_wdata = dca_signal_1;
assign dca_signal_0 = control_rmx_inst_fifo_rready;
assign dca_signal_6 = control_rmx_inst_fifo_rdata;
assign control_rmx_inst_fifo_rrequest = dca_signal_5;
assign control_rmx_operation_finish = dca_signal_4;
assign control_rmx_input_fifo_rrequest = 0;
assign control_rmx_output_fifo_wrequest = 0;
assign control_rmx_output_fifo_wdata = 0;

DCA_MODULE_12
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .TENSOR_PARA(TENSOR_PARA)
)
i_dca_instance_0
(
  .dca_port_23(clk),
  .dca_port_41(rstnn),
  .dca_port_02(1'b 0),
  .dca_port_42(1'b 1),
  .dca_port_34(),

  .dca_port_19(dca_signal_0),
  .dca_port_36(dca_signal_6),
  .dca_port_09(dca_signal_5),
  .dca_port_28(dca_signal_4),
  .dca_port_30(dca_signal_2),
  .dca_port_40(dca_signal_3),
  .dca_port_01(dca_signal_1),
  .dca_port_32(dca_signal_7),

  .dca_port_13(ma_sinst_busy),
  .dca_port_24(ma_sinst_wvalid),
  .dca_port_22(ma_sinst_wdata),
  .dca_port_17(ma_sinst_wready),
  .dca_port_16(ma_sinst_decode_finish),
  .dca_port_21(ma_sinst_execute_finish),
  .dca_port_10(ma_sload_tensor_row_wready),
  .dca_port_31(ma_sload_tensor_row_wvalid),
  .dca_port_06(ma_sload_tensor_row_wlast),
  .dca_port_43(ma_sload_tensor_row_wdata),

  .dca_port_29(mb_sinst_busy),
  .dca_port_33(mb_sinst_wvalid),
  .dca_port_37(mb_sinst_wdata),
  .dca_port_14(mb_sinst_wready),
  .dca_port_08(mb_sinst_decode_finish),
  .dca_port_15(mb_sinst_execute_finish),
  .dca_port_03(mb_sload_tensor_row_wready),
  .dca_port_38(mb_sload_tensor_row_wvalid),
  .dca_port_45(mb_sload_tensor_row_wlast),
  .dca_port_12(mb_sload_tensor_row_wdata),

  .dca_port_07(mc_sinst_busy),
  .dca_port_25(mc_sinst_wvalid),
  .dca_port_35(mc_sinst_wdata),
  .dca_port_18(mc_sinst_wready),
  .dca_port_26(mc_sinst_decode_finish),
  .dca_port_00(mc_sinst_execute_finish),
  .dca_port_46(mc_sload_tensor_row_wready),
  .dca_port_05(mc_sload_tensor_row_wvalid),
  .dca_port_20(mc_sload_tensor_row_wlast),
  .dca_port_11(mc_sload_tensor_row_wdata),
  .dca_port_39(mc_sstore_tensor_row_rvalid),
  .dca_port_27(mc_sstore_tensor_row_rready),
  .dca_port_44(mc_sstore_tensor_row_rlast),
  .dca_port_04(mc_sstore_tensor_row_rdata)
);

assign ma_sstore_tensor_row_rready = 0;
assign ma_sstore_tensor_row_rdata = 0;

assign mb_sstore_tensor_row_rready = 0;
assign mb_sstore_tensor_row_rdata = 0;

endmodule
