`timescale 1ns / 1ps
`include "../source/cpu.svh"

module cpu_main_memory_tb();

    // Clock and control signals
    logic clk = 0;
    logic clk_en = 1;
    
    // Memory interface signals (driven by testbench to CPU)
    logic wr_en;
    logic [31:0] mem_addr;
    logic [31:0] w_data;
    // r_data comes from CPU's internal memory
    logic [31:0] r_data;
    
    // Instantiate the CPU module which contains main_memory (rw_ram instance)
    // This tests the CPU's memory implementation
    cpu cpu_unit (
        .clk(clk),
        .clk_en(clk_en),
        .rst(1'b0),
        .r_data(r_data),  // CPU outputs memory data on this port
        .wr_en(wr_en),    // Testbench drives write enable
        .mem_addr(mem_addr), // Testbench drives address
        .w_data(w_data),  // Testbench drives write data
        .regs_ok()
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    // Task to read from memory at a given address
    task read_memory(input logic [31:0] addr, output logic [31:0] data);
        mem_addr = addr;
        wr_en = 1'b0;
        @(posedge clk);
        #2; // Wait for combinational logic
        data = r_data;
    endtask
    
    // Task to write to memory at a given address
    task write_memory(input logic [31:0] addr, input logic [31:0] data);
        mem_addr = addr;
        w_data = data;
        wr_en = 1'b1;
        @(posedge clk);
        #2;
        wr_en = 1'b0;
    endtask
    
    // Task to verify memory content
    task verify_memory(input logic [31:0] addr, input logic [31:0] expected);
        logic [31:0] actual;
        read_memory(addr, actual);
        if (actual !== expected) begin
            $error("Memory verification failed at address 0x%08h: expected 0x%08h, got 0x%08h", 
                   addr, expected, actual);
        end else begin
            $display("  ✓ Address 0x%08h: 0x%08h (correct)", addr, actual);
        end
    endtask
    
    initial begin
        $display("========================================");
        $display("CPU Main Memory Testbench");
        $display("Testing instruction and data memory loading");
        $display("========================================\n");
        
        // Wait for initialization
        #20;
        
        $display("=== Test 1: Loading instruction memory from instr_1.mem ===");
        $display("Simulating loading instructions at 0x00400000");
        
        // Load instruction memory with values from instr_1.mem
        // These simulate what would be loaded from asm/instr_1.mem
        write_memory(32'h00400000, 32'h20100005); // ADDI $s0, $zero, 5
        write_memory(32'h00400004, 32'h20110002); // ADDI $s1, $zero, 2
        write_memory(32'h00400008, 32'h20080064); // ADDI $t0, $zero, 100
        write_memory(32'h0040000C, 32'h00089843); // SRA $s3, $t0, $t1
        write_memory(32'h00400010, 32'h00139082); // SRL $s2, $s3, $s4
        write_memory(32'h00400014, 32'h00084900); // SLL $t1, $t0, $s0
        write_memory(32'h00400018, 32'h0253a027); // NOR $s4, $s2, $s3
        write_memory(32'h0040001C, 32'h0249a826); // XOR $s5, $s2, $t1
        write_memory(32'h00400020, 32'h0295b025); // OR $s6, $s4, $s5
        write_memory(32'h00400024, 32'h01095024); // AND $t2, $t0, $t1
        
        // Verify the loaded instructions
        verify_memory(32'h00400000, 32'h20100005);
        verify_memory(32'h00400004, 32'h20110002);
        verify_memory(32'h00400008, 32'h20080064);
        verify_memory(32'h0040000C, 32'h00089843);
        verify_memory(32'h00400010, 32'h00139082);
        
        $display("\n=== Test 2: Loading data memory from data_1.mem ===");
        $display("Simulating loading data at 0x0");
        
        // Load data memory with values from data_1.mem
        // These simulate what would be loaded from asm/data_1.mem
        write_memory(32'h00000000, 32'h00000001);
        write_memory(32'h00000004, 32'h00000002);
        write_memory(32'h00000008, 32'h00000003);
        write_memory(32'h0000000C, 32'h00000004);
        write_memory(32'h00000010, 32'h00000005);
        write_memory(32'h00000014, 32'h00000006);
        write_memory(32'h00000018, 32'h00000007);
        write_memory(32'h0000001C, 32'h00000008);
        
        // Verify the loaded data
        verify_memory(32'h00000000, 32'h00000001);
        verify_memory(32'h00000004, 32'h00000002);
        verify_memory(32'h00000008, 32'h00000003);
        verify_memory(32'h0000000C, 32'h00000004);
        
        $display("\n=== Test 3: Writing to data memory ===");
        
        // Write some test values to data memory
        write_memory(32'h00000010, 32'hDEADBEEF);
        write_memory(32'h00000014, 32'hCAFEBABE);
        write_memory(32'h00000018, 32'h12345678);
        
        // Verify the writes
        verify_memory(32'h00000010, 32'hDEADBEEF);
        verify_memory(32'h00000014, 32'hCAFEBABE);
        verify_memory(32'h00000018, 32'h12345678);
        
        $display("\n=== Test 4: Writing to instruction memory ===");
        
        // Write to instruction memory (though this is unusual in practice)
        write_memory(32'h00400020, 32'h00000000); // Write a NOP
        verify_memory(32'h00400020, 32'h00000000);
        
        $display("\n=== Test 5: Address boundary verification ===");
        
        // Verify that addresses are properly mapped
        // Data memory should be at addresses < 0x00400000
        // Instruction memory should be at addresses >= 0x00400000
        
        // Test data memory boundary
        write_memory(32'h000003FC, 32'hB0ABCDEF); // Last word of first 1KB
        verify_memory(32'h000003FC, 32'hB0ABCDEF);
        
        // Test instruction memory boundary  
        write_memory(32'h00400000, 32'hCAFEBABE); // First word of instruction memory
        verify_memory(32'h00400000, 32'hCAFEBABE);
        
        $display("\n========================================");
        $display("All memory tests completed!");
        $display("========================================");
        
        #50;
        $finish;
    end
    
    // Monitor for debugging
    initial begin
        $monitor("Time: %0t | wr_en: %b | addr: 0x%08h | w_data: 0x%08h | r_data: 0x%08h",
                 $time, wr_en, mem_addr, w_data, r_data);
    end

endmodule

