#  NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
#  This is an automatically generated file by wjfan on Mon Mar 11 15:41:56 CST 2019
# 
#  cmd:    swerv -snapshot=mybuild -ahb 
# 
# To use this in a perf script, use 'require $RV_ROOT/configs/config.pl'
# Reference the hash via $config{name}..


%config = (
            'triggers' => [
                            {
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
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
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
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
                            }
                          ],
            'core' => {
                        'lsu_num_nbload_width' => '2',
                        'opensource' => '1',
                        'dec_instbuf_depth' => '4',
                        'lsu_wrbuf_depth' => '4',
                        'dma_buf_depth' => '2',
                        'lsu_num_nbload' => '4',
                        'lsu_stbuf_depth' => '8'
                      },
            'csr' => {
                       'mhpmevent6' => {
                                         'exists' => 'true',
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff'
                                       },
                       'pmpcfg3' => {
                                      'exists' => 'false'
                                    },
                       'misa' => {
                                   'reset' => '0x40001104',
                                   'exists' => 'true',
                                   'mask' => '0x0'
                                 },
                       'pmpaddr8' => {
                                       'exists' => 'false'
                                     },
                       'dcsr' => {
                                   'exists' => 'true',
                                   'reset' => '0x40000003',
                                   'mask' => '0x00008c04',
                                   'poke_mask' => '0x00008dcc'
                                 },
                       'cycle' => {
                                    'exists' => 'false'
                                  },
                       'pmpaddr7' => {
                                       'exists' => 'false'
                                     },
                       'dicad0' => {
                                     'reset' => '0x0',
                                     'debug' => 'true',
                                     'exists' => 'true',
                                     'comment' => 'Cache diagnostics.',
                                     'number' => '0x7c9',
                                     'mask' => '0xffffffff'
                                   },
                       'mvendorid' => {
                                        'exists' => 'true',
                                        'reset' => '0x45',
                                        'mask' => '0x0'
                                      },
                       'mhpmevent4' => {
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0',
                                         'exists' => 'true'
                                       },
                       'mdccmect' => {
                                       'mask' => '0xffffffff',
                                       'number' => '0x7f2',
                                       'reset' => '0x0',
                                       'exists' => 'true'
                                     },
                       'tselect' => {
                                      'exists' => 'true',
                                      'reset' => '0x0',
                                      'mask' => '0x3'
                                    },
                       'dicad1' => {
                                     'number' => '0x7ca',
                                     'mask' => '0x3',
                                     'exists' => 'true',
                                     'comment' => 'Cache diagnostics.',
                                     'reset' => '0x0',
                                     'debug' => 'true'
                                   },
                       'pmpcfg2' => {
                                      'exists' => 'false'
                                    },
                       'mip' => {
                                  'reset' => '0x0',
                                  'exists' => 'true',
                                  'poke_mask' => '0x40000888',
                                  'mask' => '0x0'
                                },
                       'mcpc' => {
                                   'exists' => 'true',
                                   'reset' => '0x0',
                                   'mask' => '0x0',
                                   'number' => '0x7c2'
                                 },
                       'pmpaddr10' => {
                                        'exists' => 'false'
                                      },
                       'miccmect' => {
                                       'exists' => 'true',
                                       'reset' => '0x0',
                                       'number' => '0x7f1',
                                       'mask' => '0xffffffff'
                                     },
                       'mhpmcounter3' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'mhpmcounter5' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'pmpaddr13' => {
                                        'exists' => 'false'
                                      },
                       'marchid' => {
                                      'reset' => '0x0000000b',
                                      'exists' => 'true',
                                      'mask' => '0x0'
                                    },
                       'mhpmcounter3h' => {
                                            'reset' => '0x0',
                                            'exists' => 'true',
                                            'mask' => '0xffffffff'
                                          },
                       'dicago' => {
                                     'exists' => 'true',
                                     'comment' => 'Cache diagnostics.',
                                     'reset' => '0x0',
                                     'debug' => 'true',
                                     'number' => '0x7cb',
                                     'mask' => '0x0'
                                   },
                       'meicurpl' => {
                                       'mask' => '0xf',
                                       'number' => '0xbcc',
                                       'reset' => '0x0',
                                       'comment' => 'External interrupt current priority level.',
                                       'exists' => 'true'
                                     },
                       'mimpid' => {
                                     'exists' => 'true',
                                     'reset' => '0x1',
                                     'mask' => '0x0'
                                   },
                       'pmpaddr12' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr6' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr0' => {
                                       'exists' => 'false'
                                     },
                       'mcgc' => {
                                   'mask' => '0x000001ff',
                                   'number' => '0x7f8',
                                   'poke_mask' => '0x000001ff',
                                   'exists' => 'true',
                                   'reset' => '0x0'
                                 },
                       'mhpmcounter5h' => {
                                            'mask' => '0xffffffff',
                                            'exists' => 'true',
                                            'reset' => '0x0'
                                          },
                       'mhpmcounter6h' => {
                                            'exists' => 'true',
                                            'reset' => '0x0',
                                            'mask' => '0xffffffff'
                                          },
                       'mhpmcounter4' => {
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0',
                                           'exists' => 'true'
                                         },
                       'pmpaddr11' => {
                                        'exists' => 'false'
                                      },
                       'instret' => {
                                      'exists' => 'false'
                                    },
                       'mfdc' => {
                                   'reset' => '0x0',
                                   'exists' => 'true',
                                   'number' => '0x7f9',
                                   'mask' => '0x000007ff'
                                 },
                       'pmpaddr2' => {
                                       'exists' => 'false'
                                     },
                       'micect' => {
                                     'mask' => '0xffffffff',
                                     'number' => '0x7f0',
                                     'reset' => '0x0',
                                     'exists' => 'true'
                                   },
                       'mie' => {
                                  'mask' => '0x40000888',
                                  'exists' => 'true',
                                  'reset' => '0x0'
                                },
                       'meicidpl' => {
                                       'mask' => '0xf',
                                       'number' => '0xbcb',
                                       'reset' => '0x0',
                                       'comment' => 'External interrupt claim id priority level.',
                                       'exists' => 'true'
                                     },
                       'time' => {
                                   'exists' => 'false'
                                 },
                       'meicpct' => {
                                      'number' => '0xbca',
                                      'mask' => '0x0',
                                      'exists' => 'true',
                                      'comment' => 'External claim id/priority capture.',
                                      'reset' => '0x0'
                                    },
                       'pmpcfg1' => {
                                      'exists' => 'false'
                                    },
                       'pmpcfg0' => {
                                      'exists' => 'false'
                                    },
                       'mstatus' => {
                                      'mask' => '0x88',
                                      'exists' => 'true',
                                      'reset' => '0x1800'
                                    },
                       'mhpmcounter4h' => {
                                            'exists' => 'true',
                                            'reset' => '0x0',
                                            'mask' => '0xffffffff'
                                          },
                       'pmpaddr14' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr3' => {
                                       'exists' => 'false'
                                     },
                       'mhpmcounter6' => {
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0',
                                           'exists' => 'true'
                                         },
                       'meipt' => {
                                    'mask' => '0xf',
                                    'number' => '0xbc9',
                                    'reset' => '0x0',
                                    'comment' => 'External interrupt priority threshold.',
                                    'exists' => 'true'
                                  },
                       'pmpaddr15' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr5' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr4' => {
                                       'exists' => 'false'
                                     },
                       'mhpmevent3' => {
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0',
                                         'exists' => 'true'
                                       },
                       'pmpaddr1' => {
                                       'exists' => 'false'
                                     },
                       'mhpmevent5' => {
                                         'exists' => 'true',
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff'
                                       },
                       'dmst' => {
                                   'mask' => '0x0',
                                   'number' => '0x7c4',
                                   'debug' => 'true',
                                   'reset' => '0x0',
                                   'comment' => 'Memory synch trigger: Flush caches in debug mode.',
                                   'exists' => 'true'
                                 },
                       'pmpaddr9' => {
                                       'exists' => 'false'
                                     },
                       'mpmc' => {
                                   'mask' => '0x0',
                                   'number' => '0x7c6',
                                   'reset' => '0x0',
                                   'comment' => 'Core pause: Implemented as read only.',
                                   'exists' => 'true'
                                 },
                       'dicawics' => {
                                       'number' => '0x7c8',
                                       'mask' => '0x0130fffc',
                                       'exists' => 'true',
                                       'comment' => 'Cache diagnostics.',
                                       'debug' => 'true',
                                       'reset' => '0x0'
                                     }
                     },
            'bht' => {
                       'bht_size' => 128,
                       'bht_hash_string' => '{ghr[3:2] ^ {ghr[3+1], {4-1-2{1\'b0}}},hashin[5:4]^ghr[2-1:0]}',
                       'bht_ghr_pad' => 'fghr[4],3\'b0',
                       'bht_addr_lo' => '4',
                       'bht_array_depth' => 16,
                       'bht_addr_hi' => 7,
                       'bht_ghr_pad2' => 'fghr[4:3],2\'b0',
                       'bht_ghr_size' => 5,
                       'bht_ghr_range' => '4:0'
                     },
            'nmi_vec' => '0x11110000',
            'numiregs' => '32',
            'even_odd_trigger_chains' => 'true',
            'tec_rv_icg' => 'clockhdr',
            'xlen' => 32,
            'harts' => 1,
            'regwidth' => '32',
            'iccm' => {
                        'iccm_bank_bits' => 3,
                        'iccm_eadr' => '0xee07ffff',
                        'iccm_offset' => '0xe000000',
                        'iccm_region' => '0xe',
                        'iccm_bits' => 19,
                        'iccm_size' => 512,
                        'iccm_size_512' => '',
                        'iccm_reserved' => '0x1000',
                        'iccm_data_cell' => 'ram_16384x39',
                        'iccm_index_bits' => 14,
                        'iccm_num_banks' => '8',
                        'iccm_sadr' => '0xee000000',
                        'iccm_rows' => '16384',
                        'iccm_num_banks_8' => ''
                      },
            'target' => 'default',
            'dccm' => {
                        'dccm_eadr' => '0xf0087fff',
                        'lsu_sb_bits' => 15,
                        'dccm_byte_width' => '4',
                        'dccm_num_banks_8' => '',
                        'dccm_rows' => '1024',
                        'dccm_region' => '0xf',
                        'dccm_offset' => '0x80000',
                        'dccm_data_width' => 32,
                        'dccm_fdata_width' => 39,
                        'dccm_reserved' => '0x1000',
                        'dccm_bits' => 15,
                        'dccm_ecc_width' => 7,
                        'dccm_size_32' => '',
                        'dccm_enable' => '1',
                        'dccm_num_banks' => '8',
                        'dccm_size' => 32,
                        'dccm_width_bits' => 2,
                        'dccm_sadr' => '0xf0080000',
                        'dccm_data_cell' => 'ram_1024x39',
                        'dccm_index_bits' => 10,
                        'dccm_bank_bits' => 3
                      },
            'memmap' => {
                          'debug_sb_mem' => '0xb0580000',
                          'serialio' => '0xd0580000',
                          'external_prog' => '0xb0000000',
                          'external_data_1' => '0x00000000',
                          'external_data' => '0xc0580000'
                        },
            'icache' => {
                          'icache_tag_cell' => 'ram_64x21',
                          'icache_size' => 16,
                          'icache_tag_low' => '6',
                          'icache_ic_rows' => '256',
                          'icache_enable' => '1',
                          'icache_taddr_high' => 5,
                          'icache_ic_index' => 8,
                          'icache_tag_depth' => 64,
                          'icache_ic_depth' => 8,
                          'icache_tag_high' => 12,
                          'icache_data_cell' => 'ram_256x34'
                        },
            'max_mmode_perf_event' => '50',
            'testbench' => {
                             'ext_addrwidth' => '32',
                             'build_ahb_lite' => 1,
                             'clock_period' => '100',
                             'CPU_TOP' => '`RV_TOP.swerv',
                             'TOP' => 'tb_top',
                             'RV_TOP' => '`TOP.rvtop',
                             'ext_datawidth' => '64',
                             'sterr_rollback' => '0',
                             'datawidth' => '64',
                             'lderr_rollback' => '1'
                           },
            'num_mmode_perf_regs' => '4',
            'bus' => {
                       'dma_bus_tag' => '1',
                       'lsu_bus_id' => '1',
                       'lsu_bus_tag' => 3,
                       'dma_bus_id' => '1',
                       'dma_bus_prty' => '1',
                       'ifu_bus_id' => '1',
                       'sb_bus_id' => '1',
                       'sb_bus_prty' => '1',
                       'lsu_bus_prty' => '1',
                       'sb_bus_tag' => '1',
                       'ifu_bus_prty' => '1',
                       'ifu_bus_tag' => '3'
                     },
            'reset_vec' => '0x80000000',
            'pic' => {
                       'pic_offset' => '0x100000',
                       'pic_meip_offset' => '0x1000',
                       'pic_int_words' => 1,
                       'pic_total_int_plus1' => 9,
                       'pic_base_addr' => '0xf0100000',
                       'pic_size' => 32,
                       'pic_meigwctrl_offset' => '0x4000',
                       'pic_meipl_offset' => '0x0000',
                       'pic_bits' => 15,
                       'pic_meipt_offset' => '0x3004',
                       'pic_mpiccfg_offset' => '0x3000',
                       'pic_meigwclr_offset' => '0x5000',
                       'pic_total_int' => 8,
                       'pic_meie_offset' => '0x2000',
                       'pic_region' => '0xf'
                     },
            'physical' => '1',
            'retstack' => {
                            'ret_stack_size' => '4'
                          },
            'btb' => {
                       'btb_addr_hi' => 5,
                       'btb_index2_lo' => 6,
                       'btb_btag_fold' => 1,
                       'btb_index3_lo' => 8,
                       'btb_size' => 32,
                       'btb_index1_hi' => 5,
                       'btb_index3_hi' => 9,
                       'btb_index1_lo' => '4',
                       'btb_index2_hi' => 7,
                       'btb_btag_size' => 9,
                       'btb_addr_lo' => '4',
                       'btb_array_depth' => 4
                     }
          );
1;
