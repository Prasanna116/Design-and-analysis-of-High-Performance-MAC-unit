module Brent_kung_32bit(
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

assign p4[11]= p2[11] & p3[7];
assign g4[11]= g2[11] | ( g3[7] & p2[11]);

assign p4[31]= p3[31] & p3[23];
assign g4[31]= g3[31] | ( g3[23] & p3[31]);

assign p4[27]= p2[27] & p3[23];
assign g4[27]= g2[27] | ( g3[23] & p2[27]);

//STAGE 5
assign p5[13]= p1[13] & p4[11];
assign g5[13]= g1[13] | ( g4[11] & p1[13]);

assign p5[9]= p1[9] & p3[7];
assign g5[9]= g1[9] | (g3[7] & p1[9]);

assign p5[5]= p1[5] & p2[3];
assign g5[5]= g1[5] | (g2[3] & p1[5]);

assign p5[29]= p1[29] & p4[27];
assign g5[29]= g1[29] | ( g4[27] & p1[29]);

assign p5[25]= p1[25] & p3[23];
assign g5[25]= g1[25] | (g3[23] & p1[25]);

assign p5[21]= p1[21] & p2[19];
assign g5[21]= g1[21] | (g2[19] & p1[21]);

//STAGE 6
//assign p6[16]= p0[16] & p4[15];
//assign g6[16]= g0[16] | (g4[15] & p0[16]);

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

assign p6[30]= p0[30] & p5[29];
assign g6[30]= g0[30] | (g5[29] & p0[30]);

assign p6[28]= p0[28] & p4[27];
assign g6[28]= g0[28] | (g4[27] & p0[28]);

assign p6[26]= p0[26] & p5[25] ;
assign g6[26]= g0[26] | (g5[25] & p0[26]);

assign p6[24]= p0[24] & p3[23];
assign g6[24]= g0[24] | (g3[23] & p0[24]);

assign p6[22]= p0[22] & p5[21];
assign g6[22]= g0[22] | (g5[21] & p0[22]); 

assign p6[20]= p0[20] & p2[19];
assign g6[20]= g0[20] | (g2[19] & p0[20]);

assign p6[18]= p0[18] & p1[17];
assign g6[18]= g0[18] | (g1[17] & p0[18]);

//STAGE CARRY AND SUM GENERATION

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
assign c[16]=g4[15];
assign c[17]=g0[16];
assign c[18]=g1[17];
assign c[19]=g6[18];
assign c[20]=g2[19];
assign c[21]=g6[20];
assign c[22]=g5[21];
assign c[23]=g6[22];
assign c[24]=g3[23];
assign c[25]=g6[24];
assign c[26]=g5[25];
assign c[27]=g6[26];
assign c[28]=g4[27];
assign c[29]=g6[28];
assign c[30]=g5[29];
assign c[31]=g6[30];

assign cout=g4[31];

assign s= (p0 ^ c[31:0]);

endmodule 