//
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
// Component Name   : DW_ahb_icm
// Component Version: 1.17a
// Release Type     : GA
//  ------------------------------------------------------------------------

// 
// Release version :  1.17a
// File Version     :        $Revision: #8 $ 
// Revision: $Id: //dwh/DW_ocb/DW_ahb_icm/amba_dev/src/DW_ahb_icm_gh.v#8 $ 
//
// File     : DW_ahb_icm_gh.v
// Authors  : Peter Gillen
// Date     : $DateTime: 2016/05/19 01:19:09 $
// Abstract : Generate incoming hready into a bussed form for all layers.
//
//
//
//
//

module i_icm_DW_ahb_icm_gh (
  hready_l1,
                      hready_l2,
                      hready_l3,
                      bus_hready_l
                      );

  input                        hready_l1;
  input                        hready_l2;
  input                        hready_l3;

  output [`ICM_NUM_LAYERS-1:0] bus_hready_l;

  assign bus_hready_l = {
                          hready_l3, 
                          hready_l2, 
                          hready_l1  };

endmodule
