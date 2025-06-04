`timescale 1ns / 1ps

module Kogge_stone_32bit_tb;

    // Inputs
    reg [31:0] a;
    reg [31:0] b;
    reg cin;

    // Outputs
    wire [31:0] s;
    wire cout;

    // Instantiate the Unit Under Test (UUT)
    Kogge_stone_32bit uut (
        .a(a),
        .b(b),
        .cin(cin),
        .s(s),
        .cout(cout)
    );

    // Expected result
    reg [32:0] expected_sum;

    // Task to apply test and check result
    task apply_test(input [31:0] in_a, input [31:0] in_b);
    begin
        a = in_a;
        b = in_b;
        cin = 0;
        expected_sum = a + b;
        #10;
        $display("Time=%0t a=%h b=%h cin=%b | s=%h cout=%b | expected_sum=%h",
                 $time, a, b, cin, s, cout, expected_sum);
        if ({cout, s} === expected_sum) begin
            $display("PASS: a=%h b=%h cin=%b -> s=%h cout=%b", a, b, cin, s, cout);
        end else begin
            $display("ERROR: Mismatch! a=%h b=%h cin=%b -> s=%h cout=%b | expected=%h",
                     a, b, cin, s, cout, expected_sum);
        end
    end
    endtask

    initial begin
        // Apply various test cases with cin = 0
        apply_test(32'h0000_1234, 32'h0000_5678);   // Small numbers
        apply_test(32'h89AB_CDEF, 32'h7654_3210);   // High values
        apply_test(32'h0F0F_0F0F, 32'hF0F0_F0F0);   // Alternating pattern
        apply_test(32'h1234_5678, 32'h2345_6789);   // Mid-range
        apply_test(32'hDEAD_BEEF, 32'hCAFEBABE);    // Big numbers
        apply_test(32'h0000_0000, 32'hFFFFFFFF);    // Zero + max
        apply_test(32'h1357_9BDF, 32'h2468_ACF0);   // Odd/even pattern
        apply_test(32'hAAAA_AAAA, 32'h5555_5555);   // Checkerboard pattern
        apply_test(32'h7FFF_FFFF, 32'h0000_0001);   // Overflow test
        apply_test(32'hFFFF_FFFF, 32'hFFFF_FFFF);   // Max + Max

        // Finish simulation
        $display("All test cases completed.");
        $finish;
    end

endmodule


