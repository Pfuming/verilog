`timescale 1ns/100ps
module tb_arithmetic;
   reg [7:0] a;
   reg [7:0] b;
   reg [1:0] sel;
  wire [7:0] result;

   arithmetic u1(
		 .a(a)
		 ,.b(b)
		 ,.sel(sel)
		 ,.result(result));
   initial begin
      $dumpfile("wave.vcd");
      $dumpvars(0, tb_arithmetic);
      a=1;
      b=1;
      sel=0;
      #20
	a=5;
      b=2;
      sel=1;
      #20
	a=2;
      b=3;
      sel = 2;
      #20
	a=8;
      b=2;
      sel=3;
      #20
	$finish;
   end
     
  endmodule
     
      
