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
// File Version     :        $Revision: #12 $ 
// Revision: $Id: //dwh/DW_ocb/DW_ahb_icm/amba_dev/src/DW_ahb_icm_cwsm.v#12 $ 
//
// File     : DW_ahb_icm_cwsm.v
// Abstract : Modular instaniation of the counting of wait states on the hready signal on each layer.
//

//
//
//
//

module i_icm_DW_ahb_icm_cwsm (
  cancel_is,
                        cancel_uis,
                        lay_hready_resp,
                        lay_hresp,
                        hclk,
                        hresetn,
                        hready,
                        uis,
                        hlayer,
                        hlayer_data,
                        hready_resp,
                        hresp,
                        busy
                        );

  parameter       LAYER_NUM     = 1;
  parameter       RELEASE_LAYER = 0;
  parameter       RELEASE_WIDTH = 4;
  parameter [3:0] RELEASE_LIMIT = 15;

//#
//# The following is used for state machines
//#
  parameter ST_NORM   = 2'b00;
  parameter ST_RETRY1 = 2'b01;
  parameter ST_RETRY2 = 2'b10;
  

  output                         cancel_is;
  output                         cancel_uis;
  output                         lay_hready_resp;
  output [`HRESP_WIDTH-1:0]      lay_hresp;
// spyglass disable_block W240
// SMD: Input declared but not used
// SJ: This module is written in a generic way with generate construct. These ports are used configuration specific in the same. No functional issue due to this.
  input                          hclk;
  input                          hresetn;
  input                          hready;
  input                          busy;
// spyglass enable_block W240

  input                          uis;
  input  [`ICM_LAYER_WIDTH-1:0]  hlayer;
  input  [`ICM_LAYER_WIDTH-1:0]  hlayer_data;
  input                          hready_resp;
  input  [`HRESP_WIDTH-1:0]      hresp;

  wire                           exceed_limit;
  wire                           shr;
  wire   [`HRESP_WIDTH-1:0]      slv_hresp;

generate
  if (RELEASE_LAYER == 1) begin : GEN_HRESP
    
    reg    [RELEASE_WIDTH-1:0]     ff_ws_count;
    reg    [RELEASE_WIDTH-1:0]     n_ws_count;
    wire   [RELEASE_WIDTH-1:0]     ws_count;
    reg    [1:0]                   ff_r_st;
    reg                            f_rhr;
    reg    [`HRESP_WIDTH-1:0]      f_rh;
    reg                            ff_cancel_is;
    reg    [1:0]                   n_f_r_st;
    wire                           cancel_retry;


  //#
  //# A counter that keeps track of the number of cycles that hready_resp_Lx is being held low for.
  //# Reset to 0 initially, then takes the next value
  //#
  
  //#
  //# We need to remove the register if the layer is not supporting the release of hready via a RETRY
  //#
    always @(posedge hclk or negedge hresetn)
    begin : ws_count_PROC
      if (hresetn == 1'b0) begin
        ff_ws_count <= {RELEASE_WIDTH{1'b0}};
      end else begin
        ff_ws_count <= n_ws_count;
      end
    end
  
    always @(ws_count or hready or uis or busy
            )
    begin : n_ws_count_PROC
      if (busy == 1'b1) begin
        n_ws_count = {RELEASE_WIDTH{1'b0}};
      end else begin
        if ((hready == 1'b1) || (uis == 1'b0)
            ) begin
          n_ws_count = {RELEASE_WIDTH{1'b0}};
        end else begin
          if (ws_count >= RELEASE_LIMIT) begin
            n_ws_count = ws_count;
          end else begin
            n_ws_count = ws_count + 1;
          end
        end
      end
    end

    
    
    always @(posedge hclk or negedge hresetn)
    begin : ff_r_st_PROC
      if (hresetn == 1'b0) begin
        ff_r_st <= ST_NORM;
      end else begin
        ff_r_st <= n_f_r_st;
      end
    end
  
    always @(posedge hclk or negedge hresetn)
    begin : f_rhr_PROC
      if (hresetn == 1'b0) begin
        f_rhr <= 1'b1;
      end else begin
        f_rhr <= ~(n_f_r_st == ST_RETRY1);
      end
    end
  
  //#
  //# Generating the two-cycle split response.
  //# Requires a hready_resp to pulse low.
  //# Requires a hresp which indicates SPLIT.
  //#
  //#
  //# Only setting bit 1 to a 1 or a 0 as RETRY=2 and OKAY=1
  //# When f_rh is used else where will remove the low bit and assign as 0.
  //#
    always @(posedge hclk or negedge hresetn)
    begin : f_rh_PROC
      if (hresetn == 1'b0) begin
        f_rh <= `OKAY;
      end else begin
        if ((n_f_r_st == ST_RETRY1) ||
            (n_f_r_st == ST_RETRY2)) begin
          f_rh <= `RETRY;
        end else begin
          f_rh <= `OKAY;
        end
      end
    end
  //#
  //# If the limit is reached. Then a retry needs to be generated by the matrix.
  //# If the layer is not capable of releasing the layer the functionality is removed
  //#
  
    always @(exceed_limit or cancel_retry or ff_r_st)
    begin : n_f_r_st_PROC
        case (ff_r_st)
          ST_NORM   : if ((exceed_limit == 1'b1) && (cancel_retry == 1'b0)) begin
                         n_f_r_st = ST_RETRY1;
                       end else begin
                         n_f_r_st = ST_NORM;
                       end
          ST_RETRY1 : n_f_r_st = ST_RETRY2;
          default   : n_f_r_st = ST_NORM;
        endcase
    end
  
  //#
  //# Register the cancel input stage so that after the htrans is cleared then the input stage is cleared.
  //#
    always @(posedge hclk or negedge hresetn)
    begin
      if (hresetn == 1'b0) begin
        ff_cancel_is <= 1'b0;
      end else begin
        ff_cancel_is <= cancel_is;
      end
    end
  
    assign ws_count = ff_ws_count;
  
    assign exceed_limit = (n_ws_count >= RELEASE_LIMIT);
  //#
  //# One cancels the address and control within the input stage, provided there is data in there
  //# Whenever one is given ownership of the slave then clear the input stage when the address and
  //# control data is used. Whenever a layer is held off for too long then it should be retried.
  //#
  
// spyglass disable_block SelfDeterminedExpr-ML
// SMD: Self determined expression found
// SJ: The expression indexing the vector/array will never exceed the bound of the vector/array.
    assign cancel_uis = (uis == 1'b1) && (((hlayer == (LAYER_NUM-1)) && (hready_resp == 1'b1)) || (ff_cancel_is == 1'b1));

    assign cancel_retry = (hready_resp == 1'b1) && (hlayer == (LAYER_NUM-1)) && (exceed_limit == 1'b1);
// spyglass enable_block SelfDeterminedExpr-ML

  //#
  //# The hready_resp for a layer will be the slave hready_resp unless a split is being generated
  //# then the internal generated split-hready_resp is used. o_rlx_r_st will be fixed as
  //# zero(ST_NORM) when there is no need to generate an internal split.
  //#
    assign lay_hresp       = (ff_r_st == ST_NORM) ? slv_hresp : {f_rh[1],1'b0};
    assign lay_hready_resp = (ff_r_st == ST_NORM) ? shr : f_rhr;
    end  
  else begin

    assign exceed_limit = 1'b0;
  
  //#
  //# One cancels the address and control within the input stage, provided there is data in there
  //# Whenever one is given ownership of the slave then clear the input stage when the address and
  //# control data is used. Whenever a layer is held off for too long then it should be retried.
  //#
// spyglass disable_block SelfDeterminedExpr-ML
// SMD: Self determined expression found
// SJ: The expression indexing the vector/array will never exceed the bound of the vector/array.
    assign cancel_uis = (uis == 1'b1) && ((hlayer == (LAYER_NUM-1)) && (hready_resp == 1'b1));
// spyglass enable_block SelfDeterminedExpr-ML
    
  //# The hready_resp for a layer will be the slave hready_resp unless a split is being generated
  //# then the internal generated split-hready_resp is used. o_rlx_r_st will be fixed as
  //# zero(ST_NORM) when there is no need to generate an internal split.
  //#
    assign lay_hresp       = slv_hresp;
  
    assign lay_hready_resp = shr;
  end
endgenerate


//#
//# The next value depends on the value of hready_l.
//# Increments or gets set to zero.
//# Stops incrementing when its limit is reached.
//# Stays at zero unless the matrix is holding off the layer
//#
//#
//# Only when the layer is implemented and also implementing the release of the layer
//# should the counter be instaniated.
//#

  assign cancel_is    = (exceed_limit == 1'b1);

//
// Only when a slave is in control of the data bus for a layer is its hready_resp passed
// back as the hready_resp of the layer. At all other times the response is '1'. The same
// applies for the hresp, where it is always an OKAY response

// spyglass disable_block SelfDeterminedExpr-ML
// SMD: Self determined expression found
// SJ: The expression indexing the vector/array will never exceed the bound of the vector/array.
  assign shr         = (hlayer_data == (LAYER_NUM-1)) ? hready_resp : ~uis;
  assign slv_hresp   = (hlayer_data == (LAYER_NUM-1)) ? hresp : `OKAY;
// spyglass enable_block SelfDeterminedExpr-ML

//#
//# Need to check whether a layer has received a split, a layer can receive multiple splits so one needs to track these.
//#


//#
//# If a layer has not received a split then no split is returned. If masters on two
//# layers have received a split response then both are returned at the same time.
//# There is no indication from the slave as to which layer it wants to release so both
//# have to be released.
//#


endmodule
