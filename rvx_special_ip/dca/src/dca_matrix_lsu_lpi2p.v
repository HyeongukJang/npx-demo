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
`include "dca_matrix_lsu_inst.vh"



module DCA_MATRIX_LSU_LPI2P
(
  clk,
  rstnn,
  clear,
  enable,
  busy,

  inst_wvalid,
  inst_wdata,
  inst_wready,
  inst_is_write,
  inst_decode_finish,
  inst_execute_finish,

  load_tensor_row_wvalid,
  load_tensor_row_wlast,
  load_tensor_row_wdata,
  load_tensor_row_wready,

  store_tensor_row_rvalid,
  store_tensor_row_rlast,
  store_tensor_row_rready,
  store_tensor_row_rdata,

  read_slxqdready,
  read_slxqvalid,
  read_slxqhint,
  read_slxqlast,
  read_slxqafy,
  read_slxqdata,
  read_slxydready,
  read_slxyvalid,
  read_slxyhint,
  read_slxylast,
  read_slxydata,

  write_slxqdready,
  write_slxqvalid,
  write_slxqhint,
  write_slxqlast,
  write_slxqafy,
  write_slxqdata,
  write_slxydready,
  write_slxyvalid,
  write_slxyhint,
  write_slxylast,
  write_slxydata
);



parameter LSU_PARA = 0;
parameter AXI_PARA = 32;
parameter BW_LPI_BURDEN = 1;
parameter MATRIX_SIZE_PARA = 4;
parameter TENSOR_PARA = 0;

`include "ervp_axi_lpara.vb"
`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"
`include "dca_tensor_scalar_lpara.vb"
`include "dca_tensor_dim_lpara.vb"

`include "lpit_function.vb"
`include "lpixm_function.vb"

localparam  BW_LPIXM_ADDR = BW_AXI_ADDR;
localparam  BW_LPIXM_DATA = BW_AXI_DATA;

`include "lpixm_lpara.vb"

input wire clk;
input wire rstnn;
input wire clear;
input wire enable;
output wire busy;

localparam  DCA_LPARA_03 = `BW_DCA_MATRIX_LSU_INST;

input wire inst_wvalid;
input wire [DCA_LPARA_03-1:0] inst_wdata;
output wire inst_wready;
output reg inst_is_write;
output wire inst_decode_finish;
output wire inst_execute_finish;

output wire load_tensor_row_wvalid;
output wire load_tensor_row_wlast;
output wire [BW_TENSOR_ROW-1:0] load_tensor_row_wdata;
input wire load_tensor_row_wready;

output wire store_tensor_row_rvalid;
output wire store_tensor_row_rlast;
input wire store_tensor_row_rready;
input wire [BW_TENSOR_ROW-1:0] store_tensor_row_rdata;

input wire [2-1:0] read_slxqdready;
output wire read_slxqvalid;
output wire read_slxqhint;
output wire read_slxqlast;
output wire read_slxqafy;
output wire [BW_LPI_QDATA-1:0] read_slxqdata;
output wire [2-1:0] read_slxydready;
input wire read_slxyvalid;
input wire read_slxyhint;
input wire read_slxylast;
input wire [BW_LPI_YDATA-1:0] read_slxydata;

input wire [2-1:0] write_slxqdready;
output wire write_slxqvalid;
output wire write_slxqhint;
output wire write_slxqlast;
output wire write_slxqafy;
output wire [BW_LPI_QDATA-1:0] write_slxqdata;
output wire [2-1:0] write_slxydready;
input wire write_slxyvalid;
input wire write_slxyhint;
input wire write_slxylast;
input wire [BW_LPI_YDATA-1:0] write_slxydata;

`include "dca_lsu_util.vb"
`include "dca_lsu_lpara.vb"
`include "motype_lpara.vb"

wire dca_signal_21;
wire dca_signal_08;
wire dca_signal_37;

wire dca_signal_34;

localparam  DCA_LPARA_09 = DCA_LPARA_03;
localparam  DCA_LPARA_02 = INST_FIFO_DEPTH;

wire dca_signal_04;
wire dca_signal_14;
wire [DCA_LPARA_09-1:0] dca_signal_27;
wire dca_signal_03;
wire dca_signal_50;
wire [DCA_LPARA_09-1:0] dca_signal_16;

