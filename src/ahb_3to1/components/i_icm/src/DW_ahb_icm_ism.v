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
// File Version     :        $Revision: #10 $ 
// Revision: $Id: //dwh/DW_ocb/DW_ahb_icm/amba_dev/src/DW_ahb_icm_ism.v#10 $ 
//
// File     : DW_ahb_icm_ism.v
// Abstract : This is the internals of the input stage module
//

module i_icm_DW_ahb_icm_ism (
  lay_hsel,
                       lay_haddr,
                       lay_hsize,
                       lay_hburst,
                       lay_hprot,
                       lay_hwrite,
                       lay_hmastlock,
                       lay_request,
                       lay_lock,
                       lay_busy,
                       lay_htrans_mod,
                       hclk,
                       hresetn,
                       hready,
                       lay_hready_resp,
                       uis,
                       update,
                       cancel,
                       hsel_l,
                       haddr_l,
                       htrans_l,
                       hsize_l,
                       hburst_l,
                       hprot_l,
                       hmastlock_l,
                       hwrite_l
                       );

parameter NUM_HSEL     = `ICM_NUM_HSEL;

  output   [NUM_HSEL-1:0]       lay_hsel;
  output   [`HADDR_WIDTH-1:0]   lay_haddr;
  output   [`HSIZE_WIDTH-1:0]   lay_hsize;
  output   [`HBURST_WIDTH-1:0]  lay_hburst;
  output   [`HPROT_WIDTH-1:0]   lay_hprot;
  output                        lay_hwrite;
  output                        lay_hmastlock;
  output                        lay_request;
  output                        lay_lock;
  output                        lay_busy;
  output   [`HTRANS_WIDTH-1:0]  lay_htrans_mod;

  input                         hclk;
  input                         hresetn;
  input                         hready;
  input                         lay_hready_resp;
  input                         uis;
  input                         update;
  input                         cancel;
  input   [NUM_HSEL-1:0]        hsel_l;
  input   [`HADDR_WIDTH-1:0]    haddr_l;
  input   [`HTRANS_WIDTH-1:0]   htrans_l;
  input   [`HSIZE_WIDTH-1:0]    hsize_l;
  input   [`HBURST_WIDTH-1:0]   hburst_l;
  input   [`HPROT_WIDTH-1:0]    hprot_l;
  input                         hwrite_l;
  input                         hmastlock_l;

  reg    [NUM_HSEL-1:0]         is_hsel;
  reg    [`HADDR_WIDTH-1:0]     is_haddr;
  reg    [`HTRANS_WIDTH-1:0]    is_htrans;
  reg    [`HSIZE_WIDTH-1:0]     is_hsize;
  reg    [`HBURST_WIDTH-1:0]    is_hburst;
  reg    [`HPROT_WIDTH-1:0]     is_hprot;
  reg                           is_hwrite;
  reg                           is_hmastlock;
  wire                          lay_block;
  reg                           active_address;
  wire                          lay_sb;
  wire                          block_layer;
  wire   [`HTRANS_WIDTH-1:0]    lay_htrans;
  wire                          lay_sel;

  always @(posedge hclk or negedge hresetn)
  begin : InputStage_PROC
    if (hresetn == 1'b0) begin
      is_hsel      <= {NUM_HSEL{1'b0}};
      is_haddr     <= {`HADDR_WIDTH{1'b0}};
      is_htrans    <= {`HTRANS_WIDTH{1'b0}};
      is_hsize     <= {`HSIZE_WIDTH{1'b0}};
      is_hburst    <= {`HBURST_WIDTH{1'b0}};
      is_hprot     <= 4'b0011;
      is_hwrite    <= 1'b0;
      is_hmastlock <= 1'b0;
    end else begin
      if (update == 1'b1) begin
        is_hsel      <= hsel_l;
        is_haddr     <= haddr_l;
        is_htrans    <= htrans_l;
        is_hsize     <= hsize_l;
        is_hburst    <= hburst_l;
        is_hprot     <= hprot_l;
        is_hwrite    <= hwrite_l;
        is_hmastlock <= hmastlock_l;
      end else begin    
        if (cancel == 1'b1) begin
          is_htrans <= {`HTRANS_WIDTH{1'b0}}; 
          is_hmastlock <= 1'b0;
        end
      end
    end
  end

  assign lay_hsel      = (uis == 1'b1)? is_hsel      : hsel_l;
  assign lay_haddr     = (uis == 1'b1)? is_haddr     : haddr_l;
  assign lay_htrans    = (uis == 1'b1)? is_htrans    : htrans_l;
  assign lay_hsize     = (uis == 1'b1)? is_hsize     : hsize_l;
  assign lay_hwrite    = (uis == 1'b1)? is_hwrite    : hwrite_l;

//
// Some ports are optional. Therefore there is no need to have an internal
// register for the stored version of the optional control signals
// Only when the layer exists is the input stage ever used.
// By default the signal from the layer is selected when the layer is not used and it is tied to zero.
//

  assign lay_hburst    = (uis == 1'b1)? is_hburst    : hburst_l;
  assign lay_hprot     = (uis == 1'b1)? is_hprot     : hprot_l;
  assign lay_hmastlock = (uis == 1'b1)? is_hmastlock : hmastlock_l;

//
// Whenever the transfer type is IDLE or NONSEQ the arbitration is changed
// unless the master is generating locked transfers when it is held until
// the lock is removed. If there is no lock supported by the slave then
// the control signal is not on the interface and downstream any of the
// connections to the lock signal or its derivatives is to zero.
//

  assign lay_sel        =  lay_hsel;
  assign lay_request    = (((block_layer == 1'b0) && (lay_sel) && (lay_htrans != `IDLE)) 
                          );
  assign lay_block      = ((lay_request && lay_htrans[0])
                          );

  assign lay_lock       = (lay_block || (lay_hmastlock && lay_sel));

  assign lay_busy       = (lay_htrans == `BUSY);
  assign lay_htrans_mod = ((block_layer == 1'b0) && (lay_sel == 1'b1)) ? lay_htrans : `IDLE;
  assign lay_sb         = ((active_address == 1'b0) && (lay_sel == 1'b1) && (hready == 1'b1) && (lay_htrans != `IDLE));
  assign block_layer    = ((active_address == 1'b0) && (lay_sb == 1'b0));

  always @(posedge hclk or negedge hresetn)
  begin : active_address_PROC
    if (!hresetn) begin
       active_address <= 1'b1;
    end else begin
      if (lay_sel == 1'b0) begin
        active_address <= 1'b0;
      end else begin
        if ((lay_htrans != `IDLE) && (hready == 1'b1)) begin
        active_address <= 1'b1;
        end else begin
          if (lay_hready_resp == 1'b1)
            active_address <= 1'b0;
        end
      end
    end
  end

endmodule
