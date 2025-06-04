module Brent_kung_8bit(
input [7:0] a,
input [7:0]b,
input cin,
output [7:0]s,
output cout);

wire [7:0]p0,g0;
wire [7:0]p1,g1;
wire [7:0]p2,g2;
wire [7:0]p3,g3;
wire [7:0]p4,g4;


wire [7:0]c;

//STAGE 0
assign p0= a ^ b;
assign g0= a & b;

//STAGE 1 
genvar i;
generate
for(i=1;i<8;i=i+2)begin:row1
 assign p1[i]= p0[i] & p0[i-1];
 assign g1[i]= g0[i] | ( g0[i-1] & p0[i]);
end
endgenerate

//STAGE 2
generate
for(i=3;i<8;i=i+4)begin:row2
 assign p2[i]= p1[i] & p1[i-2];
 assign g2[i]= g1[i] | ( g1[i-2] & p1[i]);
end
endgenerate

//STAGE 3
assign p3[7]= p2[7] & p2[3];
assign g3[7]= g2[7] | ( g2[3] & p2[7]);

assign p3[5]= p1[5] & p2[3];
assign g3[5]= g1[5] | ( g2[3] & p1[5]);

//STAGE 4
assign p4[2]= p0[2] & p1[1];
assign g4[2]= g0[2] | ( g1[1] & p0[2]);

assign p4[4]= p0[4] & p2[3];
assign g4[4]= g0[4] | ( g2[3] & p0[4]);

assign p4[6]= p0[6] & p3[5];
assign g4[6]= g0[6] | ( g3[5] & p0[6]);

// For only Cin=0
//assign c[0]=cin;
//assign c[1]=g0[0];
//assign c[2]=g1[1];
//assign c[3]=g4[2];
//assign c[4]=g2[3];
//assign c[5]=g4[4];
//assign c[6]=g3[5];
//assign c[7]=g4[6];
//assign cout=g3[7];

//For Cin= 0 OR 1
assign c[0] = cin;
assign c[1] = g0[0] | (p0[0] & cin);
assign c[2] = g1[1] | (p1[1] & cin);
assign c[3] = g4[2] | (p4[2] & cin);
assign c[4] = g2[3] | (p2[3] & cin);
assign c[5] = g4[4] | (p4[4] & cin);
assign c[6] = g3[5] | (p3[5] & cin);
assign c[7] = g4[6] | (p4[6] & cin);
assign cout = g3[7] | (p3[7] & cin);

assign s= p0 ^ c ;

endmodule

