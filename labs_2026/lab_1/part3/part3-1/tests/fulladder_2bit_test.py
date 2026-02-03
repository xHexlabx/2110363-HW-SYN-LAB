import logging
import os
from pathlib import Path
from re import L

import cocotb
from cocotb.triggers import Timer
from cocotb_tools.runner import get_runner


@cocotb.test()
async def fulladder_2bit_test(dut):
    # Create a logger for this testbench
    logger = logging.getLogger("fulladder_2bit_test")
    logger.info("Starting Full Adder 2-bit Testbench")

    #  TODO: Fill your testbench code here

    # Iterate through all possible input combinations
    # a: 2 bits (0-3), b: 2 bits (0-3), cin: 1 bit (0-1)
    for a in range(4):
        for b in range(4):
            for cin in range(2):
                # 1. Assign values to the DUT
                dut.A.value = a
                dut.B.value = b
                dut.Cin.value = cin

                # 2. Wait for combinational logic to propagate
                # Since there is no clock, we just wait for a small amount of simulation time
                await Timer(1, units="ns")

                # 3. Calculate expected values (Python model)
                total = a + b + cin
                expected_sum = total & 0x3  # Lower 2 bits
                expected_cout = (total >> 2) & 0x1  # Carry out bit

                # 4. Capture actual values from DUT
                # .integer converts the BinaryValue object to a standard Python int
                actual_sum = int(dut.Sum.value)
                actual_cout = int(dut.Cout.value)

                logger.info(
                    f"Input: A={a}, B={b}, Cin={cin} | "
                    f"Expected: Sum={expected_sum}, Cout={expected_cout} | "
                    f"Actual: Sum={actual_sum}, Cout={actual_cout}"
                )

                # 5. Assertions
                assert actual_sum == expected_sum, (
                    f"Sum mismatch! {a}+{b}+{cin}: Expected {expected_sum}, got {actual_sum}"
                )
                assert actual_cout == expected_cout, (
                    f"Cout mismatch! {a}+{b}+{cin}: Expected {expected_cout}, got {actual_cout}"
                )

    logger.info("All 32 test cases passed successfully!")


def runner():
    # --- Fill the information below ---

    # Path to all related Verilog files
    verilog_files = ["../fulladder_2bit.v"]

    # Top-level module name
    top_module = "fulladder_2bit"

    # Test module name (normally it is the name of this file without .py
    # except your testcase is in other Python file)
    test_module = "fulladder_2bit_test"

    # ----------------------------------

    sim = os.getenv("SIM", "icarus")

    proj_path = Path(__file__).resolve().parent

    sources = [proj_path / Path(f) for f in verilog_files]

    runner = get_runner(sim)

    runner.build(
        sources=sources,
        hdl_toplevel=top_module,
        always=True,
        waves=True,
        timescale=("1ns", "1ps"),
    )

    runner.test(hdl_toplevel=top_module, test_module=test_module, waves=True)


if __name__ == "__main__":
    runner()
