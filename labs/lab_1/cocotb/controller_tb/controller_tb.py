import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

@cocotb.test()
async def test_press_to_run(dut):
    """
    Test logic: Release(1)=Reset, Press(0)=Run
    """
    dut._log.info("Starting Test: Press-to-Run Logic...")

    # 1. Start Clock
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())

    # 2. Initial State: Release Button (rst=1) -> Should be Reset
    dut._log.info("Phase 1: Button Released (rst=1) -> Assert Reset")
    dut.rst.value = 1
    await Timer(20, units="ns")
    
    # ตรวจสอบว่า Reset จริงหรือไม่
    assert dut.an.value.binstr == "1111", "Failed: Should be Reset (1111) when rst=1"
    assert dut.counter.value == 0, "Failed: Counter should be 0 when rst=1"

    # 3. Action: Press Button (rst=0) -> Should Run
    dut._log.info("Phase 2: Button Pressed (rst=0) -> Start Running")
    dut.rst.value = 0
    await RisingEdge(dut.clk) # รอ Clock ลูกแรก

    # 4. Fast Forward ไปจุดที่เปลี่ยนสถานะ
    # เนื่องจากต้องนับเยอะ เราจะยัดค่าลง counter ไปเลยเพื่อประหยัดเวลา simulation
    dut.counter.value = 131070
    
    await RisingEdge(dut.clk) # 131071
    await RisingEdge(dut.clk) # 131072 (Bit 17 flips)
    await RisingEdge(dut.clk) # Update Output
    await RisingEdge(dut.clk) # Update Output

    # 5. ตรวจสอบว่าทำงาน (เปลี่ยนสถานะ)
    expected_an = "1101"
    assert dut.an.value.binstr == expected_an, \
        f"Failed: Should switch state to {expected_an} when running. Got {dut.an.value.binstr}"
        
    dut._log.info("Phase 3: Logic works correctly while button is pressed!")

    # 6. Action: Release Button (rst=1) -> Should Reset Immediately
    dut._log.info("Phase 4: Button Released (rst=1) -> Stop & Reset")
    dut.rst.value = 1
    await Timer(20, units="ns") # Reset ทำงานทันทีไม่ต้องรอ Clock (Async)
    
    assert dut.an.value.binstr == "1111", "Failed: Should return to Reset state immediately"
    assert dut.counter.value == 0, "Failed: Counter should be cleared immediately"

    dut._log.info("All Tests Passed!")