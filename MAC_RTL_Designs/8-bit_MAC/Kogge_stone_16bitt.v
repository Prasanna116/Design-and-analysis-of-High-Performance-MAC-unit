module Kogge_stone_16bitt(
input [15:0]a,
input [15:0]b,
input cin,
output [15:0]s,
output cout);

wire [15:0]c;
wire [15:0]p0, g0;
wire [15:0]p1, g1;
wire [15:0]p2, g2;
wire [15:0]p3, g3;
wire [15:0]p4, g4;


//STAGE1 Preprocessing stage
assign p0=a^b;
assign g0=a&b;

//STAGE2 Parallel  prefix
//ROW1
assign p1[0]=p0[0];
assign g1[0]=g0[0];

genvar i;

generate 
for(i=1;i<16;i=i+1) begin : gen_row1
assign p1[i]= p0[i] & p0[i-1];
assign g1[i]= g0[i] | ( g0[i-1] & p0[i]);
end
endgenerate

// Paralle Prefix STAGE 2

assign p2[0]=p0[0];
assign g2[0]=g0[0];
assign p2[1]=p1[1];
assign g2[1]=g1[1];

generate 
for(i=2;i<16;i=i+1) begin : gen_row2
assign p2[i]= p1[i] & p1[i-2];
assign g2[i]= g1[i] | ( g1[i-2] & p1[i]);
end
endgenerate


//Parallel Prefix STAGE 3
assign p3[0]=p0[0];
assign g3[0]=g0[0];
assign p3[1]=p1[1];
assign g3[1]=g1[1];
assign p3[2]=p2[2];
assign g3[2]=g2[2];
assign p3[3]=p2[3];
assign g3[3]=g2[3];

generate 
for(i=4;i<16;i=i+1) begin : gen_row3
assign p3[i]= p2[i] & p2[i-4];
assign g3[i]= g2[i] | ( g2[i-4] & p2[i]);
end
endgenerate

//Parallel Prefix STAGE 4

generate 
for(i=8;i<16;i=i+1) begin : gen_row4
assign p4[i]= p3[i] & p3[i-8];
assign g4[i]= g3[i] | ( g3[i-8] & p3[i]);
end
endgenerate

// Default values for p4[0-7] and g4[0-7]
assign p4[7:0] = p3[7:0];
assign g4[7:0] = g3[7:0];


// STAGE 3 SUM & CARRY
assign c[0]=cin;
assign c[1]=g0[0];
assign c[2]=g1[1];
assign c[3]=g2[2];
assign c[4]=g2[3];
assign c[5]=g3[4];
assign c[6]=g3[5];
assign c[7]=g3[6];
assign c[8]=g3[7];
assign c[9]=g4[8];
assign c[10]=g4[9];
assign c[11]=g4[10];
assign c[12]=g4[11];
assign c[13]=g4[12];
assign c[14]=g4[13];
assign c[15]=g4[14];
assign cout=g4[15];

assign s= (p0^c[15:0]);

endmodule
