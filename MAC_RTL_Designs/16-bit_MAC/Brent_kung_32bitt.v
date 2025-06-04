module Brent_kung_32bitt(
input [31:0]a,
input [31:0]b,
input cin,
output [31:0]s,
output cout);

wire [31:0] c;
wire [31:0] p0, g0 ;
wire [31:0] p1, g1 ;
wire [31:0] p2, g2 ;
wire [31:0] p3, g3 ;
wire [31:0] p4, g4 ;
wire [31:0] p5, g5 ; 
wire [31:0] p6, g6 ;
wire [31:0] p7, g7 ;
wire [31:0] p8, g8 ;

//STAGE 0
assign p0= a ^ b;
assign g0= a & b;

//STAGE 1
genvar i;
generate
for(i=1;i<32;i=i+2) begin : row1
 assign p1[i] = p0[i] & p0[i-1];
 assign g1[i] = g0[i] | (g0[i-1] & p0[i]);
end
endgenerate

//STAGE 2
generate
for(i=3;i<32;i=i+4) begin : row2
 assign p2[i]= p1[i] & p1[i-2];
 assign g2[i]= g1[i] | ( g1[i-2] & p1[i]);
end
endgenerate

//STAGE 3
generate
for(i=7;i<32;i=i+8) begin : row3
 assign p3[i]= p2[i] & p2[i-4];
 assign g3[i]= g2[i] | ( g2[i-4] & p2[i]);
end
endgenerate

//STAGE 4
assign p4[15]= p3[15] & p3[7];
assign g4[15]= g3[15] | ( g3[7] & p3[15]);

//assign p4[11]= p2[11] & p3[7];
//assign g4[11]= g2[11] | ( g3[7] & p2[11]);

assign p4[31]= p3[31] & p3[23];
assign g4[31]= g3[31] | ( g3[23] & p3[31]);

//assign p4[27]= p2[27] & p3[23];
//assign g4[27]= g2[27] | ( g3[23] & p2[27]);

//STAGE 5
assign p5[31]= p4[31] & p4[15];
assign g5[31]= g4[31] | ( g4[15] & p4[31]);

assign p5[23]= p3[23] & p4[15];
assign g5[23]= g3[23] | ( g4[15] & p3[23]);

//STAGE 6

assign p6[27]= p2[27] & p5[23];
assign g6[27]= g2[27] | ( g5[23] & p2[27]);

assign p6[19]= p2[19] & p4[15];
assign g6[19]= g2[19] | ( g4[15] & p2[19]);

assign p6[11]= p2[11] & p3[7];
assign g6[11]= g2[11] | ( g3[7] & p2[11]);

//STAGE 7

assign p7[13]= p1[13] & p6[11];
assign g7[13]= g1[13] | ( g6[11] & p1[13]);

assign p7[9]= p1[9] & p3[7];
assign g7[9]= g1[9] | (g3[7] & p1[9]);

assign p7[5]= p1[5] & p2[3];
assign g7[5]= g1[5] | (g2[3] & p1[5]);

assign p7[29]= p1[29] & p6[27];
assign g7[29]= g1[29] | ( g6[27] & p1[29]);

assign p7[25]= p1[25] & p5[23];
assign g7[25]= g1[25] | (g5[23] & p1[25]);

assign p7[21]= p1[21] & p6[19];
assign g7[21]= g1[21] | (g6[19] & p1[21]);

assign p7[17]= p1[17] & p4[15];
assign g7[17]= g1[17] | (g4[15] & p1[17]);

//STAGE 8

assign p8[14]= p0[14] & p7[13];
assign g8[14]= g0[14] | (g7[13] & p0[14]);

assign p8[12]= p0[12] & p6[11];
assign g8[12]= g0[12] | (g6[11] & p0[12]);

assign p8[10]= p0[10] & p7[9] ;
assign g8[10]= g0[10] | (g7[9] & p0[10]);

assign p8[8]= p0[8] & p3[7];
assign g8[8]= g0[8] | (g3[7] & p0[8]);

assign p8[6]= p0[6] & p7[5];
assign g8[6]= g0[6] | (g7[5] & p0[6]); 

assign p8[4]= p0[4] & p2[3];
assign g8[4]= g0[4] | (g2[3] & p0[4]);

assign p8[2]= p0[2] & p1[1];
assign g8[2]= g0[2] | (g1[1] & p0[2]);

assign p8[30]= p0[30] & p7[29];
assign g8[30]= g0[30] | (g7[29] & p0[30]);

assign p8[28]= p0[28] & p6[27];
assign g8[28]= g0[28] | (g6[27] & p0[28]);

assign p8[26]= p0[26] & p7[25] ;
assign g8[26]= g0[26] | (g7[25] & p0[26]);

assign p8[24]= p0[24] & p5[23];
assign g8[24]= g0[24] | (g5[23] & p0[24]);

assign p8[22]= p0[22] & p7[21];
assign g8[22]= g0[22] | (g7[21] & p0[22]); 

assign p8[20]= p0[20] & p6[19];
assign g8[20]= g0[20] | (g6[19] & p0[20]);

assign p8[18]= p0[18] & p7[17];
assign g8[18]= g0[18] | (g7[17] & p0[18]);

assign p8[16]= p0[16] & p4[15];
assign g8[16]= g0[16] | (g4[15] & p0[16]);

//STAGE CARRY AND SUM GENERATION

assign c[0]=cin;
assign c[1]=g0[0];
assign c[2]=g1[1];
assign c[3]=g8[2];
assign c[4]=g2[3];
assign c[5]=g8[4];
assign c[6]=g7[5];
assign c[7]=g8[6];
assign c[8]=g3[7];
assign c[9]=g8[8];
assign c[10]=g7[9];
assign c[11]=g8[10];
assign c[12]=g6[11];
assign c[13]=g8[12];
assign c[14]=g7[13];
assign c[15]=g8[14];
assign c[16]=g4[15];
assign c[17]=g8[16];
assign c[18]=g7[17];
assign c[19]=g8[18];
assign c[20]=g6[19];
assign c[21]=g8[20];
assign c[22]=g7[21];
assign c[23]=g8[22];
assign c[24]=g5[23];
assign c[25]=g8[24];
assign c[26]=g7[25];
assign c[27]=g8[26];
assign c[28]=g6[27];
assign c[29]=g8[28];
assign c[30]=g7[29];
assign c[31]=g8[30];

assign cout=g4[31];

assign s= (p0 ^ c[31:0]);

endmodule 
