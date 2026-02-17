`timescale 1ms/1ps  // 时间单位改为ms以便仿真

module traffic_light_test;
reg clk_1024;        // 1024 Hz 时钟
reg reset;
reg maintain;        // 检修按键
wire red1, yellow1, green1;
wire red2, yellow2, green2;

// 生成1024 Hz时钟 (周期 ≈ 0.9765625 ms ≈ 1ms)
always begin
    #0.48828125 clk_1024 = 1;  // 半个周期
    #0.48828125 clk_1024 = 0;  // 半个周期
end

// 波形输出
initial begin
    $dumpfile("traffic_improved.vcd");
    $dumpvars(0, traffic_light_test);
end

// 测试序列
initial begin
    // 初始化
    clk_1024 = 0;
    reset = 1;
    maintain = 0;
    
    // 复位
    #10 reset = 0;
    
    // 正常运行一段时间
    #50000 $display("Time %0t ms: Normal mode - State = %0d", $time, u1.state);
    
    // 切换到检修模式
    #10000 maintain = 1;
    $display("Time %0t ms: Switching to maintenance mode", $time);
    
    // 检修模式运行
    #20000 maintain = 0;
    $display("Time %0t ms: Switching back to normal mode", $time);
    
    // 继续运行
    #50000 $display("Time %0t ms: Simulation continuing", $time);
    
    // 结束仿真
    #100000 $finish;
end

// 实例化设计
traffic_light_control_improved u1(
    .clk(clk_1024),
    .reset(reset),
    .maintain(maintain),
    .red1(red1),
    .yellow1(yellow1),
    .green1(green1),
    .red2(red2),
    .yellow2(yellow2),
    .green2(green2)
);

// 监控状态变化
always @(u1.state) begin
    $display("Time %0t ms: State changed to %0d (Maintain=%b)", 
             $time, u1.state, maintain);
    $display("  Light1: R=%d Y=%d G=%d", red1, yellow1, green1);
    $display("  Light2: R=%d Y=%d G=%d", red2, yellow2, green2);
end

// 监控检修模式切换
always @(maintain) begin
    $display("Time %0t ms: MAINTAIN MODE = %b", $time, maintain);
end

// 每隔一段时间打印count值
always @(posedge u1.sec_pulse) begin
    if (u1.count % 10 == 0)  // 每10秒打印一次
        $display("Time %0t ms: Count = %0d, State = %0d", 
                 $time, u1.count, u1.state);
end

endmodule
