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
`include "dca_include_1.vh"




module DCA_MODULE_04
(
  dca_port_00,
  dca_port_04,
  dca_port_13,
  dca_port_15,
  dca_port_12,

  dca_port_10,
  dca_port_17,
  dca_port_21,

  dca_port_06,
  dca_port_18,
  dca_port_01,

  dca_port_20,
  dca_port_07,
  dca_port_08,
  dca_port_22,
  dca_port_14,
  dca_port_05,
  dca_port_19,
  dca_port_09,
  dca_port_02,
  dca_port_11,
  dca_port_16,
  dca_port_03
);




parameter MATRIX_SIZE_PARA = 8;

`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"
`include "dca_include_2.vh"

input wire dca_port_00;
input wire dca_port_04;
input wire dca_port_13;
input wire dca_port_15;
output wire dca_port_12;

localparam  DCA_LPARA_3 = `DCA_GDEF_24;

input wire dca_port_10;
input wire [DCA_LPARA_3-1:0] dca_port_17;
output wire dca_port_21;
input wire dca_port_06;
input wire dca_port_18;
input wire dca_port_01;

input wire dca_port_20;
output wire dca_port_07;
output reg [BW_BLOCKED_STEP_INST-1:0] dca_port_08;

input wire dca_port_22;
output wire dca_port_14;
output wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_port_05;

input wire dca_port_19;
output wire dca_port_09;
output wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_port_02;

input wire dca_port_11;
output wire dca_port_16;
output wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_port_03;

wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_52;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_41;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_02;
wire [`DCA_GDEF_44-1:0] dca_signal_39;
wire [`DCA_GDEF_15-1:0] dca_signal_26;

wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_38;
wire dca_signal_36;
wire dca_signal_22;
wire dca_signal_33;
reg dca_signal_59;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_67;
wire dca_signal_21;
wire dca_signal_11;
wire dca_signal_61;
wire dca_signal_00;
wire dca_signal_29;
wire dca_signal_57;

wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_50;
wire dca_signal_08;
wire dca_signal_12;
wire dca_signal_37;
reg dca_signal_14;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_42;
wire dca_signal_06;
wire dca_signal_16;
wire dca_signal_49;
wire dca_signal_58;
wire dca_signal_45;
wire dca_signal_54;

wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_71;
wire dca_signal_10;
wire dca_signal_72;
wire dca_signal_34;
reg dca_signal_07;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_56;
wire dca_signal_25;
wire dca_signal_19;
wire dca_signal_17;
wire dca_signal_68;
wire dca_signal_64;
wire dca_signal_04;

