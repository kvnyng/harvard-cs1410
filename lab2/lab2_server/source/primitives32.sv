// File containing all the primitives for the ALU
`timescale 1ns/1ps

module and32
(
    input  logic [31:0] x,
    input  logic [31:0] y,
    output wire [31:0] z
);
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : gen_and
            and g (z[i], x[i], y[i]);
        end
    endgenerate
endmodule

module not32
(
    input  logic [31:0] x,
    output logic [31:0] z
);
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : gen_not
            not g (z[i], x[i]);
        end
    endgenerate
endmodule

module or32
(
    input  logic [31:0] x,
    input  logic [31:0] y,
    output logic [31:0] z
);
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : gen_or
            or g (z[i], x[i], y[i]);
        end
    endgenerate
endmodule

