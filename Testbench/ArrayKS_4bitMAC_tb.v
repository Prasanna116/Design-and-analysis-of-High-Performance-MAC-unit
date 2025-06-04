`timescale 1ns / 1ps

module ArrayKS_4bitMAC_tb;

    // Inputs
    reg [3:0] a;
    reg [3:0] b;
    reg clk;
    reg rst;
    reg cin;

    // Outputs
    wire [7:0] result;
    wire cout;

    // Instantiate the ArrayKS_4bitMAC module
    ArrayKS_4bitMAC uut (
        .a(a),
        .b(b),
        .clk(clk),
        .rst(rst),
        .cin(cin),
        .result(result),
        .cout(cout)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // Clock period of 10ns (100MHz)
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 0;
        a = 4'b0000;
        b = 4'b0000;
        cin = 0;

        // Apply reset
        rst = 1;
        #10;
        rst = 0;

        // Test Case 1: Multiply 4'b0001 and 4'b0010 with no carry-in
        a = 4'b0001;
        b = 4'b0010;
        cin = 0;
        #10;  // Wait for one clock cycle

        // Test Case 2: Multiply 4'b0101 and 4'b0110 with carry-in = 0
        a = 4'b0101;
        b = 4'b0110;
        cin = 0;
        #10;

        // Test Case 3: Multiply 4'b1111 and 4'b1111 with no carry-in
        a = 4'b1111;
        b = 4'b1111;
        cin = 0;
        #10;

        // Test Case 4: Multiply 4'b1100 and 4'b1010 with carry-in = 0
        a = 4'b1100;
        b = 4'b1010;
        cin = 0;
        #10;


        // End simulation
        $finish;
    end

    // Monitor output results
    initial begin
        $monitor("Time = %0t | a = %b, b = %b, cin = %b, rst = %b, result = %b, cout = %b", 
                 $time, a, b, cin, rst, result, cout);
    end

endmodule

