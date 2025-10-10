module is_zero32 (
    input  logic [31:0] x,
    output logic        zero
);
    // OR-reduce x with a balanced tree, then invert
    logic [15:0] l1;
    logic [7:0]  l2;
    logic [3:0]  l3;
    logic [1:0]  l4;
    logic        l5;

    genvar i;

    // Level 1: 32 -> 16
    generate
        for (i = 0; i < 16; i = i + 1) begin : gen_l1
            or u_or (l1[i], x[2*i], x[2*i+1]);
        end
    endgenerate

    // Level 2: 16 -> 8
    generate
        for (i = 0; i < 8; i = i + 1) begin : gen_l2
            or u_or (l2[i], l1[2*i], l1[2*i+1]);
        end
    endgenerate

    // Level 3: 8 -> 4
    generate
        for (i = 0; i < 4; i = i + 1) begin : gen_l3
            or u_or (l3[i], l2[2*i], l2[2*i+1]);
        end
    endgenerate

    // Level 4: 4 -> 2
    generate
        for (i = 0; i < 2; i = i + 1) begin : gen_l4
            or u_or (l4[i], l3[2*i], l3[2*i+1]);
        end
    endgenerate

    // Level 5: 2 -> 1 (final OR of all bits)
    or  u_or_final (l5, l4[0], l4[1]);

    // zero = ~(|x)
    not u_not (zero, l5);
endmodule