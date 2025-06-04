`timescale 1ns / 1ps

module Wallace_Mult16_tb;

    // Inputs
    reg [15:0] a;
    reg [15:0] b;

    // Output
    wire [31:0] out;

    // Instantiate the Unit Under Test (UUT)
    Wallace_Mult16 uut (
        .a(a),
        .b(b),
        .out(out)
    );

    // Task to perform test
    task test_input;
        input [15:0] a_in;
        input [15:0] b_in;
        reg [31:0] expected;
    begin
        a = a_in;
        b = b_in;
        expected = a_in * b_in;
        #10;  // wait for outputs to stabilize
        if (out !== expected) begin
            $display("ERROR: a = %d, b = %d => Expected = %d, Got = %d", a, b, expected, out);
        end else begin
            $display("PASS: a = %d, b = %d => Output = %d", a, b, out);
        end
    end
    endtask

    initial begin
        // Initialize Inputs
        a = 0;
        b = 0;

        $display("Starting Wallace Tree 16x16 Multiplier Test...");

        // Apply test cases
        test_input(16'd0, 16'd0);
        test_input(16'd1, 16'd1);
        test_input(16'd123, 16'd456);
        test_input(16'd255, 16'd255);
        test_input(16'hFFFF, 16'hFFFF); // Max input values
        test_input(16'd32767, 16'd2);
        test_input(16'd1024, 16'd1024);
        test_input(16'd30000, 16'd3);
        test_input(16'd500, 16'd1000);

        $display("Test completed.");
        $finish;
    end

endmodule

