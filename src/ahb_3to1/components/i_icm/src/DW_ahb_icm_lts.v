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
// File Version     :        $Revision: #9 $ 
// Revision: $Id: //dwh/DW_ocb/DW_ahb_icm/amba_dev/src/DW_ahb_icm_lts.v#9 $ 
//
// File     : DW_ahb_icm_lts.v
// Authors  : Peter Gillen
// Date     : $Date: 2016/05/19 $
// Abstract : The translation from layer to slave.
//
//
//
//
//

module i_icm_DW_ahb_icm_lts (
  bus_hsel,
                       bus_haddr,
                       bus_htrans,
                       bus_hsize,
                       bus_hburst,
                       bus_hprot,
                       bus_hwrite,
                       bus_hmastlock,
                       bus_hwdata,
                       hlayer,
                       hlayer_data,
                       hsel,
                       haddr,
                       htrans,
                       hsize,
                       hburst,
                       hprot,
                       hwrite,
                       hmastlock,
                       hwdata
                       );

  input  [`ICM_BUS_NUM_HSEL-1:0]      bus_hsel;
  input  [`ICM_BUS_HADDR_WIDTH-1:0]   bus_haddr;
  input  [`ICM_BUS_HTRANS_WIDTH-1:0]  bus_htrans;
  input  [`ICM_BUS_HSIZE_WIDTH-1:0]   bus_hsize;
  input  [`ICM_BUS_HBURST_WIDTH-1:0]  bus_hburst;
  input  [`ICM_BUS_HPROT_WIDTH-1:0]   bus_hprot;
  input  [`ICM_NUM_LAYERS-1:0]        bus_hwrite;
  input  [`ICM_NUM_LAYERS-1:0]        bus_hmastlock;
  input  [`ICM_BUS_DATA_WIDTH-1:0]    bus_hwdata;
  input  [`ICM_LAYER_WIDTH-1:0]           hlayer;
  input  [`ICM_LAYER_WIDTH-1:0]           hlayer_data;

  output [`ICM_NUM_HSEL-1:0]              hsel;
  output [`HADDR_WIDTH-1:0]               haddr;
  output [`HTRANS_WIDTH-1:0]              htrans;
  output [`HSIZE_WIDTH-1:0]               hsize;
  output [`HBURST_WIDTH-1:0]              hburst;
  output [`HPROT_WIDTH-1:0]               hprot;
  output                                  hwrite;
  output                                  hmastlock;
  output [`AHB_DATA_WIDTH-1:0]            hwdata;


//
// The bus_hsel is made up of all the combined layers seperate lay_*_hsel which 
// are ICM_NUM_HSEL bits wide. The bus_hsel is made up of all the layers and
// is maximum width because of this but only for layer numbers not for select
// lines.
//

  i_icm_DW_ahb_icm_bcm02
   #(
    .A_WIDTH    (`ICM_BUS_NUM_HSEL),
    .SEL_WIDTH  (`ICM_LAYER_WIDTH),
    .MUX_WIDTH  (`ICM_NUM_HSEL)
  ) U_hsel (
    .a   ( bus_hsel ),
    .sel ( hlayer ),
    .mux ( hsel )
  );

  i_icm_DW_ahb_icm_bcm02
   #(
    .A_WIDTH    (`ICM_BUS_HADDR_WIDTH),
    .SEL_WIDTH  (`ICM_LAYER_WIDTH),
    .MUX_WIDTH  (`HADDR_WIDTH)
  ) U_haddr (
    .a   ( bus_haddr ),
    .sel ( hlayer ),
    .mux ( haddr )
  );

  i_icm_DW_ahb_icm_bcm02
   #(
    .A_WIDTH    (`ICM_BUS_HTRANS_WIDTH),
    .SEL_WIDTH  (`ICM_LAYER_WIDTH),
    .MUX_WIDTH  (`HTRANS_WIDTH)
  ) U_htrans (
    .a   ( bus_htrans ),
    .sel ( hlayer ),
    .mux ( htrans )
  );

  i_icm_DW_ahb_icm_bcm02
   #(
    .A_WIDTH    (`ICM_BUS_HSIZE_WIDTH),
    .SEL_WIDTH  (`ICM_LAYER_WIDTH),
    .MUX_WIDTH  (`HSIZE_WIDTH)
  ) U_hsize (
    .a   ( bus_hsize ),
    .sel ( hlayer ),
    .mux ( hsize )
  );

  i_icm_DW_ahb_icm_bcm02
   #(
    .A_WIDTH    (`ICM_BUS_HBURST_WIDTH),
    .SEL_WIDTH  (`ICM_LAYER_WIDTH),
    .MUX_WIDTH  (`HBURST_WIDTH)
  ) U_hburst (
    .a   ( bus_hburst ),
    .sel ( hlayer ),
    .mux ( hburst )
  );


  i_icm_DW_ahb_icm_bcm02
   #(
    .A_WIDTH    (`ICM_BUS_HPROT_WIDTH),
    .SEL_WIDTH  (`ICM_LAYER_WIDTH),
    .MUX_WIDTH  (`HPROT_WIDTH)
  ) U_hprot (
    .a   ( bus_hprot ),
    .sel ( hlayer ),
    .mux ( hprot )
  );


  i_icm_DW_ahb_icm_bcm02
   #(
    .A_WIDTH    (`ICM_NUM_LAYERS),
    .SEL_WIDTH  (`ICM_LAYER_WIDTH),
    .MUX_WIDTH  (1)
  ) U_hwrite (
    .a   ( bus_hwrite ),
    .sel ( hlayer ),
    .mux ( hwrite )
  );

  i_icm_DW_ahb_icm_bcm02
   #(
    .A_WIDTH    (`ICM_NUM_LAYERS),
    .SEL_WIDTH  (`ICM_LAYER_WIDTH),
    .MUX_WIDTH  (1)
  ) U_hmastlock (
    .a   ( bus_hmastlock ),
    .sel ( hlayer ),
    .mux ( hmastlock )
  );







//
// The data to the slave is controlled by the owner of the data bus to the slave.
//

  i_icm_DW_ahb_icm_bcm02
   #(
    .A_WIDTH    (`ICM_BUS_DATA_WIDTH),
    .SEL_WIDTH  (`ICM_LAYER_WIDTH), 
    .MUX_WIDTH  (`AHB_DATA_WIDTH)
  )  U_dmux (
    .a   ( bus_hwdata ),
    .sel ( hlayer_data ),
    .mux ( hwdata )
  );
  
endmodule
