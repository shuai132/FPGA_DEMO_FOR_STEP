module segdisp (num1, num2, seg_led_1, seg_led_2);
    input [3:0] num1;
    input [3:0] num2;
    output [8:0] seg_led_1;
    output [8:0] seg_led_2;

    reg [8:0] seg[9:0];

    initial
    begin
        seg[0] = 9'h3f;
        seg[1] = 9'h06;
        seg[2] = 9'h5b;
        seg[3] = 9'h4f;
        seg[4] = 9'h66;
        seg[5] = 9'h6d;
        seg[6] = 9'h7d;
        seg[7] = 9'h07;
        seg[8] = 9'h7f;
        seg[9] = 9'h6f;
    end

    assign seg_led_1 = seg[num1];
    assign seg_led_2 = seg[num2];

endmodule