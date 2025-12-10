`timescale 1ns/1ns

module tb_full_adder;

    // 1. ประกาศตัวแปร
    // input ของ Module ใช้ reg (เพราะเราต้องกำหนดค่าให้มัน)
    reg t_a;
    reg t_b;
    reg t_cin;
    
    // output ของ Module ใช้ wire (เพราะรับค่าจากการต่อสาย)
    wire t_sum;
    wire t_cout;

    // 2. เรียกใช้ (Instantiate) Module ที่เราจะเทส (Unit Under Test - UUT)
    full_adder uut (
        .a(t_a),
        .b(t_b),
        .cin(t_cin),
        .sum(t_sum),
        .cout(t_cout)
    );

    // 3. เริ่มการทดสอบ (Stimulus)
    initial begin
        // สร้างไฟล์สำหรับดู Waveform (GTKWave)
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_full_adder);

        // แสดงผลทางหน้าจอ (Monitor changes)
        $monitor("Time: %0t | a = %b | b = %b | cin = %b | sum = %b | cout = %b", $time, t_a, t_b, t_cin , t_sum, t_cout);

        // ป้อนค่าทดสอบ (Truth Table)
        t_a = 0; t_b = 0; t_cin = 0; #10;
        t_a = 0; t_b = 0; t_cin = 1; #10;
        t_a = 0; t_b = 1; t_cin = 0; #10;
        t_a = 0; t_b = 1; t_cin = 1; #10;
        t_a = 1; t_b = 0; t_cin = 0; #10;
        t_a = 1; t_b = 0; t_cin = 1; #10;
        t_a = 1; t_b = 1; t_cin = 0; #10;
        t_a = 1; t_b = 1; t_cin = 1; #10;

        // จบการทำงาน
        $finish;
    end

endmodule