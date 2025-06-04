`timescale 1ns / 1ps

module VedicBK_8bitMAC_tb;

    // Inputs
    reg [7:0] a;
    reg [7:0] b;
    reg clk;
    reg rst;
    reg cin;

    // Outputs
    wire [15:0] out;
    wire cout;

    // Instantiate the 8-bit MAC Unit
    VedicBK_8bitMAC uut (
        .a(a),
        .b(b),
        .clk(clk),
        .rst(rst),
        .cin(cin),
        .out(out),
        .cout(cout)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test cases
    initial begin
        // Monitor signals for debugging
        $monitor("Time: %0dns | a: %d | b: %d | cin: %b | out: %d | cout: %b", 
                 $time, a, b, cin, out, cout);

        // Initialize inputs
        a = 0; b = 0; cin = 0; rst = 1;

        // Hold reset
        #10 rst = 0;

        // Test Case 1: Multiply and accumulate
        #10 a = 8'b00000011; b = 8'b00000010; cin = 0; // (3 * 2) = 6
        #10 a = 8'b00000101; b = 8'b00000001; cin = 0; // (5 * 1) + 6 = 11
        #10 a = 8'b00000010; b = 8'b00000011; cin = 0; // (2 * 3) + 11 = 17

        // Test Case 2: Multiply with carry-in
        #10 a = 8'b00000011; b = 8'b00000011; cin = 0; // (3 * 3) + 17  = 26

     
        #10 a = 8'b11111111; b = 8'b11111111; cin = 0; // Maximum values (255 * 255)+ 26 = 65051

        // Test Case 4: Overflow scenario
        #10 a = 8'b00010110; b = 8'b00001100; cin = 0; // Accumulate with overflow
        
        // End simulation
        #20 $finish;
    end
endmodule

