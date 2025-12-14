# Makefile

SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Path ไปหาไฟล์ Verilog
VERILOG_SOURCES += $(PWD)/../../src/param_half_adder.v

TOPLEVEL = param_half_adder

# เปลี่ยนจาก MODULE เป็น COCOTB_TEST_MODULES เพื่อแก้ Warning
COCOTB_TEST_MODULES = param_half_adder_tb

include $(shell cocotb-config --makefiles)/Makefile.sim