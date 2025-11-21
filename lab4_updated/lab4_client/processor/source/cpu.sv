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
        output logic [31:0] dbg_PC,  // Debug PC value
        output logic [3:0] dbg_current_state,  // Debug FSM current state
        output logic [3:0] dbg_next_state,    // Debug FSM next state
        output logic [5:0] dbg_opcode,     // Debug opcode
        output logic [5:0] dbg_funct,      // Debug funct
        output logic dbg_PCWrite,          // Debug PCWrite signal
        output logic dbg_Branch,           // Debug Branch signal
        output logic [1:0] dbg_PCSrc,      // Debug PCSrc signal
        output logic [31:0] dbg_ALUResult, // Debug ALUResult
        output logic [31:0] dbg_ALUOut,     // Debug ALUOut
        output logic [31:0] dbg_instruction_reg,  // Debug full instruction register
        output logic [31:0] dbg_ImmValue,     // Debug ImmValue (sign or zero-extended immediate)
        output logic [31:0] dbg_SignImm,     // Debug SignImm
        output logic [31:0] dbg_ZeroImm,     // Debug ZeroImm
        output logic [15:0] dbg_imm_16,      // Debug imm_16
        output logic dbg_opcode_has_xz,     // Debug: opcode has X/Z bits
        output logic [5:0] dbg_opcode_raw,   // Debug: raw opcode value
        output logic [3:0] dbg_decode_result,  // Debug: which decode path was taken
        output logic [3:0] dbg_next_state_before_case,  // Debug: next_state before case
        output logic [3:0] dbg_next_state_after_j_check,  // Debug: next_state after J check
        output logic [5:0] dbg_opcode_reg,  // Debug: registered opcode value
        output logic [5:0] dbg_opcode_used,  // Debug: opcode actually used in comparisons
        output logic dbg_opcode_reg_has_xz,  // Debug: registered opcode has X/Z bits
        output logic dbg_isLW,  // Debug: isLW signal value
        output logic dbg_isSW,  // Debug: isSW signal value
        output logic dbg_isR,   // Debug: isR signal value
        output logic dbg_isJR   // Debug: isJR signal value
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
    logic branch_condition;  // Branch condition: (BranchEQ & zero) | (BranchNE & ~zero)
    logic PCEn;             // PC enable signal (output of OR gate): branch_condition OR PCWrite
    
    reg_en #(
        .N(32),
        .INIT(`I_START_ADDRESS)
    ) PC_Reg (
        .clk(clk),
        .rst(rst),
        .en(PCEn),         // PC enable: PCWrite OR branch_condition
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
    logic BranchEQ;      // Branch if equal (BEQ)
    logic BranchNE;      // Branch if not equal (BNE)
    logic [1:0] PCSrc;
    logic [3:0] ALUControl;
    logic [1:0] ALUSrcB;
    logic ALUSrcA;
    logic RegWrite;
    logic RegDst;
    logic ExtOp;        // Extension operation: 1 = sign extend, 0 = zero extend
    logic UseShamt;     // Use shamt field for shift instructions
    logic WriteRA;      // Write return address for JAL
    
    // Debug signals from control unit (use logic to match control_unit output)
    logic [3:0] dbg_ctrl_current_state, dbg_ctrl_next_state;
    
    // Get state from control unit for enable signals (declared early for use in A/B register enables)
    logic [3:0] current_state;
    logic [3:0] next_state;
    assign current_state = dbg_ctrl_current_state;
    assign next_state = dbg_ctrl_next_state;
    
    // MemToReg mux: MemToReg = 0 selects ALUOut, MemToReg = 1 selects data_reg
    // Note: ALUOut will be connected later after ALU_Reg is instantiated
    // For JAL, we use ALUResult directly (which has PC+4 calculated in S9)
    // Note: ALUResult is declared later, so we'll assign this after ALU is instantiated
    logic [31:0] alu_out_for_reg;  // Placeholder, will be connected to ALUOut
    logic [31:0] reg_file_w_data_temp;  // Temporary for reg_file_w_data
    
    // Register File
    logic [ADDR_WIDTH-1:0] reg_file_r0_addr;  // Read address 0 (rs)
    logic [ADDR_WIDTH-1:0] reg_file_r1_addr;  // Read address 1 (rt)
    logic [ADDR_WIDTH-1:0] reg_file_w_addr;  // Write address (rd or rt)
    logic [DATA_WIDTH-1:0] reg_file_r0_data;  // Read data 0 (rs data)
    logic [DATA_WIDTH-1:0] reg_file_r1_data;  // Read data 1 (rt data)
    
    // Register file address connections from instruction register
    assign reg_file_r0_addr = instruction_reg[25:21];  // A1: rs field
    assign reg_file_r1_addr = instruction_reg[20:16];  // A2: rt field
    
    // Extract opcode and funct from instruction register (needed early for JAL and zero-extend)
    logic [5:0] opcode;
    logic [5:0] funct;
    assign opcode = instruction_reg[31:26];
    assign funct = instruction_reg[5:0];
    
    // RegDst mux: selects between rt (20:16) and rd (15:11) for write address
    // RegDst = 0: select rt (20:16) for I-type instructions
    // RegDst = 1: select rd (15:11) for R-type instructions
    // Special case: JAL (WriteRA = 1) always writes to register 31 ($ra)
    logic [ADDR_WIDTH-1:0] reg_file_w_addr_temp;
    assign reg_file_w_addr_temp = RegDst ? instruction_reg[15:11] : instruction_reg[20:16];
    assign reg_file_w_addr = WriteRA ? 5'd31 : reg_file_w_addr_temp;
    
    // Instantiate register file
    reg_file #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) reg_file_inst (
        .clk(clk),
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
    // The control unit FSM ensures timing by waiting in S1 (decode) before executing
    // This gives time for register file addresses to propagate and outputs to stabilize
    logic [31:0] Register_File_A;  // Stores RD1 (rs data) - A register
    logic [31:0] Register_File_B;  // Stores RD2 (rt data) - B register
    
    // Always update A and B registers (matching server/reference pattern)
    // The FSM timing ensures values are stable when needed
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
    assign dbg_instruction_reg = instruction_reg;
    // Cast enum types to match (they should be the same, but SystemVerilog is strict)
    // Pass through debug signals
    assign dbg_current_state = dbg_ctrl_current_state;
    assign dbg_next_state = dbg_ctrl_next_state;
    assign dbg_opcode = opcode;
    assign dbg_funct = funct;
    // dbg_opcode_has_xz, dbg_opcode_raw, and dbg_decode_result assigned from control unit
    assign dbg_PCWrite = PCWrite;
    assign dbg_Branch = BranchEQ | BranchNE;  // Combined branch signal for debug
    assign dbg_PCSrc = PCSrc;
    // dbg_ALUResult and dbg_ALUOut assigned after ALU is instantiated (see below)
    
    // Sign Extender and Zero Extender
    logic [15:0] imm_16;  // 16-bit immediate from instruction
    logic [31:0] SignImm; // 32-bit sign-extended immediate
    logic [31:0] ZeroImm; // 32-bit zero-extended immediate
    logic [31:0] ImmValue; // Selected immediate value (sign or zero extended)
    
    assign imm_16 = instruction_reg[15:0];
    
    sign_extend sign_extend_inst (
        .imm_16(imm_16),
        .imm_32(SignImm)
    );
    
    // Zero extension: pad upper 16 bits with zeros
    assign ZeroImm = {16'b0, imm_16};
    
    // Select between sign-extended and zero-extended based on ExtOp control signal
    // ExtOp = 1: sign extend, ExtOp = 0: zero extend
    assign ImmValue = ExtOp ? SignImm : ZeroImm;
    
    // Barrel Shifter - left shift by 2 bits (multiply by 4)
    logic [31:0] shifted_imm;  // Barrel shifter output
    
    barrel_shifter barrel_shifter_inst (
        .data_in(SignImm),
        .data_out(shifted_imm)
    );
    
    // ALU Source B Mux (SrcB select mux) - 2-bit wide, 4-to-1 mux
    // ALUSrcB = 00: Register_File_B (for R-type arithmetic/logic)
    // ALUSrcB = 01: constant 4 (for PC+4)
    // ALUSrcB = 10: ImmValue (sign or zero-extended immediate, for I-type)
    // ALUSrcB = 11: shifted_imm (barrel shifter output, for branch address calculation)
    // Note: For shift instructions, we need shamt field, but ALU uses Register_File_B as shift amount
    //       Actually, shift instructions use shamt from instruction[10:6] as the shift amount
    logic [31:0] alu_src_b_mux_in0;  // Input 00: Register_File_B (or shamt for shifts)
    logic [31:0] alu_src_b_mux_in1;  // Input 01: constant 4
    logic [31:0] alu_src_b_mux_in2;  // Input 10: ImmValue (sign or zero-extended)
    logic [31:0] alu_src_b_mux_in3;  // Input 11: shifted_imm
    logic [31:0] alu_src_b;  // ALU source B output
    
    // Extract shamt field for shift instructions (bits 10:6)
    logic [4:0] shamt;
    assign shamt = instruction_reg[10:6];
    
    // Connect inputs to SrcB select mux
    // alu_src_b_mux_in0 will be assigned after opcode/funct are declared (for shift instruction handling)
    assign alu_src_b_mux_in1 = 32'd4;            // Input 01: constant 4
    assign alu_src_b_mux_in2 = ImmValue;         // Input 10: sign or zero-extended immediate
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
    // Enable ALUOut updates in states where we compute new ALU results:
    // - S1_DECODE (state 2): compute branch target (PC + offset)
    // - S2_ADDR (state 3): compute memory address (rs + offset)
    // - S6_EXEC (state 7): compute R-type result
    // - S9_EXI (state 10): compute I-type result
    // This preserves values in other states (S3_MEMRD, S4_MEMWB, S5_MEMWR, S8_BRANCH)
    logic [31:0] ALUOut;  // ALU register output
    logic ALUOut_en;      // ALUOut enable signal
    
    // Enable ALUOut in states where we compute new ALU results (positive logic)
    // Match reference pattern: enable in S1_DECODE, S2_ADDR, S6_EXEC, S9_EXI
    assign ALUOut_en = (current_state == 4'd2) ||  // S1_DECODE
                       (current_state == 4'd3) ||  // S2_ADDR
                       (current_state == 4'd7) ||  // S6_EXEC
                       (current_state == 4'd10);   // S9_EXI
    
    reg_en #(
        .N(32),
        .INIT(0)
    ) ALU_Reg (
        .clk(clk),
        .rst(rst),
        .en(ALUOut_en),
        .d(ALUResult),
        .q(ALUOut)
    );
    
    // PC+4 Register - stores PC+4 from S0 for use by JAL
    // This register is updated ONLY in S0 when PC+4 is calculated
    // Use PCWrite as enable since it's asserted in S0_FETCH (matching working control_fsm)
    logic [31:0] PC_plus_4;
    
    reg_en #(
        .N(32),
        .INIT(0)
    ) PC_plus_4_Reg (
        .clk(clk),
        .rst(rst),
        .en(PCWrite),  // Update in S0 when PCWrite is asserted (PC+4 is calculated)
        .d(ALUResult),  // In S0, ALUResult = PC + 4
        .q(PC_plus_4)
    );
    
    // Now assign reg_file_w_data (ALUResult is now available)
    // For JAL, use PC+4 from the PC_plus_4 register (saved in S0)
    // Otherwise, use ALUOut for normal instructions
    assign reg_file_w_data = MemToReg ? data_reg : (WriteRA ? PC_plus_4 : ALUOut);
    
    // Assign debug signals for ALU (now that ALUResult and ALUOut are declared)
    assign dbg_ALUResult = ALUResult;
    assign dbg_ALUOut = ALUOut;
    
    // Assign debug signals for immediate values
    assign dbg_ImmValue = ImmValue;
    assign dbg_SignImm = SignImm;
    assign dbg_ZeroImm = ZeroImm;
    assign dbg_imm_16 = imm_16;
    
    // Jump address calculation
    // For J and JAL: jump address = {PC[31:28], instruction[25:0], 2'b00}
    logic [31:0] jump_addr;
    assign jump_addr = {PC[31:28], instruction_reg[25:0], 2'b00};
    
    // PCSrc Select Mux - 4-to-1 mux for PC source selection
    // PCSrc = 00: ALUResult (for PC+4, normal instruction flow) - uses combinational ALU output
    // PCSrc = 01: ALUOut (for branch target) - uses registered ALU output
    // PCSrc = 10: jump_addr (for J and JAL)
    // PCSrc = 11: Register_File_A (for JR)
    // NOTE: Working codebase uses alu_z (combinational) for PCSrc=00, which is ALUResult
    mux #(
        .N(32)
    ) PCSrc_Select (
        .sel(PCSrc),
        .in0(ALUResult),        // Input 00: ALUResult (PC+4) - combinational ALU output
        .in1(ALUOut),           // Input 01: ALUOut (branch target) - registered ALU output
        .in2(jump_addr),        // Input 10: jump address
        .in3(reg_file_r0_data),  // Input 11: Register file output (rs) for JR
        .out(PC_prime)          // Output: PC' (PC prime) feeds into PC_Reg
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
    
    // For shift instructions (SLL, SRL, SRA), use shamt as ALU input B and rt as ALU input A
    // Use UseShamt control signal from control unit
    // For shift instructions: ALU A = rt (register file output), ALU B = shamt
    // For non-shift R-type: ALU A = rs (register file output), ALU B = rt (register file output)
    // NOTE: Use register file outputs directly (like reference), not A/B registers
    //       A/B registers are used for memory writes, not ALU inputs
    assign alu_src_b_mux_in0 = UseShamt ? {27'b0, shamt} : reg_file_r1_data;
    assign alu_src_a_mux_in1 = UseShamt ? reg_file_r1_data : reg_file_r0_data;
    
    // Control unit output signals are declared above (before datapath usage)
    
    // Instantiate control unit
    control_unit ctrl_unit (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .opcode(opcode),
        .funct(funct),
        .PCWrite(PCWrite),
        .PCSrc(PCSrc),
        .ALUControl(ALUControl),
        .ALUSrcB(ALUSrcB),
        .ALUSrcA(ALUSrcA),
        .RegWrite(RegWrite),
        .IorD(IorD),
        .MemWrite(MemWrite),
        .IRWrite(IRWrite),
        .MemToReg(MemToReg),
        .RegDst(RegDst),
        .ExtOp(ExtOp),
        .UseShamt(UseShamt),
        .WriteRA(WriteRA),
        .BranchEQ(BranchEQ),
        .BranchNE(BranchNE),
        .dbg_current_state(dbg_ctrl_current_state),
        .dbg_next_state(dbg_ctrl_next_state),
        .dbg_opcode_has_xz(dbg_opcode_has_xz),
        .dbg_opcode_raw(dbg_opcode_raw),
        .dbg_decode_result(dbg_decode_result),
        .dbg_next_state_before_case(dbg_next_state_before_case),
        .dbg_next_state_after_j_check(dbg_next_state_after_j_check),
        .dbg_opcode_reg(dbg_opcode_reg),
        .dbg_opcode_used(dbg_opcode_used),
        .dbg_opcode_reg_has_xz(dbg_opcode_reg_has_xz),
        .dbg_isLW(dbg_isLW),
        .dbg_isSW(dbg_isSW),
        .dbg_isR(dbg_isR),
        .dbg_isJR(dbg_isJR)
    );
    
    // Connect MemWrite to memory write enable
    assign wr_en = MemWrite;
    
    // Data register enable (MDRWrite): enable in S4_MEMWB to capture memory read data
    // The memory read is combinational, but we capture in S4_MEMWB to ensure address is stable
    // This matches the working codebase behavior
    // NOTE: S4_MEMWB is state 5, not 4!
    assign data_reg_en = (current_state == 4'd5);  // S4_MEMWB (state 5) - capture memory read data
    
    // Branch Logic - connect after control unit and ALU are instantiated
    // BEQ: branch when rs == rt (alu_zero == 1)
    // BNE: branch when rs != rt (alu_zero == 0)
    // Use separate BranchEQ and BranchNE signals from control unit
    assign branch_condition = (BranchEQ & alu_zero) | (BranchNE & ~alu_zero);
    
    // OR gate: (Branch condition) OR PCWrite
    assign PCEn = branch_condition | PCWrite;
    
    // Debug: Monitor register writes and memory operations
    always_ff @(posedge clk) begin
        if (!rst && clk_en) begin
            // Monitor ALL register writes
            if (RegWrite) begin
                $display("[CPU] REGISTER WRITE: w_addr=%0d, w_data=0x%08h (%0d), RegDst=%0d, MemToReg=%0d, WriteRA=%0d, state=%0d",
                    reg_file_w_addr, reg_file_w_data, reg_file_w_data, RegDst, MemToReg, WriteRA, current_state);
                $display("[CPU]   ALUOut=0x%08h (%0d), ALUResult=0x%08h (%0d), data_reg=0x%08h (%0d), PC_plus_4=0x%08h (%0d)", 
                    ALUOut, ALUOut, ALUResult, ALUResult, data_reg, data_reg, PC_plus_4, PC_plus_4);
                $display("[CPU]   dbg_ctrl_current_state=%0d, ALUOut_en=%0d", dbg_ctrl_current_state, ALUOut_en);
            end
            // Monitor ALU computation in S9_EXI (I-type) and S6_EXEC (R-type) - use always_comb to see values immediately
            // Also monitor in always_comb to see values before clock edge
            if (current_state == 4'd7) begin  // S6_EXEC
                $display("[CPU] S6_EXEC: ALUResult=0x%08h (%0d), ALUOut=0x%08h (%0d), ALUOut_en=%0d",
                    ALUResult, ALUResult, ALUOut, ALUOut, ALUOut_en);
                $display("[CPU]   alu_src_a=0x%08h (%0d), alu_src_b=0x%08h (%0d), ALUSrcA=%0d, ALUSrcB=%0b, ALUControl=%0d",
                    alu_src_a, alu_src_a, alu_src_b, alu_src_b, ALUSrcA, ALUSrcB, ALUControl);
            end
            if (current_state == 4'd10) begin  // S9_EXI
                $display("[CPU] S9_EXI (always_ff): ALUResult=0x%08h (%0d), ALUOut=0x%08h (%0d), ALUOut_en=%0d, current_state=%0d",
                    ALUResult, ALUResult, ALUOut, ALUOut, ALUOut_en, current_state);
                $display("[CPU]   alu_src_a=0x%08h (%0d), alu_src_b=0x%08h (%0d), ALUSrcA=%0d, ALUSrcB=%0b, ALUControl=%0d",
                    alu_src_a, alu_src_a, alu_src_b, alu_src_b, ALUSrcA, ALUSrcB, ALUControl);
                $display("[CPU]   reg_file_r0_data=0x%08h (%0d), ImmValue=0x%08h (%0d), instruction_reg[15:0]=0x%04h",
                    reg_file_r0_data, reg_file_r0_data, ImmValue, ImmValue, instruction_reg[15:0]);
            end
            if (current_state == 4'd11) begin  // S10_WBI
                $display("[CPU] S10_WBI (always_ff): ALUOut=0x%08h (%0d), ALUOut_en=%0d, ALUResult=0x%08h (%0d), current_state=%0d",
                    ALUOut, ALUOut, ALUOut_en, ALUResult, ALUResult, current_state);
            end
            // Monitor state transitions to see when ALUOut_en changes
            if (current_state == 4'd11) begin  // S10_WBI
                $display("[CPU] S10_WBI: ALUOut=0x%08h (%0d), ALUOut_en=%0d (should be 0 to preserve value)", ALUOut, ALUOut, ALUOut_en);
            end
            if (current_state == 4'd8) begin  // S7_ALUWB
                $display("[CPU] S7_ALUWB: ALUOut=0x%08h (%0d), ALUOut_en=%0d (should be 0 to preserve value)", ALUOut, ALUOut, ALUOut_en);
            end
            // STEP 1: Address calculation (S2_ADDR)
            if (current_state == 4'd3 && (opcode == `OP_LW || opcode == `OP_SW)) begin  // S2_ADDR
                $display("[CPU] STEP 1 - ADDRESS CALCULATION (opcode=0x%02h):", opcode);
                $display("[CPU]   rs (reg_file_r0_data) = 0x%08h (%0d)", reg_file_r0_data, reg_file_r0_data);
                $display("[CPU]   imm_16 = 0x%04h (%0d)", imm_16, imm_16);
                $display("[CPU]   ImmValue = 0x%08h (%0d)", ImmValue, ImmValue);
                $display("[CPU]   ALUResult = 0x%08h (%0d) [Expected: 0x00000644 (1604)]", ALUResult, ALUResult);
                $display("[CPU]   ALUOut = 0x%08h (%0d), ALUOut_en = %0d", ALUOut, ALUOut, ALUOut_en);
            end
        // STEP 2: Memory write (S5_MEMWR for SW)
        if (current_state == 4'd6 && opcode == `OP_SW) begin  // S5_MEMWR (state 6)
            $display("[CPU] STEP 2 - MEMORY WRITE (SW):");
            $display("[CPU]   mem_addr = 0x%08h (%0d) [Expected: 0x00000644 (1604)]", mem_addr, mem_addr);
            $display("[CPU]   w_data = 0x%08h (%0d) [Expected: 0x00000002 (2)]", w_data, w_data);
            $display("[CPU]   wr_en = %0d [Expected: 1]", wr_en);
            $display("[CPU]   IorD = %0d [Expected: 1]", IorD);
            $display("[CPU]   ALUOut = 0x%08h (%0d)", ALUOut, ALUOut);
        end
        // STEP 2: Memory read (S3_MEMRD for LW)
        if (current_state == 4'd4 && opcode == `OP_LW) begin  // S3_MEMRD (state 4)
            $display("[CPU] STEP 2 - MEMORY READ (LW):");
            $display("[CPU]   mem_addr = 0x%08h (%0d) [Expected: 0x00000644 (1604)]", mem_addr, mem_addr);
            $display("[CPU]   r_data = 0x%08h (%0d) [Expected: 0x00000002 (2)]", r_data, r_data);
            $display("[CPU]   IorD = %0d [Expected: 1]", IorD);
            $display("[CPU]   ALUOut = 0x%08h (%0d)", ALUOut, ALUOut);
        end
        // STEP 3: Capture memory data (S4_MEMWB for LW)
        if (current_state == 4'd5 && opcode == `OP_LW) begin  // S4_MEMWB (state 5)
            $display("[CPU] STEP 3 - CAPTURE MEMORY DATA (LW):");
            $display("[CPU]   mem_addr = 0x%08h (%0d)", mem_addr, mem_addr);
            $display("[CPU]   r_data = 0x%08h (%0d) [Expected: 0x00000002 (2)]", r_data, r_data);
            $display("[CPU]   data_reg_en = %0d [Expected: 1]", data_reg_en);
            $display("[CPU]   data_reg = 0x%08h (%0d) [Expected: 0x00000002 (2)]", data_reg, data_reg);
        end
        // STEP 4: Register writeback (S10_WBI for LW)
        if (current_state == 4'd11 && opcode == `OP_LW) begin  // S10_WBI (state 11)
            $display("[CPU] STEP 4 - REGISTER WRITEBACK (LW):");
            $display("[CPU]   reg_file_w_addr = %0d ($t2) [Expected: 10]", reg_file_w_addr);
            $display("[CPU]   reg_file_w_data = 0x%08h (%0d) [Expected: 0x00000002 (2)]", reg_file_w_data, reg_file_w_data);
            $display("[CPU]   RegWrite = %0d [Expected: 1]", RegWrite);
            $display("[CPU]   MemToReg = %0d [Expected: 1]", MemToReg);
            $display("[CPU]   data_reg = 0x%08h (%0d)", data_reg, data_reg);
            $display("[CPU]   ALUOut = 0x%08h (%0d)", ALUOut, ALUOut);
        end
        end
    end
    


endmodule

