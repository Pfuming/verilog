`timescale 1ns / 1ps

module tb_mux4_1_casez();
    reg a, b, c, d;
    reg [3:0] sel;
    wire dout;

    // 实例化被测模块
    mux4_1_casez uut (
        .dout(dout),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel)
    );

    initial begin
        // 初始化输入
        a = 1'b0;
        b = 1'b1;
        c = 1'b0;
        d = 1'b1;
        sel = 4'b0000;

        // 测试 sel[0] 有效
        #10 sel = 4'b0001; // 应输出 a (0)
        #10 sel = 4'b0011; // 仍匹配 ???1 第一条，输出 a (0)

        // 测试 sel[1] 有效
        #10 sel = 4'b0010; // 匹配 ??1?，输出 b (1)
        #10 sel = 4'b0110; // 仍匹配 ??1?，输出 b (1)

        // 测试 sel[2] 有效
        #10 sel = 4'b0100; // 匹配 ?1??，输出 c (0)
        #10 sel = 4'b1100; // 仍匹配 ?1??，输出 c (0)

        // 测试 sel[3] 有效
        #10 sel = 4'b1000; // 匹配 1???，输出 d (1)
        #10 sel = 4'b1001; // 匹配 ???1 先，输出 a (0)，不是 d，注意优先级！

        // 改变输入值，检查输出是否随输入变化
        #10 a = 1'b1;
        #10 sel = 4'b0001; // 输出 a (1)
        #10 sel = 4'b0010; // 输出 b (1)

        #10 $finish;
    end

    initial begin
        $monitor("Time = %t, sel = %b, a=%b, b=%b, c=%b, d=%b, dout=%b", 
                 $time, sel, a, b, c, d, dout);
    end
endmodule