localparam  DCA_LPARA_10 = BW_TXN_INFO;
localparam  DCA_LPARA_05 = MATRIX_NUM_COL;

wire dca_signal_57;
wire dca_signal_01;
wire [DCA_LPARA_10-1:0] dca_signal_42;
wire dca_signal_31;
wire dca_signal_60;
wire [DCA_LPARA_10-1:0] dca_signal_00;

wire dca_signal_10;
wire dca_signal_47;
wire [DCA_LPARA_10-1:0] dca_signal_06;
wire dca_signal_11;
wire dca_signal_58;
wire [DCA_LPARA_10-1:0] dca_signal_15;

wire dca_signal_59;
wire dca_signal_49;
wire [DCA_LPARA_10-1:0] dca_signal_12;
wire dca_signal_13;
wire dca_signal_32;
wire [DCA_LPARA_10-1:0] dca_signal_20;

wire dca_signal_46;
wire dca_signal_19;
wire [DCA_LPARA_10-1:0] dca_signal_51;
wire dca_signal_26;
wire dca_signal_30;
wire [DCA_LPARA_10-1:0] dca_signal_43;

localparam  DCA_LPARA_08 = BW_RRESP_INFO;
localparam  DCA_LPARA_06 = 2;

wire dca_signal_55;
wire dca_signal_35;
wire [DCA_LPARA_08-1:0] dca_signal_62;
wire dca_signal_24;
wire dca_signal_05;
wire [DCA_LPARA_08-1:0] dca_signal_39;

localparam  DCA_LPARA_00 = BW_WDATA_INFO;
localparam  DCA_LPARA_04 = 4;

wire dca_signal_28;
wire dca_signal_65;
wire [DCA_LPARA_00-1:0] dca_signal_23;
wire dca_signal_52;
wire dca_signal_40;
wire [DCA_LPARA_00-1:0] dca_signal_29;

wire dca_signal_09;
wire dca_signal_45;
wire [BW_AXI_DATA-1:0] dca_signal_56;
wire [`BW_AXI_WSTRB(BW_AXI_DATA)-1:0] dca_signal_17;
wire dca_signal_63;
wire dca_signal_25;

localparam  DCA_LPARA_12 = 2;
localparam  DCA_LPARA_11 = 0;
localparam  DCA_LPARA_07 = 1;
localparam  DCA_LPARA_01 = 2;

reg [DCA_LPARA_12-1:0] dca_signal_33;
wire dca_signal_54;
wire [DCA_LPARA_03-1:0] dca_signal_53;

wire [`BW_DCA_MATRIX_LSU_INST_OPCODE-1:0] dca_signal_07;

reg dca_signal_44;

wire dca_signal_18;
wire dca_signal_38;
wire dca_signal_22;
wire dca_signal_41;
wire dca_signal_64;
wire dca_signal_02;
wire dca_signal_61;
wire dca_signal_48;
wire dca_signal_36;

assign dca_signal_21 = (INCLUDE_INST_FIFO==1) & enable;
assign dca_signal_08 = READ_SUPPORTED & enable;
assign dca_signal_37 = WRITE_SUPPORTED & enable;

ERVP_FIFO
#(
  .BW_DATA(DCA_LPARA_09),
  .DEPTH(DCA_LPARA_02)
)
i_dca_instance_09
(
  .clk(clk),
  .rstnn(rstnn),
  .enable(dca_signal_21),
  .clear(clear),

  .wready(dca_signal_04),
  .wfull(),
  .wrequest(dca_signal_14),
  .wdata(dca_signal_27),
  .wnum(),
  .rready(dca_signal_03),
  .rempty(),
  .rrequest(dca_signal_50),
  .rdata(dca_signal_16),
  .rnum()
);

assign dca_signal_14 = inst_wvalid;
assign dca_signal_27 = inst_wdata;
assign dca_signal_50 = inst_decode_finish;

