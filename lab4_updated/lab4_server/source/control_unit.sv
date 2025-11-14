// File for defining the control unit for the MIPS processor

`timescale 1ns / 1ps
`include "cpu.svh"

module control_unit
    (
        input logic clk,
        input logic [5:0] opcode,
        input logic [5:0] funct,

        output logic PCWrite,
        output logic Branch,
        output logic PCSrc,
        output logic [3:0] ALUControl,
        output logic [1:0] ALUSrcB,
        output logic ALUSrcA,
        output logic RegWrite,
        output logic IorD,
        output logic MemWrite,
        output logic IRWrite,
        output logic MemToReg,
        output logic RegDst
    );

    // State definitions
    typedef enum {
        S0_INST_FETCH,
        S1_INST_DECODE,
        S2_EXECUTE_RTYPE,
        S3_RTYPE_WRITEBACK
    } state_t;

    state_t current_state, next_state;

    // State register
    always_ff @(posedge clk) begin
        current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            S0_INST_FETCH: begin
                next_state = S1_INST_DECODE;
            end
            S1_INST_DECODE: begin
                if (opcode == `OP_RTYPE) begin
                    next_state = S2_EXECUTE_RTYPE;
                end else begin
                    // For now, only handle R-type, stay in decode or go back to fetch
                    next_state = S0_INST_FETCH;
                end
            end
            S2_EXECUTE_RTYPE: begin
                next_state = S3_RTYPE_WRITEBACK;
            end
            S3_RTYPE_WRITEBACK: begin
                next_state = S0_INST_FETCH;
            end
            default: begin
                next_state = S0_INST_FETCH;
            end
        endcase
    end

    // Function to map funct field to ALU op code
    function logic [3:0] funct_to_alu_op(input logic [5:0] funct);
        case (funct)
            `F_AND: funct_to_alu_op = `ALU_AND;
            `F_OR:  funct_to_alu_op = `ALU_OR;
            `F_XOR: funct_to_alu_op = `ALU_XOR;
            `F_NOR: funct_to_alu_op = `ALU_NOR;
            `F_ADD: funct_to_alu_op = `ALU_ADD;
            `F_SUB: funct_to_alu_op = `ALU_SUB;
            `F_SLT: funct_to_alu_op = `ALU_SLT;
            `F_SLL: funct_to_alu_op = `ALU_SLL;
            `F_SRL: funct_to_alu_op = `ALU_SRL;
            `F_SRA: funct_to_alu_op = `ALU_SRA;
            default: funct_to_alu_op = `ALU_ADD;
        endcase
    endfunction

    // Output logic
    always_comb begin
        // Default values
        PCWrite = 1'b0;
        Branch = 1'b0;
        PCSrc = 1'b0;
        ALUControl = `ALU_ADD;
        ALUSrcB = 2'b00;
        ALUSrcA = 1'b0;
        RegWrite = 1'b0;
        IorD = 1'b0;
        MemWrite = 1'b0;
        IRWrite = 1'b0;
        MemToReg = 1'b0;
        RegDst = 1'b0;

        case (current_state)
            S0_INST_FETCH: begin
                // S0: Instruction Fetch
                IorD = 1'b0;
                ALUSrcA = 1'b0;
                ALUSrcB = 2'b01;
                ALUControl = `ALU_ADD;
                PCSrc = 1'b0;  // PCSrc = 00 (assuming 0 means PC+4)
                IRWrite = 1'b1;
                PCWrite = 1'b1;
            end
            S1_INST_DECODE: begin
                // S1: Instruction Decode
                ALUSrcA = 1'b0;
                ALUSrcB = 2'b11;
                ALUControl = `ALU_ADD;
            end
            S2_EXECUTE_RTYPE: begin
                // S2: Execute R-Type
                ALUSrcA = 1'b1;
                ALUSrcB = 2'b00;
                ALUControl = funct_to_alu_op(funct);
            end
            S3_RTYPE_WRITEBACK: begin
                // S3: R-Type Writeback
                RegDst = 1'b1;
                MemToReg = 1'b0;  // MemtoReg = 0 (select ALU result, not memory data)
                RegWrite = 1'b1;
            end
            default: begin
                // Default: same as S0
                IorD = 1'b0;
                ALUSrcA = 1'b0;
                ALUSrcB = 2'b01;
                ALUControl = `ALU_ADD;
                PCSrc = 1'b0;
                IRWrite = 1'b1;
                PCWrite = 1'b1;
            end
        endcase
    end

endmodule