module Vedic_Mult2(
input [1:0] a,
input [1:0]b,
output [3:0]out);

wire [3:0]p;
wire [1:0]c;

assign p[0]= a[0] & b[0];
assign p[1]= a[1] & b[0];
assign p[2]= a[0] & b[1];
assign p[3]= a[1] & b[1]; 


assign out[0]=p[0];

half_adder ga(p[1],p[2],out[1],c[0]);
half_adder gb(p[3],c[0],out[2],out[3]);

endmodule
