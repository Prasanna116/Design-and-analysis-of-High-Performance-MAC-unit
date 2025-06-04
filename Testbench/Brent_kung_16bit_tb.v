// Testbench for 16-bit Brent-Kung Adder
`timescale 1ns/1ps

module Brent_kung_16bit_tb;

  // Testbench signals
  reg [15:0] a;
  reg [15:0] b;
  reg cin;
  wire [15:0] s;
  wire cout;

  // Instantiate the Brent-Kung Adder module
  Brent_kung_16bit UUT (
    .a(a),
    .b(b),
    .cin(cin),
    .s(s),
    .cout(cout)
  );

  // Test sequence
  initial begin
    // Initialize inputs
    a = 16'b0;
    b = 16'b0;
    cin = 0;

    // Apply a series of test cases
    $display("Time\ta\tb\tc_in\ts\tc_out\n-----------------------------------");
    $monitor("%0dns\t%h\t%h\t%b\t%h\t%b", $time, a, b, cin, s, cout);

    // Test case 1: Zero inputs
    #10 a = 16'h0000; b = 16'h0000; cin = 0;
   
    // Test case 2: Small inputs
    #10 a = 16'h000F; b = 16'h0001; cin = 0;

    // Test case 3: Carry generation
    #10 a = 16'hFE01; b = 16'h001A; cin = 0;

    // Test case 4: Random values
    #10 a = 16'h1234; b = 16'h5678; cin = 0;

    // Test case 5: Random values
    #10 a = 16'hFF24; b = 16'h001A; cin = 0;

    // Test case 6: Large inputs
    #10 a = 16'hABCD; b = 16'hDCBA; cin = 0;

    // Finish simulation
    #10 $finish;
  end

endmodule

