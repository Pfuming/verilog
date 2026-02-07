module arithmetic(
		  a,
		  b,
		  sel,
		  result);
   input [7:0] a;
   input [7:0] b;
   input [1:0] sel;
   wire [7:0] result1;
   wire [7:0] result2;
   wire [7:0] result3;
   wire [7:0] result4;   
   output reg [7:0]  result;
   assign result1=a+b;
   assign result2=a-b;
   assign result3=a*b;
   assign result4=a/b;
   
   always @(*) begin
      case(sel)
	2'b00:result=result1;
	2'b01:result=result2;
	2'b10:result=result3;
	2'b11:result=result4;
	default:result=8'bxxxx_xxxx;
      endcase
   end
endmodule
