`timescale 1ns / 1ns

module fsm_tb ();
    // Create wires and regs to connect to the DUT
    reg        clk;
    reg        reset;
    reg        data_in;
    wire [1:0] data_out;

    // TODO: instantiate the DUT and write the testbench logic











    // -- Do not delete the lines below --
    // Dump waveforms
    initial begin
        $dumpfile("fsm_tb.vcd");
        $dumpvars(0, fsm_tb);
    end

endmodule
