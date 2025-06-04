module Dadda_Mult8(
input [7:0]a,
input [7:0]b,
output [15:0]out);

wire pp[7:0][7:0];

wire [22:0]s;
wire [30:0]c;
wire [18:0]ss;
wire [32:0]cc;

wire [2:0]out1;
wire [7:0]out2;

wire [4:0]mbec;


genvar i;
genvar j;
generate
for(i=0;i<8;i=i+1)
begin
  for(j=0;j<8;j=j+1)
  begin
  assign pp[j][i]= a[j] & b[i];
  end
end
endgenerate

//PART0

//Conversion of 8 to 6:
half_adder g1(pp[6][0],pp[5][1],s[0],c[0]);
full_adder g2(pp[7][0],pp[6][1],pp[5][2],s[1],c[1]);
half_adder g3(pp[4][3],pp[3][4],s[2],c[2]);

//Coversion of 6 to 4:
half_adder g4(pp[4][0],pp[3][1],s[3],c[3]);
full_adder g5(pp[5][0],pp[4][1],pp[3][2],s[4],c[4]);
half_adder g6(pp[2][3],pp[1][4],s[5],c[5]);

full_adder g7(s[0],pp[4][2],pp[3][3],s[6],c[6]);
full_adder g8(pp[2][4],pp[1][5],pp[0][6],s[7],c[7]);
full_adder g9(c[0],s[1],s[2],s[8],c[8]);
full_adder g10(pp[2][5],pp[1][6],pp[0][7],s[9],c[9]);

//Conversion of 4 to 3:
half_adder g11(pp[3][0],pp[2][1],s[10],c[10]);
full_adder g12(s[3],pp[2][2],pp[1][3],s[11],c[11]);
full_adder g13(c[3],s[4],s[5],s[12],c[12]);
full_adder g14(c[4],s[7],s[6],s[13],c[13]);
full_adder g15(c[6],s[9],s[8],s[14],c[14]);
full_adder g16(c[8],c[2],c[1],s[15],c[15]);

//Conversion of 3 to 2:
half_adder g17(pp[2][0],pp[1][1],s[16],c[16]);
full_adder g18(s[10],pp[1][2],pp[0][3],s[17],c[17]);
full_adder g19(c[10],s[11],pp[0][4],s[18],c[18]);
full_adder g20(c[11],s[12],pp[0][5],s[19],c[19]);
full_adder g21(c[12],s[13],c[5],s[20],c[20]);
full_adder g22(c[13],s[14],c[7],s[21],c[21]);
full_adder g23(c[14],s[15],c[9],s[22],c[22]);

//Conversion of 2 to 1:
assign out[0]=pp[0][0];
//RCA
half_adder g24(pp[1][0],pp[0][1],out[1],c[23]);
full_adder g25(s[16],pp[0][2],c[23],out[2],c[24]);
full_adder g26(s[17],c[16],c[24],out[3],c[25]);
full_adder g27(s[18],c[17],c[25],out[4],c[26]);
full_adder g28(s[19],c[18],c[26],out[5],c[27]);
full_adder g29(s[20],c[19],c[27],out[6],c[28]);
full_adder g30(s[21],c[20],c[28],out[7],c[29]);
full_adder g31(s[22],c[21],c[29],out1[0],c[30]);
full_adder g32(c[15],c[22],c[30],out1[1],out1[2]);



//PART 1

//Conversion of  8 to 6:
half_adder h1(pp[7][1],pp[6][2],ss[0],cc[0]);
half_adder h2(pp[7][2],pp[6][3],ss[1],cc[1]);

//Conversion of 6 to 4:
full_adder h3(ss[0],pp[5][3],pp[4][4],ss[2],cc[2]);
full_adder h4(cc[0],ss[1],pp[5][4],ss[3],cc[3]);
half_adder h5(pp[4][5],pp[3][6],ss[4],cc[4]);
full_adder h6(pp[7][3],pp[6][4],cc[1],ss[5],cc[5]);
full_adder h7(pp[5][5],pp[4][6],pp[3][7],ss[6],cc[6]);
full_adder h8(pp[7][4],pp[6][5],pp[5][6],ss[7],cc[7]);

//Conversion of 4 to 3:

half_adder h9(ss[2],pp[3][5],ss[8],cc[8]);
full_adder h10(cc[2],ss[3],ss[4],ss[9],cc[9]);
full_adder h11(cc[3],ss[6],ss[5],ss[10],cc[10]);
full_adder h12(cc[5],pp[4][7],ss[7],ss[11],cc[11]);
full_adder h13(cc[7],pp[7][5],pp[6][6],ss[12],c[12]);

//Conversion of 3 to 2:
half_adder h14(ss[8],pp[2][6],ss[13],cc[13]);
full_adder h15(cc[8],ss[9],pp[2][7],ss[14],cc[14]);
full_adder h16(cc[9],ss[10],cc[4],ss[15],cc[15]);
full_adder h17(cc[10],ss[11],cc[6],ss[16],cc[16]);
full_adder h18(cc[11],ss[12],pp[5][7],ss[17],cc[17]);
full_adder h19(cc[12],pp[7][6],pp[6][7],ss[18],cc[18]);

//Conversion of 2 to 1:
//RCA

half_adder h20(ss[13],pp[1][7],out2[0],cc[19]);
full_adder h21(cc[13],ss[14],cc[19],out2[1],cc[20]);
full_adder h22(cc[14],ss[15],cc[20],out2[2],cc[21]);
full_adder h23(cc[15],ss[16],cc[21],out2[3],cc[22]);
full_adder h24(cc[16],ss[17],cc[22],out2[4],cc[23]);
full_adder h25(cc[17],ss[18],cc[23],out2[5],cc[24]);
full_adder h26(cc[18],pp[7][7],cc[24],out2[6],out2[7]);

// To add extra partial carry outputs from PART 0 with PART 1, WE WILL USE HYBRID ADDER

// MBEC (Multiplexers with Binary to Excess-1 Converters) and Ripple Carry Adder (CLA) 

// 3-bit RCA

full_adder a1(out1[0],out2[0],1'b0,out[8],cc[25]);
full_adder a2(out1[1],out2[1],cc[25],out[9],cc[26]);
full_adder a3(out1[2],out2[2],cc[26],out[10],cc[27]);

//half_adder a4(cc[27],out2[3],out[11],cc[28]);
//half_adder a5(cc[28],out2[4],out[12],cc[29]);
//half_adder a6(cc[29],out2[5],out[13],cc[30]);
//half_adder a7(cc[30],out2[6],out[14],cc[31]);
//half_adder a8(cc[31],out2[7],out[15],cc[32]);


//5-bit MBEC

assign mbec[0]= (~out2[3]);
assign mbec[1]= (out2[3]^out2[4]);
assign mbec[2]= (out2[3] & out2[4]) ^ (out2[5]);
assign mbec[3]= (out2[3] & out2[4] & out2[5]) ^ (out2[6]);
assign mbec[4]= (out2[3] & out2[4] & out2[5] & out2[6]) ^ (out2[7]);

assign out[15:11]=(cc[27]) ? (mbec[4:0]) : (out2[7:3]);

endmodule




         