// ------------------------------------------------------------------------------------------
// File     : DW_ahb_icm_cc_constants.v
// Abstract : The parameter file.
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
// File Version     :        $Revision: #16 $ 
// Revision: $Id: //dwh/DW_ocb/DW_ahb_icm/amba_dev/src/DW_ahb_icm_cc_constants.v#16 $ 
// ------------------------------------------------------------------------------------------
//


// Name:         USE_FOUNDATION
// Default:      true ([<functionof>])
// Values:       false (0), true (1)
// Enabled:      [<functionof> %item]
// 
// The component code utilizes DesignWare Foundation parts for 
// optimal Synthesis QoR. Customers with only a DesignWare license must use 
// Foundation parts. Customers with only a Source license cannot use Foundation 
// parts. Customers with both Source and DesignWare licenses have the option of 
// using DesignWare Foundation parts.
`define USE_FOUNDATION 0



// Name:         AHB_LITE
// Default:      false
// Values:       false (0), true (1)
// 
// When this is set to Yes, no master in the system is capable of 
// accepting a RETRY or a SPLIT response from a slave. Therefore, it is not 
// possible to have a split-capable slave within the system, nor is it possible for the 
// DW_ahb_icm to generate the RETRY. On a layer, this setting implies only a single 
// master with no dummy master, and some parameters are disabled and 
// overwritten with their default values.
`define AHB_LITE 1


// Name:         AHB_MASK_PRIORITY
// Default:      false
// Values:       false (0), true (1)
// 
// If this parameter is set to True, the DW_ahb_icm masks the bus 
// arbitration to all AHB layers, except for AHB Layer for which transaction is in 
// progress under following conditions: A NONSEQ transfer is issued from one AHB 
// Layer, if Slave issues a wait state through pulling hready low (data phase of 
// previous transaction).
`define AHB_MASK_PRIORITY 0


// Name:         HADDR_WIDTH
// Default:      32
// Values:       32 64
// 
// Specifies the width of the connected address bus.
`define HADDR_WIDTH 32


// Name:         AHB_DATA_WIDTH
// Default:      32
// Values:       32 64 128 256
// 
// Specifies the width of the AHB data bus.
`define AHB_DATA_WIDTH 64


// Name:         ICM_NUM_LAYERS
// Default:      2
// Values:       2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
// 
// The number of AHB layers that the DW_ahb_icm must support.
`define ICM_NUM_LAYERS 3


`define LOG2_ICM_NUM_LAYERS 2


`define LOG2_ICM_NUM_LAYERS_P1 2


// Name:         ICM_NUM_HSEL
// Default:      1
// Values:       1 2 3 4 5 6 7 8
// Enabled:      ICM_HAS_MHSEL==1
// 
// Number of select lines attached to a slave.
`define ICM_NUM_HSEL 1


// Name:         ICM_HAS_MHSEL
// Default:      true ([<functionof> equal $::shell_activity_mode "assembler"]?1:0)
// Values:       false (0), true (1)
// Enabled:      ![<functionof> equal $::shell_activity_mode "assembler"]
// 
// This parameter controls the connected slave select lines. The 
// connected slave can have multiple slave-select lines and share a common AHB 
// interface layer, or it may have only one.
`define ICM_HAS_MHSEL 1


// Name:         ICM_HAS_PROT
// Default:      false
// Values:       false (0), true (1)
// 
// The connected slave uses and requires the protection control from 
// each of the masters.
`define ICM_HAS_PROT 1


// Name:         ICM_HAS_BURST
// Default:      true
// Values:       false (0), true (1)
// 
// The connected slave uses and requires the burst control from each 
// of the masters.
`define ICM_HAS_BURST 1


// Name:         ICM_HAS_LOCK
// Default:      true
// Values:       false (0), true (1)
// 
// The connected slave uses and requires the lock control from each 
// of the masters.
`define ICM_HAS_LOCK 1


// Name:         ICM_HAS_SPLIT
// Default:      false
// Values:       false (0), true (1)
// Enabled:      AHB_LITE == 0
// 
// The connected slave is split-capable and needs to know which 
// master is driving the address and control.
`define ICM_HAS_SPLIT 0


// Name:         MID_WIDTH
// Default:      0
// Values:       0 1 2 3 4 5 6 7 8 9 10 11 12
// Enabled:      AHB_LITE == 1
// 
// Specifies the width of a non standard Master ID  
// sideband signals. When set to 0, the Master ID 
// sideband signals are removed.
`define MID_WIDTH 0

//Creates a define for  MID propogation.

// `define AHB_MID_EN

//Specifies the width for the Non Standard Master ID 
//Sideband Signal after prepending the AHB Layer number

