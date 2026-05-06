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
`include "ervp_axi_define.vh"



module DCA_MATRIX_MREG2STORE
(
  clk,
  rstnn,
  clear,
  enable,
  busy,

  storereg_wready,
  storereg_wrequest,

  mreg_move_renable,
  mreg_move_rdata_list1d,

  store_tensor_row_rvalid,
  store_tensor_row_rlast,
  store_tensor_row_rready,
  store_tensor_row_rdata
);



parameter MATRIX_SIZE_PARA = 4;
parameter BW_TENSOR_SCALAR = 32;

`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"
`include "dca_tensor_dim_lpara.vb"

input wire clk;
input wire rstnn;
input wire clear;
input wire enable;
output wire busy;

localparam  DCA_LPARA_1 = BW_TENSOR_ROW;

output wire storereg_wready;
input wire storereg_wrequest;

output wire mreg_move_renable;
input wire [DCA_LPARA_1-1:0] mreg_move_rdata_list1d;

input wire store_tensor_row_rvalid;
input wire store_tensor_row_rlast;
output wire store_tensor_row_rready;
output wire [BW_TENSOR_ROW-1:0] store_tensor_row_rdata;

wire dca_signal_8;
wire dca_signal_3;
wire dca_signal_6;

localparam  DCA_LPARA_3 = MATRIX_NUM_ROW;

wire dca_signal_2;
wire dca_signal_5;
wire [DCA_LPARA_3-1:0] dca_signal_0;
wire dca_signal_1;
wire dca_signal_7;

localparam  DCA_LPARA_5 = 2;
localparam  DCA_LPARA_2 = 0;
localparam  DCA_LPARA_0 = 1;
localparam  DCA_LPARA_4 = 2;

reg [DCA_LPARA_5-1:0] dca_signal_4;

assign dca_signal_8 = store_tensor_row_rready & store_tensor_row_rvalid;
assign dca_signal_3 = dca_signal_8 | (dca_signal_4==DCA_LPARA_4);
assign dca_signal_6 = dca_signal_3 & dca_signal_7;

ERVP_COUNTER_WITH_ONEHOT_ENCODING
#(
  .COUNT_LENGTH(DCA_LPARA_3)
)
i_dca_instance_0
(
  .clk(clk),
  .rstnn(rstnn),
  .enable(enable),
  .init(dca_signal_2),
  .count(dca_signal_5),
  .value(dca_signal_0),
  .is_first_count(dca_signal_1),
  .is_last_count(dca_signal_7)
);

assign dca_signal_2 = clear | dca_signal_6;
assign dca_signal_5 = dca_signal_3;

always@(posedge clk, negedge rstnn)
begin
  if(rstnn==0)
    dca_signal_4 <= DCA_LPARA_2;
  else if(clear)
    dca_signal_4 <= DCA_LPARA_2;
  else if(enable)
  begin
    case(dca_signal_4)
      DCA_LPARA_2:
        if(storereg_wrequest)
          dca_signal_4 <= DCA_LPARA_0;
      DCA_LPARA_0:
        if(dca_signal_8 & store_tensor_row_rlast)
        begin
          if(dca_signal_7)
            dca_signal_4 <= DCA_LPARA_2;
          else
            dca_signal_4 <= DCA_LPARA_4;
        end
      DCA_LPARA_4:
        if(dca_signal_6)
          dca_signal_4 <= DCA_LPARA_2;
    endcase
  end
end

assign mreg_move_renable = dca_signal_3;

assign store_tensor_row_rready = (dca_signal_4==DCA_LPARA_0);
assign store_tensor_row_rdata = mreg_move_rdata_list1d;

assign storereg_wready = (dca_signal_4==DCA_LPARA_2);
assign busy = (dca_signal_4!=DCA_LPARA_2);

endmodule
