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
// File Version     :        $Revision: #14 $ 
// Revision: $Id: //dwh/DW_ocb/DW_ahb_icm/amba_dev/src/DW_ahb_icm.v#14 $ 
// proprietary to Synopsys, Inc.  Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc.
//
// The entire notice above must be reproduced on all authorized copies.
//
// File     : DW_ahb_icm.v
// Authors  : Peter Gillen
// Date     : $Date: 2018/07/20 $
// Abstract : The top level module.
//
//
//
//
//
// Please refer to the databook for full details on the signals.
//
// These are found in the "Signal Description" section of the "Signals" chapter.
// There are details on the following
//   Any False Paths
//   Any Multicycle Paths
//   Any Asynchronous Signals
//

//==============================================================================
// Start License Usage
//==============================================================================
//==============================================================================
// End License Usage
//==============================================================================

//spyglass disable_block Topology_02
//SMD: No asynchronous pin to pin paths.
//SJ: Multiple inputs are directly involved in output evaluation. This is desired behavior of the DW_ahb_icm.
module i_icm_DW_ahb_icm ( 

  hclk,
                   hresetn,
                   hresp,
                   hready_resp,
                   hrdata,
                   hsel_s1_l1,
                   haddr_l1,
                   htrans_l1,
                   hsize_l1,
                   hburst_l1,
                   hwdata_l1,
                   hwrite_l1,
                   hmastlock_l1,
                   hprot_l1,
                   hready_l1,
                   hsel_s1_l2,
                   haddr_l2,
                   htrans_l2,
                   hsize_l2,
                   hburst_l2,
                   hwdata_l2,
                   hwrite_l2,
                   hmastlock_l2,
                   hprot_l2,
                   hready_l2,
                   hsel_s1_l3,
                   haddr_l3,
                   htrans_l3,
                   hsize_l3,
                   hburst_l3,
                   hwdata_l3,
                   hwrite_l3,
                   hmastlock_l3,
                   hprot_l3,
                   hready_l3,
                   hresp_l1,
                   hready_resp_l1,
                   hrdata_l1,
                   hresp_l2,
                   hready_resp_l2,
                   hrdata_l2,
                   hresp_l3,
                   hready_resp_l3,
                   hrdata_l3,
                   hsel_s1,
                   haddr,
                   htrans,
                   hsize,
                   hburst,
                   hwdata,
                   hwrite,
                   hmastlock,
                   hprot,
                   hready
                   );
//spyglass enable_block Topology_02
 
  //------------------------------------------------------------------------------------------------
  //Input Signals
  //------------------------------------------------------------------------------------------------

  input                        hclk;
  input                        hresetn;


  input  [`HRESP_WIDTH-1:0]    hresp;
  input                        hready_resp;
  input  [`AHB_DATA_WIDTH-1:0] hrdata;


  // Master 1 Interface Signals

  input                         hsel_s1_l1;
  input  [`HADDR_WIDTH-1:0]     haddr_l1;
  input  [`HTRANS_WIDTH-1:0]    htrans_l1;
  input  [`HSIZE_WIDTH-1:0]     hsize_l1;
  input  [`HBURST_WIDTH-1:0]    hburst_l1;
  input  [`AHB_DATA_WIDTH-1:0]  hwdata_l1;
  input                         hwrite_l1;
  input                         hmastlock_l1;
  input  [`HPROT_WIDTH-1:0]     hprot_l1;
  input                         hready_l1;

  // Master 2 Interface Signals

  input                         hsel_s1_l2;
  input  [`HADDR_WIDTH-1:0]     haddr_l2;
  input  [`HTRANS_WIDTH-1:0]    htrans_l2;
  input  [`HSIZE_WIDTH-1:0]     hsize_l2;
  input  [`HBURST_WIDTH-1:0]    hburst_l2;
  input  [`AHB_DATA_WIDTH-1:0]  hwdata_l2;
  input                         hwrite_l2;
  input                         hmastlock_l2;
  input  [`HPROT_WIDTH-1:0]     hprot_l2;
  input                         hready_l2;

