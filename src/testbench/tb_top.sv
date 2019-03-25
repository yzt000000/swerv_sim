// SPDX-License-Identifier: Apache-2.0
// Copyright 2019 Western Digital Corporation or its affiliates.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
`ifndef VERILATOR
module tb_top;
`else
module tb_top ( input logic core_clk, input logic reset_l);
`endif

`ifndef VERILATOR
   logic                                reset_l;
   logic                                core_clk;
`endif
   logic                                nmi_int;

   logic        [31:0]                  reset_vector;
   logic        [31:0]                  nmi_vector;

   logic        [31:0]                  ic_haddr        ;
   logic        [2:0]                   ic_hburst       ;
   logic                                ic_hmastlock    ;
   logic        [3:0]                   ic_hprot        ;
   logic        [2:0]                   ic_hsize        ;
   logic        [1:0]                   ic_htrans       ;
   logic                                ic_hwrite       ;
   logic        [63:0]                  ic_hrdata       ;
   logic                                ic_hready       ;
   logic                                ic_hresp        ;
   logic        [63:0]                  ic_hwdata       ;

   logic        [31:0]                  Slave_haddr        ;
   logic        [2:0]                   Slave_hburst       ;
   logic                                Slave_hmastlock    ;
   logic        [3:0]                   Slave_hprot        ;
   logic        [2:0]                   Slave_hsize        ;
   logic        [1:0]                   Slave_htrans       ;
   logic                                Slave_hwrite       ;
   logic        [63:0]                  Slave_hrdata       ;
   logic                                Slave_hready       ;
   logic                                Slave_hresp        ;
   logic        [63:0]                  Slave_hwdata       ;
   logic                                Slave_hready_resp  ;

   logic                                tmp0,tmp1,tmp2     ;



   logic        [31:0]                  lsu_haddr       ;
   logic        [2:0]                   lsu_hburst      ;
   logic                                lsu_hmastlock   ;
   logic        [3:0]                   lsu_hprot       ;
   logic        [2:0]                   lsu_hsize       ;
   logic        [1:0]                   lsu_htrans      ;
   logic                                lsu_hwrite      ;
   logic        [63:0]                  lsu_hrdata      ;
   logic        [63:0]                  lsu_hwdata      ;
   logic                                lsu_hready      ;
   logic                                lsu_hresp        ;

   logic        [31:0]                  sb_haddr        ;
   logic        [2:0]                   sb_hburst       ;
   logic                                sb_hmastlock    ;
   logic        [3:0]                   sb_hprot        ;
   logic        [2:0]                   sb_hsize        ;
   logic        [1:0]                   sb_htrans       ;
   logic                                sb_hwrite       ;

   logic        [63:0]                  sb_hrdata       ;
   logic        [63:0]                  sb_hwdata       ;
   logic                                sb_hready       ;
   logic                                sb_hresp        ;

   logic        [63:0]                  trace_rv_i_insn_ip;
   logic        [63:0]                  trace_rv_i_address_ip;
   logic        [2:0]                   trace_rv_i_valid_ip;
   logic        [2:0]                   trace_rv_i_exception_ip;
   logic        [4:0]                   trace_rv_i_ecause_ip;
   logic        [2:0]                   trace_rv_i_interrupt_ip;
   logic        [31:0]                  trace_rv_i_tval_ip;

   logic                                o_debug_mode_status;
   logic                                dec_tlu_perfcnt0;
   logic                                dec_tlu_perfcnt1;
   logic                                dec_tlu_perfcnt2;
   logic                                dec_tlu_perfcnt3;


   logic                                jtag_tdo;
   logic                                o_cpu_halt_ack;
   logic                                o_cpu_halt_status;
   logic                                o_cpu_run_ack;

   logic                                mailbox_write;
   logic        [63:0]                  dma_hrdata       ;
   logic        [63:0]                  dma_hwdata       ;
   logic                                dma_hready       ;
   logic                                dma_hresp        ;

   logic        [31:0]                  cycleCnt       ;
   logic                                mailbox_data_val;
   logic        [31:0]                  sc_print        ;

   //assign sc_print = 'h3000;
   assign sc_print = 'hd0580000;
   //assign mailbox_write = &{i_ahb_lsu.Write, i_ahb_lsu.Last_HADDR==32'hD0580000, i_ahb_lsu.HRESETn==1};
   //assign mailbox_write = i_ahb_lsu.mailbox_write;
   //assign mailbox_write = i_ahb_lsu.mailbox_write & !core_clk;
   //assign mailbox_data_val = (i_ahb_lsu.WriteData[7:0] > 8'h1f) & (i_ahb_lsu.WriteData[7:0] < 8'h7f);

   //assign mailbox_data_val = (i_ahb_lsu.Last_HADDR == 32'hD0580000);



   int unsigned                         f_i_info;
   string stuff_file;
   string i_info;

   initial begin
       $value$plusargs("test_info=%s",i_info);
       $display("%s\n",i_info);
       f_i_info = $fopen(i_info,"r");

       forever begin
           if($feof(f_i_info)) break;
           $fscanf(f_i_info,"%s\n", stuff_file);
           $display("%s\n", stuff_file);
       end
   end

`ifndef VERILATOR
   `define FORCE force
`else
   `define FORCE 
`endif


   integer fd;
   initial begin
     fd = $fopen("console.log","w");
   end

   integer tp;

   always @(posedge core_clk or negedge reset_l) begin
     if( reset_l == 0)
         cycleCnt <= 0;
     else 
         cycleCnt <= cycleCnt+1;
   end

   always @(negedge core_clk) begin
      //if(cycleCnt == 32'h800)
      //if(cycleCnt == 32'h1800)
      if(rvtop.swerv.dec.decode.dec_i0_pc_d[31:1] == 'h7c)
        $finish;
   end

typedef enum logic {
    AHB_STATE_IDLE = 1'b0,
    AHB_STATE_DATA = 1'b1,
    AHB_STATE_ERR  = 1'bx
} type_scr1_ahb_state_e;

type_scr1_ahb_state_e           ahb_state;

logic write_addr_phase;
logic write_data_phase;

assign write_addr_phase = (i_ahb_lsu.HADDR == sc_print) && i_ahb_lsu.HWRITE && (i_ahb_lsu.HTRANS == 2'b10) && (i_ahb_lsu.HREADY);

always @(posedge core_clk) begin
    write_data_phase <= write_addr_phase;
end


always @(posedge core_clk) begin
    if (write_data_phase) 
        $write("%c",i_ahb_lsu.HWDATA[7:0]);
end


   always @(posedge core_clk)
     $fwrite(tp,"%b,%h,%h,%0h,%0h,3,%b,%h,%h,%b\n", rvtop.trace_rv_i_valid_ip, rvtop.trace_rv_i_address_ip[63:32], rvtop.trace_rv_i_address_ip[31:0], rvtop.trace_rv_i_insn_ip[63:32], rvtop.trace_rv_i_insn_ip[31:0],rvtop.trace_rv_i_exception_ip,rvtop.trace_rv_i_ecause_ip,rvtop.trace_rv_i_tval_ip,rvtop.trace_rv_i_interrupt_ip);

   initial begin

`ifndef VERILATOR
     core_clk = 0;
`endif

     reset_vector = 32'h00000300;
     //nmi_vector   = 32'hee000000;
     nmi_vector   = 32'h00000000;
     nmi_int   = 0;

`ifndef VERILATOR
     @(posedge core_clk);
     reset_l = 0;
`endif

     //tb_top.ahb_sif.ram_inst.genblk1.ram_inst.mem_array[16383:0]
     //$readmemh("../src/data.hex",     i_ahb_lsu.mem);
     if (stuff_file.len()>0) begin
         $readmemh(stuff_file,  i_ahb_lsu.ram_inst.genblk1.ram_inst.mem_array);
     end
     tp = $fopen("trace_port.csv","w");

`ifndef VERILATOR
     repeat (5) @(posedge core_clk);
     reset_l = 1;
     #45000000000 $display("");$finish;
`endif
   end

`ifndef VERILATOR
initial begin
   forever  begin 
     core_clk = #5 ~core_clk;
   end
end
`endif

   //=========================================================================-
   // RTL instance
   //=========================================================================-
   swerv_wrapper rvtop (
            .rst_l              ( reset_l       ),
            .clk                ( core_clk      ),
            .rst_vec            ( reset_vector[31:1]  ),
            .nmi_int            ( nmi_int       ),
            .nmi_vec            ( 31'h00000000  ),

            .haddr              ( ic_haddr      ),
            .hburst             ( ic_hburst     ),
            .hmastlock          ( ic_hmastlock  ),
            .hprot              ( ic_hprot      ),
            .hsize              ( ic_hsize      ),
            .htrans             ( ic_htrans     ),
            .hwrite             ( ic_hwrite     ),

            .hrdata             ( ic_hrdata[63:0]),
            .hready             ( ic_hready     ),
            .hresp              ( ic_hresp      ),

           //---------------------------------------------------------------
           // Debug AHB Master
           //---------------------------------------------------------------
           .sb_haddr            ( sb_haddr      ),
           .sb_hburst           ( sb_hburst     ),
           .sb_hmastlock        ( sb_hmastlock  ),
           .sb_hprot            ( sb_hprot      ),
           .sb_hsize            ( sb_hsize      ),
           .sb_htrans           ( sb_htrans     ),
           .sb_hwrite           ( sb_hwrite     ),
           .sb_hwdata           ( sb_hwdata     ),

           .sb_hrdata           ( sb_hrdata     ),
           .sb_hready           ( sb_hready     ),
           .sb_hresp            ( sb_hresp      ),


            //---------------------------------------------------------------
            // LSU AHB Master
            //---------------------------------------------------------------
            .lsu_haddr     ( lsu_haddr       ),
            .lsu_hburst    ( lsu_hburst      ),
            .lsu_hmastlock ( lsu_hmastlock   ),
            .lsu_hprot     ( lsu_hprot       ),
            .lsu_hsize     ( lsu_hsize       ),
            .lsu_htrans    ( lsu_htrans      ),
            .lsu_hwrite    ( lsu_hwrite      ),
            .lsu_hwdata    ( lsu_hwdata      ),

            .lsu_hrdata    ( lsu_hrdata[63:0]),
            .lsu_hready    ( lsu_hready      ),
            .lsu_hresp     ( lsu_hresp       ),


           //---------------------------------------------------------------
           // DMA Slave
           //---------------------------------------------------------------
           .dma_haddr           ( '0     ),
           .dma_hburst          ( '0    ),
           .dma_hmastlock       ( '0 ),
           .dma_hprot           ( '0     ),
           .dma_hsize           ( '0     ),
           .dma_htrans          ( '0    ),
           .dma_hwrite          ( '0    ),
           .dma_hwdata          ( '0    ),

           .dma_hrdata          ( dma_hrdata    ),
           .dma_hready          ( dma_hready    ),
           .dma_hresp           ( dma_hresp     ),

           .timer_int           ( 1'b0     ),
           `ifdef TB_RESTRUCT
           .extintsrc_req       ( '0  ),
           `else
           .extintsrc_req       ( '0  ),
           `endif

           `ifdef RV_BUILD_AHB_LITE
           .lsu_bus_clk_en ( 1'b1  ),// Clock ratio b/w cpu core clk & AHB master interface
           .ifu_bus_clk_en ( 1'b1  ),// Clock ratio b/w cpu core clk & AHB master interface
           .dbg_bus_clk_en ( 1'b0  ),// Clock ratio b/w cpu core clk & AHB Debug master interface
           .dma_bus_clk_en ( 1'b0  ),// Clock ratio b/w cpu core clk & AHB slave interface
           `endif

           .trace_rv_i_insn_ip(trace_rv_i_insn_ip),
           .trace_rv_i_address_ip(trace_rv_i_address_ip),
           .trace_rv_i_valid_ip(trace_rv_i_valid_ip),
           .trace_rv_i_exception_ip(trace_rv_i_exception_ip),
           .trace_rv_i_ecause_ip(trace_rv_i_ecause_ip),
           .trace_rv_i_interrupt_ip(trace_rv_i_interrupt_ip),
           .trace_rv_i_tval_ip(trace_rv_i_tval_ip),





           .jtag_tck            ( 1'b0  ),          // JTAG clk
           .jtag_tms            ( 1'b0  ),          // JTAG TMS
           .jtag_tdi            ( 1'b0  ),          // JTAG tdi
           .jtag_trst_n         ( 1'b0  ),       // JTAG Reset
           .jtag_tdo            ( jtag_tdo ),          // JTAG TDO
           .i_cpu_halt_req      ( 1'b0  ),    // Async halt req to CPU
           .o_cpu_halt_ack      ( o_cpu_halt_ack ),    // core response to halt
           .o_cpu_halt_status   ( o_cpu_halt_status ), // 1'b1 indicates core is halted
           .i_cpu_run_req       ( 1'b0  ),     // Async restart req to CPU
           .o_debug_mode_status (o_debug_mode_status),
           .o_cpu_run_ack       ( o_cpu_run_ack ),     // Core response to run req

           .dec_tlu_perfcnt0(dec_tlu_perfcnt0),
           .dec_tlu_perfcnt1(dec_tlu_perfcnt1),
           .dec_tlu_perfcnt2(dec_tlu_perfcnt2),
           .dec_tlu_perfcnt3(dec_tlu_perfcnt3),

           .scan_mode           ( 1'b0 ),         // To enable scan mode
           .mbist_mode          ( 1'b0 )        // to enable mbist

         );

initial begin
  `FORCE rvtop.dccm_rd_data_hi = '0;
  `FORCE rvtop.dccm_rd_data_lo = '0;
end


   //=========================================================================-
   // AHB I$ instance
   //=========================================================================-
  parameter MASTERS =3;
  parameter SLAVES  =2;
  parameter HADDR_SIZE = 32;
  parameter HDATA_SIZE = 64;
/*
  logic [           2:0] mst_priority  [MASTERS] ;
  logic                  mst_HSEL      [MASTERS] ;
  logic [HADDR_SIZE-1:0] mst_HADDR     [MASTERS] ;
  logic [HDATA_SIZE-1:0] mst_HWDATA    [MASTERS] ;
  logic [HDATA_SIZE-1:0] mst_HRDATA    [MASTERS] ;
  logic                  mst_HWRITE    [MASTERS] ;
  logic [           2:0] mst_HSIZE     [MASTERS] ;
  logic [           2:0] mst_HBURST    [MASTERS] ;
  logic [           3:0] mst_HPROT     [MASTERS] ;
  logic [           1:0] mst_HTRANS    [MASTERS] ;
  logic                  mst_HMASTLOCK [MASTERS] ;
  logic                  mst_HREADYOUT [MASTERS] ;
  logic                  mst_HREADY    [MASTERS] ;
  logic                  mst_HRESP     [MASTERS] ;

  //Slave Ports; AHB Slaves connect to these
  //  thus these are actually AHB Master Interfaces
  logic [HADDR_SIZE-1:0] slv_addr_mask [SLAVES] ;
  logic [HADDR_SIZE-1:0] slv_addr_base [SLAVES] ;

  logic                  slv_HSEL      [SLAVES] ;
  logic [HADDR_SIZE-1:0] slv_HADDR     [SLAVES] ;
  logic [HDATA_SIZE-1:0] slv_HWDATA    [SLAVES] ;
  logic [HDATA_SIZE-1:0] slv_HRDATA    [SLAVES] ;
  logic                  slv_HWRITE    [SLAVES] ;
  logic [           2:0] slv_HSIZE     [SLAVES] ;
  logic [           2:0] slv_HBURST    [SLAVES] ;
  logic [           3:0] slv_HPROT     [SLAVES] ;
  logic [           1:0] slv_HTRANS    [SLAVES] ;
  logic                  slv_HMASTLOCK [SLAVES] ;
  logic                  slv_HREADYOUT [SLAVES] ; //HREADYOUT to slave-decoder; generates HREADY to all connected slaves
  logic                  slv_HREADY    [SLAVES] ; //combinatorial HREADY from all connected slaves
  logic                  slv_HRESP     [SLAVES] ;

  assign mst_priority[0] = 3'b000;
  assign mst_priority[1] = 3'b010;
  assign mst_priority[2] = 3'b100;
  assign mst_HSEL[0]     = 1'b1;
  assign mst_HSEL[1]     = 1'b1;
  assign mst_HSEL[2]     = 1'b1;

  assign mst_HADDR[0]    = lsu_haddr       ; 
  assign mst_HWDATA[0]   = lsu_hwdata      ;
  assign lsu_hrdata      = mst_HRDATA[0]   ;
  assign mst_HWRITE[0]   = lsu_hwrite      ;
  assign mst_HSIZE[0]    = lsu_hsize       ;
  assign mst_HBURST[0]   = lsu_hburst      ;
  assign mst_HPROT[0]    = lsu_hprot       ;
  assign mst_HTRANS[0]   = lsu_htrans      ;
  assign mst_HMASTLOCK[0] = lsu_hmastlock  ;
  assign lsu_hready       = mst_HREADYOUT[0]  ;
  assign lsu_hresp        = mst_HRESP[0]   ;
  assign mst_HREADY[0]    = 1'b1           ;

  assign mst_HADDR[1]     = ic_haddr       ; 
  assign mst_HWDATA[1]    = ic_hwdata      ;
  assign ic_hrdata        = mst_HRDATA[1]  ;
  assign mst_HWRITE[1]    = ic_hwrite      ;
  assign mst_HSIZE[1]     = ic_hsize       ;
  assign mst_HBURST[1]    = ic_hburst      ;
  assign mst_HPROT[1]     = ic_hprot       ;
  assign mst_HTRANS[1]    = ic_htrans      ;
  assign mst_HMASTLOCK[1] = ic_hmastlock   ;
  assign ic_hready        = mst_HREADYOUT[1]  ;
  assign ic_hresp         = mst_HRESP[1]   ;
  assign mst_HREADY[1]    = 1'b1           ;

  assign mst_HADDR[2]     = sb_haddr       ; 
  assign mst_HWDATA[2]    = sb_hwdata      ;
  assign sb_hrdata        = mst_HRDATA[2]  ;
  assign mst_HWRITE[2]    = sb_hwrite      ;
  assign mst_HSIZE[2]     = sb_hsize       ;
  assign mst_HBURST[2]    = sb_hburst      ;
  assign mst_HPROT[2]     = sb_hprot       ;
  assign mst_HTRANS[2]    = sb_htrans      ;
  assign mst_HMASTLOCK[2] = sb_hmastlock   ;
  assign sb_hready        = mst_HREADYOUT[2]  ;
  assign sb_hresp         = mst_HRESP[2]   ;
  assign mst_HREADY[2]    = 1'b1           ;


  assign slv_addr_mask[0]  = 32'h00000000   ;
  assign slv_addr_base[0]  = 32'h00000080   ;
  assign Slave_hsel       = slv_HSEL[0]    ;
  assign Slave_haddr      = slv_HADDR[0]   ;
  assign Slave_hwdata     = slv_HWDATA[0]  ;
  assign slv_HRDATA[0]    = Slave_hrdata   ;
  assign Slave_hwrite     = slv_HWRITE[0]  ;
  assign Slave_hsize      = slv_HSIZE[0]   ;
  assign Slave_hburst     = slv_HBURST[0]  ;
  assign Slave_hprot      = slv_HPROT[0]   ;
  assign Slave_htrans     = slv_HTRANS[0]  ;
  assign Slave_hmastlock  = slv_HMASTLOCK[0] ;
  assign Slave_hready     = slv_HREADYOUT[0] ;
  assign slv_HREADY[0]     = Slave_hready_resp;
  assign slv_HRESP[0]      = Slave_hresp;

  assign slv_addr_mask[1]  = 32'hffffff80   ;
  assign slv_addr_base[1]  = 32'h00000000   ;
  assign slv_HRDATA[1]     = 'd0   ;
  assign slv_HREADY[1]     = 1'b1;
  assign slv_HRESP[1]      = 1'b0;




  


  ahb3lite_interconnect  
  #(.HADDR_SIZE            (32               ),
    .HDATA_SIZE            (64               ),
    .MASTERS               (3                ),
    .SLAVES                (2                ))
  i_ahb_3to1
  (
    .HRESETn               (reset_l                          ),
    .HCLK                  (core_clk                         ),
    .mst_priority          (mst_priority                     ),
                                            
    .mst_HSEL              (mst_HSEL                         ),
    .mst_HADDR             (mst_HADDR                        ),
    .mst_HWDATA            (mst_HWDATA                       ),
    .mst_HRDATA            (mst_HRDATA                       ),
    .mst_HWRITE            (mst_HWRITE                       ),
    .mst_HSIZE             (mst_HSIZE                        ),
    .mst_HBURST            (mst_HBURST                       ),
    .mst_HPROT             (mst_HPROT                        ),
    .mst_HTRANS            (mst_HTRANS                       ),
    .mst_HMASTLOCK         (mst_HMASTLOCK                    ),
    .mst_HREADYOUT         (mst_HREADYOUT                    ),
    .mst_HREADY            (mst_HREADY                       ),
    .mst_HRESP             (mst_HRESP                        ),

    .slv_addr_mask         (slv_addr_mask         ),
    .slv_addr_base         (slv_addr_base         ),
                                          
    .slv_HSEL              (slv_HSEL              ),
    .slv_HADDR             (slv_HADDR             ),
    .slv_HWDATA            (slv_HWDATA            ),
    .slv_HRDATA            (slv_HRDATA            ),
    .slv_HWRITE            (slv_HWRITE            ),
    .slv_HSIZE             (slv_HSIZE             ),
    .slv_HBURST            (slv_HBURST            ),
    .slv_HPROT             (slv_HPROT             ),
    .slv_HTRANS            (slv_HTRANS            ),
    .slv_HMASTLOCK         (slv_HMASTLOCK         ),
    .slv_HREADYOUT         (slv_HREADYOUT         ), //HREADYOUT to slave-decoder; generates HREADY to all connected slaves
    .slv_HREADY            (slv_HREADY            ), //combinatorial HREADY from all connected slaves
    .slv_HRESP             (slv_HRESP             )
);

*/








  ahb_3to1 i_ahb_3to1 
  (
      .HCLK_hclk                        (core_clk                                    ),
      .HRESETn_hresetn                  (reset_l                                     ),

      .ex_i_ahb_1_AHB_Master_haddr      (lsu_haddr                                   ),
      .ex_i_ahb_1_AHB_Master_hburst     (lsu_hburst                                  ),
      .ex_i_ahb_1_AHB_Master_hlock      (lsu_hmastlock                                   ),
      .ex_i_ahb_1_AHB_Master_hprot      (lsu_hprot                                   ),
      .ex_i_ahb_1_AHB_Master_hsize      (lsu_hsize                                   ),
      .ex_i_ahb_1_AHB_Master_htrans     (lsu_htrans                                  ),
      .ex_i_ahb_1_AHB_Master_hwdata     (lsu_hwdata                                  ),
      .ex_i_ahb_1_AHB_Master_hwrite     (lsu_hwrite                                  ),
      .ex_i_ahb_1_AHB_Master_hrdata     (lsu_hrdata                                  ),
      .ex_i_ahb_1_AHB_Master_hready     (lsu_hready                                  ),
      .ex_i_ahb_1_AHB_Master_hresp      ({tmp0,lsu_hresp }                                  ),

      .ex_i_ahb_2_AHB_Master_haddr      (ic_haddr                                   ),
      .ex_i_ahb_2_AHB_Master_hburst     (ic_hburst                                  ),
      .ex_i_ahb_2_AHB_Master_hlock      (ic_hmastlock                                   ),
      .ex_i_ahb_2_AHB_Master_hprot      (ic_hprot                                   ),
      .ex_i_ahb_2_AHB_Master_hsize      (ic_hsize                                   ),
      .ex_i_ahb_2_AHB_Master_htrans     (ic_htrans                                  ),
      .ex_i_ahb_2_AHB_Master_hwdata     (ic_hwdata                                  ),
      .ex_i_ahb_2_AHB_Master_hwrite     (ic_hwrite                                  ),
      .ex_i_ahb_2_AHB_Master_hrdata     (ic_hrdata                                  ),
      .ex_i_ahb_2_AHB_Master_hready     (ic_hready                                  ),
      .ex_i_ahb_2_AHB_Master_hresp      ({tmp1,ic_hresp }                                  ),

      .ex_i_ahb_AHB_Master_haddr      (sb_haddr                                   ),
      .ex_i_ahb_AHB_Master_hburst     (sb_hburst                                  ),
      .ex_i_ahb_AHB_Master_hlock      (sb_hmastlock                               ),
      .ex_i_ahb_AHB_Master_hprot      (sb_hprot                                   ),
      .ex_i_ahb_AHB_Master_hsize      (sb_hsize                                   ),
      .ex_i_ahb_AHB_Master_htrans     (sb_htrans                                  ),
      .ex_i_ahb_AHB_Master_hwdata     (sb_hwdata                                  ),
      .ex_i_ahb_AHB_Master_hwrite     (sb_hwrite                                  ),
      .ex_i_ahb_AHB_Master_hrdata     (sb_hrdata                                  ),
      .ex_i_ahb_AHB_Master_hready     (sb_hready                                  ),
      .ex_i_ahb_AHB_Master_hresp      ({tmp2,sb_hresp}                             ),

      .ex_i_icm_AHB_Slave_hrdata       (Slave_hrdata                         ) ,
      .ex_i_icm_AHB_Slave_hready_resp  (Slave_hready_resp                    ) ,
      .ex_i_icm_AHB_Slave_hresp        ({1'b0,Slave_hresp}                   ) ,
      .ex_i_icm_AHB_Slave_haddr        (Slave_haddr                          ) ,
      .ex_i_icm_AHB_Slave_hburst       (Slave_hburst                         ) ,
      .ex_i_icm_AHB_Slave_hmastlock    (Slave_hmastlock                      ) ,  //
      .ex_i_icm_AHB_Slave_hprot        (Slave_hprot                          ) ,
      .ex_i_icm_AHB_Slave_hready       (Slave_hready                         ) ,
      .ex_i_icm_AHB_Slave_hsel         (Slave_hsel                           ) ,
      .ex_i_icm_AHB_Slave_hsize        (Slave_hsize                          ) ,
      .ex_i_icm_AHB_Slave_htrans       (Slave_htrans                         ) ,
      .ex_i_icm_AHB_Slave_hwdata       (Slave_hwdata                         ) ,
      .ex_i_icm_AHB_Slave_hwrite       (Slave_hwrite                         ) ,


      .i_ahb_1_hmaster_data            (                                          ) ,
      .i_ahb_2_hmaster_data            (                                          ) ,
      .i_ahb_hmaster_data              (                                          ) 
  );




ahb3lite_sram1rw #(
            .MEM_SIZE          (0           ),   //Memory in Bytes
            .MEM_DEPTH         (16384       ), //Memory depth
            .HADDR_SIZE        (32          ),
            .HDATA_SIZE        (64          ),
            .TECHNOLOGY        ("GENERIC"   ),
            .REGISTERED_OUTPUT ("NO"        )
) i_ahb_lsu
(/**/
            .HRESETn                        (reset_l                            ),
            .HCLK                           (core_clk                           ),
            // Outputs
            .HRDATA                         (Slave_hrdata[63:0]               ),
            .HREADYOUT                      (Slave_hready_resp                ),
            .HRESP                          (Slave_hresp                      ),  // sys_mem_hresp = {0,sys_mem_hresp_t}
            // Inputs
            .HSEL                           (1'b1                             ),
            .HADDR                          (Slave_haddr[31:0]                ),
            .HBURST                         (Slave_hburst[2:0]                ),
            .HPROT                          (Slave_hprot[3:0]                 ),
            .HREADY                         (Slave_hready                     ),
            .HSIZE                          (Slave_hsize[2:0]                 ),
            .HTRANS                         (Slave_htrans[1:0]                ),
            .HWDATA                         (Slave_hwdata[63:0]               ),
            .HWRITE                         (Slave_hwrite                     )
        );
                    



logic [31:0] pc0;
logic [31:0] pc1;

assign pc0 = {rvtop.swerv.exu.dec_i0_pc_d,1'b0};
assign pc1 = {rvtop.swerv.exu.dec_i1_pc_d,1'b0};







endmodule
