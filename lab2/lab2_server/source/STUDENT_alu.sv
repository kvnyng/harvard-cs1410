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
    // TODO: instantiate adder module

    // SUB
    // TODO: instantiate subtractor. Can you think of a way to implement the subtractor by reusing the adder module?

    // SLT
    // TODO: instantiate slt module


    // FLAGS
    // TODO: implement flag logic



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
    assign z = z_and;
    
endmodule
