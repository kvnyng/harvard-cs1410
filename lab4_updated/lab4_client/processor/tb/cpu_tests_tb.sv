`timescale 1ns / 1ps
`include "../source/cpu.svh"

module cpu_tests_tb();

    // Clock and control signals
    logic clk = 0;
    logic clk_en = 1;
    logic rst = 1;
    
    // CPU interface signals
    logic [31:0] r_data;
    logic wr_en;
    logic [31:0] mem_addr, w_data;
    logic [31:0] regs_ok [0:31];
    
    // External memory instance (for testbench)
    rw_ram main_memory (
        .clk(clk),
        .clk_en(clk_en),
        .wr_en(wr_en),
        .addr(mem_addr),
        .w_data(w_data),
        .r_data(r_data)
    );
    
    // Test parameters (set by build script via define)
    `ifdef INSTR_MEM_FILE
        parameter string INSTR_MEM_FILE = `INSTR_MEM_FILE;
    `else
        parameter string INSTR_MEM_FILE = "tests/rtype_tests_instr.mem";
    `endif
    
    `ifdef DATA_MEM_FILE
        parameter string DATA_MEM_FILE = `DATA_MEM_FILE;
    `else
        parameter string DATA_MEM_FILE = "";
    `endif
    
    `ifdef MAX_CYCLES
        parameter int MAX_CYCLES = `MAX_CYCLES;
    `else
        parameter int MAX_CYCLES = 1000;
    `endif
    
    
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
        .regs_ok(regs_ok)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    // Cycle counter for debugging
    int cycle_count = 0;
    always @(posedge clk) begin
        if (!rst) begin
            cycle_count <= cycle_count + 1;
        end else begin
            cycle_count <= 0;
        end
    end
    
    // Debug: Monitor state transitions and SW/LW instructions
    always @(posedge clk) begin
        if (!rst && cycle_count > 10) begin
            // SW instruction is at 0x0040004c (instruction 19, 0-indexed)
            // LW instruction is at 0x00400050 (instruction 20, 0-indexed)
            if (cpu_inst.dbg_PC >= 32'h00400048 && cpu_inst.dbg_PC <= 32'h00400058) begin
                // State name mapping
                string state_name;
                string next_state_name;
                case (cpu_inst.dbg_current_state)
                    4'd0: state_name = "S0_FETCH";
                    4'd1: state_name = "S1_DECODE_WAIT";
                    4'd2: state_name = "S1_DECODE";
                    4'd3: state_name = "S2_ADDR";
                    4'd4: state_name = "S3_MEMRD";
                    4'd5: state_name = "S4_MEMWB";
                    4'd6: state_name = "S5_MEMWR";
                    4'd7: state_name = "S6_EXEC";
                    4'd8: state_name = "S7_ALUWB";
                    4'd9: state_name = "S8_BRANCH";
                    4'd10: state_name = "S9_EXI";
                    4'd11: state_name = "S10_WBI";
                    4'd12: state_name = "S11_JUMP";
                    default: state_name = "UNKNOWN";
                endcase
                case (cpu_inst.dbg_next_state)
                    4'd0: next_state_name = "S0_FETCH";
                    4'd1: next_state_name = "S1_DECODE_WAIT";
                    4'd2: next_state_name = "S1_DECODE";
                    4'd3: next_state_name = "S2_ADDR";
                    4'd4: next_state_name = "S3_MEMRD";
                    4'd5: next_state_name = "S4_MEMWB";
                    4'd6: next_state_name = "S5_MEMWR";
                    4'd7: next_state_name = "S6_EXEC";
                    4'd8: next_state_name = "S7_ALUWB";
                    4'd9: next_state_name = "S8_BRANCH";
                    4'd10: next_state_name = "S9_EXI";
                    4'd11: next_state_name = "S10_WBI";
                    4'd12: next_state_name = "S11_JUMP";
                    default: next_state_name = "UNKNOWN";
                endcase
                
                $display("[DEBUG] Cycle %0d | PC=0x%08h | State=%0d(%s) | NextState=%0d(%s) | Opcode=0x%02h | Instr=0x%08h | DecodeResult=%0d | OpcodeHasXZ=%0d | isLW=%0d | isSW=%0d | isR=%0d | isJR=%0d", 
                    cycle_count, cpu_inst.dbg_PC, cpu_inst.dbg_current_state, state_name, 
                    cpu_inst.dbg_next_state, next_state_name,
                    cpu_inst.dbg_opcode, cpu_inst.dbg_instruction_reg, cpu_inst.dbg_decode_result, cpu_inst.dbg_opcode_has_xz,
                    cpu_inst.dbg_isLW, cpu_inst.dbg_isSW, cpu_inst.dbg_isR, cpu_inst.dbg_isJR);
                
                // Check for SW (opcode 0x2b = 43)
                if (cpu_inst.dbg_opcode == 6'h2b) begin
                    case (cpu_inst.dbg_current_state)
                        4'd1: begin // S1_DECODE_WAIT
                            $display("  [SW WAIT] Waiting for instruction to settle");
                        end
                        4'd2: begin // S1_DECODE
                            $display("  [SW DECODE] rs=$t1=%0d, rt=$s1=%0d, imm=4", 
                                cpu_inst.dbg_instruction_reg_rs, cpu_inst.dbg_instruction_reg_rt);
                            $display("  [SW DECODE] Register_File_A ($t1) = 0x%08h (%0d)", 
                                cpu_inst.dbg_Register_File_A, cpu_inst.dbg_Register_File_A);
                            $display("  [SW DECODE] Register_File_B ($s1) = 0x%08h (%0d)", 
                                cpu_inst.dbg_Register_File_B, cpu_inst.dbg_Register_File_B);
                        end
                        4'd3: begin // S2_ADDR
                            $display("  [SW S2_ADDR] Calculating address: rs + imm");
                            $display("  [SW S2_ADDR] rs ($t1) = 0x%08h (%0d)", 
                                cpu_inst.dbg_Register_File_A, cpu_inst.dbg_Register_File_A);
                            $display("  [SW S2_ADDR] imm_16 = 0x%04h (%0d)", 
                                cpu_inst.dbg_imm_16, cpu_inst.dbg_imm_16);
                            $display("  [SW S2_ADDR] SignImm = 0x%08h (%0d)", 
                                cpu_inst.dbg_SignImm, cpu_inst.dbg_SignImm);
                            $display("  [SW S2_ADDR] ZeroImm = 0x%08h (%0d)", 
                                cpu_inst.dbg_ZeroImm, cpu_inst.dbg_ZeroImm);
                            $display("  [SW S2_ADDR] ImmValue = 0x%08h (%0d)", 
                                cpu_inst.dbg_ImmValue, cpu_inst.dbg_ImmValue);
                            $display("  [SW S2_ADDR] ALUResult = 0x%08h (%0d)", 
                                cpu_inst.dbg_ALUResult, cpu_inst.dbg_ALUResult);
                        end
                        4'd5: begin // S5_MEMWR
                            $display("  [SW S5_MEMWR] Writing to memory");
                            $display("  [SW S5_MEMWR] mem_addr = 0x%08h (%0d)", mem_addr, mem_addr);
                            $display("  [SW S5_MEMWR] w_data = 0x%08h (%0d)", w_data, w_data);
                            $display("  [SW S5_MEMWR] wr_en = %0d", wr_en);
                            $display("  [SW S5_MEMWR] IorD should be 1, checking...");
                        end
                    endcase
                end
                
                // Check for LW (opcode 0x23 = 35)
                if (cpu_inst.dbg_opcode == 6'h23) begin
                    case (cpu_inst.dbg_current_state)
                        4'd1: begin // S1_DECODE
                            $display("  [LW DECODE] rs=$t1=%0d, rt=$t2=%0d, imm=4", 
                                cpu_inst.dbg_instruction_reg_rs, cpu_inst.dbg_instruction_reg_rt);
                            $display("  [LW DECODE] Register_File_A ($t1) = 0x%08h (%0d)", 
                                cpu_inst.dbg_Register_File_A, cpu_inst.dbg_Register_File_A);
                        end
                        4'd2: begin // S2_ADDR
                            $display("  [LW S2_ADDR] Calculating address: rs + imm");
                            $display("  [LW S2_ADDR] rs ($t1) = 0x%08h (%0d)", 
                                cpu_inst.dbg_Register_File_A, cpu_inst.dbg_Register_File_A);
                            $display("  [LW S2_ADDR] imm_16 = 0x%04h (%0d)", 
                                cpu_inst.dbg_imm_16, cpu_inst.dbg_imm_16);
                            $display("  [LW S2_ADDR] SignImm = 0x%08h (%0d)", 
                                cpu_inst.dbg_SignImm, cpu_inst.dbg_SignImm);
                            $display("  [LW S2_ADDR] ZeroImm = 0x%08h (%0d)", 
                                cpu_inst.dbg_ZeroImm, cpu_inst.dbg_ZeroImm);
                            $display("  [LW S2_ADDR] ImmValue = 0x%08h (%0d)", 
                                cpu_inst.dbg_ImmValue, cpu_inst.dbg_ImmValue);
                            $display("  [LW S2_ADDR] ALUResult = 0x%08h (%0d)", 
                                cpu_inst.dbg_ALUResult, cpu_inst.dbg_ALUResult);
                        end
                        4'd3: begin // S3_MEMRD
                            $display("  [LW S3_MEMRD] Reading from memory");
                            $display("  [LW S3_MEMRD] mem_addr = 0x%08h (%0d)", mem_addr, mem_addr);
                            $display("  [LW S3_MEMRD] ALUOut = 0x%08h (%0d)", 
                                cpu_inst.dbg_ALUOut, cpu_inst.dbg_ALUOut);
                            $display("  [LW S3_MEMRD] r_data = 0x%08h (%0d)", r_data, r_data);
                        end
                        4'd4: begin // S4_MEMWB
                            $display("  [LW S4_MEMWB] Capturing memory data");
                            $display("  [LW S4_MEMWB] mem_addr = 0x%08h (%0d)", mem_addr, mem_addr);
                            $display("  [LW S4_MEMWB] r_data = 0x%08h (%0d)", r_data, r_data);
                            $display("  [LW S4_MEMWB] ALUOut = 0x%08h (%0d)", 
                                cpu_inst.dbg_ALUOut, cpu_inst.dbg_ALUOut);
                        end
                        4'd10: begin // S10_WBI
                            $display("  [LW S10_WBI] Writing back to register");
                            $display("  [LW S10_WBI] w_addr = %0d ($t2)", cpu_inst.dbg_reg_file_w_addr);
                            $display("  [LW S10_WBI] w_data = 0x%08h (%0d)", 
                                cpu_inst.dbg_reg_file_w_data, cpu_inst.dbg_reg_file_w_data);
                            $display("  [LW S10_WBI] RegWrite = %0d", cpu_inst.dbg_RegWrite);
                        end
                    endcase
                end
            end
        end
    end
    
    // Task to load memory from file
    task automatic load_memory_from_file(input string filename, input logic is_instruction);
        int file;
        logic [31:0] addr;
        logic [31:0] data;
        int phy_i_addr, phy_d_addr;
        automatic int count = 0;
        
        file = $fopen(filename, "r");
        if (file == 0) begin
            $display("ERROR: Could not open file: %s", filename);
            $finish;
        end
        
        addr = is_instruction ? `I_START_ADDRESS : 32'h0;
        
        // Read hex values from file (one per line)
        while (!$feof(file)) begin
            int scan_result;
            scan_result = $fscanf(file, "%h", data);
            if (scan_result == 1) begin
                // Calculate physical address
                if (is_instruction) begin
                    phy_i_addr = addr[10:2];
                    main_memory.imem[phy_i_addr] = data;
                end else begin
                    phy_d_addr = addr[11:2];
                    main_memory.dmem[phy_d_addr] = data;
                end
                addr = addr + 4;
                count++;
            end else begin
                // Skip to next line if scan failed
                string line;
                $fgets(line, file);
            end
        end
        
        $fclose(file);
        $display("  Loaded %0d words from %s", count, filename);
    endtask
    
    initial begin
        $display("========================================");
        $display("CPU Tests Testbench");
        $display("========================================");
        $display("Instruction Memory: %s", INSTR_MEM_FILE);
        $display("Data Memory: %s", DATA_MEM_FILE);
        $display("");
        
        // Reset
        rst = 1;
        #20;
        rst = 0;
        #10;
        
        // Load instruction memory
        $display("Loading instruction memory...");
        load_memory_from_file(INSTR_MEM_FILE, 1);
        
        // Load data memory (if file exists)
        if (DATA_MEM_FILE != "") begin
            $display("Loading data memory...");
            load_memory_from_file(DATA_MEM_FILE, 0);
        end
        
        $display("");
        $display("Starting simulation...");
        $display("Maximum cycles: %0d", MAX_CYCLES);
        $display("");
        
        // Wait for execution - use MAX_CYCLES to ensure all instructions complete
        // Each instruction takes 4 cycles, so MAX_CYCLES should be sufficient
        repeat(MAX_CYCLES) @(posedge clk);
        
        #200; // Wait for final writeback
        
        // Output register values in expected format
        $display("");
        $display("REGS:");
        $display("");
        
        // Output each register with its name
        $display("Reg 0 ($zero)  :  0x%08h", regs_ok[0]);
        $display("Reg 1 ($at)   :  0x%08h", regs_ok[1]);
        $display("Reg 2 ($v0)   :  0x%08h", regs_ok[2]);
        $display("Reg 3 ($v1)   :  0x%08h", regs_ok[3]);
        $display("Reg 4 ($a0)   :  0x%08h", regs_ok[4]);
        $display("Reg 5 ($a1)   :  0x%08h", regs_ok[5]);
        $display("Reg 6 ($a2)   :  0x%08h", regs_ok[6]);
        $display("Reg 7 ($a3)   :  0x%08h", regs_ok[7]);
        $display("Reg 8 ($t0)   :  0x%08h", regs_ok[8]);
        $display("Reg 9 ($t1)   :  0x%08h", regs_ok[9]);
        $display("Reg 10 ($t2)  :  0x%08h", regs_ok[10]);
        $display("Reg 11 ($t3)  :  0x%08h", regs_ok[11]);
        $display("Reg 12 ($t4)  :  0x%08h", regs_ok[12]);
        $display("Reg 13 ($t5)  :  0x%08h", regs_ok[13]);
        $display("Reg 14 ($t6)  :  0x%08h", regs_ok[14]);
        $display("Reg 15 ($t7)  :  0x%08h", regs_ok[15]);
        $display("Reg 16 ($s0)  :  0x%08h", regs_ok[16]);
        $display("Reg 17 ($s1)  :  0x%08h", regs_ok[17]);
        $display("Reg 18 ($s2)  :  0x%08h", regs_ok[18]);
        $display("Reg 19 ($s3)  :  0x%08h", regs_ok[19]);
        $display("Reg 20 ($s4)  :  0x%08h", regs_ok[20]);
        $display("Reg 21 ($s5)  :  0x%08h", regs_ok[21]);
        $display("Reg 22 ($s6)  :  0x%08h", regs_ok[22]);
        $display("Reg 23 ($s7)  :  0x%08h", regs_ok[23]);
        $display("Reg 24 ($t8)  :  0x%08h", regs_ok[24]);
        $display("Reg 25 ($t9)  :  0x%08h", regs_ok[25]);
        $display("Reg 26 ($k0)  :  0x%08h", regs_ok[26]);
        $display("Reg 27 ($k1)  :  0x%08h", regs_ok[27]);
        $display("Reg 28 ($gp)  :  0x%08h", regs_ok[28]);
        $display("Reg 29 ($sp)  :  0x%08h", regs_ok[29]);
        $display("Reg 30 ($fp)  :  0x%08h", regs_ok[30]);
        $display("Reg 31 ($ra)  :  0x%08h", regs_ok[31]);
        
        $display("");
        $display("Simulation completed");
        
        $finish;
    end

endmodule