always@(posedge clk, negedge rstnn)
begin
  if(rstnn==0)
  begin
    dca_signal_33 <= DCA_LPARA_11;
    inst_is_write <= 0;
  end
  else if(enable)
    case(dca_signal_33)
      DCA_LPARA_11:
        if(dca_signal_54)
          dca_signal_33 <= DCA_LPARA_07;
      DCA_LPARA_07:
        if(dca_signal_44)
        begin
          dca_signal_33 <= DCA_LPARA_01;
          inst_is_write <= (dca_signal_07==`DCA_MATRIX_LSU_INST_OPCODE_WRITE);
        end
      DCA_LPARA_01:
        if(inst_decode_finish)
          dca_signal_33 <= DCA_LPARA_11;
    endcase
end

assign dca_signal_54 = (INCLUDE_INST_FIFO==0)? inst_wvalid : dca_signal_03;
assign dca_signal_53 = (INCLUDE_INST_FIFO==0)? inst_wdata : dca_signal_16;
assign inst_wready = (INCLUDE_INST_FIFO==0)? inst_decode_finish : dca_signal_04;

assign dca_signal_07 = dca_signal_53;

always@(*)
begin
  dca_signal_44 = 0;
  if(dca_signal_33==DCA_LPARA_07)
    case(dca_signal_07)
      `DCA_MATRIX_LSU_INST_OPCODE_READ:
        dca_signal_44 = ~dca_signal_61;
      `DCA_MATRIX_LSU_INST_OPCODE_WRITE:
        dca_signal_44 = ~dca_signal_22;
    endcase
end

DCA_MODULE_08
#(
  .LSU_PARA(LSU_PARA),
  .AXI_PARA(AXI_PARA),
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .DCA_GPARA_0(DCA_LPARA_05)
)
i_dca_instance_06
(
  .dca_port_00(clk),
  .dca_port_27(rstnn),
  .dca_port_18(clear),
  .dca_port_21(enable),
  .dca_port_06(dca_signal_18),

  .dca_port_03(dca_signal_34),

  .dca_port_01(dca_signal_44),
  .dca_port_22(dca_signal_53),
  .dca_port_07(),

  .dca_port_20(dca_signal_57),
  .dca_port_11(dca_signal_01),
  .dca_port_09(dca_signal_42),

  .dca_port_29(dca_signal_10),
  .dca_port_24(dca_signal_47),
  .dca_port_28(dca_signal_06),

  .dca_port_19(dca_signal_59),
  .dca_port_10(dca_signal_49),
  .dca_port_08(dca_signal_12),

  .dca_port_02(dca_signal_46),
  .dca_port_26(dca_signal_19),
  .dca_port_25(dca_signal_51),

  .dca_port_16(dca_signal_55),
  .dca_port_15(dca_signal_35),
  .dca_port_23(dca_signal_62),

  .dca_port_12(dca_signal_28),
  .dca_port_04(dca_signal_65),
  .dca_port_05(dca_signal_23),

  .dca_port_13(load_tensor_row_wvalid),
  .dca_port_17(load_tensor_row_wlast),
  .dca_port_14(load_tensor_row_wready)
);

assign dca_signal_34 = 1;

ERVP_FIFO
#(
  .BW_DATA(DCA_LPARA_10),
  .DEPTH(DCA_LPARA_05)
)
i_dca_instance_11
(
  .clk(clk),
  .rstnn(rstnn),
  .enable(dca_signal_08),
  .clear(clear),

  .wready(dca_signal_57),
  .wfull(),
  .wrequest(dca_signal_01),
  .wdata(dca_signal_42),
  .wnum(),
  .rready(dca_signal_31),
  .rempty(),
  .rrequest(dca_signal_60),
  .rdata(dca_signal_00),
  .rnum()
);

ERVP_FIFO
#(
  .BW_DATA(DCA_LPARA_10),
  .DEPTH(DCA_LPARA_05)
)
i_dca_instance_00
(
  .clk(clk),
  .rstnn(rstnn),
  .enable(dca_signal_08),
  .clear(clear),

  .wready(dca_signal_10),
  .wfull(),
  .wrequest(dca_signal_47),
  .wdata(dca_signal_06),
  .wnum(),
  .rready(dca_signal_11),
  .rempty(),
  .rrequest(dca_signal_58),
  .rdata(dca_signal_15),
  .rnum()
);

ERVP_FIFO
#(
  .BW_DATA(DCA_LPARA_10),
  .DEPTH(DCA_LPARA_05)
)
i_dca_instance_12
(
  .clk(clk),
  .rstnn(rstnn),
  .enable(dca_signal_37),
  .clear(clear),

  .wready(dca_signal_59),
  .wfull(),
  .wrequest(dca_signal_49),
  .wdata(dca_signal_12),
  .wnum(),
  .rready(dca_signal_13),
  .rempty(),
  .rrequest(dca_signal_32),
  .rdata(dca_signal_20),
  .rnum()
);

DCA_MODULE_30
#(
  .LSU_PARA(LSU_PARA),
  .AXI_PARA(AXI_PARA),
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .DCA_GPARA_0(DCA_LPARA_05)
)
i_dca_instance_05
(
  .dca_port_04(clk),
  .dca_port_00(rstnn),
  .dca_port_08(dca_signal_37),
  .dca_port_07(clear),

  .dca_port_05(dca_signal_46),
  .dca_port_03(dca_signal_19),
  .dca_port_02(dca_signal_51),
  .dca_port_06(dca_signal_26),
  .dca_port_01(dca_signal_30),
  .dca_port_09(dca_signal_43)
);

ERVP_FIFO
#(
  .BW_DATA(DCA_LPARA_08),
  .DEPTH(DCA_LPARA_06)
)
i_dca_instance_04
(
  .clk(clk),
  .rstnn(rstnn),
  .enable(dca_signal_08),
  .clear(clear),

  .wready(dca_signal_55),
  .wfull(),
  .wrequest(dca_signal_35),
  .wdata(dca_signal_62),
  .wnum(),
  .rready(dca_signal_24),
  .rempty(),
  .rrequest(dca_signal_05),
  .rdata(dca_signal_39),
  .rnum()
);

ERVP_FIFO
#(
  .BW_DATA(DCA_LPARA_00),
  .DEPTH(DCA_LPARA_04)
)
i_dca_instance_02
(
  .clk(clk),
  .rstnn(rstnn),
  .enable(dca_signal_37),
  .clear(clear),

  .wready(dca_signal_28),
  .wfull(),
  .wrequest(dca_signal_65),
  .wdata(dca_signal_23),
  .wnum(),
  .rready(dca_signal_52),
  .rempty(),
  .rrequest(dca_signal_40),
  .rdata(dca_signal_29),
  .rnum()
);

DCA_MODULE_13
#(
  .LSU_PARA(LSU_PARA),
  .AXI_PARA(AXI_PARA),
  .BW_LPI_BURDEN(BW_LPI_BURDEN),
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_01
(
  .dca_port_01(clk),
  .dca_port_09(rstnn),
  .dca_port_07(clear),
  .dca_port_06(dca_signal_08),
  .dca_port_13(dca_signal_38),

  .dca_port_05(dca_signal_53),

  .dca_port_08(dca_signal_31),
  .dca_port_03(dca_signal_00),
  .dca_port_02(dca_signal_60),

  .dca_port_14(read_slxqdready),
  .dca_port_10(read_slxqvalid),
  .dca_port_00(read_slxqhint),
  .dca_port_04(read_slxqlast),
  .dca_port_12(read_slxqafy),
  .dca_port_11(read_slxqdata)
);

assign inst_decode_finish = (dca_signal_33==DCA_LPARA_01) & (~dca_signal_18) & (~dca_signal_31) & (~dca_signal_13);

DCA_MODULE_19
#(
  .LSU_PARA(LSU_PARA),
  .AXI_PARA(AXI_PARA),
  .BW_LPI_BURDEN(BW_LPI_BURDEN),
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .TENSOR_PARA(TENSOR_PARA)
)
i_dca_instance_07
(
  .dca_port_05(clk),
  .dca_port_01(rstnn),
  .dca_port_02(clear),
  .dca_port_12(dca_signal_08),
  .dca_port_16(dca_signal_22),

  .dca_port_19(dca_signal_41),

  .dca_port_18(dca_signal_24),
  .dca_port_14(dca_signal_39),
  .dca_port_06(dca_signal_05),

  .dca_port_20(dca_signal_11),
  .dca_port_11(dca_signal_15),
  .dca_port_07(dca_signal_58),

  .dca_port_04(read_slxydready),
  .dca_port_09(read_slxyvalid),
  .dca_port_08(read_slxyhint),
  .dca_port_15(read_slxylast),
  .dca_port_10(read_slxydata),

  .dca_port_17(load_tensor_row_wvalid),
  .dca_port_03(load_tensor_row_wlast),
  .dca_port_00(load_tensor_row_wdata),
  .dca_port_13(load_tensor_row_wready)
);

DCA_MODULE_06
#(
  .LSU_PARA(LSU_PARA),
  .AXI_PARA(AXI_PARA),
  .BW_LPI_BURDEN(BW_LPI_BURDEN),
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .TENSOR_PARA(TENSOR_PARA)
)
i_dca_instance_10
(
  .dca_port_19(clk),
  .dca_port_02(rstnn),
  .dca_port_15(clear),
  .dca_port_00(dca_signal_37),
  .dca_port_12(dca_signal_02),

  .dca_port_17(dca_signal_52),
  .dca_port_05(dca_signal_29),
  .dca_port_03(dca_signal_40),

  .dca_port_13(dca_signal_26),
  .dca_port_04(dca_signal_43),
  .dca_port_01(dca_signal_30),

  .dca_port_14(store_tensor_row_rvalid),
  .dca_port_07(store_tensor_row_rlast),
  .dca_port_20(store_tensor_row_rready),
  .dca_port_06(store_tensor_row_rdata),

  .dca_port_09(dca_signal_09),
  .dca_port_18(dca_signal_45),
  .dca_port_08(dca_signal_56),
  .dca_port_11(dca_signal_17),
  .dca_port_16(dca_signal_63),
  .dca_port_10(dca_signal_25)
);

DCA_MODULE_33
#(
  .LSU_PARA(LSU_PARA),
  .AXI_PARA(AXI_PARA),
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .BW_LPI_BURDEN(BW_LPI_BURDEN),
  .DCA_GPARA_0(DCA_LPARA_04)
)
i_dca_instance_08
(
  .dca_port_05(clk),
  .dca_port_08(rstnn),
  .dca_port_01(clear),
  .dca_port_02(dca_signal_37),
  .dca_port_09(dca_signal_61),

  .dca_port_04(dca_signal_48),
  .dca_port_15(dca_signal_36),

  .dca_port_07(dca_signal_09),
  .dca_port_06(dca_signal_45),
  .dca_port_14(dca_signal_63),
  .dca_port_03(dca_signal_25),

  .dca_port_00(write_slxydready),
  .dca_port_13(write_slxyvalid),
  .dca_port_11(write_slxyhint),
  .dca_port_12(write_slxylast),
  .dca_port_10(write_slxydata)
);

assign dca_signal_48 = dca_signal_41;

DCA_MODULE_16
#(
  .LSU_PARA(LSU_PARA),
  .AXI_PARA(AXI_PARA),
  .BW_LPI_BURDEN(BW_LPI_BURDEN),
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_03
(
  .dca_port_14(clk),
  .dca_port_17(rstnn),
  .dca_port_04(clear),
  .dca_port_03(dca_signal_37),
  .dca_port_02(dca_signal_64),

  .dca_port_07(dca_signal_53),

  .dca_port_12(dca_signal_13),
  .dca_port_15(dca_signal_20),
  .dca_port_00(dca_signal_32),

  .dca_port_08(dca_signal_09),
  .dca_port_20(dca_signal_45),
  .dca_port_01(dca_signal_56),
  .dca_port_13(dca_signal_17),
  .dca_port_19(dca_signal_63),
  .dca_port_06(dca_signal_25),

  .dca_port_10(write_slxqdready),
  .dca_port_11(write_slxqvalid),
  .dca_port_18(write_slxqhint),
  .dca_port_16(write_slxqlast),
  .dca_port_05(write_slxqafy),
  .dca_port_09(write_slxqdata)
);

assign inst_execute_finish = dca_signal_41 | dca_signal_36;
assign busy = dca_signal_03 | (dca_signal_33!=DCA_LPARA_11) | dca_signal_18 | dca_signal_22 | dca_signal_02 | dca_signal_61;

endmodule