`define MID_LAYNO_WIDTH 2


// Name:         ICM_HAS_XPRIORITY
// Default:      false
// Values:       false (0), true (1)
// 
// This setting, when True (1), enables you to control the arbitration 
// priority from external signals. This is the only way for you to dynamically change 
// the priorities. When priorities are internal, they are fixed with Layer 1 the highest 
// priority down to Layer 8 with the lowest priority. 
//  
// The external priorities are controlled by driving the icm_priority bus input. When 
// there are: 
//   - 2 layers - bus is 2-bits  wide; each layer has 1 bit for priority. 
//   - 3 layers - bus is 6-bits  wide; each layer has 2 bits for priority. 
//   - 4 layers - bus is 8-bits  wide; each layer has 2 bits for priority. 
//   - 5 layers - bus is 15-bits wide; each layer has 3 bits for priority. 
//   - 6 layers - bus is 18-bits wide; each layer has 3 bits for priority. 
//   - 7 layers - bus is 21-bits wide; each layer has 3 bits for priority. 
//   - 8 layers - bus is 24-bits wide; each layer has 3 bits for priority. 
//   - 9 layers - bus is 36-bits wide, each layer has 4 bit for priority. 
//   - 10 layers - bus is 40-bits wide; each layer has 4 bits for priority. 
//   - 11 layers - bus is 44-bits wide; each layer has 4 bits for priority. 
//   - 12 layers - bus is 48-bits wide; each layer has 4 bits for priority. 
//   - 13 layers - bus is 52-bits wide; each layer has 4 bits for priority. 
//   - 14 layers - bus is 56-bits wide; each layer has 4 bits for priority. 
//   - 15 layers - bus is 60-bits wide; each layer has 4 bits for priority. 
//   - 16 layers - bus is 64-bits wide; each layer has 4 bits for priority. 
// The bit order of the icm_priority is always: 
//  
// [layer16]_[layer15]_[layer14]_[layer13]_[layer12]_[layer11]_[layer10]_[layer9] 
//  
// [layer8]_[layer7]_[layer6]_[layer5]_[layer4]_[layer3]_[layer2]_[layer1] 
//  
// For a four-layer system, the following is an example of driving icm_priority: 
//  
//  icm_priority[1:0] => layer 1 (2'b00) Highest Priority 
//  
//  icm_priority[3:2] => layer 2 (2'b11) Fourth  Priority 
//  
//  icm_priority[5:4] => layer 3 (2'b01) Second  Priority 
//  
//  icm_priority[7:6] => layer 4 (2'b10) Third  Priority 
//  
// If the priorities are the same, then the layer index is used to calculate the highest 
// priority. If layer 1 and layer 2 have the same priority then layer 1 is deemed as the 
// higher priority.
`define ICM_HAS_XPRIORITY 0

//Width of the priority vector. Each layer has a prioirty.

`define ICM_LAYERP_WIDTH 4

//Width of wait state counter. Which counts the number of cycles that a layer
//is held off by the matrix.

`define ICM_RWIDTH_L1 4

//Width of wait state counter. Which counts the number of cycles that a layer
//is held off by the matrix.

`define ICM_RWIDTH_L2 4

//Width of wait state counter. Which counts the number of cycles that a layer
//is held off by the matrix.

`define ICM_RWIDTH_L3 4

//Width of wait state counter. Which counts the number of cycles that a layer
//is held off by the matrix.

`define ICM_RWIDTH_L4 4

//Width of wait state counter. Which counts the number of cycles that a layer
//is held off by the matrix.

`define ICM_RWIDTH_L5 4

//Width of wait state counter. Which counts the number of cycles that a layer
//is held off by the matrix.

`define ICM_RWIDTH_L6 4

//Width of wait state counter. Which counts the number of cycles that a layer
//is held off by the matrix.

`define ICM_RWIDTH_L7 4

//Width of wait state counter. Which counts the number of cycles that a layer
//is held off by the matrix.

`define ICM_RWIDTH_L8 4

//Width of wait state counter. Which counts the number of cycles that a layer
//is held off by the matrix.

`define ICM_RWIDTH_L9 4

//Width of wait state counter. Which counts the number of cycles that a layer
//is held off by the matrix.

`define ICM_RWIDTH_L10 4

//Width of wait state counter. Which counts the number of cycles that a layer
//is held off by the matrix.

`define ICM_RWIDTH_L11 4

//Width of wait state counter. Which counts the number of cycles that a layer
//is held off by the matrix.

`define ICM_RWIDTH_L12 4

//Width of wait state counter. Which counts the number of cycles that a layer
//is held off by the matrix.

`define ICM_RWIDTH_L13 4

//Width of wait state counter. Which counts the number of cycles that a layer
//is held off by the matrix.

`define ICM_RWIDTH_L14 4

//Width of wait state counter. Which counts the number of cycles that a layer
//is held off by the matrix.

`define ICM_RWIDTH_L15 4

//Width of wait state counter. Which counts the number of cycles that a layer
//is held off by the matrix.

`define ICM_RWIDTH_L16 4


// Name:         ICM_RELEASE_L1
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (ICM_NUM_LAYERS >= 2) && (AHB_LITE == 0)
// 
// Enables a layer to give the option for a higher priority layer to be 
// granted access to the slave. 
//  
// A layer may be prevented from getting access to the slave if other layers have 
// higher priority or are taking a long time. Meanwhile, masters on the layer can do 
// nothing with that slave and may need to access other slaves. When the slave 
// becomes available, the DW_ahb_icm allows the layer to RETRY, whereby a 
// master on that layer can continue with the original transfer or enable another 
// master to have access. 
//  
// If there is no other master requesting access, then the master that was being held 
// off can RETRY the transfer. 
// 
`define ICM_RELEASE_L1 0


