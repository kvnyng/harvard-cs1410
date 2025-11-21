`timescale 1ns / 1ps
`include "../source/cpu.svh"

module cpu_ctest_tb();

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
    
    // Test parameters
    parameter string INSTR_MEM_FILE = "tests/c_instr.mem";
    parameter string DATA_MEM_FILE = "tests/c_data.mem";
    parameter string EXPECTED_OUTPUT_FILE = "tests/c_test_out.txt";
    parameter int MAX_CYCLES = 2000;
    
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
    
    // Cycle counter
    int cycle_count = 0;
    always @(posedge clk) begin
        if (!rst) begin
            cycle_count <= cycle_count + 1;
        end
    end
    
    // Expected values storage
    logic [31:0] expected_regs [0:31];
    logic [31:0] expected_mem [0:1023];  // Data memory (1024 words)
    logic reg_expected_valid [0:31];
    logic mem_expected_valid [0:1023];
    
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
    
    // Task to parse expected output file
    task automatic parse_expected_output(input string filename);
        int file;
        string line;
        int line_num = 0;
        int reg_num;
        logic [31:0] reg_value;
        int addr;
        logic [31:0] mem_value;
        int scan_result;
        int in_regs_section = 0;
        int in_mem_section = 0;
        string regs_match;
        string mem_match;
        string skip_str;
        int mem_index;
        int valid_regs;
        int valid_mem;
        
        // Initialize expected arrays
        for (int i = 0; i < 32; i++) begin
            reg_expected_valid[i] = 0;
            expected_regs[i] = 32'h0;
        end
        for (int i = 0; i < 1024; i++) begin
            mem_expected_valid[i] = 0;
            expected_mem[i] = 32'h0;
        end
        
        file = $fopen(filename, "r");
        if (file == 0) begin
            $display("ERROR: Could not open expected output file: %s", filename);
            $finish;
        end
        
        $display("  Parsing expected output file...");
        
        while (!$feof(file)) begin
            line_num++;
            $fgets(line, file);
            
            // Remove trailing newline if present
            if (line.len() > 0 && line[line.len()-1] == "\n") begin
                line = line.substr(0, line.len()-2);
            end
            
            // Check for REGS section - look for "REGS:" anywhere in line
            if (line == "REGS:") begin
                in_regs_section = 1;
                in_mem_section = 0;
                continue;
            end
            
            // Check for memory section header
            if (line == "---Output from FPGA RAM ---") begin
                in_regs_section = 0;
                in_mem_section = 1;
                continue;
            end
            
            // Skip empty lines and lines with just dots
            if (line.len() == 0) continue;
            if (line[0] == ".") continue;
            
            // Parse register line: "Reg N ($name)  :  value"
            if (in_regs_section) begin
                // Try to parse: "Reg %d" followed by anything, then ":" then value
                // Use a pattern that matches the format
                scan_result = $sscanf(line, "Reg %d %s : %d", reg_num, skip_str, reg_value);
                if (scan_result == 3) begin
                    if (reg_num >= 0 && reg_num < 32) begin
                        expected_regs[reg_num] = reg_value;
                        reg_expected_valid[reg_num] = 1;
                    end
                end
            end
            
            // Parse memory line: "0xADDR  |  value"
            if (in_mem_section) begin
                scan_result = $sscanf(line, "0x%x  |  %d", addr, mem_value);
                if (scan_result == 2) begin
                    mem_index = addr / 4;
                    if (mem_index >= 0 && mem_index < 1024) begin
                        expected_mem[mem_index] = mem_value;
                        mem_expected_valid[mem_index] = 1;
                    end
                end
            end
        end
        
        $fclose(file);
        
        // Count valid expectations
        valid_regs = 0;
        valid_mem = 0;
        for (int i = 0; i < 32; i++) begin
            if (reg_expected_valid[i]) valid_regs++;
        end
        for (int i = 0; i < 1024; i++) begin
            if (mem_expected_valid[i]) valid_mem++;
        end
        
        $display("  Parsed %0d expected register values", valid_regs);
        $display("  Parsed %0d expected memory values", valid_mem);
    endtask
    
    // Task to compare results
    task automatic compare_results();
        int reg_errors = 0;
        int reg_total = 0;
        int mem_errors = 0;
        int mem_total = 0;
        int total_errors = 0;
        int addr;
        logic is_match;
        
        $display("");
        $display("========================================");
        $display("COMPARING RESULTS");
        $display("========================================");
        $display("");
        
        // Compare registers
        $display("Register Comparison:");
        $display("--------------------");
        for (int i = 0; i < 32; i++) begin
            if (reg_expected_valid[i]) begin
                reg_total++;
                if (regs_ok[i] != expected_regs[i]) begin
                    reg_errors++;
                    $display("  ✗ Reg %0d: Expected 0x%08h (%0d), Got 0x%08h (%0d)", 
                             i, expected_regs[i], expected_regs[i], 
                             regs_ok[i], regs_ok[i]);
                end else begin
                    $display("  ✓ Reg %0d: 0x%08h (%0d) - MATCH", 
                             i, regs_ok[i], regs_ok[i]);
                end
            end
        end
        
        $display("");
        $display("Register Summary: %0d/%0d correct", reg_total - reg_errors, reg_total);
        if (reg_errors > 0) begin
            $display("  ✗ %0d register mismatches", reg_errors);
        end else begin
            $display("  ✓ All registers match!");
        end
        
        $display("");
        
        // Compare memory (only check addresses that have expected values)
        $display("Memory Comparison:");
        $display("------------------");
        for (int i = 0; i < 1024; i++) begin
            if (mem_expected_valid[i]) begin
                mem_total++;
                addr = i * 4;
                // Accept X (unknown) values for uninitialized memory (expected = 0)
                // Also accept exact matches
                is_match = 0;
                if (expected_mem[i] == 0 && $isunknown(main_memory.dmem[i])) begin
                    // X is acceptable for uninitialized memory (expected = 0)
                    is_match = 1;
                end else if (main_memory.dmem[i] == expected_mem[i]) begin
                    // Normal comparison for non-zero expected values
                    is_match = 1;
                end
                
                if (!is_match) begin
                    mem_errors++;
                    $display("  ✗ Addr 0x%08h: Expected 0x%08h (%0d), Got 0x%08h (%0d)", 
                             addr, expected_mem[i], expected_mem[i],
                             main_memory.dmem[i], main_memory.dmem[i]);
                end
            end
        end
        
        // Only print memory matches for non-zero values or if there are errors
        if (mem_errors > 0) begin
            $display("");
            $display("Memory locations with matches:");
            for (int i = 0; i < 1024; i++) begin
                if (mem_expected_valid[i] && main_memory.dmem[i] == expected_mem[i] && expected_mem[i] != 0) begin
                    $display("  ✓ Addr 0x%08h: 0x%08h (%0d) - MATCH", 
                             i * 4, main_memory.dmem[i], main_memory.dmem[i]);
                end
            end
        end
        
        $display("");
        $display("Memory Summary: %0d/%0d correct", mem_total - mem_errors, mem_total);
        if (mem_errors > 0) begin
            $display("  ✗ %0d memory mismatches", mem_errors);
        end else begin
            $display("  ✓ All memory locations match!");
        end
        
        total_errors = reg_errors + mem_errors;
        
        $display("");
        $display("========================================");
        $display("TEST SUMMARY");
        $display("========================================");
        $display("Total comparisons: %0d", reg_total + mem_total);
        $display("Total errors: %0d", total_errors);
        $display("Register errors: %0d", reg_errors);
        $display("Memory errors: %0d", mem_errors);
        $display("");
        
        if (total_errors == 0) begin
            $display("✓✓✓ TEST PASSED ✓✓✓");
            $display("");
        end else begin
            $display("✗✗✗ TEST FAILED ✗✗✗");
            $display("");
        end
    endtask
    
    initial begin
        $display("========================================");
        $display("CPU C-Test Testbench");
        $display("========================================");
        $display("Instruction Memory: %s", INSTR_MEM_FILE);
        $display("Data Memory: %s", DATA_MEM_FILE);
        $display("Expected Output: %s", EXPECTED_OUTPUT_FILE);
        $display("");
        
        // Parse expected output first
        $display("Step 1: Loading expected output...");
        parse_expected_output(EXPECTED_OUTPUT_FILE);
        $display("");
        
        // Reset
        $display("Step 2: Resetting CPU...");
        rst = 1;
        #20;
        rst = 0;
        #10;
        $display("");
        
        // Load instruction memory
        $display("Step 3: Loading instruction memory...");
        load_memory_from_file(INSTR_MEM_FILE, 1);
        $display("");
        
        // Load data memory
        $display("Step 4: Loading data memory...");
        if (DATA_MEM_FILE != "") begin
            load_memory_from_file(DATA_MEM_FILE, 0);
        end
        $display("");
        
        // Run simulation
        $display("Step 5: Running simulation...");
        $display("  Maximum cycles: %0d", MAX_CYCLES);
        $display("");
        
        // Wait for execution
        repeat(MAX_CYCLES) @(posedge clk);
        
        #200; // Wait for final writeback
        
        $display("");
        $display("Simulation completed after %0d cycles", cycle_count);
        $display("Final PC: 0x%08h", cpu_inst.dbg_PC);
        $display("");
        
        // Compare results
        $display("Step 6: Comparing results...");
        compare_results();
        
        $finish;
    end

endmodule

