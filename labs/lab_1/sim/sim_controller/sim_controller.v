`timescale 1ns / 1ps

module sim_controller;

    // 1. ประกาศตัวแปรสัญญาณ
    reg rst;
    reg clk;
    wire [3:0] an;
    wire selector;

    // 2. เรียกใช้ Module (UUT - Unit Under Test)
    controller uut (
        .rst(rst),
        .clk(clk),
        .an(an),
        .selector(selector)
    );

    // 3. สร้างสัญญาณนาฬิกา (Clock Generation)
    // คาบ 10ns (100MHz) -> Toggle ทุกๆ 5ns
    always #5 clk = ~clk;

    // 4. เริ่มต้นการทดสอบ
    initial begin
        // สร้างไฟล์สำหรับดู Waveform
        $dumpfile("wave.vcd");
        $dumpvars(0, sim_controller);

        // กำหนดค่าเริ่มต้น
        clk = 0;
        rst = 1; // กดปุ่ม Reset (Active High) ค้างไว้ตอนเริ่ม
        
        $display("Simulation Start...");

        // --- Phase 1: Reset Test ---
        #20; // รอ 20ns
        rst = 0; // ปล่อยปุ่ม Reset ให้วงจรทำงาน
        $display("Time: %0t | Reset Released", $time);

        // รอสักนิดเพื่อให้มั่นใจว่า logic เข้าสถานะแรกแล้ว
        #20;
        // ตรวจสอบสถานะแรก (ควรเป็น an=1110, selector=0)
        if (an === 4'b1110 && selector === 1'b0)
            $display("PASS: State 1 Correct (an=%b, selector=%b)", an, selector);
        else
            $error("FAIL: State 1 Incorrect (an=%b, selector=%b)", an, selector);


        // --- Phase 2: Transition Test (Hack Time) ---
        // ปกติต้องรอ 2^17 cycles (นับแสนรอบ) กว่าจะเปลี่ยนสถานะ
        // เราจะ "โกง" ด้วยการยัดค่าลงไปในตัวแปร counter ของ uut โดยตรง
        $display("Time: %0t | Forcing counter to near overflow...", $time);
        
        // เข้าถึงตัวแปรภายใน module uut.counter
        // ตั้งค่าไปที่ 131070 (อีก 2 clock จะถึงจุดเปลี่ยน 131072)
        uut.counter = 18'd131070; 

        #50; // ปล่อยเวลาวิ่งไปอีกนิดให้ counter นับข้ามขอบ

        // ตรวจสอบสถานะที่สอง (ควรเป็น an=1101, selector=1)
        if (an === 4'b1101 && selector === 1'b1)
            $display("PASS: State 2 Correct (an=%b, selector=%b)", an, selector);
        else
            $error("FAIL: State 2 Incorrect (an=%b, selector=%b)", an, selector);

        // จบการทำงาน
        $display("Simulation Finished");
        $finish;
    end

endmodule