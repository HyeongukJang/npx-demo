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



module DCA_MATRIX_MAC_MMIOX
(
  clk,
  rstnn,
  ma_slxqdready,
  ma_slxqvalid,
  ma_slxqlast,
  ma_slxqwrite,
  ma_slxqlen,
  ma_slxqsize,
  ma_slxqburst,
  ma_slxqwstrb,
  ma_slxqwdata,
  ma_slxqaddr,
  ma_slxqburden,
  ma_slxydready,
  ma_slxyvalid,
  ma_slxylast,
  ma_slxywreply,
  ma_slxyresp,
  ma_slxyrdata,
  ma_slxyburden,
  mb_slxqdready,
  mb_slxqvalid,
  mb_slxqlast,
  mb_slxqwrite,
  mb_slxqlen,
  mb_slxqsize,
  mb_slxqburst,
  mb_slxqwstrb,
  mb_slxqwdata,
  mb_slxqaddr,
  mb_slxqburden,
  mb_slxydready,
  mb_slxyvalid,
  mb_slxylast,
  mb_slxywreply,
  mb_slxyresp,
  mb_slxyrdata,
  mb_slxyburden,
  mc_slxqdready,
  mc_slxqvalid,
  mc_slxqlast,
  mc_slxqwrite,
  mc_slxqlen,
  mc_slxqsize,
  mc_slxqburst,
  mc_slxqwstrb,
  mc_slxqwdata,
  mc_slxqaddr,
  mc_slxqburden,
  mc_slxydready,
  mc_slxyvalid,
  mc_slxylast,
  mc_slxywreply,
  mc_slxyresp,
  mc_slxyrdata,
  mc_slxyburden,
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
  control_rmx_output_fifo_wdata
);



parameter BW_ADDR = 32;
parameter MA_BW_DATA = 128;
parameter MA_HAS_BURDEN = 0;
parameter MA_BW_BURDEN = 1;
parameter MB_BW_DATA = 128;
parameter MB_HAS_BURDEN = 0;
parameter MB_BW_BURDEN = 1;
parameter MC_BW_DATA = 128;
parameter MC_HAS_BURDEN = 0;
parameter MC_BW_BURDEN = 1;

parameter MATRIX_SIZE_PARA = 8;
parameter TENSOR_PARA = 0;

localparam  LSU_PARA = 0;

localparam  DCA_LPARA_1 = 1;
localparam  DCA_LPARA_7 = `BW_DCA_MATRIX_MAC_STATUS;
localparam  DCA_LPARA_5 = `BW_DCA_MATRIX_MAC_LOG;
localparam  DCA_LPARA_2 = `BW_DCA_MATRIX_MAC_INST;
localparam  DCA_LPARA_4 = 32;
localparam  DCA_LPARA_6 = 32;

`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"

