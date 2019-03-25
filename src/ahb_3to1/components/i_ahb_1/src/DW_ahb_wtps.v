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
// Revision: $Id: //dwh/DW_ocb/DW_ahb/amba_dev/src/DW_ahb_wtps.v#8 $ 
--
-- File :                       DW_ahb_wtps.v
-- Author:                      Peter Gillen 
-- Date :                       $Date: 2018/06/22 $ 
-- Abstract     :
--
-- Each master has a counter which counts the number of clock tokens each
-- master uses up in an arbitration period. When the tokens are used then
-- this master can no longer compete at the upper level. When masters are
-- masked from this upper level they can gain access when no one else is
-- looking for the bus who has any spare tokens. When all tokens are used
-- then normal arbitration continues. This requires the weighted token
-- arbitration scheme to be enabled, otherwise the default arbitration
-- scheme is in place.
--
*/

module i_ahb_1_DW_ahb_wtps (
  hclk,
                    hresetn,
                    hmaster,
                    wten,
                    ahb_itcl,
                    bus_ahb_icl,
                    mask,
                    tokenmask,
                    ahb_wt_aps
                    );

input                          hclk;
input                          hresetn;
// Configuration: Weighted token enable
input                          wten;
input [`NUM_AHB_MASTERS:0]     mask;
input [`HMASTER_WIDTH-1:0]     hmaster;
// Configuration: the number of clock tokens in arbitration period
input [`AHB_TCL_WIDTH-1:0]     ahb_itcl;
// Configuration of all the master clock tokens for each counter
input [`AHB_CCL_BUS_WIDTH-1:0] bus_ahb_icl;

