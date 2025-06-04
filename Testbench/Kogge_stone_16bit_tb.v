`timescale 1ns / 1ps

module kogge_stone_16bit_tb;

    // Inputs
    reg [15:0] a;
    reg [15:0] b;
    reg cin;

    // Outputs
    wire [15:0] s;
    wire cout;

    // Instantiate the Unit Under Test (UUT)
    kogge_stone_16bitt uut (
        .a(a),
        .b(b),
        .cin(cin),
        .s(s),
        .cout(cout)
    );

    initial begin
        // Initialize Inputs
        a = 16'b0;
        b = 16'b0;
        cin = 1'b0;

        // Apply Test Cases
        #10 a = 16'b0000000000001010; b = 16'b0000000000001101; cin = 1'b0; // 10 + 13 = 23
        #10 a = 16'b1111111111111111; b = 16'b0000000000000001; cin = 1'b0; // Overflow: 65535 + 1 = 0x10000
        #10 a = 16'b1010101010101010; b = 16'b0101010101010101; cin = 1'b0; // Alternating bits sum
        #10 a = 16'b1111111111111111; b = 16'b1111111111111111; cin = 1'b1; // Large carry-in: 65535 + 65535 + 1 = 0x1FFFF
        #10 a = 16'b1000000000000000; b = 16'b1000000000000000; cin = 1'b0; // Test MSB carry
        #10 a = 16'b0000000000000001; b = 16'b0000000000000001; cin = 1'b1; // Smallest inputs with carry-in

        // End simulation
        #10 $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t | a=%b | b=%b | cin=%b | s=%b | cout=%b", 
                 $time, a, b, cin, s, cout);
    end

endmodule

