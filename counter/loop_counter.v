module loop_counter(
	      clk,
	      resetn,
	      out1,
	       out0);
   input clk;
   input resetn;
   output reg [3:0] out0;
   output reg [3:0] out1;
   
   always @(posedge clk or negedge resetn)
     if(!resetn) begin
       out1<=4'b0000;
       out0<=4'b0000;
     end
     else begin
	if (out0==9)  begin
	   out0<=0;
	   if(out1==9)begin
	      out1<=0;
	   end
	   else begin
	      out1<=out1+1;
	   end
	end
	else begin
	   out0<=out0+1;
	end
     end // else: !if(!resetn)
   endmodule
