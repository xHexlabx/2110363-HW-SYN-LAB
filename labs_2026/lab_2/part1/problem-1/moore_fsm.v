module moore_fsm (
    input  wire       clk,
    input  wire       rst,
    input  wire       in,
    output wire [2:0] out
);
    // TODO: Implement the Moore FSM logic here

    localparam IDLE = 3'b000 ;
    localparam [2:0] 
        S1 = 3'b001 ,
        S2 = 3'b010 ,
        S3 = 3'b011 ,
        S4 = 3'b100 ,
        S5 = 3'b101 ;

    reg [2:0] state, next_state;
    reg [2:0] output_reg;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset state
            state <= IDLE;
        end else begin
            // State transitions
            state <= next_state;
        end
    end

    always @(*) begin
        // Next state logic
        case (state)
            S1: next_state = in ? S2 : S4;
            S2: next_state = in ? S3 : S1;
            S3: next_state = in ? S5 : S2;
            S4: next_state = in ? S1 : S5;
            S5: next_state = S5 ;
            default: next_state = S1;
        endcase
    end

    always @(*) begin
        // Output logic based on current state
        case (state)
            S1: output_reg = 3'b011;
            S2: output_reg = 3'b100;
            S3: output_reg = 3'b101;
            S4: output_reg = 3'b010;
            S5: output_reg = 3'b001;
            default: output_reg = 3'b000;
        endcase
    end

    assign out = output_reg;

endmodule 
