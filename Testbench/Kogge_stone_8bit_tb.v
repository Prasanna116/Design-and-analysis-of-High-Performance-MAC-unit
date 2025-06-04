module kogge_stone_8bit_tb;

reg [7:0]a;
reg [7:0]b;
reg cin;

wire [7:0]s;
wire cout;

kogge_stone_8bit utt(a,b,cin,s,cout);

initial 
begin

a=8'b00000000;b=8'b00000000;cin=0;

#10 a=8'b11110000;b=8'b00001111;cin=0;
#10 a=8'b10110101;b=8'b11010110;cin=1;
#10 a=8'b01101001;b=8'b01011100;cin=1;
#10 a=8'b10101010;b=8'b01010101;cin=0;

end

initial
begin
$monitor("%g\t  %b %b   %b | %b   %b", $time, a, b, cin, s, cout);
end

endmodule