module mux_8x1(
    input logic [2:0] sel,
    input logic [7:0] in,
    output logic out
    );

    logic mux1_output;
    logic mux2_output;

    mux_4x1 mux_4x1_lo (
        .sel (sel[1:0]),
        .in (in[3:0]),
        .out (mux1_output)
    );

    mux_4x1 mux_4x1_hi (
        .sel (sel[1:0]),
        .in (in[7:4]),
        .out (mux2_output)
    );

    mux_2x1 mux_2x1_top (
        .sel (sel[2]),
        .in ({mux2_output, mux1_output}),
        .out (out)
    )
endmodule


// # recompile ALL modules explicitly (order doesn’t matter but include all)
// xvlog -sv source/mux_2x1.sv source/mux_4x1.sv source/mux_8x1.sv tb/mux_8x1_tb.sv

// # elaborate + run
// xelab mux_8x1_tb -s mux_8x1_tb_sim -debug typical
// xsim mux_8x1_tb_sim -R