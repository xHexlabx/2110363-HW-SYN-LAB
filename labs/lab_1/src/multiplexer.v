module multiplexer (
    input  wire [3:0] in_0 ,
    input  wire [3:0] in_1 ,
    input  wire selector,
    output wire [3:0] data_out
);

    assign data_out = selector ? in_1 : in_0;

endmodule