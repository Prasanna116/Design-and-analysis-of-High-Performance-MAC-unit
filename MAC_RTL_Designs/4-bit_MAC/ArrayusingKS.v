module ArrayusingKS(
input [3:0] a,
input [3:0] b,
output [7:0] z);

//Partial products variables
wire [3:0]p0;
wire [3:0]p1;
wire [3:0]p2;
wire [3:0]p3;

wire [5:0]s;
wire [10:0]c;
//Partialproducts

assign p0= a & {4{b[0]}};
assign p1= a & {4{b[1]}};
assign p2= a & {4{b[2]}};
assign p3= a & {4{b[3]}};

assign z[0]=p0[0];
//ROW1
half_adder g1(p0[1],p1[0],z[1],c[0]);
half_adder g2(p0[2],p1[1],s[0],c[1]);
half_adder g3(p0[3],p1[2],s[1],c[2]);

//ROW2
full_adder h1(s[0],c[0],p2[0],z[2],c[3]);
full_adder h2(s[1],c[1],p2[1],s[2],c[4]);
full_adder h3(p1[3],c[2],p2[2],s[3],c[5]);

//ROW3
full_adder i1(s[2],c[3],p3[0],z[3],c[6]);
full_adder i2(s[3],c[4],p3[1],s[4],c[7]);
full_adder i3(p3[2],c[5],p2[3],s[5],c[8]);

//ROW4
half_adder j1(s[4],c[6],z[4],c[9]);
full_adder j2(s[5],c[7],c[9],z[5],c[10]);
full_adder j3(p3[3],c[8],c[10],z[6],z[7]);

endmodule

