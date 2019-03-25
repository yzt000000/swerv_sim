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
// Revision: $Id: //dwh/DW_ocb/DW_ahb_icm/amba_dev/src/DW_ahb_icm_csg.v#9 $ 
// File     : DW_ahb_icm_csg.v
// Authors  : Peter Gillen
// Date     : $DateTime: 2018/06/22 07:08:01 $
// Abstract : Generates the input hready for the shared slave.
//
//
//
//
//

module i_icm_DW_ahb_icm_csg (
  bus_request,
  hready_resp,
  hlayer,
  bus_uis,
  bus_hready_l,
  bus_cancel_uis,

  hready
);
  input  [`ICM_NUM_LAYERS-1:0]  bus_request;
  input                         hready_resp;
  input  [`ICM_LAYER_WIDTH-1:0] hlayer;
  input  [`ICM_NUM_LAYERS-1:0]  bus_uis;
  input  [`ICM_NUM_LAYERS-1:0]  bus_hready_l;
  input  [`ICM_NUM_LAYERS-1:0]  bus_cancel_uis;

  output                        hready;

  reg    [`ICM_MAX_LAYERS-1:0]  int_hready_l;
  reg    [`ICM_NUM_LAYERS-1:0]  fullbus_request;

  integer                       i;

//
// A slave is held from accepting a new address until the data portion
// of the response is ready to complete. A layer may have another
// command pipelined so the slave is allowed to accept it but the
// layer is not released as it is now in control of the data bus.
// Another layer would have had access to the slave before.
// The same applies to all layers.

// spyglass disable_block W415a
// SMD: Signal may be multiply assigned (beside initialization) in the same scope
// SJ: The design checked and verified that not any one of a single bit of the bus is assigned more than once beside initialization or the multiple assignments are intentional.
  always @(bus_request)
  begin : fullbus_request_PROC
    fullbus_request = {(`ICM_NUM_LAYERS){1'b0}};
    fullbus_request[`ICM_NUM_LAYERS-1:0] = bus_request[`ICM_NUM_LAYERS-1:0];
  end
  
  always @( bus_uis or bus_hready_l or hready_resp or bus_cancel_uis or fullbus_request)
  begin : int_hready_l_PROC
  int_hready_l = {(`ICM_MAX_LAYERS){1'b0}};
    for (i = 0; i < `ICM_NUM_LAYERS; i = i + 1) begin
      if ( bus_uis[i] == 1'b0 ) begin
        if (hready_resp == 1'b0)
          int_hready_l[i] = 1'b0;
        else
          int_hready_l[i] = (fullbus_request[i] == 1'b0) || (bus_hready_l[i] == 1'b1);
      end else begin
        if ( ( hready_resp == 1'b1 ) &&
            ( bus_cancel_uis[i] == 1'b1 ) ) begin
          int_hready_l[i] = 1'b1;
        end else begin
          int_hready_l[i] = 1'b0;
        end
      end
    end
  end
// spyglass enable_block W415a

// Both are zero or both are 1
//  assign hready =  int_hready_l[hlayer_data] && int_hready_l[hlayer];
  assign hready =  int_hready_l[hlayer];

endmodule
