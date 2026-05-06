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




module DCA_MODULE_31
(
  dca_port_07,
  dca_port_22,
  dca_port_10,
  dca_port_21,
  dca_port_13,

  dca_port_15,
  dca_port_16,
  dca_port_11,

  dca_port_12,
  dca_port_04,
  dca_port_09,

  dca_port_19,
  dca_port_06,
  dca_port_02,
  dca_port_01,
  dca_port_00,
  dca_port_14,
  dca_port_17,
  dca_port_18,
  dca_port_03,
  dca_port_08,
  dca_port_05,
  dca_port_20
);




parameter MATRIX_SIZE_PARA = 8;

`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"
`include "dca_include_3.vh"

input wire dca_port_07;
input wire dca_port_22;
input wire dca_port_10;
input wire dca_port_21;
output wire dca_port_13;

localparam  DCA_LPARA_2 = `BW_DCA_MATRIX_MAC_INST;

input wire dca_port_15;
input wire [DCA_LPARA_2-1:0] dca_port_16;
output wire dca_port_11;
input wire dca_port_12;
input wire dca_port_04;
input wire dca_port_09;

input wire dca_port_19;
output wire dca_port_06;
output reg [BW_BLOCKED_STEP_INST-1:0] dca_port_02;

input wire dca_port_01;
output wire dca_port_00;
output wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_port_14;

input wire dca_port_17;
output wire dca_port_18;
output wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_port_03;

input wire dca_port_08;
output wire dca_port_05;
output wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_port_20;

wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_11;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_60;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_21;
wire [`BW_DCA_MATRIX_MAC_OPCODE-1:0] dca_signal_59;

wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_02;
wire dca_signal_19;
wire dca_signal_28;
wire dca_signal_08;
reg dca_signal_67;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_47;
wire dca_signal_27;
wire dca_signal_52;
wire dca_signal_42;
wire dca_signal_20;
wire dca_signal_40;
wire dca_signal_46;

wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_01;
wire dca_signal_05;
wire dca_signal_71;
wire dca_signal_18;
reg dca_signal_62;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_30;
wire dca_signal_32;
wire dca_signal_04;
wire dca_signal_37;
wire dca_signal_50;
wire dca_signal_65;
wire dca_signal_00;

wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_33;
wire dca_signal_38;
wire dca_signal_41;
wire dca_signal_09;
reg dca_signal_31;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_51;
wire dca_signal_48;
wire dca_signal_29;
wire dca_signal_70;
wire dca_signal_35;
wire dca_signal_69;
wire dca_signal_34;

wire [`BW_DCA_MATRIX_LSU_INST_OPCODE-1:0] dca_signal_24;
wire [`BW_DCA_MATRIX_LSU_INST_OPCODE-1:0] dca_signal_13;
wire [`BW_DCA_MATRIX_LSU_INST_OPCODE-1:0] dca_signal_43;

localparam  DCA_LPARA_3 = 1;
localparam  DCA_LPARA_4 = 0;
localparam  DCA_LPARA_1 = 1;

reg [DCA_LPARA_3-1:0] dca_signal_44;
wire dca_signal_63;
wire dca_signal_26;
wire dca_signal_15;
wire dca_signal_07;

reg dca_signal_54;

localparam  DCA_LPARA_0 = 3;

reg [DCA_LPARA_0-1:0] dca_signal_66;
wire dca_signal_12;
wire dca_signal_64;

wire dca_signal_03;
wire dca_signal_57;
wire dca_signal_25;
wire dca_signal_14;
wire dca_signal_06;
wire dca_signal_53;

wire dca_signal_68;
wire dca_signal_10;
wire dca_signal_39;
wire dca_signal_45;
wire dca_signal_23;
wire dca_signal_49;
wire dca_signal_36;
wire dca_signal_55;
wire dca_signal_56;
wire dca_signal_58;

wire [MATRIX_NUM_ROW-1:0] dca_signal_61;
wire [MATRIX_NUM_COL-1:0] dca_signal_22;
wire [MATRIX_MAX_DIM-1:0] dca_signal_17;

wire [MATRIX_NUM_ROW-1:0] dca_signal_16;

assign {dca_signal_59,dca_signal_21,dca_signal_60,dca_signal_11} = dca_port_16;

assign dca_signal_68 = dca_signal_59[`DCA_MATRIX_MAC_OPCODE_INDEX_MULT_COND];
assign dca_signal_10 = 0;
assign dca_signal_39 = dca_signal_68 & dca_signal_27;
assign dca_signal_45 = dca_signal_68 & dca_signal_52;
assign dca_signal_23 = dca_signal_10;
assign dca_signal_49 = dca_signal_10;

