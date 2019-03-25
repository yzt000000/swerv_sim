#  NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
#  This is an automatically generated file by wjfan on Tue Mar 19 16:51:18 CST 2019
# 
#  cmd:    swerv -set reset_vec=0x0 -snapshot=mybuild 
# 
# To use this in a perf script, use 'require $RV_ROOT/configs/config.pl'
# Reference the hash via $config{name}..


%config = (
            'reset_vec' => '0x0',
            'core' => {
                        'lsu_num_nbload_width' => '2',
                        'dma_buf_depth' => '2',
                        'dec_instbuf_depth' => '4',
                        'opensource' => '1',
                        'lsu_num_nbload' => '4',
                        'lsu_stbuf_depth' => '8',
                        'lsu_wrbuf_depth' => '4'
                      },
            'harts' => 1,
            'max_mmode_perf_event' => '50',
            'csr' => {
                       'pmpaddr6' => {
                                       'exists' => 'false'
                                     },
                       'mhpmevent5' => {
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0',
                                         'exists' => 'true'
                                       },
                       'pmpcfg3' => {
                                      'exists' => 'false'
                                    },
                       'mie' => {
                                  'exists' => 'true',
                                  'mask' => '0x40000888',
                                  'reset' => '0x0'
                                },
                       'instret' => {
                                      'exists' => 'false'
                                    },
                       'mhpmcounter5h' => {
                                            'reset' => '0x0',
                                            'mask' => '0xffffffff',
                                            'exists' => 'true'
                                          },
                       'misa' => {
                                   'exists' => 'true',
                                   'reset' => '0x40001104',
                                   'mask' => '0x0'
                                 },
                       'mhpmcounter6h' => {
                                            'exists' => 'true',
                                            'reset' => '0x0',
                                            'mask' => '0xffffffff'
                                          },
                       'pmpcfg2' => {
                                      'exists' => 'false'
                                    },
                       'pmpaddr11' => {
                                        'exists' => 'false'
                                      },
                       'meicidpl' => {
                                       'mask' => '0xf',
                                       'reset' => '0x0',
                                       'comment' => 'External interrupt claim id priority level.',
                                       'exists' => 'true',
                                       'number' => '0xbcb'
                                     },
                       'mdccmect' => {
                                       'number' => '0x7f2',
                                       'exists' => 'true',
                                       'reset' => '0x0',
                                       'mask' => '0xffffffff'
                                     },
                       'meipt' => {
                                    'mask' => '0xf',
                                    'reset' => '0x0',
                                    'exists' => 'true',
                                    'comment' => 'External interrupt priority threshold.',
                                    'number' => '0xbc9'
                                  },
                       'mimpid' => {
                                     'exists' => 'true',
                                     'mask' => '0x0',
                                     'reset' => '0x1'
                                   },
                       'pmpaddr0' => {
                                       'exists' => 'false'
                                     },
                       'mhpmcounter3h' => {
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0',
                                            'exists' => 'true'
                                          },
                       'mip' => {
                                  'mask' => '0x0',
                                  'reset' => '0x0',
                                  'exists' => 'true',
                                  'poke_mask' => '0x40000888'
                                },
                       'cycle' => {
                                    'exists' => 'false'
                                  },
                       'pmpaddr13' => {
                                        'exists' => 'false'
                                      },
                       'mhpmcounter5' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'meicurpl' => {
                                       'comment' => 'External interrupt current priority level.',
                                       'exists' => 'true',
                                       'number' => '0xbcc',
                                       'reset' => '0x0',
                                       'mask' => '0xf'
                                     },
                       'mpmc' => {
                                   'number' => '0x7c6',
                                   'exists' => 'true',
                                   'comment' => 'Core pause: Implemented as read only.',
                                   'reset' => '0x0',
                                   'mask' => '0x0'
                                 },
                       'pmpaddr14' => {
                                        'exists' => 'false'
                                      },
                       'dicad0' => {
                                     'mask' => '0xffffffff',
                                     'reset' => '0x0',
                                     'debug' => 'true',
                                     'exists' => 'true',
                                     'comment' => 'Cache diagnostics.',
                                     'number' => '0x7c9'
                                   },
                       'pmpaddr5' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr3' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr8' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr12' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr15' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr9' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr10' => {
                                        'exists' => 'false'
                                      },
                       'tselect' => {
                                      'reset' => '0x0',
                                      'mask' => '0x3',
                                      'exists' => 'true'
                                    },
                       'dicawics' => {
                                       'mask' => '0x0130fffc',
                                       'reset' => '0x0',
                                       'debug' => 'true',
                                       'comment' => 'Cache diagnostics.',
                                       'exists' => 'true',
                                       'number' => '0x7c8'
                                     },
                       'pmpaddr2' => {
                                       'exists' => 'false'
                                     },
                       'dmst' => {
                                   'mask' => '0x0',
                                   'reset' => '0x0',
                                   'exists' => 'true',
                                   'comment' => 'Memory synch trigger: Flush caches in debug mode.',
                                   'number' => '0x7c4',
                                   'debug' => 'true'
                                 },
                       'mvendorid' => {
                                        'exists' => 'true',
                                        'mask' => '0x0',
                                        'reset' => '0x45'
                                      },
                       'pmpaddr1' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr7' => {
                                       'exists' => 'false'
                                     },
                       'meicpct' => {
                                      'mask' => '0x0',
                                      'reset' => '0x0',
                                      'exists' => 'true',
                                      'comment' => 'External claim id/priority capture.',
                                      'number' => '0xbca'
                                    },
                       'mhpmcounter4' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'mhpmcounter4h' => {
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0',
                                            'exists' => 'true'
                                          },
                       'mhpmevent6' => {
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff',
                                         'exists' => 'true'
                                       },
                       'mcgc' => {
                                   'mask' => '0x000001ff',
                                   'reset' => '0x0',
                                   'number' => '0x7f8',
                                   'exists' => 'true',
                                   'poke_mask' => '0x000001ff'
                                 },
                       'pmpcfg1' => {
                                      'exists' => 'false'
                                    },
                       'micect' => {
                                     'mask' => '0xffffffff',
                                     'reset' => '0x0',
                                     'number' => '0x7f0',
                                     'exists' => 'true'
                                   },
                       'marchid' => {
                                      'exists' => 'true',
                                      'reset' => '0x0000000b',
                                      'mask' => '0x0'
                                    },
                       'mhpmevent3' => {
                                         'exists' => 'true',
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0'
                                       },
                       'mcpc' => {
                                   'exists' => 'true',
                                   'number' => '0x7c2',
                                   'reset' => '0x0',
                                   'mask' => '0x0'
                                 },
                       'mhpmcounter6' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'miccmect' => {
                                       'reset' => '0x0',
                                       'mask' => '0xffffffff',
                                       'exists' => 'true',
                                       'number' => '0x7f1'
                                     },
                       'dcsr' => {
                                   'mask' => '0x00008c04',
                                   'reset' => '0x40000003',
                                   'exists' => 'true',
                                   'poke_mask' => '0x00008dcc'
                                 },
                       'dicago' => {
                                     'mask' => '0x0',
                                     'reset' => '0x0',
                                     'comment' => 'Cache diagnostics.',
                                     'exists' => 'true',
                                     'number' => '0x7cb',
                                     'debug' => 'true'
                                   },
                       'pmpaddr4' => {
                                       'exists' => 'false'
                                     },
                       'mhpmevent4' => {
                                         'exists' => 'true',
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0'
                                       },
                       'mhpmcounter3' => {
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0',
                                           'exists' => 'true'
                                         },
                       'pmpcfg0' => {
                                      'exists' => 'false'
                                    },
                       'dicad1' => {
                                     'reset' => '0x0',
                                     'mask' => '0x3',
                                     'debug' => 'true',
                                     'comment' => 'Cache diagnostics.',
                                     'exists' => 'true',
                                     'number' => '0x7ca'
                                   },
                       'mfdc' => {
                                   'number' => '0x7f9',
                                   'exists' => 'true',
                                   'reset' => '0x0',
                                   'mask' => '0x000007ff'
                                 },
                       'mstatus' => {
                                      'exists' => 'true',
                                      'reset' => '0x1800',
                                      'mask' => '0x88'
                                    },
                       'time' => {
                                   'exists' => 'false'
                                 }
                     },
            'icache' => {
                          'icache_ic_index' => 8,
                          'icache_size' => 16,
                          'icache_tag_low' => '6',
                          'icache_ic_depth' => 8,
                          'icache_tag_depth' => 64,
                          'icache_taddr_high' => 5,
                          'icache_data_cell' => 'ram_256x34',
                          'icache_tag_cell' => 'ram_64x21',
                          'icache_tag_high' => 12,
                          'icache_enable' => '1',
                          'icache_ic_rows' => '256'
                        },
            'testbench' => {
                             'clock_period' => '100',
                             'CPU_TOP' => '`RV_TOP.swerv',
                             'lderr_rollback' => '1',
                             'ext_addrwidth' => '32',
                             'ext_datawidth' => '64',
                             'TOP' => 'tb_top',
                             'RV_TOP' => '`TOP.rvtop',
                             'build_axi4' => '',
                             'sterr_rollback' => '0',
                             'datawidth' => '64'
                           },
            'bus' => {
                       'sb_bus_id' => '1',
                       'dma_bus_id' => '1',
                       'ifu_bus_prty' => '1',
                       'dma_bus_prty' => '1',
                       'lsu_bus_prty' => '1',
                       'dma_bus_tag' => '1',
                       'ifu_bus_tag' => '3',
                       'ifu_bus_id' => '1',
                       'lsu_bus_tag' => 3,
                       'sb_bus_prty' => '1',
                       'lsu_bus_id' => '1',
                       'sb_bus_tag' => '1'
                     },
            'tec_rv_icg' => 'clockhdr',
            'numiregs' => '32',
            'num_mmode_perf_regs' => '4',
            'dccm' => {
                        'dccm_size' => 32,
                        'dccm_width_bits' => 2,
                        'dccm_reserved' => '0x1000',
                        'dccm_region' => '0xf',
                        'lsu_sb_bits' => 15,
                        'dccm_byte_width' => '4',
                        'dccm_data_cell' => 'ram_1024x39',
                        'dccm_enable' => '1',
                        'dccm_eadr' => '0xf0087fff',
                        'dccm_data_width' => 32,
                        'dccm_bank_bits' => 3,
                        'dccm_ecc_width' => 7,
                        'dccm_index_bits' => 10,
                        'dccm_num_banks_8' => '',
                        'dccm_num_banks' => '8',
                        'dccm_bits' => 15,
                        'dccm_offset' => '0x80000',
                        'dccm_sadr' => '0xf0080000',
                        'dccm_fdata_width' => 39,
                        'dccm_size_32' => '',
                        'dccm_rows' => '1024'
                      },
            'iccm' => {
                        'iccm_sadr' => '0xee000000',
                        'iccm_offset' => '0xe000000',
                        'iccm_reserved' => '0x1000',
                        'iccm_rows' => '16384',
                        'iccm_num_banks' => '8',
                        'iccm_bank_bits' => 3,
                        'iccm_size_512' => '',
                        'iccm_region' => '0xe',
                        'iccm_index_bits' => 14,
                        'iccm_eadr' => '0xee07ffff',
                        'iccm_num_banks_8' => '',
                        'iccm_bits' => 19,
                        'iccm_size' => 512,
                        'iccm_data_cell' => 'ram_16384x39'
                      },
            'memmap' => {
                          'serialio' => '0xd0580000',
                          'debug_sb_mem' => '0xb0580000',
                          'external_data_1' => '0x00000000',
                          'external_data' => '0xc0580000',
                          'external_prog' => '0xb0000000'
                        },
            'target' => 'default',
            'bht' => {
                       'bht_ghr_size' => 5,
                       'bht_ghr_pad' => 'fghr[4],3\'b0',
                       'bht_hash_string' => '{ghr[3:2] ^ {ghr[3+1], {4-1-2{1\'b0}}},hashin[5:4]^ghr[2-1:0]}',
                       'bht_ghr_range' => '4:0',
                       'bht_addr_hi' => 7,
                       'bht_size' => 128,
                       'bht_ghr_pad2' => 'fghr[4:3],2\'b0',
                       'bht_addr_lo' => '4',
                       'bht_array_depth' => 16
                     },
            'regwidth' => '32',
            'nmi_vec' => '0x11110000',
            'retstack' => {
                            'ret_stack_size' => '4'
                          },
            'btb' => {
                       'btb_size' => 32,
                       'btb_addr_lo' => '4',
                       'btb_index3_hi' => 9,
                       'btb_index3_lo' => 8,
                       'btb_index2_lo' => 6,
                       'btb_array_depth' => 4,
                       'btb_index2_hi' => 7,
                       'btb_index1_lo' => '4',
                       'btb_addr_hi' => 5,
                       'btb_btag_size' => 9,
                       'btb_index1_hi' => 5,
                       'btb_btag_fold' => 1
                     },
            'xlen' => 32,
            'pic' => {
                       'pic_int_words' => 1,
                       'pic_meie_offset' => '0x2000',
                       'pic_bits' => 15,
                       'pic_region' => '0xf',
                       'pic_meigwctrl_offset' => '0x4000',
                       'pic_offset' => '0x100000',
                       'pic_size' => 32,
                       'pic_meipt_offset' => '0x3004',
                       'pic_meipl_offset' => '0x0000',
                       'pic_base_addr' => '0xf0100000',
                       'pic_mpiccfg_offset' => '0x3000',
                       'pic_meip_offset' => '0x1000',
                       'pic_total_int_plus1' => 9,
                       'pic_total_int' => 8,
                       'pic_meigwclr_offset' => '0x5000'
                     },
            'even_odd_trigger_chains' => 'true',
            'triggers' => [
                            {
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ]
                            },
                            {
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ],
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ]
                            },
                            {
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ]
                            },
                            {
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ],
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ]
                            }
                          ],
            'physical' => '1'
          );
1;