// Master 3 Interface Signals

  input                         hsel_s1_l3;
  input  [`HADDR_WIDTH-1:0]     haddr_l3;
  input  [`HTRANS_WIDTH-1:0]    htrans_l3;
  input  [`HSIZE_WIDTH-1:0]     hsize_l3;
  input  [`HBURST_WIDTH-1:0]    hburst_l3;
  input  [`AHB_DATA_WIDTH-1:0]  hwdata_l3;
  input                         hwrite_l3;
  input                         hmastlock_l3;
  input  [`HPROT_WIDTH-1:0]     hprot_l3;
  input                         hready_l3;



























  output [`HRESP_WIDTH-1:0]     hresp_l1;
  output                        hready_resp_l1;
  output [`AHB_DATA_WIDTH-1:0]  hrdata_l1;

// Master 2 Interface Signals

  output [`HRESP_WIDTH-1:0]     hresp_l2;
  output                        hready_resp_l2;
  output [`AHB_DATA_WIDTH-1:0]  hrdata_l2;

// Master 3 Interface Signals

  output [`HRESP_WIDTH-1:0]     hresp_l3;
  output                        hready_resp_l3;
  output [`AHB_DATA_WIDTH-1:0]  hrdata_l3;

// Master 4 Interface Signals


// Master 5 Interface Signals


// Master 6 Interface Signals


// Master 7 Interface Signals


// Master 8 Interface Signals










// Slave Interface signals

  output                       hsel_s1;
  output [`HADDR_WIDTH-1:0]    haddr;
  output [`HTRANS_WIDTH-1:0]   htrans;
  output [`HSIZE_WIDTH-1:0]    hsize;
  output [`HBURST_WIDTH-1:0]   hburst;
  output [`AHB_DATA_WIDTH-1:0] hwdata;
  output                       hwrite;
  output                       hmastlock;
  output [`HPROT_WIDTH-1:0]    hprot;
  output                       hready;