// Name:         ICM_RLIMIT_L1
// Default:      0x4
// Values:       0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
// Enabled:      (ICM_NUM_LAYERS >= 2) && (AHB_LITE == 0) && (ICM_RELEASE_L1 == 1)
// 
// The number of cycles that a layer can be held off before the matrix 
// generates a RETRY response. Once a RETRY is generated, any stored address 
// and control is cancelled and the master with the highest priority on Layer 1 gains 
// access.
`define ICM_RLIMIT_L1 4'h4


// Name:         ICM_RELEASE_L2
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (ICM_NUM_LAYERS >= 2) && (AHB_LITE == 0)
// 
// The matrix can release a layer from being held off. 
// When a layer is held off, then other masters on that layer cannot 
// gain access to that layer. By allowing the matrix to release a layer, 
// it gives the option for a higher priority master on that layer to be  
// granted access to the layer if it is requesting and not having to wait for  
// the layer to be granted access to the slave first before giving access  
// to the released priority master. If there is no other master requesting 
// access, then the master that was being held off can RETRY the transfer. 
//  
// This option is not available when the component is configured as an  
// AMBA Lite system (AHB_LITE=0).
`define ICM_RELEASE_L2 0


// Name:         ICM_RLIMIT_L2
// Default:      0x4
// Values:       0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
// Enabled:      (ICM_NUM_LAYERS >= 2) && (AHB_LITE == 0) && (ICM_RELEASE_L2 == 1)
// 
// The number of cycles that a layer can be held off before 
// the matrix will generate a RETRY response. Once a RETRY 
// is generated, any stored address and control is canceled 
// and the master with the highest priority on the layer  
// will gain access. 
//  
// This option is not available when the component 
// is configured as an AMBA Lite system (AHB_LITE = 0).
`define ICM_RLIMIT_L2 4'h4


// Name:         ICM_RELEASE_L3
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (ICM_NUM_LAYERS >= 3) && (AHB_LITE == 0)
// 
// The matrix can release a layer from being held off. 
// When a layer is held off, then other masters on that layer cannot 
// gain access to that layer. By allowing the matrix to release a layer, 
// it gives the option for a higher priority master on that layer to be  
// granted access to the layer if it is requesting and not having to wait for  
// the layer to be granted access to the slave first before giving access  
// to the released priority master. If there is no other master requesting 
// access, then the master that was being held off can RETRY the transfer. 
//  
// This option is not available when the component is configured as an  
// AMBA Lite system (AHB_LITE=0).
`define ICM_RELEASE_L3 0


// Name:         ICM_RLIMIT_L3
// Default:      0x4
// Values:       0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
// Enabled:      (ICM_NUM_LAYERS >= 3) && (AHB_LITE == 0) && (ICM_RELEASE_L3 == 1)
// 
// The number of cycles that a layer can be held off before 
// the matrix will generate a RETRY response. Once a RETRY 
// is generated, any stored address and control is canceled 
// and the master with the highest priority on the layer 
// will gain access. 
//  
// This option is not available when the component 
// is configured as an AMBA Lite system (AHB_LITE = 0).
`define ICM_RLIMIT_L3 4'h4


// Name:         ICM_RELEASE_L4
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (ICM_NUM_LAYERS >= 4) && (AHB_LITE == 0)
// 
// The matrix can release a layer from being held off. 
// When a layer is held off, then other masters on that layer cannot 
// gain access to that layer. By allowing the matrix to release a layer, 
// it gives the option for a higher priority master on that layer to be  
// granted access to the layer if it is requesting and not having to wait for  
// the layer to be granted access to the slave first before giving access  
// to the released priority master. If there is no other master requesting 
// access, then the master that was being held off can RETRY the transfer. 
//  
// This option is not available when the component is configured as an  
// AMBA Lite system (AHB_LITE=0).
`define ICM_RELEASE_L4 0


// Name:         ICM_RLIMIT_L4
// Default:      0x4
// Values:       0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
// Enabled:      (ICM_NUM_LAYERS >= 4) && (AHB_LITE == 0) && (ICM_RELEASE_L4 == 1)
// 
// The number of cycles that a layer can be held off before 
// the matrix will generate a RETRY response. Once a RETRY 
// is generated, any stored address and control is canceled 
// and the master with the highest priority on the layer  
// will gain access. 
//  
// This option is not available when the component 
// is configured as an AMBA Lite system (AHB_LITE = 0).
`define ICM_RLIMIT_L4 4'h4


// Name:         ICM_RELEASE_L5
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (ICM_NUM_LAYERS >= 5) && (AHB_LITE == 0)
// 
// The matrix can release a layer from being held off. 
// When a layer is held off, then other masters on that layer cannot 
// gain access to that layer. By allowing the matrix to release a layer, 
// it gives the option for a higher priority master on that layer to be  
// granted access to the layer if it is requesting and not having to wait for  
// the layer to be granted access to the slave first before giving access  
// to the released priority master. If there is no other master requesting 
// access, then the master that was being held off can RETRY the transfer. 
//  
// This option is not available when the component is configured as an  
// AMBA Lite system (AHB_LITE=0).
`define ICM_RELEASE_L5 0


// Name:         ICM_RLIMIT_L5
// Default:      0x4
// Values:       0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
// Enabled:      (ICM_NUM_LAYERS >= 5) && (AHB_LITE == 0) && (ICM_RELEASE_L5 == 1)
// 
// The number of cycles that a layer can be held off before 
// the matrix will generate a RETRY response. Once a RETRY 
// is generated, any stored address and control is canceled 
// and the master with the highest priority on the layer  
// will gain access. 
//  
// This option is not available when the component 
// is configured as an AMBA Lite system (AHB_LITE = 0).
`define ICM_RLIMIT_L5 4'h4


// Name:         ICM_RELEASE_L6
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (ICM_NUM_LAYERS >= 6) && (AHB_LITE == 0)
// 
// The matrix can release a layer from being held off. 
// When a layer is held off, then other masters on that layer cannot 
// gain access to that layer. By allowing the matrix to release a layer, 
// it gives the option for a higher priority master on that layer to be  
// granted access to the layer if it is requesting and not having to wait for  
// the layer to be granted access to the slave first before giving access  
// to the released priority master. If there is no other master requesting 
// access, then the master that was being held off can RETRY the transfer. 
//  
// This option is not available when the component is configured as an  
// AMBA Lite system (AHB_LITE=0).
`define ICM_RELEASE_L6 0


