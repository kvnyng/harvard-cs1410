/*
 * =============================================================================
 * ADDER MODULES - GATE-LEVEL IMPLEMENTATION
 * =============================================================================
 * 
 * This file contains gate-level implementations of:
 * 1. half_adder: 1-bit adder without carry input
 * 2. full_adder: 1-bit adder with carry input
 * 3. rca32: 32-bit ripple-carry adder
 * 
 * All modules use only basic gates (AND, OR, XOR) as required by specifications.
 * =============================================================================
 */

// Half Adder: Adds two 1-bit inputs, produces sum and carry
module half_adder (
    input  logic a,           // First input bit
    input  logic b,           // Second input bit
    output logic sum,         // Sum output (a XOR b)
    output logic carry        // Carry output (a AND b)
);

    // Sum = a XOR b
    xor sum_gate (sum, a, b);
    
    // Carry = a AND b  
    and carry_gate (carry, a, b);

endmodule

// Full Adder: Adds two 1-bit inputs with carry input
module full_adder (
    input  logic a,           // First input bit
    input  logic b,           // Second input bit  
    input  logic carry_in,    // Carry input from previous stage
    output logic sum,         // Sum output
    output logic carry_out    // Carry output
);

    // Internal signals for intermediate calculations
    logic a_xor_b;            // a XOR b
    logic a_and_b;            // a AND b
    logic xor_result_and_cin; // (a XOR b) AND carry_in

    // Calculate a XOR b
    xor xor_ab_gate (a_xor_b, a, b);
    
    // Calculate a AND b
    and and_ab_gate (a_and_b, a, b);

    // Sum = (a XOR b) XOR carry_in
    xor sum_gate (sum, a_xor_b, carry_in);
    
    // Calculate (a XOR b) AND carry_in
    and and_cin_gate (xor_result_and_cin, a_xor_b, carry_in);

    // Carry out = (a AND b) OR ((a XOR b) AND carry_in)
    or carry_out_gate (carry_out, a_and_b, xor_result_and_cin);
    
endmodule

// 32-bit Ripple-Carry Adder
module rca32 (
    input  logic [31:0] a,        // First 32-bit input
    input  logic [31:0] b,        // Second 32-bit input
    input  logic        carry_in, // Initial carry input
    output logic [31:0] sum,      // 32-bit sum output
    output logic        carry_out,// Final carry output
    output logic        overflow  // Overflow flag for signed arithmetic
);

    // Carry chain: 33 bits to handle carry propagation
    logic [32:0] carry_chain;

    // Initialize carry chain with input carry
    assign carry_chain[0] = carry_in;

    // Generate 32 full adders in a ripple-carry configuration
    genvar i;
    generate 
        for (i = 0; i < 32; i = i + 1) begin : gen_full_adders
            full_adder fa_stage (
                .a        (a[i]),              // Input a bit i
                .b        (b[i]),              // Input b bit i  
                .carry_in (carry_chain[i]),    // Carry from previous stage
                .sum      (sum[i]),            // Sum bit i
                .carry_out(carry_chain[i+1])   // Carry to next stage
            );
        end
    endgenerate

    // Final carry output is the carry from the last stage
    assign carry_out = carry_chain[32];
    
    // Overflow detection for signed arithmetic:
    // Overflow occurs when carry into MSB differs from carry out of MSB
    xor overflow_gate (overflow, carry_chain[31], carry_chain[32]);

endmodule