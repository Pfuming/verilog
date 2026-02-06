// 1. timescale指令必须在模块定义之前
`timescale 1ns/1ps

module tb_loop_counter;
    reg clk;
    reg resetn;
    wire [3:0] out1;
    wire [3:0] out0;
    
    // 实例化被测试模块
    loop_counter ul(
        .clk(clk),
        .resetn(resetn),
        .out1(out1),
        .out0(out0)
    );
    
    // 时钟生成
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    // 测试序列
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_loop_counter);
        
        resetn = 0;  // 初始复位
        
        #20 resetn = 1;  // 释放复位
        
        #2100 $finish;  // 仿真结束
    end
    
endmodule  // 确保模块有结束标记
