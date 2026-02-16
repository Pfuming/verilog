module traffic_light_control_improved(
    input clk,           // 1024 Hz 系统时钟
    input reset,
    input maintain,      // 检修按键
    output reg red1, yellow1, green1,
    output reg red2, yellow2, green2
);
reg [31:0] count;        // 更大的计数器用于分频
reg [9:0] sec_count;     // 秒计数器 (1024分频需要10位)
reg sec_pulse;           // 秒脉冲

// 状态定义
parameter Y1Y2=0, R1Y2=1, G1R2=2, Y1R2=3, R1G2=4;

// 时间参数 - 正常工作模式 (单位：秒)
parameter NORM_TIME_R1Y2 = 250;   // 250秒
parameter NORM_TIME_G1R2 = 2500;  // 2500秒
parameter NORM_TIME_Y1R2 = 250;   // 250秒
parameter NORM_TIME_R1G2 = 2250;  // 2250秒

// 时间参数 - 检修模式 (时间大大缩短，单位：秒)
parameter MAINT_TIME_R1Y2 = 2;     // 2秒
parameter MAINT_TIME_G1R2 = 5;     // 5秒
parameter MAINT_TIME_Y1R2 = 2;     // 2秒
parameter MAINT_TIME_R1G2 = 5;     // 5秒

reg [2:0] state;
wire [31:0] time_r1y2, time_g1r2, time_y1r2, time_r1g2;

// 根据检修模式选择时间参数
assign time_r1y2 = maintain ? MAINT_TIME_R1Y2 : NORM_TIME_R1Y2;
assign time_g1r2 = maintain ? MAINT_TIME_G1R2 : NORM_TIME_G1R2;
assign time_y1r2 = maintain ? MAINT_TIME_Y1R2 : NORM_TIME_Y1R2;
assign time_r1g2 = maintain ? MAINT_TIME_R1G2 : NORM_TIME_R1G2;

// 1024 Hz 分频产生秒脉冲
always @(posedge clk or posedge reset) begin
    if (reset) begin
        sec_count <= 0;
        sec_pulse <= 0;
    end else begin
        if (sec_count == 1023) begin  // 1024分频
            sec_count <= 0;
            sec_pulse <= 1;
        end else begin
            sec_count <= sec_count + 1;
            sec_pulse <= 0;
        end
    end
end

// 主状态机 - 只在秒脉冲时更新
always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 0;
        state <= Y1Y2;
        red1 <= 0; yellow1 <= 1; green1 <= 0; 
        red2 <= 0; yellow2 <= 1; green2 <= 0;
    end else if (sec_pulse) begin  // 每秒更新一次
        case (state)
            Y1Y2: begin
                state <= R1Y2;
                count <= 1;
                // 保持黄灯状态
            end
            
            R1Y2: begin
                if (count == time_r1y2) begin
                    state <= G1R2;
                    red1 <= 0; yellow1 <= 0; green1 <= 1;
                    red2 <= 1; yellow2 <= 0; green2 <= 0;
                    count <= 1;
                end else begin
                    state <= R1Y2;
                    red1 <= 1; yellow1 <= 0; green1 <= 0;
                    red2 <= 0; yellow2 <= 1; green2 <= 0;
                    count <= count + 1;
                end
            end
            
            G1R2: begin
                if (count == time_g1r2) begin
                    state <= Y1R2;
                    red1 <= 0; yellow1 <= 1; green1 <= 0;
                    red2 <= 1; yellow2 <= 0; green2 <= 0;
                    count <= 1;
                end else begin
                    state <= G1R2;
                    red1 <= 0; yellow1 <= 0; green1 <= 1;
                    red2 <= 1; yellow2 <= 0; green2 <= 0;
                    count <= count + 1;
                end
            end
            
            Y1R2: begin
                if (count == time_y1r2) begin
                    state <= R1G2;
                    red1 <= 1; yellow1 <= 0; green1 <= 0;
                    red2 <= 0; yellow2 <= 0; green2 <= 1;
                    count <= 1;
                end else begin
                    state <= Y1R2;
                    red1 <= 0; yellow1 <= 1; green1 <= 0;
                    red2 <= 1; yellow2 <= 0; green2 <= 0;
                    count <= count + 1;
                end
            end
            
            R1G2: begin
                if (count == time_r1g2) begin
                    state <= R1Y2;
                    red1 <= 1; yellow1 <= 0; green1 <= 0;
                    red2 <= 0; yellow2 <= 1; green2 <= 0;
                    count <= 1;
                end else begin
                    state <= R1G2;
                    red1 <= 1; yellow1 <= 0; green1 <= 0;
                    red2 <= 0; yellow2 <= 0; green2 <= 1;
                    count <= count + 1;
                end
            end
            
            default: state <= Y1Y2;
        endcase
    end
end

endmodule