wire [`BW_DCA_MATRIX_LSU_INST_OPCODE-1:0] dca_signal_69;
wire [`BW_DCA_MATRIX_LSU_INST_OPCODE-1:0] dca_signal_28;
wire [`BW_DCA_MATRIX_LSU_INST_OPCODE-1:0] dca_signal_40;

localparam  DCA_LPARA_0 = 1;
localparam  DCA_LPARA_1 = 0;
localparam  DCA_LPARA_2 = 1;

reg [DCA_LPARA_0-1:0] dca_signal_23;
wire dca_signal_62;
wire dca_signal_47;
wire dca_signal_73;
wire dca_signal_09;

reg dca_signal_65;

wire dca_signal_24;
wire dca_signal_35;
wire dca_signal_43;
wire dca_signal_70;
wire dca_signal_13;
wire dca_signal_01;

wire dca_signal_66;
wire dca_signal_53;
wire dca_signal_05;
wire dca_signal_46;
wire dca_signal_03;
wire dca_signal_63;
wire dca_signal_44;
wire dca_signal_15;
wire dca_signal_55;
wire dca_signal_20;

wire [MATRIX_MAX_DIM-1:0] dca_signal_51;
wire dca_signal_60;
wire dca_signal_18;
wire dca_signal_32;
wire [MATRIX_NUM_ROW-1:0] dca_signal_30;
wire [MATRIX_NUM_COL-1:0] dca_signal_48;
wire [MATRIX_MAX_DIM-1:0] dca_signal_27;

wire [MATRIX_NUM_ROW-1:0] dca_signal_31;

assign {dca_signal_26,dca_signal_39,dca_signal_02,dca_signal_41,dca_signal_52} = dca_port_17;
assign dca_signal_51 = {dca_signal_39, dca_signal_39};
assign dca_signal_60 = 0;
assign dca_signal_18 = 0;
assign dca_signal_32 = 0;

assign dca_signal_66 = dca_signal_26[`DCA_GDEF_31];
assign dca_signal_53 = dca_signal_26[`DCA_GDEF_00];
assign dca_signal_05 = dca_signal_66 & dca_signal_21;
assign dca_signal_46 = dca_signal_66 & dca_signal_11;
assign dca_signal_03 = dca_signal_53;
assign dca_signal_63 = dca_signal_53;

assign dca_signal_44 = dca_signal_05 | dca_signal_03;
assign dca_signal_15 = dca_signal_46 | dca_signal_63;

assign dca_signal_55 = dca_signal_29 & dca_signal_64;
assign dca_signal_20 = dca_signal_57 & dca_signal_04;

DCA_MATRIX_SPLITER
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_1
(
  .clk(dca_port_00),
  .rstnn(dca_port_04),
  .clear(dca_port_13),
  .enable(dca_port_15),

  .matrix_info(dca_signal_38),
  .init(dca_signal_36),
  .is_col_first(dca_signal_22),
  .iterate(dca_signal_33),
  .go_next_base(dca_signal_59),

  .block_info(dca_signal_67),
  .is_first_x(dca_signal_21),
  .is_last_x(dca_signal_11),
  .is_first_y(dca_signal_61),
  .is_last_y(dca_signal_00),
  .is_first_element(dca_signal_29),
  .is_last_element(dca_signal_57),
  .valid_row_list(),
  .valid_col_list()
);

assign dca_signal_38 = dca_signal_52;
assign dca_signal_36 = dca_signal_62;
assign dca_signal_22 = 1;
assign dca_signal_33 = dca_signal_09 & dca_signal_35;

DCA_MATRIX_SPLITER
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_2
(
  .clk(dca_port_00),
  .rstnn(dca_port_04),
  .clear(dca_port_13),
  .enable(dca_port_15),

  .matrix_info(dca_signal_50),
  .init(dca_signal_08),
  .is_col_first(dca_signal_12),
  .iterate(dca_signal_37),
  .go_next_base(dca_signal_14),

  .block_info(dca_signal_42),
  .is_first_x(dca_signal_06),
  .is_last_x(dca_signal_16),
  .is_first_y(dca_signal_49),
  .is_last_y(dca_signal_58),
  .is_first_element(dca_signal_45),
  .is_last_element(dca_signal_54),
  .valid_row_list(dca_signal_31),
  .valid_col_list()
);

assign dca_signal_50 = dca_signal_41;
assign dca_signal_08 = dca_signal_62;
assign dca_signal_12 = ~dca_signal_66;
assign dca_signal_37 = dca_signal_09 & dca_signal_43;

DCA_MATRIX_SPLITER
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_0
(
  .clk(dca_port_00),
  .rstnn(dca_port_04),
  .clear(dca_port_13),
  .enable(dca_port_15),

  .matrix_info(dca_signal_71),
  .init(dca_signal_10),
  .is_col_first(dca_signal_72),
  .iterate(dca_signal_34),
  .go_next_base(dca_signal_07),

  .block_info(dca_signal_56),
  .is_first_x(dca_signal_25),
  .is_last_x(dca_signal_19),
  .is_first_y(dca_signal_17),
  .is_last_y(dca_signal_68),
  .is_first_element(dca_signal_64),
  .is_last_element(dca_signal_04),
  .valid_row_list(dca_signal_30),
  .valid_col_list(dca_signal_48)
);

assign dca_signal_71 = dca_signal_02;
assign dca_signal_10 = dca_signal_62;
assign dca_signal_72 = 1;
assign dca_signal_34 = dca_signal_09 & dca_signal_70;

always@(*)
begin
  dca_signal_59 = 0;
  dca_signal_14 = 0;
  dca_signal_07 = 0;
  if(dca_signal_09 && dca_signal_47)
  begin
    if(dca_signal_66)
    begin
      dca_signal_59 = dca_signal_46 & dca_signal_19;
      dca_signal_14 = dca_signal_16;
      dca_signal_07 = dca_signal_46 & dca_signal_19;
    end
    else
    begin
      dca_signal_59 = dca_signal_11;
      dca_signal_14 = dca_signal_16;
      dca_signal_07 = dca_signal_19;
    end
  end
end

assign dca_signal_24 = dca_signal_26[`DCA_GDEF_22] & dca_signal_44;
assign dca_signal_35 = (~dca_signal_13) & dca_signal_26[`DCA_GDEF_27];
assign dca_signal_43 = (~dca_signal_13) & dca_signal_26[`DCA_GDEF_55] & (dca_signal_26[`DCA_GDEF_58]? dca_signal_55 : 1);
assign dca_signal_70 = dca_signal_26[`DCA_GDEF_43] & (~dca_signal_13) & (dca_signal_66? dca_signal_46 : 1);
assign dca_signal_13 = dca_signal_26[`DCA_GDEF_06] & (~dca_signal_65);
assign dca_signal_01 = dca_signal_70 | dca_signal_13;

always@(posedge dca_port_00, negedge dca_port_04)
begin
  if(dca_port_04==0)
    dca_signal_23 <= DCA_LPARA_1;
  else if(dca_port_15)
    case(dca_signal_23)
      DCA_LPARA_1:
        if(dca_signal_62)
          dca_signal_23 <= DCA_LPARA_2;
      DCA_LPARA_2:
        if(dca_signal_73)
          dca_signal_23 <= DCA_LPARA_1;
    endcase
end

assign dca_signal_62 = (dca_signal_23==DCA_LPARA_1) & dca_port_10;
assign dca_signal_09 = dca_port_20 & dca_port_07;
assign dca_signal_47 = dca_signal_26[`DCA_GDEF_06]? dca_signal_65 : 1;
assign dca_signal_73 = dca_signal_09 & dca_signal_20 & dca_signal_47;

always@(posedge dca_port_00, negedge dca_port_04)
begin
  if(dca_port_04==0)
    dca_signal_65 <= 0;
  else if(dca_signal_09)
  begin
    if(dca_signal_65 && dca_signal_15)
      dca_signal_65 <= 0;
    else if(dca_signal_13)
      dca_signal_65 <= 1;
  end
end

assign dca_port_21 = dca_signal_73;

assign dca_port_07 = (dca_signal_23==DCA_LPARA_2) & dca_port_20 & (dca_signal_35? dca_port_22 : 1) & (dca_signal_43? dca_port_19 : 1) & (dca_signal_01? dca_port_11 : 1);

assign dca_signal_27 = dca_signal_31;

always@(*)
begin
  dca_port_08 = {dca_signal_27, dca_signal_30, dca_signal_48, dca_signal_20, dca_signal_32, dca_signal_18, dca_signal_60, dca_signal_51, dca_signal_26};
  if(dca_signal_13)
    dca_port_08[`DCA_GDEF_15-1:0] = `DCA_GDEF_48;
  dca_port_08[`DCA_GDEF_22] = dca_signal_24;
  dca_port_08[`DCA_GDEF_27] = dca_signal_35;
  dca_port_08[`DCA_GDEF_55] = dca_signal_43;
  dca_port_08[`DCA_GDEF_43] = dca_signal_70;
  dca_port_08[`DCA_GDEF_06] = dca_signal_13;
end

assign dca_port_14 = dca_port_07 & dca_signal_35;
assign dca_port_09 = dca_port_07 & dca_signal_43;
assign dca_port_16 = dca_port_07 & dca_signal_01;

assign dca_signal_69 = `DCA_MATRIX_LSU_INST_OPCODE_READ;
assign dca_signal_28 = `DCA_MATRIX_LSU_INST_OPCODE_READ;
assign dca_signal_40 = dca_signal_13? `DCA_MATRIX_LSU_INST_OPCODE_READ : `DCA_MATRIX_LSU_INST_OPCODE_WRITE;

assign dca_port_05 = {dca_signal_67, dca_signal_69};
assign dca_port_02 = {dca_signal_42, dca_signal_28};
assign dca_port_03 = {dca_signal_56, dca_signal_40};

assign dca_port_12 = (dca_signal_23==DCA_LPARA_2);

endmodule
