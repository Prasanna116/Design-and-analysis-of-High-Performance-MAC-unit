module Vedic_Mult16(
input [15:0] a,
input [15:0] b,
output [31:0] out);

wire [15:0] o0,o1,o2,o3;
wire [15:0]out1;
wire [23:0]out2;


Vedic_Mult8 g1(a[7:0],b[7:0],o0);
Vedic_Mult8 g2(a[7:0],b[15:8],o1);
Vedic_Mult8 g3(a[15:8],b[7:0],o2);
Vedic_Mult8 g4(a[15:8],b[15:8],o3);

assign out[7:0]= o0[7:0];

assign out1= {8'b0,o0[15:8]} + o1[15:0] ;
assign out2= {8'b0,o2[15:0]} + {o3[15:0],8'b0} ;

assign out[31:8]= {8'b0,out1} + out2;

endmodule 