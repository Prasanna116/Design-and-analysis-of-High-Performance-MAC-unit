module Wallace_Tree_4bbit(
input [3:0] a,
input [3:0] b,
output [7:0] s);

wire [3:0] p0;
wire [3:0] p1;
wire [3:0] p2;
wire [3:0] p3;

wire[10:0] c;
wire[5:0] ss;
assign po= a & {4{b[0]}};
assign p1= a & {4{b[1]}};
assign p2= a & {4{b[2]}};
assign p3= a & {4{b[3]}};

half_adder(p0[1],p1[0],s[1],c[0]);
full_adder(p0[2],p1[1],p2[0],ss[0],c[1]);
full_adder(p0[3],p1[2],p2[1],ss[1],c[2]);
half_adder(p1[3],p2[2],ss[2],c[3]);

half_adder(c[0],ss[0],s[2],c[4]);
full_adder(p3[0],ss[1],c[1],ss[3],c[5]);
full_adder(p3[1],ss[2],c[2],ss[4],c[6]);
full_adder(p2[3],p3[2],c[3],ss[5],c[7]);

half_adder(c[4],ss[3],s[3],c[8]);
full_adder(c[5],ss[4],c[8],s[4],c[9]);
full_adder(c[6],ss[5],c[9],s[5],c[10]);
full_adder(c[7],p3[3],c[10],s[6],s[7]);

endmodule





