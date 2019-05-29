module top(clk, rst, led);
    input clk;
    input rst;
    output led;

    wire clk1s;

    divide #(.WIDTH(32),.N(12_000_000)) u1(
        .clk(clk),
        .rst_n(rst),
        .clkout(clk1s)
        );

    assign led = clk1s;

endmodule