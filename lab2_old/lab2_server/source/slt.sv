`timescale 1ns/1ps
module slt (
    input  logic [31:0] a,
    input  logic [31:0] b,
    output logic [31:0] out   // 000...001 when a<b (signed), else 0
);
    logic [31:0] diff;
    logic        ovf, slt_bit;

    // a - b
    subtractor sub_u (.a(a), .b(b), .s(diff), .overflow(ovf));

    // Signed less-than corrected for ovf:
    assign slt_bit = diff[31] ^ ovf;

    // Widen to all-ones/all-zeros
    assign out = {32{slt_bit}};  // or {31'b0, slt_bit} for LSB-only
endmodule