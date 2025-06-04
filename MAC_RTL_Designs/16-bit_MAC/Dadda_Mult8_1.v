module Dadda_Mult8_1(
input [7:0]a,
input [7:0]b,
output [15:0]out);

wire p[7:0][7:0];

wire [41:0]s;
wire [54:0]c;



genvar i;
genvar j;
generate
for(i=0;i<8;i=i+1) begin:row1
  for(j=0;j<8;j=j+1)begin: row2
  assign p[j][i]= a[j] & b[i];
  end
end
endgenerate


//Conversion of 8 to 6:

half_adder g1(p[6][0],p[5][1],s[0],c[0]);

full_adder g2(p[7][0],p[6][1],p[5][2],s[1],c[1]);
half_adder g3(p[4][3],p[3][4],s[2],c[2]);

full_adder g4(p[7][1],p[6][2],p[5][3],s[3],c[3]);
half_adder g5(p[4][4],p[3][5],s[4],c[4]);

full_adder g6(p[7][2],p[6][3],p[5][4],s[5],c[5]);

//Conversion of 6 to 4:

half_adder g7(p[4][0],p[3][1],s[6],c[6]);

full_adder g8(p[5][0],p[4][1],p[3][2],s[7],c[7]);
half_adder g9(p[2][3],p[1][4],s[8],c[8]);

full_adder g10(s[0],p[4][2],p[3][3],s[9],c[9]);
full_adder g11(p[2][4],p[1][5],p[0][6],s[10],c[10]);

full_adder g12(c[0],s[1],s[2],s[11],c[11]);
full_adder g13(p[2][5],p[1][6],p[0][7],s[12],c[12]);

full_adder g14(c[1],c[2],s[3],s[13],c[13]);
full_adder g15(s[4],p[2][6],p[1][7],s[14],c[14]);

full_adder g16(c[3],c[4],s[5],s[15],c[15]);
full_adder g17(p[4][5],p[3][6],p[2][7],s[16],c[16]);

full_adder g18(c[5],p[7][3],p[6][4],s[17],c[17]);
full_adder g19(p[5][5],p[4][6],p[3][7],s[18],c[18]);

full_adder g20(p[7][4],p[6][5],p[5][6],s[19],c[19]);

//Conversion of 4 to 3:
half_adder g21(p[3][0],p[2][1],s[20],c[20]);

full_adder g22(s[6],p[2][2],p[1][3],s[21],c[21]);
full_adder g23(c[6],s[7],s[8],s[22],c[22]);
full_adder g24(c[7],c[8],s[9],s[23],c[23]);
full_adder g25(c[9],c[10],s[11],s[24],c[24]);
full_adder g26(c[11],c[12],s[13],s[25],c[25]);
full_adder g27(c[13],c[14],s[15],s[26],c[26]);
full_adder g28(c[15],c[16],s[17],s[27],c[27]);
full_adder g29(c[17],c[18],s[19],s[28],c[28]);
full_adder g30(c[19],p[7][5],p[6][6],s[29],c[29]);

//Conversion of 3 to 2:
half_adder g31(p[2][0],p[1][1],s[30],c[30]);

full_adder g32(s[20],p[1][2],p[0][3],s[31],c[31]);
full_adder g33(s[21],c[20],p[0][4],s[32],c[32]);
full_adder g34(s[22],c[21],p[0][5],s[33],c[33]);
full_adder g35(s[23],c[22],s[10],s[34],c[34]);
full_adder g36(s[24],c[23],s[12],s[35],c[35]);
full_adder g37(s[25],c[24],s[14],s[36],c[36]);
full_adder g38(s[26],c[25],s[16],s[37],c[37]);
full_adder g39(s[27],c[26],s[18],s[38],c[38]);
full_adder g40(s[28],c[27],p[4][7],s[39],c[39]);
full_adder g41(s[29],c[28],p[5][7],s[40],c[40]);
full_adder g42(c[29],p[7][6],p[6][7],s[41],c[41]);

//Conversion 2 to 1:
assign out[0]=p[0][0];

half_adder g43(p[1][0],p[0][1],out[1],c[42]);

full_adder g44(s[30],p[0][2],c[42],out[2],c[43]);
full_adder g45(s[31],c[30],c[43],out[3],c[44]);
full_adder g46(s[32],c[31],c[44],out[4],c[45]);
full_adder g47(s[33],c[32],c[45],out[5],c[46]);
full_adder g48(s[34],c[33],c[46],out[6],c[47]);
full_adder g49(s[35],c[34],c[47],out[7],c[48]);
full_adder g50(s[36],c[35],c[48],out[8],c[49]);
full_adder g51(s[37],c[36],c[49],out[9],c[50]);
full_adder g52(s[38],c[37],c[50],out[10],c[51]);
full_adder g53(s[39],c[38],c[51],out[11],c[52]);
full_adder g54(s[40],c[39],c[52],out[12],c[53]);
full_adder g55(s[41],c[40],c[53],out[13],c[54]);
full_adder g56(p[7][7],c[41],c[54],out[14],out[15]);

endmodule


