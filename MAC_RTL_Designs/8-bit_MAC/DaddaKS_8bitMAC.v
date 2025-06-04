module DaddaKS_8bitMAC(
    input [7:0] a,          // 8-bit input A
    input [7:0] b,          // 8-bit input B
    input clk,
    input rst,
    input cin,              // Carry-in for the adder
    output reg [15:0] out,  // 16-bit output
    output cout             // Carry-out from the adder
);

    wire [15:0] out1;       // Output from the 8-bit Vedic multiplier
    wire [15:0] sum;

    // Instantiate 8-bit Vedic multiplier
    Dadda_Mult8_1 g1 (
        .a(a),
        .b(b),
        .out(out1)
    );

    // Instantiate 16-bit Kogge-Stone adder
    Kogge_stone_16bitt g2 (
        .a(out1),
        .b(out),
        .cin(cin),
        .s(sum),
        .cout(cout)
    );

    // Register output with synchronous reset
    always @(posedge clk or posedge rst) begin
        if (rst)
            out <= 16'h0;  // Reset to 16-bit zero
        else
            out <= sum;    // Update output with adder result
    end
endmodule