// Name:         ICM_RLIMIT_L6
// Default:      0x4
// Values:       0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
// Enabled:      (ICM_NUM_LAYERS >= 6) && (AHB_LITE == 0) && (ICM_RELEASE_L6 == 1)
// 
// The number of cycles that a layer can be held off before 
// the matrix will generate a RETRY response. Once a RETRY 
// is generated, any stored address and control is canceled 
// and the master with the highest priority on the layer  
// will gain access. 
//  
// This option is not available when the component 
// is configured as an AMBA Lite system (AHB_LITE = 0).
`define ICM_RLIMIT_L6 4'h4


// Name:         ICM_RELEASE_L7
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (ICM_NUM_LAYERS >= 7) && (AHB_LITE == 0)
// 
// The matrix can release a layer from being held off. 
// When a layer is held off, then other masters on that layer cannot 
// gain access to that layer. By allowing the matrix to release a layer, 
// it gives the option for a higher priority master on that layer to be  
// granted access to the layer if it is requesting and not having to wait for  
// the layer to be granted access to the slave first before giving access  
// to the released priority master. If there is no other master requesting 
// access, then the master that was being held off can RETRY the transfer. 
//  
// This option is not available when the component is configured as an  
// AMBA Lite system (AHB_LITE=0).
`define ICM_RELEASE_L7 0


// Name:         ICM_RLIMIT_L7
// Default:      0x4
// Values:       0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
// Enabled:      (ICM_NUM_LAYERS >= 7) && (AHB_LITE == 0) && (ICM_RELEASE_L7 == 1)
// 
// The number of cycles that a layer can be held off before 
// the matrix will generate a RETRY response. Once a RETRY 
// is generated, any stored address and control is canceled 
// and the master with the highest priority on the layer  
// will gain access. 
//  
// This option is not available when the component 
// is configured as an AMBA Lite system (AHB_LITE = 0).
`define ICM_RLIMIT_L7 4'h4


// Name:         ICM_RELEASE_L8
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (ICM_NUM_LAYERS >= 8) && (AHB_LITE == 0)
// 
// The matrix can release a layer from being held off. 
// When a layer is held off, then other masters on that layer cannot 
// gain access to that layer. By allowing the matrix to release a layer, 
// it gives the option for a higher priority master on that layer to be  
// granted access to the layer if it is requesting and not having to wait for  
// the layer to be granted access to the slave first before giving access  
// to the released priority master. If there is no other master requesting 
// access, then the master that was being held off can RETRY the transfer. 
//  
// This option is not available when the component is configured as an  
// AMBA Lite system (AHB_LITE=0).
`define ICM_RELEASE_L8 0


// Name:         ICM_RLIMIT_L8
// Default:      0x4
// Values:       0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
// Enabled:      (ICM_NUM_LAYERS >= 8) && (AHB_LITE == 0) && (ICM_RELEASE_L8 == 1)
// 
// The number of cycles that a layer can be held off before 
// the matrix will generate a RETRY response. Once a RETRY 
// is generated, any stored address and control is canceled 
// and the master with the highest priority on the layer  
// will gain access. 
//  
// This option is not available when the component 
// is configured as an AMBA Lite system (AHB_LITE = 0).
`define ICM_RLIMIT_L8 4'h4


// Name:         ICM_RELEASE_L9
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (ICM_NUM_LAYERS >= 9) && (AHB_LITE == 0)
// 
// The matrix can release a layer from being held off. 
// When a layer is held off, then other masters on that layer cannot 
// gain access to that layer. By allowing the matrix to release a layer, 
// it gives the option for a higher priority master on that layer to be  
// granted access to the layer if it is requesting and not having to wait for  
// the layer to be granted access to the slave first before giving access  
// to the released priority master. If there is no other master requesting 
// access, then the master that was being held off can RETRY the transfer. 
//  
// This option is not available when the component is configured as an  
// AMBA Lite system (AHB_LITE=0).
`define ICM_RELEASE_L9 0


// Name:         ICM_RLIMIT_L9
// Default:      0x4
// Values:       0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
// Enabled:      (ICM_NUM_LAYERS >= 9) && (AHB_LITE == 0) && (ICM_RELEASE_L9 == 1)
// 
// The number of cycles that a layer can be held off before 
// the matrix will generate a RETRY response. Once a RETRY 
// is generated, any stored address and control is canceled 
// and the master with the highest priority on the layer  
// will gain access. 
//  
// This option is not available when the component 
// is configured as an AMBA Lite system (AHB_LITE = 0).
`define ICM_RLIMIT_L9 4'h4


// Name:         ICM_RELEASE_L10
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (ICM_NUM_LAYERS >= 10) && (AHB_LITE == 0)
// 
// The matrix can release a layer from being held off. 
// When a layer is held off, then other masters on that layer cannot 
// gain access to that layer. By allowing the matrix to release a layer, 
// it gives the option for a higher priority master on that layer to be  
// granted access to the layer if it is requesting and not having to wait for  
// the layer to be granted access to the slave first before giving access  
// to the released priority master. If there is no other master requesting 
// access, then the master that was being held off can RETRY the transfer. 
//  
// This option is not available when the component is configured as an  
// AMBA Lite system (AHB_LITE=0).
`define ICM_RELEASE_L10 0


