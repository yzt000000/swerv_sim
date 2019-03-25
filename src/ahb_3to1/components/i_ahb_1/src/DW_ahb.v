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
// File Version     :        $Revision: #11 $ 
// Revision: $Id: //dwh/DW_ocb/DW_ahb/amba_dev/src/DW_ahb.v#11 $ 
--
-- File :                       DW_ahb.v
-- Date :                       $Date: 2018/07/20 $
-- Abstract     :               Top-level DW_ahb BusIP
--
//
// Please refer to the databook for full details on the signals.
//
// These are found in the "Signal Description" section of the "Signals" chapter.
// There are details on the following
//   Any False Paths
//   Any Multicycle Paths
//   Any Asynchronous Signals
//
------------------------------------------------------------------------
*/
//==============================================================================
// Start License Usage
//==============================================================================
//==============================================================================
// End License Usage
//==============================================================================
//spyglass disable_block Topology_02
//SMD: No asynchronous pin to pin paths.
//SJ: DW_ahb performs address decoding where only combinational logic is present. This is desired behavior of the DW_ahb.
module i_ahb_1_DW_ahb (
  hclk,
               hresetn,
               haddr_m1,
               hburst_m1,
               hlock_m1,
               hprot_m1,
               hsize_m1,
               htrans_m1,
               hwdata_m1,
               hwrite_m1,
               hsel_s1,
               hready_resp_s1,
               hresp_s1,
               hrdata_s1,
               haddr,
               hburst,
               hprot,
               hsize,
               htrans,
               hwdata,
               hwrite,
               hready,
               hresp,
               hrdata,
               hmaster,
               hmaster_data,
               hmastlock
               );
//spyglass enable_block Topology_02

  // ----------------------------------------
  // Parameters inherited from the cc_constant 
  // file, make them not visible from the GUI
  // ----------------------------------------

  // physical parameters

  // memory map parameters
  parameter INT_R1_N_SA_1 = 32'h0;
  parameter INT_R1_N_EA_1 = 32'hffffffff;
  parameter INT_R1_N_SA_2 = 32'ha000000;
  parameter INT_R1_N_EA_2 = 32'ha00ffff;

  // derived parameters
  parameter ADDRBUS_WIDTH = 64;
  parameter DATABUS_WIDTH = 128;
  parameter HRDATABUS_WIDTH = 128;
  
 
  input                          hclk;
  input                          hresetn;

// Master #1 AHB signals
  input [`HADDR_WIDTH-1:0]        haddr_m1;
  input [`HBURST_WIDTH-1:0]      hburst_m1;
  input                          hlock_m1;
  input [`HPROT_WIDTH-1:0]       hprot_m1;
  input [`HSIZE_WIDTH-1:0]       hsize_m1;
  input [`HTRANS_WIDTH-1:0]      htrans_m1;
  input [`AHB_DATA_WIDTH-1:0]     hwdata_m1;
  input                          hwrite_m1;
  

// Slave #1 AHB signals
  input                          hready_resp_s1;
  input [`HRESP_WIDTH-1:0]       hresp_s1;
  input [`AHB_DATA_WIDTH-1:0]     hrdata_s1;
  output                         hsel_s1;

  output [`HADDR_WIDTH-1:0]      haddr;
  output [`HBURST_WIDTH-1:0]     hburst;
  output [`HPROT_WIDTH-1:0]      hprot;
  output [`HSIZE_WIDTH-1:0]      hsize;
  output [`HTRANS_WIDTH-1:0]     htrans;
  output [`AHB_DATA_WIDTH-1:0]   hwdata;
  output                         hwrite;
  output [`HMASTER_WIDTH-1:0]    hmaster;
  output [`HMASTER_WIDTH-1:0]    hmaster_data;
  output                         hmastlock;
  output                         hready;
  output [`HRESP_WIDTH-1:0]      hresp;
  output [`AHB_DATA_WIDTH-1:0]    hrdata;


// Dummy wire declarations for inputs which may have been removed
// by reuse pragmas.


