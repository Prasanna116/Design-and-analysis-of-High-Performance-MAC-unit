`timescale 1ns/1ps

module Vedic_Mult16_tb;

    reg [15:0] a, b;
    wire [31:0] out;

    Vedic_Mult16 uut (
        .a(a),
        .b(b),
        .out(out)
    );

    initial begin
        $monitor("Time: %0t | a = %d, b = %d | out = %d", $time, a, b, out);

        // Test case 1: 0 × 0
        a = 16'd0; b = 16'd0; #10;
        
        // Test case 2: 1 × 1
        a = 16'd1; b = 16'd1; #10;
        
        // Test case 3: 123 × 456
        a = 16'd123; b = 16'd456; #10;

        // Test case 4: Max × 1
        a = 16'hFFFF; b = 16'd1; #10;

        // Test case 5: Max × Max
        a = 16'hFFFF; b = 16'hFFFF; #10;

        // Test case 6: Random values
        a = 16'd30583; b = 16'd27456; #10;

        $stop;
    end

endmodule

