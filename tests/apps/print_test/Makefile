src_dir := $(dir $(lastword $(MAKEFILE_LIST)))

FLAGS = -O3 -funroll-loops -fpeel-loops -fgcse-sm -fgcse-las -flto
FLAGS_STR = "$(FLAGS)"


CFLAGS := $(FLAGS)  \
-static -std=gnu99 -fno-common -fno-builtin-printf \
-Wa,-march=rv32imc -march=rv32imc -mabi=ilp32  \
-DFLAGS_STR=\"$(FLAGS_STR)\" \
-DSELF_TIMED=1 -DTIME=1
LDFLAGS := -nostartfiles -nostdlib -lc -lgcc -march=rv32imc -mabi=ilp32
bsp_dir=$(tests_dir)/bsp
common_dir=${tests_dir}/common

VPATH += $(src_dir) $(bsp_dir) $(common_dir)

incs += -I$(src_dir) -I$(bsp_dir) -I$(common_dir)


baseaddr := 0


c_src := sc_printf.c print_test.c
asm_src := startup.S
ld_script := $(bsp_dir)/link.ld

c_objs   := $(addprefix $(bld_dir)/,$(patsubst %.c, %.o, $(c_src)  ))
asm_objs := $(addprefix $(bld_dir)/,$(patsubst %.S, %.o, $(asm_src)))

default: $(bld_dir)/print_test.elf $(bld_dir)/print_test.hex $(bld_dir)/print_test.dump $(bld_dir)/print_test.tcm

$(bld_dir)/%.o: %.S
	$(RISCV_GCC) $(CFLAGS) -D__ASSEMBLY__=1 -c $(incs) $< -o $@

$(bld_dir)/%.o: %.c
	$(RISCV_GCC) $(CFLAGS) -c $(incs) $< -o $@

$(bld_dir)/print_test.elf: $(ld_script) $(c_objs) $(asm_objs)
	$(RISCV_GCC) -o $@ -T $^ $(LDFLAGS)


$(bld_dir)/%.hex: $(bld_dir)/%.elf
	$(RISCV_OBJCOPY) $^ $@

$(bld_dir)/%.dump: $(bld_dir)/%.elf
	$(RISCV_OBJDUMP) $^ > $@


$(bld_dir)/%.tcm: $(bld_dir)/%.hex
	perl $(tests_dir)/bin/th.pl -f  $^  -o $@ -b $(baseaddr)



clean:
	$(RM) $(c_objs) $(asm_objs) $(bld_dir)/print_test.elf $(bld_dir)/print_test.hex $(bld_dir)/print_test.dump $(bld_dir)/print_test.tcm
