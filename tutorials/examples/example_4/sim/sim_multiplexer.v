`timescale 1ns/1ns

module sim_multiplexer;

    // 1. ประกาศตัวแปร
    // input ของ Module ใช้ reg (เพราะเราต้องกำหนดค่าให้มัน)
    reg [3 : 0] t_data_in ;
    reg [1 : 0] t_sel ;
    
    // output ของ Module ใช้ wire (เพราะรับค่าจากการต่อสาย)
    wire t_data_out ;

    // 2. เรียกใช้ (Instantiate) Module ที่เราจะเทส (Unit Under Test - UUT)
    multiplexer uut (
        .data_in(t_data_in),
        .sel(t_sel),
        .data_out(t_data_out)
    );

    // 3. เริ่มการทดสอบ (Stimulus)
    initial begin
        // สร้างไฟล์สำหรับดู Waveform (GTKWave)
        $dumpfile("wave.vcd");
        $dumpvars(0, sim_multiplexer);

        // แสดงผลทางหน้าจอ (Monitor changes)
        $monitor("Time: %0t | data_in = %b | sel = %b | data_out = %b", $time, t_data_in, t_sel , t_data_out);

        // ป้อนค่าทดสอบ
        t_data_in = 4'b1010; t_sel = 2'b00; #10;
        t_data_in = 4'b1010; t_sel = 2'b01; #10;
        t_data_in = 4'b1010; t_sel = 2'b10; #10;
        t_data_in = 4'b1010; t_sel = 2'b11; #10;

        // จบการทำงาน
        $finish;
    end
endmodule