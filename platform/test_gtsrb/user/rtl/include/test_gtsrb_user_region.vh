/*****************/
/* Custom Region */
/*****************/

// wire clk_system;
// wire clk_dca_core;
// wire clk_core;
// wire clk_system_external;
// wire clk_system_debug;
// wire clk_local_access;
// wire clk_process_000;
// wire clk_dram_if;
// wire clk_dram_sys;
// wire clk_dram_ref;
// wire clk_jpeg;
// wire clk_noc;
// wire gclk_system;
// wire gclk_dca_core;
// wire gclk_core;
// wire gclk_system_external;
// wire gclk_system_debug;
// wire gclk_local_access;
// wire gclk_process_000;
// wire gclk_jpeg;
// wire gclk_noc;
// wire tick_1us;
// wire tick_62d5ms;
// wire tick_gpio;
// wire spi_common_sclk;
// wire spi_common_sdq0;
// wire global_rstnn;
// wire global_rstpp;
// wire [(7)-1:0] rstnn_seqeunce;
// wire [(7)-1:0] rstpp_seqeunce;
// wire rstnn_user;
// wire rstpp_user;
// wire user_spi_0_rclk;
// wire user_spi_0_rcs;
// wire user_spi_0_rdq0;
// wire user_spi_0_rdq1;

/* DO NOT MODIFY THE ABOVE */
/* MUST MODIFY THE BELOW   */


//assign oled_bw_sclk = (user_spi_0_rcs)? 0: user_spi_0_rclk;
//assign `NOT_CONNECT = user_spi_0_rcs;
//assign oled_bw_sdin = (user_spi_0_rcs)? 0: user_spi_0_rdq0;
//assign user_spi_0_rdq1 = 0;

assign oled_bw_sclk = user_spi_0_rclk;
assign oled_bw_sdin = user_spi_0_rdq0;
assign user_spi_0_rdq1 = 0;

//assign oled_bw_cs = user_spi_0_rcs;
//assign oled_bw_sdin = user_spi_0_rdq0;
//assign user_spi_0_rdq1 = oled_bw_sdout;
//assign oled_bw_sclk = user_spi_0_rclk;

assign cls_uart_tx = user_uart_0_rtx;
assign user_uart_0_rrx = cls_uart_rx;
