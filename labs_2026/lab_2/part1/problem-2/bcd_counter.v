module bcd_counter (
    input  wire       clk,
    input  wire       rst,
    output reg [3:0] q,
    output reg       cout
);  
    // TODO: Implement BCD counter
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset the counter to 0
            q <= 4'b0000;
            cout <= 1'b0;
        end else begin
            if (q == 4'b1000) begin
                q <= q + 1; // Reset to 0 after reaching 9
                cout <= 1'b1; // Set carry out
            end else if (q == 4'b1001) begin
                q <= 4'b0000; // Reset to 0 after reaching 9
                cout <= 1'b0; // Set carry out
            end else begin
                q <= q + 1; // Increment the counter
            end
        end
    end
    
endmodule
