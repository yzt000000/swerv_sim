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
// Revision: $Id: //dwh/DW_ocb/DW_ahb_icm/amba_dev/src/DW_ahb_icm_cdissm.v#9 $ 
// proprietary to Synopsys, Inc.  Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc.
//
// The entire notice above must be reproduced on all authorized copies.
//
// File     : DW_ahb_icm_cdissm.v
// Abstract : Clash detection and input stage selection in modular form.
//

module i_icm_DW_ahb_icm_cdissm (

  hclk,
  hresetn,

  cancel_uis,
  lay_hready,
  lay_request,
  lay_lock,
  all_lay_lr,
  hlayer,
  hready_resp,

  lay_lr,
  uis
);

  parameter LAYER_NUM       = 1;

  input                        hclk;
  input                        hresetn;
  input [`ICM_NUM_LAYERS-2:0]  all_lay_lr;
  input                        cancel_uis;
  input                        lay_hready;
  input                        lay_request;
  input                        lay_lock;
  input [`ICM_LAYER_WIDTH-1:0] hlayer;
  input                        hready_resp;

  output                       lay_lr;
  output                       uis;

// f_uis  : Registered version of use input stage for layer.

  reg                          f_uis;

  wire                         int_f_uis;
  wire                         lay_request; // Layer request
  wire                         lay_lock;    // Layer lock
  wire                         l_clash;   // Clash on layer
  wire                         l_set;     // Set use input stage

//#
//# Provided the layer exists then pass on the lock and request.
//# A combined lock and request is passed out to other module for them to detect clash in requests
//# This is made up of all_lay_lr which will have all the lock or requests for all other 
//# layers.
//#
  assign lay_lr    = lay_request || lay_lock;

  assign l_clash   = lay_lr && (|all_lay_lr) && (lay_hready);

//
// When a layer is requesting for access to the slave, there may be
// a clash with another layer. The winning layer is allowed to complete
// its access to the slave and the other requesting layers are each
// held off. 
// 

// spyglass disable_block SelfDeterminedExpr-ML
// SMD: Self determined expression found
// SJ: The expression indexing the vector/array will never exceed the bound of the vector/array.
  assign l_set = ((hlayer == (LAYER_NUM-1)) && (lay_request == 1'b1) && (lay_hready == 1'b1) && (hready_resp == 1'b0));
// spyglass enable_block SelfDeterminedExpr-ML

//
// There are a number of ways to use the input stage.
// One uses the input stage when there is a clash between layers and the losing
// layer has the address and control transferred into the input stage.
// If there is no clash then when the slave is not ready the layer may be ready
// in such case the address and control needs to be passed into the input stage.
// Once there is data in the inpout stage it is kept and the layer is held off
// until the data in the input stage is used or cancelled.
// One cancels the data when a layer is held for too long and a retry is issued
// to the layer allowing a higher priority master to gain access to the DW_ahb
// bus.
//
// The same principle applies to all layers.
//

  assign int_f_uis = f_uis;

// spyglass disable_block STARC05-2.11.3.1
// SMD: Ensure that the sequential and combinational parts of an FSM description should be in separate always blocks. (Verilog)
// SJ: No functional, This rule is for better readability purpose, this is intentiionally written.
  always @(posedge hclk or negedge hresetn)
  begin : f_uis_PROC
    if (hresetn == 1'b0) begin
      f_uis <= 1'b0;
    end else begin
      if (cancel_uis == 1'b1) begin
        f_uis <= 1'b0;
      end else begin
        if (f_uis == 1'b1) begin
          f_uis <= int_f_uis;
        end else begin
// spyglass disable_block SelfDeterminedExpr-ML
// SMD: Self determined expression found
// SJ: The expression indexing the vector/array will never exceed the bound of the vector/array.
          if ((hlayer != (LAYER_NUM -1)) && (l_clash == 1'b1) && (lay_request == 1'b1)) begin
// spyglass enable_block SelfDeterminedExpr-ML
            f_uis <= 1'b1;
          end else begin
            if (l_set == 1'b1) begin
              f_uis <= 1'b1;
            end
          end
        end
      end
    end
  end
// spyglass enable_block STARC05-2.11.3.1

  assign uis = f_uis;

endmodule
