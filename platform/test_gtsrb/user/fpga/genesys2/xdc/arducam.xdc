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
## 2017-07-18 Kyuseung Han (han@etri.re.kr)
## ****************************************************************************
## ****************************************************************************

#Pmod Header JA Upper
set_property -dict { PACKAGE_PIN U27   IOSTANDARD LVCMOS33 } [get_ports { arducam_spi_scs }]; # pin 1
set_property -dict { PACKAGE_PIN U28   IOSTANDARD LVCMOS33 } [get_ports { arducam_spi_sdq0 }]; # pin 2 (MOSI)
set_property -dict { PACKAGE_PIN T26   IOSTANDARD LVCMOS33 } [get_ports { arducam_spi_sdq1 }]; # pin 3 (MISO)
set_property -dict { PACKAGE_PIN T27   IOSTANDARD LVCMOS33 } [get_ports { arducam_spi_sclk }]; # pin 4

#Pmod Header JA Lower
set_property -dict { PACKAGE_PIN T20   IOSTANDARD LVCMOS33 } [get_ports { arducam_i2c_sclk }]; #IO_L24P_T3_RS1_15 Sch=jb_p[4] # pin 9
set_property -dict { PACKAGE_PIN T21   IOSTANDARD LVCMOS33 } [get_ports { arducam_i2c_sdata }]; #IO_L24N_T3_RS0_15 Sch=jb_n[4] # pin 10

set_property PULLUP true [get_ports arducam_i2c_sclk ]
set_property PULLUP true [get_ports arducam_i2c_sdata ]


## PMOD Header JA
#set_property -dict { PACKAGE_PIN U27   IOSTANDARD LVCMOS33 } [get_ports { ja[0] }]; #IO_L13P_T2_MRCC_14 Sch=ja_p[1]
#set_property -dict { PACKAGE_PIN U28   IOSTANDARD LVCMOS33 } [get_ports { ja[1] }]; #IO_L13N_T2_MRCC_14 Sch=ja_n[1]
#set_property -dict { PACKAGE_PIN T26   IOSTANDARD LVCMOS33 } [get_ports { ja[2] }]; #IO_L12P_T1_MRCC_14 Sch=ja_p[2]
#set_property -dict { PACKAGE_PIN T27   IOSTANDARD LVCMOS33 } [get_ports { ja[3] }]; #IO_L12N_T1_MRCC_14 Sch=ja_n[2]
#
#set_property -dict { PACKAGE_PIN T22   IOSTANDARD LVCMOS33 } [get_ports { ja[4] }]; #IO_L5P_T0_D06_14 Sch=ja_p[3]
#set_property -dict { PACKAGE_PIN T23   IOSTANDARD LVCMOS33 } [get_ports { ja[5] }]; #IO_L5N_T0_D07_14 Sch=ja_n[3]
#set_property -dict { PACKAGE_PIN T20   IOSTANDARD LVCMOS33 } [get_ports { ja[6] }]; #IO_L4P_T0_D04_14 Sch=ja_p[4]
#set_property -dict { PACKAGE_PIN T21   IOSTANDARD LVCMOS33 } [get_ports { ja[7] }]; #IO_L4N_T0_D05_14 Sch=ja_n[4]

