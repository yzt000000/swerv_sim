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
// Revision: $Id: //dwh/DW_ocb/DW_ahb_icm/amba_dev/src/DW_ahb_icm_low.v#8 $ 
//
// File     : DW_ahb_icm_low.v
// Authors  : Peter Gillen
// Date     : $Date: 2015/05/15 $
// Abstract : Handles slaves with a default hready_resp of low.
//
//
//
//
//

module i_icm_DW_ahb_icm_low ( 
  hclk,
  hresetn,
  hready,
  hready_resp,
  hsel,

  revised_hready_resp
);

  input                      hclk;
  input                      hresetn;
  input                      hready;
  input                      hready_resp;
  input  [`ICM_NUM_HSEL-1:0] hsel;

  output                     revised_hready_resp;

  reg                        internal_hready_resp;

//#
//# If the incoming hready is high and the slave is not selected then make sure
//# that the hready_resp used will be a 1. 
//# If the incoming hready i shigh and the slave is selected then make sure
//# that the hready_resp from the slave is passed through and used and that the
//# internal is having no effect
//# The incoming hsel maybe a bus with only one bit set so this needs to be
//# a bit-wise or.
//#

  always @(posedge hclk or negedge hresetn)
  begin : internal_hready_resp_PROC
    if (hresetn == 1'b0) begin
      internal_hready_resp <= 1'b1;
    end else begin
      if (hready == 1'b1) begin
        if (hsel == 1'b1) begin
          internal_hready_resp <= 1'b0;
        end else begin
          internal_hready_resp <= 1'b1;
        end
      end
    end
  end
  assign revised_hready_resp = internal_hready_resp | hready_resp;

endmodule
