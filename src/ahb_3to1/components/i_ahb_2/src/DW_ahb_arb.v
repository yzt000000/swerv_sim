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
// File Version     :        $Revision: #10 $ 
// Revision: $Id: //dwh/DW_ocb/DW_ahb/amba_dev/src/DW_ahb_arb.v#10 $ 
--  
-- File :                       DW_ahb_arb.v
-- Author:                      Ray Beechinor, Peter Gillen 
-- Date :                       $Date: 2018/06/22 $ 
-- Abstract     :               AHB Arbiter.
--
--  Instantiates the following blocks:
--
--  * DW_ahb_bcm53   (Two-tier DW arbiter)
--  * DW_ahb_gctrl  (Grant Control Logic)
--  * DW_ahb_mask   (Mask Generation Logic)
--  * DW_ahb_ebt    (Early Burst Termination Control)
--  * DW_ahb_arbif  (AHB Arbiter Slave Interface) 
--               
--  DW_ahb_arb implements a two-tier arbitration scheme which complies
--  with the requirements of the AMBA specification.
--  The first tier of the arbitration is a user-programmable priority
--  scheme;  the second tier of arbitration is a "fair" scheme
--  which will make the arbitration decision when two or more masters
--  with the same user-programmed priority request bus access.
--           
*/

module i_ahb_2_DW_ahb_arb (
  hclk,
                   hresetn,
                   hready,
                   hresp,
                   hburst,
                   htrans, 
                   bus_hlock,
                   bus_hbusreq, 
                   bus_hsplit,
                   hmaster_data,
                   bus_hgrant,
                   hmaster,
                   hmastlock
                   );

  // physical parameters

  input                        hclk;
  input                        hresetn;
  input                        hready;
  input [`HRESP_WIDTH-1:0]     hresp;
  input [`HBURST_WIDTH-1:0]    hburst;
  input [`HTRANS_WIDTH-1:0]    htrans;
  input [`NUM_AHB_MASTERS:0]   bus_hlock;
// All bus requests are concatenated into a single bus.
  input [`NUM_AHB_MASTERS:0]   bus_hbusreq;
  input [`SPLITBUS_WIDTH-1:0]  bus_hsplit;
// Which master has control of the data bus
  input [`HMASTER_WIDTH-1:0]   hmaster_data;
// When set then pause mode is enabled.
  
  output [`NUM_AHB_MASTERS:1]  bus_hgrant;
// Arbiter slave response to master
// Arbiter slave transfer response to master
  output [`HMASTER_WIDTH-1:0]  hmaster;
  output                       hmastlock;


  wire [(4*(`NUM_INT_MASTERS))-1:0] bus_priority;
//  wire [`HSPLIT_WIDTH-1:0]     hsplit;
  wire [`HMASTER_WIDTH-1:0]    def_mst;
  wire [`NUM_AHB_MASTERS:0]    maskmaster;
  wire [`NUM_AHB_MASTERS:0]    mask;
  wire [`NUM_AHB_MASTERS:0]    grant;
  wire [`NUM_AHB_MASTERS:0]    grant_2t;
  wire                         parked;
  wire                         parked_2t;
  wire [`NUM_AHB_MASTERS:0]    ibus_hbusreq;

  wire                          est;
  wire [`HMASTER_WIDTH-1:0]     ihmaster;
  wire                          csilt;
  wire                          ltip;
  
  
  wire l_2t_unconn, g_2t_unconn; 
  wire [`LOG2_NUM_INT_MASTERS-1:0] gi_2t_unconn;
  wire l_3t_unconn, g_3t_unconn; 
  wire [`LOG2_NUM_INT_MASTERS-1:0] gi_3t_unconn;
   
// When the mode is not configured do not want any logic used so need
// to free up the regsiter.


  i_ahb_2_DW_ahb_arbif
   
   U_arbif (
            .def_mst(def_mst),
            .bus_priority(bus_priority),
            .maskmaster(maskmaster)
            );





//
// Mask 
//
  i_ahb_2_DW_ahb_mask
  
   U_mask (
    .hclk             (hclk),
    .hresetn          (hresetn),
    .hresp            (hresp),
    .bus_hsplit       (bus_hsplit),
    .hmaster_data     (hmaster_data),
    .maskmaster       (maskmaster),
    .bus_priority     (bus_priority),
    .ltip             (ltip),
    .csilt            (csilt),
    .hready           (hready),

    .est              (est),
//    .hsplit           (hsplit),
    .mask             (mask)

  );

//
// Grant Control
//
  i_ahb_2_DW_ahb_gctrl
  
   U_gctrl (
    .hclk(hclk),
            .hresetn(hresetn),
            .bus_hlock(bus_hlock),
            .def_mst(def_mst),
            .hburst(hburst),
            .hready(hready),
            .hresp(hresp),
            //    .hsplit           (hsplit),
            .htrans(htrans),
            .grant_2t(grant_2t),
            .parked_2t(parked_2t),
            .mask(mask),
            .ltip(ltip),
            .csilt(csilt),
            .bus_hbusreq(bus_hbusreq),
            .ibus_hbusreq(ibus_hbusreq),
            .bus_hgrant_out(bus_hgrant),
            .hmastlock(hmastlock),
            .hmaster(ihmaster),
            .est(est)
            );



// spyglass disable_block W528
// SMD: A signal or variable is set but never read
// SJ: BCMs are generic modules. All of there ports may not be used. Unconnected ports will be optimized during synthesis.


//#
//# With only one master it is going to be always granted provided it is not masked.
//# When there is a bit set in the grant bus then we are not parked.
//#
  assign grant = ~mask & ibus_hbusreq;
  assign parked = ~(|grant);


// spyglass enable_block W528



  i_ahb_2_DW_ahb_gating
   U_gating (
                          .grant_2t(grant_2t),
                          .parked_2t(parked_2t),
                          .grant(grant),
                          .parked(parked)
                          );



  assign hmaster = ihmaster;

endmodule
