module Vedic_Mult8(
input [7:0] a,
input [7:0] b,
output [15:0] out);

wire [7:0] q0,q1,q2,q3;
wire [7:0] out1;
wire [11:0] out2;

Vedic_Mult4 g1(a[3:0],b[3:0],q0);
Vedic_Mult4 g2(a[3:0],b[7:4],q1);
Vedic_Mult4 g3(a[7:4],b[3:0],q2);
Vedic_Mult4 g4(a[7:4],b[7:4],q3);

assign out[3:0]=q0[3:0];

assign out1= {4'b0,q0[7:4]} + q1[7:0] ;
assign out2= {q3[7:0],4'b0} + {4'b0,q2[7:0]} ;

assign out[15:4]= {4'b0,out1[7:0]} + out2;

endmodule