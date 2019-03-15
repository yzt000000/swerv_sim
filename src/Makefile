src_dir := $(dir $(lastword $(MAKEFILE_LIST)))
rtl_dir := $(root_dir)/src/
rtl_files ?= swerv_top.files
top_module ?=swerv_top_tb 

rtl_list := $(addprefix $(rtl_dir),$(shell cat $(rtl_dir)$(rtl_files)))
sv_list := $(filter %.sv,$(rtl_list))



# Check for RV_ROOT
ifeq (,$(wildcard ${RV_ROOT}/configs/swerv.config))
$(error env var RV_ROOT does not point to a valid dir! Exiting!)
endif

# Allow snapshot override
ifeq ($(strip $(snapshot)),)
	snapshot = default
endif

defines = ${RV_ROOT}/configs/snapshots/$(snapshot)/common_defines.vh ${RV_ROOT}/design/include/def.sv
includes = -I${RV_ROOT}/design/include -I${RV_ROOT}/design/lib -I${RV_ROOT}/design/dmi -I${RV_ROOT}/configs/snapshots/$(snapshot)
# CFLAGS for verilator generated Makefiles. Without -std=c++11 it complains for `auto` variables
CFLAGS += "-std=c++11"




.PHONY:  build_vcs 

default: build_vcs

export snapshot=default

build_vcs: $(rtl_list) ${RV_ROOT}/configs/snapshots/$(snapshot)/common_defines.vh
	cd $(bld_dir); \
	vcs \
	-full64 \
	-assert svaext \
	-sverilog \
	-notice \
	-debug_region=lib+cell \
	-debug_pp \
	-LDFLAGS "-Wl,--rpath,$(NOVAS_HOME)/share/PLI/VCS/LINUX64 " \
	+lint=all,noVCDE \
	-timescale=1ns/1ps \
	$(VCS_OPTS) \
	-nc \
	-debug_all \
	+libext+.v \
	+incdir+$(rtl_dir)includes \
	+define+RV_OPENSOURCE \
	+error+500 \
	+incdir+${RV_ROOT}/design/lib  \
	+incdir+${RV_ROOT}/design/include \
	+incdir+${RV_ROOT}/design/dmi \
	+incdir+${RV_ROOT}/configs/snapshots/$(snapshot) \
	${RV_ROOT}/configs/snapshots/$(snapshot)/common_defines.vh \
	${RV_ROOT}/design/include/def.sv \
	$(rtl_list) \
	${RV_ROOT}/testbench/tb_top.sv \
	-I${RV_ROOT}/testbench \
	${RV_ROOT}/testbench/ahb_sif.sv \
	-l vcs.log



run_verdi: $(rtl_list) ${RV_ROOT}/configs/snapshots/$(snapshot)/common_defines.vh
	cd fsdb; \
	verdi \
	-lca \
	-sverilog \
	-timescale=1ns/1ps \
	+incdir+$(rtl_dir)includes \
	+define+RV_OPENSOURCE \
	+incdir+${RV_ROOT}/design/lib  \
	+incdir+${RV_ROOT}/design/include \
	+incdir+${RV_ROOT}/design/dmi \
	+incdir+${RV_ROOT}/configs/snapshots/$(snapshot) \
	${RV_ROOT}/configs/snapshots/$(snapshot)/common_defines.vh \
	${RV_ROOT}/design/include/def.sv \
	$(rtl_list) \
	${RV_ROOT}/testbench/tb_top.sv \
	-I${RV_ROOT}/testbench \
	${RV_ROOT}/testbench/ahb_sif.sv \
	-top $(top_module) \ 
	-l verdi.log

