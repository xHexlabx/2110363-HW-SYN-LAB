# Makefile
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# รวมไฟล์ Verilog ทั้งหมด
VERILOG_SOURCES += $(PWD)/../../src/system.v
VERILOG_SOURCES += $(PWD)/../../src/controller.v
VERILOG_SOURCES += $(PWD)/../../src/multiplexer.v
VERILOG_SOURCES += $(PWD)/../../src/seven_segment_decoder.v

# Module หลักคือ system
TOPLEVEL = system
MODULE = system_tb

# Flag สำหรับ enable block dump ใน controller (ถ้ามี)
COMPILE_ARGS += -DCOCOTB_SIM

include $(shell cocotb-config --makefiles)/Makefile.sim