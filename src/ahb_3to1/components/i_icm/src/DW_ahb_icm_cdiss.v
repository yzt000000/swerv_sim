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
// Revision: $Id: //dwh/DW_ocb/DW_ahb_icm/amba_dev/src/DW_ahb_icm_cdiss.v#9 $ 
// proprietary to Synopsys, Inc.  Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc.
//
// The entire notice above must be reproduced on all authorized copies.
//
// File     : DW_ahb_icm_cdiss.v
// Abstract : Clash detection and input stage selection.
//

module i_icm_DW_ahb_icm_cdiss (
  hclk,
  hresetn,
  bus_cancel_uis,
  bus_hready_l,
  bus_request,
  bus_lock,
  hlayer,
  hready_resp,

  bus_uis
);
  
  input                        hclk;
  input                        hresetn;
  input [`ICM_NUM_LAYERS-1:0]  bus_cancel_uis;
  input [`ICM_NUM_LAYERS-1:0]  bus_request;
  input [`ICM_NUM_LAYERS-1:0]  bus_lock;
  input [`ICM_LAYER_WIDTH-1:0] hlayer;
  input [`ICM_NUM_LAYERS-1:0]  bus_hready_l;
  input                        hready_resp;

  output [`ICM_NUM_LAYERS-1:0] bus_uis;

  reg  [`ICM_NUM_LAYERS-1:0]   max_bus_request;
  reg  [`ICM_NUM_LAYERS-1:0]   max_bus_lock;

//
// Could declare these as lay_hready[`ICM_MAX_LAYERS:1] but for debug purposes each bit is listed seperately.
//

  wire                         lay3_lr;  
  wire  [`ICM_NUM_LAYERS-2:0]  all_lay_lr_3;
  wire                         lay2_lr;   
  wire  [`ICM_NUM_LAYERS-2:0]  all_lay_lr_2;
  wire                         lay1_lr;
  wire  [`ICM_NUM_LAYERS-2:0]  all_lay_lr_1;



  assign all_lay_lr_1 = {lay3_lr,lay2_lr};
  assign all_lay_lr_2 = {lay3_lr,lay1_lr};
  assign all_lay_lr_3 = {lay2_lr,lay1_lr};














//#
//#
//# Want to extract each layers request from the bussed requests
//# (bus_request). Need to expand to the maximum width and then
//# strip off the individual bits. The request is then used in
//# the generation of the layer's use-input-stage (Lx_uis)
//#
// spyglass disable_block W415a
// SMD: Signal may be multiply assigned (beside initialization) in the same scope
// SJ: The design checked and verified that not any one of a single bit of the bus is assigned more than once beside initialization or the multiple assignments are intentional.
  always @(bus_request)
  begin : max_bus_request_PROC
    max_bus_request                      = {`ICM_NUM_LAYERS{1'b0}};
    max_bus_request[`ICM_NUM_LAYERS-1:0] = bus_request;
  end

  always @(bus_lock)
  begin : max_bus_lock_PROC
    max_bus_lock                      = {`ICM_NUM_LAYERS{1'b0}};
    max_bus_lock[`ICM_NUM_LAYERS-1:0] = bus_lock;
  end
// spyglass enable_block W415a


  i_icm_DW_ahb_icm_cdissm
   #( 
    .LAYER_NUM    (1)
  ) U_cdissm_Layer1 (
    .hclk         (hclk),
    .hresetn      (hresetn),
    .cancel_uis   (bus_cancel_uis[0]),
    .lay_hready   (bus_hready_l[0]),
    .lay_request  (max_bus_request[0]),
    .lay_lock     (max_bus_lock[0]),
    .all_lay_lr   (all_lay_lr_1),
    .hlayer       (hlayer),
    .hready_resp  (hready_resp),

    .lay_lr       (lay1_lr),
    .uis          (bus_uis[0])
  );

  i_icm_DW_ahb_icm_cdissm
   #(
    .LAYER_NUM    (2)
  ) U_cdissm_Layer2 (
    .hclk         (hclk),
    .hresetn      (hresetn),
    .cancel_uis   (bus_cancel_uis[1]),
    .lay_hready   (bus_hready_l[1]),
    .lay_request  (max_bus_request[1]),
    .lay_lock     (max_bus_lock[1]),
    .all_lay_lr   (all_lay_lr_2),
    .hlayer       (hlayer),
    .hready_resp  (hready_resp),

    .lay_lr       (lay2_lr),
    .uis          (bus_uis[1])
  );

  i_icm_DW_ahb_icm_cdissm
   #(
    .LAYER_NUM    (3)
  ) U_cdissm_Layer3 (
    .hclk         (hclk),
    .hresetn      (hresetn),
    .cancel_uis   (bus_cancel_uis[2]),
    .lay_hready   (bus_hready_l[2]),
    .lay_request  (max_bus_request[2]),
    .lay_lock     (max_bus_lock[2]),
    .all_lay_lr   (all_lay_lr_3),
    .hlayer       (hlayer),
    .hready_resp  (hready_resp),

    .lay_lr       (lay3_lr),
    .uis          (bus_uis[2])
  );




























endmodule
