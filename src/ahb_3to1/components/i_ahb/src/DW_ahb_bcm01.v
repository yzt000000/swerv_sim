
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
// Filename    : DW_ahb_bcm01.v
// Revision    : $Id: //dwh/DW_ocb/DW_ahb/amba_dev/src/DW_ahb_bcm01.v#8 $
// Author      : Rick Kelly     May 18, 2004
// Description : DW_ahb_bcm01.v Verilog module for DW_ahb
//
// DesignWare IP ID: f543d40e
//
////////////////////////////////////////////////////////////////////////////////


  module i_ahb_DW_ahb_bcm01 (
      // Inputs
        a,
        tc,
        min_max,
      // Outputs
        value,
        index
);

parameter WIDTH =               4;      // element WIDTH
parameter NUM_INPUTS =          8;      // number of elements in input array
parameter INDEX_WIDTH =         3;      // size of index pointer = ceil(log2(NUM_INPUTS))

localparam [INDEX_WIDTH : 0] NUM_INPUTS_LOG2 = 1 << (INDEX_WIDTH);

input  [NUM_INPUTS*WIDTH-1 : 0]         a;      // Concatenated input vector
input                                   tc;     // 0 = unsigned, 1 = signed
input                                   min_max;// 0 = find min, 1 = find max
output [WIDTH-1:0]                      value;  // mon or max value found
output [INDEX_WIDTH-1:0]                index;  // index to value found


wire   [NUM_INPUTS*WIDTH-1 : 0]         a_uns, a_trans;
reg    [WIDTH-1:0]                      val_int;
wire   [WIDTH-1:0]                      val_trans;
reg    [INDEX_WIDTH-1:0]                indx_int;


generate
  if (WIDTH == 1) begin : GEN_W_EQ1
    assign a_uns = a ^ {NUM_INPUTS{tc}};
    assign value = val_trans ^ tc;
  end else begin : GEN_W_GT1
    assign a_uns = a ^ { NUM_INPUTS { tc, { WIDTH-1 {1'b0}}}};
    assign value = val_trans ^ { tc, { WIDTH-1 {1'b0}}};
  end
endgenerate

  assign a_trans = a_uns;

// spyglass disable_block W415a
// SMD: Signal may be multiply assigned (beside initialization) in the same scope
// SJ: The design checked and verified that not any one of a single bit of the bus is assigned more than once beside initialization or the multiple assignments are intentional.
// spyglass disable_block SelfDeterminedExpr-ML
// SMD: Self determined expression found
// SJ: The expression indexing the vector/array will never exceed the bound of the vector/array.
  always @ (a_trans or min_max) begin : find_minmax_PROC
      reg    [WIDTH-1:0]        val_1, val_2;
      reg    [INDEX_WIDTH-1 : 0]        indx_1, indx_2;
      reg    [( (2 << INDEX_WIDTH)-1)*WIDTH-1 : 0]       val_array;
      reg    [( (2 << INDEX_WIDTH)-1)*INDEX_WIDTH-1:0] indx_array;
      integer           i, j, k, l, m, n;

    i = 0;
    j = 0;
    val_array = {( (2 << INDEX_WIDTH)-1)*WIDTH{1'b0}};
    indx_array = {( (2 << INDEX_WIDTH)-1)*INDEX_WIDTH{1'b0}};
    for (n=0 ; n<NUM_INPUTS ; n=n+1) begin
      for (m=0 ; m<WIDTH ; m=m+1) 
        val_array[i+m] = a_trans[i+m];

      for (m=0;m<INDEX_WIDTH;m=m+1) indx_array[ m + j ] = (((n>>m)&1)!=0)?1'b1:1'b0;

      i = i + WIDTH;
      j = j + INDEX_WIDTH;
    end

    for (n=NUM_INPUTS ; n<(1 << INDEX_WIDTH) ; n=n+1) begin
      for (m=0 ; m<WIDTH ; m=m+1) 
        val_array[i+m] = val_array[(NUM_INPUTS-1)*WIDTH+m];

      for (m=0 ; m < INDEX_WIDTH ; m=m+1)
        indx_array[j+m] = indx_array[(NUM_INPUTS-1)*INDEX_WIDTH+m];

      i = i + WIDTH;
      j = j + INDEX_WIDTH;      
    end

    k = 0;
    l = 0;
    for (n=0 ; n < (1 << (INDEX_WIDTH-1))*2-1 ; n=n+1) begin
      
      for (m=0 ; m<WIDTH ; m=m+1) begin
          val_1[m] = val_array[k+m];
      end
      
      for (m=0 ; m<INDEX_WIDTH ; m=m+1) begin
          indx_1[m] = indx_array[l+m];
      end

      k = k + WIDTH;
      l = l + INDEX_WIDTH;
      
      for (m=0 ; m<WIDTH ; m=m+1) begin
          val_2[m] = val_array[k+m];
      end 

      for (m=0 ; m<INDEX_WIDTH ; m=m+1) begin
          indx_2[m] = indx_array[l+m];
      end

      k = k + WIDTH;
      l = l + INDEX_WIDTH;

      if (((min_max==1'b1) && (val_1 > val_2)) || ((min_max==1'b0) && (val_1 <= val_2))) begin
        for (m=0 ; m<WIDTH ; m=m+1)
          val_array[i+m] = val_1[m];
        
        for (m=0 ; m<INDEX_WIDTH ; m=m+1)
          indx_array[j+m] = indx_1[m];

      end else begin
        for (m=0 ; m<WIDTH ; m=m+1)
          val_array[i+m] = val_2[m];
        
        for (m=0 ; m<INDEX_WIDTH ; m=m+1)
          indx_array[j+m] = indx_2[m];

      end

      i = i + WIDTH;
      j = j + INDEX_WIDTH;
    end


    for (m=0 ; m < WIDTH ; m=m+1)
      val_int[m] = val_array[k+m];
    
    for (m=0 ; m < INDEX_WIDTH ; m=m+1)
      indx_int[m] = indx_array[l+m];
    
  end
// spyglass enable_block W415a
// spyglass enable_block SelfDeterminedExpr-ML

  assign val_trans = val_int;
  assign index = indx_int;


endmodule
