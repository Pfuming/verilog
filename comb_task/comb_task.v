module comb_task(dina, dinb, cin, sum, cout);
input [2:0] dina, dinb;
input cin;
output [2:0] sum;
reg [2:0] sum;
output cout;
reg [3:0] c_temp;
integer J;
task one_bit_full_adder;
    input A, B, CarryIn;
    output Sum, CarryOut;
begin
    Sum=A ^ B ^ CarryIn;
    CarryOut = (A & B) | (A & CarryIn) | (B & CarryIn);
end
endtask
always @(dina or dinb or cin)
begin
    c_temp[0]=cin;
    for(J=0; J<3; J =J+1)
    one_bit_full_adder(dina[J], dinb[J], c_temp[J], sum[J], c_temp[J+1]);
end
assign cout=c_temp[3];
endmodule
