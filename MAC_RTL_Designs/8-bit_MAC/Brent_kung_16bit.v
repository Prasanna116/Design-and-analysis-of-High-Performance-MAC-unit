module Brent_kung_16bit(
input [15:0] a,
input [15:0]b,
input cin,
output [15:0]s,
output cout);

wire [15:0]p0,g0;
wire [15:0]p1,g1;
wire [15:0]p2,g2;
wire [15:0]p3,g3;
wire [15:0]p4,g4;
wire [15:0]p5,g5;
wire [15:0]p6,g6;

wire [15:0]c;

//STAGE 0
assign p0= a ^ b;
assign g0= a & b;

//STAGE 1 
genvar i;
generate
for(i=1;i<16;i=i+2)begin:row1
 assign p1[i]= p0[i] & p0[i-1];
 assign g1[i]= g0[i] | ( g0[i-1] & p0[i]);
end
endgenerate

//STAGE 2
generate
for(i=3;i<16;i=i+4)begin:row2
 assign p2[i]= p1[i] & p1[i-2];
 assign g2[i]= g1[i] | ( g1[i-2] & p1[i]);
end
endgenerate

//STAGE 3
generate
for(i=7;i<16;i=i+8)begin:row3
 assign p3[i]= p2[i] & p2[i-4];
 assign g3[i]= g2[i] | ( g2[i-4] & p2[i]);
end
endgenerate

//STAGE 4
assign p4[15]= p3[15] & p3[7];
assign g4[15]= g3[15] | ( g3[7] & p3[15]);

assign p4[11]= p2[11] & p3[7];
assign g4[11]= g2[11] | ( g3[7] & p2[11]);

//STAGE 5
assign p5[13]= p1[13] & p4[11];
assign g5[13]= g1[13] | ( g4[11] & p1[13]);

assign p5[9]= p1[9] & p3[7];
assign g5[9]= g1[9] | (g3[7] & p1[9]);

assign p5[5]= p1[5] & p2[3];
assign g5[5]= g1[5] | (g2[3] & p1[5]);

//STAGE 6
assign p6[14]= p0[14] & p5[13];
assign g6[14]= g0[14] | (g5[13] & p0[14]);

assign p6[12]= p0[12] & p4[11];
assign g6[12]= g0[12] | (g4[11] & p0[12]);

assign p6[10]= p0[10] & p5[9] ;
assign g6[10]= g0[10] | (g5[9] & p0[10]);

assign p6[8]= p0[8] & p3[7];
assign g6[8]= g0[8] | (g3[7] & p0[8]);

assign p6[6]= p0[6] & p5[5];
assign g6[6]= g0[6] | (g5[5] & p0[6]); 

assign p6[4]= p0[4] & p2[3];
assign g6[4]= g0[4] | (g2[3] & p0[4]);

assign p6[2]= p0[2] & p1[1];
assign g6[2]= g0[2] | (g1[1] & p0[2]);

assign c[0]=cin;
assign c[1]=g0[0];
assign c[2]=g1[1];
assign c[3]=g6[2];
assign c[4]=g2[3];
assign c[5]=g6[4];
assign c[6]=g5[5];
assign c[7]=g6[6];
assign c[8]=g3[7];
assign c[9]=g6[8];
assign c[10]=g5[9];
assign c[11]=g6[10];
assign c[12]=g4[11];
assign c[13]=g6[12];
assign c[14]=g5[13];
assign c[15]=g6[14];
assign cout=g4[15];

assign s= (p0^c[15:0]);

endmodule

