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



module DCA_MATRIX_MAC
(
  clk_core,
  rstnn_core,
  clk_mmio,
  rstnn_mmio,
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
  control_rpsel,
  control_rpenable,
  control_rpwrite,
  control_rpaddr,
  control_rpwdata,
  control_rpready,
  control_rprdata,
  control_rpslverr
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
parameter CONTROL_MEMORYMAP = (32'h 1000);
parameter CONTROL_BW_DATA = 32;

parameter MMIO_ENDIAN_TYPE = `LITTLE_ENDIAN;
parameter MATRIX_SIZE_PARA = 8;
parameter TENSOR_PARA = 0;

localparam  LSU_PARA = 0;

localparam  DCA_LPARA_06 = 1;
localparam  DCA_LPARA_00 = `BW_DCA_MATRIX_MAC_STATUS;
localparam  DCA_LPARA_08 = `BW_DCA_MATRIX_MAC_LOG;
localparam  DCA_LPARA_01 = `BW_DCA_MATRIX_MAC_INST;
localparam  DCA_LPARA_05 = 32;
localparam  DCA_LPARA_07 = 32;

localparam  DCA_LPARA_04 = 0;
localparam  DCA_LPARA_09 = 4;
localparam  DCA_LPARA_02 = 0;
localparam  DCA_LPARA_03 = 0;

`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"

input wire clk_core;
input wire rstnn_core;
input wire clk_mmio;
input wire rstnn_mmio;
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
input wire control_rpsel;
input wire control_rpenable;
input wire control_rpwrite;
input wire [(BW_ADDR)-1:0] control_rpaddr;
input wire [(CONTROL_BW_DATA)-1:0] control_rpwdata;
output wire control_rpready;
output wire [(CONTROL_BW_DATA)-1:0] control_rprdata;
output wire control_rpslverr;

wire [(DCA_LPARA_06)-1:0] dca_signal_16;
wire [(DCA_LPARA_00)-1:0] dca_signal_10;
wire dca_signal_09;
wire dca_signal_01;
wire dca_signal_07;
wire dca_signal_00;
wire [(DCA_LPARA_08)-1:0] dca_signal_13;
wire dca_signal_05;
wire [(DCA_LPARA_01)-1:0] dca_signal_15;
wire dca_signal_03;
wire dca_signal_08;
wire dca_signal_12;
wire [(DCA_LPARA_05)-1:0] dca_signal_06;
wire dca_signal_11;
wire dca_signal_14;
wire dca_signal_02;
wire [(DCA_LPARA_07)-1:0] dca_signal_04;

ERVP_APB2MMIOX
#(
  .BW_ADDR(BW_ADDR),
  .BW_APB_DATA(CONTROL_BW_DATA),
  .ENDIAN_TYPE(MMIO_ENDIAN_TYPE),
  .BW_CONFIG(DCA_LPARA_06),
  .BW_STATUS(DCA_LPARA_00),
  .BW_LOG(DCA_LPARA_08),
  .BW_INST(DCA_LPARA_01),
  .LOG_FIFO_DEPTH(DCA_LPARA_04),  
  .INST_FIFO_DEPTH(DCA_LPARA_09),
  .INPUT_FIFO_DEPTH(DCA_LPARA_02),
  .OUTPUT_FIFO_DEPTH(DCA_LPARA_03)
)
i_dca_instance_1
(
  .clk_mmio(clk_mmio),
  .rstnn_mmio(rstnn_mmio),
  .clk_acc(clk_core),
  .rstnn_acc(rstnn_core),

  .mmio_rpsel(control_rpsel),
  .mmio_rpenable(control_rpenable),
  .mmio_rpaddr(control_rpaddr),
  .mmio_rpwrite(control_rpwrite),
  .mmio_rpwdata(control_rpwdata),
  .mmio_rprdata(control_rprdata),
  .mmio_rpready(control_rpready),
  .mmio_rpslverr(control_rpslverr),

  .interrupt_list(),
  
  .smx_core_config(dca_signal_16),
  .smx_core_status(dca_signal_10),
  .smx_clear_request(dca_signal_09),
  .smx_clear_finish(dca_signal_01),
  .smx_core_log_wready(dca_signal_07),
  .smx_core_log_wrequest(dca_signal_00),
  .smx_core_log_wdata(dca_signal_13),
  .smx_inst_fifo_rready(dca_signal_05),
  .smx_inst_fifo_rdata(dca_signal_15),
  .smx_inst_fifo_rrequest(dca_signal_03),
  .smx_operation_finish(dca_signal_08),
  .smx_input_fifo_rready(dca_signal_12),
  .smx_input_fifo_rdata(dca_signal_06),
  .smx_input_fifo_rrequest(dca_signal_11),
  .smx_output_fifo_wready(dca_signal_14),
  .smx_output_fifo_wrequest(dca_signal_02),
  .smx_output_fifo_wdata(dca_signal_04)
);

DCA_MATRIX_MAC_MMIOX
#(
  .BW_ADDR(BW_ADDR),
  .MA_BW_DATA(MA_BW_DATA),
  .MA_HAS_BURDEN(MA_HAS_BURDEN),
  .MA_BW_BURDEN(MA_BW_BURDEN),
  .MB_BW_DATA(MB_BW_DATA),
  .MB_HAS_BURDEN(MB_HAS_BURDEN),
  .MB_BW_BURDEN(MB_BW_BURDEN),
  .MC_BW_DATA(MC_BW_DATA),
  .MC_HAS_BURDEN(MC_HAS_BURDEN),
  .MC_BW_BURDEN(MC_BW_BURDEN),
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .TENSOR_PARA(TENSOR_PARA)
)
i_dca_instance_0
(
  .clk(clk_core),
  .rstnn(rstnn_core),
  .ma_slxqdready(ma_slxqdready),
  .ma_slxqvalid(ma_slxqvalid),
  .ma_slxqlast(ma_slxqlast),
  .ma_slxqwrite(ma_slxqwrite),
  .ma_slxqlen(ma_slxqlen),
  .ma_slxqsize(ma_slxqsize),
  .ma_slxqburst(ma_slxqburst),
  .ma_slxqwstrb(ma_slxqwstrb),
  .ma_slxqwdata(ma_slxqwdata),
  .ma_slxqaddr(ma_slxqaddr),
  .ma_slxqburden(ma_slxqburden),
  .ma_slxydready(ma_slxydready),
  .ma_slxyvalid(ma_slxyvalid),
  .ma_slxylast(ma_slxylast),
  .ma_slxywreply(ma_slxywreply),
  .ma_slxyresp(ma_slxyresp),
  .ma_slxyrdata(ma_slxyrdata),
  .ma_slxyburden(ma_slxyburden),
  .mb_slxqdready(mb_slxqdready),
  .mb_slxqvalid(mb_slxqvalid),
  .mb_slxqlast(mb_slxqlast),
  .mb_slxqwrite(mb_slxqwrite),
  .mb_slxqlen(mb_slxqlen),
  .mb_slxqsize(mb_slxqsize),
  .mb_slxqburst(mb_slxqburst),
  .mb_slxqwstrb(mb_slxqwstrb),
  .mb_slxqwdata(mb_slxqwdata),
  .mb_slxqaddr(mb_slxqaddr),
  .mb_slxqburden(mb_slxqburden),
  .mb_slxydready(mb_slxydready),
  .mb_slxyvalid(mb_slxyvalid),
  .mb_slxylast(mb_slxylast),
  .mb_slxywreply(mb_slxywreply),
  .mb_slxyresp(mb_slxyresp),
  .mb_slxyrdata(mb_slxyrdata),
  .mb_slxyburden(mb_slxyburden),
  .mc_slxqdready(mc_slxqdready),
  .mc_slxqvalid(mc_slxqvalid),
  .mc_slxqlast(mc_slxqlast),
  .mc_slxqwrite(mc_slxqwrite),
  .mc_slxqlen(mc_slxqlen),
  .mc_slxqsize(mc_slxqsize),
  .mc_slxqburst(mc_slxqburst),
  .mc_slxqwstrb(mc_slxqwstrb),
  .mc_slxqwdata(mc_slxqwdata),
  .mc_slxqaddr(mc_slxqaddr),
  .mc_slxqburden(mc_slxqburden),
  .mc_slxydready(mc_slxydready),
  .mc_slxyvalid(mc_slxyvalid),
  .mc_slxylast(mc_slxylast),
  .mc_slxywreply(mc_slxywreply),
  .mc_slxyresp(mc_slxyresp),
  .mc_slxyrdata(mc_slxyrdata),
  .mc_slxyburden(mc_slxyburden),
  .control_rmx_core_config(dca_signal_16),
  .control_rmx_core_status(dca_signal_10),
  .control_rmx_core_log_wready(dca_signal_07),
  .control_rmx_core_log_wrequest(dca_signal_00),
  .control_rmx_core_log_wdata(dca_signal_13),
  .control_rmx_inst_fifo_rready(dca_signal_05),
  .control_rmx_inst_fifo_rdata(dca_signal_15),
  .control_rmx_inst_fifo_rrequest(dca_signal_03),
  .control_rmx_operation_finish(dca_signal_08),
  .control_rmx_input_fifo_rready(dca_signal_12),
  .control_rmx_input_fifo_rdata(dca_signal_06),
  .control_rmx_input_fifo_rrequest(dca_signal_11),
  .control_rmx_output_fifo_wready(dca_signal_14),
  .control_rmx_output_fifo_wrequest(dca_signal_02),
  .control_rmx_output_fifo_wdata(dca_signal_04)
);

endmodule
