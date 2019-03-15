#  NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
#  This is an automatically generated file by wjfan on Tue Mar 12 14:48:55 CST 2019
# 
#  cmd:    swerv -snapshot=default -ahb 
# 
# To use this in a perf script, use 'require $RV_ROOT/configs/config.pl'
# Reference the hash via $config{name}..


%config = (
            'numiregs' => '32',
            'btb' => {
                       'btb_size' => 32,
                       'btb_btag_size' => 9,
                       'btb_index1_lo' => '4',
                       'btb_index2_lo' => 6,
                       'btb_index3_hi' => 9,
                       'btb_array_depth' => 4,
                       'btb_addr_hi' => 5,
                       'btb_index3_lo' => 8,
                       'btb_index1_hi' => 5,
                       'btb_addr_lo' => '4',
                       'btb_index2_hi' => 7,
                       'btb_btag_fold' => 1
                     },
            'bus' => {
                       'dma_bus_prty' => '1',
                       'lsu_bus_tag' => 3,
                       'sb_bus_prty' => '1',
                       'sb_bus_id' => '1',
                       'lsu_bus_id' => '1',
                       'dma_bus_id' => '1',
                       'dma_bus_tag' => '1',
                       'ifu_bus_tag' => '3',
                       'sb_bus_tag' => '1',
                       'lsu_bus_prty' => '1',
                       'ifu_bus_id' => '1',
                       'ifu_bus_prty' => '1'
                     },
            'nmi_vec' => '0x11110000',
            'max_mmode_perf_event' => '50',
            'testbench' => {
                             'TOP' => 'tb_top',
                             'CPU_TOP' => '`RV_TOP.swerv',
                             'sterr_rollback' => '0',
                             'ext_datawidth' => '64',
                             'RV_TOP' => '`TOP.rvtop',
                             'clock_period' => '100',
                             'datawidth' => '64',
                             'build_ahb_lite' => 1,
                             'lderr_rollback' => '1',
                             'ext_addrwidth' => '32'
                           },
            'dccm' => {
                        'dccm_reserved' => '0x1000',
                        'dccm_byte_width' => '4',
                        'dccm_data_width' => 32,
                        'dccm_bits' => 15,
                        'dccm_offset' => '0x80000',
                        'dccm_num_banks_8' => '',
                        'dccm_region' => '0xf',
                        'dccm_width_bits' => 2,
                        'dccm_num_banks' => '8',
                        'dccm_size' => 32,
                        'dccm_ecc_width' => 7,
                        'dccm_fdata_width' => 39,
                        'lsu_sb_bits' => 15,
                        'dccm_index_bits' => 10,
                        'dccm_bank_bits' => 3,
                        'dccm_rows' => '1024',
                        'dccm_data_cell' => 'ram_1024x39',
                        'dccm_sadr' => '0xf0080000',
                        'dccm_enable' => '1',
                        'dccm_size_32' => '',
                        'dccm_eadr' => '0xf0087fff'
                      },
            'csr' => {
                       'pmpaddr5' => {
                                       'exists' => 'false'
                                     },
                       'meicpct' => {
                                      'number' => '0xbca',
                                      'comment' => 'External claim id/priority capture.',
                                      'mask' => '0x0',
                                      'exists' => 'true',
                                      'reset' => '0x0'
                                    },
                       'mdccmect' => {
                                       'exists' => 'true',
                                       'reset' => '0x0',
                                       'number' => '0x7f2',
                                       'mask' => '0xffffffff'
                                     },
                       'mip' => {
                                  'poke_mask' => '0x40000888',
                                  'mask' => '0x0',
                                  'exists' => 'true',
                                  'reset' => '0x0'
                                },
                       'dcsr' => {
                                   'poke_mask' => '0x00008dcc',
                                   'mask' => '0x00008c04',
                                   'exists' => 'true',
                                   'reset' => '0x40000003'
                                 },
                       'instret' => {
                                      'exists' => 'false'
                                    },
                       'micect' => {
                                     'number' => '0x7f0',
                                     'mask' => '0xffffffff',
                                     'exists' => 'true',
                                     'reset' => '0x0'
                                   },
                       'mhpmcounter4h' => {
                                            'mask' => '0xffffffff',
                                            'exists' => 'true',
                                            'reset' => '0x0'
                                          },
                       'mhpmevent5' => {
                                         'mask' => '0xffffffff',
                                         'exists' => 'true',
                                         'reset' => '0x0'
                                       },
                       'tselect' => {
                                      'mask' => '0x3',
                                      'exists' => 'true',
                                      'reset' => '0x0'
                                    },
                       'pmpcfg2' => {
                                      'exists' => 'false'
                                    },
                       'mhpmevent4' => {
                                         'mask' => '0xffffffff',
                                         'exists' => 'true',
                                         'reset' => '0x0'
                                       },
                       'dicad1' => {
                                     'mask' => '0x3',
                                     'debug' => 'true',
                                     'comment' => 'Cache diagnostics.',
                                     'number' => '0x7ca',
                                     'reset' => '0x0',
                                     'exists' => 'true'
                                   },
                       'mhpmevent6' => {
                                         'mask' => '0xffffffff',
                                         'exists' => 'true',
                                         'reset' => '0x0'
                                       },
                       'pmpaddr7' => {
                                       'exists' => 'false'
                                     },
                       'meicurpl' => {
                                       'comment' => 'External interrupt current priority level.',
                                       'number' => '0xbcc',
                                       'mask' => '0xf',
                                       'exists' => 'true',
                                       'reset' => '0x0'
                                     },
                       'mhpmcounter4' => {
                                           'reset' => '0x0',
                                           'exists' => 'true',
                                           'mask' => '0xffffffff'
                                         },
                       'pmpaddr4' => {
                                       'exists' => 'false'
                                     },
                       'cycle' => {
                                    'exists' => 'false'
                                  },
                       'mie' => {
                                  'exists' => 'true',
                                  'reset' => '0x0',
                                  'mask' => '0x40000888'
                                },
                       'pmpaddr2' => {
                                       'exists' => 'false'
                                     },
                       'meicidpl' => {
                                       'comment' => 'External interrupt claim id priority level.',
                                       'number' => '0xbcb',
                                       'mask' => '0xf',
                                       'exists' => 'true',
                                       'reset' => '0x0'
                                     },
                       'mhpmcounter3h' => {
                                            'reset' => '0x0',
                                            'exists' => 'true',
                                            'mask' => '0xffffffff'
                                          },
                       'mhpmcounter6' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'mstatus' => {
                                      'exists' => 'true',
                                      'reset' => '0x1800',
                                      'mask' => '0x88'
                                    },
                       'pmpaddr6' => {
                                       'exists' => 'false'
                                     },
                       'marchid' => {
                                      'reset' => '0x0000000b',
                                      'exists' => 'true',
                                      'mask' => '0x0'
                                    },
                       'mhpmcounter5' => {
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0',
                                           'exists' => 'true'
                                         },
                       'pmpaddr0' => {
                                       'exists' => 'false'
                                     },
                       'mhpmcounter3' => {
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0',
                                           'exists' => 'true'
                                         },
                       'pmpaddr10' => {
                                        'exists' => 'false'
                                      },
                       'mfdc' => {
                                   'reset' => '0x0',
                                   'exists' => 'true',
                                   'mask' => '0x000007ff',
                                   'number' => '0x7f9'
                                 },
                       'dmst' => {
                                   'debug' => 'true',
                                   'comment' => 'Memory synch trigger: Flush caches in debug mode.',
                                   'number' => '0x7c4',
                                   'mask' => '0x0',
                                   'exists' => 'true',
                                   'reset' => '0x0'
                                 },
                       'pmpaddr14' => {
                                        'exists' => 'false'
                                      },
                       'dicawics' => {
                                       'reset' => '0x0',
                                       'exists' => 'true',
                                       'mask' => '0x0130fffc',
                                       'number' => '0x7c8',
                                       'debug' => 'true',
                                       'comment' => 'Cache diagnostics.'
                                     },
                       'dicad0' => {
                                     'reset' => '0x0',
                                     'exists' => 'true',
                                     'mask' => '0xffffffff',
                                     'number' => '0x7c9',
                                     'comment' => 'Cache diagnostics.',
                                     'debug' => 'true'
                                   },
                       'pmpaddr13' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr11' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr8' => {
                                       'exists' => 'false'
                                     },
                       'mvendorid' => {
                                        'mask' => '0x0',
                                        'reset' => '0x45',
                                        'exists' => 'true'
                                      },
                       'mhpmevent3' => {
                                         'exists' => 'true',
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff'
                                       },
                       'mhpmcounter6h' => {
                                            'mask' => '0xffffffff',
                                            'exists' => 'true',
                                            'reset' => '0x0'
                                          },
                       'time' => {
                                   'exists' => 'false'
                                 },
                       'mcgc' => {
                                   'mask' => '0x000001ff',
                                   'number' => '0x7f8',
                                   'poke_mask' => '0x000001ff',
                                   'reset' => '0x0',
                                   'exists' => 'true'
                                 },
                       'dicago' => {
                                     'number' => '0x7cb',
                                     'comment' => 'Cache diagnostics.',
                                     'debug' => 'true',
                                     'mask' => '0x0',
                                     'exists' => 'true',
                                     'reset' => '0x0'
                                   },
                       'pmpcfg1' => {
                                      'exists' => 'false'
                                    },
                       'mpmc' => {
                                   'reset' => '0x0',
                                   'exists' => 'true',
                                   'mask' => '0x0',
                                   'number' => '0x7c6',
                                   'comment' => 'Core pause: Implemented as read only.'
                                 },
                       'pmpaddr9' => {
                                       'exists' => 'false'
                                     },
                       'pmpcfg3' => {
                                      'exists' => 'false'
                                    },
                       'pmpcfg0' => {
                                      'exists' => 'false'
                                    },
                       'mimpid' => {
                                     'mask' => '0x0',
                                     'exists' => 'true',
                                     'reset' => '0x1'
                                   },
                       'pmpaddr12' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr15' => {
                                        'exists' => 'false'
                                      },
                       'meipt' => {
                                    'comment' => 'External interrupt priority threshold.',
                                    'number' => '0xbc9',
                                    'mask' => '0xf',
                                    'exists' => 'true',
                                    'reset' => '0x0'
                                  },
                       'mhpmcounter5h' => {
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0',
                                            'exists' => 'true'
                                          },
                       'misa' => {
                                   'reset' => '0x40001104',
                                   'exists' => 'true',
                                   'mask' => '0x0'
                                 },
                       'mcpc' => {
                                   'exists' => 'true',
                                   'reset' => '0x0',
                                   'number' => '0x7c2',
                                   'mask' => '0x0'
                                 },
                       'pmpaddr3' => {
                                       'exists' => 'false'
                                     },
                       'miccmect' => {
                                       'number' => '0x7f1',
                                       'mask' => '0xffffffff',
                                       'exists' => 'true',
                                       'reset' => '0x0'
                                     },
                       'pmpaddr1' => {
                                       'exists' => 'false'
                                     }
                     },
            'iccm' => {
                        'iccm_data_cell' => 'ram_16384x39',
                        'iccm_index_bits' => 14,
                        'iccm_rows' => '16384',
                        'iccm_bank_bits' => 3,
                        'iccm_num_banks' => '8',
                        'iccm_num_banks_8' => '',
                        'iccm_sadr' => '0xee000000',
                        'iccm_size_512' => '',
                        'iccm_offset' => '0xe000000',
                        'iccm_reserved' => '0x1000',
                        'iccm_eadr' => '0xee07ffff',
                        'iccm_region' => '0xe',
                        'iccm_size' => 512,
                        'iccm_bits' => 19
                      },
            'pic' => {
                       'pic_total_int' => 8,
                       'pic_meigwclr_offset' => '0x5000',
                       'pic_int_words' => 1,
                       'pic_base_addr' => '0xf0100000',
                       'pic_meie_offset' => '0x2000',
                       'pic_region' => '0xf',
                       'pic_offset' => '0x100000',
                       'pic_bits' => 15,
                       'pic_size' => 32,
                       'pic_meipl_offset' => '0x0000',
                       'pic_meipt_offset' => '0x3004',
                       'pic_meip_offset' => '0x1000',
                       'pic_meigwctrl_offset' => '0x4000',
                       'pic_total_int_plus1' => 9,
                       'pic_mpiccfg_offset' => '0x3000'
                     },
            'num_mmode_perf_regs' => '4',
            'bht' => {
                       'bht_array_depth' => 16,
                       'bht_size' => 128,
                       'bht_ghr_range' => '4:0',
                       'bht_ghr_size' => 5,
                       'bht_ghr_pad2' => 'fghr[4:3],2\'b0',
                       'bht_ghr_pad' => 'fghr[4],3\'b0',
                       'bht_addr_hi' => 7,
                       'bht_hash_string' => '{ghr[3:2] ^ {ghr[3+1], {4-1-2{1\'b0}}},hashin[5:4]^ghr[2-1:0]}',
                       'bht_addr_lo' => '4'
                     },
            'physical' => '1',
            'xlen' => 32,
            'icache' => {
                          'icache_ic_depth' => 8,
                          'icache_tag_low' => '6',
                          'icache_tag_depth' => 64,
                          'icache_enable' => '1',
                          'icache_size' => 16,
                          'icache_ic_index' => 8,
                          'icache_ic_rows' => '256',
                          'icache_tag_cell' => 'ram_64x21',
                          'icache_data_cell' => 'ram_256x34',
                          'icache_taddr_high' => 5,
                          'icache_tag_high' => 12
                        },
            'triggers' => [
                            {
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ],
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ]
                            },
                            {
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ]
                            },
                            {
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ]
                            },
                            {
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ],
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ]
                            }
                          ],
            'memmap' => {
                          'debug_sb_mem' => '0xb0580000',
                          'serialio' => '0xd0580000',
                          'external_data_1' => '0x00000000',
                          'external_prog' => '0xb0000000',
                          'external_data' => '0xc0580000'
                        },
            'even_odd_trigger_chains' => 'true',
            'core' => {
                        'lsu_num_nbload_width' => '2',
                        'dma_buf_depth' => '2',
                        'opensource' => '1',
                        'dec_instbuf_depth' => '4',
                        'lsu_num_nbload' => '4',
                        'lsu_wrbuf_depth' => '4',
                        'lsu_stbuf_depth' => '8'
                      },
            'retstack' => {
                            'ret_stack_size' => '4'
                          },
            'reset_vec' => '0x80000000',
            'regwidth' => '32',
            'harts' => 1,
            'target' => 'default',
            'tec_rv_icg' => 'clockhdr'
          );
1;
