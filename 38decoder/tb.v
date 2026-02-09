`timescale 1ns/1ps
module tb_decode3_8;
   reg [2:0] din;
   wire [7:0] dout;
   initial begin
      $dumpfile("wave.vcd");
      $dumpvars(0,tb_decode3_8);
      //Initialize Iinputs
      din=0;
      #100 din=1;
      #100 din=2;
      #100 din=3;
      #100 din=4;
      #100 din=5;
      #100 din=6;
      #100 din=7;
      end
decode3_8 u1(
     .din(din),
     .dout(dout));
endmodule	     
      
