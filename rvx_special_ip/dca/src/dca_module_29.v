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

`include "dca_matrix_info.vh"
`include "dca_matrix_lsu_inst.vh"
`include "dca_module_memorymap_offset.vh"




module DCA_MODULE_29
(
  dca_port_17,
  dca_port_07,
  dca_port_05,
  dca_port_12,
  dca_port_03,

  dca_port_08,
  dca_port_11,
  dca_port_14,
  dca_port_10,

  dca_port_06,
  dca_port_02,
  dca_port_13,
  dca_port_00,
  dca_port_09,
  dca_port_01,
  dca_port_04,
  dca_port_16,
  dca_port_15
);




parameter MATRIX_SIZE_PARA = 8;

`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"
`include "dca_include_0.vh"

input wire dca_port_17;
input wire dca_port_07;
input wire dca_port_05;
input wire dca_port_12;
output wire dca_port_03;

localparam  DCA_LPARA_3 = `BW_DCA_MRU_INST;

input wire dca_port_08;
input wire [DCA_LPARA_3-1:0] dca_port_11;
output wire dca_port_14;
input wire dca_port_10;

input wire dca_port_06;
output wire dca_port_02;
output wire [BW_BLOCKED_STEP_INST-1:0] dca_port_13;

input wire dca_port_00;
output wire dca_port_09;
output wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_port_01;

input wire dca_port_04;
output wire dca_port_16;
output wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_port_15;

wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_23;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_31;
wire [`BW_DCA_MRU_OPCODE-1:0] dca_signal_15;

wire dca_signal_11;
wire dca_signal_39;
wire dca_signal_00;

wire dca_signal_40;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_01;
wire dca_signal_13;
wire dca_signal_16;
wire dca_signal_41;
wire dca_signal_17;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_03;
wire dca_signal_12;
wire dca_signal_33;
wire dca_signal_29;
wire dca_signal_07;
wire dca_signal_24;
wire dca_signal_22;

wire dca_signal_28;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_14;
wire dca_signal_05;
wire dca_signal_04;
wire dca_signal_32;
wire dca_signal_26;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_08;
wire dca_signal_25;
wire dca_signal_10;
wire dca_signal_36;
wire dca_signal_30;
wire dca_signal_34;
wire dca_signal_02;

wire dca_signal_37;

wire [`BW_DCA_MATRIX_LSU_INST_OPCODE-1:0] dca_signal_18;
wire [`BW_DCA_MATRIX_LSU_INST_OPCODE-1:0] dca_signal_35;

localparam  DCA_LPARA_2 = 1;
localparam  DCA_LPARA_0 = 0;
localparam  DCA_LPARA_1 = 1;

reg [DCA_LPARA_2-1:0] dca_signal_06;
wire dca_signal_19;
wire dca_signal_09;
wire dca_signal_27;

localparam  DCA_LPARA_4 = 3;

reg [DCA_LPARA_4-1:0] dca_signal_38;
wire dca_signal_20;
wire dca_signal_21;

assign {dca_signal_15, dca_signal_31, dca_signal_23} = dca_port_11;

assign dca_signal_11 = dca_signal_15[`DCA_MRU_OPCODE_INDEX_TRANSPOSE];
assign dca_signal_39 = dca_signal_15[`DCA_MRU_OPCODE_INDEX_LSU0_REQ];
assign dca_signal_00 = 1;

DCA_MATRIX_SPLITER
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_0
(
  .clk(dca_port_17),
  .rstnn(dca_port_07),
  .clear(dca_port_05),
  .enable(dca_signal_40),

  .matrix_info(dca_signal_01),
  .init(dca_signal_13),
  .is_col_first(dca_signal_16),
  .iterate(dca_signal_41),
  .go_next_base(dca_signal_17),

  .block_info(dca_signal_03),
  .is_first_x(dca_signal_12),
  .is_last_x(dca_signal_33),
  .is_first_y(dca_signal_29),
  .is_last_y(dca_signal_07),
  .is_first_element(dca_signal_24),
  .is_last_element(dca_signal_22),
  .valid_row_list(),
  .valid_col_list()
);

assign dca_signal_40 = dca_port_12 & dca_signal_39;
assign dca_signal_01 = dca_signal_23;
assign dca_signal_13 = dca_signal_19;
assign dca_signal_16 = 1;
assign dca_signal_41 = dca_signal_27;
assign dca_signal_17 = dca_signal_27 & dca_signal_33;

DCA_MATRIX_SPLITER
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_1
(
  .clk(dca_port_17),
  .rstnn(dca_port_07),
  .clear(dca_port_05),
  .enable(dca_signal_28),

  .matrix_info(dca_signal_14),
  .init(dca_signal_05),
  .is_col_first(dca_signal_04),
  .iterate(dca_signal_32),
  .go_next_base(dca_signal_26),

  .block_info(dca_signal_08),
  .is_first_x(dca_signal_25),
  .is_last_x(dca_signal_10),
  .is_first_y(dca_signal_36),
  .is_last_y(dca_signal_30),
  .is_first_element(dca_signal_34),
  .is_last_element(dca_signal_02),
  .valid_row_list(),
  .valid_col_list()
);

assign dca_signal_28 = dca_port_12 & dca_signal_00;
assign dca_signal_14 = dca_signal_31;
assign dca_signal_05 = dca_signal_19;
assign dca_signal_04 = ~dca_signal_11;
assign dca_signal_32 = dca_signal_27;
assign dca_signal_26 = dca_signal_27 & dca_signal_10;

assign dca_signal_37 = dca_signal_02;

always@(posedge dca_port_17, negedge dca_port_07)
begin
  if(dca_port_07==0)
    dca_signal_06 <= DCA_LPARA_0;
  else if(dca_port_12)
    case(dca_signal_06)
      DCA_LPARA_0:
        if(dca_signal_19)
          dca_signal_06 <= DCA_LPARA_1;
      DCA_LPARA_1:
        if(dca_signal_09)
          dca_signal_06 <= DCA_LPARA_0;
    endcase
end
assign dca_signal_19 = (dca_signal_06==DCA_LPARA_0) & dca_port_08;
assign dca_signal_09 = dca_signal_27 & dca_signal_37;

always@(posedge dca_port_17, negedge dca_port_07)
begin
  if(dca_port_07==0)
    dca_signal_38 <= 1;
  else if(dca_signal_21)
  begin
    if(dca_signal_27 & dca_signal_20)
      ;
    else
      dca_signal_38 <= dca_signal_38>>1;
  end
  else if(dca_signal_27 & dca_signal_20)
    dca_signal_38 <= dca_signal_38<<1;
end
assign dca_signal_20 = dca_signal_39;
assign dca_signal_21 = dca_port_10;
assign dca_port_14 = dca_signal_09;

assign dca_signal_27 = dca_port_06 & dca_port_02;
assign dca_port_02 = (dca_signal_06==DCA_LPARA_1) & dca_port_06 & (dca_signal_39? dca_port_00 : 1) & (dca_signal_00? dca_port_04 : 1) & ((dca_signal_20)? (~dca_signal_38[DCA_LPARA_4-1]) : 1);
assign dca_port_13 = {dca_signal_37, dca_signal_15};

assign dca_port_09 = dca_port_02 & dca_signal_39;
assign dca_port_16 = dca_port_02 & dca_signal_00;
assign dca_signal_18 = `DCA_MATRIX_LSU_INST_OPCODE_READ;
assign dca_signal_35 = `DCA_MATRIX_LSU_INST_OPCODE_WRITE;
assign dca_port_01 = {dca_signal_03, dca_signal_18};
assign dca_port_15 = {dca_signal_08, dca_signal_35};

assign dca_port_03 = (dca_signal_06==DCA_LPARA_1);

endmodule
