module seven_segment_decoder (
    input  wire [3:0] data_in,
    output reg  [7:0] segments
);
    always @(*) begin
        case (data_in)
            4'b0000: segments = 8'b11000000; // 0
            4'b0001: segments = 8'b11111001; // 1
            4'b0010: segments = 8'b10100100; // 2
            4'b0011: segments = 8'b10110000; // 3
            4'b0100: segments = 8'b10011001; // 4
            4'b0101: segments = 8'b10010010; // 5
            4'b0110: segments = 8'b10000010; // 6
            4'b0111: segments = 8'b11111000; // 7
            4'b1000: segments = 8'b10000000; // 8
            4'b1001: segments = 8'b10010000; // 9
            4'b1010: segments = 8'b10001000; // A
            4'b1011: segments = 8'b10000011; // b
            4'b1100: segments = 8'b11000110; // C
            4'b1101: segments = 8'b10100001; // d
            4'b1110: segments = 8'b10000110; // E
            4'b1111: segments = 8'b10001110; // F
            default: segments = 8'b11111111; // Blank
        endcase
    end
    `ifdef COCOTB_SIM
        initial begin
            $dumpfile("wave.vcd");  // Name of the dump file
            $dumpvars(0, seven_segment_decoder);  // Dump all variables for the top module
        end
    `endif
endmodule