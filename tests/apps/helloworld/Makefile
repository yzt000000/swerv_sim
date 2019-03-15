src_dir := $(dir $(lastword $(MAKEFILE_LIST)))

FLAGS = -O3 -funroll-loops -fpeel-loops -fgcse-sm -fgcse-las -flto

FLAGS_STR = "$(FLAGS)"

CFLAGS := $(FLAGS)  \
-static -std=gnu99 -fno-common -fno-builtin-printf \
-Wa,-march=rv32imc -march=rv32imc -mabi=ilp32  \
-DFLAGS_STR=\"$(FLAGS_STR)\" \
-DSELF_TIMED=1 -DTIME=1
LDFLAGS := -march=rv32imc  -nostartfiles -Wl,--no-relax,-Bstatic,-T,$(ld_script) -ffreestanding -nostdlib 
bsp_dir=$(tests_dir)/bsp
common_dir=${tests_dir}/common

VPATH += $(src_dir) $(bsp_dir) $(common_dir)

incs += -I$(src_dir) -I$(bsp_dir) -I$(common_dir)


baseaddr := 0


c_src := printf.c helloworld.c
asm_src := startup.S
ld_script := $(bsp_dir)/link.ld

c_objs   := $(addprefix $(bld_dir)/,$(patsubst %.c, %.o, $(c_src)  ))
asm_objs := $(addprefix $(bld_dir)/,$(patsubst %.S, %.o, $(asm_src)))

default: $(bld_dir)/helloworld.elf $(bld_dir)/helloworld.hex $(bld_dir)/helloworld.dump $(bld_dir)/helloworld.tcm


$(bld_dir)/helloworld.elf: ${bsp_dir}/link.ld ${bsp_dir}/startup.S ${common_dir}/printf.c helloworld.c
	$(RISCV_GCC) -march=rv32imc -mabi=ilp32  -nostartfiles -Wl,--no-relax,-Bstatic,-T,${bsp_dir}/link.ld -ffreestanding -nostdlib -g -o $@ ${bsp_dir}/startup.S ${common_dir}/printf.c helloworld.c -I${common_dir} -I${bsp_dir}

$(bld_dir)/%.hex: $(bld_dir)/%.elf
	$(RISCV_OBJCOPY) $^ $@

$(bld_dir)/%.dump: $(bld_dir)/%.elf
	$(RISCV_OBJDUMP) $^ > $@


$(bld_dir)/%.tcm: $(bld_dir)/%.hex
	perl $(tests_dir)/bin/th.pl -f  $^  -o $@ -b $(baseaddr)



clean:
	$(RM) $(c_objs) $(asm_objs) $(bld_dir)/helloworld.elf $(bld_dir)/helloworld.hex $(bld_dir)/helloworld.dump $(bld_dir)/helloworld.tcm
