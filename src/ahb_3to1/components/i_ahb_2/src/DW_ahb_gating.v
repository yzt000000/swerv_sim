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
// File Version     :        $Revision: #6 $ 
// Revision: $Id: //dwh/DW_ocb/DW_ahb/amba_dev/src/DW_ahb_gating.v#6 $ 
--
-- File :                       DW_ahb_gating.v
-- Author:                      Peter Gillen 
-- Date :                       $Date: 2015/05/15 $ 
-- Abstract     :               
--
-- Depending on the configuration the grants can be generated from one
-- of two arbitration sources. This module controls which source wins.
-- =====================================================================
*/

module i_ahb_2_DW_ahb_gating (
                      grant,
                      parked,
                      grant_2t,
                      parked_2t
                      );

  input  [`NUM_AHB_MASTERS:0] grant;
  input                       parked;

  output [`NUM_AHB_MASTERS:0] grant_2t;
  output                      parked_2t;

  reg    [`NUM_AHB_MASTERS:0] grant_2t;
  reg                         parked_2t;

//
// Always give the grant to the lower tiered arbiter unless the
// weighted token arbitration scheme is implemented then only give
// the grant from this upper arbiter when it is not parked and when
// the weighted token arbitration is enabled.
// Two conditions : Weighted token implemented
//                : Weighted token enabled
//
  always @(
           grant)
  begin : grant_2t_PROC
    grant_2t = grant;
  end

//
// Whenever the weighted token priority scheme is used then
// the arbiter is parked when both arbiters are parked.
// When the weighted token priority scheme is not used then
// the arbiter is parked when the lower level arbiter is parked.
// Even when the weighted token priority scheme is used it may
// not be enabled so it then needs to behave as if it did not have
// the scheme
//
  always @(
           parked)
  begin : parked_2t_PROC
    parked_2t = parked;
  end

endmodule
