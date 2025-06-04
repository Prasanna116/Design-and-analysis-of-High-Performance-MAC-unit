`timescale 1ns / 1ps

module Vedic_Mult4_tb;

reg [3:0] a;
reg [3:0] b;

wire [7:0] out;

Vedic_Mult4 uut (
        .a(a),
        .b(b),
        .out(out));

initial begin
// Initialize inputs
a = 0;
b = 0;

// Apply test cases
        #10 a = 4'b0001; b = 4'b0010;  // 1 * 2 = 2
        #10 $display("%0t\t%b\t%b\t%b", $time, a, b, out);

        #10 a = 4'b0011; b = 4'b0101;  // 3 * 5 = 15
        #10 $display("%0t\t%b\t%b\t%b", $time, a, b, out);

        #10 a = 4'b1111; b = 4'b1111;  // 15 * 15 = 225
        #10 $display("%0t\t%b\t%b\t%b", $time, a, b, out);

        #10 a = 4'b1010; b = 4'b0101;  // 10 * 5 = 50
        #10 $display("%0t\t%b\t%b\t%b", $time, a, b, out);

        #10 a = 4'b0110; b = 4'b0011;  // 6 * 3 = 18
        #10 $display("%0t\t%b\t%b\t%b", $time, a, b, out);

        // Finish simulation
        #10 $finish;
    end

endmodule
