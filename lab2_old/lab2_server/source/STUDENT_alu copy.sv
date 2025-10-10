`timescale 1ns/1ps
`include "alu.svh"

module STUDENT_alu
    (
        input logic [31:0] x,               // 1st input
        input logic [31:0] y,               // 2nd input
        input logic [2:0] op,               // 3-bit op code
        output logic [31:0] z,              // output
        output logic zero, equal, overflow  // flags
    );


    // TODO Part A -- 8:1 mux, AND, ADD (with ripple-carry adder), SUB, flags, SLT
    // mux is at the bottom of the file.

    // submodule outputs
    logic [31:0] z_and; 

    // AND
    and32 and_unit (.x(x), .y(y), .z(z_and));  // Note the syntax for inputs/outputs to the instantiated module.

    // ADD (RCA)
    logic adder_cout, adder_ovf;
    logic [31:0] adder_s;

    adder u1 (
        .a (x[31:0]),
        .b (y[31:0]),
        .s (adder_s[31:0]),
        .c_out(adder_cout),
        .overflow(adder_ovf)
    );

    // SUB
    logic subber_cout, subber_ovf;
    logic [31:0] subber_s;

    subtractor u2 (
        .a (x[31:0]),
        .b (y[31:0]),
        .s (subber_s[31:0]),
        .c_out(subber_cout),
        .overflow(subber_ovf)
    );

    // SLT
    logic [31:0] slt_out;

    slt u3 (
       .a (x[31:0]),
       .b (y[31:0]),
       .out (slt_out)
    );

    // FLAGS
    // // Creating reserve flag
    logic op0_and_op1, reserve;

    and and1 (op0_and_op1, op[0], op[1]);
    and and2 (reserve, op0_and_op1, op[2]);
    
    // // Overflow
    logic u4_out;
    mux_4x1 u4 (
        .sel (op[1:0]),
        .in ({1'b0, subber_ovf, adder_ovf, 1'b0}),
        .out (u4_out)
    );

    mux_2x1 u5 (
        .sel (op[2]),
        .in ({1'b0, u4_out}),
        .out (overflow)
    );

    // // Equal
    logic u6_out;

    equal32 u6 (
        .a (x[31:0]),
        .b (y[31:0]),
        .eq (u6_out)
    );

    mux_2x1 u7 (
        .sel (reserve),
        .in ({1'b0, u6_out}),
        .out (equal)
    );

    // // Zero
    logic zero_out;

    is_zero32 u8 (
        .x (z[31:0]),
        .zero (zero_out)
    );

    mux_2x1 u9 (
        .sel(reserve),
        .in({1'b0, zero_out}),
        .out (zero)
    );

    // TODO Part B -- SRL, SRA, SLL, ADD (with carry-lookahead adder)

    // SRL
    // TODO: instantiate srl module

    // SRA
    // TODO: instantiate sra module

    // SLL
    // TODO: instantiate sll module

    // ADD (CLA)
    // TODO: instantiate cla adder. Comment out the ripple-carry adder instantiation from Part A



    // MUX 8:1 to select the output z from the submodule outputs
    // The code given here only outputs z_and. How can you condition the output based on the operation?
    // Be sure to use the macros (such as `ALU_AND) for the op codes, as defined in alu.svh. 
    
    // // Build the 8×32 input bus
    mux_8x32 u10 (
        .in  ({
                32'h0000_0000,
                32'h0000_0000,   // sel=6
                32'h0000_0000,   // sel=5
                32'h0000_0000,   // sel=4
                slt_out,         // sel=3
                subber_s,        // sel=2
                adder_s,         // sel=1
                z_and           // sel=0
                }),
        .sel (op),
        .out (z[31:0])
    );
    // and32 and_unit(.x(x), .y(y), .z(z_and));

    // assign z = (op == `ALU_AND) ? z_and : 32'hDEAD_BEEF;

endmodule

// xvlog -sv -i ./source \
//   source/STUDENT_alu.sv source/adder.sv source/alu_top.sv \
//   source/equal32.sv source/mux.sv source/slt.sv \
//   source/zero32.sv source/not32.sv source/and32.sv tb/alu_tb.sv
//  xelab alu_tb -s alu_tb_sim -debug typical
//  xsim alu_tb_sim -R