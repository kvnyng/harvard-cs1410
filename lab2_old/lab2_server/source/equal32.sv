`default_nettype none
module equal32 (
    input  wire [31:0] a,
    input  wire [31:0] b,
    output wire        eq   // 1 if a == b, else 0
);
    wire [31:0] xnor_bits;
    wire [15:0] l2;
    wire [7:0]  l3;
    wire [3:0]  l4;
    wire [1:0]  l5;

    genvar i;

    // Per-bit equality
    generate
        for (i = 0; i < 32; i = i + 1) begin : gen_xnor
            xnor u_xnor (xnor_bits[i], a[i], b[i]);
        end
    endgenerate

    // Balanced AND reduction tree
    generate
        for (i = 0; i < 16; i = i + 1) begin : gen_l2
            and u_and (l2[i], xnor_bits[2*i],   xnor_bits[2*i+1]);
        end
        for (i = 0; i < 8; i = i + 1) begin : gen_l3
            and u_and (l3[i], l2[2*i],         l2[2*i+1]);
        end
        for (i = 0; i < 4; i = i + 1) begin : gen_l4
            and u_and (l4[i], l3[2*i],         l3[2*i+1]);
        end
        for (i = 0; i < 2; i = i + 1) begin : gen_l5
            and u_and (l5[i], l4[2*i],         l4[2*i+1]);
        end
    endgenerate

    and u_final (eq, l5[0], l5[1]);
endmodule
`default_nettype wire