import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_seven_segment_decoder(dut):
    """
    Testbench for Seven Segment Decoder
    Checks all 16 hex values (0-F) against the expected segment patterns.
    """
    
    dut._log.info("Starting Seven Segment Decoder Test...")

    # Truth Table (Mapping from Input [int] to Expected Output [binary string])
    # อ้างอิงจาก Code Verilog ที่คุณให้มา
    expected_segments = {
        0:  "11000000", # 0
        1:  "11111001", # 1
        2:  "10100100", # 2
        3:  "10110000", # 3
        4:  "10011001", # 4
        5:  "10010010", # 5
        6:  "10000010", # 6
        7:  "11111000", # 7
        8:  "10000000", # 8
        9:  "10010000", # 9
        10: "10001000", # A
        11: "10000011", # b
        12: "11000110", # C
        13: "10100001", # d
        14: "10000110", # E
        15: "10001110"  # F
    }

    # Loop through all 16 possibilities (0 to 15)
    for i in range(16):
        # 1. Drive Input
        dut.data_in.value = i
        
        # 2. Wait for Combinational Logic to settle
        await Timer(1, units='ns')
        
        # 3. Check Output
        # อ่านค่าจริงจาก DUT (Device Under Test)
        # .binstr จะให้ค่าเป็น string เช่น "11000000" ซึ่งง่ายต่อการเปรียบเทียบ
        actual_val = dut.segments.value.binstr 
        expected_val = expected_segments[i]
        
        # เปรียบเทียบผลลัพธ์
        assert actual_val == expected_val, \
            f"Test Failed for Input {i:X} (Hex): Expected {expected_val}, Got {actual_val}"
            
        dut._log.info(f"PASS: Input {i:X} -> Segments {actual_val}")

    dut._log.info("All 16 cases passed successfully!")