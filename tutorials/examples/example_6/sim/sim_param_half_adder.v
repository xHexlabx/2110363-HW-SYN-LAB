`timescale 1ns/1ns

module sim_param_half_adder;

    // Parameters
    parameter WIDTH = 4;

    // Inputs
    reg  [WIDTH-1:0] a;
    reg  [WIDTH-1:0] b;

    // Outputs
    wire [WIDTH-1:0] sum;
    wire             cout;

    // Instantiate the Unit Under Test (UUT)
    param_half_adder #(
        .WIDTH(WIDTH)
    ) uut (
        .a(a),
        .b(b),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        // Initialize Inputs
        $dumpfile("wave.vcd");
        $dumpvars(0, sim_param_half_adder);

        a = 0;
        b = 0;

        // Wait 100 ns for global reset to finish
        #100;

        // Add stimulus here
        a = 4'b1100; b = 4'b1010; #10;
        a = 4'b1111; b = 4'b0001; #10;
        a = 4'b0011; b = 4'b0101; #10;
        a = 4'b1001; b = 4'b0110; #10;

        // Finish simulation
        #100;
        $finish;
    end
endmodule