// Conditional ports such as hburst_l1 etc, are left unconnected on sub modules,
// they require a declaration as they are not removed from the port list of the
// sub module.

  wire   [`HBURST_WIDTH-1:0]    hburst_l1;
  wire                          hmastlock_l1;
  wire   [`HPROT_WIDTH-1:0]     hprot_l1;

  wire   [`HBURST_WIDTH-1:0]    hburst_l2;
  wire                          hmastlock_l2;
  wire   [`HPROT_WIDTH-1:0]     hprot_l2;

  wire   [`HADDR_WIDTH-1:0]     haddr_l3;
  wire   [`HTRANS_WIDTH-1:0]    htrans_l3;
  wire   [`HSIZE_WIDTH-1:0]     hsize_l3;
  wire   [`HBURST_WIDTH-1:0]    hburst_l3;
  wire   [`AHB_DATA_WIDTH-1:0]  hwdata_l3;
  wire                          hwrite_l3;
  wire                          hmastlock_l3;
  wire   [`HPROT_WIDTH-1:0]     hprot_l3;
  wire                          hready_l3;















  wire   [`HRESP_WIDTH-1:0]     hresp;
  wire                          hready_resp;
  wire   [`AHB_DATA_WIDTH-1:0]  hrdata;

  wire   [`ICM_BUS_NUM_HSEL-1:0]      bus_hsel;
  wire   [`ICM_BUS_HADDR_WIDTH-1:0]   bus_haddr;
  wire   [`ICM_BUS_HTRANS_WIDTH-1:0]  bus_htrans;
  wire   [`ICM_BUS_HSIZE_WIDTH-1:0]   bus_hsize;
  wire   [`ICM_BUS_HBURST_WIDTH-1:0]  bus_hburst;
  wire   [`ICM_BUS_HPROT_WIDTH-1:0]   bus_hprot;
  wire   [`ICM_NUM_LAYERS-1:0]        bus_hwrite;
  wire   [`ICM_NUM_LAYERS-1:0]        bus_hmastlock;
  wire   [`ICM_BUS_DATA_WIDTH-1:0]    bus_hwdata;

  wire   [`ICM_NUM_LAYERS-1:0]  bus_request;
  wire   [`ICM_NUM_LAYERS-1:0]  bus_lock;
  wire   [`ICM_NUM_LAYERS-1:0]  bus_busy;
  wire   [`ICM_PRIORITY_WIDTH-1:0] bus_priority;
  wire   [`ICM_PRIORITY_WIDTH-1:0] priority_i;
  wire   [`ICM_NUM_LAYERS-1:0]  bus_mask;
  wire   [`ICM_NUM_LAYERS-1:0]  bus_hlayer;

  wire   [`ICM_LAYER_WIDTH-1:0] hlayer;
  wire   [`ICM_LAYER_WIDTH-1:0] hlayer_data;

  wire   [`ICM_NUM_HSEL-1:0]    hsel_l1;
  wire   [`ICM_NUM_HSEL-1:0]    hsel_l2;
  wire   [`ICM_NUM_HSEL-1:0]    hsel_l3;

  wire                          hsel_s1_l1;

  wire                          hsel_s1_l2;

  wire                          hsel_s1_l3;















  wire   [`ICM_NUM_LAYERS-1:0]  bus_uis;
  wire   [`ICM_NUM_LAYERS-1:0]  cancel_is;
  wire   [`ICM_NUM_LAYERS-1:0]  bus_cancel_uis;
  wire   [`ICM_NUM_LAYERS-1:0]  bus_hready_l;

// Optional I/O's need to be defined.

  wire [`HBURST_WIDTH-1:0]      hburst;
  wire                          hmastlock;
  wire [`HPROT_WIDTH-1:0]       hprot;

  wire                          hsel_s1;

  reg  [`ICM_NUM_HSEL-1:0]      max_hsel;
  wire [`ICM_NUM_HSEL-1:0]      hsel;
  wire                          revised_hready_resp;

  wire [`AHB_DATA_WIDTH-1:0]    hrdata_l1;
  wire [`AHB_DATA_WIDTH-1:0]    hrdata_l2;
  wire [`AHB_DATA_WIDTH-1:0]    hrdata_l3; 


  wire [`HRESP_WIDTH-1:0]       hresp_l3;

  wire                          hready_resp_l3; 

  
  wire [`ICM_NUM_LAYERS-1:0] bus_hready_resp;

   wire p_unconn, g_unconn; 
   wire [`LOG2_ICM_NUM_LAYERS-1:0] gi_unconn;
   wire l_unconn;
   
//
// Take the incoming hready and combine into a bus format making the bits
// for unused layers always ready (tied to 1'b1)
//

  i_icm_DW_ahb_icm_gh
   U_gh (
    .hready_l1(hready_l1),
                      .hready_l2(hready_l2),
                      .hready_l3(hready_l3),
                      .bus_hready_l(bus_hready_l)
                      );

//
//
//
  
  assign bus_hready_resp = {
  hready_resp_l3,
  hready_resp_l2,
  hready_resp_l1};

  assign hsel_l1 = {
  hsel_s1_l1};
  
  assign hsel_l2 = {
  hsel_s1_l2};
  
  assign hsel_l3 = {
  hsel_s1_l3};
  
  
  
  
  









//
// All the select lines from each of the layers are selected by the hlayer. The resultant peripheral select
// is then connected to the seperated signals.
//
// spyglass disable_block W415a
// SMD: Signal may be multiply assigned (beside initialization) in the same scope
// SJ: The design checked and verified that not any one of a single bit of the bus is assigned more than once beside initialization or the multiple assignments are intentional.
  always @( hsel )
  begin : max_sel_PROC
    max_hsel = {`ICM_NUM_HSEL{1'b0}};
    max_hsel[`ICM_NUM_HSEL-1:0] = hsel;
  end
// spyglass enable_block W415a

  assign hsel_s1 = max_hsel[0];

  assign bus_priority = 6'b100100;


  assign bus_hwdata = {
  hwdata_l3,
  hwdata_l2,
  hwdata_l1};
  assign hrdata_l1 = hrdata;
  assign hrdata_l2 = hrdata;
  assign hrdata_l3 = hrdata;

//  reg  [`ICM_MAX_LAYERS-1:0] full_hlayer_data;
//  wire [`ICM_NUM_LAYERS-1:0] num_hlayer_data;
  wire [`ICM_NUM_LAYERS-1:0] revised_bus_lock;

//#  always @(hlayer_data or hresp)
//#  begin
//#    full_hlayer_data = 'b0;
//#    if (hresp != `IDLE)
//#      full_hlayer_data[hlayer_data] = 1'b1;
//#  end
//#  assign num_hlayer_data = full_hlayer_data[`ICM_NUM_LAYERS-1:0];
//# 
//#  assign revised_bus_lock = bus_lock | num_hlayer_data;

//# Need to find a way to deny access to other layers when there is an error response
//# Need to create corresponding traffic profile on the bus.
//# FOr the moment allowing change in hsize when hready is low if there is an error response.
  assign revised_bus_lock = bus_lock;

  

  assign priority_i = bus_priority;

// Internal arbiter

  i_icm_DW_ahb_icm_bcm52
   #(
  .N                 (`ICM_NUM_LAYERS),
  .PARK_MODE         (1),
  .PARK_INDEX        (0),
  .OUTPUT_MODE       (0),
  .INDEX_WIDTH       (`LOG2_ICM_NUM_LAYERS),
  .REAL_INDEX_WIDTH  (`LOG2_ICM_NUM_LAYERS_P1))
  U_dp ( 
    .clk              ( hclk ),
    .rst_n            ( hresetn ),
    .init_n           (1'b1),
    .enable           (1'b1),
    .request          ( bus_request ),
    .lock             ( revised_bus_lock ),
    .mask             ( bus_mask ),
    .prior            ( priority_i ),

    .grant            ( bus_hlayer ),
// spyglass disable_block W528
// SMD: A signal or variable is set but never read
// SJ: Based on component configuration, this(these) signal(s) or parts of it will not be used to compute the final result.
    .parked           (p_unconn),
    .granted          (g_unconn),
    .locked           (l_unconn),
    .grant_index      (gi_unconn)
// spyglass enable_block W528
   );

// Holds onto the current owner of the data bus
  i_icm_DW_ahb_icm_hld
   U_hld ( 
    .hclk             ( hclk ),
    .hresetn          ( hresetn ),
    .bus_hlayer       ( bus_hlayer ),
    .hready_resp      ( revised_hready_resp ),

    .hlayer           ( hlayer ),
    .hlayer_data      ( hlayer_data )
   );

// Clash detection and input stage selection
  i_icm_DW_ahb_icm_cdiss
   U_cdiss ( 
    .hclk             ( hclk ),
    .hresetn          ( hresetn ),
    .bus_cancel_uis   ( bus_cancel_uis ),
    .bus_hready_l     ( bus_hready_l ),
    .bus_request      ( bus_request ),
    .bus_lock         ( bus_lock ),
    .hlayer           ( hlayer ),
    .hready_resp      ( revised_hready_resp ),

    .bus_uis          ( bus_uis )
   );

// The input stage
  i_icm_DW_ahb_icm_is
   U_is ( 
    .hclk(hclk),
                      .hresetn(hresetn),
                      .bus_hready_resp_l(bus_hready_resp),
                      .bus_uis(bus_uis),
                      .cancel_is(cancel_is),
                      .bus_hready_l(bus_hready_l),
                      .hsel_l1(hsel_l1),
                      .haddr_l1(haddr_l1),
                      .htrans_l1(htrans_l1),
                      .hsize_l1(hsize_l1),
                      .hburst_l1(hburst_l1),
                      .hprot_l1(hprot_l1),
                      .hwrite_l1(hwrite_l1),
                      .hmastlock_l1(hmastlock_l1),
                      .hsel_l2(hsel_l2),
                      .haddr_l2(haddr_l2),
                      .htrans_l2(htrans_l2),
                      .hsize_l2(hsize_l2),
                      .hburst_l2(hburst_l2),
                      .hprot_l2(hprot_l2),
                      .hwrite_l2(hwrite_l2),
                      .hmastlock_l2(hmastlock_l2),
                      .hsel_l3(hsel_l3),
                      .haddr_l3(haddr_l3),
                      .htrans_l3(htrans_l3),
                      .hsize_l3(hsize_l3),
                      .hburst_l3(hburst_l3),
                      .hprot_l3(hprot_l3),
                      .hwrite_l3(hwrite_l3),
                      .hmastlock_l3(hmastlock_l3),
                      .bus_hsel(bus_hsel),
                      .bus_haddr(bus_haddr),
                      .bus_htrans(bus_htrans),
                      .bus_hsize(bus_hsize),
                      .bus_hburst(bus_hburst),
                      .bus_hprot(bus_hprot),
                      .bus_hwrite(bus_hwrite),
                      .bus_hmastlock(bus_hmastlock),
                      .bus_request(bus_request),
                      .bus_lock(bus_lock),
                      .bus_busy(bus_busy)
                      );


// Translation from layer to slave
  i_icm_DW_ahb_icm_lts
   U_lts ( 
    .bus_hsel(bus_hsel),
                        .bus_haddr(bus_haddr),
                        .bus_htrans(bus_htrans),
                        .bus_hsize(bus_hsize),
                        .bus_hburst(bus_hburst),
                        .bus_hprot(bus_hprot),
                        .bus_hwrite(bus_hwrite),
                        .bus_hmastlock(bus_hmastlock),
                        .bus_hwdata(bus_hwdata),
                        .hlayer(hlayer),
                        .hlayer_data(hlayer_data),
                        .hsel(hsel),
                        .haddr(haddr),
                        .htrans(htrans),
                        .hsize(hsize),
                        .hburst(hburst),
                        .hprot(hprot),
                        .hwrite(hwrite),
                        .hmastlock(hmastlock),
                        .hwdata(hwdata)
                        );

// Count Wait States on the bus_hready_l signals
  i_icm_DW_ahb_icm_cws
   U_cws ( 
    .hclk(hclk),
                        .hresetn(hresetn),
                        .bus_hready_l(bus_hready_l),
                        .bus_uis(bus_uis),
                        .hlayer(hlayer),
                        .hlayer_data(hlayer_data),
                        .hready_resp(revised_hready_resp),
                        .hresp(hresp),
                        .bus_busy(bus_busy),
                        .hready_resp_l1(hready_resp_l1),
                        .hresp_l1(hresp_l1),
                        .hready_resp_l2(hready_resp_l2),
                        .hresp_l2(hresp_l2),
                        .hready_resp_l3(hready_resp_l3),
                        .hresp_l3(hresp_l3),
                        .bus_cancel_uis(bus_cancel_uis),
                        .cancel_is(cancel_is)
                        );

// Generates the input hready for the common slave
  i_icm_DW_ahb_icm_csg
   U_csg (
    .bus_request          ( bus_request ),
    .hready_resp          ( revised_hready_resp ),
    .hlayer               ( hlayer ),
    .bus_uis              ( bus_uis ),
    .bus_hready_l         ( bus_hready_l ),
    .bus_cancel_uis       ( bus_cancel_uis ),

    .hready               ( hready )
  );

// Handles common slaves with a default hready_resp of low
  i_icm_DW_ahb_icm_low
   U_low ( 
    .hclk                 ( hclk ),
    .hresetn              ( hresetn ),
    .hready               ( hready ),
    .hsel                 ( hsel ),
    .hready_resp          ( hready_resp ),
    .revised_hready_resp  ( revised_hready_resp )
  );

  // Masking the Access to the Common slave when previous transaction in progress


  assign bus_mask = {`ICM_NUM_LAYERS{1'b0}};


endmodule
