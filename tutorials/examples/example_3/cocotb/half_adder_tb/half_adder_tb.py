import cocotb
from cocotb.triggers import Timer
import random

@cocotb.test()
async def half_adder_test(dut):
    """
    Test 4-bit Half Adder (Adder without Carry In)
    Verifies both exhaustive (all combinations) and randomized inputs.
    """
    
    dut._log.info("Starting 4-bit Half Adder Test")

    # 1. Exhaustive Test
    dut._log.info("Phase 1: Exhaustive Testing")
    for a in range(16):
        for b in range(16):
            await run_single_test(dut, a, b)

    # 2. Randomized Test
    dut._log.info("Phase 2: Randomized Testing")
    for _ in range(50):
        a = random.randint(0, 15)
        b = random.randint(0, 15)
        await run_single_test(dut, a, b)

    dut._log.info("All tests passed successfully!")

async def run_single_test(dut, a, b):
    """Helper coroutine to drive inputs and verify outputs"""
    
    # Drive Inputs
    dut.a.value = a
    dut.b.value = b

    # Wait for signals to settle
    # FIX 1: เปลี่ยน units='ns' เป็น unit='ns'
    await Timer(2, unit='ns')

    # Calculate Expected Values
    total_sum = a + b
    expected_sum = total_sum & 0xF
    expected_cout = 1 if total_sum > 15 else 0

    # Read Actual Values
    try:
        # FIX 2: cocotb 2.0 เลิกใช้ .integer
        # ใช้ int(...) สำหรับ single bit (cout)
        # ใช้ .to_unsigned() หรือ int(...) สำหรับ vector (sum)
        actual_sum = int(dut.sum.value)
        actual_cout = int(dut.cout.value)
        
    except ValueError:
        # Catch X/Z states
        raise ValueError(f"DUT returned unknown values (X/Z) for inputs a={a}, b={b}. "
                         f"Got sum={dut.sum.value}, cout={dut.cout.value}")

    # Check Results
    assert actual_sum == expected_sum, \
        f"Sum Error: a={a}, b={b} | Expected {expected_sum}, Got {actual_sum}"
    
    assert actual_cout == expected_cout, \
        f"Cout Error: a={a}, b={b} | Expected {expected_cout}, Got {actual_cout}"