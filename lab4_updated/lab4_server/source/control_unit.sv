// File for defining the control unit for the MIPS processor

`timescale 1ns / 1ps
`include "cpu.svh"

// State definitions (must be before module to use in port list)
typedef enum logic [3:0] {
    S0_FETCH,
    S1_DECODE_WAIT,  // Wait state to allow instruction register to settle
    S1_DECODE,
    S2_ADDR,
    S3_MEMRD,
    S4_MEMWB,
    S5_MEMWR,
    S6_EXEC,
    S7_ALUWB,
    S8_BRANCH,
    S9_EXI,
    S10_WBI,
    S11_JUMP
} state_t;

module control_unit
    (
        input logic clk,
        input logic clk_en,
        input logic rst,
        input logic [5:0] opcode,
        input logic [5:0] funct,

        output logic PCWrite,
        output logic [1:0] PCSrc,
        output logic [3:0] ALUControl,
        output logic [1:0] ALUSrcB,
        output logic ALUSrcA,
        output logic RegWrite,
        output logic IorD,
        output logic MemWrite,
        output logic IRWrite,
        output logic MemToReg,
        output logic RegDst,
        output logic ExtOp,        // Extension operation: 1 = sign extend, 0 = zero extend
        output logic UseShamt,     // Use shamt field for shift instructions
        output logic WriteRA,      // Write return address for JAL
        output logic BranchEQ,     // Branch if equal (BEQ)
        output logic BranchNE,     // Branch if not equal (BNE)
        
        // Debug outputs (use logic to avoid type issues)
        output logic [3:0] dbg_current_state,
        output logic [3:0] dbg_next_state,
        output logic dbg_opcode_has_xz,  // Debug: opcode has X/Z bits
        output logic [5:0] dbg_opcode_raw,  // Debug: raw opcode value
        output logic [3:0] dbg_decode_result,  // Debug: which decode path was taken (0=unknown, 1=rtype, 2=j, 3=jal, 4=branch, 5=itype, 6=mem)
        output logic [3:0] dbg_next_state_before_case,  // Debug: next_state before case statement
        output logic [3:0] dbg_next_state_after_j_check,  // Debug: next_state after J check
        output logic [5:0] dbg_opcode_reg,  // Debug: registered opcode value
        output logic [5:0] dbg_opcode_used,  // Debug: opcode actually used in comparisons
        output logic dbg_opcode_reg_has_xz,  // Debug: registered opcode has X/Z bits
        output logic dbg_isLW,  // Debug: isLW signal value
        output logic dbg_isSW,  // Debug: isSW signal value
        output logic dbg_isR,   // Debug: isR signal value
        output logic dbg_isJR   // Debug: isJR signal value
    );

    state_t s, ns;
    
    // Instruction type detection signals
    logic isR, isSHIFT, isJR, isADDI, isANDI, isORI, isXORI, isSLTI, isALUImm;
    logic isLW, isSW, isBEQ, isBNE, isJ, isJAL;
    
    // State register
    always_ff @(posedge clk or posedge rst) begin
        if (rst) s <= S0_FETCH;
        else if (clk_en) s <= ns;
    end
    
    // Debug signal assignments
    assign dbg_current_state = s[3:0];
    assign dbg_next_state = ns[3:0];
    assign dbg_opcode_raw = opcode;
    assign dbg_opcode_reg = opcode;
    assign dbg_opcode_used = opcode;
    // $isunknown is not synthesizable - set to 0 for synthesis
    // Use simulation-only check: if any bit is X or Z, result is 1
    assign dbg_opcode_has_xz = 1'b0;  // Disabled for synthesis compatibility
    assign dbg_opcode_reg_has_xz = 1'b0;  // Disabled for synthesis compatibility
    assign dbg_isLW = isLW;
    assign dbg_isSW = isSW;
    assign dbg_isR = isR;
    assign dbg_isJR = isJR;
    
    logic [3:0] decode_result;
    always_comb begin
        if (s == S1_DECODE) begin
            if (opcode == `OP_RTYPE && funct == `F_JR) decode_result = 4'd1;  // JR
            else if (opcode == `OP_RTYPE) decode_result = 4'd2;  // R-type
            else if (opcode == `OP_ADDI || opcode == `OP_ANDI || opcode == `OP_ORI || opcode == `OP_XORI || opcode == `OP_SLTI) decode_result = 4'd3;  // I-type ALU
            else if (opcode == `OP_LW || opcode == `OP_SW) decode_result = 4'd4;  // Memory
            else if (opcode == `OP_BEQ || opcode == `OP_BNE) decode_result = 4'd5;  // Branch
            else if (opcode == `OP_J || opcode == `OP_JAL) decode_result = 4'd6;  // Jump
            else decode_result = 4'd0;  // Unknown
        end else begin
            decode_result = 4'd0;
        end
    end
    assign dbg_decode_result = decode_result;
    assign dbg_next_state_before_case = 4'd0;
    assign dbg_next_state_after_j_check = 4'd0;

    // Function to map ALUOp (2-bit) to ALUControl (4-bit)
    // ALUOp encoding:
    // 00: ADD (for PC+4, address calculation)
    // 01: SUB (for branch comparison)
    // 10: R-type (use funct field)
    // 11: I-type (use opcode)
    function logic [3:0] aluop_to_alucontrol(input logic [1:0] aluop, input logic [5:0] funct, input logic [5:0] opcode);
        case (aluop)
            2'b00: aluop_to_alucontrol = `ALU_ADD;  // ADD
            2'b01: aluop_to_alucontrol = `ALU_SUB;  // SUB
            2'b10: begin  // R-type - use funct
                case (funct)
                    `F_AND: aluop_to_alucontrol = `ALU_AND;
                    `F_OR:  aluop_to_alucontrol = `ALU_OR;
                    `F_XOR: aluop_to_alucontrol = `ALU_XOR;
                    `F_NOR: aluop_to_alucontrol = `ALU_NOR;
                    `F_ADD: aluop_to_alucontrol = `ALU_ADD;
                    `F_SUB: aluop_to_alucontrol = `ALU_SUB;
                    `F_SLT: aluop_to_alucontrol = `ALU_SLT;
                    `F_SLL: aluop_to_alucontrol = `ALU_SLL;
                    `F_SRL: aluop_to_alucontrol = `ALU_SRL;
                    `F_SRA: aluop_to_alucontrol = `ALU_SRA;
                    default: aluop_to_alucontrol = `ALU_ADD;
                endcase
            end
            2'b11: begin  // I-type - use opcode
                case (opcode)
                    `OP_ADDI: aluop_to_alucontrol = `ALU_ADD;
                    `OP_ANDI: aluop_to_alucontrol = `ALU_AND;
                    `OP_ORI:  aluop_to_alucontrol = `ALU_OR;
                    `OP_XORI: aluop_to_alucontrol = `ALU_XOR;
                    `OP_SLTI: aluop_to_alucontrol = `ALU_SLT;
                    default:  aluop_to_alucontrol = `ALU_ADD;
                endcase
            end
            default: aluop_to_alucontrol = `ALU_ADD;
        endcase
    endfunction

    // Next state and control signal logic
    always_comb begin
        // Instruction type detection (evaluated first in always_comb)
        isR     = (opcode == `OP_RTYPE);
        isSHIFT = isR && (funct == `F_SLL || funct == `F_SRL || funct == `F_SRA);
        isJR    = isR && (funct == `F_JR);
        isADDI  = (opcode == `OP_ADDI);
        isANDI  = (opcode == `OP_ANDI);
        isORI   = (opcode == `OP_ORI);
        isXORI  = (opcode == `OP_XORI);
        isSLTI  = (opcode == `OP_SLTI);
        isALUImm = isADDI || isANDI || isORI || isXORI || isSLTI;
        isLW    = (opcode == `OP_LW);
        isSW    = (opcode == `OP_SW);
        isBEQ   = (opcode == `OP_BEQ);
        isBNE   = (opcode == `OP_BNE);
        isJ     = (opcode == `OP_J);
        isJAL   = (opcode == `OP_JAL);
        
        // Default: stay in current state
        ns = s;
        
        // Default all control signals to 0
        PCWrite = 0;
        PCSrc = 2'b00;
        ALUControl = `ALU_ADD;
        ALUSrcB = 2'b00;
        ALUSrcA = 0;
        RegWrite = 0;
        IorD = 0;
        MemWrite = 0;
        IRWrite = 0;
        MemToReg = 0;
        RegDst = 0;
        ExtOp = 1;          // Default to sign extend
        UseShamt = 0;       // Default to not using shamt
        WriteRA = 0;        // Default to not writing RA
        BranchEQ = 0;       // Default to no BEQ
        BranchNE = 0;       // Default to no BNE

        unique case (s)
            S0_FETCH: begin
                IorD    = 0;
                ALUSrcA = 0;
                ALUSrcB = 2'b01;
                ALUControl = `ALU_ADD;  // PC + 4
                PCSrc   = 2'b00;
                PCWrite = 1;
                IRWrite = 1;  // Write instruction from memory (read in this cycle)
                ns = S1_DECODE_WAIT;  // Wait one cycle for instruction to settle
            end

            S1_DECODE_WAIT: begin
                ALUSrcA = 0;
                ALUSrcB = 2'b11;
                ALUControl = `ALU_ADD;
                ExtOp = 1;
                ns = S1_DECODE;
            end

            S1_DECODE: begin
                ALUSrcA = 0;
                ALUSrcB = 2'b11;
                ALUControl = `ALU_ADD;
                ExtOp = 1;

                if ((opcode == `OP_RTYPE) && (funct == `F_JR)) begin
                    ns = S11_JUMP;
                end else if (opcode == `OP_RTYPE) begin
                    ns = S6_EXEC;
                end else if ((opcode == `OP_ADDI) || (opcode == `OP_ANDI) || (opcode == `OP_ORI) || (opcode == `OP_XORI) || (opcode == `OP_SLTI)) begin
                    ns = S9_EXI;
                end else if ((opcode == `OP_LW) || (opcode == `OP_SW)) begin
                    ns = S2_ADDR;
                end else if ((opcode == `OP_BEQ) || (opcode == `OP_BNE)) begin
                    ns = S8_BRANCH;
                end else if ((opcode == `OP_J) || (opcode == `OP_JAL)) begin
                    ns = S11_JUMP;
                end else begin
                    ns = S0_FETCH;
                end
            end

            S2_ADDR: begin
                ALUSrcA = 1;
                ALUSrcB = 2'b10;
                ALUControl = `ALU_ADD;
                ExtOp = 1;
                if (isLW) begin
                    ns = S3_MEMRD;
                end else begin
                    ns = S5_MEMWR;
                end
            end

            S3_MEMRD: begin
                IorD = 1;
                ns = S4_MEMWB;
            end

            S4_MEMWB: begin
                IorD = 1;
                ns = S10_WBI;
            end

            S5_MEMWR: begin
                IorD = 1;
                MemWrite = 1;
                ns = S0_FETCH;
            end

            S6_EXEC: begin
                ALUSrcA = 1;
                ALUSrcB = 2'b00;
                ALUControl = aluop_to_alucontrol(2'b10, funct, opcode);
                UseShamt = isSHIFT;
                ns = S7_ALUWB;
            end

            S7_ALUWB: begin
                RegDst   = 1;
                MemToReg = 0;
                RegWrite = 1;
                ns = S0_FETCH;
            end

            S8_BRANCH: begin
                ALUSrcA = 1;
                ALUSrcB = 2'b00;
                ALUControl = `ALU_SUB;
                BranchEQ = isBEQ;
                BranchNE = isBNE;
                PCSrc = 2'b01;
                ns = S0_FETCH;
            end

            S9_EXI: begin
                ALUSrcA = 1;
                ALUSrcB = 2'b10;
                ALUControl = aluop_to_alucontrol(2'b11, funct, opcode);
                ExtOp = ~(isANDI || isORI || isXORI);
                ns = S10_WBI;
            end

            S10_WBI: begin
                RegDst = 0;
                if (isLW) begin
                    MemToReg = 1;
                end else begin
                    MemToReg = 0;
                end
                RegWrite = 1;
                ns = S0_FETCH;
            end

            S11_JUMP: begin
                if (isJR) begin
                    ALUSrcA = 1;
                    ALUSrcB = 2'b00;
                    ALUControl = `ALU_ADD;
                    PCSrc = 2'b11;
                    PCWrite = 1;
                end else begin
                    PCSrc = 2'b10;
                    PCWrite = 1;
                    if (isJAL) begin
                        RegWrite = 1;
                        WriteRA = 1;
                    end
                end
                ns = S0_FETCH;
            end

            default: ns = S0_FETCH;
        endcase
    end
endmodule
