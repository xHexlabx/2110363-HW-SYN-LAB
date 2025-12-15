# Makefile

SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Path ไปหาไฟล์ Verilog
VERILOG_SOURCES += $(PWD)/../../src/seven_segment_decoder.v

TOPLEVEL = seven_segment_decoder

# เปลี่ยนจาก MODULE เป็น COCOTB_TEST_MODULES เพื่อแก้ Warning
COCOTB_TEST_MODULES = seven_segment_decoder_tb

include $(shell cocotb-config --makefiles)/Makefile.sim