input wire clk;
input wire rstnn;
input wire [(2)-1:0] ma_slxqdready;
output wire ma_slxqvalid;
output wire ma_slxqlast;
output wire ma_slxqwrite;
output wire [(8)-1:0] ma_slxqlen;
output wire [(3)-1:0] ma_slxqsize;
output wire [(2)-1:0] ma_slxqburst;
output wire [(MA_BW_DATA/8)-1:0] ma_slxqwstrb;
output wire [(MA_BW_DATA)-1:0] ma_slxqwdata;
output wire [(BW_ADDR)-1:0] ma_slxqaddr;
output wire [(MA_BW_BURDEN)-1:0] ma_slxqburden;
output wire [(2)-1:0] ma_slxydready;
input wire ma_slxyvalid;
input wire ma_slxylast;
input wire ma_slxywreply;
input wire [(2)-1:0] ma_slxyresp;
input wire [(MA_BW_DATA)-1:0] ma_slxyrdata;
input wire [(MA_BW_BURDEN)-1:0] ma_slxyburden;
input wire [(2)-1:0] mb_slxqdready;
output wire mb_slxqvalid;
output wire mb_slxqlast;
output wire mb_slxqwrite;
output wire [(8)-1:0] mb_slxqlen;
output wire [(3)-1:0] mb_slxqsize;
output wire [(2)-1:0] mb_slxqburst;
output wire [(MB_BW_DATA/8)-1:0] mb_slxqwstrb;
output wire [(MB_BW_DATA)-1:0] mb_slxqwdata;
output wire [(BW_ADDR)-1:0] mb_slxqaddr;
output wire [(MB_BW_BURDEN)-1:0] mb_slxqburden;
output wire [(2)-1:0] mb_slxydready;
input wire mb_slxyvalid;
input wire mb_slxylast;
input wire mb_slxywreply;
input wire [(2)-1:0] mb_slxyresp;
input wire [(MB_BW_DATA)-1:0] mb_slxyrdata;
input wire [(MB_BW_BURDEN)-1:0] mb_slxyburden;
input wire [(2)-1:0] mc_slxqdready;
output wire mc_slxqvalid;
output wire mc_slxqlast;
output wire mc_slxqwrite;
output wire [(8)-1:0] mc_slxqlen;
output wire [(3)-1:0] mc_slxqsize;
output wire [(2)-1:0] mc_slxqburst;
output wire [(MC_BW_DATA/8)-1:0] mc_slxqwstrb;
output wire [(MC_BW_DATA)-1:0] mc_slxqwdata;
output wire [(BW_ADDR)-1:0] mc_slxqaddr;
output wire [(MC_BW_BURDEN)-1:0] mc_slxqburden;
output wire [(2)-1:0] mc_slxydready;
input wire mc_slxyvalid;
input wire mc_slxylast;
input wire mc_slxywreply;
input wire [(2)-1:0] mc_slxyresp;
input wire [(MC_BW_DATA)-1:0] mc_slxyrdata;
input wire [(MC_BW_BURDEN)-1:0] mc_slxyburden;
input wire [(DCA_LPARA_1)-1:0] control_rmx_core_config;
output wire [(DCA_LPARA_7)-1:0] control_rmx_core_status;
input wire control_rmx_clear_request;
output wire control_rmx_clear_finish;
input wire control_rmx_log_fifo_wready;
output wire control_rmx_log_fifo_wrequest;
output wire [(DCA_LPARA_5)-1:0] control_rmx_log_fifo_wdata;
input wire control_rmx_inst_fifo_rready;
input wire [(DCA_LPARA_2)-1:0] control_rmx_inst_fifo_rdata;
output wire control_rmx_inst_fifo_rrequest;
output wire control_rmx_operation_finish;
input wire control_rmx_input_fifo_rready;
input wire [(DCA_LPARA_4)-1:0] control_rmx_input_fifo_rdata;
output wire control_rmx_input_fifo_rrequest;
input wire control_rmx_output_fifo_wready;
output wire control_rmx_output_fifo_wrequest;
output wire [(DCA_LPARA_6)-1:0] control_rmx_output_fifo_wdata;

`include "dca_tensor_scalar_lpara.vb"
`include "dca_tensor_dim_lpara.vb"

