module mux_2x1(
    input logic sel,
    input logic [1:0] in,
    output logic out
    );

   logic not_sel;
   logic in0_and_not_sel;
   logic in1_and_sel;

   not u_not (not_sel, sel);
   and u_and0 (in0_and_not_sel, in[0], not_sel);
   and u_and1 (in1_and_sel, in[1], sel);

   or u_or (out, in0_and_not_sel, in1_and_sel);

endmodule


// Build and run commands
// // 1. Compile:
// // xvlog -sv source/mux_2x1.sv tb/mux_tb.sv

// // 2. Create simulation snapsho
// // xelab mux_tb -s mux_tb_sim -debug typical

// // 3. Run simulation image
// // xsim mux_tb_sim -R


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
    );
    
endmodule


// # recompile ALL modules explicitly (order doesn’t matter but include all)
// xvlog -sv source/mux_2x1.sv source/mux_4x1.sv source/mux_8x1.sv tb/mux_8x1_tb.sv

// # elaborate + run
// xelab mux_8x1_tb -s mux_8x1_tb_sim -debug typical
// xsim mux_8x1_tb_sim -R

module mux_2x32 (
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic        sel,
    output logic [31:0] out
);
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : gen_mux
            mux_2x1 u (
                .sel (sel),
                .in  ({b[i], a[i]}),
                .out (out[i])
            );
        end
    endgenerate
endmodule

module mux_8x32
(
    input  logic [7:0][31:0] in,   // 8 inputs, each 32 bits
    input  logic [2:0]       sel,  // select
    output logic [31:0]      out   // 32-bit output
);
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : gen_mux
            // For bit i, feed the 8 input bits in[0][i]..in[7][i] to a mux_8x1
            mux_8x1 u (
                .in  ({in[7][i], in[6][i], in[5][i], in[4][i],
                       in[3][i], in[2][i], in[1][i], in[0][i]}),
                .sel (sel),
                .out (out[i])
            );
        end
    endgenerate
endmodule
