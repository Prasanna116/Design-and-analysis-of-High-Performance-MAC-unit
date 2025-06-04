module Wallace_Mult8(
input signed [7:0]a,
input signed [7:0]b,
output signed [15:0]out);

wire p[7:0][7:0];
wire [52:0]s;
wire [63:0]c;

//Partial Product Generation
genvar i,j;
generate 
for(i=0;i<8;i=i+1)begin:pp1
  for(j=0;j<8;j=j+1)begin:pp2
     assign p[j][i]= a[j] & b[i];
  end
end
endgenerate




// Level 1

half_adder g1(p[1][0],p[0][1],s[0],c[0]);
full_adder g2(p[2][0],p[1][1],p[0][2],s[1],c[1]);
full_adder g3(p[3][0],p[2][1],p[1][2],s[2],c[2]);
full_adder g4(p[4][0],p[3][1],p[2][2],s[3],c[3]);
full_adder g5(p[5][0],p[4][1],p[3][2],s[5],c[5]);
full_adder g6(p[6][0],p[5][1],p[4][2],s[7],c[7]);
full_adder g7(p[7][0],p[6][1],p[5][2],s[9],c[9]);
full_adder g8(0,p[7][1],p[6][2],s[11],c[11]);

half_adder g9(p[1][3],p[0][4],s[4],c[4]);
full_adder g10(p[2][3],p[1][4],p[0][5],s[6],c[6]);
full_adder g11(p[3][3],p[2][4],p[1][5],s[8],c[8]);
full_adder g12(p[4][3],p[3][4],p[2][5],s[10],c[10]);
full_adder g13(p[5][3],p[4][4],p[3][5],s[12],c[12]);
full_adder g14(p[6][3],p[5][4],p[4][5],s[13],c[13]);
full_adder g15(p[7][3],p[6][4],p[5][5],s[14],c[14]);
half_adder g16(p[7][4],p[6][5],s[15],c[15]);

//Level 2
half_adder g17(s[1],c[0],s[16],c[16]);
full_adder g18(s[2],c[1],p[0][3],s[17],c[17]);
full_adder g19(s[3],c[2],s[4],s[18],c[18]);
full_adder g20(s[5],c[3],s[6],s[19],c[19]);
full_adder g21(s[7],c[5],s[8],s[20],c[20]);
full_adder g22(s[9],c[7],s[10],s[22],c[22]);
full_adder g23(s[11],c[9],s[12],s[24],c[24]);
full_adder g24(p[7][2],c[11],s[13],s[26],c[26]);

half_adder g25(c[6],p[0][6],s[21],c[21]);
full_adder g26(c[8],p[1][6],p[0][7],s[23],c[23]);
full_adder g27(c[10],p[2][6],p[1][7],s[25],c[25]);
full_adder g28(c[12],p[3][6],p[2][7],s[27],c[27]);
full_adder g29(c[13],p[4][6],p[3][7],s[28],c[28]);
full_adder g30(c[14],p[5][6],p[4][7],s[29],c[29]);
full_adder g31(c[15],p[6][6],p[5][7],s[30],c[30]);
half_adder g32(p[7][6],p[6][7],s[31],c[31]);

//Level 3
half_adder g33(s[17],c[16],s[32],c[32]);
half_adder g34(s[18],c[17],s[33],c[33]);
full_adder g35(s[19],c[18],c[4],s[34],c[34]);
full_adder g36(s[20],c[19],s[21],s[35],c[35]);
full_adder g37(s[22],c[20],s[23],s[36],c[36]);
full_adder g38(s[24],c[22],s[25],s[37],c[37]);
full_adder g39(s[26],c[24],s[27],s[38],c[38]);
full_adder g40(s[28],c[26],s[14],s[39],c[39]);
half_adder g41(s[15],s[29],s[40],c[40]);
half_adder g42(p[7][5],s[30],s[41],c[41]);

//Level 4
half_adder g43(s[33],c[32],s[42],c[42]);
half_adder g44(s[34],c[33],s[43],c[43]);
half_adder g45(s[35],c[34],s[44],c[44]);
full_adder g46(s[36],c[35],c[21],s[45],c[45]);
full_adder g47(s[37],c[36],c[23],s[46],c[46]);
full_adder g48(s[38],c[37],c[25],s[47],c[47]);
full_adder g49(s[39],c[38],c[27],s[48],c[48]);
full_adder g50(s[40],c[39],c[28],s[49],c[49]);
full_adder g51(s[41],c[40],c[29],s[50],c[50]);
full_adder g52(s[31],c[41],c[30],s[51],c[51]);
half_adder g53(p[7][7],c[31],s[52],c[52]);

//Level 5
assign out[0]=p[0][0];
assign out[1]=s[0];
assign out[2]=s[16];
assign out[3]=s[32];
assign out[4]=s[42];

half_adder g54(s[43],c[42],out[5],c[53]);
full_adder g55(s[44],c[43],c[53],out[6],c[54]);
full_adder g56(s[45],c[44],c[54],out[7],c[55]);
full_adder g57(s[46],c[45],c[55],out[8],c[56]);
full_adder g58(s[47],c[46],c[56],out[9],c[57]);
full_adder g59(s[48],c[47],c[57],out[10],c[58]);
full_adder g60(s[49],c[48],c[58],out[11],c[59]);
full_adder g61(s[50],c[49],c[59],out[12],c[60]);
full_adder g62(s[51],c[50],c[60],out[13],c[61]);
full_adder g63(s[52],c[51],c[61],out[14],c[62]);
half_adder g64(c[52],c[62],out[15],c[63]);


endmodule



