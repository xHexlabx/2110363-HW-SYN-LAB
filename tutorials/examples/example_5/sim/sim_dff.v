`timescale 1ns/1ns

module sim_dff;

    // 1. ประกาศตัวแปร
    // input ของ Module ใช้ reg (เพราะเราต้องกำหนดค่าให้มัน)
    reg t_d;
    reg t_clk;
    
    // output ของ Module ใช้ wire (เพราะรับค่าจากการต่อสาย)
    wire t_q;

    // 2. เรียกใช้ (Instantiate) Module ที่เราจะเทส (Unit Under Test - UUT)
    dff uut (
        .clk(t_clk),
        .d(t_d),
        .q(t_q)
    );

    // 3. เริ่มการทดสอบ (Stimulus)
    initial begin
        // สร้างไฟล์สำหรับดู Waveform (GTKWave)
        $dumpfile("wave.vcd");
        $dumpvars(0, sim_dff);

        // แสดงผลทางหน้าจอ (Monitor changes)
        $monitor("Time: %0t | clk = %b | d = %b | q = %b" , $time, t_clk, t_d, t_q);

        t_clk = 0; t_d = 0; #10;
        t_clk = 1; t_d = 0; #10;
        t_clk = 0; t_d = 0; #10;
        t_clk = 1; t_d = 1; #10;
        t_clk = 0; t_d = 1; #10;

        // จบการทำงาน
        $finish;
    end
endmodule