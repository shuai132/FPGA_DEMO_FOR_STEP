module pwm(clk, rst_n, value, out);
    parameter BITS = 8;

    input clk;
    input rst_n;
    input [BITS-1:0] value;
    output out;

    reg [BITS-1:0] count;

    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
            count <= 0;
        else
            count <= count + 1;
    end

    assign out = count <= value;

endmodule