module ArrayBK_4bitMAC (
    input [3:0] a,            // 4-bit multiplicand
    input [3:0] b,            // 4-bit multiplier
    input clk,
    input rst,
    input cin,                // Initial carry-in
    output reg [7:0] result,  // 8-bit result of MAC operation
    output cout               // Carry-out from adder
);
    wire [7:0] product;       // 8-bit product from multiplier
    wire [7:0] sum;           // 8-bit sum from the adder

    // Instantiate the 4-bit Array Multiplier
    ArrayusingKS array_mult (
        .a(a),
        .b(b),
        .z(product)
    );

    // Instantiate the 8-bit Kogge-Stone Adder
    Brent_kung_8bit BK_adder (
        .a(product),
        .b(result),
        .cin(cin),              // Carry-in to the adder
        .s(sum),
        .cout(cout)             // Carry-out from the adder
    );

    // Always block to update result at each clock edge or reset
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            result <= 8'b0;      // Reset the result to 0
        end else begin
            result <= sum;       // Update result with the sum from adder
        end
    end
endmodule
