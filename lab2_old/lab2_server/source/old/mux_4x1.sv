module mux_4x1(
    input logic [1:0] sel,
    input logic [3:0] in,
    output logic out
    );

    logic mux1_output;
    logic mux2_output;

    mux_2x1 mux_lo (
        .sel (sel[0]),
        .in (in[1:0]),
        .out (mux1_output)
    );

    mux_2x1 mux_hi (
        .sel (sel[0]),
        .in (in[3:2]),
        .out (mux2_output)
    );

    mux_2x1 mux_top (
        .sel (sel[1]),
        .in ({mux2_output, mux1_output}),
        .out (out)
    );


endmodule


// Build and run commands
// // 1. Compile:
// // xvlog -sv source/mux_4x1.sv tb/mux_4x1_tb.sv

// // 2. Create simulation snapsho
// // xelab mux_4x1_tb -s mux_4x1_tb_sim -debug typical

// // 3. Run simulation image
// // xsim mux_4x1_tb_sim -R