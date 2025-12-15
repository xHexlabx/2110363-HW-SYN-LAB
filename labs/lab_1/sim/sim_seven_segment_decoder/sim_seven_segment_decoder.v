`timescale 1ns / 1ps

module sim_seven_segment_decoder ();

  // 1. Declare signals (ใช้ชื่อแบบ Snake Case ตาม Module หลัก)
  reg  [3:0] data_in;
  wire [7:0] segments;

  // 2. Instantiate the Unit Under Test (UUT)
  seven_segment_decoder uut (
      .data_in (data_in),
      .segments(segments)
  );

  // Variable for tracking status
  integer flag = 0;

  // 3. Task to check the output
  task check_output;
    input [3:0] in_val;
    input [7:0] expected_val;
    begin
      data_in = in_val;
      #10; // รอเวลาให้สัญญาณเดินทาง (Propagation Delay)
      
      if (segments !== expected_val) begin
        $error("ERROR: Time=%0t | data_in=%h | segments=%b | Expected=%b", 
                $time, data_in, segments, expected_val);
        flag = 1;
      end
    end
  endtask

  // 4. Test Cases
  initial begin
    $display("Starting Simulation...");
    $dumpfile("wave.vcd");
    // หมายเหตุ: ต้องเปลี่ยนชื่อ module ใน $dumpvars ให้ตรงกับชื่อ module ด้านบน
    $dumpvars(0, sim_seven_segment_decoder);

    // ทดสอบค่า 0-9
    check_output(4'h0, 8'b11000000); // 0
    check_output(4'h1, 8'b11111001); // 1
    check_output(4'h2, 8'b10100100); // 2
    check_output(4'h3, 8'b10110000); // 3
    check_output(4'h4, 8'b10011001); // 4
    check_output(4'h5, 8'b10010010); // 5
    check_output(4'h6, 8'b10000010); // 6
    check_output(4'h7, 8'b11111000); // 7
    check_output(4'h8, 8'b10000000); // 8
    check_output(4'h9, 8'b10010000); // 9

    // ทดสอบค่า A-F
    check_output(4'hA, 8'b10001000); // A
    check_output(4'hB, 8'b10000011); // b
    check_output(4'hC, 8'b11000110); // C
    check_output(4'hD, 8'b10100001); // d
    check_output(4'hE, 8'b10000110); // E
    check_output(4'hF, 8'b10001110); // F

    // สรุปผล
    if (flag == 0) begin
      $display("----------------------------------");
      $display("    ALL TEST CASES PASSED       ");
      $display("----------------------------------");
    end else begin
      $display("----------------------------------");
      $display("    SOME TEST CASES FAILED      ");
      $display("----------------------------------");
    end

    $finish;
  end

endmodule