`include "dca_lsu_util.vb"

localparam  DCA_LPARA_3 = MAKE_LSU_READ_ONLY(LSU_PARA);
localparam  DCA_LPARA_0 = MAKE_LSU_WRITE_ONLY(LSU_PARA);

wire dca_signal_32;
wire dca_signal_05;
wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_signal_12;
wire dca_signal_35;
wire dca_signal_26;
wire dca_signal_40;

wire dca_signal_29;
wire dca_signal_39;
wire [BW_TENSOR_ROW-1:0] dca_signal_02;
wire dca_signal_04;

wire dca_signal_09;
wire dca_signal_28;
wire dca_signal_31;
wire [BW_TENSOR_ROW-1:0] dca_signal_03;

wire dca_signal_01;
wire dca_signal_27;
wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_signal_13;
wire dca_signal_22;
wire dca_signal_36;
wire dca_signal_10;

wire dca_signal_41;
wire dca_signal_17;
wire [BW_TENSOR_ROW-1:0] dca_signal_20;
wire dca_signal_00;

wire dca_signal_14;
wire dca_signal_16;
wire dca_signal_11;
wire [BW_TENSOR_ROW-1:0] dca_signal_37;

wire dca_signal_30;
wire dca_signal_08;
wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_signal_19;
wire dca_signal_38;
wire dca_signal_34;
wire dca_signal_33;

wire dca_signal_06;
wire dca_signal_15;
wire [BW_TENSOR_ROW-1:0] dca_signal_24;
wire dca_signal_21;

wire dca_signal_18;
wire dca_signal_25;
wire dca_signal_07;
wire [BW_TENSOR_ROW-1:0] dca_signal_23;

DCA_MATRIX_LSU_XMI1P
#(
  .LSU_PARA(DCA_LPARA_3),
  .AXI_PARA(MA_BW_DATA),
  .BW_LPI_BURDEN(1),
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .TENSOR_PARA(TENSOR_PARA)
)
i_dca_instance_0
(
  .clk(clk),
  .rstnn(rstnn),
  .clear(1'b 0),
  .enable(1'b 1),
  .busy(dca_signal_32),

  .inst_wvalid(dca_signal_05),
  .inst_wdata(dca_signal_12),
  .inst_wready(dca_signal_35),
  .inst_decode_finish(dca_signal_26),
  .inst_execute_finish(dca_signal_40),

  .slxqdready(ma_slxqdready),
  .slxqvalid(ma_slxqvalid),
  .slxqlast(ma_slxqlast),
  .slxqwrite(ma_slxqwrite),
  .slxqlen(ma_slxqlen),
  .slxqsize(ma_slxqsize),
  .slxqburst(ma_slxqburst),
  .slxqwstrb(ma_slxqwstrb),
  .slxqwdata(ma_slxqwdata),
  .slxqaddr(ma_slxqaddr),
  .slxqburden(ma_slxqburden),
  .slxydready(ma_slxydready),
  .slxyvalid(ma_slxyvalid),
  .slxylast(ma_slxylast),
  .slxywreply(ma_slxywreply),
  .slxyresp(ma_slxyresp),
  .slxyrdata(ma_slxyrdata),
  .slxyburden(ma_slxyburden),

  .load_tensor_row_wvalid(dca_signal_29),
  .load_tensor_row_wlast(dca_signal_39),
  .load_tensor_row_wdata(dca_signal_02),
  .load_tensor_row_wready(dca_signal_04),

  .store_tensor_row_rvalid(dca_signal_09),
  .store_tensor_row_rlast(dca_signal_28),
  .store_tensor_row_rready(dca_signal_31),
  .store_tensor_row_rdata(dca_signal_03)
);

assign dca_signal_31 = 0;
assign dca_signal_28 = 0;
assign dca_signal_03 = 0;

DCA_MATRIX_LSU_XMI1P
#(
  .LSU_PARA(DCA_LPARA_3),
  .AXI_PARA(MB_BW_DATA),
  .BW_LPI_BURDEN(1),
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .TENSOR_PARA(TENSOR_PARA)
)
i_dca_instance_3
(
  .clk(clk),
  .rstnn(rstnn),
  .clear(1'b 0),
  .enable(1'b 1),
  .busy(dca_signal_01),

  .inst_wvalid(dca_signal_27),
  .inst_wdata(dca_signal_13),
  .inst_wready(dca_signal_22),
  .inst_decode_finish(dca_signal_36),
  .inst_execute_finish(dca_signal_10),

  .slxqdready(mb_slxqdready),
  .slxqvalid(mb_slxqvalid),
  .slxqlast(mb_slxqlast),
  .slxqwrite(mb_slxqwrite),
  .slxqlen(mb_slxqlen),
  .slxqsize(mb_slxqsize),
  .slxqburst(mb_slxqburst),
  .slxqwstrb(mb_slxqwstrb),
  .slxqwdata(mb_slxqwdata),
  .slxqaddr(mb_slxqaddr),
  .slxqburden(mb_slxqburden),
  .slxydready(mb_slxydready),
  .slxyvalid(mb_slxyvalid),
  .slxylast(mb_slxylast),
  .slxywreply(mb_slxywreply),
  .slxyresp(mb_slxyresp),
  .slxyrdata(mb_slxyrdata),
  .slxyburden(mb_slxyburden),
  
  .load_tensor_row_wvalid(dca_signal_41),
  .load_tensor_row_wlast(dca_signal_17),
  .load_tensor_row_wdata(dca_signal_20),
  .load_tensor_row_wready(dca_signal_00),

  .store_tensor_row_rvalid(dca_signal_14),
  .store_tensor_row_rlast(dca_signal_16),
  .store_tensor_row_rready(dca_signal_11),
  .store_tensor_row_rdata(dca_signal_37)
);

assign dca_signal_11 = 0;
assign dca_signal_16 = 0;
assign dca_signal_37 = 0;

DCA_MATRIX_LSU_XMI1P
#(
  .LSU_PARA(DCA_LPARA_0),
  .AXI_PARA(MC_BW_DATA),
  .BW_LPI_BURDEN(1),
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .TENSOR_PARA(TENSOR_PARA)
)
i_dca_instance_2
(
  .clk(clk),
  .rstnn(rstnn),
  .clear(1'b 0),
  .enable(1'b 1),
  .busy(dca_signal_30),

  .inst_wvalid(dca_signal_08),
  .inst_wdata(dca_signal_19),
  .inst_wready(dca_signal_38),
  .inst_decode_finish(dca_signal_34),
  .inst_execute_finish(dca_signal_33),

  .slxqdready(mc_slxqdready),
  .slxqvalid(mc_slxqvalid),
  .slxqlast(mc_slxqlast),
  .slxqwrite(mc_slxqwrite),
  .slxqlen(mc_slxqlen),
  .slxqsize(mc_slxqsize),
  .slxqburst(mc_slxqburst),
  .slxqwstrb(mc_slxqwstrb),
  .slxqwdata(mc_slxqwdata),
  .slxqaddr(mc_slxqaddr),
  .slxqburden(mc_slxqburden),
  .slxydready(mc_slxydready),
  .slxyvalid(mc_slxyvalid),
  .slxylast(mc_slxylast),
  .slxywreply(mc_slxywreply),
  .slxyresp(mc_slxyresp),
  .slxyrdata(mc_slxyrdata),
  .slxyburden(mc_slxyburden),
  
  .load_tensor_row_wvalid(dca_signal_06),
  .load_tensor_row_wlast(dca_signal_15),
  .load_tensor_row_wdata(dca_signal_24),
  .load_tensor_row_wready(dca_signal_21),

  .store_tensor_row_rvalid(dca_signal_18),
  .store_tensor_row_rlast(dca_signal_25),
  .store_tensor_row_rready(dca_signal_07),
  .store_tensor_row_rdata(dca_signal_23)
);

assign dca_signal_21 = 0;

DCA_MATRIX_MAC_MMIOX_MLSU
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .TENSOR_PARA(TENSOR_PARA)
)
i_dca_instance_1
(
  .clk(clk),
  .rstnn(rstnn),

  .control_rmx_core_config(control_rmx_core_config),
  .control_rmx_core_status(control_rmx_core_status),
  .control_rmx_clear_request(control_rmx_clear_request),
  .control_rmx_clear_finish(control_rmx_clear_finish),
  .control_rmx_log_fifo_wready(control_rmx_log_fifo_wready),
  .control_rmx_log_fifo_wrequest(control_rmx_log_fifo_wrequest),
  .control_rmx_log_fifo_wdata(control_rmx_log_fifo_wdata),
  .control_rmx_inst_fifo_rready(control_rmx_inst_fifo_rready),
  .control_rmx_inst_fifo_rdata(control_rmx_inst_fifo_rdata),
  .control_rmx_inst_fifo_rrequest(control_rmx_inst_fifo_rrequest),
  .control_rmx_operation_finish(control_rmx_operation_finish),
  .control_rmx_input_fifo_rready(control_rmx_input_fifo_rready),
  .control_rmx_input_fifo_rdata(control_rmx_input_fifo_rdata),
  .control_rmx_input_fifo_rrequest(control_rmx_input_fifo_rrequest),
  .control_rmx_output_fifo_wready(control_rmx_output_fifo_wready),
  .control_rmx_output_fifo_wrequest(control_rmx_output_fifo_wrequest),
  .control_rmx_output_fifo_wdata(control_rmx_output_fifo_wdata),

  .ma_sinst_wvalid(dca_signal_05),
	.ma_sinst_wdata(dca_signal_12),
	.ma_sinst_wready(dca_signal_35),
	.ma_sinst_decode_finish(dca_signal_26),
	.ma_sinst_execute_finish(dca_signal_40),
	.ma_sinst_busy(dca_signal_32),
	.ma_sload_tensor_row_wvalid(dca_signal_29),
	.ma_sload_tensor_row_wlast(dca_signal_39),
	.ma_sload_tensor_row_wdata(dca_signal_02),
	.ma_sload_tensor_row_wready(dca_signal_04),
	.ma_sstore_tensor_row_rvalid(dca_signal_09),
	.ma_sstore_tensor_row_rlast(dca_signal_28),
	.ma_sstore_tensor_row_rdata(dca_signal_03),
	.ma_sstore_tensor_row_rready(dca_signal_31),

  .mb_sinst_wvalid(dca_signal_27),
	.mb_sinst_wdata(dca_signal_13),
	.mb_sinst_wready(dca_signal_22),
	.mb_sinst_decode_finish(dca_signal_36),
	.mb_sinst_execute_finish(dca_signal_10),
	.mb_sinst_busy(dca_signal_01),
	.mb_sload_tensor_row_wvalid(dca_signal_41),
	.mb_sload_tensor_row_wlast(dca_signal_17),
	.mb_sload_tensor_row_wdata(dca_signal_20),
	.mb_sload_tensor_row_wready(dca_signal_00),
	.mb_sstore_tensor_row_rvalid(dca_signal_14),
	.mb_sstore_tensor_row_rlast(dca_signal_16),
	.mb_sstore_tensor_row_rdata(dca_signal_37),
	.mb_sstore_tensor_row_rready(dca_signal_11),

  .mc_sinst_wvalid(dca_signal_08),
	.mc_sinst_wdata(dca_signal_19),
	.mc_sinst_wready(dca_signal_38),
	.mc_sinst_decode_finish(dca_signal_34),
	.mc_sinst_execute_finish(dca_signal_33),
	.mc_sinst_busy(dca_signal_30),
	.mc_sload_tensor_row_wvalid(dca_signal_06),
	.mc_sload_tensor_row_wlast(dca_signal_15),
	.mc_sload_tensor_row_wdata(dca_signal_24),
	.mc_sload_tensor_row_wready(dca_signal_21),
	.mc_sstore_tensor_row_rvalid(dca_signal_18),
	.mc_sstore_tensor_row_rlast(dca_signal_25),
	.mc_sstore_tensor_row_rdata(dca_signal_23),
	.mc_sstore_tensor_row_rready(dca_signal_07)
);

endmodule
