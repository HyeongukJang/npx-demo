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

##########
## OLED ##
##########
#Pmod Header JB
set_property -dict { PACKAGE_PIN V29   IOSTANDARD LVCMOS33 } [get_ports { oled_scs }]; # pin 1
set_property -dict { PACKAGE_PIN V30   IOSTANDARD LVCMOS33 } [get_ports { oled_sdq0 }]; # pin 2 (MOSI)
set_property -dict { PACKAGE_PIN V25   IOSTANDARD LVCMOS33 } [get_ports { oled_sdq1 }]; # pin 3 (MISO)
set_property -dict { PACKAGE_PIN W26   IOSTANDARD LVCMOS33 } [get_ports { oled_sclk }]; # pin 4

set_property -dict { PACKAGE_PIN T25   IOSTANDARD LVCMOS33 } [get_ports { oled_sdcsel }]; # pin 7
set_property -dict { PACKAGE_PIN U25   IOSTANDARD LVCMOS33 } [get_ports { oled_srstnn }]; # pin 8
set_property -dict { PACKAGE_PIN U22   IOSTANDARD LVCMOS33 } [get_ports { oled_svbat }]; # pin 9
set_property -dict { PACKAGE_PIN U23   IOSTANDARD LVCMOS33 } [get_ports { oled_svdd }]; # pin 10

## PMOD Header JB
#set_property -dict { PACKAGE_PIN V29   IOSTANDARD LVCMOS33 } [get_ports { jb[0] }]; #IO_L17P_T2_A14_D30_14 Sch=jb_p[1]
#set_property -dict { PACKAGE_PIN V30   IOSTANDARD LVCMOS33 } [get_ports { jb[1] }]; #IO_L17N_T2_A13_D29_14 Sch=jb_n[1]
#set_property -dict { PACKAGE_PIN V25   IOSTANDARD LVCMOS33 } [get_ports { jb[2] }]; #IO_L18P_T2_A12_D28_14 Sch=jb_p[2]
#set_property -dict { PACKAGE_PIN W26   IOSTANDARD LVCMOS33 } [get_ports { jb[3] }]; #IO_L18N_T2_A11_D27_14 Sch=jb_n[2]
#set_property -dict { PACKAGE_PIN T25   IOSTANDARD LVCMOS33 } [get_ports { jb[4] }]; #IO_L14P_T2_SRCC_14 Sch=jb_p[3]
#set_property -dict { PACKAGE_PIN U25   IOSTANDARD LVCMOS33 } [get_ports { jb[5] }]; #IO_L14N_T2_SRCC_14 Sch=jb_n[3]
#set_property -dict { PACKAGE_PIN U22   IOSTANDARD LVCMOS33 } [get_ports { jb[6] }]; #IO_L21P_T3_DQS_14 Sch=jb_p[4]
#set_property -dict { PACKAGE_PIN U23   IOSTANDARD LVCMOS33 } [get_ports { jb[7] }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=jb_n[4]
