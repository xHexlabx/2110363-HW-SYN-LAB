`timescale 1ns / 1ps

module sim_system;

    // Signals
    reg [7:0] sw;
    reg rst, clk;
    wire [3:0] an;
    wire [7:0] segments;

    // Instantiate System
    system uut (
        .sw(sw),
        .rst(rst),
        .clk(clk),
        .an(an),
        .segments(segments)
    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("wave_system.vcd");
        $dumpvars(0, sim_system);

        // Init
        clk = 0;
        rst = 1; // Reset active
        sw = 8'hC3; // 1100 0011 -> High=C (12), Low=3
        
        $display("Starting System Simulation...");
        #20;
        
        // Run
        rst = 0;
        $display("Reset Released. SW Input = %h", sw);
        
        // Check State 0 (Digit 3)
        #20;
        // uut.controller_inst.selector ควรเป็น 0
        // segments ควรเป็น pattern ของเลข 3 (0011) -> 10110000
        if (an === 4'b1110 && segments === 8'b10110000)
             $display("PASS: State 0 showing 3 (an=%b, seg=%b)", an, segments);
        else $error("FAIL: State 0 expected 3 (an=%b, seg=%b)", an, segments);

        // Force Counter
        $display("Forcing counter switch...");
        uut.controller_inst.counter = 18'd131070;
        
        #50;

        // Check State 1 (Digit C)
        // uut.controller_inst.selector ควรเป็น 1
        // segments ควรเป็น pattern ของเลข C (1100) -> 11000110
        if (an === 4'b1101 && segments === 8'b11000110)
             $display("PASS: State 1 showing C (an=%b, seg=%b)", an, segments);
        else $error("FAIL: State 1 expected C (an=%b, seg=%b)", an, segments);

        $finish;
    end

endmodule