module Brent_kung_8bit_tb;

    reg  [7:0] A, B;
    reg        Cin;
    wire [7:0] Sum;
    wire       Cout;

    Brent_kung_8bit uut (
        .a(A),
        .b(B),
        .cin(Cin),
        .s(Sum),
        .cout(Cout)
    );

    initial begin
        $display("A         B         Cin | Sum       Cout");
        $display("------------------------------");

        A = 8'h15; B = 8'h2A; Cin = 0; #10;
        $display("%h  %h   %b   | %h    %b", A, B, Cin, Sum, Cout);

        A = 8'hFF; B = 8'h01; Cin = 0; #10;
        $display("%h  %h   %b   | %h    %b", A, B, Cin, Sum, Cout);

        A = 8'hA5; B = 8'h5A; Cin = 1; #10;
        $display("%h  %h   %b   | %h    %b", A, B, Cin, Sum, Cout);

        A = 8'h00; B = 8'h00; Cin = 1; #10;
        $display("%h  %h   %b   | %h    %b", A, B, Cin, Sum, Cout);

        A = 8'hF0; B = 8'h0F; Cin = 1; #10;
        $display("%h  %h   %b   | %h    %b", A, B, Cin, Sum, Cout);

        $stop;
    end

endmodule

