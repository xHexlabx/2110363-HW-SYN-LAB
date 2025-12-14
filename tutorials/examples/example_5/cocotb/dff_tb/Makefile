# Makefile

SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Path ไปหาไฟล์ Verilog
VERILOG_SOURCES += $(PWD)/../../src/dff.v

TOPLEVEL = dff

# เปลี่ยนจาก MODULE เป็น COCOTB_TEST_MODULES เพื่อแก้ Warning
COCOTB_TEST_MODULES = dff_tb

include $(shell cocotb-config --makefiles)/Makefile.sim