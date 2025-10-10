`include "alu.svh"
`timescale 1ns/1ps

// =============================================================================
// 32-BIT ARITHMETIC LOGIC UNIT (ALU)
// =============================================================================
// 
// This module implements a 32-bit ALU supporting the following operations:
// - AND: 32-bit bitwise AND
// - ADD: 32-bit signed addition using carry look-ahead adder (CLA)
// - SUB: 32-bit signed subtraction using carry look-ahead adder (CLA)
// - SLT: Set Less Than using MSB XOR overflow logic
// - SRL: Shift Right Logical (zero-fill)
// - SRA: Shift Right Arithmetic (sign-fill)
// - SLL: Shift Left Logical (zero-fill)
// 
// ADDER IMPLEMENTATIONS:
// - Ripple-Carry Adder (RCA): Available but commented out for comparison
// - Carry Look-Ahead Adder (CLA): Currently active implementation
//   * Computes all carries in parallel for faster addition
//   * Uses generate and propagate signals for true carry look-ahead
//   * Eliminates carry propagation delay compared to RCA
// 
// The ALU also generates three flags:
// - zero: Set when result is zero (for all operations except 3'b111)
// - equal: Set when inputs are equal (for all operations except 3'b111)
// - overflow: Set for signed overflow in ADD/SUB operations
// =============================================================================

module STUDENT_alu
(
    input logic [31:0] x,               // First operand
    input logic [31:0] y,               // Second operand
    input logic [2:0] op,               // 3-bit operation code
    output logic [31:0] z,              // 32-bit result
    output logic zero, equal, overflow  // Status flags
);

    // =========================================================================
    // OPERATION OUTPUT SIGNALS
    // =========================================================================
    // Each operation produces its own 32-bit result that gets selected by the
    // output multiplexer based on the operation code.
    
    logic [31:0] z_and;  // AND operation result
    logic [31:0] z_add;  // ADD operation result
    logic [31:0] z_sub;  // SUB operation result
    logic [31:0] z_slt;  // SLT operation result
    logic [31:0] z_srl;  // SRL operation result
    logic [31:0] z_sra;  // SRA operation result
    logic [31:0] z_sll;  // SLL operation result

    // =========================================================================
    // LOGICAL OPERATIONS
    // =========================================================================

    // AND Operation: 32-bit bitwise AND
    and32 and_unit (.x(x), .y(y), .z(z_and));

    // =========================================================================
    // RIPPLE-CARRY ADDER (RCA) IMPLEMENTATION
    // =========================================================================
    // The following RCA implementation is commented out but available for comparison.
    // RCA characteristics:
    // - Sequential carry propagation from LSB to MSB
    // - Simple implementation with predictable timing
    // - Higher delay due to carry chain propagation
    // - Suitable for smaller bit widths or when area is more important than speed

    // // ADD Operation: 32-bit signed addition using ripple-carry adder
    // logic carry_out_add, overflow_add;
    // rca32 adder_unit (
    //     .a(x), 
    //     .b(y), 
    //     .carry_in(1'b0), 
    //     .sum(z_add), 
    //     .carry_out(carry_out_add), 
    //     .overflow(overflow_add)
    // );

    // // SUB Operation: 32-bit signed subtraction using two's complement
    // // Implementation: x - y = x + (~y + 1) = x + ~y + 1
    // logic carry_out_sub, overflow_sub;
    // logic [31:0] y_twos_complement;
    // not32 not_unit (.x(y), .z(y_twos_complement));
    // rca32 subtractor_unit (
    //     .a(x), 
    //     .b(y_twos_complement), 
    //     .carry_in(1'b1), 
    //     .sum(z_sub), 
    //     .carry_out(carry_out_sub), 
    //     .overflow(overflow_sub)
    // );

    // =========================================================================
    // CARRY LOOK-AHEAD ADDER (CLA) IMPLEMENTATION
    // =========================================================================
    // The following CLA implementation is currently active and provides:
    // - Parallel carry computation for all bit positions
    // - Faster addition compared to RCA due to reduced carry propagation delay
    // - Uses generate (G) and propagate (P) signals for true carry look-ahead
    // - More complex logic but better performance for 32-bit operations
    // - CLA equation: C[i] = G[i-1] + P[i-1] * C[i-1]

    // ADD Operation: 32-bit signed addition using carry look-ahead adder
    logic carry_out_add, overflow_add;
    cla cla_unit (
        .a(x), 
        .b(y), 
        .carry_in(1'b0), 
        .sum(z_add), 
        .carry_out(carry_out_add), 
        .overflow(overflow_add)
    );

    // SUB Operation: 32-bit signed subtraction using carry look-ahead adder
    // Implementation: x - y = x + (~y + 1) = x + ~y + 1
    logic carry_out_sub, overflow_sub;
    logic [31:0] y_twos_complement;
    not32 not_unit (.x(y), .z(y_twos_complement));
    cla cla_unit_sub (
        .a(x), 
        .b(y_twos_complement), 
        .carry_in(1'b1), 
        .sum(z_sub), 
        .carry_out(carry_out_sub), 
        .overflow(overflow_sub)
    );


    // SLT Operation: Set Less Than using MSB XOR overflow logic
    // Uses the MSB and overflow from the subtractor to implement SLT
    slt_32bit slt_unit (.msb(z_sub[31]), .overflow(overflow_sub), .result(z_slt));

    // =========================================================================
    // SHIFT OPERATIONS
    // =========================================================================

    // SRL Operation: Shift Right Logical (zero-fill)
    srl srl_unit (.x(x), .y(y), .z(z_srl));

    // SRA Operation: Shift Right Arithmetic (sign-fill)
    sra sra_unit (.x(x), .y(y), .z(z_sra));

    // SLL Operation: Shift Left Logical (zero-fill)
    sll sll_unit (.x(x), .y(y), .z(z_sll));

    // =========================================================================
    // OUTPUT SELECTION
    // =========================================================================
    // 8:1 multiplexer selects the appropriate operation result based on op code
    // Input order: {32'd0, z_sll, z_sra, z_srl, z_slt, z_sub, z_add, z_and}
    // Corresponds to op codes: 111, 110, 101, 100, 011, 010, 001, 000
    
    mux_8x32 mux_8x32_inst (
        .in({32'd0, z_sll, z_sra, z_srl, z_slt, z_sub, z_add, z_and}), 
        .sel(op), 
        .out(z)
    );

    // =========================================================================
    // FLAG GENERATION
    // =========================================================================

    // Overflow Flag: Set for signed overflow in ADD/SUB operations
    // Input order matches op codes: {111, 110, 101, 100, 011, 010, 001, 000}
    mux_8x1 mux_8x1_overflow_inst (
        .in({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, overflow_sub, overflow_add, 1'b0}), 
        .sel(op), 
        .out(overflow)
    );

    // Zero and Equal Flags: Set for all operations except 3'b111
    // If op code is 3'b111, flags are set to 0; otherwise, they reflect the operation result
    
    logic op_is_111;
    and and_gate_op_is_111 (op_is_111, op[2], op[1], op[0]);

    wire zero_out, equal_out;
    assign zero_out = (z == 32'd0);  // Zero flag: result is zero
    assign equal_out = (x == y);     // Equal flag: inputs are equal
    
    mux_2x1 mux_2x1_zero_inst (.in({1'b0, zero_out}), .sel(op_is_111), .out(zero));
    mux_2x1 mux_2x1_equal_inst (.in({1'b0, equal_out}), .sel(op_is_111), .out(equal));

endmodule