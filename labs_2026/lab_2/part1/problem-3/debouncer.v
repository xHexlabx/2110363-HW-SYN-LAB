module debouncer #(
    SAMPLING_RATE = 3,
    COUNTER_WIDTH = 2
) (
    input  wire clk,
    input  wire rst,
    input  wire data_in,
    output reg data_out
);
    // TODO: Implement debouncing module using sampling technique

    reg [COUNTER_WIDTH-1:0] counter ;
    
    always @(posedge clk) begin
        if(rst) begin
            counter <= 0 ;
            data_out <= 0 ;
        end else begin
            if(counter == SAMPLING_RATE - 1) begin
                if(data_in == 1)begin
                    data_out <= 1 ;
                end else begin
                    data_out <= 0 ;
                end
                counter <= 0 ;
            end else begin
                counter <= counter + 1 ;
            end
        end
    end
endmodule
