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
// File Version     :        $Revision: #7 $ 
// Revision: $Id: //dwh/DW_ocb/DW_ahb/amba_dev/src/DW_ahb_cntc.v#7 $ 
--
-- File :                       DW_ahb_cntc.v
-- Author:                      Peter Gillen 
-- Date :                       $Date: 2015/05/15 $ 
-- Abstract     :
--
-- Counts the clock cycles (tokens) that a master uses up when it is
-- on the bus. When the programmed number of tokens are used the master
-- is masked from the third tier of arbitration.
--
*/
module i_ahb_DW_ahb_cntc (
  hclk,
                    hresetn,
                    enable,
                    load,
                    load_val,
                    mask
                    );

  input                       hclk;
  input                       hresetn;
  input                       enable;
  input                       load;
  input  [`AHB_CCL_WIDTH-1:0] load_val;

  output                      mask;

  parameter RV = {`AHB_CCL_WIDTH{1'b0}};

  reg    [`AHB_CCL_WIDTH-1:0] count;
  reg    [`AHB_CCL_WIDTH-1:0] next_count;
  reg                         mask;
  wire                        do_not_mask;

//
// Counter is broken into a master and a slave section.
// Counter gets resets with a parameter value.
// Load counter with value when load is active
// Provided the counter is not masked and is enabled
// then decrement by 1 otherwise hold the value as is.
//
  always @ (posedge hclk or negedge hresetn)
  begin : count_PROC
    if (hresetn == 1'b0)
      count <= RV;
    else begin
      count <= next_count;
    end
  end

  // JS_DEBUG, 1/4/08, leda CS_5P_R_B
  // No non-blocking assignment are allowed in a combinatorial block
  // Fixing here.
  always @(load or load_val or mask or enable or count)
  begin : next_count_PROC
    next_count = count;
    if (load == 1'b1) begin
      next_count = load_val;
    end else begin
      if ((mask == 1'b0) && (enable == 1'b1)) begin
        next_count = count - 1;
      end
    end
  end

//
// Whenever the configured value is zero then this means that
// the user does not want to have that master masked. It has
// infinite tokens available. This means it should never be
// masked. Generate a signal which overrides the normal
// masking to keep the master free.
//
  assign do_not_mask = (load_val == {`AHB_CCL_WIDTH{1'b0}});

//
// Whenever one is going to load then clear the mask bits
// So that the master is cleared at the start of the arbitration
// period. Subsequently when the counter reaches one, and is
// enabled then the mask bit is set as the master runs out of
// tokens.
//
  // spyglass disable_block FlopEConst
  // SMD : Reports permanently disabled or enabled flip-flop enable pins
  // SJ  : The flip-flop enable signal is generated based on the load value, which is configuration depedent. Hence
  //       the load value may be all zeroes in some configuration, which results in flip-flop enable permanently 
  //       tied to high. But this will not be the case in other configuration. Hence this Lint check can be disabled.
  always @ (posedge hclk or negedge hresetn)
  begin : mask_PROC
    if (hresetn == 1'b0) begin
      mask <= 1'b0;
    end else begin
      if ((load == 1'b1) || (do_not_mask == 1'b1)) begin
        mask <= 1'b0;
      end else begin
        if (next_count == {`AHB_CCL_WIDTH{1'b0}}) begin
          mask <= 1'b1;
        end
      end
    end
  end
  // spyglass enable_block FlopEConst

endmodule
