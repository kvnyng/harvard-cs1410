`timescale 1ns / 1ps
`include "../source/cpu.svh"

module cpu_itype_jtype_tb();

    // Clock and control signals
    logic clk = 0;
    logic clk_en = 1;
    logic rst = 1;
    
    // CPU interface signals
    logic [31:0] r_data;
    logic wr_en;
    logic [31:0] mem_addr, w_data;
    logic [31:0] regs_ok [0:31];
    
    // Simulated memory (external to CPU)
    // Need larger memory to accommodate both instruction (0x00400000+) and data (0x00000000+) regions
    // Max address: 0x00800000 -> index 0x00200000 (2M words)
    // Array size: [0:2097151] to cover 0x00000000 to 0x007FFFFC
    logic [31:0] memory [0:2097151];  // 8MB memory (2M words) to cover full address range
    
    // Test results tracking
    int test_count = 0;
    int pass_count = 0;
    int fail_count = 0;
    int cycle_count = 0;
    
    // Debug signals
    logic [4:0] dbg_reg_file_r0_addr, dbg_reg_file_r1_addr, dbg_reg_file_w_addr;
    logic [31:0] dbg_reg_file_r0_data, dbg_reg_file_r1_data, dbg_reg_file_w_data;
    logic [31:0] dbg_Register_File_A, dbg_Register_File_B;
    logic [5:0] dbg_instruction_reg_rs, dbg_instruction_reg_rt;
    logic dbg_RegWrite;
    logic [31:0] dbg_PC;
    logic [31:0] dbg_ImmValue, dbg_SignImm, dbg_ZeroImm;
    logic [15:0] dbg_imm_16;
    // Debug state signals (as logic [3:0])
    logic [3:0] dbg_current_state, dbg_next_state;
    logic [5:0] dbg_opcode, dbg_funct;
    logic dbg_PCWrite, dbg_Branch;
    logic [1:0] dbg_PCSrc;
    logic [31:0] dbg_ALUResult, dbg_ALUOut;
    logic [31:0] dbg_instruction_reg;
    logic dbg_opcode_has_xz;
    logic [5:0] dbg_opcode_raw;
    logic [3:0] dbg_decode_result;
    logic [3:0] dbg_next_state_before_case;
    logic [3:0] dbg_next_state_after_j_check;
    
    // Instantiate CPU
    cpu #(
        .DATA_WIDTH(32),
        .ADDR_WIDTH(5)
    ) cpu_inst (
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .r_data(r_data),
        .wr_en(wr_en),
        .mem_addr(mem_addr),
        .w_data(w_data),
        .regs_ok(regs_ok),
        .dbg_reg_file_r0_addr(dbg_reg_file_r0_addr),
        .dbg_reg_file_r1_addr(dbg_reg_file_r1_addr),
        .dbg_reg_file_r0_data(dbg_reg_file_r0_data),
        .dbg_reg_file_r1_data(dbg_reg_file_r1_data),
        .dbg_Register_File_A(dbg_Register_File_A),
        .dbg_Register_File_B(dbg_Register_File_B),
        .dbg_instruction_reg_rs(dbg_instruction_reg_rs),
        .dbg_instruction_reg_rt(dbg_instruction_reg_rt),
        .dbg_reg_file_w_addr(dbg_reg_file_w_addr),
        .dbg_RegWrite(dbg_RegWrite),
        .dbg_reg_file_w_data(dbg_reg_file_w_data),
        .dbg_PC(dbg_PC),
        .dbg_current_state(dbg_current_state),
        .dbg_next_state(dbg_next_state),
        .dbg_opcode(dbg_opcode),
        .dbg_funct(dbg_funct),
        .dbg_PCWrite(dbg_PCWrite),
        .dbg_Branch(dbg_Branch),
        .dbg_PCSrc(dbg_PCSrc),
        .dbg_ALUResult(dbg_ALUResult),
        .dbg_ALUOut(dbg_ALUOut),
        .dbg_instruction_reg(dbg_instruction_reg),
        .dbg_ImmValue(dbg_ImmValue),
        .dbg_SignImm(dbg_SignImm),
        .dbg_ZeroImm(dbg_ZeroImm),
        .dbg_imm_16(dbg_imm_16),
        .dbg_opcode_has_xz(dbg_opcode_has_xz),
        .dbg_opcode_raw(dbg_opcode_raw),
        .dbg_decode_result(dbg_decode_result),
        .dbg_next_state_before_case(dbg_next_state_before_case),
        .dbg_next_state_after_j_check(dbg_next_state_after_j_check)
    );
    
    // Clock generation (100MHz = 10ns period)
    always #5 clk = ~clk;
    
    // Memory simulation - handles reads and writes
    always_ff @(posedge clk) begin
        if (wr_en) begin
            // Write to memory
            logic [31:0] idx = mem_addr >> 2;  // Use full address range
            if (mem_addr < 32'h00800000) begin  // Within our memory range
                memory[idx] <= w_data;
            end
        end
    end
    
    // Memory read (combinational)
    // Use full address >> 2 as index to avoid conflicts between instruction and data memory
    always_comb begin
        logic [31:0] idx = mem_addr >> 2;  // Use full address range
        if (mem_addr >= `I_START_ADDRESS && mem_addr < 32'h00800000) begin
            // Instruction memory
            r_data = memory[idx];
        end else if (mem_addr < 32'h00400000) begin
            // Data memory
            r_data = memory[idx];
        end else begin
            r_data = 32'h00000000;  // Default to NOP
        end
    end
    
    // Monitor clock cycles and FSM state transitions
    // Add small delay to ensure signals are stable after clock edge
    always @(posedge clk) begin
        #1;  // Small delay to ensure signals are stable
        cycle_count++;
        
        // Debug: Monitor FSM state transitions and control signals
        if (!rst && cycle_count > 5 && cycle_count < 150) begin
            // Function to convert state to string
            automatic string state_str, next_str;
            case (dbg_current_state)
                4'd0: state_str = "S0_FETCH";
                4'd1: state_str = "S1_DECODE";
                4'd2: state_str = "S2_ADDR";
                4'd3: state_str = "S3_MEMRD";
                4'd4: state_str = "S4_MEMWB";
                4'd5: state_str = "S5_MEMWR";
                4'd6: state_str = "S6_EXEC";
                4'd7: state_str = "S7_ALUWB";
                4'd8: state_str = "S8_BRANCH";
                4'd9: state_str = "S9_EXI";
                4'd10: state_str = "S10_WBI";
                4'd11: state_str = "S11_JUMP";
                default: state_str = "UNKNOWN";
            endcase
            case (dbg_next_state)
                4'd0: next_str = "S0_FETCH";
                4'd1: next_str = "S1_DECODE";
                4'd2: next_str = "S2_ADDR";
                4'd3: next_str = "S3_MEMRD";
                4'd4: next_str = "S4_MEMWB";
                4'd5: next_str = "S5_MEMWR";
                4'd6: next_str = "S6_EXEC";
                4'd7: next_str = "S7_ALUWB";
                4'd8: next_str = "S8_BRANCH";
                4'd9: next_str = "S9_EXI";
                4'd10: next_str = "S10_WBI";
                4'd11: next_str = "S11_JUMP";
                default: next_str = "UNKNOWN";
            endcase
            
            // Print every cycle for debugging (with full instruction and X/Z check)
            $display("[Cycle %0d] State: %s -> %s | PC=0x%08h | Opcode=0x%02h (bin:%06b) [%s] | RawOp=0x%02h | DecodePath=%0d | PCWrite=%b | Branch=%b | PCSrc=%b | RegWrite=%b | Instr=0x%08h",
                cycle_count, state_str, next_str, dbg_PC, dbg_opcode, dbg_opcode, 
                (dbg_opcode_has_xz ? "X/Z" : "OK"), dbg_opcode_raw, dbg_decode_result,
                dbg_PCWrite, dbg_Branch, dbg_PCSrc, dbg_RegWrite, dbg_instruction_reg);
            
            // Enhanced debug for I-type instructions during execution
            if ((dbg_opcode == 6'b001000 || dbg_opcode == 6'b001100 || dbg_opcode == 6'b001101 || 
                 dbg_opcode == 6'b001110 || dbg_opcode == 6'b001010) && 
                (dbg_current_state == 4'd9 || dbg_current_state == 4'd10)) begin
                $display("  [I-TYPE DEBUG] State=%0d | rs=$%0d rt=$%0d | RegFile_A=0x%08h | RegFile_B=0x%08h | ImmValue=0x%08h | ALUResult=0x%08h | ALUOut=0x%08h",
                    dbg_current_state, dbg_instruction_reg_rs, dbg_instruction_reg_rt,
                    dbg_Register_File_A, dbg_Register_File_B, dbg_ImmValue, dbg_ALUResult, dbg_ALUOut);
            end
            
            // Debug for LW/SW instructions
            if ((dbg_opcode == 6'b100011 || dbg_opcode == 6'b101011) && dbg_current_state == 4'd1) begin
                $display("  [LW/SW DEBUG] State=S1_DECODE | Opcode=0x%02x | DecodePath=%0d | NextState=%0d | isLW should be: %b",
                    dbg_opcode, dbg_decode_result, dbg_next_state, (dbg_opcode == 6'b100011));
            end
            
            // Debug register writes
            if (dbg_RegWrite && cycle_count > 5 && cycle_count < 150) begin
                $display("  [REG WRITE] Cycle=%0d | w_addr=$%0d | w_data=0x%08h (%0d) | RegDst=%b | MemToReg=%b | WriteRA=%b",
                    cycle_count, dbg_reg_file_w_addr, dbg_reg_file_w_data, dbg_reg_file_w_data,
                    (dbg_instruction_reg[15:11] == dbg_reg_file_w_addr ? 1 : 0),  // RegDst indicator
                    (dbg_reg_file_w_data == dbg_ALUOut ? 0 : 1),  // MemToReg indicator (rough)
                    0);  // WriteRA would need separate signal
            end
            
            // Additional debug for I-type instructions (opcode 0x08, 0x0a, 0x0c, 0x0d, 0x0e)
            if (dbg_opcode == 6'b001000 || dbg_opcode == 6'b001010 || 
                dbg_opcode == 6'b001100 || dbg_opcode == 6'b001101 || dbg_opcode == 6'b001110) begin
                $display("  DEBUG I-TYPE: rs_addr=%0d | rt_addr=%0d | r0_data=0x%08h | r1_data=0x%08h | RegA=0x%08h | RegB=0x%08h | RegWrite=%b",
                    dbg_instruction_reg_rs, dbg_instruction_reg_rt,
                    dbg_reg_file_r0_data, dbg_reg_file_r1_data,
                    dbg_Register_File_A, dbg_Register_File_B, dbg_RegWrite);
                $display("  DEBUG IMM: imm_16=0x%04h | SignImm=0x%08h | ZeroImm=0x%08h | ImmValue=0x%08h | ALUResult=0x%08h | ALUOut=0x%08h",
                    dbg_imm_16, dbg_SignImm, dbg_ZeroImm, dbg_ImmValue, dbg_ALUResult, dbg_ALUOut);
            end
            
            // Additional debug for specific problematic cycles
            if (cycle_count >= 88 && cycle_count <= 92) begin
                $display("  DEBUG: opcode==0x02? %b | opcode==0x03? %b | opcode==0x00? %b | opcode==0x08? %b",
                    (dbg_opcode == 6'b000010), (dbg_opcode == 6'b000011), 
                    (dbg_opcode == 6'b000000), (dbg_opcode == 6'b001000));
                $display("  DEBUG: decode_result=%0d | next_state=%0d | before_case=%0d | after_j_check=%0d",
                    dbg_decode_result, dbg_next_state, dbg_next_state_before_case, dbg_next_state_after_j_check);
                $display("  DEBUG: next_state should be: %s (actual: %0d)",
                    (dbg_decode_result == 4'd2 || dbg_decode_result == 4'd3) ? "S9_JUMP(9)" : 
                    (dbg_decode_result == 4'd1) ? "S2_RTYPE(2) or S10_JR(10)" : "other",
                    dbg_next_state);
            end
        end
    end
    
    // Task to wait for N clock cycles
    task wait_cycles(input int n);
        repeat(n) @(posedge clk);
        #2; // Small delay for combinational logic to settle
    endtask
    
    // Task to write instruction to memory
    // Use full address >> 2 as index to avoid conflicts between instruction and data memory
    task write_instruction_memory(input logic [31:0] addr, input logic [31:0] instr);
        logic [31:0] idx = addr >> 2;  // Use full address range
        memory[idx] = instr;
        $display("    [0x%08h] Instruction: 0x%08h (memory[%0d])", addr, instr, idx);
    endtask
    
    // Task to write data to memory
    // Use full address >> 2 as index to avoid conflicts between instruction and data memory
    task write_data_memory(input logic [31:0] addr, input logic [31:0] data);
        logic [31:0] idx = addr >> 2;  // Use full address range
        memory[idx] = data;
        $display("    [0x%08h] Data: 0x%08h (%0d) (memory[%0d])", addr, data, $signed(data), idx);
    endtask
    
    // Task to check register value
    task automatic check_register(input logic [4:0] reg_num, input logic [31:0] expected, input string test_name);
        logic [31:0] actual;
        test_count++;
        actual = regs_ok[reg_num];
        if (actual === expected) begin
            pass_count++;
            $display("  ✓ %s: $%0d = 0x%08h (%0d)", test_name, reg_num, actual, actual);
        end else begin
            fail_count++;
            $error("Test '%s' FAILED: Register $%0d: expected=0x%08h (%0d), got=0x%08h (%0d)", 
                   test_name, reg_num, expected, expected, actual, actual);
        end
    endtask
    
    // Helper function to encode I-type instruction
    function logic [31:0] encode_itype(input logic [5:0] opcode, input logic [4:0] rs, 
                                       input logic [4:0] rt, input logic [15:0] imm);
        encode_itype = {opcode, rs, rt, imm};
    endfunction
    
    // Helper function to encode J-type instruction
    function logic [31:0] encode_jtype(input logic [5:0] opcode, input logic [25:0] addr);
        encode_jtype = {opcode, addr};
    endfunction
    
    initial begin
        $display("========================================");
        $display("CPU I-Type and J-Type Instructions Testbench");
        $display("Testing I-type and J-type instructions");
        $display("========================================\n");
        
        // Initialize memory to zeros
        for (int i = 0; i < 2097152; i++) begin
            memory[i] = 32'h00000000;
        end
        
        // CRITICAL: Load instructions BEFORE releasing reset
        // This ensures instructions are in memory before CPU starts fetching
        $display("\n=== Loading I-Type and J-Type Instructions ===");
        $display("Writing instructions to instruction memory at 0x00400000\n");
        
        // Test 1: I-Type Immediate Instructions (ADDI, ANDI, ORI, XORI, SLTI)
        $display("Test 1: I-Type Immediate Instructions");
        write_instruction_memory(32'h00400000, encode_itype(`OP_ADDI, 5'd0, 5'd1, 16'd5));    // ADDI $1, $0, 5
        write_instruction_memory(32'h00400004, encode_itype(`OP_ADDI, 5'd0, 5'd2, 16'd3));    // ADDI $2, $0, 3
        write_instruction_memory(32'h00400008, encode_itype(`OP_ADDI, 5'd1, 5'd3, 16'd10));   // ADDI $3, $1, 10  -> $3 = 15
        write_instruction_memory(32'h0040000C, encode_itype(`OP_ANDI, 5'd1, 5'd4, 16'h0003));  // ANDI $4, $1, 3   -> $4 = 5 & 3 = 1
        write_instruction_memory(32'h00400010, encode_itype(`OP_ORI, 5'd1, 5'd5, 16'h0003));  // ORI  $5, $1, 3   -> $5 = 5 | 3 = 7
        write_instruction_memory(32'h00400014, encode_itype(`OP_XORI, 5'd1, 5'd6, 16'h0003)); // XORI $6, $1, 3   -> $6 = 5 ^ 3 = 6
        write_instruction_memory(32'h00400018, encode_itype(`OP_SLTI, 5'd1, 5'd7, 16'd10));  // SLTI $7, $1, 10  -> $7 = (5 < 10) ? 1 : 0 = 1
        write_instruction_memory(32'h0040001C, encode_itype(`OP_SLTI, 5'd3, 5'd8, 16'd10));  // SLTI $8, $3, 10  -> $8 = (15 < 10) ? 0 : 0 = 0
        
        // Test 2: Load Word (LW)
        $display("\nTest 2: Load Word (LW)");
        // First, write some data to memory
        write_data_memory(32'h00000000, 32'hDEADBEEF);
        write_data_memory(32'h00000004, 32'hCAFEBABE);
        write_data_memory(32'h00000008, 32'h12345678);
        // Now load instructions
        write_instruction_memory(32'h00400020, encode_itype(`OP_ADDI, 5'd0, 5'd9, 16'd0));   // ADDI $9, $0, 0    -> $9 = 0 (base address)
        write_instruction_memory(32'h00400024, encode_itype(`OP_LW, 5'd9, 5'd10, 16'd0));     // LW   $10, 0($9)  -> $10 = mem[0] = 0xDEADBEEF
        write_instruction_memory(32'h00400028, encode_itype(`OP_LW, 5'd9, 5'd11, 16'd4));     // LW   $11, 4($9)  -> $11 = mem[4] = 0xCAFEBABE
        write_instruction_memory(32'h0040002C, encode_itype(`OP_LW, 5'd9, 5'd12, 16'd8));     // LW   $12, 8($9)  -> $12 = mem[8] = 0x12345678
        
        // Test 3: Store Word (SW)
        $display("\nTest 3: Store Word (SW)");
        write_instruction_memory(32'h00400030, encode_itype(`OP_ADDI, 5'd0, 5'd13, 16'd100)); // ADDI $13, $0, 100 -> $13 = 100
        write_instruction_memory(32'h00400034, encode_itype(`OP_SW, 5'd9, 5'd13, 16'd12));    // SW   $13, 12($9) -> mem[12] = $13 = 100
        write_instruction_memory(32'h00400038, encode_itype(`OP_LW, 5'd9, 5'd14, 16'd12));    // LW   $14, 12($9)  -> $14 = mem[12] = 100
        
        // Test 4: Branch Instructions (BEQ, BNE)
        $display("\nTest 4: Branch Instructions (BEQ, BNE)");
        write_instruction_memory(32'h0040003C, encode_itype(`OP_ADDI, 5'd0, 5'd15, 16'd5));   // ADDI $15, $0, 5   -> $15 = 5
        write_instruction_memory(32'h00400040, encode_itype(`OP_ADDI, 5'd0, 5'd16, 16'd5));   // ADDI $16, $0, 5   -> $16 = 5
        write_instruction_memory(32'h00400044, encode_itype(`OP_ADDI, 5'd0, 5'd17, 16'd3));  // ADDI $17, $0, 3   -> $17 = 3
        // BEQ $15, $16, 4  -> if ($15 == $16) branch to PC+4+4*4 = PC+20 = 0x00400058
        write_instruction_memory(32'h00400048, encode_itype(`OP_BEQ, 5'd15, 5'd16, 16'd4));  // BEQ  $15, $16, 4  (should branch)
        write_instruction_memory(32'h0040004C, encode_itype(`OP_ADDI, 5'd0, 5'd18, 16'd99));  // ADDI $18, $0, 99  (should be skipped)
        write_instruction_memory(32'h00400050, encode_itype(`OP_ADDI, 5'd0, 5'd18, 16'd42)); // ADDI $18, $0, 42  (branch target)
        // BNE $15, $17, 4  -> if ($15 != $17) branch to PC+4+4*4 = PC+20 = 0x00400064
        write_instruction_memory(32'h00400054, encode_itype(`OP_BNE, 5'd15, 5'd17, 16'd4));  // BNE  $15, $17, 4  (should branch)
        write_instruction_memory(32'h00400058, encode_itype(`OP_ADDI, 5'd0, 5'd19, 16'd99)); // ADDI $19, $0, 99  (should be skipped)
        write_instruction_memory(32'h0040005C, encode_itype(`OP_ADDI, 5'd0, 5'd19, 16'd77)); // ADDI $19, $0, 77  (branch target)
        
        // Test 5: Jump Instructions (J, JAL)
        $display("\nTest 5: Jump Instructions (J, JAL)");
        write_instruction_memory(32'h00400060, encode_itype(`OP_ADDI, 5'd0, 5'd20, 16'd10)); // ADDI $20, $0, 10  -> $20 = 10
        // J target: jump to 0x00400080 (target address = 0x00400080 >> 2 = 0x00100020)
        write_instruction_memory(32'h00400064, encode_jtype(`OP_J, 26'h00100020));           // J    0x00400080
        write_instruction_memory(32'h00400068, encode_itype(`OP_ADDI, 5'd0, 5'd21, 16'd99));  // ADDI $21, $0, 99  (should be skipped)
        write_instruction_memory(32'h0040006C, encode_itype(`OP_ADDI, 5'd0, 5'd21, 16'd99)); // ADDI $21, $0, 99  (should be skipped)
        write_instruction_memory(32'h00400070, encode_itype(`OP_ADDI, 5'd0, 5'd21, 16'd99));  // ADDI $21, $0, 99  (should be skipped)
        write_instruction_memory(32'h00400074, encode_itype(`OP_ADDI, 5'd0, 5'd21, 16'd99)); // ADDI $21, $0, 99  (should be skipped)
        write_instruction_memory(32'h00400078, encode_itype(`OP_ADDI, 5'd0, 5'd21, 16'd99)); // ADDI $21, $0, 99  (should be skipped)
        write_instruction_memory(32'h0040007C, encode_itype(`OP_ADDI, 5'd0, 5'd21, 16'd99));  // ADDI $21, $0, 99  (should be skipped)
        write_instruction_memory(32'h00400080, encode_itype(`OP_ADDI, 5'd0, 5'd21, 16'd50)); // ADDI $21, $0, 50  (jump target)
        // JAL target: jump to 0x00400090, save PC+4 to $31
        write_instruction_memory(32'h00400084, encode_jtype(`OP_JAL, 26'h00100024));         // JAL  0x00400090
        write_instruction_memory(32'h00400088, encode_itype(`OP_ADDI, 5'd0, 5'd22, 16'd99));  // ADDI $22, $0, 99  (should be skipped)
        write_instruction_memory(32'h0040008C, encode_itype(`OP_ADDI, 5'd0, 5'd22, 16'd99));  // ADDI $22, $0, 99  (should be skipped)
        write_instruction_memory(32'h00400090, encode_itype(`OP_ADDI, 5'd0, 5'd22, 16'd60));  // ADDI $22, $0, 60  (JAL target)
        
        // Test 6: Jump Register (JR)
        $display("\nTest 6: Jump Register (JR)");
        write_instruction_memory(32'h00400094, encode_itype(`OP_ADDI, 5'd0, 5'd23, 16'h00A0)); // ADDI $23, $0, 0xA0 -> $23 = 160
        write_instruction_memory(32'h00400098, encode_itype(`OP_ADDI, 5'd23, 5'd23, 16'h0004)); // ADDI $23, $23, 4 -> $23 = 164 = 0x004000A4
        // JR $23: jump to address in $23 = 0x004000A4
        write_instruction_memory(32'h0040009C, {6'b000000, 5'd23, 5'b00000, 5'b00000, 6'b001000}); // JR $23
        write_instruction_memory(32'h004000A0, encode_itype(`OP_ADDI, 5'd0, 5'd24, 16'd99));  // ADDI $24, $0, 99  (should be skipped)
        write_instruction_memory(32'h004000A4, encode_itype(`OP_ADDI, 5'd0, 5'd24, 16'd70)); // ADDI $24, $0, 70  (JR target)
        
        // Test 7: Negative immediate values
        $display("\nTest 7: Negative Immediate Values");
        write_instruction_memory(32'h004000A8, encode_itype(`OP_ADDI, 5'd0, 5'd25, 16'hFFFF)); // ADDI $25, $0, -1  -> $25 = -1
        write_instruction_memory(32'h004000AC, encode_itype(`OP_ADDI, 5'd25, 5'd26, 16'hFFFE)); // ADDI $26, $25, -2 -> $26 = -3
        
        // Test 8: Edge cases for branches
        $display("\nTest 8: Edge Cases for Branches");
        write_instruction_memory(32'h004000B0, encode_itype(`OP_ADDI, 5'd0, 5'd27, 16'd0));  // ADDI $27, $0, 0   -> $27 = 0
        write_instruction_memory(32'h004000B4, encode_itype(`OP_BEQ, 5'd27, 5'd0, 16'd4));   // BEQ  $27, $0, 4   (should branch: 0 == 0)
        write_instruction_memory(32'h004000B8, encode_itype(`OP_ADDI, 5'd0, 5'd28, 16'd99)); // ADDI $28, $0, 99  (should be skipped)
        write_instruction_memory(32'h004000BC, encode_itype(`OP_ADDI, 5'd0, 5'd28, 16'd88)); // ADDI $28, $0, 88  (branch target)
        
        // End of tests - add a marker instruction
        write_instruction_memory(32'h004000C0, encode_itype(`OP_ADDI, 5'd0, 5'd29, 16'd200)); // ADDI $29, $0, 200 -> $29 = 200 (test complete marker)
        
        $display("\n=== Initialization ===");
        // Now initialize and reset CPU AFTER all instructions are loaded
        rst = 1;
        wait_cycles(4);
        rst = 0;
        wait_cycles(2);
        $display("  CPU reset complete");
        $display("  PC should be at 0x%08h", `I_START_ADDRESS);
        $display("  Cycle count: %0d\n", cycle_count);
        
        // Verify initial state
        $display("=== Verifying Initial State ===");
        check_register(0, 32'h00000000, "Register $0 (must always be 0)");
        
        $display("\n=== Running Simulation ===");
        $display("Allowing CPU to execute instructions...");
        $display("Total instructions loaded. Waiting for execution...\n");
        
        // Wait for instruction execution cycles
        // Each instruction takes multiple cycles, so wait enough cycles
        // Wait until PC reaches end of test instructions or timeout
        begin
            automatic int timeout = 0;
            while (dbg_PC < 32'h004000C4 && timeout < 2000) begin
                @(posedge clk);
                timeout++;
                if (timeout % 200 == 0) begin
                    $display("  [Cycle %0d] PC = 0x%08h (waiting for 0x004000C4)", cycle_count, dbg_PC);
                end
            end
            if (dbg_PC >= 32'h004000C4) begin
                $display("  ✓ PC reached 0x004000C4 at cycle %0d", cycle_count);
            end else begin
                $display("  ⚠ Timeout: PC = 0x%08h (expected >= 0x004000C4)", dbg_PC);
            end
        end
        
        // Wait additional cycles for last instruction writeback
        wait_cycles(20);
        $display("  Completed %0d cycles", cycle_count);
        $display("  Final PC: 0x%08h\n", dbg_PC);
        
        // Verify results
        $display("=== Verifying Results ===");
        
        // Test 1: I-Type Immediate Instructions
        $display("\nTest 1: I-Type Immediate Instructions");
        check_register(1, 32'd5, "ADDI: $1 = 5");
        check_register(2, 32'd3, "ADDI: $2 = 3");
        check_register(3, 32'd15, "ADDI: $3 = 15 (5 + 10)");
        check_register(4, 32'd1, "ANDI: $4 = 1 (5 & 3)");
        check_register(5, 32'd7, "ORI: $5 = 7 (5 | 3)");
        check_register(6, 32'd6, "XORI: $6 = 6 (5 ^ 3)");
        check_register(7, 32'd1, "SLTI: $7 = 1 (5 < 10)");
        check_register(8, 32'd0, "SLTI: $8 = 0 (15 < 10 is false)");
        
        // Test 2: Load Word
        $display("\nTest 2: Load Word (LW)");
        check_register(10, 32'hDEADBEEF, "LW: $10 = mem[0] = 0xDEADBEEF");
        check_register(11, 32'hCAFEBABE, "LW: $11 = mem[4] = 0xCAFEBABE");
        check_register(12, 32'h12345678, "LW: $12 = mem[8] = 0x12345678");
        
        // Test 3: Store Word
        $display("\nTest 3: Store Word (SW)");
        check_register(14, 32'd100, "LW after SW: $14 = mem[12] = 100");
        
        // Test 4: Branch Instructions
        $display("\nTest 4: Branch Instructions");
        check_register(18, 32'd42, "BEQ branch: $18 = 42 (branch taken)");
        check_register(19, 32'd77, "BNE branch: $19 = 77 (branch taken)");
        
        // Test 5: Jump Instructions
        $display("\nTest 5: Jump Instructions");
        check_register(21, 32'd50, "J jump: $21 = 50 (jump taken)");
        check_register(22, 32'd60, "JAL jump: $22 = 60 (jump taken)");
        check_register(31, 32'h00400088, "JAL: $31 = PC+4 = 0x00400088");
        
        // Test 6: Jump Register
        $display("\nTest 6: Jump Register (JR)");
        check_register(24, 32'd70, "JR: $24 = 70 (jump taken)");
        
        // Test 7: Negative Immediate Values
        $display("\nTest 7: Negative Immediate Values");
        check_register(25, 32'hFFFFFFFF, "ADDI negative: $25 = -1");
        check_register(26, 32'hFFFFFFFD, "ADDI negative: $26 = -3");
        
        // Test 8: Edge Cases
        $display("\nTest 8: Edge Cases");
        check_register(28, 32'd88, "BEQ edge case: $28 = 88 (0 == 0 branch)");
        
        // Test complete marker
        check_register(29, 32'd200, "Test complete marker: $29 = 200");
        
        // Summary
        $display("\n========================================");
        $display("Test Summary");
        $display("========================================");
        $display("Total tests: %0d", test_count);
        $display("Passed: %0d", pass_count);
        $display("Failed: %0d", fail_count);
        $display("Total cycles: %0d", cycle_count);
        if (fail_count == 0) begin
            $display("✓ All tests passed!");
        end else begin
            $display("✗ Some tests failed");
        end
        $display("========================================");
        
        #100;
        $finish;
    end

endmodule

