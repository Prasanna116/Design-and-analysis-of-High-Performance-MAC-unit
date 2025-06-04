// Testbench for DaddaBK_8bitMAC
`timescale 1ns/1ps

module DaddaBK_8bitMAC_tb;

    // Inputs
    reg [7:0] a;
    reg [7:0] b;
    reg clk;
    reg rst;
    reg cin;

    // Outputs
    wire [15:0] out;
    wire cout;

    // Instantiate the DaddaBK_8bitMAC module
    DaddaBK_8bitMAC UUT (
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
        forever #5 clk = ~clk; // Clock period of 10ns
    end

    // Test sequence
    initial begin
        // Initialize inputs
        a = 8'b0;
        b = 8'b0;
        rst = 1;
        cin = 0;

        // Display header for monitoring
        $display("Time\ta\tb\tc_in\tout\tc_out\n------------------------------------------------------");
        $monitor("%0dns\t%h\t%h\t%b\t%h\t%b", $time, a, b, cin, out, cout);

        // Test Case 1: Reset behavior
        #10 rst = 0; a = 8'd0; b = 8'd0; cin = 0; // Outputs should be zero

        // Test Case 2: Simple multiplication
        #10 a = 8'd15; b = 8'd15; cin = 0; // 15 * 15 = 225

        // Test Case 3: Accumulation with carry-in
        #10 a = 8'd3; b = 8'd4; cin = 0; // (3 * 4) + 225 + 0 = 237

        // Test Case 4: Multiplication with zero
        #10 a = 8'd0; b = 8'd127; cin = 0; // 0 * 127 = 0, result = 237

        // Test Case 5: Large numbers
        #10 a = 8'd255; b = 8'd255; cin = 0; // 255 * 255 + 236  = 65262

        // Test Case 6: Random values
        #10 a = 8'd128; b = 8'd64; cin = 0; // 128 * 64 + 65262 = 73454

        // Test Case 7: Check reset during operation
        #10 rst = 1; // Reset should clear the output
        #10 rst = 0; a = 8'd100; b = 8'd100; cin = 0; // 100 * 100 = 10000

        // End simulation
        #50 $finish;
    end

endmodule

