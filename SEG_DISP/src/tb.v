`timescale 1ns / 100ps
module tb;
    parameter CLK_PERIOD = 40;
    reg sys_clk;
    initial
        sys_clk = 1'b0;
    always
        sys_clk = #(CLK_PERIOD/2) ~sys_clk;

    reg sys_rst_n;
    initial
    begin
        sys_rst_n = 1'b0;
        #200;
        sys_rst_n = 1'b1;
    end

    wire led;
    wire [8:0] seg_led_1;
    wire [8:0] seg_led_2;
    top u1(
        .clk(sys_clk),
        .rst(sys_rst_n),
        .led(led),
        .seg_led_1(seg_led_1),
        .seg_led_2(seg_led_2)
    );
endmodule