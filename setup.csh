setenv RV_ROOT ${home}/githome/swerv_sim/src


setenv PATH "${PATH}:/opt/riscv/bin"
setenv RISCV_TESTS  "${home}/syntacore/riscv-tests"
setenv RISCV_TOOLS_PATH "${home}/riscv-toolchain"
setenv  CROSS_PREFIX "riscv32-unknown-elf-"
setenv  OOCD_ROOT "${RISCV_TOOLS_PATH}/openocd"
setenv  OPENOCD_SCRIPTS "${OOCD_ROOT}/tcl"
#setenv  PATH "${RISCV_TOOLS_PATH}/riscv-unknown-elf-gcc/bin:${RISCV_TOOLS_PATH}/openocd/src:${PATH} "
#-----------------------------------------------------------------------------------------
