`timescale 1ns/1ps

module slt_32bit(
    input logic msb,           // MSB of the subtraction result
    input logic overflow,      // Overflow flag from the subtraction
    output logic [31:0] result // 32-bit output where LSB is SLT result
);
    
    // SLT logic: if x < y (signed), then SLT = 1, else SLT = 0
    // For signed comparison: SLT = MSB XOR overflow
    // This handles both normal cases and overflow cases correctly
    
    wire slt_result;
    xor xor_gate (slt_result, msb, overflow);
    
    // Fan out the SLT result to all 32 bits
    // LSB gets the actual SLT result, all other bits are 0
    assign result = {31'b0, slt_result};

endmodule