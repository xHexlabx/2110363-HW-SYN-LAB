module rom (
    input  wire       clk,
    input  wire [3:0] in,
    output wire [7:0] out
);
    reg [15:0] mem [15:0];
    reg [7:0] out_reg ;

    // TODO: Fill template of ROM from language template and adjust parameters/ports as needed.
    initial begin
        $dumpfile("rom_waveform.vcd"); // Name of the VCD file
        $dumpvars(0, rom);            // Dump all variables in the 'rom' module

        $display("ROM initialized");
        $readmemh("./data.mem", mem);
    end

    always @(posedge clk) begin
        out_reg <= mem[in];
    end

    assign out = out_reg;

endmodule
