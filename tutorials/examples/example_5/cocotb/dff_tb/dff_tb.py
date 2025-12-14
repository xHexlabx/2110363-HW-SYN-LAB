import cocotb
from cocotb.triggers import Timer

@cocotb.test()

async def dff_test(dut):
    """ Testbench for D Flip-Flop """

    # Initial values
    dut.d.value = 0
    dut.clk.value = 0
    dut.q.value = 0

    # Apply test vectors
    for i in range(5):
        # Set D input
        dut.d.value = i % 2
        await Timer(10, units='ns')

        # Toggle clock
        dut.clk.value = 1
        await Timer(10, units='ns')
        dut.clk.value = 0
        await Timer(10, units='ns')

        # Check output Q
        assert dut.q.value == dut.d.value, f"Test failed at iteration {i}: D={dut.d.value}, Q={dut.q.value}"

    cocotb.log.info("D Flip-Flop test completed successfully.")