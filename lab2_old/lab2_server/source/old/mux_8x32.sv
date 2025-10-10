module mux_32x8 
(
    input  logic [7:0][31:0] in,   // 8 inputs, each 32 bits wide
    input  logic [2:0]       sel,  // selects one of the 8 inputs
    output logic [31:0]      out   // 32-bit output
);

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : gen_mux
            mux_8x1 u (
                .in  ({in[7][i], in[6][i], in[5][i], in[4][i],
                       in[3][i], in[2][i], in[1][i], in[0][i]}),
                .sel (sel),
                .out (out[i])
            );
        end
    endgenerate

endmodule