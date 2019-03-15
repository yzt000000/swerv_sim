# SPDX-License-Identifier: Apache-2.0
# Copyright 2019 Western Digital Corporation or its affiliates.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

src_dir := $(dir $(lastword $(MAKEFILE_LIST)))
baseaddr := 0

BSP_DIR=${tests_dir}/bsp
COMMON_DIR=${tests_dir}/common

#all: hello.elf
default: $(bld_dir)/hello.elf $(bld_dir)/hello.hex $(bld_dir)/hello.dump $(bld_dir)/hello.tcm

$(bld_dir)/hello.elf: ${BSP_DIR}/link.ld ${BSP_DIR}/startup.S ${COMMON_DIR}/printf.c hello.c
	$(RISCV_GCC) -march=rv32imc -mabi=ilp32  -nostartfiles -Wl,--no-relax,-Bstatic,-T,${BSP_DIR}/link.ld -ffreestanding -nostdlib -g -o $@ ${BSP_DIR}/startup.S ${COMMON_DIR}/printf.c hello.c -I${COMMON_DIR} -I${BSP_DIR}
	
	#riscv32-unknown-elf-gcc -march=rv32imc  -nostartfiles -Wl,--no-relax,-Bstatic,-T,${BSP_DIR}/link.ld -ffreestanding -nostdlib -g -o hello.elf ${BSP_DIR}/startup.S ${COMMON_DIR}/printf.c hello.c -I${COMMON_DIR} -I${BSP_DIR}

$(bld_dir)/%.hex: $(bld_dir)/%.elf
	$(RISCV_OBJCOPY) $^ $@

$(bld_dir)/%.dump: $(bld_dir)/%.elf
	$(RISCV_OBJDUMP) $^ > $@


$(bld_dir)/%.tcm: $(bld_dir)/%.hex
	perl $(tests_dir)/bin/th.pl -f  $^  -o $@ -b $(baseaddr)



clean:
	rm -rf *.elf *.o 

