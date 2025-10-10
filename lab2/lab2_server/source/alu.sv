`include "alu.svh"
`timescale 1ns/1ps

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
    logic [31:0] z_add;
    logic [31:0] z_sub;
    logic [31:0] z_slt;
    logic [31:0] z_srl;
    logic [31:0] z_sra;
    logic [31:0] z_sll;

    // Set the z outputs that are not yet implemented to 0
    assign z_srl = 32'd0;
    assign z_sra = 32'd0;
    assign z_sll = 32'd0;

    // AND
    and32 and_unit (.x(x), .y(y), .z(z_and));  // Note the syntax for inputs/outputs to the instantiated module.

    // ADD (RCA)
    // TODO: instantiate adder module
    logic carry_out_add, overflow_add;
    rca32 adder_unit (.a(x), .b(y), .carry_in(1'b0), .sum(z_add), .carry_out(carry_out_add), .overflow(overflow_add));

    // SUB
    // TODO: instantiate subtractor. Can you think of a way to implement the subtractor by reusing the adder module?
    logic carry_out_sub, overflow_sub;
    logic [31:0] y_twos_complement;
    not32 not_unit (.x(y), .z(y_twos_complement));
    rca32 subtractor_unit (.a(x), .b(y_twos_complement), .carry_in(1'b1), .sum(z_sub), .carry_out(carry_out_sub), .overflow(overflow_sub));

    // SLT
    // Use the MSB and overflow from the subtractor to implement SLT
    slt_32bit slt_unit (.msb(z_sub[31]), .overflow(overflow_sub), .result(z_slt));
    
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
    mux_8x32 mux_8x32_inst (.in({32'd0, z_sll, z_sra, z_srl, z_slt, z_sub, z_add, z_and}), .sel(op), .out(z));

    // FLAGS
    // TODO: implement flag logic
    // Overflow based on the add and sub operations
    mux_8x1 mux_8x1_overflow_inst (.in({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, overflow_sub, overflow_add, 1'b0}), .sel(op), .out(overflow));

    // Check if the op code is 3'b111 using AND gates. Then run zero_checker and equal_checker through two 2x1 muxes to select the output.
    logic op_is_111;
    and and_gate_op_is_111 (op_is_111, op[2], op[1], op[0]);

    wire zero_out, equal_out;
    // check_zero32 zero_checker (.z(z), .zero(zero_out));
    // check_equal32 equal_checker (.x(x), .y(y), .equal(equal_out));
    assign zero_out = (z == 32'd0);
    assign equal_out = (x == y);
    
    mux_2x1 mux_2x1_zero_inst (.in({1'b0, zero_out}), .sel(op_is_111), .out(zero));
    mux_2x1 mux_2x1_equal_inst (.in({1'b0, equal_out}), .sel(op_is_111), .out(equal));

endmodule
