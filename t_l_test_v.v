`timescale 1ms/1us
module t_l_test_v;
reg clk;
reg reset;
wire red1, yellow1, green1, red2, yellow2, green2;
always begin #10 clk=1; #10 clk=0; end
initial begin
    clk=0;
    reset=1;
    #10000;
    reset=0;
end
traffic_light_control ul(.clk(clk), .reset(reset), .red1(red1), .yellow1(yellow1),
    .green1(green1), .red2(red2), .yellow2(yellow2), .green2(green2));
endmodule
