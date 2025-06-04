`timescale 1ns / 1ps

module Baugh_Wooley_Mult8_tb;
    // Inputs
    reg [7:0] a;
    reg [7:0] b;

    // Output
    wire [15:0] out;

    // Instantiate the DUT (Device Under Test)
    BaughWooley_Mult8 uut (
        .a(a),
        .b(b),
        .out(out)
    );

    // Stimulus block
    initial begin
        // Monitor the outputs
        $monitor("Time: %0t | a = %d, b = %d, out = %d", $time, a, b, out);

        // Apply test cases
        a = 8'b00000011; b = 8'b00000101; // 3 * 5 = 15
        #10;

        a = 8'b11111101; b = 8'b00000011; // -3 * 3 = -9
        #10;

        a = 8'b00001000; b = 8'b11111000; // 8 * -8 = -64
        #10;

        a = 8'b11111011; b = 8'b11111110; // -5 * -2 = 10
        #10;

        a = 8'b10000000; b = 8'b00000001; // -128 * 1 = -128
        #10;

        a = 8'b01111111; b = 8'b00000010; // 127 * 2 = 254
        #10;

        a = 8'b00000000; b = 8'b00000000; // 0 * 0 = 0
        #10;

        a = 8'b00000000; b = 8'b11111111; // 0 * -1 = 0
        #10;

        // End simulation
        $stop;
    end

endmodule

