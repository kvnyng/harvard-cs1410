`timescale 1ns/1ps

// 32-bit Carry Look-Ahead Adder
// Simplified implementation using generate blocks for repetitive logic
module cla
(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic carry_in,
    output logic [31:0] sum,
    output logic carry_out,
    output logic overflow
);

    // Generate and propagate signals for each bit
    logic [31:0] generate_out, propagate_out;
    
    // Internal carry signals
    logic [32:0] internal_carry; // 33 bits to include carry_in and carry_out
    
    // Initialize carry_in
    assign internal_carry[0] = carry_in;
    
    // Compute generate and propagate for each bit
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : gen_gp
            // Generate: G[i] = A[i] AND B[i]
            and and_gate (generate_out[i], a[i], b[i]);
            
            // Propagate: P[i] = A[i] XOR B[i]
            xor xor_gate (propagate_out[i], a[i], b[i]);
        end
    endgenerate
    
    // Carry Look-Ahead Logic using generate blocks
    // C[i] = G[i-1] + P[i-1] * C[i-1] for i = 1 to 32
    genvar j;
    generate
        for (j = 1; j <= 32; j = j + 1) begin : gen_carry
            logic temp_carry;
            and and_gate_c (temp_carry, propagate_out[j-1], internal_carry[j-1]);
            or or_gate_c (internal_carry[j], generate_out[j-1], temp_carry);
        end
    endgenerate
    
    // Compute sum for each bit: S[i] = P[i] XOR C[i]
    genvar k;
    generate
        for (k = 0; k < 32; k = k + 1) begin : gen_sum
            xor xor_gate_sum (sum[k], propagate_out[k], internal_carry[k]);
        end
    endgenerate
    
    // Final carry out
    assign carry_out = internal_carry[32];

    // Overflow detection for signed arithmetic:
    // Overflow occurs when carry into MSB differs from carry out of MSB
    xor overflow_gate (overflow, internal_carry[31], internal_carry[32]);
    
endmodule