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
// Revision: $Id: //dwh/DW_ocb/DW_ahb_icm/amba_dev/src/DW_ahb_icm_is.v#10 $ 
//
// File     : DW_ahb_icm_is.v
// Abstract : The input stage.
//

module i_icm_DW_ahb_icm_is (
  hclk,
                      hresetn,
                      bus_hready_resp_l,
                      cancel_is,
                      bus_uis,
                      bus_hready_l,
                      hsel_l1,
                      haddr_l1,
                      htrans_l1,
                      hsize_l1,
                      hburst_l1,
                      hprot_l1,
                      hwrite_l1,
                      hmastlock_l1,
                      hsel_l2,
                      haddr_l2,
                      htrans_l2,
                      hsize_l2,
                      hburst_l2,
                      hprot_l2,
                      hwrite_l2,
                      hmastlock_l2,
                      hsel_l3,
                      haddr_l3,
                      htrans_l3,
                      hsize_l3,
                      hburst_l3,
                      hprot_l3,
                      hwrite_l3,
                      hmastlock_l3,
                      bus_hsel,
                      bus_haddr,
                      bus_htrans,
                      bus_hsize,
                      bus_hburst,
                      bus_hprot,
                      bus_hwrite,
                      bus_hmastlock,
                      bus_request,
                      bus_lock,
                      bus_busy
                      );

  input                        hclk;
  input                        hresetn;
  input  [`ICM_NUM_LAYERS-1:0] bus_hready_resp_l;
  input  [`ICM_NUM_LAYERS-1:0] cancel_is;
  input  [`ICM_NUM_LAYERS-1:0] bus_uis;
  input  [`ICM_NUM_LAYERS-1:0] bus_hready_l;
  input  [`ICM_NUM_HSEL-1:0]   hsel_l1;
  input  [`HADDR_WIDTH-1:0]    haddr_l1;
  input  [`HTRANS_WIDTH-1:0]   htrans_l1;
  input  [`HSIZE_WIDTH-1:0]    hsize_l1;
  input  [`HBURST_WIDTH-1:0]   hburst_l1;
  input  [`HPROT_WIDTH-1:0]    hprot_l1;
  input                        hwrite_l1;
  input                        hmastlock_l1;
  input  [`ICM_NUM_HSEL-1:0]   hsel_l2;
  input  [`HADDR_WIDTH-1:0]    haddr_l2;
  input  [`HTRANS_WIDTH-1:0]   htrans_l2;
  input  [`HSIZE_WIDTH-1:0]    hsize_l2;
  input  [`HBURST_WIDTH-1:0]   hburst_l2;
  input  [`HPROT_WIDTH-1:0]    hprot_l2;
  input                        hwrite_l2;
  input                        hmastlock_l2;
  input  [`ICM_NUM_HSEL-1:0]   hsel_l3;
  input  [`HADDR_WIDTH-1:0]    haddr_l3;
  input  [`HTRANS_WIDTH-1:0]   htrans_l3;
  input  [`HSIZE_WIDTH-1:0]    hsize_l3;
  input  [`HBURST_WIDTH-1:0]   hburst_l3;
  input  [`HPROT_WIDTH-1:0]    hprot_l3;
  input                        hwrite_l3;
  input                        hmastlock_l3;

  output [`ICM_BUS_NUM_HSEL-1:0]      bus_hsel;
  output [`ICM_BUS_HADDR_WIDTH-1:0]   bus_haddr;
  output [`ICM_BUS_HTRANS_WIDTH-1:0]  bus_htrans;
  output [`ICM_BUS_HSIZE_WIDTH-1:0]   bus_hsize;
  output [`ICM_BUS_HBURST_WIDTH-1:0]  bus_hburst;
  output [`ICM_BUS_HPROT_WIDTH-1:0]   bus_hprot;
  output [`ICM_NUM_LAYERS-1:0]        bus_hwrite;
  output [`ICM_NUM_LAYERS-1:0]        bus_hmastlock;
  output [`ICM_NUM_LAYERS-1:0]        bus_request;
  output [`ICM_NUM_LAYERS-1:0]        bus_lock;
  output [`ICM_NUM_LAYERS-1:0]        bus_busy;

  wire                         lay1_update_is; 
  wire                         lay2_update_is; 
  wire                         lay3_update_is; 

//
// These are included so that the configuration can be viewed within the  trace file.
//

// ### Start of RTL Code ###



  assign lay1_update_is = (bus_hready_l[0] == 1'b1) && (bus_uis[0] == 1'b0);
  assign lay2_update_is = (bus_hready_l[1] == 1'b1) && (bus_uis[1] == 1'b0);
  assign lay3_update_is = (bus_hready_l[2] == 1'b1) && (bus_uis[2] == 1'b0);

  i_icm_DW_ahb_icm_ism
    U_Layer1_is (
    .lay_hsel(bus_hsel[`ICM_NUM_HSEL-1:0]),
                               .lay_haddr(bus_haddr[`HADDR_WIDTH-1:0]),
                               .lay_htrans_mod(bus_htrans[`HTRANS_WIDTH-1:0]),
                               .lay_hsize(bus_hsize[`HSIZE_WIDTH-1:0]),
                               .lay_hburst(bus_hburst[`HBURST_WIDTH-1:0]),
                               .lay_hprot(bus_hprot[`HPROT_WIDTH-1:0]),
                               .lay_hwrite(bus_hwrite[0]),
                               .lay_hmastlock(bus_hmastlock[0]),
                               .lay_request(bus_request[0]),
                               .lay_lock(bus_lock[0]),
                               .lay_busy(bus_busy[0]),
                               .hclk(hclk),
                               .hresetn(hresetn),
                               .hready(bus_hready_l[0]),
                               .lay_hready_resp(bus_hready_resp_l[0]),
                               .uis(bus_uis[0]),
                               .update(lay1_update_is),
                               .cancel(cancel_is[0]),
                               .hsel_l(hsel_l1),
                               .haddr_l(haddr_l1),
                               .htrans_l(htrans_l1),
                               .hsize_l(hsize_l1),
                               .hburst_l(hburst_l1),
                               .hprot_l(hprot_l1),
                               .hmastlock_l(hmastlock_l1),
                               .hwrite_l(hwrite_l1)
                               );

// spyglass disable_block SelfDeterminedExpr-ML
// SMD: Self determined expression found
// SJ: The expression indexing the vector/array will never exceed the bound of the vector/array.
  i_icm_DW_ahb_icm_ism
    U_Layer2_is (
    .lay_hsel(bus_hsel[2*`ICM_NUM_HSEL-1:`ICM_NUM_HSEL]),
                               .lay_haddr(bus_haddr[2*`HADDR_WIDTH-1:`HADDR_WIDTH]),
                               .lay_htrans_mod(bus_htrans[2*`HTRANS_WIDTH-1:`HTRANS_WIDTH]),
                               .lay_hsize(bus_hsize[2*`HSIZE_WIDTH-1:`HSIZE_WIDTH]),
                               .lay_hburst(bus_hburst[2*`HBURST_WIDTH-1:`HBURST_WIDTH]),
                               .lay_hprot(bus_hprot[2*`HPROT_WIDTH-1:`HPROT_WIDTH]),
                               .lay_hwrite(bus_hwrite[1]),
                               .lay_hmastlock(bus_hmastlock[1]),
                               .lay_request(bus_request[1]),
                               .lay_lock(bus_lock[1]),
                               .lay_busy(bus_busy[1]),
                               .hclk(hclk),
                               .hresetn(hresetn),
                               .hready(bus_hready_l[1]),
                               .lay_hready_resp(bus_hready_resp_l[1]),
                               .uis(bus_uis[1]),
                               .update(lay2_update_is),
                               .cancel(cancel_is[1]),
                               .hsel_l(hsel_l2),
                               .haddr_l(haddr_l2),
                               .htrans_l(htrans_l2),
                               .hsize_l(hsize_l2),
                               .hburst_l(hburst_l2),
                               .hprot_l(hprot_l2),
                               .hmastlock_l(hmastlock_l2),
                               .hwrite_l(hwrite_l2)
                               );

  i_icm_DW_ahb_icm_ism
    U_Layer3_is (
    .lay_hsel(bus_hsel[3*`ICM_NUM_HSEL-1:2*`ICM_NUM_HSEL]),
                               .lay_haddr(bus_haddr[3*`HADDR_WIDTH-1:2*`HADDR_WIDTH]),
                               .lay_htrans_mod(bus_htrans[3*`HTRANS_WIDTH-1:2*`HTRANS_WIDTH]),
                               .lay_hsize(bus_hsize[3*`HSIZE_WIDTH-1:2*`HSIZE_WIDTH]),
                               .lay_hburst(bus_hburst[3*`HBURST_WIDTH-1:2*`HBURST_WIDTH]),
                               .lay_hprot(bus_hprot[3*`HPROT_WIDTH-1:2*`HPROT_WIDTH]),
                               .lay_hwrite(bus_hwrite[2]),
                               .lay_hmastlock(bus_hmastlock[2]),
                               .lay_request(bus_request[2]),
                               .lay_lock(bus_lock[2]),
                               .lay_busy(bus_busy[2]),
                               .hclk(hclk),
                               .hresetn(hresetn),
                               .hready(bus_hready_l[2]),
                               .lay_hready_resp(bus_hready_resp_l[2]),
                               .uis(bus_uis[2]),
                               .update(lay3_update_is),
                               .cancel(cancel_is[2]),
                               .hsel_l(hsel_l3),
                               .haddr_l(haddr_l3),
                               .htrans_l(htrans_l3),
                               .hsize_l(hsize_l3),
                               .hburst_l(hburst_l3),
                               .hprot_l(hprot_l3),
                               .hmastlock_l(hmastlock_l3),
                               .hwrite_l(hwrite_l3)
                               );




























// spyglass enable_block SelfDeterminedExpr-ML

//
// For all the layers each signal is combined into a bus signal with one from each layer.
//

endmodule
