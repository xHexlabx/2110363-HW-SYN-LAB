import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def MultiplexerTB(dut):
    """Try accessing the design."""
    dut._log.info("Running test!")

    for i in range(16):
        for j in range(16):
            for k in range(2):
                dut.in_0.value = i
                dut.in_1.value = j
                dut.selector.value = k
                await Timer(1, units='ns')
                if(k == 0):
                    assert dut.data_out.value == i
                else:
                    assert dut.data_out.value == j
    
    dut._log.info("Test Complete")