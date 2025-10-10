`timescale 1ns / 1ps

module slt(
    input  wire [31:0] s_sub,
    input  wire        ovf_sub,
    output wire        z
    );
    wire set;

    xor u_set(set, s_sub[31], ovf_sub);
    buf b0(z[0], set);

    genvar i;
    generate
        for (i=1; i<32; i=i+1) begin: g
            buf bi(z[i], 1'b0);
        end
    endgenerate
endmodule
