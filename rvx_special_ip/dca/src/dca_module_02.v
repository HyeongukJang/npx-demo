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
`include "dca_include_1.vh"




module DCA_MODULE_02
(
  dca_port_22,
  dca_port_14,
  dca_port_18,
  dca_port_05,
  dca_port_09,

  dca_port_03,
  dca_port_00,
  dca_port_12,

  dca_port_21,
  dca_port_10,
  dca_port_02,

  dca_port_06,
  dca_port_15,
  dca_port_08,

  dca_port_17,
  dca_port_13,

  dca_port_07,
  dca_port_01,
  dca_port_11,
  dca_port_19,

  dca_port_04,
  dca_port_20,
  dca_port_16
);




parameter MATRIX_SIZE_PARA = 4;
parameter TENSOR_PARA = 0;

`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"
`include "dca_include_2.vh"
`include "dca_tensor_scalar_lpara.vb"
`include "dca_tensor_dim_lpara.vb"

input wire dca_port_22;
input wire dca_port_14;
input wire dca_port_18;
input wire dca_port_05;
output wire dca_port_09;

input wire dca_port_03;
input wire [BW_BLOCKED_STEP_INST-1:0] dca_port_00;
output wire dca_port_12;

input wire [BW_TENSOR_MATRIX-1:0] dca_port_21;
output wire dca_port_10;
output wire dca_port_02;

input wire [BW_TENSOR_MATRIX-1:0] dca_port_06;
output wire dca_port_15;
output wire dca_port_08;

output wire dca_port_17;
input wire [BW_TENSOR_MATRIX-1:0] dca_port_13;

input wire [BW_TENSOR_MATRIX-1:0] dca_port_07;
output wire dca_port_01;
output wire [MATRIX_NUM_ELEMENT-1:0] dca_port_11;
output reg [BW_TENSOR_MATRIX-1:0] dca_port_19;

input wire [BW_TENSOR_MATRIX-1:0] dca_port_04;
output wire [MATRIX_NUM_ELEMENT-1:0] dca_port_20;
output wire [BW_TENSOR_MATRIX-1:0] dca_port_16;

wire [`DCA_GDEF_15-1:0] dca_signal_15;
wire [MATRIX_MAX_DIM-1:0] dca_signal_80;
wire dca_signal_26;
wire dca_signal_08;
wire dca_signal_44;
wire dca_signal_77;
wire [MATRIX_NUM_COL-1:0] dca_signal_39;
wire [MATRIX_NUM_ROW-1:0] dca_signal_71;
wire [MATRIX_MAX_DIM-1:0] dca_signal_83;

wire dca_signal_30;
wire dca_signal_33;
wire dca_signal_79;
wire dca_signal_48;
wire dca_signal_21;
wire dca_signal_27;
wire dca_signal_64;
wire dca_signal_06;
wire dca_signal_52;
wire dca_signal_65;
wire dca_signal_50;

localparam  DCA_LPARA_09 = 1;
localparam  DCA_LPARA_01 = 0;
localparam  DCA_LPARA_04 = 1;

reg [DCA_LPARA_09-1:0] dca_signal_25;

genvar i;
genvar i_row, i_col;

reg dca_signal_37;
reg dca_signal_73;
reg dca_signal_20;
reg dca_signal_75;
reg dca_signal_09;
wire dca_signal_53;

localparam  DCA_LPARA_19 = 1;
localparam  DCA_LPARA_14 = 3;
localparam  DCA_LPARA_21 = 2;
localparam  DCA_LPARA_18 = 3;
localparam  DCA_LPARA_07 = 3; 

reg dca_signal_04;
wire dca_signal_46;
reg dca_signal_61;
wire [DCA_LPARA_07-1:0] dca_signal_54;

reg dca_signal_66;
reg dca_signal_68;
reg [BW_TENSOR_MATRIX-1:0] dca_signal_62;
reg [BW_TENSOR_MATRIX-1:0] dca_signal_74;
wire [BW_TENSOR_MATRIX-1:0] dca_signal_35;

reg dca_signal_18;
reg dca_signal_43;
reg [BW_TENSOR_MATRIX-1:0] dca_signal_05;
reg [BW_TENSOR_MATRIX-1:0] dca_signal_40;
wire [BW_TENSOR_MATRIX-1:0] dca_signal_31;