assign dca_signal_36 = dca_signal_39 | dca_signal_23;
assign dca_signal_55 = dca_signal_45 | dca_signal_49;

assign dca_signal_56 = dca_signal_40 & dca_signal_69;
assign dca_signal_58 = dca_signal_46 & dca_signal_34;

DCA_MATRIX_SPLITER
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_0
(
  .clk(dca_port_07),
  .rstnn(dca_port_22),
  .clear(dca_port_10),
  .enable(dca_port_21),

  .matrix_info(dca_signal_02),
  .init(dca_signal_19),
  .is_col_first(dca_signal_28),
  .iterate(dca_signal_08),
  .go_next_base(dca_signal_67),

  .block_info(dca_signal_47),
  .is_first_x(dca_signal_27),
  .is_last_x(dca_signal_52),
  .is_first_y(dca_signal_42),
  .is_last_y(dca_signal_20),
  .is_first_element(dca_signal_40),
  .is_last_element(dca_signal_46),
  .valid_row_list(),
  .valid_col_list()
);

assign dca_signal_02 = dca_signal_11;
assign dca_signal_19 = dca_signal_63;
assign dca_signal_28 = 1;
assign dca_signal_08 = dca_signal_07 & dca_signal_57;

DCA_MATRIX_SPLITER
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_2
(
  .clk(dca_port_07),
  .rstnn(dca_port_22),
  .clear(dca_port_10),
  .enable(dca_port_21),

  .matrix_info(dca_signal_01),
  .init(dca_signal_05),
  .is_col_first(dca_signal_71),
  .iterate(dca_signal_18),
  .go_next_base(dca_signal_62),

  .block_info(dca_signal_30),
  .is_first_x(dca_signal_32),
  .is_last_x(dca_signal_04),
  .is_first_y(dca_signal_37),
  .is_last_y(dca_signal_50),
  .is_first_element(dca_signal_65),
  .is_last_element(dca_signal_00),
  .valid_row_list(dca_signal_16),
  .valid_col_list()
);

assign dca_signal_01 = dca_signal_60;
assign dca_signal_05 = dca_signal_63;
assign dca_signal_71 = ~dca_signal_68;
assign dca_signal_18 = dca_signal_07 & dca_signal_25;

DCA_MATRIX_SPLITER
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_1
(
  .clk(dca_port_07),
  .rstnn(dca_port_22),
  .clear(dca_port_10),
  .enable(dca_port_21),

  .matrix_info(dca_signal_33),
  .init(dca_signal_38),
  .is_col_first(dca_signal_41),
  .iterate(dca_signal_09),
  .go_next_base(dca_signal_31),

  .block_info(dca_signal_51),
  .is_first_x(dca_signal_48),
  .is_last_x(dca_signal_29),
  .is_first_y(dca_signal_70),
  .is_last_y(dca_signal_35),
  .is_first_element(dca_signal_69),
  .is_last_element(dca_signal_34),
  .valid_row_list(dca_signal_61),
  .valid_col_list(dca_signal_22)
);

assign dca_signal_33 = dca_signal_21;
assign dca_signal_38 = dca_signal_63;
assign dca_signal_41 = 1;
assign dca_signal_09 = dca_signal_07 & dca_signal_14;

always@(*)
begin
  dca_signal_67 = 0;
  dca_signal_62 = 0;
  dca_signal_31 = 0;
  if(dca_signal_07 && dca_signal_26)
  begin
    if(dca_signal_68)
    begin
      dca_signal_67 = dca_signal_45 & dca_signal_29;
      dca_signal_62 = dca_signal_04;
      dca_signal_31 = dca_signal_45 & dca_signal_29;
    end
    else
    begin
      dca_signal_67 = dca_signal_52;
      dca_signal_62 = dca_signal_04;
      dca_signal_31 = dca_signal_29;
    end
  end
end

assign dca_signal_03 = dca_signal_59[`DCA_MATRIX_MAC_OPCODE_INDEX_INIT_ACC] & dca_signal_36;
assign dca_signal_57 = (~dca_signal_06) & dca_signal_59[`DCA_MATRIX_MAC_OPCODE_INDEX_LSU0_REQ];
assign dca_signal_25 = (~dca_signal_06) & dca_signal_59[`DCA_MATRIX_MAC_OPCODE_INDEX_LSU1_REQ] & (dca_signal_59[`DCA_MATRIX_MAC_OPCODE_INDEX_RSRC_CONSTANT]? dca_signal_56 : 1);
assign dca_signal_14 = dca_signal_59[`DCA_MATRIX_MAC_OPCODE_INDEX_LSU2_REQ] & (~dca_signal_06) & (dca_signal_68? dca_signal_45 : 1);
assign dca_signal_06 = dca_signal_59[`DCA_MATRIX_MAC_OPCODE_INDEX_LOAD_ACC] & (~dca_signal_54);
assign dca_signal_53 = dca_signal_14 | dca_signal_06;