// Name:         ICM_RLIMIT_L10
// Default:      0x4
// Values:       0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
// Enabled:      (ICM_NUM_LAYERS >= 10) && (AHB_LITE == 0) && (ICM_RELEASE_L10 == 1)
// 
// The number of cycles that a layer can be held off before 
// the matrix will generate a RETRY response. Once a RETRY 
// is generated, any stored address and control is canceled 
// and the master with the highest priority on the layer  
// will gain access. 
//  
// This option is not available when the component 
// is configured as an AMBA Lite system (AHB_LITE = 0).
`define ICM_RLIMIT_L10 4'h4


// Name:         ICM_RELEASE_L11
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (ICM_NUM_LAYERS >= 11) && (AHB_LITE == 0)
// 
// The matrix can release a layer from being held off. 
// When a layer is held off, then other masters on that layer cannot 
// gain access to that layer. By allowing the matrix to release a layer, 
// it gives the option for a higher priority master on that layer to be  
// granted access to the layer if it is requesting and not having to wait for  
// the layer to be granted access to the slave first before giving access  
// to the released priority master. If there is no other master requesting 
// access, then the master that was being held off can RETRY the transfer. 
//  
// This option is not available when the component is configured as an  
// AMBA Lite system (AHB_LITE=0).
`define ICM_RELEASE_L11 0


// Name:         ICM_RLIMIT_L11
// Default:      0x4
// Values:       0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
// Enabled:      (ICM_NUM_LAYERS >= 11) && (AHB_LITE == 0) && (ICM_RELEASE_L11 == 1)
// 
// The number of cycles that a layer can be held off before 
// the matrix will generate a RETRY response. Once a RETRY 
// is generated, any stored address and control is canceled 
// and the master with the highest priority on the layer  
// will gain access. 
//  
// This option is not available when the component 
// is configured as an AMBA Lite system (AHB_LITE = 0).
`define ICM_RLIMIT_L11 4'h4


// Name:         ICM_RELEASE_L12
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (ICM_NUM_LAYERS >= 12) && (AHB_LITE == 0)
// 
// The matrix can release a layer from being held off. 
// When a layer is held off, then other masters on that layer cannot 
// gain access to that layer. By allowing the matrix to release a layer, 
// it gives the option for a higher priority master on that layer to be  
// granted access to the layer if it is requesting and not having to wait for  
// the layer to be granted access to the slave first before giving access  
// to the released priority master. If there is no other master requesting 
// access, then the master that was being held off can RETRY the transfer. 
//  
// This option is not available when the component is configured as an  
// AMBA Lite system (AHB_LITE=0).
`define ICM_RELEASE_L12 0


// Name:         ICM_RLIMIT_L12
// Default:      0x4
// Values:       0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
// Enabled:      (ICM_NUM_LAYERS >= 12) && (AHB_LITE == 0) && (ICM_RELEASE_L12 == 1)
// 
// The number of cycles that a layer can be held off before 
// the matrix will generate a RETRY response. Once a RETRY 
// is generated, any stored address and control is canceled 
// and the master with the highest priority on the layer  
// will gain access. 
//  
// This option is not available when the component 
// is configured as an AMBA Lite system (AHB_LITE = 0).
`define ICM_RLIMIT_L12 4'h4


// Name:         ICM_RELEASE_L13
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (ICM_NUM_LAYERS >= 13) && (AHB_LITE == 0)
// 
// The matrix can release a layer from being held off. 
// When a layer is held off, then other masters on that layer cannot 
// gain access to that layer. By allowing the matrix to release a layer, 
// it gives the option for a higher priority master on that layer to be  
// granted access to the layer if it is requesting and not having to wait for  
// the layer to be granted access to the slave first before giving access  
// to the released priority master. If there is no other master requesting 
// access, then the master that was being held off can RETRY the transfer. 
//  
// This option is not available when the component is configured as an  
// AMBA Lite system (AHB_LITE=0).
`define ICM_RELEASE_L13 0


// Name:         ICM_RLIMIT_L13
// Default:      0x4
// Values:       0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
// Enabled:      (ICM_NUM_LAYERS >= 13) && (AHB_LITE == 0) && (ICM_RELEASE_L13 == 1)
// 
// The number of cycles that a layer can be held off before 
// the matrix will generate a RETRY response. Once a RETRY 
// is generated, any stored address and control is canceled 
// and the master with the highest priority on the layer  
// will gain access. 
//  
// This option is not available when the component 
// is configured as an AMBA Lite system (AHB_LITE = 0).
`define ICM_RLIMIT_L13 4'h4


// Name:         ICM_RELEASE_L14
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (ICM_NUM_LAYERS >= 14) && (AHB_LITE == 0)
// 
// The matrix can release a layer from being held off. 
// When a layer is held off, then other masters on that layer cannot 
// gain access to that layer. By allowing the matrix to release a layer, 
// it gives the option for a higher priority master on that layer to be  
// granted access to the layer if it is requesting and not having to wait for  
// the layer to be granted access to the slave first before giving access  
// to the released priority master. If there is no other master requesting 
// access, then the master that was being held off can RETRY the transfer. 
//  
// This option is not available when the component is configured as an  
// AMBA Lite system (AHB_LITE=0).
`define ICM_RELEASE_L14 0


