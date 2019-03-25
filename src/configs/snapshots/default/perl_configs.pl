#  NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
#  This is an automatically generated file by wjfan on Wed Mar 20 18:43:39 CST 2019
# 
#  cmd:    swerv -set reset_vec=0x200 -ahb_lite 
# 
# To use this in a perf script, use 'require $RV_ROOT/configs/config.pl'
# Reference the hash via $config{name}..


%config = (
            'core' => {
                        'dec_instbuf_depth' => '4',
                        'lsu_wrbuf_depth' => '4',
                        'lsu_num_nbload' => '4',
                        'dma_buf_depth' => '2',
                        'opensource' => '1',
                        'lsu_stbuf_depth' => '8',
                        'lsu_num_nbload_width' => '2'
                      },
            'bus' => {
                       'lsu_bus_prty' => '1',
                       'ifu_bus_tag' => '3',
                       'sb_bus_tag' => '1',
                       'lsu_bus_tag' => 3,
                       'lsu_bus_id' => '1',
                       'dma_bus_id' => '1',
                       'sb_bus_prty' => '1',
                       'dma_bus_tag' => '1',
                       'ifu_bus_prty' => '1',
                       'sb_bus_id' => '1',
                       'dma_bus_prty' => '1',
                       'ifu_bus_id' => '1'
                     },
            'retstack' => {
                            'ret_stack_size' => '4'
                          },
            'tec_rv_icg' => 'clockhdr',
            'xlen' => 32,
            'btb' => {
                       'btb_index2_lo' => 6,
                       'btb_index1_lo' => '4',
                       'btb_index3_lo' => 8,
                       'btb_index1_hi' => 5,
                       'btb_btag_fold' => 1,
                       'btb_addr_hi' => 5,
                       'btb_index2_hi' => 7,
                       'btb_size' => 32,
                       'btb_addr_lo' => '4',
                       'btb_index3_hi' => 9,
                       'btb_btag_size' => 9,
                       'btb_array_depth' => 4
                     },
            'even_odd_trigger_chains' => 'true',
            'nmi_vec' => '0x11110000',
            'physical' => '1',
            'num_mmode_perf_regs' => '4',
            'harts' => 1,
            'memmap' => {
                          'external_data_1' => '0x00000000',
                          'external_data' => '0xc0580000',
                          'external_prog' => '0xb0000000',
                          'debug_sb_mem' => '0xb0580000',
                          'serialio' => '0xd0580000'
                        },
            'numiregs' => '32',
            'target' => 'default',
            'pic' => {
                       'pic_meip_offset' => '0x1000',
                       'pic_meigwctrl_offset' => '0x4000',
                       'pic_base_addr' => '0xf0100000',
                       'pic_meipt_offset' => '0x3004',
                       'pic_bits' => 15,
                       'pic_size' => 32,
                       'pic_meigwclr_offset' => '0x5000',
                       'pic_mpiccfg_offset' => '0x3000',
                       'pic_offset' => '0x100000',
                       'pic_meie_offset' => '0x2000',
                       'pic_total_int' => 8,
                       'pic_int_words' => 1,
                       'pic_meipl_offset' => '0x0000',
                       'pic_total_int_plus1' => 9,
                       'pic_region' => '0xf'
                     },
            'reset_vec' => '0x200',
            'icache' => {
                          'icache_tag_low' => '6',
                          'icache_tag_depth' => 64,
                          'icache_enable' => '1',
                          'icache_ic_depth' => 8,
                          'icache_tag_high' => 12,
                          'icache_tag_cell' => 'ram_64x21',
                          'icache_ic_rows' => '256',
                          'icache_ic_index' => 8,
                          'icache_data_cell' => 'ram_256x34',
                          'icache_size' => 16,
                          'icache_taddr_high' => 5
                        },
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
            'regwidth' => '32',
            'dccm' => {
                        'lsu_sb_bits' => 15,
                        'dccm_reserved' => '0x1000',
                        'dccm_enable' => '1',
                        'dccm_sadr' => '0xf0080000',
                        'dccm_num_banks' => '8',
                        'dccm_bank_bits' => 3,
                        'dccm_offset' => '0x80000',
                        'dccm_bits' => 15,
                        'dccm_data_cell' => 'ram_1024x39',
                        'dccm_data_width' => 32,
                        'dccm_num_banks_8' => '',
                        'dccm_size_32' => '',
                        'dccm_ecc_width' => 7,
                        'dccm_byte_width' => '4',
                        'dccm_index_bits' => 10,
                        'dccm_rows' => '1024',
                        'dccm_eadr' => '0xf0087fff',
                        'dccm_region' => '0xf',
                        'dccm_size' => 32,
                        'dccm_width_bits' => 2,
                        'dccm_fdata_width' => 39
                      },
            'bht' => {
                       'bht_size' => 128,
                       'bht_ghr_pad' => 'fghr[4],3\'b0',
                       'bht_ghr_range' => '4:0',
                       'bht_array_depth' => 16,
                       'bht_ghr_size' => 5,
                       'bht_ghr_pad2' => 'fghr[4:3],2\'b0',
                       'bht_addr_lo' => '4',
                       'bht_addr_hi' => 7,
                       'bht_hash_string' => '{ghr[3:2] ^ {ghr[3+1], {4-1-2{1\'b0}}},hashin[5:4]^ghr[2-1:0]}'
                     },
            'max_mmode_perf_event' => '50',
            'iccm' => {
                        'iccm_num_banks' => '8',
                        'iccm_eadr' => '0xee07ffff',
                        'iccm_sadr' => '0xee000000',
                        'iccm_rows' => '16384',
                        'iccm_num_banks_8' => '',
                        'iccm_size' => 512,
                        'iccm_bank_bits' => 3,
                        'iccm_bits' => 19,
                        'iccm_size_512' => '',
                        'iccm_data_cell' => 'ram_16384x39',
                        'iccm_index_bits' => 14,
                        'iccm_region' => '0xe',
                        'iccm_offset' => '0xe000000',
                        'iccm_reserved' => '0x1000'
                      },
            'csr' => {
                       'mvendorid' => {
                                        'reset' => '0x45',
                                        'exists' => 'true',
                                        'mask' => '0x0'
                                      },
                       'pmpaddr13' => {
                                        'exists' => 'false'
                                      },
                       'pmpcfg2' => {
                                      'exists' => 'false'
                                    },
                       'mcpc' => {
                                   'mask' => '0x0',
                                   'exists' => 'true',
                                   'reset' => '0x0',
                                   'number' => '0x7c2'
                                 },
                       'pmpcfg0' => {
                                      'exists' => 'false'
                                    },
                       'mstatus' => {
                                      'exists' => 'true',
                                      'reset' => '0x1800',
                                      'mask' => '0x88'
                                    },
                       'mhpmcounter6h' => {
                                            'exists' => 'true',
                                            'reset' => '0x0',
                                            'mask' => '0xffffffff'
                                          },
                       'instret' => {
                                      'exists' => 'false'
                                    },
                       'mip' => {
                                  'reset' => '0x0',
                                  'exists' => 'true',
                                  'mask' => '0x0',
                                  'poke_mask' => '0x40000888'
                                },
                       'mie' => {
                                  'mask' => '0x40000888',
                                  'exists' => 'true',
                                  'reset' => '0x0'
                                },
                       'mimpid' => {
                                     'mask' => '0x0',
                                     'reset' => '0x1',
                                     'exists' => 'true'
                                   },
                       'pmpaddr5' => {
                                       'exists' => 'false'
                                     },
                       'mdccmect' => {
                                       'mask' => '0xffffffff',
                                       'exists' => 'true',
                                       'reset' => '0x0',
                                       'number' => '0x7f2'
                                     },
                       'meicurpl' => {
                                       'mask' => '0xf',
                                       'exists' => 'true',
                                       'reset' => '0x0',
                                       'comment' => 'External interrupt current priority level.',
                                       'number' => '0xbcc'
                                     },
                       'pmpaddr1' => {
                                       'exists' => 'false'
                                     },
                       'mhpmevent5' => {
                                         'exists' => 'true',
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff'
                                       },
                       'mhpmcounter5h' => {
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0',
                                            'exists' => 'true'
                                          },
                       'pmpcfg3' => {
                                      'exists' => 'false'
                                    },
                       'pmpaddr3' => {
                                       'exists' => 'false'
                                     },
                       'meicpct' => {
                                      'mask' => '0x0',
                                      'number' => '0xbca',
                                      'exists' => 'true',
                                      'reset' => '0x0',
                                      'comment' => 'External claim id/priority capture.'
                                    },
                       'dicawics' => {
                                       'mask' => '0x0130fffc',
                                       'debug' => 'true',
                                       'reset' => '0x0',
                                       'exists' => 'true',
                                       'comment' => 'Cache diagnostics.',
                                       'number' => '0x7c8'
                                     },
                       'mhpmcounter3h' => {
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0',
                                            'exists' => 'true'
                                          },
                       'misa' => {
                                   'mask' => '0x0',
                                   'reset' => '0x40001104',
                                   'exists' => 'true'
                                 },
                       'mhpmcounter5' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'mpmc' => {
                                   'mask' => '0x0',
                                   'exists' => 'true',
                                   'reset' => '0x0',
                                   'comment' => 'Core pause: Implemented as read only.',
                                   'number' => '0x7c6'
                                 },
                       'pmpaddr11' => {
                                        'exists' => 'false'
                                      },
                       'pmpcfg1' => {
                                      'exists' => 'false'
                                    },
                       'meicidpl' => {
                                       'mask' => '0xf',
                                       'exists' => 'true',
                                       'reset' => '0x0',
                                       'comment' => 'External interrupt claim id priority level.',
                                       'number' => '0xbcb'
                                     },
                       'time' => {
                                   'exists' => 'false'
                                 },
                       'dicad0' => {
                                     'comment' => 'Cache diagnostics.',
                                     'reset' => '0x0',
                                     'exists' => 'true',
                                     'number' => '0x7c9',
                                     'mask' => '0xffffffff',
                                     'debug' => 'true'
                                   },
                       'mhpmcounter4h' => {
                                            'mask' => '0xffffffff',
                                            'exists' => 'true',
                                            'reset' => '0x0'
                                          },
                       'pmpaddr8' => {
                                       'exists' => 'false'
                                     },
                       'mhpmcounter4' => {
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0',
                                           'exists' => 'true'
                                         },
                       'pmpaddr7' => {
                                       'exists' => 'false'
                                     },
                       'meipt' => {
                                    'mask' => '0xf',
                                    'exists' => 'true',
                                    'reset' => '0x0',
                                    'comment' => 'External interrupt priority threshold.',
                                    'number' => '0xbc9'
                                  },
                       'pmpaddr12' => {
                                        'exists' => 'false'
                                      },
                       'miccmect' => {
                                       'mask' => '0xffffffff',
                                       'exists' => 'true',
                                       'reset' => '0x0',
                                       'number' => '0x7f1'
                                     },
                       'tselect' => {
                                      'mask' => '0x3',
                                      'exists' => 'true',
                                      'reset' => '0x0'
                                    },
                       'dicago' => {
                                     'exists' => 'true',
                                     'reset' => '0x0',
                                     'comment' => 'Cache diagnostics.',
                                     'number' => '0x7cb',
                                     'mask' => '0x0',
                                     'debug' => 'true'
                                   },
                       'pmpaddr15' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr4' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr9' => {
                                       'exists' => 'false'
                                     },
                       'marchid' => {
                                      'exists' => 'true',
                                      'reset' => '0x0000000b',
                                      'mask' => '0x0'
                                    },
                       'mhpmcounter6' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'mhpmevent4' => {
                                         'exists' => 'true',
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff'
                                       },
                       'mhpmevent6' => {
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0',
                                         'exists' => 'true'
                                       },
                       'pmpaddr6' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr10' => {
                                        'exists' => 'false'
                                      },
                       'dicad1' => {
                                     'mask' => '0x3',
                                     'debug' => 'true',
                                     'comment' => 'Cache diagnostics.',
                                     'reset' => '0x0',
                                     'exists' => 'true',
                                     'number' => '0x7ca'
                                   },
                       'mhpmcounter3' => {
                                           'reset' => '0x0',
                                           'exists' => 'true',
                                           'mask' => '0xffffffff'
                                         },
                       'mfdc' => {
                                   'mask' => '0x000007ff',
                                   'number' => '0x7f9',
                                   'reset' => '0x0',
                                   'exists' => 'true'
                                 },
                       'cycle' => {
                                    'exists' => 'false'
                                  },
                       'micect' => {
                                     'number' => '0x7f0',
                                     'reset' => '0x0',
                                     'exists' => 'true',
                                     'mask' => '0xffffffff'
                                   },
                       'pmpaddr2' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr0' => {
                                       'exists' => 'false'
                                     },
                       'mhpmevent3' => {
                                         'exists' => 'true',
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff'
                                       },
                       'mcgc' => {
                                   'poke_mask' => '0x000001ff',
                                   'mask' => '0x000001ff',
                                   'number' => '0x7f8',
                                   'exists' => 'true',
                                   'reset' => '0x0'
                                 },
                       'dmst' => {
                                   'mask' => '0x0',
                                   'debug' => 'true',
                                   'reset' => '0x0',
                                   'exists' => 'true',
                                   'comment' => 'Memory synch trigger: Flush caches in debug mode.',
                                   'number' => '0x7c4'
                                 },
                       'dcsr' => {
                                   'reset' => '0x40000003',
                                   'exists' => 'true',
                                   'mask' => '0x00008c04',
                                   'poke_mask' => '0x00008dcc'
                                 },
                       'pmpaddr14' => {
                                        'exists' => 'false'
                                      }
                     },
            'testbench' => {
                             'datawidth' => '64',
                             'sterr_rollback' => '0',
                             'lderr_rollback' => '1',
                             'CPU_TOP' => '`RV_TOP.swerv',
                             'clock_period' => '100',
                             'TOP' => 'tb_top',
                             'RV_TOP' => '`TOP.rvtop',
                             'ext_datawidth' => '64',
                             'build_ahb_lite' => 1,
                             'ext_addrwidth' => '32'
                           }
          );
1;
