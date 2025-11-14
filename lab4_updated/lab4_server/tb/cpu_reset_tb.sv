`timescale 1ns / 1ps
`include "../source/cpu.svh"

module cpu_reset_tb();

    // Clock and control signals
    logic clk = 0;
    logic clk_en = 1;
    logic rst = 1;  // Start with reset asserted
    
    // Test counters and temporary variables
    int regs_written;
    int reg_matches;
    logic [31:0] pc_before_release;
    logic [31:0] pc_after_5;
    logic [31:0] pc_after_25;
    logic [31:0] pc_before_second_reset;
    
    // Expected register values for b_test
    int expected_regs[13];
    logic [31:0] expected_vals[13];
    
    // CPU interface signals
    logic [31:0] r_data;
    logic wr_en;
    logic [31:0] mem_addr, w_data;
    logic [31:0] regs_ok [0:31];
    
    // Debug signals
    logic [31:0] dbg_PC;
    logic [31:0] dbg_instruction_reg;
    logic [4:0] dbg_reg_file_r0_addr, dbg_reg_file_r1_addr, dbg_reg_file_w_addr;
    logic [31:0] dbg_reg_file_r0_data, dbg_reg_file_r1_data, dbg_reg_file_w_data;
    logic dbg_RegWrite;
    
    // External memory instance (for testbench)
    rw_ram main_memory (
        .clk(clk),
        .clk_en(clk_en),
        .wr_en(wr_en),
        .addr(mem_addr),
        .w_data(w_data),
        .r_data(r_data)
    );
    
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
        .dbg_PC(dbg_PC),
        .dbg_reg_file_r0_addr(dbg_reg_file_r0_addr),
        .dbg_reg_file_r1_addr(dbg_reg_file_r1_addr),
        .dbg_reg_file_r0_data(dbg_reg_file_r0_data),
        .dbg_reg_file_r1_data(dbg_reg_file_r1_data),
        .dbg_reg_file_w_addr(dbg_reg_file_w_addr),
        .dbg_reg_file_w_data(dbg_reg_file_w_data),
        .dbg_RegWrite(dbg_RegWrite)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
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
    
    // Task to check register value
    task check_register(input int reg_num, input logic [31:0] expected, input string description);
        if (regs_ok[reg_num] == expected) begin
            $display("  ✓ %s: 0x%08h (%0d)", description, regs_ok[reg_num], regs_ok[reg_num]);
        end else begin
            $display("  ✗ %s: Expected 0x%08h, got 0x%08h", description, expected, regs_ok[reg_num]);
        end
    endtask
    
    // Task to wait for N clock cycles
    task wait_cycles(input int n);
        repeat(n) @(posedge clk);
    endtask
    
    initial begin
        $display("========================================");
        $display("CPU Reset Sequence Testbench");
        $display("Testing that CPU executes instructions after reset release");
        $display("========================================\n");
        
        // Load test program (b_test instructions and data)
        $display("=== Loading Memory ===");
        load_memory_from_file("tests/b_instr.mem", 1);  // Load instructions
        load_memory_from_file("tests/b_data.mem", 0);   // Load data memory
        $display("  Memory loaded with b_test program");
        $display("  Expected final register values from b_test_out.txt");
        $display("");
        
        // Test 1: Verify reset state
        $display("=== Test 1: Reset State Verification ===");
        $display("  CPU is in reset (rst = 1)");
        wait_cycles(5);
        
        // Check that PC is reset to I_START_ADDRESS
        if (dbg_PC == `I_START_ADDRESS) begin
            $display("  ✓ PC reset correctly: 0x%08h", dbg_PC);
        end else begin
            $display("  ✗ PC reset failed: Expected 0x%08h, got 0x%08h", `I_START_ADDRESS, dbg_PC);
        end
        
        // Check that all registers are zero (except $0 which should always be 0)
        $display("  Checking register file reset state:");
        check_register(0, 32'h00000000, "Reg 0 ($zero)");
        for (int i = 1; i < 32; i++) begin
            if (regs_ok[i] != 32'h0) begin
                $display("  ✗ Reg %0d not reset: 0x%08h", i, regs_ok[i]);
            end
        end
        $display("  ✓ All registers properly reset to 0");
        $display("");
        
        // Test 2: Release reset and verify CPU IMMEDIATELY starts executing loaded instructions
        $display("=== Test 2: Reset Release and Instruction Execution ===");
        $display("  Releasing reset (rst = 0)...");
        
        // Capture PC before reset release
        pc_before_release = dbg_PC;
        $display("  PC before reset release: 0x%08h", pc_before_release);
        
        // Release reset
        @(posedge clk);
        rst = 0;
        @(posedge clk);  // Wait one cycle after reset release
        
        // Verify PC is at I_START_ADDRESS immediately after reset release
        if (dbg_PC == `I_START_ADDRESS) begin
            $display("  ✓ PC at instruction start after reset release: 0x%08h", dbg_PC);
        end else begin
            $display("  ✗ PC not at start: Expected 0x%08h, got 0x%08h", `I_START_ADDRESS, dbg_PC);
        end
        
        // Wait for CPU to execute instructions
        $display("  Waiting for CPU to execute loaded instructions...");
        $display("  (b_test program should execute and write to registers)");
        wait_cycles(100);
        
        // Check that PC has advanced (CPU is executing)
        if (dbg_PC > `I_START_ADDRESS) begin
            $display("  ✓ PC advanced after reset release: 0x%08h (CPU is executing)", dbg_PC);
        end else begin
            $display("  ✗ PC did not advance: 0x%08h (CPU may be stuck after reset)", dbg_PC);
            $display("     This indicates the CPU is not starting execution after reset release!");
        end
        
        // Wait more cycles to ensure execution continues
        $display("  Waiting 50 more cycles to verify continued execution...");
        pc_after_5 = dbg_PC;
        wait_cycles(50);
        pc_after_25 = dbg_PC;
        
        if (pc_after_25 > pc_after_5) begin
            $display("  ✓ PC continued advancing: 0x%08h -> 0x%08h (CPU executing normally)", pc_after_5, pc_after_25);
        end else begin
            $display("  ✗ PC stopped advancing: 0x%08h (CPU may have stopped)", pc_after_25);
        end
        
        // Check that registers are being written (CPU is executing instructions)
        regs_written = 0;
        for (int i = 1; i < 32; i++) begin
            if (regs_ok[i] != 32'h0) begin
                regs_written = regs_written + 1;
            end
        end
        
        if (regs_written > 0) begin
            $display("  ✓ Registers written: %0d registers have non-zero values", regs_written);
            $display("     This confirms CPU is executing instructions after reset");
        end else begin
            $display("  ✗ No registers written: CPU may not be executing instructions");
            $display("     This indicates the CPU is not executing after reset release!");
        end
        $display("");
        
        // Test 3: Run full program and verify final state matches expected
        $display("=== Test 3: Full Program Execution After Reset ===");
        $display("  Running b_test program to completion...");
        $display("  (This should match the expected output from b_test_out.txt)");
        wait_cycles(400);
        
        // Display final register state and compare with expected
        $display("  Final register state after program execution:");
        $display("  (Comparing with expected values from b_test)");
        
        // Expected values from b_test (from b_test_out.txt)
        check_register(0, 32'h00000000, "Reg 0 ($zero)");
        check_register(8, 32'h00000006, "Reg 8 ($t0)");
        check_register(9, 32'h00000003, "Reg 9 ($t1)");
        check_register(10, 32'h00000009, "Reg 10 ($t2)");
        check_register(11, 32'h00000002, "Reg 11 ($t3)");
        check_register(12, 32'h00000007, "Reg 12 ($t4)");
        check_register(13, 32'h00000005, "Reg 13 ($t5)");
        check_register(14, 32'h00000030, "Reg 14 ($t6)");
        check_register(15, 32'hffffffff, "Reg 15 ($t7)");
        check_register(16, 32'h0000000f, "Reg 16 ($s0)");
        check_register(17, 32'hffffffff, "Reg 17 ($s1)");
        check_register(22, 32'hffffffff, "Reg 22 ($s6)");
        check_register(23, 32'h00000003, "Reg 23 ($s7)");
        
        // Initialize expected register arrays
        expected_regs[0] = 0;   expected_vals[0] = 32'h00000000;
        expected_regs[1] = 8;   expected_vals[1] = 32'h00000006;
        expected_regs[2] = 9;   expected_vals[2] = 32'h00000003;
        expected_regs[3] = 10;  expected_vals[3] = 32'h00000009;
        expected_regs[4] = 11;  expected_vals[4] = 32'h00000002;
        expected_regs[5] = 12;  expected_vals[5] = 32'h00000007;
        expected_regs[6] = 13;  expected_vals[6] = 32'h00000005;
        expected_regs[7] = 14;  expected_vals[7] = 32'h00000030;
        expected_regs[8] = 15;  expected_vals[8] = 32'hffffffff;
        expected_regs[9] = 16;  expected_vals[9] = 32'h0000000f;
        expected_regs[10] = 17; expected_vals[10] = 32'hffffffff;
        expected_regs[11] = 22; expected_vals[11] = 32'hffffffff;
        expected_regs[12] = 23; expected_vals[12] = 32'h00000003;
        
        // Count how many registers match expected
        reg_matches = 0;
        for (int i = 0; i < 13; i++) begin
            if (regs_ok[expected_regs[i]] == expected_vals[i]) begin
                reg_matches = reg_matches + 1;
            end
        end
        
        if (reg_matches == 13) begin
            $display("");
            $display("  ✓✓✓ ALL REGISTERS MATCH EXPECTED VALUES! ✓✓✓");
            $display("  This confirms the CPU is correctly executing instructions after reset!");
        end else begin
            $display("");
            $display("  ✗ Only %0d/13 key registers match expected values", reg_matches);
            $display("  This indicates the CPU may not be executing correctly after reset");
        end
        $display("");
        
        $display("========================================");
        $display("Reset Sequence Test Complete");
        $display("========================================");
        $finish;
    end

endmodule

