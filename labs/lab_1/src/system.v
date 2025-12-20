module system (
    input wire [7 : 0] sw ,
    input wire rst ,
    input wire clk ,
    output wire [3 : 0] an ,
    output wire [7 : 0] segments
);
    wire selector ;
    wire [3 : 0] data_out;

    controller controller_inst (
        .rst(rst),
        .clk(clk),
        .an(an),
        .selector(selector)
    );

    multiplexer multiplexer_inst (
        .in_0(sw[3:0]),
        .in_1(sw[7:4]),
        .selector(selector),
        .data_out(data_out)
    );

    seven_segment_decoder seven_segment_decoder_inst (
        .data_in(data_out),
        .segments(segments)
    );
    
endmodule