// When a master runs out of tokens it is to be masked from the upper arbitration
// scheme using the tokenmask bit.

  output [`NUM_AHB_MASTERS:0]    tokenmask;
  output                         ahb_wt_aps;

reg    [`AHB_TCL_WIDTH-1:0]    ahb_tccnt;
wire   [`NUM_AHB_MASTERS:0]    wt_mask;

// Enables for the counters to count.
// en_tccnt       : The type of counting mode, clock or bus cycle
// en_ahb_tccnt   : Requires the mode to be enabled plus the counting mode
// en_ahb_ccnt_mx : When hmaster is x and en_ahb_tccnt is active then the
//                  master is using a clock token and the count is decremented

wire                           en_ahb_tccnt;

// Each master generates a mask bit wt_mask_mx and this is overridden with
// iwt_mask_mx. The over riding is done for masters that are not included
// into the design. For 14 master system then master 15 mask are set to 0.


// Arbitration period start
wire                        arb_pstart;


// When the weighted token is enabled then the counters are loaded
// and a new arbitration period is started. The mode should be
// disabled when the counter values are being changed and then
// reenabled when the value are all programmed. A rising edge
// detector is used to load the counters when the mode is enabled.
wire                        red_wten;
reg                         d_wten;

assign ahb_wt_aps = arb_pstart;

//--------------------------------------------------------------------
// Rising Edge Detector on Weighted Token Arbitration
//--------------------------------------------------------------------
//
// d_wten : When the user programs the weighted token enable
// this change is used to load the counters for the arbitration
// period and for the clock tokens. Looking for a rising edge
// to load the counter. The counter is subsequently loaded when
// the timer loops around zero.
//


  always @ (posedge hclk or negedge hresetn)
  begin : d_wten_PROC
    if (hresetn == 1'b0)
      d_wten <= 1'b0;
    else
      d_wten <= wten;
  end 
  assign red_wten = (d_wten == 1'b0) && (wten == 1'b1);

//--------------------------------------------------------------------
// Falling Edge Detector on pause provided configured
//--------------------------------------------------------------------
//
// pause will be set when the arbiter enters pause mode
// When one comes out of pause mode then all the counters
// will be reloaded. If pause mode is not enabled then this
// functionality is bypassed.


//--------------------------------------------------------------------
// Arbitration Period Start
//--------------------------------------------------------------------
//
// The counter is loaded whenever the count is zero
// The counter is loaded whenever one comes out of pause mode, as one
// could have entered pause mode in the middle of an arbitration period
// The counter is loaded when the weighted token arbitration scheme is
// enabled.
//
  assign arb_pstart = (ahb_tccnt == {`AHB_TCL_WIDTH{1'b0}}) || 
                      (red_wten  == 1'b1);

//--------------------------------------------------------------------
// Arbitration Enabling
//--------------------------------------------------------------------
//
// When one has AHB_TPS_MODE as clock cycle mode then the counter
// is always enabled. When one has AHB_TPS_MODE as bus cycle mode
// the counter is enabled when hready is active. In  both cases one
// requires the weighted token enable to be set.
//
  assign en_ahb_tccnt = wten;

//--------------------------------------------------------------------
// Arbitration Period Counter
//--------------------------------------------------------------------
//
// ahb_tccnt : AHB Total Cycle Count
// Loaded with ahb_itcl when count reaches zero
// Decremented by 1 on each enable cycle
//
  always @ (posedge hclk or negedge hresetn)
  begin : ahb_tccnt_PROC
    if (hresetn == 1'b0)
      ahb_tccnt <= {`AHB_TCL_WIDTH{1'b0}};
    else begin
      if (arb_pstart == 1'b1) begin
        ahb_tccnt <= ahb_itcl;
      end else begin
        if (en_ahb_tccnt == 1'b1) begin
          ahb_tccnt <= ahb_tccnt - 1;
        end
      end
    end
  end

//--------------------------------------------------------------------
// Master Clock Token Counter 
//--------------------------------------------------------------------
//
// ahb_ccnt_m1 : AHB Cycle Count Master 1
// Loaded with ahb_icl_m1 when the arbitration period starts, this is
// part of the concatenated bus bus_ahb_icl which is made up of each
// masters load value.
// Decremented by 1 on each enable cycle provided the bus owner
// is master number 1. Reset with macro AHB_CL_M1.
//
// spyglass disable_block SelfDeterminedExpr-ML
// SMD: Self determined expression present in the design.
// SJ: No functional issue in this addition



//
// ahb_ccnt_m2 : AHB Cycle Count Master 2
// Loaded with ahb_icl_m1 when the arbitration period starts, this is
// part of the concatenated bus bus_ahb_icl which is made up of each
// masters load value.
// Decremented by 1 on each enable cycle provided the bus owner
// is master number 2. Reset with macro AHB_CL_M2.
//


//
// ahb_ccnt_m3 : AHB Cycle Count Master 3
// Loaded with ahb_icl_m1 when the arbitration period starts, this is
// part of the concatenated bus bus_ahb_icl which is made up of each
// masters load value.
// Decremented by 1 on each enable cycle provided the bus owner
// is master number 3. Reset with macro AHB_CL_M3.
//


//
// ahb_ccnt_m4 : AHB Cycle Count Master 4
// Loaded with ahb_icl_m1 when the arbitration period starts, this is
// part of the concatenated bus bus_ahb_icl which is made up of each
// masters load value.
// Decremented by 1 on each enable cycle provided the bus owner
// is master number 4. Reset with macro AHB_CL_M4.
//


//
// ahb_ccnt_m5 : AHB Cycle Count Master 5
// Loaded with ahb_icl_m1 when the arbitration period starts, this is
// part of the concatenated bus bus_ahb_icl which is made up of each
// masters load value.
// Decremented by 1 on each enable cycle provided the bus owner
// is master number 5. Reset with macro AHB_CL_M5.
//


//
// ahb_ccnt_m6 : AHB Cycle Count Master 6
// Loaded with ahb_icl_m1 when the arbitration period starts, this is
// part of the concatenated bus bus_ahb_icl which is made up of each
// masters load value.
// Decremented by 1 on each enable cycle provided the bus owner
// is master number 6. Reset with macro AHB_CL_M6.
//


//
// ahb_ccnt_m7 : AHB Cycle Count Master 7
// Loaded with ahb_icl_m1 when the arbitration period starts, this is
// part of the concatenated bus bus_ahb_icl which is made up of each
// masters load value.
// Decremented by 1 on each enable cycle provided the bus owner
// is master number 7. Reset with macro AHB_CL_M7.
//


//
// ahb_ccnt_m8 : AHB Cycle Count Master 8
// Loaded with ahb_icl_m1 when the arbitration period starts, this is
// part of the concatenated bus bus_ahb_icl which is made up of each
// masters load value.
// Decremented by 1 on each enable cycle provided the bus owner
// is master number 8. Reset with macro AHB_CL_M8.
//


//
// ahb_ccnt_m9 : AHB Cycle Count Master 9
// Loaded with ahb_icl_m1 when the arbitration period starts, this is
// part of the concatenated bus bus_ahb_icl which is made up of each
// masters load value.
// Decremented by 1 on each enable cycle provided the bus owner
// is master number 9. Reset with macro AHB_CL_M9.
//


//
// ahb_ccnt_m10 : AHB Cycle Count Master 10
// Loaded with ahb_icl_m1 when the arbitration period starts, this is
// part of the concatenated bus bus_ahb_icl which is made up of each
// masters load value.
// Decremented by 1 on each enable cycle provided the bus owner
// is master number 10. Reset with macro AHB_CL_M10.
//


//
// ahb_ccnt_m11 : AHB Cycle Count Master 11
// Loaded with ahb_icl_m1 when the arbitration period starts, this is
// part of the concatenated bus bus_ahb_icl which is made up of each
// masters load value.
// Decremented by 1 on each enable cycle provided the bus owner
// is master number 11. Reset with macro AHB_CL_M11.
//


//
// ahb_ccnt_m12 : AHB Cycle Count Master 12
// Loaded with ahb_icl_m1 when the arbitration period starts, this is
// part of the concatenated bus bus_ahb_icl which is made up of each
// masters load value.
// Decremented by 1 on each enable cycle provided the bus owner
// is master number 12. Reset with macro AHB_CL_M12.
//


//
// ahb_ccnt_m13 : AHB Cycle Count Master 13
// Loaded with ahb_icl_m1 when the arbitration period starts, this is
// part of the concatenated bus bus_ahb_icl which is made up of each
// masters load value.
// Decremented by 1 on each enable cycle provided the bus owner
// is master number 13. Reset with macro AHB_CL_M13.
//


//
// ahb_ccnt_m14 : AHB Cycle Count Master 14
// Loaded with ahb_icl_m1 when the arbitration period starts, this is
// part of the concatenated bus bus_ahb_icl which is made up of each
// masters load value.
// Decremented by 1 on each enable cycle provided the bus owner
// is master number 14. Reset with macro AHB_CL_M14.
//


//
// ahb_ccnt_m15 : AHB Cycle Count Master 15
// Loaded with ahb_icl_m1 when the arbitration period starts, this is
// part of the concatenated bus bus_ahb_icl which is made up of each
// masters load value.
// Decremented by 1 on each enable cycle provided the bus owner
// is master number 15. Reset with macro AHB_CL_M15.
//

// spyglass enable_block SelfDeterminedExpr-ML

//
// All mask bits are qualified and are concatenated, the relevant number of bits
// are then stripped depending on the number of masters in the system.
// Externally this is used with the output from DW_ahb_mask to remove a master from
// the upper arbitration scheme.
//
  assign wt_mask = { 
                     1'b0  
                     };

  assign tokenmask = wt_mask[`NUM_AHB_MASTERS:0] | mask;

endmodule
