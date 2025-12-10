import cocotb
from cocotb.triggers import Timer
from cocotb.regression import TestFactory
import random

# Simple directed test
@cocotb.test()
async def and_gate_basic_test(dut):
    """
    Basic test checking all 4 truth table cases for an AND gate.
    """
    
    # Truth table for AND gate
    # A | B | C
    # --+---+--
    # 0 | 0 | 0
    # 0 | 1 | 0
    # 1 | 0 | 0
    # 1 | 1 | 1

    truth_table = [
        (0, 0, 0),
        (0, 1, 0),
        (1, 0, 0),
        (1, 1, 1)
    ]

    for a_val, b_val, expected_c in truth_table:
        # 1. Drive inputs
        dut.a.value = a_val
        dut.b.value = b_val

        # 2. Wait for propagation (1 ns is sufficient for functional sim)
        await Timer(1, unit="ns")

        # 3. Check output
        # We assume '0' and '1' logic levels. 
        # Note: dut.c.value returns a BinaryValue, which compares directly to integers.
        assert dut.c.value == expected_c, \
            f"Error: For inputs a={a_val}, b={b_val}, expected c={expected_c} but got {dut.c.value}"
        
        # Optional: Logging
        dut._log.info(f"PASS: a={a_val}, b={b_val} -> c={dut.c.value}")


# Randomized test example
@cocotb.test()
async def and_gate_random_test(dut):
    """
    Randomized test running multiple iterations.
    """
    for i in range(20):
        # Generate random 0 or 1
        val_a = random.randint(0, 1)
        val_b = random.randint(0, 1)
        
        dut.a.value = val_a
        dut.b.value = val_b
        
        await Timer(1, unit='ns')
        
        expected = val_a & val_b
        assert dut.c.value == expected, \
            f"Random Iteration {i}: a={val_a}, b={val_b}, expected={expected}, got={dut.c.value}"