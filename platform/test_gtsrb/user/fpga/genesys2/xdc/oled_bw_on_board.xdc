## ****************************************************************************
## ****************************************************************************
## Copyright SoC Design Research Group, All rights reserved.    
## Electronics and Telecommunications Research Institute (ETRI)
##
## THESE DOCUMENTS CONTAIN CONFIDENTIAL INFORMATION AND KNOWLEDGE 
## WHICH IS THE PROPERTY OF ETRI. NO PART OF THIS PUBLICATION IS 
## TO BE USED FOR ANY OTHER PURPOSE, AND THESE ARE NOT TO BE 
## REPRODUCED, COPIED, DISCLOSED, TRANSMITTED, STORED IN A RETRIEVAL 
## SYSTEM OR TRANSLATED INTO ANY OTHER HUMAN OR COMPUTER LANGUAGE, 
## IN ANY FORM, BY ANY MEANS, IN WHOLE OR IN PART, WITHOUT THE 
## COMPLETE PRIOR WRITTEN PERMISSION OF ETRI.
## ****************************************************************************
## Apr.19,2017, Sukho Lee (shlee99@etri.re.kr)
## ****************************************************************************
## ****************************************************************************

##########################
## OLED_BW for genesys2 ##
##########################
## OLED Display on board
set_property -dict { PACKAGE_PIN AF17  IOSTANDARD LVCMOS18 } [get_ports { oled_bw_sclk }]; #IO_L12P_T1_MRCC_32 Sch=oled_sclk
set_property -dict { PACKAGE_PIN Y15   IOSTANDARD LVCMOS18 } [get_ports { oled_bw_sdin }]; #IO_L24N_T3_32 Sch=oled_sdin

set_property -dict { PACKAGE_PIN AC17  IOSTANDARD LVCMOS18 } [get_ports { oled_bw_dc }]; #IO_L18N_T2_32 Sch=oled_dc
set_property -dict { PACKAGE_PIN AB17  IOSTANDARD LVCMOS18 } [get_ports { oled_bw_res }]; #IO_L18P_T2_32 Sch=oled_res
set_property -dict { PACKAGE_PIN AB22  IOSTANDARD LVCMOS33 } [get_ports { oled_bw_vbat }]; #IO_L3P_T0_DQS_12 Sch=oled_vbat
set_property -dict { PACKAGE_PIN AG17  IOSTANDARD LVCMOS18 } [get_ports { oled_bw_vdd }]; #IO_L12N_T1_MRCC_32 Sch=oled_vdd

## Pmod D
#set_property -dict { PACKAGE_PIN V27   IOSTANDARD LVCMOS33 } [get_ports { oled_bw_cs }]; #IO_L16N_T2_A15_D31_14 Sch=jd[1]
#set_property -dict { PACKAGE_PIN Y30   IOSTANDARD LVCMOS33 } [get_ports { oled_bw_sdin }]; #IO_L8P_T1_13 Sch=jd[2]
#set_property -dict { PACKAGE_PIN V24   IOSTANDARD LVCMOS33 } [get_ports { oled_bw_sdout }]; #IO_L23N_T3_A02_D18_14 Sch=jd[3]
#set_property -dict { PACKAGE_PIN W22   IOSTANDARD LVCMOS33 } [get_ports { oled_bw_sclk }]; #IO_L24N_T3_A00_D16_14 Sch=jd[4]
#
#set_property -dict { PACKAGE_PIN U24   IOSTANDARD LVCMOS33 } [get_ports { oled_bw_dc }]; #IO_L23P_T3_A03_D19_14 Sch=jd[7]
#set_property -dict { PACKAGE_PIN Y26   IOSTANDARD LVCMOS33 } [get_ports { oled_bw_res }]; #IO_L1P_T0_13 Sch=jd[8]
#set_property -dict { PACKAGE_PIN V22   IOSTANDARD LVCMOS33 } [get_ports { oled_bw_vbat }]; #IO_L22N_T3_A04_D20_14 Sch=jd[9]
#set_property -dict { PACKAGE_PIN W21   IOSTANDARD LVCMOS33 } [get_ports { oled_bw_vdd }]; #IO_L24P_T3_A01_D17_14 Sch=jd[10]

