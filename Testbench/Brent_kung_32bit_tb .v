`timescale 1ns / 1ps

module Brent_kung_32bit_tb;

    // Inputs
    reg [31:0] a;
    reg [31:0] b;
    reg cin;

    // Outputs
    wire [31:0] s;
    wire cout;

    // Instantiate the Brent-Kung 32-bit adder
    Brent_kung_32bitt uut (
        .a(a),
        .b(b),
        .cin(cin),
        .s(s),
        .cout(cout)
    );

    // Expected result (33-bit to hold carry out)
    reg [32:0] expected_sum;

    // Task for applying a test
    task apply_test(input [31:0] in_a, input [31:0] in_b);
    begin
        a = in_a;
        b = in_b;
        cin = 0;  // only cin = 0 as you requested
        expected_sum = a + b;
        #10;  // wait for the adder to compute

        $display("a=%h b=%h cin=%b -> s=%h cout=%b | expected=%h",
                  a, b, cin, s, cout, expected_sum);

        if ({cout, s} === expected_sum) begin
            $display("PASS ?");
        end else begin
            $display("FAIL ? Expected=%h Got s=%h cout=%b",
                     expected_sum, s, cout);
        end
    end
    endtask

    initial begin
        $display("Starting Brent-Kung 32-bit adder tests (cin = 0)...");

        // Test cases
        apply_test(32'h0000_1234, 32'h0000_5678);
        apply_test(32'h89AB_CDEF, 32'h7654_3210);
        apply_test(32'h0F0F_0F0F, 32'hF0F0_F0F0);
        apply_test(32'h1234_5678, 32'h2345_6789);
        apply_test(32'hDEAD_BEEF, 32'hCAFEBABE);
        apply_test(32'h0000_0000, 32'hFFFFFFFF);
        apply_test(32'h1357_9BDF, 32'h2468_ACF0);
        apply_test(32'hAAAA_AAAA, 32'h5555_5555);
        apply_test(32'h7FFF_FFFF, 32'h0000_0001);
        apply_test(32'hFFFF_FFFF, 32'hFFFF_FFFF);

        $display("All tests completed.");
        $finish;
    end

endmodule
