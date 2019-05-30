module top(clk, rst, led);
    input clk;
    input rst;
    output led;

    parameter PWM_BITS = 9;
    parameter [PWM_BITS-1:0] PWM_MAXV = 2 ** PWM_BITS - 1;

    wire clk1ms;
    reg [PWM_BITS-1:0] pwmValue;

    reg flag_c, flag_n;
    wire pwmOut;

    divide #(.WIDTH(14),.N(12_000)) u1(
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

    assign led = flag_c ? pwmOut : !pwmOut;

endmodule