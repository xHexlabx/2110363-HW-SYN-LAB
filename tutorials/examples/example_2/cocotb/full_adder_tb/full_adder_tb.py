import cocotb
from cocotb.triggers import Timer
import random

@cocotb.test()

async def full_adder_basic_test(dut):

    """
    Basic test checking all 8 truth table cases for a Full Adder.
    """
    
    # Truth table for Full Adder
    # A | B | Cin | Sum | Cout
    # --+---+-----+-----+-----
    # 0 | 0 |  0  |  0  |  0
    # 0 | 0 |  1  |  1  |  0
    # 0 | 1 |  0  |  1  |  0
    # 0 | 1 |  1  |  0  |  1
    # 1 | 0 |  0  |  1  |  0
    # 1 | 0 |  1  |  0  |  1
    # 1 | 1 |  0  |  0  |  1
    # 1 | 1 |  1  |  1  |  1

    truth_table = [
        (0, 0, 0, 0, 0),
        (0, 0, 1, 1, 0),
        (0, 1, 0, 1, 0),
        (0, 1, 1, 0, 1),
        (1, 0, 0, 1, 0),
        (1, 0, 1, 0, 1),
        (1, 1, 0, 0, 1),
        (1, 1, 1, 1, 1)
    ]

    for a_val, b_val, cin_val, expected_sum, expected_cout in truth_table:
        # Drive inputs
        dut.a.value = a_val
        dut.b.value = b_val
        dut.cin.value = cin_val

        # Wait for propagation
        await Timer(1, unit="ns")

        # Check outputs
        assert dut.sum.value == expected_sum, \
            f"Error: For inputs a={a_val}, b={b_val}, cin={cin_val}, expected sum={expected_sum} but got {dut.sum.value}"
        assert dut.cout.value == expected_cout,\
            f"Error: For inputs a={a_val}, b={b_val}, cin={cin_val}, expected cout={expected_cout} but got {dut.cout.value}"