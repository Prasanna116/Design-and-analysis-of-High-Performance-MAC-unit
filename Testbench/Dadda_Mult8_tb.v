`timescale 1ns/1ps

module Dadda_Mult8_tb;

// Inputs
reg [7:0] a;
reg [7:0] b;

// Outputs
wire [15:0] out;

// Instantiate the DUT (Device Under Test)
Dadda_Mult8_1 dut (
    .a(a),
    .b(b),
    .out(out)
);

// Task to compute the expected product
function [15:0] expected_product(input [7:0] a, input [7:0] b);
    expected_product = a * b;
endfunction

// Testbench procedure
initial begin
    // Initialize inputs
    a = 0;
    b = 0;

    // Apply test cases
    $display("Starting Dadda Multiplier Testbench...");
    $display("Time\tA\tB\tExpected\tOutput\tPass/Fail");
    $monitor("%0t\t%0d\t%0d\t%0d\t\t%0d\t%s",
             $time, a, b, expected_product(a, b), out,
             (out === expected_product(a, b)) ? "PASS" : "FAIL");

    // Test case 1: Multiplication of small numbers
    #10 a = 8'd3; b = 8'd4; // 3 * 4 = 12
    #10 a = 8'd15; b = 8'd15; // 15 * 15 = 225

    // Test case 2: Multiplication with zero
    #10 a = 8'd0; b = 8'd127; // 0 * 127 = 0
    #10 a = 8'd255; b = 8'd0; // 255 * 0 = 0

    // Test case 3: Multiplication of large numbers
    #10 a = 8'd255; b = 8'd255; // 255 * 255 = 65025
    #10 a = 8'd128; b = 8'd128; // 128 * 128 = 16384

    // Test case 4: Random numbers
    #10 a = 8'd123; b = 8'd45; // 123 * 45 = 5535
    #10 a = 8'd60; b = 8'd25;  // 60 * 25 = 1500

    // End of testbench
    #10 $stop;
end

endmodule

