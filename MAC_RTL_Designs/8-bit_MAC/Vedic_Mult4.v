module Vedic_Mult4(
input [3:0] a,
input [3:0]b,
output [7:0]out);

wire [3:0] q0,q1,q2,q3 ;
wire [3:0] t1;
wire [5:0] t2,t3;

Vedic_Mult2 g1(a[1:0],b[1:0],q0);
Vedic_Mult2 g2(a[3:2],b[1:0],q1);
Vedic_Mult2 g3(a[1:0],b[3:2],q2);
Vedic_Mult2 g4(a[3:2],b[3:2],q3);



assign t1= {2'b0,q0[3:2]} + q1[3:0] ;

assign t2=  {q3[3:0],2'b0} + {2'b00,q2[3:0]} ;

assign t3=  {2'b0,t1[3:0]} + t2[5:0] ;

assign out[1:0]=q0[1:0];
assign out[7:2]=t3[5:0];

endmodule