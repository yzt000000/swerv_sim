#  NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
#  This is an automatically generated file by wjfan on Mon Mar 18 19:03:33 CST 2019
# 
#  cmd:    swerv -target default -set reset_vec=0x0 -ahb_lite -icache_enable=0 
# 
# To use this in a perf script, use 'require $RV_ROOT/configs/config.pl'
# Reference the hash via $config{name}..


%config = (
            'bus' => {
                       'sb_bus_id' => '1',
                       'lsu_bus_prty' => '1',
                       'lsu_bus_tag' => 3,
                       'sb_bus_tag' => '1',
                       'dma_bus_prty' => '1',
                       'ifu_bus_id' => '1',
                       'dma_bus_tag' => '1',
                       'ifu_bus_prty' => '1',
                       'lsu_bus_id' => '1',
                       'dma_bus_id' => '1',
                       'sb_bus_prty' => '1',
                       'ifu_bus_tag' => '3'
                     },
            'tec_rv_icg' => 'clockhdr',
            'csr' => {
                       'pmpaddr7' => {
                                       'exists' => 'false'
                                     },
                       'pmpcfg2' => {
                                      'exists' => 'false'
                                    },
                       'mhpmevent3' => {
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff',
                                         'exists' => 'true'
                                       },
                       'mhpmcounter5h' => {
                                            'reset' => '0x0',
                                            'mask' => '0xffffffff',
                                            'exists' => 'true'
                                          },
                       'time' => {
                                   'exists' => 'false'
                                 },
                       'mhpmcounter5' => {
                                           'exists' => 'true',
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0'
                                         },
                       'mhpmcounter4h' => {
                                            'reset' => '0x0',
                                            'mask' => '0xffffffff',
                                            'exists' => 'true'
                                          },
                       'mstatus' => {
                                      'exists' => 'true',
                                      'mask' => '0x88',
                                      'reset' => '0x1800'
                                    },
                       'pmpaddr10' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr11' => {
                                        'exists' => 'false'
                                      },
                       'misa' => {
                                   'reset' => '0x40001104',
                                   'mask' => '0x0',
                                   'exists' => 'true'
                                 },
                       'mhpmcounter6' => {
                                           'reset' => '0x0',
                                           'exists' => 'true',
                                           'mask' => '0xffffffff'
                                         },
                       'mhpmcounter3' => {
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff',
                                           'exists' => 'true'
                                         },
                       'pmpcfg3' => {
                                      'exists' => 'false'
                                    },
                       'mie' => {
                                  'reset' => '0x0',
                                  'exists' => 'true',
                                  'mask' => '0x40000888'
                                },
                       'pmpaddr3' => {
                                       'exists' => 'false'
                                     },
                       'mhpmevent4' => {
                                         'reset' => '0x0',
                                         'exists' => 'true',
                                         'mask' => '0xffffffff'
                                       },
                       'mhpmcounter3h' => {
                                            'reset' => '0x0',
                                            'exists' => 'true',
                                            'mask' => '0xffffffff'
                                          },
                       'pmpaddr4' => {
                                       'exists' => 'false'
                                     },
                       'meipt' => {
                                    'mask' => '0xf',
                                    'exists' => 'true',
                                    'comment' => 'External interrupt priority threshold.',
                                    'reset' => '0x0',
                                    'number' => '0xbc9'
                                  },
                       'mcgc' => {
                                   'reset' => '0x0',
                                   'number' => '0x7f8',
                                   'mask' => '0x000001ff',
                                   'exists' => 'true',
                                   'poke_mask' => '0x000001ff'
                                 },
                       'pmpaddr13' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr15' => {
                                        'exists' => 'false'
                                      },
                       'dicad1' => {
                                     'number' => '0x7ca',
                                     'reset' => '0x0',
                                     'comment' => 'Cache diagnostics.',
                                     'exists' => 'true',
                                     'debug' => 'true',
                                     'mask' => '0x3'
                                   },
                       'mvendorid' => {
                                        'exists' => 'true',
                                        'mask' => '0x0',
                                        'reset' => '0x45'
                                      },
                       'dicad0' => {
                                     'exists' => 'true',
                                     'mask' => '0xffffffff',
                                     'debug' => 'true',
                                     'number' => '0x7c9',
                                     'reset' => '0x0',
                                     'comment' => 'Cache diagnostics.'
                                   },
                       'meicidpl' => {
                                       'exists' => 'true',
                                       'mask' => '0xf',
                                       'number' => '0xbcb',
                                       'comment' => 'External interrupt claim id priority level.',
                                       'reset' => '0x0'
                                     },
                       'pmpaddr0' => {
                                       'exists' => 'false'
                                     },
                       'cycle' => {
                                    'exists' => 'false'
                                  },
                       'pmpaddr1' => {
                                       'exists' => 'false'
                                     },
                       'meicpct' => {
                                      'mask' => '0x0',
                                      'exists' => 'true',
                                      'reset' => '0x0',
                                      'comment' => 'External claim id/priority capture.',
                                      'number' => '0xbca'
                                    },
                       'dicago' => {
                                     'exists' => 'true',
                                     'mask' => '0x0',
                                     'debug' => 'true',
                                     'number' => '0x7cb',
                                     'comment' => 'Cache diagnostics.',
                                     'reset' => '0x0'
                                   },
                       'dicawics' => {
                                       'exists' => 'true',
                                       'mask' => '0x0130fffc',
                                       'debug' => 'true',
                                       'number' => '0x7c8',
                                       'comment' => 'Cache diagnostics.',
                                       'reset' => '0x0'
                                     },
                       'pmpaddr14' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr9' => {
                                       'exists' => 'false'
                                     },
                       'mdccmect' => {
                                       'exists' => 'true',
                                       'mask' => '0xffffffff',
                                       'number' => '0x7f2',
                                       'reset' => '0x0'
                                     },
                       'mhpmcounter6h' => {
                                            'reset' => '0x0',
                                            'exists' => 'true',
                                            'mask' => '0xffffffff'
                                          },
                       'tselect' => {
                                      'reset' => '0x0',
                                      'exists' => 'true',
                                      'mask' => '0x3'
                                    },
                       'mhpmcounter4' => {
                                           'exists' => 'true',
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0'
                                         },
                       'pmpaddr8' => {
                                       'exists' => 'false'
                                     },
                       'miccmect' => {
                                       'reset' => '0x0',
                                       'number' => '0x7f1',
                                       'mask' => '0xffffffff',
                                       'exists' => 'true'
                                     },
                       'pmpcfg0' => {
                                      'exists' => 'false'
                                    },
                       'pmpaddr6' => {
                                       'exists' => 'false'
                                     },
                       'dmst' => {
                                   'exists' => 'true',
                                   'mask' => '0x0',
                                   'debug' => 'true',
                                   'number' => '0x7c4',
                                   'reset' => '0x0',
                                   'comment' => 'Memory synch trigger: Flush caches in debug mode.'
                                 },
                       'pmpaddr12' => {
                                        'exists' => 'false'
                                      },
                       'mfdc' => {
                                   'reset' => '0x0',
                                   'number' => '0x7f9',
                                   'mask' => '0x000007ff',
                                   'exists' => 'true'
                                 },
                       'micect' => {
                                     'reset' => '0x0',
                                     'number' => '0x7f0',
                                     'mask' => '0xffffffff',
                                     'exists' => 'true'
                                   },
                       'pmpaddr5' => {
                                       'exists' => 'false'
                                     },
                       'mhpmevent5' => {
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff',
                                         'exists' => 'true'
                                       },
                       'marchid' => {
                                      'exists' => 'true',
                                      'mask' => '0x0',
                                      'reset' => '0x0000000b'
                                    },
                       'instret' => {
                                      'exists' => 'false'
                                    },
                       'mhpmevent6' => {
                                         'exists' => 'true',
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0'
                                       },
                       'dcsr' => {
                                   'reset' => '0x40000003',
                                   'exists' => 'true',
                                   'poke_mask' => '0x00008dcc',
                                   'mask' => '0x00008c04'
                                 },
                       'mip' => {
                                  'mask' => '0x0',
                                  'poke_mask' => '0x40000888',
                                  'exists' => 'true',
                                  'reset' => '0x0'
                                },
                       'meicurpl' => {
                                       'exists' => 'true',
                                       'mask' => '0xf',
                                       'number' => '0xbcc',
                                       'comment' => 'External interrupt current priority level.',
                                       'reset' => '0x0'
                                     },
                       'mpmc' => {
                                   'comment' => 'Core pause: Implemented as read only.',
                                   'reset' => '0x0',
                                   'number' => '0x7c6',
                                   'mask' => '0x0',
                                   'exists' => 'true'
                                 },
                       'mimpid' => {
                                     'exists' => 'true',
                                     'mask' => '0x0',
                                     'reset' => '0x1'
                                   },
                       'pmpaddr2' => {
                                       'exists' => 'false'
                                     },
                       'pmpcfg1' => {
                                      'exists' => 'false'
                                    },
                       'mcpc' => {
                                   'mask' => '0x0',
                                   'exists' => 'true',
                                   'reset' => '0x0',
                                   'number' => '0x7c2'
                                 }
                     },
            'target' => 'default',
            'bht' => {
                       'bht_ghr_pad2' => 'fghr[4:3],2\'b0',
                       'bht_addr_lo' => '4',
                       'bht_ghr_range' => '4:0',
                       'bht_ghr_pad' => 'fghr[4],3\'b0',
                       'bht_size' => 128,
                       'bht_array_depth' => 16,
                       'bht_hash_string' => '{ghr[3:2] ^ {ghr[3+1], {4-1-2{1\'b0}}},hashin[5:4]^ghr[2-1:0]}',
                       'bht_addr_hi' => 7,
                       'bht_ghr_size' => 5
                     },
            'dccm' => {
                        'dccm_offset' => '0x80000',
                        'dccm_bits' => 15,
                        'dccm_num_banks' => '8',
                        'dccm_region' => '0xf',
                        'dccm_width_bits' => 2,
                        'dccm_enable' => '1',
                        'dccm_data_width' => 32,
                        'dccm_ecc_width' => 7,
                        'dccm_reserved' => '0x1000',
                        'dccm_eadr' => '0xf0087fff',
                        'dccm_size' => 32,
                        'dccm_num_banks_8' => '',
                        'dccm_bank_bits' => 3,
                        'dccm_size_32' => '',
                        'dccm_rows' => '1024',
                        'dccm_fdata_width' => 39,
                        'dccm_sadr' => '0xf0080000',
                        'dccm_byte_width' => '4',
                        'dccm_data_cell' => 'ram_1024x39',
                        'lsu_sb_bits' => 15,
                        'dccm_index_bits' => 10
                      },
            'iccm' => {
                        'iccm_rows' => '16384',
                        'iccm_num_banks' => '8',
                        'iccm_index_bits' => 14,
                        'iccm_sadr' => '0xee000000',
                        'iccm_size' => 512,
                        'iccm_bank_bits' => 3,
                        'iccm_eadr' => '0xee07ffff',
                        'iccm_data_cell' => 'ram_16384x39',
                        'iccm_num_banks_8' => '',
                        'iccm_size_512' => '',
                        'iccm_region' => '0xe',
                        'iccm_offset' => '0xe000000',
                        'iccm_reserved' => '0x1000',
                        'iccm_bits' => 19
                      },
            'retstack' => {
                            'ret_stack_size' => '4'
                          },
            'reset_vec' => '0x0',
            'max_mmode_perf_event' => '50',
            'num_mmode_perf_regs' => '4',
            'regwidth' => '32',
            'numiregs' => '32',
            'harts' => 1,
            'btb' => {
                       'btb_index3_lo' => 8,
                       'btb_index2_lo' => 6,
                       'btb_index1_hi' => 5,
                       'btb_index1_lo' => '4',
                       'btb_btag_size' => 9,
                       'btb_index3_hi' => 9,
                       'btb_size' => 32,
                       'btb_index2_hi' => 7,
                       'btb_addr_hi' => 5,
                       'btb_btag_fold' => 1,
                       'btb_array_depth' => 4,
                       'btb_addr_lo' => '4'
                     },
            'even_odd_trigger_chains' => 'true',
            'icache' => {
                          'icache_data_cell' => 'ram_256x34',
                          'icache_ic_rows' => '256',
                          'icache_tag_high' => 12,
                          'icache_size' => 16,
                          'icache_tag_depth' => 64,
                          'icache_ic_index' => 8,
                          'icache_tag_low' => '6',
                          'icache_tag_cell' => 'ram_64x21',
                          'icache_taddr_high' => 5,
                          'icache_ic_depth' => 8
                        },
            'physical' => '1',
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
                            }
                          ],
            'core' => {
                        'lsu_wrbuf_depth' => '4',
                        'dec_instbuf_depth' => '4',
                        'opensource' => '1',
                        'lsu_num_nbload_width' => '2',
                        'dma_buf_depth' => '2',
                        'lsu_num_nbload' => '4',
                        'lsu_stbuf_depth' => '8'
                      },
            'pic' => {
                       'pic_meip_offset' => '0x1000',
                       'pic_meipl_offset' => '0x0000',
                       'pic_total_int' => 8,
                       'pic_size' => 32,
                       'pic_base_addr' => '0xf0100000',
                       'pic_meigwclr_offset' => '0x5000',
                       'pic_mpiccfg_offset' => '0x3000',
                       'pic_int_words' => 1,
                       'pic_bits' => 15,
                       'pic_meipt_offset' => '0x3004',
                       'pic_total_int_plus1' => 9,
                       'pic_region' => '0xf',
                       'pic_meie_offset' => '0x2000',
                       'pic_meigwctrl_offset' => '0x4000',
                       'pic_offset' => '0x100000'
                     },
            'nmi_vec' => '0x11110000',
            'xlen' => 32,
            'testbench' => {
                             'ext_addrwidth' => '32',
                             'lderr_rollback' => '1',
                             'TOP' => 'tb_top',
                             'sterr_rollback' => '0',
                             'clock_period' => '100',
                             'RV_TOP' => '`TOP.rvtop',
                             'build_ahb_lite' => 1,
                             'CPU_TOP' => '`RV_TOP.swerv',
                             'datawidth' => '64',
                             'ext_datawidth' => '64'
                           },
            'memmap' => {
                          'external_data_1' => '0x00000000',
                          'serialio' => '0xd0580000',
                          'external_prog' => '0xb0000000',
                          'external_data' => '0xc0580000',
                          'debug_sb_mem' => '0xb0580000'
                        }
          );
1;