// Name:         ICM_RLIMIT_L14
// Default:      0x4
// Values:       0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
// Enabled:      (ICM_NUM_LAYERS >= 14) && (AHB_LITE == 0) && (ICM_RELEASE_L14 == 1)
// 
// The number of cycles that a layer can be held off before 
// the matrix will generate a RETRY response. Once a RETRY 
// is generated, any stored address and control is canceled 
// and the master with the highest priority on the layer  
// will gain access. 
//  
// This option is not available when the component 
// is configured as an AMBA Lite system (AHB_LITE = 0).
`define ICM_RLIMIT_L14 4'h4


// Name:         ICM_RELEASE_L15
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (ICM_NUM_LAYERS >= 15) && (AHB_LITE == 0)
// 
// The matrix can release a layer from being held off. 
// When a layer is held off, then other masters on that layer cannot 
// gain access to that layer. By allowing the matrix to release a layer, 
// it gives the option for a higher priority master on that layer to be  
// granted access to the layer if it is requesting and not having to wait for  
// the layer to be granted access to the slave first before giving access  
// to the released priority master. If there is no other master requesting 
// access, then the master that was being held off can RETRY the transfer. 
//  
// This option is not available when the component is configured as an  
// AMBA Lite system (AHB_LITE=0).
`define ICM_RELEASE_L15 0


// Name:         ICM_RLIMIT_L15
// Default:      0x4
// Values:       0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
// Enabled:      (ICM_NUM_LAYERS >= 15) && (AHB_LITE == 0) && (ICM_RELEASE_L15 == 1)
// 
// The number of cycles that a layer can be held off before 
// the matrix will generate a RETRY response. Once a RETRY 
// is generated, any stored address and control is canceled 
// and the master with the highest priority on the layer  
// will gain access. 
//  
// This option is not available when the component 
// is configured as an AMBA Lite system (AHB_LITE = 0).
`define ICM_RLIMIT_L15 4'h4


// Name:         ICM_RELEASE_L16
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (ICM_NUM_LAYERS >= 16) && (AHB_LITE == 0)
// 
// The matrix can release a layer from being held off. 
// When a layer is held off, then other masters on that layer cannot 
// gain access to that layer. By allowing the matrix to release a layer, 
// it gives the option for a higher priority master on that layer to be  
// granted access to the layer if it is requesting and not having to wait for  
// the layer to be granted access to the slave first before giving access  
// to the released priority master. If there is no other master requesting 
// access, then the master that was being held off can RETRY the transfer. 
//  
// This option is not available when the component is configured as an  
// AMBA Lite system (AHB_LITE=0).
`define ICM_RELEASE_L16 0


// Name:         ICM_RLIMIT_L16
// Default:      0x4
// Values:       0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf
// Enabled:      (ICM_NUM_LAYERS >= 16) && (AHB_LITE == 0) && (ICM_RELEASE_L16 == 1)
// 
// The number of cycles that a layer can be held off before 
// the matrix will generate a RETRY response. Once a RETRY 
// is generated, any stored address and control is canceled 
// and the master with the highest priority on the layer  
// will gain access. 
//  
// This option is not available when the component 
// is configured as an AMBA Lite system (AHB_LITE = 0).
`define ICM_RLIMIT_L16 4'h4

//Indication of whether to generate the hlock signal on the interface.

`define ICM_HV_HAS_LOCK_3 1'h1

//Indication of whether to generate the hlock signal on the interface.

`define ICM_HV_HAS_BURST_3 1'h1

//Indication of whether to generate the hlock signal on the interface.

`define ICM_HV_HAS_PROT_3 1'h1

//Indication of whether to generate the hlock signal on the interface.

`define ICM_HV_HAS_LOCK_4 1'h0

//Indication of whether to generate the hlock signal on the interface.

`define ICM_HV_HAS_BURST_4 1'h0

//Indication of whether to generate the hlock signal on the interface.

`define ICM_HV_HAS_PROT_4 1'h0

//Indication of whether to generate the hmaster signal on the interface.

`define ICM_HV_HAS_MASTER_1 1'h0

//Indication of whether to generate the hmaster signal on the interface.

`define ICM_HV_HAS_MASTER_2 1'h0

//Indication of whether to generate the hmaster signal on the interface.

`define ICM_HV_HAS_MASTER_3 1'h0

//Indication of whether to generate the hmaster signal on the interface.

`define ICM_HV_HAS_MASTER_4 1'h0

//Maximum number of layers.

`define ICM_MAX_LAYERS 16

//Maximum number of chip selects.

`define ICM_MAX_HSEL 16

//Concatenated priority bus width

`define ICM_BUSP_WIDTH 12

//Maximum concatenated priority bus width

`define ICM_MAXP_WIDTH 64

//Width of the hlayer bus.

`define ICM_LAYER_WIDTH 4

//lay One Number.

`define ICM_LAYER_ONE_NUM 4'h0

//lay Two Number.

`define ICM_LAYER_TWO_NUM 4'h1

//lay Three Number.

`define ICM_LAYER_THREE_NUM 4'h2

//lay Four Number.

`define ICM_LAYER_FOUR_NUM 4'h3

//lay Five Number.

`define ICM_LAYER_FIVE_NUM 4'h4

//lay Six Number.

`define ICM_LAYER_SIX_NUM 4'h5

//lay Seven Number.

`define ICM_LAYER_SEVEN_NUM 4'h6

//lay Eight Number.

`define ICM_LAYER_EIGHT_NUM 4'h7

