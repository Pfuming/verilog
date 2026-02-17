`timescale 1us/1us
module tb_8_rainbow_light;
   reg clk;
   reg rst;
   reg control;
   wire [7:0] dout;
   always begin 
      #500 clk=0;
      #500 clk=1;
   end
   eight_rainbow_light uut(
		       .clk(clk)
		       ,.rst(rst)
		       ,.control(control)
		       ,.dout(dout));
   initial begin
      $dumpfile("wave.vcd");
      $dumpvars(0, tb_8_rainbow_light);
      rst=1;
      control=0;     
      #1000
	rst=0;
      #1000
	control=1;
      #16000
	control=0;
      #10000
	$finish;
   end // initial begin
   endmodule
	
      
