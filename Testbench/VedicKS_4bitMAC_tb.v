`timescale 1ns / 1ps

module VedicKS_4bitMAC_tb;

    // Inputs
    reg [3:0] a;
    reg [3:0] b;
    reg clk;
    reg rst;
    reg cin;

    // Outputs
    wire [7:0] result;
    wire cout;

    // Instantiate the MAC Unit
    VedicKS_4bitMAC uut (
        .a(a),
        .b(b),
        .clk(clk),
        .rst(rst),
        .cin(cin),
        .result(result),
        .cout(cout)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock period of 10ns
    end

    // Apply Inputs and Test Cases
    initial begin
        // Initialize inputs
        a = 0;
        b = 0;
        rst = 1;   // Assert reset
        cin = 0;

        #10 rst = 0; // Deassert reset

        // Test Case 1: Basic operation
        #10 a = 4'b0011; b = 4'b0010; cin = 0; // (3 * 2) -> Result should accumulate 6
        #10 a = 4'b0101; b = 4'b0001; cin = 0; // (5 * 1) -> Result should accumulate 6 + 5 = 11
        #10 a = 4'b0010; b = 4'b0011; cin = 0; // (2 * 3) -> Result should accumulate 11 + 6 = 17

        // Test Case 2: Using carry-in
        #10 a = 4'b0011; b = 4'b0011; cin = 1; // (3 * 3) + 17 + 1 -> Accumulate 17 + 9 + 1 = 27

        // Test Case 3: Reset behavior
        #10 rst = 1;  // Assert reset


        #10 rst=0; a = 4'b1111; b = 4'b1111; cin = 0; // Maximum values (15 * 15) -> Accumulate 225

        // Test Case 4: Check overflow
        #10 a = 4'b1010; b = 4'b0110; cin = 0; // 255 + (10*6) = 315

        // End simulation
        #20 $finish;
    end

    // Monitor the output values
    initial begin
        $monitor("Time = %0dns, a = %b, b = %b, result = %d, cout = %b", 
                 $time, a, b, result, cout);
    end

endmodule

