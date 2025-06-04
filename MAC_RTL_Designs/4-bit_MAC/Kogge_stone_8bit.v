module Kogge_stone_8bit(
input [7:0]a,
input [7:0]b,
input cin,
output [7:0]s,
output cout);

wire [7:0]c;
wire [7:0]p0;
wire [7:0]g0;

wire [7:1]p1;
wire [7:1]g1;

wire [7:2]p2;
wire [7:2]g2;

wire [7:4]p3;
wire [7:4]g3;
//STAGE1 Preprocessing stage
assign p0=a^b;
assign g0=a&b;

//STAGE2 Parallel  prefix

//ROW1
assign p1[1]= p0[1] & p0[0];
assign g1[1]= g0[1] | ( g0[0] & p0[1]);

assign p1[2]= p0[2] & p0[1];
assign g1[2]= g0[2] | ( g0[1] & p0[2]);

assign p1[3]= p0[3] & p0[2];
assign g1[3]= g0[3] | ( g0[2] & p0[3]);

assign p1[4]= p0[4] & p0[3];
assign g1[4]= g0[4] | ( g0[3] & p0[4]);

assign p1[5]= p0[5] & p0[4];
assign g1[5]= g0[5] | ( g0[4] & p0[5]);

assign p1[6]= p0[6] & p0[5];
assign g1[6]= g0[6] | ( g0[5] & p0[6]);

assign p1[7]= p0[7] & p0[6];
assign g1[7]= g0[7] | ( g0[6] & p0[7]);

// Paralle Prefix STAGE 2
assign p2[2]=p1[2] & p0[0];
assign g2[2]= g1[2] | (g0[0] & p1[2]);

assign p2[3]=p1[3] & p1[1];
assign g2[3]= g1[3] | (g1[1] & p1[3]);

assign p2[4]=p1[4] & p1[2];
assign g2[4]= g1[4] | (g1[2] & p1[4]);

assign p2[5]=p1[5] & p1[3];
assign g2[5]= g1[5] | (g1[3] & p1[5]);

assign p2[6]=p1[6] & p1[4];
assign g2[6]= g1[6] | (g1[4] & p1[6]);

assign p2[7]=p1[7] & p1[5];
assign g2[7]= g1[7] | (g1[5] & p1[7]);

//Parallel Prefix STAGE 3

assign p3[4]=p2[4] & p0[0];
assign g3[4]= g2[4] | (g0[0] & p2[4]);

assign p3[5]=p2[5] & p1[1];
assign g3[5]= g2[5] | (g1[1] & p2[5]);

assign p3[6]=p2[6] & p2[2];
assign g3[6]= g2[6] | (g2[2] & p2[6]);

assign p3[7]=p2[7] & p2[3];
assign g3[7]= g2[7] | (g2[3] & p2[7]);

//STAGE 3 Carry generate
//FOR Cin=0
//assign c[1]=g0[0];
//assign c[2]=g1[1];
//assign c[3]=g2[2];
//assign c[4]=g2[3];
//assign c[5]=g3[4];
//assign c[6]=g3[5];
//assign c[7]=g3[6];
//assign cout=g3[7];
//assign c[0]=cin;

//FOR  Cin=0 or 1;

assign c[1]=g0[0]| (p0[0] & cin);
assign c[2]=g1[1]| (p1[1] & cin);
assign c[3]=g2[2]| (p2[2] & cin);
assign c[4]=g2[3]| (p2[3] & cin);
assign c[5]=g3[4]| (p3[4] & cin);
assign c[6]=g3[5]| (p3[5] & cin);
assign c[7]=g3[6]| (p3[6] & cin);
assign cout=g3[7]| (p3[7] & cin);
assign c[0]=cin;

assign s= p0 ^ c;


endmodule
