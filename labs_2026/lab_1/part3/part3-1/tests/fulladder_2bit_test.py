import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.triggers import RisingEdge, FallingEdge
import logging

import os
from pathlib import Path
from cocotb_tools.runner import get_runner

@cocotb.test()
async def fulladder_2bit_test(dut):
    # Create a logger for this testbench
    logger = logging.getLogger("fulladder_2bit_test")
    logger.info("Starting Full Adder 2-bit Testbench")
    
    #  TODO: Fill your testbench code here
    
    
    
        
def runner():
    # --- Fill the information below ---
    
    # Path to all related Verilog files
    verilog_files = [
        "../fulladder_2bit.v"
    ]
    
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
        timescale=('1ns','1ps')
    )
    
    runner.test(hdl_toplevel=top_module, test_module=test_module, waves=True)

if __name__ == "__main__":
    runner()