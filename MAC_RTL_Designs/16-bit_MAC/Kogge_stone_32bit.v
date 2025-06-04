module Kogge_stone_32bit(
input [31:0] a,
input [31:0] b,
input cin,
output [31:0] s,
output cout);

wire [31:0] c;
wire [31:0] p0, g0 ;
wire [31:0] p1, g1 ;
wire [31:0] p2, g2 ;
wire [31:0] p3, g3 ;
wire [31:0] p4, g4 ;
wire [31:0] p5, g5 ; 

assign p0= a ^ b;
assign g0= a & b;


//STAGE 1

assign p1[0]=p0[0];
assign g1[0]=g0[0];
genvar i;
generate
for(i=1;i<32;i=i+1) begin: row1

assign p1[i] = p0[i] & p0[i-1];
assign g1[i] = g0[i] | (p0[i] & g0[i-1] );

end
endgenerate

//STAGE 2

assign p2[1:0]=p1[1:0];
assign g2[1:0]=g1[1:0];

genvar j;
generate
for(j=2;j<32;j=j+1) begin: row2

assign p2[j] = p1[j] & p1[j-2];
assign g2[j] = g1[j] | (p1[j] & g1[j-2] );

end
endgenerate

//STAGE 3

assign p3[3:0]=p2[3:0];
assign g3[3:0]=g2[3:0];

genvar k;
generate
for(k=4;k<32;k=k+1) begin: row3

assign p3[k] = p2[k] & p2[k-4];
assign g3[k] = g2[k] | (p2[k] & g2[k-4] );

end
endgenerate

//STAGE 4

assign p4[7:0]=p3[7:0];
assign g4[7:0]=g3[7:0];

genvar l;
generate
for(l=8;l<32;l=l+1) begin: row4

assign p4[l] = p3[l] & p3[l-8];
assign g4[l] = g3[l] | (p3[l] & g3[l-8] );

end
endgenerate

//STAGE 5

assign p5[15:0]= p4[15:0];
assign g5[15:0]= g4[15:0];

genvar m;
generate
for(m=16;m<32;m=m+1) begin: row5

assign p5[m] = p4[m] & p4[m-16];
assign g5[m] = g4[m] | (p4[m] & g4[m-16] );

end
endgenerate

// SUM & CARRY

assign c[0]=cin;
assign c[31:1]=g5[30:0];
assign cout=g5[31];

assign s= (p0 ^ c) ;

endmodule



