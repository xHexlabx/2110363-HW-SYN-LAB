module dff_sync_reset (
    input  wire clk,
    input  wire rst,
    input  wire D,
    output reg Q
);
    // TODO: Implement the D flip-flop with synchronous reset behavior here
    always @(posedge clk) begin
        if (rst) begin
            Q <= 1'b0;
        end else begin
            Q <= D;
        end
    end

endmodule
