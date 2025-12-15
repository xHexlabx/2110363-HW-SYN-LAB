`timescale 1ns / 1ps

module sim_multiplexer ();
  // reg/wire declaration
  reg  [3:0] in_0;
  reg  [3:0] in_1;
  reg        selector;
  wire [3:0] data_out;

  // instantiate the Multiplexer module
  multiplexer MultiplexerInst (
      .in_0(in_0),
      .in_1(in_1),
      .selector(selector),
      .data_out(data_out)
  );
  // instantiate variable
  integer flag = 0;
  integer TestCaseNo = 0;
  integer i;
  integer j;

  // task to check the output
  task check_output;
    input integer TestCaseNo;
    input reg [3:0] expected_data_out;  // Expected output
    begin
      if (data_out !== expected_data_out) begin
        $error(
            "ERROR: TestCaseNo %0d | Time = %0t | in_0 = %b, in_1 = %b, selector = %b | data_out = %b (Expected: %b)",
            TestCaseNo, $time, in_0, in_1, selector, data_out, expected_data_out);
        flag = 1;
      end
    end
  endtask

  // test cases
  initial begin
    $display("Starting Simulation...");
    $dumpfile("wave.vcd");
    // หมายเหตุ: ต้องเปลี่ยนชื่อ module ใน $dumpvars ให้ตรงกับชื่อ module ด้านบน
    $dumpvars(0, sim_multiplexer);
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        in_0 = i;
        in_1 = j;
        selector = 0;
        #1;
        check_output(TestCaseNo, i);
        TestCaseNo = TestCaseNo + 1;
        selector   = 1;
        #1;
        check_output(TestCaseNo, j);
        TestCaseNo = TestCaseNo + 1;
      end
    end
    if (flag == 0) begin
      $display("All test cases pass");
    end else begin
      $display("Some test cases fail");
    end
    $finish;
  end

endmodule