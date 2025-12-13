`timescale 1ns/1ns

module sim_half_adder;

    // 1. ประกาศตัวแปร
    // input ของ Module ใช้ reg (เพราะเราต้องกำหนดค่าให้มัน)
    reg [3 : 0] t_a;
    reg [3 : 0] t_b;
    
    // output ของ Module ใช้ wire (เพราะรับค่าจากการต่อสาย)
    wire [3 : 0] t_sum;
    wire t_cout;

    // 2. เรียกใช้ (Instantiate) Module ที่เราจะเทส (Unit Under Test - UUT)
    half_adder uut (
        .a(t_a),
        .b(t_b),
        .sum(t_sum),
        .cout(t_cout)
    );

    // 3. เริ่มการทดสอบ (Stimulus)
    initial begin
        // สร้างไฟล์สำหรับดู Waveform (GTKWave)
        $dumpfile("wave.vcd");
        $dumpvars(0, sim_half_adder);

        // แสดงผลทางหน้าจอ (Monitor changes)
        $monitor("Time: %0t | a = %b | b = %b | sum = %b | cout = %b", $time, t_a, t_b, t_sum, t_cout);

        // ป้อนค่าทดสอบ (Truth Table)
        t_a = 0; t_b = 0; #10; // รอ 10ns
        t_a = 0; t_b = 1; #10;
        t_a = 1; t_b = 0; #10;
        t_a = 1; t_b = 1; #10;

        t_a = 4'b1000; t_b = 4'b0111; #10; // รอ 10ns
        t_a = 4'b1000; t_b = 4'b1000; #10;
        // จบการทำงาน
        $finish;
    end 
endmodule