// Internal concatenated bus of all top-level haddr buses from masters
  wire   [ADDRBUS_WIDTH-1:0]     bus_haddr;
  wire   [`HTRANSBUS_WIDTH-1:0]  bus_htrans;
  wire   [`INTERNAL_HSEL-1:0]    hsel;
  wire   [`HRESPBUS_WIDTH-1:0]   bus_hresp;
  wire   [`HREADY_WIDTH-1:0]     bus_hready;
  wire   [HRDATABUS_WIDTH-1:0]   bus_hrdata;
  wire   [`HBURSTBUS_WIDTH-1:0]  bus_hburst;
  wire   [`HSIZEBUS_WIDTH-1:0]   bus_hsize;
  wire   [`HPROTBUS_WIDTH-1:0]   bus_hprot;
  wire   [`HWRITEBUS_WIDTH-1:0]  bus_hwrite;
  wire   [DATABUS_WIDTH-1:0]     bus_hwdata;

  wire   [`HMASTER_WIDTH-1:0]    hmaster_data;
  wire                           hsel_none;
  wire   [`HRESP_WIDTH-1:0]      hresp_none;
  wire                           hready_resp_none;
  wire   [`AHB_DATA_WIDTH-1:0]    hrdata_none;


// These are the signals driven by Master 0, the Internal Dummy
// Master
// The Dummy Master is granted the bus when no other master
// can access the bus.
// The function of the Dummy Master is to drive Default
// Values onto the Address, Data and Control buses when
// no other master can gain access to the bus.

//
// The dummy master
//
  assign bus_haddr[`HADDR_WIDTH-1:0]     = {`HADDR_WIDTH{1'b0}};
  assign bus_htrans[`HTRANS_WIDTH-1:0]   = `IDLE;
  assign bus_hwdata[`AHB_DATA_WIDTH-1:0] = {`AHB_DATA_WIDTH{1'b0}};
  assign bus_hsize[`HSIZE_WIDTH-1:0]     = `BYTE;
  assign bus_hburst[`HBURST_WIDTH-1:0]   = `SINGLE;
  assign bus_hprot[`HPROT_WIDTH-1:0]     = `NC_NB_P_D;
  assign bus_hwrite[0]                   = `READ;

//
// Build internal busses from master and slave signals, The following 
// assign statements are generated by a tcl plugin script.
//
   
  assign bus_haddr[(`HADDR_WIDTH*2)-1:(`HADDR_WIDTH*1)] = haddr_m1;
  assign bus_htrans[3:2] = htrans_m1;
  assign bus_hburst[5:3] = hburst_m1;
  assign bus_hsize[5:3] = hsize_m1;
  assign bus_hprot[7:4] = hprot_m1;
  assign bus_hwrite[1] = hwrite_m1;
  assign bus_hwdata[(`AHB_DATA_WIDTH*2)-1:(`AHB_DATA_WIDTH*1)] = hwdata_m1;


  // When AHB LITE is selected, slave will be always ready and will always give OK response.
  // Hence bus_hready is tied to logic 1 and bus_hresp is tied to logic 0's. 
  assign bus_hready[0] = 1'b1;
  assign bus_hresp[1:0] = 2'h0;
  // When AHB LITE is selected bus_hrdata is always tied to logic 0's.
  assign bus_hrdata[`AHB_DATA_WIDTH-1:0] = {`AHB_DATA_WIDTH{1'b0}};

  assign bus_hready[1] = hready_resp_s1;
  assign bus_hresp[3:2] = hresp_s1;
  assign bus_hrdata[(`AHB_DATA_WIDTH*2)-1:`AHB_DATA_WIDTH*1] = hrdata_s1;

  // spyglass disable_block SelfDeterminedExpr-ML
  // SMD: Self determined expression present in the design.
  // SJ: No functional issue in this addition
  assign hsel_none = hsel[`NUM_IAHB_SLAVES+1];
  // spyglass enable_block SelfDeterminedExpr-ML
  assign hsel_s1 = hsel[1];



// end of generated "assign" statements
   
  i_ahb_1_DW_ahb_mux
  
   U_mux (
    .hclk(hclk),
          .hresetn(hresetn),
          .bus_haddr(bus_haddr),
          .bus_hburst(bus_hburst),
          .bus_hprot(bus_hprot),
          .bus_hsize(bus_hsize),
          .bus_htrans(bus_htrans),
          .bus_hwdata(bus_hwdata),
          .bus_hwrite(bus_hwrite),
          .hrdata_none(hrdata_none),
          .hready_resp_none(hready_resp_none),
          .hresp_none(hresp_none),
          .bus_hready(bus_hready),
          .bus_hresp(bus_hresp),
          .bus_hrdata(bus_hrdata),
          .hsel(hsel[`NUM_IAHB_SLAVES:0]),
          .hmaster_data(hmaster_data),
          .haddr(haddr),
          .hburst(hburst),
          .hprot(hprot),
          .hsize(hsize),
          .htrans(htrans),
          .hwdata(hwdata),
          .hwrite(hwrite),
          .hrdata(hrdata),
          .hready(hready),
          .hresp(hresp)
          );

  i_ahb_1_DW_ahb_dcdr
   #(`HADDR_WIDTH, INT_R1_N_SA_1, INT_R1_N_EA_1, INT_R1_N_SA_2, INT_R1_N_EA_2) U_dcdr (
    .haddr(haddr),
                                                                                                  .hsel(hsel)
                                                                                                  );





  i_ahb_1_DW_ahb_arblite
   U_arblite (
    .hclk             (hclk),
    .hresetn          (hresetn),
    .hlock_m1         (hlock_m1),
    .hready           (hready),
    .hmaster          (hmaster),
    .hmastlock        (hmastlock)
  );


  i_ahb_1_DW_ahb_dfltslv
   
   U_dfltslv (
    .hclk             (hclk),
    .hresetn          (hresetn),
    .hready           (hready),
    .htrans           (htrans),
    .hsel_none        (hsel_none),
    .hready_resp_none (hready_resp_none),
    .hresp_none       (hresp_none),
    .hrdata_none      (hrdata_none)
  );



endmodule
