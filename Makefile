#------------------------------------------------------------------------------
# Makefile for RISCV
#------------------------------------------------------------------------------

VCS_OPTS ?=
MODELSIM_OPTS ?=
NCSIM_OPTS ?=

# Paths
export root_dir := $(shell pwd)
export bld_dir := $(root_dir)/build
export tests_dir := $(root_dir)/tests

test_results := $(bld_dir)/test_results.txt
test_info := $(bld_dir)/test_info
tcm_info  := $(bld_dir)/tcm_info
itcm_info  := $(bld_dir)/itcm_info
dtcm_info  := $(bld_dir)/dtcm_info

ifndef TB
	TB=sram
endif

# Environment
export CROSS_PREFIX ?= riscv64-unknown-elf-
export RISCV_GCC ?= $(CROSS_PREFIX)gcc
export RISCV_OBJDUMP ?= $(CROSS_PREFIX)objdump -D
export RISCV_OBJCOPY ?= $(CROSS_PREFIX)objcopy -O verilog
export RISCV_READELF ?= $(CROSS_PREFIX)readelf -s


export rtl_files  := swerv_top.files
export top_module := tb_top



ifndef TS
	TS = test1
endif

ifndef FSDB
	FSDB =0
endif


# Targets
.PHONY: tests run_vcs 

default: run_vcs


tests: $(root_dir)/tests/apps/$(TS)/$(TS).c 
	$(MAKE) -C $(root_dir)/tests/apps/$(TS) 

$(test_info): clean_hex clean_tcm tests
	cd $(bld_dir); \
	rm test_info; \
	rm tcm_info; \
	rm itcm_info; \
	rm dtcm_info; \
	ls -tr *.hex > $@
$(tcm_info): 
	cd $(bld_dir); \
	cp test_info tcm_info; \
	sed -i 's/hex/tcm/' tcm_info ;

$(itcm_info): 
	cd $(bld_dir); \
	cp test_info itcm_info; \
	sed -i 's/hex/itcm/' itcm_info ;

$(dtcm_info): 
	cd $(bld_dir); \
	cp test_info dtcm_info; \
	sed -i 's/hex/dtcm/' dtcm_info ;

ifeq ($(FSDB),0)
DUMP_COMMAND1:=""
DUMP_COMMAND2:=""
else
DUMP_COMMAND1='fsdbAutoSwitchDumpfile 25 ../fsdb/$(FSDB).fsdb 0'
DUMP_COMMAND2='fsdbDumpvars 0 "$(top_module)"' 
endif

build_dump:
	echo $(FSDB)
	echo $(DUMP_COMMAND1) > src/dump.ucli
	echo $(DUMP_COMMAND2) >> src/dump.ucli
	echo 'run' >> src/dump.ucli


#helloworld: | $(bld_dir)
#	$(MAKE) -C $(root_dir)/tests/apps/helloworld 


$(bld_dir):
	mkdir -p $(bld_dir)

run_vcs: build_dump $(test_info) $(tcm_info) $(itcm_info) $(dtcm_info) 
	$(MAKE) -C $(root_dir)/src build_vcs;
	printf "" > $(test_results);
	cd $(bld_dir); \
	$(bld_dir)/simv +fsdb+all=on +fsdb+mda=on -ucli -i ../src/dump.ucli \
	+test_info=$(tcm_info) \
	+tcm_info=$(tcm_info) \
	+itcm_info=$(itcm_info) \
	+dtcm_info=$(dtcm_info) \
	+test_results=$(test_results) \
	+imem_pattern=$(imem_pattern) \
	+dmem_pattern=$(dmem_pattern) \
	$(VCS_OPTS)

run_verdi:
	$(MAKE) -C $(root_dir)/src run_verdi; 

clean: clean_tcm clean_hex
	$(RM) $(test_info)
	$(RM) $(tcm_info)
	$(RM) $(bld_dir)/*.o
	$(RM) $(bld_dir)/*.log
	$(RM) -rf $(bld_dir)/simv* 
	$(RM) -rf $(bld_dir)/csrc

clean_hex:
	$(RM) -rf $(bld_dir)/*.hex

clean_tcm:
	$(RM) -rf $(bld_dir)/*tcm

clean_all: clean
	$(RM)  -rf $(bld_dir)/*
