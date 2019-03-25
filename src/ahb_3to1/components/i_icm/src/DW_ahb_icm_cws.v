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
// File Version     :        $Revision: #9 $ 
// Revision: $Id: //dwh/DW_ocb/DW_ahb_icm/amba_dev/src/DW_ahb_icm_cws.v#9 $ 
//
// File     : DW_ahb_icm_cws.v
// Authors  : Peter Gillen
// Date     : $DateTime: 2018/06/22 07:08:01 $
// Abstract : Count Wait States on the hready_Lx signal.
//
//
//
//
//

module i_icm_DW_ahb_icm_cws (

  hclk,
                       hresetn,
                       bus_hready_l,
                       bus_uis,
                       hlayer,
                       hlayer_data,
                       hready_resp,
                       hresp,
                       bus_busy,
                       hready_resp_l1,
                       hresp_l1,
                       hready_resp_l2,
                       hresp_l2,
                       hready_resp_l3,
                       hresp_l3,
                       bus_cancel_uis,
                       cancel_is
                       );

  input                         hclk;
  input                         hresetn;
  input  [`ICM_NUM_LAYERS-1:0]  bus_hready_l;
  input  [`ICM_NUM_LAYERS-1:0]  bus_uis;
  input  [`ICM_LAYER_WIDTH-1:0] hlayer;
  input  [`ICM_LAYER_WIDTH-1:0] hlayer_data;
  input                         hready_resp;
  input  [`HRESP_WIDTH-1:0]     hresp;
  input  [`ICM_NUM_LAYERS-1:0]  bus_busy;

  output [`ICM_NUM_LAYERS-1:0]  bus_cancel_uis;
  output [`ICM_NUM_LAYERS-1:0]  cancel_is;
  output                        hready_resp_l1;
  output [`HRESP_WIDTH-1:0]     hresp_l1;
  output                        hready_resp_l2;
  output [`HRESP_WIDTH-1:0]     hresp_l2;
  output                        hready_resp_l3;
  output [`HRESP_WIDTH-1:0]     hresp_l3;



  reg  [`ICM_NUM_LAYERS-1:0] combined_busy;

//#
//# bus_busy is not the maximum width, the combined_busy is the max width.
//#
// spyglass disable_block W415a
// SMD: Signal may be multiply assigned (beside initialization) in the same scope
// SJ: The design checked and verified that not any one of a single bit of the bus is assigned more than once beside initialization or the multiple assignments are intentional.
  always @(bus_busy)
  begin : bus_busy_PROC
    combined_busy = {(`ICM_NUM_LAYERS){1'b0}};
    combined_busy[`ICM_NUM_LAYERS-1:0] = bus_busy;
  end
// spyglass enable_block W415a

//#
//# Extract from the bus the individual signals for use input stage and
//# layer ready.
//#


//#
//# 
//#
  i_icm_DW_ahb_icm_cwsm
   #(
    .LAYER_NUM       (1),
    .RELEASE_LAYER   (`ICM_RELEASE_L1),
    .RELEASE_WIDTH   (`ICM_RWIDTH_L1),
    .RELEASE_LIMIT   (`ICM_RLIMIT_L1))
   U_cwsm_Layer1 (
    .cancel_is(cancel_is[0]),
                  .cancel_uis(bus_cancel_uis[0]),
                  .lay_hready_resp(hready_resp_l1),
                  .lay_hresp(hresp_l1),
                  .hclk(hclk),
                  .hresetn(hresetn),
                  .hready(bus_hready_l[0]),
                  .uis(bus_uis[0]),
                  .hlayer(hlayer),
                  .hlayer_data(hlayer_data),
                  .hready_resp(hready_resp),
                  .hresp(hresp),
                  .busy(combined_busy[0])
                  );

//#
//# 
//#
  i_icm_DW_ahb_icm_cwsm
   #( 
    .LAYER_NUM       (2),
    .RELEASE_LAYER   (`ICM_RELEASE_L2),
    .RELEASE_WIDTH   (`ICM_RWIDTH_L2),
    .RELEASE_LIMIT   (`ICM_RLIMIT_L2))
   U_cwsm_Layer2 (
    .cancel_is(cancel_is[1]),
                  .cancel_uis(bus_cancel_uis[1]),
                  .lay_hready_resp(hready_resp_l2),
                  .lay_hresp(hresp_l2),
                  .hclk(hclk),
                  .hresetn(hresetn),
                  .hready(bus_hready_l[1]),
                  .uis(bus_uis[1]),
                  .hlayer(hlayer),
                  .hlayer_data(hlayer_data),
                  .hready_resp(hready_resp),
                  .hresp(hresp),
                  .busy(combined_busy[1])
                  );

//#
//# 
//#
  i_icm_DW_ahb_icm_cwsm
   #( 
    .LAYER_NUM       (3),
    .RELEASE_LAYER   (`ICM_RELEASE_L3),
    .RELEASE_WIDTH   (`ICM_RWIDTH_L3),
    .RELEASE_LIMIT   (`ICM_RLIMIT_L3))
   U_cwsm_Layer3 (
    .cancel_is(cancel_is[2]),
                  .cancel_uis(bus_cancel_uis[2]),
                  .lay_hready_resp(hready_resp_l3),
                  .lay_hresp(hresp_l3),
                  .hclk(hclk),
                  .hresetn(hresetn),
                  .hready(bus_hready_l[2]),
                  .uis(bus_uis[2]),
                  .hlayer(hlayer),
                  .hlayer_data(hlayer_data),
                  .hready_resp(hready_resp),
                  .hresp(hresp),
                  .busy(combined_busy[2])
                  );


//#
//# 
//#



























//#
//# Need to see know who is the owner of the data bus
//#

endmodule
