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

// xvlog -sv source/and32.sv tb/and32_tb.sv

// xelab and32_tb -s and32_tb_sim -debug typical

// xsim and32_tb_sim -R