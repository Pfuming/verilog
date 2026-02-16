module traffic_light_control(clk, reset, red1, yellow1, green1, red2, yellow2, green2);
input clk;
input reset;
output red1, yellow1, green1;
reg red1, yellow1, green1;
output red2, yellow2, green2;
reg red2, yellow2, green2;
reg [11:0] count;
parameter Y1Y2=0, R1Y2=1, G1R2=2, Y1R2=3, R1G2=4;
parameter timeR1Y2=250, timeG1R2=2500, timeY1R2=250, timeR1G2=2250;
reg [2:0] state;
always @(posedge clk)
    if(reset) begin
    count<=0;
    state<=Y1Y2;
    red1<=0;yellow1<=1;green1<=0; red2<=0;yellow2<=1;green2<=0;
    end
else
    case(state)
    Y1Y2: begin
    state<=R1Y2;
    count<=1;
    end
    R1Y2: begin
    if(count==timeR1Y2) begin
       state<=G1R2;
       red1<=0;yellow1<=0;green1<=1; red2<=1;yellow2<=0;green2<=0;
       count<=1;
    end
    else begin
       state<=R1Y2;
       red1<=1;yellow1<=0;green1<=0; red2<=0;yellow2<=1;green2<=0;
       count<=count+1;
    end
    end
    G1R2: begin
    if(count==timeG1R2) begin
       state<=Y1R2;
       red1<=0;yellow1<=1;green1<=0; red2<=1;yellow2<=0;green2<=0;
       count<=1;
    end
    else begin
       state<=G1R2;
       red1<=0;yellow1<=0;green1<=1; red2<=1;yellow2<=0;green2<=0;
       count<=count+1;
    end
    end
    Y1R2: begin
    if(count==timeY1R2) begin
       state<=R1G2;
       red1<=1;yellow1<=0;green1<=0; red2<=0;yellow2<=0;green2<=1;
       count<=1;
    end
    else begin
       state<=Y1R2;
       red1<=0;yellow1<=1;green1<=0; red2<=0;yellow2<=0;green2<=0;
       count<=count+1;
    end
    end
    R1G2: begin
       if(count==timeR1G2) begin
	  state<=R1Y2;
	  red1<=1;
	  yellow1<=0;
	  green1<=0;
	  red2<=0;
	  yellow2<=1;
	  green2<=1;
	  count<=1;
       end
       else begin
	  state<=R1G2;
	  red1<=1;yellow1<=0;green1<=0; red2<=0;yellow2<=0;green2<=1;
	  count<=count+1;
       end // else: !if(count==timeR1G2)
       end
    default: state<=Y1Y2;
    endcase
endmodule