always@(posedge dca_port_07, negedge dca_port_22)
begin
  if(dca_port_22==0)
    dca_signal_44 <= DCA_LPARA_4;
  else if(dca_port_21)
    case(dca_signal_44)
      DCA_LPARA_4:
        if(dca_signal_63)
          dca_signal_44 <= DCA_LPARA_1;
      DCA_LPARA_1:
        if(dca_signal_15)
          dca_signal_44 <= DCA_LPARA_4;
    endcase
end

assign dca_signal_63 = (dca_signal_44==DCA_LPARA_4) & dca_port_15;
assign dca_signal_07 = dca_port_19 & dca_port_06;
assign dca_signal_26 = dca_signal_59[`DCA_MATRIX_MAC_OPCODE_INDEX_LOAD_ACC]? dca_signal_54 : 1;
assign dca_signal_15 = dca_signal_07 & dca_signal_58 & dca_signal_26;

always@(posedge dca_port_07, negedge dca_port_22)
begin
  if(dca_port_22==0)
    dca_signal_54 <= 0;
  else if(dca_signal_07)
  begin
    if(dca_signal_54 && dca_signal_55)
      dca_signal_54 <= 0;
    else if(dca_signal_06)
      dca_signal_54 <= 1;
  end
end

always@(posedge dca_port_07, negedge dca_port_22)
begin
  if(dca_port_22==0)
    dca_signal_66 <= 1;
  else if(dca_signal_64)
  begin
    if(dca_signal_07 & dca_signal_12)
      ;
    else
      dca_signal_66 <= dca_signal_66>>1;
  end
  else if(dca_signal_07 & dca_signal_12)
    dca_signal_66 <= dca_signal_66<<1;
end

assign dca_signal_12 = dca_signal_57 | dca_signal_25 | dca_signal_06;
assign dca_signal_64 = dca_port_12 | dca_port_04 | dca_port_09;

assign dca_port_11 = dca_signal_15;

assign dca_port_06 = (dca_signal_44==DCA_LPARA_1) & dca_port_19 & (dca_signal_57? dca_port_01 : 1) & (dca_signal_25? dca_port_17 : 1) & (dca_signal_53? dca_port_08 : 1) & ((dca_signal_12)? (~dca_signal_66[DCA_LPARA_0-1]) : 1);

assign dca_signal_17 = dca_signal_16;

always@(*)
begin
  dca_port_02 = {dca_signal_17, dca_signal_61, dca_signal_22, dca_signal_58, dca_signal_59};
  if(dca_signal_06)
    dca_port_02[`BW_DCA_MATRIX_MAC_OPCODE-1:0] = `DCA_MATRIX_MAC_OPCODE_NO_CAL;
  dca_port_02[`DCA_MATRIX_MAC_OPCODE_INDEX_INIT_ACC] = dca_signal_03;
  dca_port_02[`DCA_MATRIX_MAC_OPCODE_INDEX_LSU0_REQ] = dca_signal_57;
  dca_port_02[`DCA_MATRIX_MAC_OPCODE_INDEX_LSU1_REQ] = dca_signal_25;
  dca_port_02[`DCA_MATRIX_MAC_OPCODE_INDEX_LSU2_REQ] = dca_signal_14;
  dca_port_02[`DCA_MATRIX_MAC_OPCODE_INDEX_LOAD_ACC] = dca_signal_06;
end

assign dca_port_00 = dca_port_06 & dca_signal_57;
assign dca_port_18 = dca_port_06 & dca_signal_25;
assign dca_port_05 = dca_port_06 & dca_signal_53;

assign dca_signal_24 = `DCA_MATRIX_LSU_INST_OPCODE_READ;
assign dca_signal_13 = `DCA_MATRIX_LSU_INST_OPCODE_READ;
assign dca_signal_43 = dca_signal_06? `DCA_MATRIX_LSU_INST_OPCODE_READ : `DCA_MATRIX_LSU_INST_OPCODE_WRITE;

assign dca_port_14 = {dca_signal_47, dca_signal_24};
assign dca_port_03 = {dca_signal_30, dca_signal_13};
assign dca_port_20 = {dca_signal_51, dca_signal_43};

assign dca_port_13 = (dca_signal_44==DCA_LPARA_1);

endmodule
