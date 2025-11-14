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
    
    // Cycle counter
    int cycle_count = 0;
    always @(posedge clk) begin
        if (!rst) begin
            cycle_count <= cycle_count + 1;
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
        $display("Simulation completed after %0d cycles", cycle_count);
        $display("Final PC: 0x%08h", cpu_inst.dbg_PC);
        
        $finish;
    end

endmodule

