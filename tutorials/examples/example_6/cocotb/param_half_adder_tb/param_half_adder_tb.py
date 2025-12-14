import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def param_half_adder_test(dut):
    """ Testbench for Parameterized Half Adder """

    # Test parameters
    WIDTH = len(dut.a)

    # Apply test vectors
    for i in range(2**WIDTH):
        for j in range(2**WIDTH):
            # Set inputs
            dut.a.value = i
            dut.b.value = j
            await Timer(10, units='ns')

            # Calculate expected outputs
            expected_sum = (i + j) & ((1 << WIDTH) - 1)
            expected_cout = (i + j) >> WIDTH

            # Check outputs
            assert dut.sum.value == expected_sum, f"Test failed for a={i}, b={j}: Expected sum={expected_sum}, Got sum={dut.sum.value}"
            assert dut.cout.value == expected_cout, f"Test failed for a={i}, b={j}: Expected cout={expected_cout}, Got cout={dut.cout.value}"

    cocotb.log.info("Parameterized Half Adder test completed successfully.")