localparam  DCA_LPARA_12 = DCA_LPARA_21;
localparam  DCA_LPARA_22 = DCA_LPARA_19;
localparam  DCA_LPARA_15 = 1;
localparam  DCA_LPARA_05 = MATRIX_MAX_DIM;

wire dca_signal_81;
wire [DCA_LPARA_15-1:0] dca_signal_56;
wire [DCA_LPARA_05-1:0] dca_signal_69;
wire dca_signal_63;
wire dca_signal_76;
wire dca_signal_55;
wire dca_signal_34;
wire dca_signal_10;
wire dca_signal_47;
wire dca_signal_82;
wire dca_signal_84;

localparam  DCA_LPARA_08 = DCA_LPARA_18;
localparam  DCA_LPARA_00 = DCA_LPARA_14;
localparam  DCA_LPARA_13 = 1;
localparam  DCA_LPARA_10 = MATRIX_MAX_DIM;

wire dca_signal_49;
wire [DCA_LPARA_13-1:0] dca_signal_67;
wire [DCA_LPARA_10-1:0] dca_signal_00;
wire dca_signal_22;
wire dca_signal_02;
wire dca_signal_01;
wire dca_signal_78;
wire dca_signal_51;
wire dca_signal_12;
wire dca_signal_14;
wire dca_signal_59;

localparam  DCA_LPARA_06 = DCA_LPARA_21;
localparam  DCA_LPARA_02 = DCA_LPARA_19;
localparam  DCA_LPARA_23 = MATRIX_NUM_ROW;
localparam  DCA_LPARA_03 = MATRIX_NUM_COL;

wire dca_signal_32;
wire [DCA_LPARA_23-1:0] dca_signal_58;
wire [DCA_LPARA_03-1:0] dca_signal_70;
wire dca_signal_24;
wire dca_signal_13;
wire dca_signal_23;
wire dca_signal_19;
wire dca_signal_38;
wire dca_signal_11;
wire dca_signal_45;
wire dca_signal_42;

localparam  DCA_LPARA_16 = DCA_LPARA_18;
localparam  DCA_LPARA_20 = DCA_LPARA_14;
localparam  DCA_LPARA_17 = MATRIX_NUM_ROW;
localparam  DCA_LPARA_11 = MATRIX_NUM_COL;

wire dca_signal_60;
wire [DCA_LPARA_17-1:0] dca_signal_17;
wire [DCA_LPARA_11-1:0] dca_signal_41;
wire dca_signal_29;
wire dca_signal_03;
wire dca_signal_07;
wire dca_signal_57;
wire dca_signal_72;
wire dca_signal_16;
wire dca_signal_36;
wire dca_signal_28;

assign {dca_signal_83, dca_signal_71, dca_signal_39, dca_signal_77, dca_signal_44, dca_signal_08, dca_signal_26, dca_signal_80, dca_signal_15} = dca_port_00;

