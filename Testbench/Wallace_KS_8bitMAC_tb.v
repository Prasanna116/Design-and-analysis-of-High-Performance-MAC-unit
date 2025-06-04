`timescale 1ns / 1ps

module Wallace_KS_8bitMAC_tb;

    // Testbench signals
    reg [7:0] a;
    reg [7:0] b;
    reg clk;
    reg rst;
    reg cin;
    wire [15:0] out;
    wire cout;

    // Instantiate the DUT (Device Under Test)
    Wallace_KS_8bitMAC DUT (
        .a(a),
        .b(b),
        .clk(clk),
        .rst(rst),
        .cin(cin),
        .out(out),
        .cout(cout)
    );

    // Clock generation (period = 10ns)
    initial clk = 0;
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize inputs
        a = 8'b0;
        b = 8'b0;
        cin = 1'b0;
        rst = 1'b1; // Assert reset

        // Wait for a few clock cycles
        #10;
        rst = 1'b0; // Deassert reset

        // Apply test cases
        #10; a = 8'd15; b = 8'd10; cin = 1'b0; // Test Case 1
        #10; a = 8'd20; b = 8'd25; cin = 1'b0; // Test Case 2
        #10; a = 8'd50; b = 8'd30; cin = 1'b0; // Test Case 3
        #10; a = 8'd100; b = 8'd200; cin = 1'b0; // Test Case 4
        #10; a = 8'd255; b = 8'd255; cin = 1'b0; // Test Case 5 (Boundary Condition)

        

        // Finish simulation
        #50;
         $finish;
    end

    // Monitor the results
    initial begin
        $monitor("Time: %0t | a = %d | b = %d | cin = %b | out = %d | cout = %b",
                 $time, a, b, cin, out, cout);
    end

endmodule
