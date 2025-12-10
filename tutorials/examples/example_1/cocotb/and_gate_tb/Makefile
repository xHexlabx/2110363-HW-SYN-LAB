# Makefile

SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Path ไปหาไฟล์ Verilog
VERILOG_SOURCES += $(PWD)/../../src/and_gate.v

TOPLEVEL = and_gate

# เปลี่ยนจาก MODULE เป็น COCOTB_TEST_MODULES เพื่อแก้ Warning
COCOTB_TEST_MODULES = test_and_gate

# จัด Log ให้สวยงาม (ตามที่คุยกันก่อนหน้า)
export COCOTB_REDUCED_LOG_FMT=1

include $(shell cocotb-config --makefiles)/Makefile.sim