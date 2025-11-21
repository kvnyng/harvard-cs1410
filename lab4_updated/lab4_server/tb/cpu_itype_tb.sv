`timescale 1ns / 1ps
`include "../source/cpu.svh"

module cpu_itype_tb();

    // Clock and control signals
    logic clk = 0;
    logic clk_en = 1;
    logic rst = 1;
    
    // CPU interface signals
    logic [31:0] r_data;
    logic wr_en;
    logic [31:0] mem_addr, w_data;
    logic [31:0] regs_ok [0:31];
    
    // Simulated memory
    logic [31:0] memory [0:2097151];
    
    // Test results tracking
    int test_count = 0;
    int pass_count = 0;
    int fail_count = 0;
    int cycle_count = 0;
    
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
    
    // Memory simulation
    always_ff @(posedge clk) begin
        if (wr_en) begin
            logic [31:0] idx = mem_addr >> 2;
            if (mem_addr < 32'h00800000) begin
                memory[idx] <= w_data;
            end
        end
    end
    
    always_comb begin
        logic [31:0] idx = mem_addr >> 2;
        if (mem_addr >= `I_START_ADDRESS && mem_addr < 32'h00800000) begin
            r_data = memory[idx];
        end else if (mem_addr < 32'h00400000) begin
            r_data = memory[idx];
        end else begin
            r_data = 32'h00000000;
        end
    end
    
    // Helper function to encode I-type instruction
    function automatic [31:0] encode_itype(input [5:0] opcode, input [4:0] rs, input [4:0] rt, input [15:0] imm);
        encode_itype = {opcode, rs, rt, imm};
    endfunction
    
    // Helper function to write instruction to memory
    task automatic write_instruction_memory(input [31:0] addr, input [31:0] instr);
        logic [31:0] idx = addr >> 2;
        memory[idx] = instr;
    endtask
    
    initial begin
        $display("========================================");
        $display("CPU I-Type Instructions Testbench");
        $display("Testing ADDI, ANDI, ORI, XORI, SLTI");
        $display("========================================\n");
        
        // Initialize memory to zeros
        for (int i = 0; i < 2097152; i++) begin
            memory[i] = 32'h00000000;
        end
        
        $display("\n=== Loading I-Type Instructions ===");
        
        // Test 1: ADDI (Add Immediate) - sign extension
        write_instruction_memory(32'h00400000, encode_itype(`OP_ADDI, 5'd0, 5'd1, 16'd5));      // ADDI $1, $0, 5      -> $1 = 5
        write_instruction_memory(32'h00400004, encode_itype(`OP_ADDI, 5'd0, 5'd2, 16'd10));     // ADDI $2, $0, 10     -> $2 = 10
        write_instruction_memory(32'h00400008, encode_itype(`OP_ADDI, 5'd1, 5'd3, 16'd15));    // ADDI $3, $1, 15     -> $3 = 5 + 15 = 20
        write_instruction_memory(32'h0040000C, encode_itype(`OP_ADDI, 5'd1, 5'd4, 16'hFFFF));  // ADDI $4, $1, -1     -> $4 = 5 + (-1) = 4
        write_instruction_memory(32'h00400010, encode_itype(`OP_ADDI, 5'd0, 5'd5, 16'h8000));  // ADDI $5, $0, -32768 -> $5 = -32768
        
        // Test 2: ANDI (And Immediate) - zero extension
        write_instruction_memory(32'h00400014, encode_itype(`OP_ANDI, 5'd1, 5'd6, 16'h0003));   // ANDI $6, $1, 3      -> $6 = 5 & 3 = 1
        write_instruction_memory(32'h00400018, encode_itype(`OP_ANDI, 5'd2, 5'd7, 16'h000F));   // ANDI $7, $2, 15     -> $7 = 10 & 15 = 10
        write_instruction_memory(32'h0040001C, encode_itype(`OP_ANDI, 5'd0, 5'd8, 16'hFFFF));   // ANDI $8, $0, 0xFFFF -> $8 = 0 & 0xFFFF = 0
        write_instruction_memory(32'h00400020, encode_itype(`OP_ANDI, 5'd2, 5'd9, 16'hFF00));   // ANDI $9, $2, 0xFF00 -> $9 = 10 & 0xFF00 = 0
        
        // Test 3: ORI (Or Immediate) - zero extension
        write_instruction_memory(32'h00400024, encode_itype(`OP_ORI, 5'd1, 5'd10, 16'h0003));   // ORI $10, $1, 3      -> $10 = 5 | 3 = 7
        write_instruction_memory(32'h00400028, encode_itype(`OP_ORI, 5'd0, 5'd11, 16'h00FF));    // ORI $11, $0, 0xFF   -> $11 = 0 | 0xFF = 255
        write_instruction_memory(32'h0040002C, encode_itype(`OP_ORI, 5'd2, 5'd12, 16'hF000));   // ORI $12, $2, 0xF000 -> $12 = 10 | 0xF000 = 0xF00A
        
        // Test 4: XORI (Xor Immediate) - zero extension
        write_instruction_memory(32'h00400030, encode_itype(`OP_XORI, 5'd1, 5'd13, 16'h0003));  // XORI $13, $1, 3     -> $13 = 5 ^ 3 = 6
        write_instruction_memory(32'h00400034, encode_itype(`OP_XORI, 5'd2, 5'd14, 16'h000F));  // XORI $14, $2, 15    -> $14 = 10 ^ 15 = 5
        write_instruction_memory(32'h00400038, encode_itype(`OP_XORI, 5'd0, 5'd15, 16'hFFFF));  // XORI $15, $0, 0xFFFF -> $15 = 0 ^ 0xFFFF = 0xFFFF
        
        // Test 5: SLTI (Set Less Than Immediate) - sign extension
        write_instruction_memory(32'h0040003C, encode_itype(`OP_SLTI, 5'd1, 5'd16, 16'd10));   // SLTI $16, $1, 10    -> $16 = (5 < 10) ? 1 : 0 = 1
        write_instruction_memory(32'h00400040, encode_itype(`OP_SLTI, 5'd2, 5'd17, 16'd5));     // SLTI $17, $2, 5     -> $17 = (10 < 5) ? 1 : 0 = 0
        write_instruction_memory(32'h00400044, encode_itype(`OP_SLTI, 5'd1, 5'd18, 16'd5));    // SLTI $18, $1, 5     -> $18 = (5 < 5) ? 1 : 0 = 0
        write_instruction_memory(32'h00400048, encode_itype(`OP_SLTI, 5'd5, 5'd19, 16'd0));    // SLTI $19, $5, 0     -> $19 = (-32768 < 0) ? 1 : 0 = 1
        write_instruction_memory(32'h0040004C, encode_itype(`OP_SLTI, 5'd0, 5'd20, 16'hFFFF)); // SLTI $20, $0, -1    -> $20 = (0 < -1) ? 1 : 0 = 0
        
        // Test 6: Edge cases
        write_instruction_memory(32'h00400050, encode_itype(`OP_ADDI, 5'd0, 5'd21, 16'd0));    // ADDI $21, $0, 0     -> $21 = 0
        write_instruction_memory(32'h00400054, encode_itype(`OP_ADDI, 5'd21, 5'd22, 16'h7FFF)); // ADDI $22, $21, 32767 -> $22 = 32767
        write_instruction_memory(32'h00400058, encode_itype(`OP_ANDI, 5'd22, 5'd23, 16'h0000)); // ANDI $23, $22, 0    -> $23 = 0
        write_instruction_memory(32'h0040005C, encode_itype(`OP_ORI, 5'd0, 5'd24, 16'h0000));  // ORI $24, $0, 0      -> $24 = 0
        write_instruction_memory(32'h00400060, encode_itype(`OP_XORI, 5'd1, 5'd25, 16'h0000));  // XORI $25, $1, 0     -> $25 = 5 ^ 0 = 5
        
        // End with infinite loop
        write_instruction_memory(32'h00400064, 32'h08000019);  // J 0x00400064 (infinite loop)
        
        $display("Instructions loaded into memory\n");
        
        // Release reset after loading instructions
        #20;
        rst = 0;
        $display("Reset released at time %0t\n", $time);
        
        // Run simulation
        #5000;
        
        $display("\n========================================");
        $display("Test Results");
        $display("========================================");
        
        // Check results
        $display("\n=== Register Values ===");
        for (int i = 0; i < 32; i++) begin
            if (regs_ok[i] != 0) begin
                $display("Reg %0d ($%0s): 0x%08h (%0d)", i, 
                    (i == 0) ? "0" : (i == 1) ? "at" : (i == 2) ? "v0" : (i == 3) ? "v1" :
                    (i == 4) ? "a0" : (i == 5) ? "a1" : (i == 6) ? "a2" : (i == 7) ? "a3" :
                    (i == 8) ? "t0" : (i == 9) ? "t1" : (i == 10) ? "t2" : (i == 11) ? "t3" :
                    (i == 12) ? "t4" : (i == 13) ? "t5" : (i == 14) ? "t6" : (i == 15) ? "t7" :
                    (i == 16) ? "s0" : (i == 17) ? "s1" : (i == 18) ? "s2" : (i == 19) ? "s3" :
                    (i == 20) ? "s4" : (i == 21) ? "s5" : (i == 22) ? "s6" : (i == 23) ? "s7" :
                    (i == 24) ? "t8" : (i == 25) ? "t9" : (i == 26) ? "k0" : (i == 27) ? "k1" :
                    (i == 28) ? "gp" : (i == 29) ? "sp" : (i == 30) ? "fp" : "ra",
                    regs_ok[i], regs_ok[i]);
            end
        end
        
        // Verify test results
        $display("\n=== Verification ===");
        
        // Test 1: ADDI
        test_count++;
        if (regs_ok[1] == 32'd5 && regs_ok[2] == 32'd10 && regs_ok[3] == 32'd20 && 
            regs_ok[4] == 32'd4 && regs_ok[5] == 32'hFFFF8000) begin
            $display("PASS: ADDI instruction test");
            pass_count++;
        end else begin
            $display("FAIL: ADDI instruction test");
            if (regs_ok[1] != 32'd5) $display("  $1 = %0d (expected 5)", regs_ok[1]);
            if (regs_ok[2] != 32'd10) $display("  $2 = %0d (expected 10)", regs_ok[2]);
            if (regs_ok[3] != 32'd20) $display("  $3 = %0d (expected 20)", regs_ok[3]);
            if (regs_ok[4] != 32'd4) $display("  $4 = %0d (expected 4)", regs_ok[4]);
            if (regs_ok[5] != 32'hFFFF8000) $display("  $5 = 0x%08h (expected 0xFFFF8000)", regs_ok[5]);
            fail_count++;
        end
        
        // Test 2: ANDI
        test_count++;
        if (regs_ok[6] == 32'd1 && regs_ok[7] == 32'd10 && regs_ok[8] == 32'd0 && regs_ok[9] == 32'd0) begin
            $display("PASS: ANDI instruction test");
            pass_count++;
        end else begin
            $display("FAIL: ANDI instruction test");
            if (regs_ok[6] != 32'd1) $display("  $6 = %0d (expected 1)", regs_ok[6]);
            if (regs_ok[7] != 32'd10) $display("  $7 = %0d (expected 10)", regs_ok[7]);
            if (regs_ok[8] != 32'd0) $display("  $8 = %0d (expected 0)", regs_ok[8]);
            if (regs_ok[9] != 32'd0) $display("  $9 = %0d (expected 0)", regs_ok[9]);
            fail_count++;
        end
        
        // Test 3: ORI
        test_count++;
        if (regs_ok[10] == 32'd7 && regs_ok[11] == 32'd255 && regs_ok[12] == 32'h0000F00A) begin
            $display("PASS: ORI instruction test");
            pass_count++;
        end else begin
            $display("FAIL: ORI instruction test");
            if (regs_ok[10] != 32'd7) $display("  $10 = %0d (expected 7)", regs_ok[10]);
            if (regs_ok[11] != 32'd255) $display("  $11 = %0d (expected 255)", regs_ok[11]);
            if (regs_ok[12] != 32'h0000F00A) $display("  $12 = 0x%08h (expected 0x0000F00A)", regs_ok[12]);
            fail_count++;
        end
        
        // Test 4: XORI
        test_count++;
        if (regs_ok[13] == 32'd6 && regs_ok[14] == 32'd5 && regs_ok[15] == 32'h0000FFFF) begin
            $display("PASS: XORI instruction test");
            pass_count++;
        end else begin
            $display("FAIL: XORI instruction test");
            if (regs_ok[13] != 32'd6) $display("  $13 = %0d (expected 6)", regs_ok[13]);
            if (regs_ok[14] != 32'd5) $display("  $14 = %0d (expected 5)", regs_ok[14]);
            if (regs_ok[15] != 32'h0000FFFF) $display("  $15 = 0x%08h (expected 0x0000FFFF)", regs_ok[15]);
            fail_count++;
        end
        
        // Test 5: SLTI
        test_count++;
        if (regs_ok[16] == 32'd1 && regs_ok[17] == 32'd0 && regs_ok[18] == 32'd0 && 
            regs_ok[19] == 32'd1 && regs_ok[20] == 32'd0) begin
            $display("PASS: SLTI instruction test");
            pass_count++;
        end else begin
            $display("FAIL: SLTI instruction test");
            if (regs_ok[16] != 32'd1) $display("  $16 = %0d (expected 1)", regs_ok[16]);
            if (regs_ok[17] != 32'd0) $display("  $17 = %0d (expected 0)", regs_ok[17]);
            if (regs_ok[18] != 32'd0) $display("  $18 = %0d (expected 0)", regs_ok[18]);
            if (regs_ok[19] != 32'd1) $display("  $19 = %0d (expected 1)", regs_ok[19]);
            if (regs_ok[20] != 32'd0) $display("  $20 = %0d (expected 0)", regs_ok[20]);
            fail_count++;
        end
        
        // Test 6: Edge cases
        test_count++;
        if (regs_ok[21] == 32'd0 && regs_ok[22] == 32'd32767 && regs_ok[23] == 32'd0 && 
            regs_ok[24] == 32'd0 && regs_ok[25] == 32'd5) begin
            $display("PASS: Edge cases test");
            pass_count++;
        end else begin
            $display("FAIL: Edge cases test");
            fail_count++;
        end
        
        $display("\n========================================");
        $display("Summary: %0d tests, %0d passed, %0d failed", test_count, pass_count, fail_count);
        $display("========================================\n");
        
        if (fail_count == 0) begin
            $display("✓ All I-type instruction tests passed!");
        end else begin
            $display("✗ Some tests failed");
        end
        
        #100;
        $finish;
    end

endmodule

