module top(clk, rst, led);
    input clk;
    input rst;
    output led;

    parameter PWM_BITS = 9;
    parameter PWM_MAXV = 2 ** PWM_BITS - 1;

    wire clk1ms;
    reg [PWM_BITS-1:0] pwmValue;

    reg flag;
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
        begin
            pwmValue <= 0;
            flag <= 0;
        end
        else
        begin
            if(pwmValue == PWM_MAXV)
                flag <= ~flag;

            pwmValue <= pwmValue + 1;
        end
    end

    assign led = flag ? pwmOut : !pwmOut;

endmodule