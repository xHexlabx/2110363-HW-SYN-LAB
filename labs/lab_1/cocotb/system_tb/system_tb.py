import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

# Truth Table สำหรับเช็คค่า Segments (0-F)
SEGMENTS_MAP = {
    0:  "11000000", 1:  "11111001", 2:  "10100100", 3:  "10110000",
    4:  "10011001", 5:  "10010010", 6:  "10000010", 7:  "11111000",
    8:  "10000000", 9:  "10010000", 10: "10001000", 11: "10000011",
    12: "11000110", 13: "10100001", 14: "10000110", 15: "10001110"
}

@cocotb.test()
async def test_system_integration(dut):
    """
    Test System Integration: Controller + Mux + Decoder
    """
    dut._log.info("Starting System Integration Test...")

    # 1. Setup Inputs & Clock
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())
    
    # กำหนดค่า Input switches: 8'hA5 (Binary 1010 0101)
    # digit 0 (sw[3:0]) = 5 (0101)
    # digit 1 (sw[7:4]) = A (1010)
    test_val_low = 5
    test_val_high = 10 # 0xA
    dut.sw.value = (test_val_high << 4) | test_val_low 
    
    # 2. Reset Sequence (Active High: 1=Reset)
    dut.rst.value = 1
    await Timer(20, units="ns")
    dut.rst.value = 0 # Run
    dut._log.info("Reset Released, System Running...")
    
    await RisingEdge(dut.clk)

    # 3. Verify State 0 (แสดงผล Digit 0)
    # Controller State 0 -> selector=0 -> Mux เลือก sw[3:0] (5) -> Decoder ออกเลข 5
    # an ควรเป็น 1110 (Active Low Digit 0)
    
    await RisingEdge(dut.clk) # รอให้ Logic ทำงาน
    
    expected_an_0 = "1110"
    expected_seg_0 = SEGMENTS_MAP[test_val_low] # เลข 5
    
    assert dut.an.value.binstr == expected_an_0, \
        f"State 0 AN Fail: Expected {expected_an_0}, Got {dut.an.value.binstr}"
    assert dut.segments.value.binstr == expected_seg_0, \
        f"State 0 Seg Fail: Expected {expected_seg_0} (Num {test_val_low}), Got {dut.segments.value.binstr}"
        
    dut._log.info(f"PASS: State 0 displaying {test_val_low} correctly on AN={dut.an.value.binstr}")

    # 4. Force Counter (ข้ามเวลา)
    # เข้าถึงตัวแปรภายใน: dut.<ชื่อ instance>.<ชื่อตัวแปร>
    dut._log.info("Forcing internal counter to skip wait time...")
    dut.controller_inst.counter.value = 131070
    
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk) # Counter overflows -> State change
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)


    # 5. Verify State 1 (แสดงผล Digit 1)
    # Controller State 1 -> selector=1 -> Mux เลือก sw[7:4] (A) -> Decoder ออกเลข A
    # an ควรเป็น 1101 (Active Low Digit 1)
    
    expected_an_1 = "1101"
    expected_seg_1 = SEGMENTS_MAP[test_val_high] # เลข A
    
    assert dut.an.value.binstr == expected_an_1, \
        f"State 1 AN Fail: Expected {expected_an_1}, Got {dut.an.value.binstr}"
    assert dut.segments.value.binstr == expected_seg_1, \
        f"State 1 Seg Fail: Expected {expected_seg_1} (Num {test_val_high:X}), Got {dut.segments.value.binstr}"

    dut._log.info(f"PASS: State 1 displaying {test_val_high:X} correctly on AN={dut.an.value.binstr}")
    dut._log.info("All System Tests Passed!")