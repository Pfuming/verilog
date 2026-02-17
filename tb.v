`timescale 1ms/1us
module t_l_test_v;
reg clk;
reg reset;
wire red1, yellow1, green1, red2, yellow2, green2;

// 添加VCD dump - 这样才能看到波形
initial begin
    $dumpfile("traffic.vcd");      // 指定波形文件名
    $dumpvars(0, t_l_test_v);       // dump所有变量
end

// 时钟生成
always begin 
    #10 clk = 1; 
    #10 clk = 0; 
end

// 复位和仿真控制
initial begin
    clk = 0;
    reset = 1;
    #10000;           // 复位保持10ms
    reset = 0;
    
    // 设置仿真时间 - 运行200ms后结束
    #400000;          // 400ms (因为时钟周期是20ms)
    $display("Simulation finished at time %t", $time);
    $finish;          // 结束仿真
end

// 实例化设计
traffic_light_control ul(
    .clk(clk), 
    .reset(reset), 
    .red1(red1), 
    .yellow1(yellow1),
    .green1(green1), 
    .red2(red2), 
    .yellow2(yellow2), 
    .green2(green2)
);

// 监控状态变化（可选）
always @(ul.state) begin
    $display("Time %0t ms: State = %0d", $time, ul.state);
    $display("  Light1: R=%d Y=%d G=%d", red1, yellow1, green1);
    $display("  Light2: R=%d Y=%d G=%d", red2, yellow2, green2);
end

// 监控count值（可选）
always @(ul.count) begin
    if (ul.count % 100 == 0)  // 每100个时钟打印一次
        $display("Time %0t ms: Count = %0d", $time, ul.count);
end
endmodule
