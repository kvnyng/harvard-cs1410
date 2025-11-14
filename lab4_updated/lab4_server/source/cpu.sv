`timescale 1ns / 1ps
`include "cpu.svh"

module cpu
    # ( parameter DATA_WIDTH = 32, 
        parameter ADDR_WIDTH = 5)
    (
        input logic clk, clk_en, rst,
        input logic [31:0] r_data,  // Memory read data (from external memory)
        output logic wr_en,
        output logic [31:0] mem_addr, w_data,
        output logic [31:0] instr,  // Current instruction (for cpu_top compatibility)

        //OK regs
        output logic [DATA_WIDTH-1:0] regs_ok [0:2**ADDR_WIDTH-1],
        
        // Debug signals
        output logic [ADDR_WIDTH-1:0] dbg_reg_file_r0_addr,
        output logic [ADDR_WIDTH-1:0] dbg_reg_file_r1_addr,
        output logic [DATA_WIDTH-1:0] dbg_reg_file_r0_data,
        output logic [DATA_WIDTH-1:0] dbg_reg_file_r1_data,
        output logic [DATA_WIDTH-1:0] dbg_Register_File_A,
        output logic [DATA_WIDTH-1:0] dbg_Register_File_B,
        output logic [5:0] dbg_instruction_reg_rs,  // instruction_reg[25:21]
        output logic [5:0] dbg_instruction_reg_rt,  // instruction_reg[20:16]
        output logic [ADDR_WIDTH-1:0] dbg_reg_file_w_addr,
        output logic dbg_RegWrite,
        output logic [DATA_WIDTH-1:0] dbg_reg_file_w_data,
        output logic [31:0] dbg_PC  // Debug PC value
    );


    /*

        You should split the CPU into one or more submodules. 
        We have provided modules for you to use inside the CPU. Please see the following files:
            reg_file.sv (register file)
            reg_en.sv (register with enable and reset),
            reg_reset.sv (register with only reset)
            alu.sv (ALU)

        Useful constants and opcodes are provided in cpu.svh, which is included 
        at the top of this file.

    */


    /* Datapath */
    /*
         
        The CPU interfaces with main memory which is enabled by the
        inputs and outputs of this module (r_data, wr_en, mem_addr, w_data)
        You should create the register file, flip flops, and logic implementing
        a simple datapath so that instructions can be loaded from main memory,
        executed, and the results can be inspected in the register file, or in
        main memory (once lw and sw are supported). 

    */
    
    // Program Counter (PC) Register
    logic [31:0] PC;
    logic [31:0] PC_prime;  // PC' (PC prime) - next PC value from PCSrc_Select
    logic PCWrite;         // PC write enable (from control unit, will be connected)
    
    // Branch Logic signals (will be connected after control unit and ALU are instantiated)
    logic branch_and_zero;  // Output of AND gate: Branch AND zero flag
    logic PCEn;             // PC enable signal (output of OR gate): (Branch AND zero) OR PCWrite
    
    reg_en #(
        .N(32),
        .INIT(`I_START_ADDRESS)
    ) PC_Reg (
        .clk(clk),
        .rst(rst),
        .en(PCEn),         // PC enable: PCWrite OR (Branch AND zero)
        .d(PC_prime),
        .q(PC)
    );
    
    // Memory address selection mux (PC_Select mux, controlled by IorD)
    // IorD = 0: select PC (instruction fetch)
    // IorD = 1: select ALUOut (data memory access)
    logic IorD;            // Instruction or Data select (from control unit)
    logic MemWrite;        // Memory write enable (from control unit)
    logic [31:0] addr;     // Memory address mux output
    
    // PC_Select mux: IorD = 0 selects PC, IorD = 1 selects ALUOut
    // Note: ALUOut will be connected later after ALU_Reg is instantiated
    logic [31:0] alu_out_for_addr;  // Placeholder, will be connected to ALUOut
    assign addr = IorD ? alu_out_for_addr : PC;
    
    // Connect memory address to output port
    assign mem_addr = addr;
    
    // Memory read data comes from external memory (r_data input port)
    // The datapath will use r_data directly from the external memory
    logic [31:0] mem_r_data;
    assign mem_r_data = r_data;
    
    // Instruction Register - stores instructions from memory
    logic [31:0] instruction_reg;
    logic IRWrite;  // Instruction register write enable (from control unit, to be connected)
    
    reg_en #(
        .N(32),
        .INIT(0)
    ) instruction_reg_inst (
        .clk(clk),
        .rst(rst),
        .en(IRWrite),
        .d(mem_r_data),
        .q(instruction_reg)
    );
    
    // Output instruction for cpu_top compatibility
    assign instr = instruction_reg;
    
    // Data Register - stores data from memory (for load instructions)
    logic [31:0] data_reg;
    logic data_reg_en;  // Data register enable (to be connected to control signal)
    
    reg_en #(
        .N(32),
        .INIT(0)
    ) data_reg_inst (
        .clk(clk),
        .rst(rst),
        .en(data_reg_en),
        .d(mem_r_data),
        .q(data_reg)
    );
    
    // MemToReg mux - selects between ALUOut (0) and data register (1)
    logic MemToReg;  // Memory to Register select (from control unit)
    logic [31:0] reg_file_w_data;  // Register file write data
    
    // Control unit output signals (declared early for use in datapath)
    logic Branch;
    logic PCSrc;
    logic [3:0] ALUControl;
    logic [1:0] ALUSrcB;
    logic ALUSrcA;
    logic RegWrite;
    logic RegDst;
    
    // MemToReg mux: MemToReg = 0 selects ALUOut, MemToReg = 1 selects data_reg
    // Note: ALUOut will be connected later after ALU_Reg is instantiated
    logic [31:0] alu_out_for_reg;  // Placeholder, will be connected to ALUOut
    assign reg_file_w_data = MemToReg ? data_reg : alu_out_for_reg;
    
    // Register File
    logic [ADDR_WIDTH-1:0] reg_file_r0_addr;  // Read address 0 (rs)
    logic [ADDR_WIDTH-1:0] reg_file_r1_addr;  // Read address 1 (rt)
    logic [ADDR_WIDTH-1:0] reg_file_w_addr;  // Write address (rd or rt)
    logic [DATA_WIDTH-1:0] reg_file_r0_data;  // Read data 0 (rs data)
    logic [DATA_WIDTH-1:0] reg_file_r1_data;  // Read data 1 (rt data)
    
    // Register file address connections from instruction register
    assign reg_file_r0_addr = instruction_reg[25:21];  // A1: rs field
    assign reg_file_r1_addr = instruction_reg[20:16];  // A2: rt field
    
    // RegDst mux: selects between rt (20:16) and rd (15:11) for write address
    // RegDst = 0: select rt (20:16) for I-type instructions
    // RegDst = 1: select rd (15:11) for R-type instructions
    assign reg_file_w_addr = RegDst ? instruction_reg[15:11] : instruction_reg[20:16];
    
    // Instantiate register file
    reg_file #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) reg_file_inst (
        .clk(clk),
        .rst(rst),
        .wr_en(RegWrite),
        .w_addr(reg_file_w_addr),
        .r0_addr(reg_file_r0_addr),
        .r1_addr(reg_file_r1_addr),
        .w_data(reg_file_w_data),
        .r0_data(reg_file_r0_data),
        .r1_data(reg_file_r1_data),
        .regs_ok(regs_ok)
    );
    
    // Register File A and B - store register file outputs
    // These are pipeline registers that should always update to track register file outputs
    // The control unit FSM ensures timing by waiting in S1 (decode) before executing in S2
    // This gives time for register file addresses to propagate and outputs to stabilize
    logic [31:0] Register_File_A;  // Stores RD1 (rs data)
    logic [31:0] Register_File_B;  // Stores RD2 (rt data)
    
    reg_reset #(
        .N(32)
    ) Register_File_A_inst (
        .clk(clk),
        .rst(rst),
        .d(reg_file_r0_data),
        .q(Register_File_A)
    );
    
    reg_reset #(
        .N(32)
    ) Register_File_B_inst (
        .clk(clk),
        .rst(rst),
        .d(reg_file_r1_data),
        .q(Register_File_B)
    );
    
    // Connect Register_File_B to memory write data (WD)
    assign w_data = Register_File_B;
    
    // Debug signal assignments
    assign dbg_reg_file_r0_addr = reg_file_r0_addr;
    assign dbg_reg_file_r1_addr = reg_file_r1_addr;
    assign dbg_reg_file_r0_data = reg_file_r0_data;
    assign dbg_reg_file_r1_data = reg_file_r1_data;
    assign dbg_Register_File_A = Register_File_A;
    assign dbg_Register_File_B = Register_File_B;
    assign dbg_instruction_reg_rs = instruction_reg[25:21];
    assign dbg_instruction_reg_rt = instruction_reg[20:16];
    assign dbg_reg_file_w_addr = reg_file_w_addr;
    assign dbg_RegWrite = RegWrite;
    assign dbg_reg_file_w_data = reg_file_w_data;
    assign dbg_PC = PC;
    
    // Sign Extender
    logic [15:0] imm_16;  // 16-bit immediate from instruction
    logic [31:0] SignImm; // 32-bit sign-extended immediate (renamed from imm_32)
    
    assign imm_16 = instruction_reg[15:0];
    
    sign_extend sign_extend_inst (
        .imm_16(imm_16),
        .imm_32(SignImm)
    );
    
    // Barrel Shifter - left shift by 2 bits (multiply by 4)
    logic [31:0] shifted_imm;  // Barrel shifter output
    
    barrel_shifter barrel_shifter_inst (
        .data_in(SignImm),
        .data_out(shifted_imm)
    );
    
    // ALU Source B Mux (SrcB select mux) - 2-bit wide, 4-to-1 mux
    // ALUSrcB = 00: Register_File_B (for R-type arithmetic/logic)
    // ALUSrcB = 01: constant 4 (for PC+4)
    // ALUSrcB = 10: SignImm (sign-extended immediate, for I-type)
    // ALUSrcB = 11: shifted_imm (barrel shifter output, for branch address calculation)
    // Note: For shift instructions, we need shamt field, but ALU uses Register_File_B as shift amount
    //       Actually, shift instructions use shamt from instruction[10:6] as the shift amount
    logic [31:0] alu_src_b_mux_in0;  // Input 00: Register_File_B (or shamt for shifts)
    logic [31:0] alu_src_b_mux_in1;  // Input 01: constant 4
    logic [31:0] alu_src_b_mux_in2;  // Input 10: SignImm
    logic [31:0] alu_src_b_mux_in3;  // Input 11: shifted_imm
    logic [31:0] alu_src_b;  // ALU source B output
    
    // Extract shamt field for shift instructions (bits 10:6)
    logic [4:0] shamt;
    assign shamt = instruction_reg[10:6];
    
    // Connect inputs to SrcB select mux
    // alu_src_b_mux_in0 will be assigned after opcode/funct are declared (for shift instruction handling)
    assign alu_src_b_mux_in1 = 32'd4;            // Input 01: constant 4
    assign alu_src_b_mux_in2 = SignImm;           // Input 10: sign-extended immediate
    assign alu_src_b_mux_in3 = shifted_imm;       // Input 11: barrel shifter output
    
    // Instantiate SrcB select mux (2-bit wide 4-to-1 mux for ALU source B)
    mux #(
        .N(32)
    ) SrcB_select_mux (
        .sel(ALUSrcB),
        .in0(alu_src_b_mux_in0),
        .in1(alu_src_b_mux_in1),
        .in2(alu_src_b_mux_in2),
        .in3(alu_src_b_mux_in3),
        .out(alu_src_b)
    );
    
    // ALU Source A Mux (1-bit wide, 2-to-1 mux)
    // ALUSrcA = 0: PC (for PC+4 calculation)
    // ALUSrcA = 1: Register_File_A (for most R-type) or Register_File_B (for shift instructions)
    // Note: For shift instructions (SLL, SRL, SRA), we shift rt (Register_File_B), not rs
    logic [31:0] alu_src_a_mux_in0;  // Input 0: PC
    logic [31:0] alu_src_a_mux_in1;  // Input 1: Register_File_A or Register_File_B (for shifts)
    logic [31:0] alu_src_a;  // ALU source A output
    
    // For shift instructions, use Register_File_B (rt) as the value to shift
    // For other instructions, use Register_File_A (rs)
    assign alu_src_a_mux_in0 = PC;
    // alu_src_a_mux_in1 is assigned after opcode/funct are declared (see below)
    
    mux_1bit #(
        .N(32)
    ) SrcA_select_mux (
        .sel(ALUSrcA),
        .in0(alu_src_a_mux_in0),
        .in1(alu_src_a_mux_in1),
        .out(alu_src_a)
    );
    
    // ALU
    logic alu_zero;        // ALU zero flag output (zero line)
    logic [31:0] ALUResult;  // ALU result signal
    
    alu #(
        .N(32)
    ) alu_inst (
        .x(alu_src_a),      // ALU input A (SrcA)
        .y(alu_src_b),      // ALU input B (SrcB)
        .op(ALUControl),    // ALU operation control
        .z(ALUResult),      // ALU result output
        .zero(alu_zero)     // ALU zero flag (zero line)
    );
    
    // ALU Register - stores ALU result
    logic [31:0] ALUOut;  // ALU register output
    
    reg_reset #(
        .N(32)
    ) ALU_Reg (
        .clk(clk),
        .rst(rst),
        .d(ALUResult),
        .q(ALUOut)
    );
    
    // PCSrc Select Mux - selects between ALUResult and ALUOut for PC_prime
    // PCSrc = 0: ALUResult (for PC+4)
    // PCSrc = 1: ALUOut (for branch target)
    mux_1bit #(
        .N(32)
    ) PCSrc_Select (
        .sel(PCSrc),
        .in0(ALUResult),   // Input 0: ALUResult
        .in1(ALUOut),      // Input 1: ALUOut
        .out(PC_prime)     // Output: PC' (PC prime) feeds into PC_Reg
    );
    
    // Connect ALUOut to MemToReg mux input 0
    assign alu_out_for_reg = ALUOut;
    
    // Connect ALUOut to PC_Select mux (IorD mux) input 1
    assign alu_out_for_addr = ALUOut;
    
    /* Controller */
    /*
        Control FSM that controls the behavior of the datapath depending on 
        the instruction that is currently executing.
    */
    
    // Extract opcode and funct from instruction register
    logic [5:0] opcode;
    logic [5:0] funct;
    
    assign opcode = instruction_reg[31:26];
    assign funct = instruction_reg[5:0];
    
    // For shift instructions (SLL, SRL, SRA), use shamt as ALU input B and rt as ALU input A
    // Check if current instruction is a shift (funct field indicates shift)
    logic is_shift_instr;
    assign is_shift_instr = (opcode == `OP_RTYPE) && 
                           ((funct == `F_SLL) || (funct == `F_SRL) || (funct == `F_SRA));
    
    // Update ALU source muxes for shift instructions
    // For shift instructions: ALU A = rt (Register_File_B), ALU B = shamt
    // For non-shift R-type: ALU A = rs (Register_File_A), ALU B = rt (Register_File_B)
    assign alu_src_b_mux_in0 = is_shift_instr ? {27'b0, shamt} : Register_File_B;
    assign alu_src_a_mux_in1 = is_shift_instr ? Register_File_B : Register_File_A;
    
    // Control unit output signals are declared above (before datapath usage)
    
    // Instantiate control unit
    control_unit ctrl_unit (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .opcode(opcode),
        .funct(funct),
        .PCWrite(PCWrite),
        .Branch(Branch),
        .PCSrc(PCSrc),
        .ALUControl(ALUControl),
        .ALUSrcB(ALUSrcB),
        .ALUSrcA(ALUSrcA),
        .RegWrite(RegWrite),
        .IorD(IorD),
        .MemWrite(MemWrite),
        .IRWrite(IRWrite),
        .MemToReg(MemToReg),
        .RegDst(RegDst)
    );
    
    // Connect MemWrite to memory write enable
    assign wr_en = MemWrite;
    
    // Data register enable: enable when reading from memory (IorD=1 and not writing)
    // This captures data during load instructions
    assign data_reg_en = IorD & ~MemWrite;
    
    // Branch Logic - connect after control unit and ALU are instantiated
    // AND gate: Branch AND zero flag
    assign branch_and_zero = Branch & alu_zero;
    
    // OR gate: (Branch AND zero) OR PCWrite
    assign PCEn = branch_and_zero | PCWrite;
    


endmodule

