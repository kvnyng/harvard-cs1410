`timescale 1ns / 1ps
`include "../source/cpu.svh"

module sign_extend_tb();

    // Test signals
    logic [15:0] imm_16;
    logic [31:0] imm_32;
    logic [31:0] expected;
    
    // Instantiate sign extender
    sign_extend dut (
        .imm_16(imm_16),
        .imm_32(imm_32)
    );
    
    // Task to test a sign extension case
    task test_sign_extend(input logic [15:0] input_val, input logic [31:0] expected_val, input string test_name);
        imm_16 = input_val;
        #1; // Small delay for combinational logic
        
        if (imm_32 !== expected_val) begin
            $error("Test '%s' failed: input=0x%04h, expected=0x%08h, got=0x%08h", 
                   test_name, input_val, expected_val, imm_32);
        end else begin
            $display("  ✓ %s: 0x%04h → 0x%08h", test_name, input_val, imm_32);
        end
    endtask
    
    initial begin
        $display("========================================");
        $display("Sign Extender Testbench");
        $display("Testing 16-bit to 32-bit sign extension");
        $display("========================================\n");
        
        $display("=== Test 1: Positive values (MSB = 0) ===");
        // Positive values should be zero-extended (upper 16 bits = 0)
        test_sign_extend(16'h0000, 32'h00000000, "Zero");
        test_sign_extend(16'h0001, 32'h00000001, "One");
        test_sign_extend(16'h0005, 32'h00000005, "Five");
        test_sign_extend(16'h007F, 32'h0000007F, "127");
        test_sign_extend(16'h00FF, 32'h000000FF, "255");
        test_sign_extend(16'h7FFF, 32'h00007FFF, "Max positive (32767)");
        
        $display("\n=== Test 2: Negative values (MSB = 1) ===");
        // Negative values should be sign-extended (upper 16 bits = 1)
        test_sign_extend(16'h8000, 32'hFFFF8000, "Min negative (-32768)");
        test_sign_extend(16'h8001, 32'hFFFF8001, "-32767");
        test_sign_extend(16'hFFFF, 32'hFFFFFFFF, "-1");
        test_sign_extend(16'hFFFE, 32'hFFFFFFFE, "-2");
        test_sign_extend(16'hFF00, 32'hFFFFFF00, "-256");
        test_sign_extend(16'hC000, 32'hFFFFC000, "-16384");
        
        $display("\n=== Test 3: Edge cases ===");
        test_sign_extend(16'h0000, 32'h00000000, "All zeros");
        test_sign_extend(16'hFFFF, 32'hFFFFFFFF, "All ones");
        test_sign_extend(16'h8000, 32'hFFFF8000, "Only MSB set");
        test_sign_extend(16'h7FFF, 32'h00007FFF, "All bits except MSB");
        
        $display("\n=== Test 4: Common MIPS immediate values ===");
        // Common immediate values used in MIPS instructions
        test_sign_extend(16'h0004, 32'h00000004, "Immediate 4");
        test_sign_extend(16'h0010, 32'h00000010, "Immediate 16");
        test_sign_extend(16'hFFFC, 32'hFFFFFFFC, "Immediate -4");
        test_sign_extend(16'hFFF0, 32'hFFFFFFF0, "Immediate -16");
        test_sign_extend(16'h0040, 32'h00000040, "Immediate 64");
        test_sign_extend(32'hFFC0, 32'hFFFFFFC0, "Immediate -64");
        
        $display("\n========================================");
        $display("All sign extension tests completed!");
        $display("========================================");
        
        #10;
        $finish;
    end
    
    // Monitor for debugging
    initial begin
        $monitor("Time: %0t | imm_16: 0x%04h | imm_32: 0x%08h", $time, imm_16, imm_32);
    end

endmodule


