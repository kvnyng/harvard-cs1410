`timescale 1ns/1ps

module cla
(
    input logic a,
    input logic b,
    input logic carry_in,
    output logic sum,
    output logic carry_out,
    output logic overflow,
    output logic generate_out,
    output logic propagate_out
);
    and and_gate (generate_out, a, b);
    xor xor_gate (propagate_out, a, b);
    xor sum_gate (sum, propagate_out, carry_in);
    logic temp_carry;
    and and_carry_out_gate (temp_carry, generate_out, carry_in);
    or or_carry_out_gate (carry_out, generate_out, temp_carry);
    xor overflow_gate (overflow, generate_out, carry_out);
endmodule

module cla4
(
    input logic [3:0] a,
    input logic [3:0] b,
    input logic carry_in,
    output logic [3:0] sum,
    output logic carry_out,
    output logic overflow,
    output logic generate_out,
    output logic propagate_out
);

    // Individual generate and propagate signals for each bit
    logic [3:0] g, p;
    
    // Calculate individual generate and propagate signals using generate loops
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : gen_gp
            and and_g (g[i], a[i], b[i]);
            xor xor_p (p[i], a[i], b[i]);
        end
    endgenerate
    
    // Calculate carry signals using carry look-ahead logic with generate loops
    logic [4:0] c;
    assign c[0] = carry_in;
    
    // For each carry signal c[i], we need to calculate:
    // c[i] = g[i-1] | (p[i-1] & g[i-2]) | (p[i-1] & p[i-2] & g[i-3]) | ... | (p[i-1] & p[i-2] & ... & p[0] & c[0])
    // We can use generate loops to create the AND terms for each carry signal
    
    // c[1] = g[0] | (p[0] & c[0])
    logic temp_c1;
    and and_c1 (temp_c1, p[0], c[0]);
    or or_c1 (c[1], g[0], temp_c1);
    
    // c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c[0])
    logic [1:0] temp_c2_terms;
    and and_c2_1 (temp_c2_terms[0], p[1], g[0]);
    and and_c2_2 (temp_c2_terms[1], p[1], p[0], c[0]);
    logic temp_c2_or;
    or or_c2_1 (temp_c2_or, temp_c2_terms[0], temp_c2_terms[1]);
    or or_c2 (c[2], g[1], temp_c2_or);
    
    // c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c[0])
    logic [2:0] temp_c3_terms;
    and and_c3_1 (temp_c3_terms[0], p[2], g[1]);
    and and_c3_2 (temp_c3_terms[1], p[2], p[1], g[0]);
    and and_c3_3 (temp_c3_terms[2], p[2], p[1], p[0], c[0]);
    logic [1:0] temp_c3_or_level1;
    or or_c3_1 (temp_c3_or_level1[0], temp_c3_terms[0], temp_c3_terms[1]);
    or or_c3_2 (temp_c3_or_level1[1], temp_c3_or_level1[0], temp_c3_terms[2]);
    or or_c3 (c[3], g[2], temp_c3_or_level1[1]);
    
    // c[4] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & c[0])
    logic [3:0] temp_c4_terms;
    and and_c4_1 (temp_c4_terms[0], p[3], g[2]);
    and and_c4_2 (temp_c4_terms[1], p[3], p[2], g[1]);
    and and_c4_3 (temp_c4_terms[2], p[3], p[2], p[1], g[0]);
    and and_c4_4 (temp_c4_terms[3], p[3], p[2], p[1], p[0], c[0]);
    logic [1:0] temp_c4_or_level1;
    or or_c4_1 (temp_c4_or_level1[0], temp_c4_terms[0], temp_c4_terms[1]);
    or or_c4_2 (temp_c4_or_level1[1], temp_c4_terms[2], temp_c4_terms[3]);
    logic temp_c4_or_level2;
    or or_c4_3 (temp_c4_or_level2, temp_c4_or_level1[0], temp_c4_or_level1[1]);
    or or_c4 (c[4], g[3], temp_c4_or_level2);
    
    // Calculate sum using the carry signals with generate loop
    generate
        for (i = 0; i < 4; i = i + 1) begin : gen_sum
            xor xor_sum (sum[i], p[i], c[i]);
        end
    endgenerate
    
    // Final carry out
    assign carry_out = c[4];
    
    // Overflow detection for signed arithmetic using gate-level primitives
    logic a3_eq_b3, sum3_ne_a3;
    xnor xnor_overflow_1 (a3_eq_b3, a[3], b[3]);
    xor xor_overflow_2 (sum3_ne_a3, sum[3], a[3]);
    and and_overflow (overflow, a3_eq_b3, sum3_ne_a3);

    // Calculate the generate and propagate signals using gate-level primitives
    // For a 4-bit CLA, the overall generate is when all bits generate (AND of all individual generates)
    // The overall propagate is when any bit propagates (OR of all individual propagates)
    logic temp_gen_1, temp_gen_2;
    and and_gen_1 (temp_gen_1, g[0], g[1]);
    and and_gen_2 (temp_gen_2, g[2], g[3]);
    and and_gen_out (generate_out, temp_gen_1, temp_gen_2);
    
    logic temp_prop_1, temp_prop_2;
    or or_prop_1 (temp_prop_1, p[0], p[1]);
    or or_prop_2 (temp_prop_2, p[2], p[3]);
    or or_prop_out (propagate_out, temp_prop_1, temp_prop_2);
endmodule

module cla16
(
    input logic [15:0] a,
    input logic [15:0] b,
    input logic carry_in,
    output logic [15:0] sum,
    output logic carry_out,
    output logic overflow,
    output logic generate_out,
    output logic propagate_out
);

    // Individual generate and propagate signals for each 4-bit group
    logic [3:0] g, p;
    
    // Internal carry signals for each cla4 module (calculated using tree structure)
    logic [4:0] c;
    assign c[0] = carry_in;
    
    // Instantiate 4 cla4 modules using generate loop
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : gen_cla16
            cla4 cla4_unit (
                .a(a[i*4+3:i*4]),
                .b(b[i*4+3:i*4]),
                .carry_in(c[i]),
                .sum(sum[i*4+3:i*4]),
                .carry_out(c[i+1]), // Use ripple carry between cla4 modules
                .overflow(), // Not used - we calculate overflow at the top level
                .generate_out(g[i]),
                .propagate_out(p[i])
            );
        end
    endgenerate
    
    // Final carry out
    assign carry_out = c[4];
    
    // Overflow detection for signed arithmetic using gate-level primitives
    logic a15_eq_b15, sum15_ne_a15;
    xnor xnor_overflow_1 (a15_eq_b15, a[15], b[15]);
    xor xor_overflow_2 (sum15_ne_a15, sum[15], a[15]);
    and and_overflow (overflow, a15_eq_b15, sum15_ne_a15);

    // Calculate the overall generate and propagate signals using gate-level primitives
    // For a 16-bit CLA, the overall generate is when all 4-bit groups generate (AND of all individual generates)
    // The overall propagate is when any 4-bit group propagates (OR of all individual propagates)
    logic [1:0] temp_gen, temp_prop;
    
    // Generate signals: AND of all groups
    genvar j;
    generate
        for (j = 0; j < 2; j = j + 1) begin : gen_gen_level1
            and and_gen_level1 (temp_gen[j], g[j*2], g[j*2+1]);
        end
    endgenerate
    and and_gen_out (generate_out, temp_gen[0], temp_gen[1]);
    
    // Propagate signals: OR of all groups
    generate
        for (j = 0; j < 2; j = j + 1) begin : gen_prop_level1
            or or_prop_level1 (temp_prop[j], p[j*2], p[j*2+1]);
        end
    endgenerate
    or or_prop_out (propagate_out, temp_prop[0], temp_prop[1]);
endmodule

module cla32
(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic carry_in,
    output logic [31:0] sum,
    output logic carry_out,
    output logic overflow,
    output logic generate_out,
    output logic propagate_out
);

    // Individual generate and propagate signals for each 16-bit group
    logic [1:0] g, p;
    
    // Internal carry signals for each cla16 module
    logic [2:0] c;
    assign c[0] = carry_in;
    
    // Instantiate 2 cla16 modules using generate loop
    genvar i;
    generate
        for (i = 0; i < 2; i = i + 1) begin : gen_cla32
            cla16 cla16_unit (
                .a(a[i*16+15:i*16]),
                .b(b[i*16+15:i*16]),
                .carry_in(c[i]),
                .sum(sum[i*16+15:i*16]),
                .carry_out(c[i+1]), 
                .overflow(), 
                .generate_out(g[i]),
                .propagate_out(p[i])
            );
        end
    endgenerate
    
    // Final carry out
    assign carry_out = c[2];
    
    // Overflow detection for signed arithmetic using gate-level primitives
    logic a31_eq_b31, sum31_ne_a31;
    xnor xnor_overflow_1 (a31_eq_b31, a[31], b[31]);
    xor xor_overflow_2 (sum31_ne_a31, sum[31], a[31]);
    and and_overflow (overflow, a31_eq_b31, sum31_ne_a31);

    // Calculate the overall generate and propagate signals using gate-level primitives
    // For a 32-bit CLA, the overall generate is when all 16-bit groups generate (AND of all individual generates)
    // The overall propagate is when any 16-bit group propagates (OR of all individual propagates)
    and and_gen_32 (generate_out, g[0], g[1]);
    or or_prop_32 (propagate_out, p[0], p[1]);
endmodule
