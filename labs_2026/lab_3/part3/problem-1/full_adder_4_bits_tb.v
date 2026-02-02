`timescale 1ns / 1ns

module full_adder_4_bits_tb ();
    // Create wires and regs to connect to the DUT
    reg  [3:0] a;
    reg  [3:0] b;
    reg        cin;
    wire [3:0] sum;
    wire       cout;

    // TODO: instantiate the DUT and write the testbench logic











    // -- Do not delete the lines below --
    // Dump waveforms
    initial begin
        $dumpfile("full_adder_4_bits_tb.vcd");
        $dumpvars(0, full_adder_4_bits_tb);
    end

endmodule
