`timescale 1ns / 1ps
`include "cpu.svh"

// Barrel shifter that performs a left shift by 2 bits
// This is equivalent to multiplying by 4
// Input: 32-bit value
// Output: 32-bit value shifted left by 2 positions (lower 2 bits become 0)
module barrel_shifter (
    input logic [31:0] data_in,
    output logic [31:0] data_out
);

    // Left shift by 2 bits: multiply by 4
    // Lower 2 bits become 0, upper 2 bits are lost
    assign data_out = {data_in[29:0], 2'b00};

endmodule


