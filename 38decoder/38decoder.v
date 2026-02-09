`timescale 1ns/1ns
module decode3_8(din, dout);
    input [2:0] din;
    output [7:0] dout;
    reg [7:0] dout;
    
    always @(din[2:0])
        case (din)
            3'b000: dout = 8'b00000001;
            3'b001: dout = 8'b00000010;
            3'b010: dout = 8'b00000100;
            3'b011: dout = 8'b00001000;
            3'b100: dout = 8'b00010000;
            3'b101: dout = 8'b00100000;
            3'b110: dout = 8'b01000000;
            3'b111: dout = 8'b10000000;
        endcase
endmodule