//lay Nine Number.

`define ICM_LAYER_NINE_NUM 4'h8

//lay Ten Number.

`define ICM_LAYER_TEN_NUM 4'h9

//lay Eleven Number.

`define ICM_LAYER_ELEVEN_NUM 4'ha

//lay TWELVE Number.

`define ICM_LAYER_TWELVE_NUM 4'hb

//lay THIRTEEN Number.

`define ICM_LAYER_THIRTEEN_NUM 4'hc

//lay FOURTEEN Number.

`define ICM_LAYER_FOURTEEN_NUM 4'hd

//lay FIFTEEN Number.

`define ICM_LAYER_FIFTEEN_NUM 4'he

//lay SIXTEEN Number.

`define ICM_LAYER_SIXTEEN_NUM 4'hf

`define ICM_HAS_LAYER3














//Require maximum width busses to be passed from one module to another.

`define ICM_MAX_BUS_NUM_HSEL 16

//Require maximum width busses to be passed from one module to another.

`define ICM_BUS_NUM_HSEL 3

//Require maximum width busses to be passed from one module to another.

`define ICM_MAX_BUS_HADDR_WIDTH 512

//Require maximum width busses to be passed from one module to another.

`define ICM_BUS_HADDR_WIDTH 96

//Require maximum width busses to be passed from one module to another.

`define ICM_MAX_BUS_HTRANS_WIDTH 32

//Require maximum width busses to be passed from one module to another.

`define ICM_BUS_HTRANS_WIDTH 6

//Require maximum width busses to be passed from one module to another.

`define ICM_MAX_BUS_HSIZE_WIDTH 48

//Require maximum width busses to be passed from one module to another.

`define ICM_BUS_HSIZE_WIDTH 9

//Require maximum width busses to be passed from one module to another.

`define ICM_MAX_BUS_HBURST_WIDTH 48

//Require maximum width busses to be passed from one module to another.

`define ICM_BUS_HBURST_WIDTH 9

//Require maximum width busses to be passed from one module to another.

`define ICM_MAX_BUS_HPROT_WIDTH 64

//Require maximum width busses to be passed from one module to another.

`define ICM_BUS_HPROT_WIDTH 12

//Require maximum width busses to be passed from one module to another.

`define ICM_MAX_BUS_HMASTER_WIDTH 64

//Require maximum width busses to be passed from one module to another.

`define ICM_BUS_HMASTER_WIDTH 12

//Require maximum width busses to be passed from one module to another.
//`define ICM_BUS_MID_WIDTH `ICM_NUM_LAYERS * `MID_WIDTH

`define ICM_BUS_MID_WIDTH 1

//Require maximum width busses to be passed from one module to another.

`define ICM_MAX_BUS_DATA_WIDTH 1024

//Require maximum width busses to be passed from one module to another.

`define ICM_BUS_DATA_WIDTH 192

//The module may have unique priority. In which case the configuration is
//checked. Fixed for current release.

`define ICM_HAS_UNIQUEP 1

//Allow the priority values to be changed.

`define ICM_PRIORITIES_CHANGEABLE 0


// Name:         ICM_PRIORITY_L1
// Default:      0x2 ([ <functionof> ICM_NUM_LAYERS 1 ])
// Values:       0x0, ..., 0xf
// Enabled:      ICM_NUM_LAYERS >= 2 && ICM_PRIORITIES_CHANGEABLE == 1
// 
// Priority of the layer. 
// The higher the number the higher the priority. 
// Priorities are fixed for current release.
`define ICM_PRIORITY_L1 4'h2


// Name:         ICM_PRIORITY_L2
// Default:      0x1 ([ <functionof> ICM_NUM_LAYERS 2 ])
// Values:       0x0, ..., 0xf
// Enabled:      ICM_NUM_LAYERS >= 2 && ICM_PRIORITIES_CHANGEABLE == 1
// 
// Priority of the layer. 
// The higher the number the higher the priority. 
// Priorities are fixed for current release.
`define ICM_PRIORITY_L2 4'h1


// Name:         ICM_PRIORITY_L3
// Default:      0x0 ([ <functionof> ICM_NUM_LAYERS 3 ])
// Values:       0x0, ..., 0xf
// Enabled:      ICM_NUM_LAYERS >= 3 && ICM_PRIORITIES_CHANGEABLE == 1
// 
// Priority of the layer. 
// The higher the number the higher the priority. 
// Priorities are fixed for current release.
`define ICM_PRIORITY_L3 4'h0


// Name:         ICM_PRIORITY_L4
// Default:      0x0 ([ <functionof> ICM_NUM_LAYERS 4 ])
// Values:       0x0, ..., 0xf
// Enabled:      ICM_NUM_LAYERS >= 4 && ICM_PRIORITIES_CHANGEABLE == 1
// 
// Priority of the layer. 
// The higher the number the higher the priority. 
// Priorities are fixed for current release.
`define ICM_PRIORITY_L4 4'h0


// Name:         ICM_PRIORITY_L5
// Default:      0x0 ([ <functionof> ICM_NUM_LAYERS 5 ])
// Values:       0x0, ..., 0xf
// Enabled:      ICM_NUM_LAYERS >= 5 && ICM_PRIORITIES_CHANGEABLE == 1
// 
// Priority of the layer. 
// The higher the number the higher the priority. 
// Priorities are fixed for current release.
`define ICM_PRIORITY_L5 4'h0


