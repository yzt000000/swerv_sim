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
// File Version     :        $Revision: #6 $ 
// Revision: $Id: //dwh/DW_ocb/DW_ahb/amba_dev/src/DW_ahb_arblite.v#6 $ 
--
-- File :                       DW_ahb_arblite.v
-- Author:                      Peter Gillen 
-- Date :                       $Date: 2016/08/26 $ 
-- Abstract     :               AHB Lite Arbiter Replacement
--           
*/

module i_ahb_DW_ahb_arblite (
  hclk,
  hresetn,
  hready,
  hlock_m1,
  hmaster,
  hmastlock
);

  input                        hclk;
  input                        hresetn;
  input                        hready;
  input                        hlock_m1;
  output [`HMASTER_WIDTH-1:0]  hmaster;
  output                       hmastlock;

  reg                          hmastlock;
//
// The timing of the hlock signal requires it to be retimed
// with hready so that the resultant hmastlock will have the
// same timing as the address and control on the AHB bus.
//
  always @(posedge hclk or negedge hresetn)
  begin : hmastlock_PROC
    if (hresetn == 1'b0) begin
      hmastlock <= 1'b0;
    end else begin
      if (hready == 1'b1) begin
        hmastlock <= hlock_m1;
      end
    end
  end

  assign hmaster = {4'b0001};

endmodule