assign dca_signal_30 = dca_signal_15[`DCA_GDEF_02];
assign dca_signal_33 = dca_signal_15[`DCA_GDEF_10];
assign dca_signal_79 = dca_signal_15[`DCA_GDEF_40];
assign dca_signal_48 = dca_signal_15[`DCA_GDEF_31];
assign dca_signal_21 = dca_signal_15[`DCA_GDEF_00];
assign dca_signal_27 = dca_signal_15[`DCA_GDEF_22];
assign dca_signal_64 = dca_signal_15[`DCA_GDEF_50];
assign dca_signal_06 = dca_signal_15[`DCA_GDEF_27];
assign dca_signal_52 = dca_signal_15[`DCA_GDEF_55];
assign dca_signal_65 = dca_signal_15[`DCA_GDEF_43];
assign dca_signal_50 = dca_signal_15[`DCA_GDEF_58];

always@(posedge dca_port_22, negedge dca_port_14)
begin
  if(dca_port_14==0)
    dca_signal_25 <= DCA_LPARA_01;
  else if(dca_port_18)
    dca_signal_25 <= DCA_LPARA_01;
  else
    case(dca_signal_25)
      DCA_LPARA_01:
        if(dca_port_03)
          dca_signal_25 <= DCA_LPARA_04;
      DCA_LPARA_04:
        if(dca_port_12)
          dca_signal_25 <= DCA_LPARA_01;
    endcase
end

assign dca_port_01 = dca_port_03 & dca_signal_27;

assign dca_port_12 = dca_signal_37 | dca_signal_73 | dca_signal_20 | dca_signal_75 | dca_signal_09;

ERVP_COUNTER
#(
  .BW_COUNTER(DCA_LPARA_07)
)
i_dca_instance_3
(
  .clk(dca_port_22),
  .rstnn(dca_port_14),
  .enable(dca_signal_04),
  .init(dca_signal_46),
  .count(dca_signal_61),
  .value(dca_signal_54),
  .is_first_count(),
  .is_last_count()
);

assign dca_signal_46 = dca_port_12;

always@(*)
begin
  dca_signal_04 = 0;
  dca_signal_61 = 0;
  if(dca_signal_25==DCA_LPARA_04)
    if(dca_signal_30 || dca_signal_79)
    begin
      dca_signal_04 = 1;
      dca_signal_61 = 1;
    end
end

always@(*)
begin
  dca_signal_37 = 0;
  dca_signal_73 = 0;
  dca_signal_20 = 0;
  dca_signal_75 = 0;
  dca_signal_09 = 0;
  if(dca_signal_25==DCA_LPARA_04)
  begin
    if(dca_signal_30)
    begin
      if(dca_signal_64)
      begin
        if(dca_signal_54==(DCA_LPARA_14-1))
          dca_signal_37 = 1;
      end
      else
      begin
        if(dca_signal_54==(DCA_LPARA_19-1))
          dca_signal_37 = 1;
      end
    end
    else if(dca_signal_79)
    begin
      if(dca_signal_64)
      begin
        if(dca_signal_54==(DCA_LPARA_18-1))
          dca_signal_73 = 1;
      end
      else
      begin
        if(dca_signal_54==(DCA_LPARA_21-1))
          dca_signal_73 = 1;
      end
    end
    else if(dca_signal_48)
    begin
      if(dca_signal_64)
        dca_signal_20 = dca_signal_02;
      else
        dca_signal_20 = dca_signal_76;
    end
    else if(dca_signal_21)
    begin
      if(dca_signal_64)
        dca_signal_75 = dca_signal_03;
      else
        dca_signal_75 = dca_signal_13;
    end
    else
      dca_signal_09 = dca_signal_27;
  end
end

assign dca_signal_53 = dca_signal_37 | dca_signal_73;

generate
for(i=0; i<MATRIX_NUM_ELEMENT; i=i+1)
begin : i_generate_adder
  DCA_MODULE_18
  #(
    .TENSOR_PARA(TENSOR_PARA)
  )
  i_dca_instance_0
  (
    .dca_port_09(dca_port_22),
    .dca_port_00(dca_port_14),
    .dca_port_08(dca_signal_66),
    .dca_port_04(dca_signal_33),
    .dca_port_07(dca_signal_64),
    .dca_port_01(dca_signal_68),
    .dca_port_06(dca_signal_62[BW_TENSOR_SCALAR*(i+1)-1-:BW_TENSOR_SCALAR]),
    .dca_port_05(dca_signal_74[BW_TENSOR_SCALAR*(i+1)-1-:BW_TENSOR_SCALAR]),
    .dca_port_03(),
    .dca_port_02(dca_signal_35[BW_TENSOR_SCALAR*(i+1)-1-:BW_TENSOR_SCALAR])
  );
end
endgenerate

always@(*)
begin
  dca_signal_66 = 0;
  if(dca_signal_25==DCA_LPARA_04)
    if(dca_signal_30 || dca_signal_48 || dca_signal_21)
      dca_signal_66 = 1;
end

always@(*)
begin
  dca_signal_68 = 0;
  if(dca_signal_25==DCA_LPARA_04)
  begin
    if(dca_signal_30)
      dca_signal_68 = 1;
    else if(dca_signal_48)
    begin
      if(dca_signal_64)
        dca_signal_68 = dca_signal_78;
      else
        dca_signal_68 = dca_signal_34;
    end
    else if(dca_signal_21)
    begin
      if(dca_signal_64)
        dca_signal_68 = dca_signal_57;
      else
        dca_signal_68 = dca_signal_19;
    end
  end
end

always@(*)
begin
  dca_signal_62 = dca_port_21;
  dca_signal_74 = dca_port_06;
  if(dca_signal_30 || dca_signal_79)
  begin
    dca_signal_62 = dca_port_21;
    dca_signal_74 = dca_port_06;
  end
  else if(dca_signal_48 || dca_signal_21)
  begin
    dca_signal_62 = dca_port_04;
    dca_signal_74 = dca_port_07;
  end
end

generate
for(i=0; i<MATRIX_NUM_ELEMENT; i=i+1)
begin : i_generate_multiplier
  DCA_MODULE_24
  #(
    .TENSOR_PARA(TENSOR_PARA)
  )
  i_dca_instance_6
  (
    .dca_port_1(dca_port_22),
    .dca_port_4(dca_port_14),
    .dca_port_2(dca_signal_18),
    .dca_port_7(dca_signal_64),
    .dca_port_3(dca_signal_43),
    .dca_port_8(dca_signal_05[BW_TENSOR_SCALAR*(i+1)-1-:BW_TENSOR_SCALAR]),
    .dca_port_6(dca_signal_40[BW_TENSOR_SCALAR*(i+1)-1-:BW_TENSOR_SCALAR]),
    .dca_port_5(),
    .dca_port_0(dca_signal_31[BW_TENSOR_SCALAR*(i+1)-1-:BW_TENSOR_SCALAR])
  );
end
endgenerate

always@(*)
begin
  dca_signal_18 = 0;
  if(dca_signal_25==DCA_LPARA_04)
    if(dca_signal_79 || dca_signal_48 || dca_signal_21)
      dca_signal_18 = 1;
end

always@(*)
begin
  dca_signal_43 = 0;
  if(dca_signal_25==DCA_LPARA_04)
  begin
    if(dca_signal_79)
      dca_signal_43 = 1;
    else if(dca_signal_48)
    begin
      if(dca_signal_64)
        dca_signal_43 = dca_signal_01;
      else
        dca_signal_43 = dca_signal_55;
    end
    else if(dca_signal_21)
    begin
      if(dca_signal_64)
        dca_signal_43 = dca_signal_07;
      else
        dca_signal_43 = dca_signal_23;
    end
  end
end

function integer GET_MATRIX_INDEX;
  input integer row_index;
  input integer col_index;
begin
  GET_MATRIX_INDEX = (row_index*BW_TENSOR_ROW) + (col_index*BW_TENSOR_SCALAR) + BW_TENSOR_SCALAR - 1;
end
endfunction

integer n, m;

always@(*)
begin
  for(m=0; m<MATRIX_NUM_ROW; m=m+1)
  begin
    for(n=0; n<MATRIX_NUM_COL; n=n+1)
    begin
      dca_signal_05[GET_MATRIX_INDEX(m,n)-:BW_TENSOR_SCALAR] = dca_port_21[GET_MATRIX_INDEX(m,n)-:BW_TENSOR_SCALAR];
      dca_signal_40[GET_MATRIX_INDEX(m,n)-:BW_TENSOR_SCALAR] = dca_port_06[GET_MATRIX_INDEX(m,n)-:BW_TENSOR_SCALAR];
      if(dca_signal_79 || dca_signal_21)
      begin
        dca_signal_05[GET_MATRIX_INDEX(m,n)-:BW_TENSOR_SCALAR] = dca_port_21[GET_MATRIX_INDEX(m,n)-:BW_TENSOR_SCALAR];
        dca_signal_40[GET_MATRIX_INDEX(m,n)-:BW_TENSOR_SCALAR] = dca_port_06[GET_MATRIX_INDEX(m,n)-:BW_TENSOR_SCALAR];
      end
      if(dca_signal_48)
      begin
        dca_signal_05[GET_MATRIX_INDEX(m,n)-:BW_TENSOR_SCALAR] = dca_port_21[GET_MATRIX_INDEX(m,0)-:BW_TENSOR_SCALAR];
        dca_signal_40[GET_MATRIX_INDEX(m,n)-:BW_TENSOR_SCALAR] = dca_port_06[GET_MATRIX_INDEX(0,n)-:BW_TENSOR_SCALAR];
      end
      if(dca_signal_50)
        dca_signal_40[GET_MATRIX_INDEX(m,n)-:BW_TENSOR_SCALAR] = dca_port_13[GET_MATRIX_INDEX(0,n)-:BW_TENSOR_SCALAR];
    end
  end
end

DCA_MODULE_00
#(
  .DCA_GPARA_3(DCA_LPARA_12),
  .DCA_GPARA_2(DCA_LPARA_22),
  .DCA_GPARA_0(DCA_LPARA_15),
  .DCA_GPARA_1(DCA_LPARA_05)
)
i_dca_instance_2
(
  .dca_port_00(dca_port_22),
  .dca_port_02(dca_port_14),
  .dca_port_01(dca_signal_81),

  .dca_port_03(dca_signal_56),
  .dca_port_06(dca_signal_69),

  .dca_port_12(dca_signal_63),
  .dca_port_11(dca_signal_76),
  
  .dca_port_10(dca_signal_55),
  .dca_port_05(dca_signal_34),

  .dca_port_08(dca_signal_10),
  .dca_port_09(dca_signal_47),
  .dca_port_04(dca_signal_82),
  .dca_port_07(dca_signal_84)
);

assign dca_signal_81 = dca_signal_48 & (~dca_signal_64);
assign dca_signal_56 = 1;
assign dca_signal_69 = dca_signal_83;
assign dca_signal_63 = dca_port_03;

DCA_MODULE_00
#(
  .DCA_GPARA_3(DCA_LPARA_08),
  .DCA_GPARA_2(DCA_LPARA_00),
  .DCA_GPARA_0(DCA_LPARA_13),
  .DCA_GPARA_1(DCA_LPARA_10)
)
i_dca_instance_1
(
  .dca_port_00(dca_port_22),
  .dca_port_02(dca_port_14),
  .dca_port_01(dca_signal_49),

  .dca_port_03(dca_signal_67),
  .dca_port_06(dca_signal_00),

  .dca_port_12(dca_signal_22),
  .dca_port_11(dca_signal_02),
  
  .dca_port_10(dca_signal_01),
  .dca_port_05(dca_signal_78),

  .dca_port_08(dca_signal_51),
  .dca_port_09(dca_signal_12),
  .dca_port_04(dca_signal_14),
  .dca_port_07(dca_signal_59)
);

assign dca_signal_49 = 0; 
assign dca_signal_67 = 1;
assign dca_signal_00 = dca_signal_83;
assign dca_signal_22 = dca_port_03;

DCA_MODULE_00
#(
  .DCA_GPARA_3(DCA_LPARA_06),
  .DCA_GPARA_2(DCA_LPARA_02),
  .DCA_GPARA_0(DCA_LPARA_23),
  .DCA_GPARA_1(DCA_LPARA_03)
)
i_dca_instance_5
(
  .dca_port_00(dca_port_22),
  .dca_port_02(dca_port_14),
  .dca_port_01(dca_signal_32),

  .dca_port_03(dca_signal_58),
  .dca_port_06(dca_signal_70),

  .dca_port_12(dca_signal_24),
  .dca_port_11(dca_signal_13),
  
  .dca_port_10(dca_signal_23),
  .dca_port_05(dca_signal_19),

  .dca_port_08(dca_signal_38),
  .dca_port_09(dca_signal_11),
  .dca_port_04(dca_signal_45),
  .dca_port_07(dca_signal_42)
);

assign dca_signal_32 = dca_signal_21 & (~dca_signal_64);
assign dca_signal_58 = dca_signal_83;
assign dca_signal_70 = dca_signal_83;
assign dca_signal_24 = dca_port_03;

DCA_MODULE_00
#(
  .DCA_GPARA_3(DCA_LPARA_16),
  .DCA_GPARA_2(DCA_LPARA_20),
  .DCA_GPARA_0(DCA_LPARA_17),
  .DCA_GPARA_1(DCA_LPARA_11)
)
i_dca_instance_4
(
  .dca_port_00(dca_port_22),
  .dca_port_02(dca_port_14),
  .dca_port_01(dca_signal_60),

  .dca_port_03(dca_signal_17),
  .dca_port_06(dca_signal_41),

  .dca_port_12(dca_signal_29),
  .dca_port_11(dca_signal_03),
  
  .dca_port_10(dca_signal_07),
  .dca_port_05(dca_signal_57),

  .dca_port_08(dca_signal_72),
  .dca_port_09(dca_signal_16),
  .dca_port_04(dca_signal_36),
  .dca_port_07(dca_signal_28)
);

assign dca_signal_60 = 0; 
assign dca_signal_17 = dca_signal_83;
assign dca_signal_41 = dca_signal_83;
assign dca_signal_29 = dca_port_03;

assign dca_port_10 = dca_signal_38 | dca_signal_72;
assign dca_port_02 = dca_signal_47 | dca_signal_47 | dca_signal_11 | dca_signal_16;

assign dca_port_15 = dca_signal_47 | dca_signal_47 | dca_signal_38 | dca_signal_72;
assign dca_port_08 = dca_signal_11 | dca_signal_16;

assign dca_port_17 = (dca_port_03 & dca_signal_50) | dca_signal_21;

generate
  for(i_row=0; i_row<MATRIX_NUM_ROW; i_row=i_row+1)
  begin : i_gen_all_wenable_list2d_row
    for(i_col=0; i_col<MATRIX_NUM_COL; i_col=i_col+1)
    begin : i_gen_all_wenable_list2d_col
      assign dca_port_20[i_row*MATRIX_NUM_COL + i_col] = (dca_signal_82 | dca_signal_14 | dca_signal_45 | dca_signal_36) & dca_signal_39[i_col] & dca_signal_71[i_row];
      assign dca_port_11[i_row*MATRIX_NUM_COL + i_col] = (dca_signal_53 | dca_signal_84 | dca_signal_59 | dca_signal_42 | dca_signal_28) & dca_signal_39[i_col] & dca_signal_71[i_row];
    end
  end
endgenerate

assign dca_port_16 = dca_signal_31;

always@(*)
begin
  dca_port_19 = dca_signal_35;
  if(dca_signal_30)
    dca_port_19 = dca_signal_35;
  else if(dca_signal_48 || dca_signal_21)
    dca_port_19 = dca_signal_35;
  else if(dca_signal_79)
    dca_port_19 = dca_signal_31;
end

assign dca_port_09 = (dca_signal_25!=DCA_LPARA_01);

`ifdef SIM_ENV
`ifdef PRINT_DCA_MATRIX_CAL

always@(posedge dca_port_22)
begin
  if(dca_signal_25==DCA_LPARA_04)
    $display("\n\n");
end

always@(negedge dca_port_22)
begin
  if(dca_port_03)
  begin
    $write("\n[CAL_START]");
    for(m=0; m<MATRIX_NUM_ROW; m=m+1)
    begin
      $write("\n");
      for(n=0; n<MATRIX_NUM_COL; n=n+1)
      begin
        $write(" %d", $signed(dca_port_21[GET_MATRIX_INDEX(m,n)-:BW_TENSOR_SCALAR]));
      end
    end
    $write("\n");
    for(m=0; m<MATRIX_NUM_ROW; m=m+1)
    begin
      $write("\n");
      for(n=0; n<MATRIX_NUM_COL; n=n+1)
      begin
        $write(" %d", $signed(dca_port_06[GET_MATRIX_INDEX(m,n)-:BW_TENSOR_SCALAR]));
      end
    end
  end
end

always@(negedge dca_port_22)
begin
  if(dca_signal_82 | dca_signal_14 | dca_signal_45 | dca_signal_36 | dca_signal_84 | dca_signal_59 | dca_signal_42 | dca_signal_28)
  begin
    $write("\n[CAL_CONSTANT] %d", $signed(dca_port_13[GET_MATRIX_INDEX(0,0)-:BW_TENSOR_SCALAR]));
  end
end

always@(negedge dca_port_22)
begin
  if(dca_signal_82 | dca_signal_14 | dca_signal_45 | dca_signal_36)
  begin
    $write("\n[CAL_TEMP]");
    for(m=0; m<MATRIX_NUM_ROW; m=m+1)
    begin
      $write("\n");
      for(n=0; n<MATRIX_NUM_COL; n=n+1)
      begin
        $write(" %d", $signed(dca_port_16[GET_MATRIX_INDEX(m,n)-:BW_TENSOR_SCALAR]));
      end
    end
  end
end

always@(negedge dca_port_22)
begin
  if(dca_signal_84 | dca_signal_59 | dca_signal_42 | dca_signal_28)
  begin
    $write("\n[CAL_OUTPUT]");
    for(m=0; m<MATRIX_NUM_ROW; m=m+1)
    begin
      $write("\n");
      for(n=0; n<MATRIX_NUM_COL; n=n+1)
      begin
        $write(" %d", $signed(dca_port_19[GET_MATRIX_INDEX(m,n)-:BW_TENSOR_SCALAR]));
      end
    end
  end
end

`endif
`endif

endmodule
