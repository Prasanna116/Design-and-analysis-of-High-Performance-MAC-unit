`timescale 1ns/1ps

module Dadda_Mult16_tb;

  reg [15:0] a, b;
  wire [31:0] out;

  // Instantiate the DUT (Device Under Test)
  Dadda_Mult16 DUT (
    .a(a),
    .b(b),
    .out(out)
  );

  // Task to check result
  task check_result;
    input [15:0] a_in, b_in;
    input [31:0] result;
    reg [31:0] expected;
    begin
      expected = a_in * b_in;
      if (result === expected)
        $display("PASS: a = %h, b = %h, out = %h", a_in, b_in, result);
      else
        $display("FAIL: a = %h, b = %h, Expected = %h, Got = %h", a_in, b_in, expected, result);
    end
  endtask

  initial begin
    $display("Starting 16-bit Dadda Multiplier Testbench...\n");

    // Test 1
    a = 16'h0002; b = 16'h0003; #10;
    check_result(a, b, out);

    // Test 2
    a = 16'h0000; b = 16'hABCD; #10;
    check_result(a, b, out);

    // Test 3
    a = 16'hFFFF; b = 16'h0001; #10;
    check_result(a, b, out);

    // Test 4
    a = 16'h1234; b = 16'h5678; #10;
    check_result(a, b, out);

    // Test 5
    a = 16'hFFFF; b = 16'hFFFF; #10;
    check_result(a, b, out);

    // Test 6
    a = 16'h00F0; b = 16'h0F00; #10;
    check_result(a, b, out);

    $display("\nTestbench completed.");
    $finish;
  end

endmodule

