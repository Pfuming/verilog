module mux4_1_casez(
		    dout,
		    a,
		    b,
		    c,
		    d,
		    sel);
   output dout;
   input  a,b,c,d;
   input [3:0] sel;
   reg	       dout;
   always @(sel or a or b or c or d)
     begin
	casez(sel)
	  4'b???1: dout = a;
	  4'b??1?: dout = b;
	  4'b?1??: dout = c;
	  4'b1???: dout = d;
	endcase // casez (sel)
     end
endmodule
