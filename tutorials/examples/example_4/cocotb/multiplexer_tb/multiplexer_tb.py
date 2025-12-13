import cocotb
from cocotb.triggers import Timer
import random

@cocotb.test()
async def multiplexer_test(dut):
    """Test for 4-to-1 Multiplexer"""
    
    dut._log.info("Starting Mux Test")

    for i in range(20):  # Run 20 random test cases
        # 1. Generate random inputs
        # data_in is 4 bits, so range is 0 to 15 (0b0000 to 0b1111)
        data_val = random.randint(0, 15)
        sel_val = random.randint(0, 3)

        # 2. Drive inputs
        dut.data_in.value = data_val
        dut.sel.value = sel_val

        # 3. Wait for combinational logic to settle
        # 'units' is renamed to 'unit' in cocotb 2.0
        await Timer(2, unit='ns')

        # 4. Calculate Expected Output (Golden Model)
        # We shift the data value to the right by 'sel' bits and take the LSB
        # Example: data=1100 (12), sel=2 -> 1100 >> 2 = 11 -> 11 & 1 = 1
        expected_output = (data_val >> sel_val) & 1

        # 5. Read Actual Output
        try:
            # Use int() instead of .integer
            actual_output = int(dut.data_out.value)
        except ValueError:
            # Handle case where output is X (unknown) or Z (high impedance)
            actual_output = "X"

        # 6. Verify
        # We use standard python assert instead of TestFailure
        assert actual_output == expected_output, \
            (f"Test Failed at iter {i}: "
             f"Inputs(data=0b{data_val:04b}, sel={sel_val}) "
             f"| Expected {expected_output}, Got {actual_output}")

    dut._log.info("All random tests passed!")