// Name:         ICM_PRIORITY_L6
// Default:      0x0 ([ <functionof> ICM_NUM_LAYERS 6 ])
// Values:       0x0, ..., 0xf
// Enabled:      ICM_NUM_LAYERS >= 6 && ICM_PRIORITIES_CHANGEABLE == 1
// 
// Priority of the layer. 
// The higher the number the higher the priority. 
// Priorities are fixed for current release.
`define ICM_PRIORITY_L6 4'h0


// Name:         ICM_PRIORITY_L7
// Default:      0x0 ([ <functionof> ICM_NUM_LAYERS 7 ])
// Values:       0x0, ..., 0xf
// Enabled:      ICM_NUM_LAYERS >= 7 && ICM_PRIORITIES_CHANGEABLE == 1
// 
// Priority of the layer. 
// The higher the number the higher the priority. 
// Priorities are fixed for current release.
`define ICM_PRIORITY_L7 4'h0


// Name:         ICM_PRIORITY_L8
// Default:      0x0 ([ <functionof> ICM_NUM_LAYERS 8 ])
// Values:       0x0, ..., 0xf
// Enabled:      ICM_NUM_LAYERS >= 8 && ICM_PRIORITIES_CHANGEABLE == 1
// 
// Priority of the layer. 
// The higher the number the higher the priority. 
// Priorities are fixed for current release.
`define ICM_PRIORITY_L8 4'h0


// Name:         ICM_PRIORITY_L9
// Default:      0x0 ([ <functionof> ICM_NUM_LAYERS 9 ])
// Values:       0x0, ..., 0xf
// Enabled:      ICM_NUM_LAYERS >= 9 && ICM_PRIORITIES_CHANGEABLE == 1
// 
// Priority of the layer. 
// The higher the number the higher the priority. 
// Priorities are fixed for current release.
`define ICM_PRIORITY_L9 4'h0


// Name:         ICM_PRIORITY_L10
// Default:      0x0 ([ <functionof> ICM_NUM_LAYERS 10 ])
// Values:       0x0, ..., 0xf
// Enabled:      ICM_NUM_LAYERS >= 10 && ICM_PRIORITIES_CHANGEABLE == 1
// 
// Priority of the layer. 
// The higher the number the higher the priority. 
// Priorities are fixed for current release.
`define ICM_PRIORITY_L10 4'h0


// Name:         ICM_PRIORITY_L11
// Default:      0x0 ([ <functionof> ICM_NUM_LAYERS 11 ])
// Values:       0x0, ..., 0xf
// Enabled:      ICM_NUM_LAYERS >= 11 && ICM_PRIORITIES_CHANGEABLE == 1
// 
// Priority of the layer. 
// The higher the number the higher the priority. 
// Priorities are fixed for current release.
`define ICM_PRIORITY_L11 4'h0


// Name:         ICM_PRIORITY_L12
// Default:      0x0 ([ <functionof> ICM_NUM_LAYERS 12 ])
// Values:       0x0, ..., 0xf
// Enabled:      ICM_NUM_LAYERS >= 12 && ICM_PRIORITIES_CHANGEABLE == 1
// 
// Priority of the layer. 
// The higher the number the higher the priority. 
// Priorities are fixed for current release.
`define ICM_PRIORITY_L12 4'h0


// Name:         ICM_PRIORITY_L13
// Default:      0x0 ([ <functionof> ICM_NUM_LAYERS 13 ])
// Values:       0x0, ..., 0xf
// Enabled:      ICM_NUM_LAYERS >= 13 && ICM_PRIORITIES_CHANGEABLE == 1
// 
// Priority of the layer. 
// The higher the number the higher the priority. 
// Priorities are fixed for current release.
`define ICM_PRIORITY_L13 4'h0


// Name:         ICM_PRIORITY_L14
// Default:      0x0 ([ <functionof> ICM_NUM_LAYERS 14 ])
// Values:       0x0, ..., 0xf
// Enabled:      ICM_NUM_LAYERS >= 14 && ICM_PRIORITIES_CHANGEABLE == 1
// 
// Priority of the layer. 
// The higher the number the higher the priority. 
// Priorities are fixed for current release.
`define ICM_PRIORITY_L14 4'h0


// Name:         ICM_PRIORITY_L15
// Default:      0x0 ([ <functionof> ICM_NUM_LAYERS 15 ])
// Values:       0x0, ..., 0xf
// Enabled:      ICM_NUM_LAYERS >= 15 && ICM_PRIORITIES_CHANGEABLE == 1
// 
// Priority of the layer. 
// The higher the number the higher the priority. 
// Priorities are fixed for current release.
`define ICM_PRIORITY_L15 4'h0


// Name:         ICM_PRIORITY_L16
// Default:      0x0 ([ <functionof> ICM_NUM_LAYERS 16 ])
// Values:       0x0, ..., 0xf
// Enabled:      ICM_NUM_LAYERS >= 16 && ICM_PRIORITIES_CHANGEABLE == 1
// 
// Priority of the layer. 
// The higher the number the higher the priority. 
// Priorities are fixed for current release.
`define ICM_PRIORITY_L16 4'h0

//Random Seed For Simulations. Anything between 1 and 31.

`define ICM_RAND_SEED 18

//Width of the priority bus when using the DW_arbiter_dp.

`define ICM_DP_PWIDTH 2

`define ICM_PRIORITY_WIDTH (`ICM_NUM_LAYERS*`ICM_DP_PWIDTH)


// `define ICM_ENCRYPT

