
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
// Filename    : DW_ahb_icm_bcm02.v
// Revision    : $Id: //dwh/DW_ocb/DW_ahb_icm/amba_dev/src/DW_ahb_icm_bcm02.v#10 $
// Author      : Rick Kelly 10/7/04
// Description : DW_ahb_icm_bcm02.v Verilog module for DW_ahb_icm
//
// DesignWare IP ID: e4009ac3
//
////////////////////////////////////////////////////////////////////////////////



module i_icm_DW_ahb_icm_bcm02(
        a,
        sel,
        mux
        );

   parameter    A_WIDTH    = 8;  // width of input array
   parameter    SEL_WIDTH  = 2;  // width of selection index
   parameter    MUX_WIDTH  = 2;  // width of selected output
   
   input [A_WIDTH-1:0] a;       // input array to select from
   input [SEL_WIDTH-1:0] sel;   // selection index

   output [MUX_WIDTH-1:0] mux;  // selected output
   reg    [MUX_WIDTH-1:0] mux;

   // Selects one of N equal sized subsections of an
   // input vector to the specified output.
   
  always @ (a or sel) begin : mux_PROC 
    integer     mxny_i, mxny_j, mxny_k;
      mux = {MUX_WIDTH {1'b0}};
      mxny_j = 0;
      mxny_k = 0;   // Temporary fix for a Leda issue
      for (mxny_i=0 ; mxny_i<A_WIDTH/MUX_WIDTH ; mxny_i=mxny_i+1) begin
        if ($unsigned(mxny_i) == sel) begin
          for (mxny_k=0 ; mxny_k<MUX_WIDTH ; mxny_k=mxny_k+1) begin
// spyglass disable_block W415a
// SMD: Signal may be multiply assigned (beside initialization) in the same scope
// SJ: The design checked and verified that not any one of a single bit of the bus is assigned more than once beside initialization or the multiple assignments are intentional.
// spyglass disable_block SelfDeterminedExpr-ML
// SMD: Self determined expression found
// SJ: The expression indexing the vector/array will never exceed the bound of the vector/array.
            mux[mxny_k] = a[mxny_j + mxny_k];
// spyglass enable_block W415a
// spyglass enable_block SelfDeterminedExpr-ML
          end // for (mxny_k
        end // if
        mxny_j = mxny_j + MUX_WIDTH;
      end // for (mxny_i
  end

endmodule
