`timescale 1ns/1ns

module tb_and_gate;

    // 1. ประกาศตัวแปร
    // input ของ Module ใช้ reg (เพราะเราต้องกำหนดค่าให้มัน)
    reg t_a;
    reg t_b;
    
    // output ของ Module ใช้ wire (เพราะรับค่าจากการต่อสาย)
    wire t_c;

    // 2. เรียกใช้ (Instantiate) Module ที่เราจะเทส (Unit Under Test - UUT)
    and_gate uut (
        .a(t_a),
        .b(t_b),
        .c(t_c)
    );

    // 3. เริ่มการทดสอบ (Stimulus)
    initial begin
        // สร้างไฟล์สำหรับดู Waveform (GTKWave)
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_and_gate);

        // แสดงผลทางหน้าจอ (Monitor changes)
        $monitor("Time: %0t | a = %b | b = %b | Output c = %b", $time, t_a, t_b, t_c);

        // ป้อนค่าทดสอบ (Truth Table)
        t_a = 0; t_b = 0; #10; // รอ 10ns
        t_a = 0; t_b = 1; #10;
        t_a = 1; t_b = 0; #10;
        t_a = 1; t_b = 1; #10;

        // จบการทำงาน
        $finish;
    end

endmodule