module top(clk, rst, led);
    input clk;
    input rst;
    output led;

    parameter PWM_BITS  = 10;
    parameter PWM_RANGE = 999;

    wire clk1ms;
    reg [PWM_BITS-1:0] pwmValue;

    reg flag;
    parameter UP   = 0;
    parameter DOWN = 1;

    divide #(.WIDTH(14),.N(12_000)) u1(
            .clk(clk),
            .rst_n(rst),
            .clkout(clk1ms)
            );

    pwm #(.BITS(PWM_BITS)) u2(
        .clk(clk),
        .rst_n(rst),
        .value(pwmValue),
        .out(led)
        );

    always@(posedge clk1ms or negedge rst)
    begin
        if(!rst) begin
            pwmValue <= 0;
            flag <= UP;
        end
        else if(pwmValue == PWM_RANGE) begin
            flag <= DOWN;
            pwmValue = pwmValue - 1;
        end
        else if(pwmValue == 0) begin
            flag <= UP;
            pwmValue = pwmValue + 1;
        end
        else
            if(flag == UP)
                pwmValue <= pwmValue + 1;
            else
                pwmValue <= pwmValue - 1;
    end

endmodule