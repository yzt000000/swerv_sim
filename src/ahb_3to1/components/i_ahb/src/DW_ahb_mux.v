/*
------------------------------------------------------------------------
--
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
// Release version :  2.14a
// File Version     :        $Revision: #8 $ 
// Revision: $Id: //dwh/DW_ocb/DW_ahb/amba_dev/src/DW_ahb_mux.v#8 $ 
--
-- File :                       DW_ahb_mux.v
-- Date :                       $Date: 2018/06/22 $ 
-- Abstract     :
--
-- This block multiplexes Address, Control and Write Data from Masters
-- to Slaves. It also multiplexes Readback Data and Transfer Response 
-- information from Slaves to Masters. Instantiates the DW_ahb_bcm02
-- block to carry out the multiplexing of the address and control 
-- signals from the masters to the slaves. 
--
------------------------------------------------------------------------
*/

module i_ahb_DW_ahb_mux (
  hclk,
                   hresetn,
                   bus_haddr,
                   bus_hburst,
                   bus_hprot,
                   bus_hsize,
                   bus_htrans,
                   bus_hwdata,
                   bus_hwrite,
                   hrdata_none,
                   hready_resp_none,
                   hresp_none,
                   bus_hready,
                   bus_hresp,
                   bus_hrdata,
                   hsel,
                   hmaster_data,
                   haddr,
                   hburst,
                   hprot,
                   hsize,
                   htrans, 
                   hwdata,
                   hwrite,
                   hrdata,
                   hready,
                   hresp
                   );

  // physical parameters

  // derived parameters
  parameter ADDRBUS_WIDTH = (`NUM_AHB_MASTERS+1)*`HADDR_WIDTH;
  parameter DATABUS_WIDTH = (`NUM_INT_MASTERS)*`AHB_DATA_WIDTH;
  parameter HRDATABUS_WIDTH = (`NUM_INT_SLAVES)*`AHB_DATA_WIDTH;

  input                          hclk;
  input                          hresetn;

// Aggregated bus of all haddr signals from masters
  input [ADDRBUS_WIDTH-1:0]     bus_haddr;
// Aggregated bus of all hburst signals from masters
  input [`HBURSTBUS_WIDTH-1:0]   bus_hburst;
// AMBA Bus showing index of current bus master
// Aggregated bus of all hprot signals from masters
  input [`HPROTBUS_WIDTH-1:0]    bus_hprot;
// Aggregated bus of all hsize signals from masters
  input [`HSIZEBUS_WIDTH-1:0]    bus_hsize;
// Aggregated bus of all htrans signals from masters
  input [`HTRANSBUS_WIDTH-1:0]   bus_htrans;
// Aggregated bus of all hwdata signals from masters
  input [DATABUS_WIDTH-1:0]     bus_hwdata;
// Aggregated bus of all hwrite signals from masters
  input [`HWRITEBUS_WIDTH-1:0]   bus_hwrite;
// Read Data from Default Slave
  input [`AHB_DATA_WIDTH-1:0]    hrdata_none;
// Bussed hrdata signals from slaves
  input [HRDATABUS_WIDTH-1:0]   bus_hrdata;
// Transfer Response from Default Slave
  input                          hready_resp_none;
  input [`HRESP_WIDTH-1:0]       hresp_none;
// Bussed hready_resp signals from slaves
  input [`HREADY_WIDTH-1:0]      bus_hready;
// Bussed hresp signals from slaves
  input [`HRESPBUS_WIDTH-1:0]    bus_hresp;


// Bussed slave select signals
  input [`NUM_IAHB_SLAVES:0]      hsel;

// Address bus muxed to slaves
  output [`HADDR_WIDTH-1:0]      haddr;
// Burst type bus muxed to slaves
  output [`HBURST_WIDTH-1:0]     hburst;
// Protection info muxed to slaves
  output [`HPROT_WIDTH-1:0]      hprot;
// Size bus muxed to slaves
  output [`HSIZE_WIDTH-1:0]      hsize;
// Transfer type bus muxed to slaves
  output [`HTRANS_WIDTH-1:0]     htrans;
// Write Data bus muxed to slaves
  output [`AHB_DATA_WIDTH-1:0]   hwdata;
// Read/Write signal muxed to slaves
  output                         hwrite;
// Bus showing current owner of system Data Bus
  output [`HMASTER_WIDTH-1:0]    hmaster_data;
// Readback data muxed to masters
  output [`AHB_DATA_WIDTH-1:0]   hrdata;
// Transfer Response signal muxed to masters
  output                         hready;
// Transfer Response bus muxed to masters
  output [`HRESP_WIDTH-1:0]      hresp;

  reg                            hready;
  reg [`AHB_DATA_WIDTH-1:0]      hrdata;
  reg [`HRESP_WIDTH-1:0]         hresp;

// Registered version of hmaster
  wire [`HMASTER_WIDTH-1:0]      ihmaster;
// Registered version of HSEL select lines
  reg [`NUM_IAHB_SLAVES:0]       hsel_prev;


// Loop counters
   integer                        j;
   integer                        c;

//
// Instantiate Address and Control multiplexors
//

  i_ahb_DW_ahb_bcm02
   #(
    .A_WIDTH   (ADDRBUS_WIDTH),
    .SEL_WIDTH (`HMASTER_WIDTH),
    .MUX_WIDTH (`HADDR_WIDTH)
  ) U_a 
  (
    .a   (bus_haddr),
    .sel (ihmaster),
    .mux (haddr)
  );

  i_ahb_DW_ahb_bcm02
   #(
    .A_WIDTH   (`HTRANSBUS_WIDTH),
    .SEL_WIDTH (`HMASTER_WIDTH),
    .MUX_WIDTH (`HTRANS_WIDTH)
  ) U_t 
  (
    .a   (bus_htrans),
    .sel (ihmaster),
    .mux (htrans)
  );

  i_ahb_DW_ahb_bcm02
   #(
    .A_WIDTH   (`HBURSTBUS_WIDTH),
    .SEL_WIDTH (`HMASTER_WIDTH),
    .MUX_WIDTH (`HBURST_WIDTH)
  ) U_b 
  (
    .a   (bus_hburst),
    .sel (ihmaster),
    .mux (hburst)
  );


  i_ahb_DW_ahb_bcm02
   #(
    .A_WIDTH   (`HSIZEBUS_WIDTH),
    .SEL_WIDTH (`HMASTER_WIDTH),
    .MUX_WIDTH (`HSIZE_WIDTH)
  ) U_s 
  (
    .a   (bus_hsize),
    .sel (ihmaster),
    .mux (hsize)
  );

  i_ahb_DW_ahb_bcm02
   #(
    .A_WIDTH   (`HPROTBUS_WIDTH),
    .SEL_WIDTH (`HMASTER_WIDTH),
    .MUX_WIDTH (`HPROT_WIDTH)
  ) U_p 
  (
    .a   (bus_hprot),
    .sel (ihmaster),
    .mux (hprot)
  );

  i_ahb_DW_ahb_bcm02
   #(
    .A_WIDTH   (`HWRITEBUS_WIDTH),
    .SEL_WIDTH (`HMASTER_WIDTH),
    .MUX_WIDTH (1)
  ) U_hw 
  (
    .a   (bus_hwrite),
    .sel (ihmaster),
    .mux (hwrite)
  );

//
// WriteData Mux (controlling hwdata).  This uses a registered version 
// of hmaster, as the address phase and data phases are not aligned, the
// address phase could be with a different master
//

  i_ahb_DW_ahb_bcm02
   #(
    .A_WIDTH   (DATABUS_WIDTH),
    .SEL_WIDTH (`HMASTER_WIDTH),
    .MUX_WIDTH (`AHB_DATA_WIDTH)
  ) U_dm 
  (
    .a   (bus_hwdata),
    .sel (hmaster_data),
    .mux (hwdata)
  );


  assign hmaster_data = 4'b0001;
  assign ihmaster     = 4'b0001;

//
// As HSEL is decoded from HADDR, it needs to be registered so that  
// data from Slave A will be muxed back into the data pipe when the 
// address changes to point to Slave B.  This situation arises due
// to the AMBA Address/Data pipeline/offset
//
// When there is no activity on the bus, hand the control of the
// return bus to the default slave. The hready will always be active.
// Allows for the a layer not to be affected by a slave which is
// held off by another layer when used in a multi-layer environment
//
// Do not have any hsel_prev active. Therefore the default is selected.

  // JS, 4/7/2008, now the slave responses are sent back to the master
  // even if the master is driving htrans=IDLE. Previous functionality
  // was to send back 0 on slave response signals, which though not
  // critical, violates the spec.
  always @ (posedge hclk or negedge hresetn)
  begin : hsel_prev_PROC
    if (hresetn == 1'b0)
      hsel_prev <= {`NUM_IAHB_SLAVES+1{1'b0}};
    else begin
      if (hready == 1'b1) begin
          hsel_prev <= hsel;
      end
    end
  end

// This block decodes hsel_prev to cause data from the correct 
// slave to be produced on the hrdata, hready and hresp outputs 
// of the block
//
// spyglass disable_block SelfDeterminedExpr-ML
// SMD: Self determined expression present in the design.
// SJ: No functional issue in this addition
// spyglass disable_block W415a
// SMD: Signal may be multiply assigned (beside initialization) in the same scope
// SJ: This is not an issue. It is initialized before assignment to avoid latches
  always @ (hsel_prev
             or bus_hrdata
             or bus_hready
             or bus_hresp
             or hresp_none
             or hrdata_none
             or hready_resp_none 
             )
  begin : decodeFromSlaves_PROC
    hready = hready_resp_none; 
    hresp  = hresp_none;
    hrdata = hrdata_none;

    for (j=0;j<=`NUM_IAHB_SLAVES;j=j+1) begin
      if (hsel_prev[j]== 1'b1) begin
        hready = bus_hready[j];
        for (c=0;c<`HRESP_WIDTH;c=c+1) begin
          hresp[c]  = bus_hresp[(j*`HRESP_WIDTH)+c];
        end
        for (c=0;c<`AHB_DATA_WIDTH;c=c+1) begin
          hrdata[c] = bus_hrdata[(j*`AHB_DATA_WIDTH)+c];
        end
      end
    end
  end
// spyglass enable_block W415a
// spyglass enable_block SelfDeterminedExpr-ML
   
endmodule
