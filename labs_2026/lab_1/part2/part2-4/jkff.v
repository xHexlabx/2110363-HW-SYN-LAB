module jkff (
    input  wire J,
    input  wire K,
    input  wire clk,
    output reg Q
);

    initial begin
        Q = 1'b0;
    end

    // TODO: Implement the JK flip-flop behavior
    always @(posedge clk) begin
        if (J && K) begin
            Q <= ~Q;
        end else if (J) begin
            Q <= 1'b1;
        end else if (K) begin
            Q <= 1'b0;
        end else begin
            Q <= Q;
        end
    end

endmodule
