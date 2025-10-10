// File containing operations needed to determine the zero and equal flags
`timescale 1ns/1ps

module check_zero32(
    input logic [31:0] z,
    output logic zero
);
    // Use a tree of OR gates that has a depth of 5 to determine if the result is zero that reduce from 32 to 1
    logic [15:0] level2_or;
    logic [7:0] level3_or;
    logic [3:0] level4_or;
    logic [1:0] level5_or;
    
    genvar i;
    // First level: OR pairs of input bits (32 inputs -> 16 outputs)
    generate
        for (i = 0; i < 16; i = i + 1) begin : gen_or_level1
            or or_gate (level2_or[i], z[i*2], z[i*2+1]);
        end
    endgenerate
    
    // Second level: OR pairs from first level (16 inputs -> 8 outputs)
    generate
        for (i = 0; i < 8; i = i + 1) begin : gen_or_level2
            or or_gate (level3_or[i], level2_or[i*2], level2_or[i*2+1]);
        end
    endgenerate
    
    // Third level: OR pairs from second level (8 inputs -> 4 outputs)
    generate
        for (i = 0; i < 4; i = i + 1) begin : gen_or_level3
            or or_gate (level4_or[i], level3_or[i*2], level3_or[i*2+1]);
        end
    endgenerate
    
    // Fourth level: OR pairs from third level (4 inputs -> 2 outputs)
    generate
        for (i = 0; i < 2; i = i + 1) begin : gen_or_level4
            or or_gate (level5_or[i], level4_or[i*2], level4_or[i*2+1]);
        end
    endgenerate
    
    // Fifth level: OR the final two results (2 inputs -> 1 output)
    wire temp_or;
    or or_gate (temp_or, level5_or[0], level5_or[1]);
    
    // If any bit is 1, then temp_or is 1, meaning not zero. So invert for zero flag.
    not not_gate (zero, temp_or);

endmodule

module check_equal32(
    input logic [31:0] x,
    input logic [31:0] y,
    output logic equal
);

    // Use a tree where the first level is of XOR gates and the second level is of OR gates to determine if the result is equal that reduce from 32 to 1
    logic [31:0] x_xor_y;
    logic [15:0] level2_or;
    logic [7:0] level3_or;
    logic [3:0] level4_or;
    logic [1:0] level5_or;
    
    genvar i;
    // First level: XOR gates to compare each bit
    generate
        for (i = 0; i < 32; i = i + 1) begin : gen_xor_level
            xor xor_gate (x_xor_y[i], x[i], y[i]);
        end
    endgenerate
    
    // Second level: OR gates to combine XOR results
    generate
        for (i = 0; i < 16; i = i + 1) begin : gen_or_level1
            or or_gate (level2_or[i], x_xor_y[i*2], x_xor_y[i*2+1]);
        end
    endgenerate
    
    // Third level: OR gates
    generate
        for (i = 0; i < 8; i = i + 1) begin : gen_or_level2
            or or_gate (level3_or[i], level2_or[i*2], level2_or[i*2+1]);
        end
    endgenerate
    
    // Fourth level: OR gates
    generate
        for (i = 0; i < 4; i = i + 1) begin : gen_or_level3
            or or_gate (level4_or[i], level3_or[i*2], level3_or[i*2+1]);
        end
    endgenerate
    
    // Fifth level: OR gates
    generate
        for (i = 0; i < 2; i = i + 1) begin : gen_or_level4
            or or_gate (level5_or[i], level4_or[i*2], level4_or[i*2+1]);
        end
    endgenerate
    
    // Final OR gate - if any XOR result is 1, then inputs are different
    // So we need to invert to get equal flag
    wire temp_or;
    or or_gate (temp_or, level5_or[0], level5_or[1]);
    not not_gate (equal, temp_or);
endmodule