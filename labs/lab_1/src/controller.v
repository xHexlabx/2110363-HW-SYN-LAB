module controller (
    input wire rst ,
    input wire clk ,
    output reg [3 : 0] an ,
    output reg selector
);

    reg [17 : 0] counter ;

    initial begin
        counter = 18'd0;
        an = 4'b1111;
        selector = 1'b0;
    end

    always @(posedge clk) begin
        
        if (rst) begin
            an <= 4'b1111;
            selector <= 1'b0;
            counter <= 18'd0;
        end else begin
            if (counter[17] == 0) begin
                an <= 4'b1110; // Activate the first digit (active low)
                selector <= 1'b0;
            end
            else begin
                an <= 4'b1101; // Activate the second digit (active low)
                selector <= 1'b1;
            end
            counter <= counter + 1;
        end

    end

endmodule