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
// Revision: $Id: //dwh/DW_ocb/DW_ahb_icm/amba_dev/src/DW_ahb_icm_hld.v#8 $ 
//
// File     : DW_ahb_icm_hld.v
// Authors  : Peter Gillen
// Date     : $Date: 2018/06/22 $
// Abstract : Holds onto the current owner of the data bus.
//
//
//
//
//

module i_icm_DW_ahb_icm_hld (
  hclk,
  hresetn,
  bus_hlayer,
  hready_resp,

  hlayer,
  hlayer_data
);

  input                         hclk;
  input                         hresetn;
  input  [`ICM_NUM_LAYERS-1:0]  bus_hlayer;
  input                         hready_resp;

  output [`ICM_LAYER_WIDTH-1:0] hlayer;
  output [`ICM_LAYER_WIDTH-1:0] hlayer_data;
  
  reg    [`ICM_LAYER_WIDTH-1:0] hlayer;
  reg    [`ICM_LAYER_WIDTH-1:0] hlayer_data;
  reg    [`ICM_MAX_LAYERS-1:0]  max_bus_hlayer;

//
// The incoming bus (bus_hlayer) can vary in width and rather
// than tracking the width and adjusting the output width
// the output hlayer width is kept at `ICM_LAYER_WIDTH bits wide.
// Therefore one needs to take the narrow bus and expand to 
// the maximum width. Using this expanded bus to generate
// the index for which layer has access to the bus.
//
// spyglass disable_block W415a
// SMD: Signal may be multiply assigned (beside initialization) in the same scope
// SJ: The design checked and verified that not any one of a single bit of the bus is assigned more than once beside initialization or the multiple assignments are intentional.
  always @(bus_hlayer)
  begin : max_bus_hlayer_PROC
    max_bus_hlayer = {`ICM_MAX_LAYERS{1'b0}};
    max_bus_hlayer[`ICM_NUM_LAYERS-1:0] = bus_hlayer;
  end
// spyglass enable_block W415a

  always @(max_bus_hlayer)
  begin : hlayer_PROC
    case (max_bus_hlayer)
      16'b1000000000000000 : hlayer = `ICM_LAYER_SIXTEEN_NUM;
      16'b0100000000000000 : hlayer = `ICM_LAYER_FIFTEEN_NUM;
      16'b0010000000000000 : hlayer = `ICM_LAYER_FOURTEEN_NUM;
      16'b0001000000000000 : hlayer = `ICM_LAYER_THIRTEEN_NUM;
      16'b0000100000000000 : hlayer = `ICM_LAYER_TWELVE_NUM;
      16'b0000010000000000 : hlayer = `ICM_LAYER_ELEVEN_NUM;
      16'b0000001000000000 : hlayer = `ICM_LAYER_TEN_NUM;
      16'b0000000100000000 : hlayer = `ICM_LAYER_NINE_NUM;
      16'b0000000010000000 : hlayer = `ICM_LAYER_EIGHT_NUM;
      16'b0000000001000000 : hlayer = `ICM_LAYER_SEVEN_NUM;
      16'b0000000000100000 : hlayer = `ICM_LAYER_SIX_NUM;
      16'b0000000000010000 : hlayer = `ICM_LAYER_FIVE_NUM;
      16'b0000000000001000 : hlayer = `ICM_LAYER_FOUR_NUM;
      16'b0000000000000100 : hlayer = `ICM_LAYER_THREE_NUM;
      16'b0000000000000010 : hlayer = `ICM_LAYER_TWO_NUM;
      default     : hlayer = `ICM_LAYER_ONE_NUM;
    endcase
  end

//
// The current layer which is the owner of the address and control bus
// will be the next owner of the data bus whenever the address and control 
// is passed to the slave. Who this layer is needs to be preserved so that
// the correct read/write data can be passed from/to the slave to/from the
// master who drove the address and control onto the layer.
//

  always @(posedge hclk or negedge hresetn)
  begin : hlayer_data_PROC
    if (hresetn == 1'b0) begin
      hlayer_data <= `ICM_LAYER_ONE_NUM;
    end else begin
      if (hready_resp == 1'b1) begin
        hlayer_data <= hlayer;
      end
    end
  end

endmodule
