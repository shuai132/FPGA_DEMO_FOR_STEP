module top(
    clk, rst,
    led,
    seg_led_1, seg_led_2
    );
    input clk;
    input rst;
    output led;

    output [8:0] seg_led_1;
    output [8:0] seg_led_2;

    parameter PWM_BITS = 8;
    parameter [PWM_BITS-1:0] PWM_MAXV = 2 ** PWM_BITS - 1;

    wire clk1ms;
    reg [PWM_BITS-1:0] pwmValue;

    reg flag_c, flag_n;
    wire pwmOut;

    divide #(.WIDTH(32),.N(24_0000)) u1(
            .clk(clk),
            .rst_n(rst),
            .clkout(clk1ms)
            );

    pwm #(.BITS(PWM_BITS)) u2(
        .clk(clk),
        .rst_n(rst),
        .value(pwmValue),
        .out(pwmOut)
        );

    reg [3:0] v1, v2;
    segdisp u3(
        .num1(v1),
        .num2(v2),
        .seg_led_1(seg_led_1),
        .seg_led_2(seg_led_2)
        );

    always@(posedge clk1ms or negedge rst)
    begin
        if(!rst)
            pwmValue <= 1'b0;
        else
            pwmValue <= pwmValue + 1'b1;
    end

    always@(posedge clk1ms or negedge rst)
    begin
        if(!rst)
            flag_c <= 1'b0;
        else
            flag_c <= flag_n;
    end

    always@(*)
    begin
        if(pwmValue == PWM_MAXV)
            flag_n = !flag_c;
        else
            flag_n = flag_c;
    end

    reg [PWM_BITS-1:0] dispPwmValue;
    always@(*)
    begin
        dispPwmValue = flag_c ? 255 - pwmValue : pwmValue;
        v1 = dispPwmValue / 100;
        v2 = (dispPwmValue - v1 * 100) / 10;
    end

    assign led = flag_c ? pwmOut : !pwmOut;

endmodule