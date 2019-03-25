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
// File Version     :        $Revision: #3 $ 
// Revision: $Id: //dwh/DW_ocb/DW_ahb_icm/amba_dev/src/DW_ahb_icm_pm.v#3 $ 
// File     : DW_ahb_icm_pm.v
// Abstract : This module is used to provide the Common slave access to only one high priority AHB Layer 
// and to mask subsequent requests to the common slave by other AHB Layers until the current transaction
// is complete
//
module i_icm_DW_ahb_icm_pm (

  hclk,
  hresetn,
  // Inputs
  htrans,
  hready,
  hresp,
  bus_hlayer,
  cancel_is,
  bus_request,
  // Outputs
  lay_req_ext,
  bus_mask
);

  input                         hclk;
  input                         hresetn;

  input [`HTRANS_WIDTH-1:0]     htrans;
  input                         hready;
  input [`HRESP_WIDTH-1:0]      hresp;
  input [`ICM_NUM_LAYERS-1:0]   bus_hlayer;
  input [`ICM_NUM_LAYERS-1:0]   cancel_is;
  input [`ICM_NUM_LAYERS-1:0]   bus_request;

  output [`ICM_NUM_LAYERS-1:0]  bus_mask;
  output [`ICM_NUM_LAYERS-1:0]  lay_req_ext;

  reg   [`ICM_NUM_LAYERS-1:0]   bus_mask_r;
  reg   [`ICM_NUM_LAYERS-1:0]   lay_req_mask_r;
  reg   [`ICM_NUM_LAYERS-1:0]   lay_req_ext_r;

//----------------------------------------------------------------------------------------------
// The MASK_PRIORITY_PROC is used to generate the Mask to disable the bus grant i.e. to mask the 
// common slave access under following special conditions:
// 1. When a previous transaction is in progress i.e. only address phase in complete and data
// phase is in progress and 
// 3. The next high priority AHB Layer is granted with the common slave access at re-arbitration
// point and 
// 4. Again there is a request by High priority AHB Layer.
// This module generates bus mask (for all other AHB Layers) when granting the access to first 
// high priority AHB Layer (in step 3) and removes the mask when either previous transaction is 
// complete or transaction corresponding to layer is removed from the input stage 
//----------------------------------------------------------------------------------------------
  always @(posedge hclk or negedge hresetn)
  begin : MASK_PRIORITY_PROC
    if (!hresetn) begin
      bus_mask_r <= {`ICM_NUM_LAYERS{1'b0}};
    end else begin
      if (bus_mask_r == {`ICM_NUM_LAYERS{1'b0}}) begin
        if ((htrans == 2'h2) && (!hready) && (!(|(bus_hlayer & cancel_is[`ICM_NUM_LAYERS-1:0]))))
          bus_mask_r <= ~(bus_hlayer & bus_request);
      end else begin
        if (hready)
          bus_mask_r <= {`ICM_NUM_LAYERS{1'b0}};
        else if (|(~bus_mask_r & cancel_is[`ICM_NUM_LAYERS-1:0]))
          bus_mask_r <= {`ICM_NUM_LAYERS{1'b0}};
      end
    end
  end

  assign bus_mask = bus_mask_r | lay_req_mask_r;

//----------------------------------------------------------------------------------------------
// The MASK_LAYER_REQ_PROC is used for extending the Layer request to retain the arbitration to
// the same layer during the second cycle of the ERROR, RETRY, and SPLIT responce, by masking 
// the requests from other AHB Layers.
//----------------------------------------------------------------------------------------------      
  always @(posedge hclk or negedge hresetn)
  begin : MASK_LAYER_REQ_PROC
    if (!hresetn) begin
      lay_req_mask_r <= {`ICM_NUM_LAYERS{1'b0}};
    end else begin
      if (!hready) begin
        if ((hresp == 2'h1) 
            ) begin
          lay_req_mask_r <= ~bus_hlayer;
        end else begin
          lay_req_mask_r <= {`ICM_NUM_LAYERS{1'b0}};
        end          
      end else begin
        lay_req_mask_r <= {`ICM_NUM_LAYERS{1'b0}};
      end
    end
  end  

//----------------------------------------------------------------------------------------------
// The EXT_LAYER_REQ_PROC is used for extending the Layer request to retain the arbitration to
// the same layer during the second cycle of the ERROR, RETRY, and SPLIT responce.
//----------------------------------------------------------------------------------------------      
  always @(posedge hclk or negedge hresetn)
  begin : EXT_LAYER_REQ_PROC
    if (!hresetn) begin
      lay_req_ext_r <= {`ICM_NUM_LAYERS{1'b0}};
    end else begin
      if (!hready) begin
        if ((hresp == 2'h1) 
            ) begin
          lay_req_ext_r <= bus_hlayer;
        end else begin
          lay_req_ext_r <= {`ICM_NUM_LAYERS{1'b0}};
        end          
      end else begin
        lay_req_ext_r <= {`ICM_NUM_LAYERS{1'b0}};
      end
    end
  end  

  assign lay_req_ext = lay_req_ext_r;

endmodule
