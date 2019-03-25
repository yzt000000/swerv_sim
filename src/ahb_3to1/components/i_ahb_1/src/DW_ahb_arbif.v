/*
------------------------------------------------------------------------
--
//  ------------------------------------------------------------------------
//
//                    (C) COPYRIGHT 2002 - 2018 SYNOPSYS, INC.
//                            ALL RIGHTS RESERVED
//
//  This software and the associated documentation are confidential and
//  proprietary to Synopsys, Inc.  Your use or disclosure of this
//  software is subject to the terms and conditions of a written
//  license agreement between you, or your company, and Synopsys, Inc.
//
// The entire notice above must be reproduced on all authorized copies.
//
// Component Name   : DW_ahb
// Component Version: 2.14a
// Release Type     : GA
//  ------------------------------------------------------------------------

// 
// Release version :  2.14a
// File Version     :        $Revision: #9 $ 
// Revision: $Id: //dwh/DW_ocb/DW_ahb/amba_dev/src/DW_ahb_arbif.v#9 $ 
--
-- File :                       DW_ahb_arbif.v
-- Author:                      Ray Beechinor 
-- Date :                       $Date: 2018/06/22 $ 
-- Abstract     :
--
-- AHB Arbiter Slave Interface.   
--
*/

// AHB Arbiter Slave Memory Map Definitions
// Master Priority Registers

`define PL1_OFFSET         10'h000
`define PL2_OFFSET         10'h004
`define PL3_OFFSET         10'h008
`define PL4_OFFSET         10'h00c
`define PL5_OFFSET         10'h010
`define PL6_OFFSET         10'h014
`define PL7_OFFSET         10'h018
`define PL8_OFFSET         10'h01c
`define PL9_OFFSET         10'h020
`define PL10_OFFSET        10'h024
`define PL11_OFFSET        10'h028
`define PL12_OFFSET        10'h02c
`define PL13_OFFSET        10'h030
`define PL14_OFFSET        10'h034
`define PL15_OFFSET        10'h038
`define EBTCOUNT_OFFSET    10'h03c
`define EBT_EN_OFFSET      10'h040
`define EBT_OFFSET         10'h044
`define DFLT_MASTER_OFFSET 10'h048
`define AHB_WTEN_OFFSET    10'h04c
`define AHB_TCL_OFFSET     10'h050
`define AHB_CCLM1_OFFSET   10'h054
`define AHB_CCLM2_OFFSET   10'h058
`define AHB_CCLM3_OFFSET   10'h05c
`define AHB_CCLM4_OFFSET   10'h060
`define AHB_CCLM5_OFFSET   10'h064
`define AHB_CCLM6_OFFSET   10'h068
`define AHB_CCLM7_OFFSET   10'h06c
`define AHB_CCLM8_OFFSET   10'h070
`define AHB_CCLM9_OFFSET   10'h074
`define AHB_CCLM10_OFFSET  10'h078
`define AHB_CCLM11_OFFSET  10'h07c
`define AHB_CCLM12_OFFSET  10'h080
`define AHB_CCLM13_OFFSET  10'h084
`define AHB_CCLM14_OFFSET  10'h088
`define AHB_CCLM15_OFFSET  10'h08c
`define AHB_VID_OFFSET     10'h090

module i_ahb_1_DW_ahb_arbif (
                     def_mst,
                     bus_priority,
                     maskmaster
                     );

  // physical parameters
  parameter BIG_ENDIAN = `BIG_ENDIAN;         // 0, 1

  
  output [`HMASTER_WIDTH-1:0]       def_mst;        // ID of the default master
                                                    // address location is performed
  output [(4*(`NUM_INT_MASTERS))-1:0] bus_priority; // all master priorities are combined into single bus
  output [`NUM_AHB_MASTERS:0]       maskmaster;     // Which masters have been masked by priority registers




  wire [3:0]                      pl1;




//
// The overall period counter is used to load the master tokens into counters
//
//
// Holds either the configuration value or the hardcoded value of the
// number of clock tokens for a master.
//
//
// The next value to be written into the configuration register.
//


  parameter   ST_NORM  = 2'b00;
  parameter   ST_READ  = 2'b01;
  parameter   ST_WRITE = 2'b10;
  parameter   ST_ERROR = 2'b11;


//
// Need to bring along the address qualification to where the data is
// going to be so that the address can be written to or read from
// correctly.
//






//
// Do not update the priorities if they are been written to by
// the same master as the priority corresponds to, if the data
// been written to is all zeroes, which would disable the master
//
  assign pl1 = `PRIORITY_1;
















  assign def_mst = `DFLT_MSTR_NUM;


   


//
//
//

//
// Priorities to DW_ahb_bcm53 are inverted as DW_ahb_bcm53 
// interprets a priority of 1 as higher than a priority 15, and 
// priority 0 is disabled.
//
  assign maskmaster[0]  = 1'b0;
  assign maskmaster[1]  = (pl1[3:0] == 4'b0);

  assign bus_priority[3:0]   = 4'hf;
  assign bus_priority[7:4]   = ~pl1[3:0];

// spyglass disable_block W415a
// SMD: Signal may be multiply assigned (beside initialization) in the same scope
// SJ: This is not an issue. It is initialized before assignment to avoid latches














// spyglass enable_block W415a


endmodule
