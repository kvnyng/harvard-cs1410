`timescale 1ns / 1ps
`include "cpu.svh"

// Sign extender module
// Extends a 16-bit signed immediate value to 32 bits
// For MIPS: replicates the sign bit (bit 15) into the upper 16 bits
module sign_extend (
    input logic [15:0] imm_16,
    output logic [31:0] imm_32
);

    // Sign extension: replicate the sign bit (MSB) to fill upper 16 bits
    // If imm_16[15] == 0 (positive), upper bits are 0
    // If imm_16[15] == 1 (negative), upper bits are 1
    assign imm_32 = {{16{imm_16[15]}}, imm_16[15:0]};

endmodule


