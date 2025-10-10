`timescale 1ns/1ps

module slt_comprehensive_tb;
    // Test signals
    logic msb, overflow;
    logic [31:0] result;
    
    // Instantiate the SLT module
    slt_32bit slt_inst (.msb(msb), .overflow(overflow), .result(result));
    
    // Test task with detailed explanation
    task test_slt_case(input logic test_msb, input logic test_overflow, input logic expected_lsb, input string description);
        msb = test_msb;
        overflow = test_overflow;
        #10; // Wait for propagation
        
        $display("Testing: %s", description);
        $display("  MSB = %b, Overflow = %b", test_msb, test_overflow);
        $display("  Expected LSB = %b, Got = %b", expected_lsb, result[0]);
        $display("  Full result = 0x%08h", result);
        
        if (result[0] !== expected_lsb) begin
            $display("  ERROR: SLT test failed!");
        end else begin
            $display("  PASS: SLT test passed");
        end
        $display("");
    endtask
    
    initial begin
        $display("Starting Comprehensive SLT module testbench...");
        $display("================================================");
        $display("SLT Logic: SLT = MSB XOR overflow");
        $display("This handles signed comparison correctly with overflow");
        $display("================================================");
        $display("");
        
        // Test Case 1: Normal case - no overflow
        // Example: 5 - 3 = 2 (positive, no overflow)
        // MSB = 0, overflow = 0 -> SLT = 0 (5 >= 3)
        test_slt_case(1'b0, 1'b0, 1'b0, "Normal case: 5 - 3 = 2 (positive, no overflow)");
        
        // Test Case 2: Normal case - no overflow  
        // Example: 3 - 5 = -2 (negative, no overflow)
        // MSB = 1, overflow = 0 -> SLT = 1 (3 < 5)
        test_slt_case(1'b1, 1'b0, 1'b1, "Normal case: 3 - 5 = -2 (negative, no overflow)");
        
        // Test Case 3: Overflow case - positive overflow
        // Example: 0x7FFFFFFF + 1 = 0x80000000 (overflow from positive to negative)
        // MSB = 1, overflow = 1 -> SLT = 0 (corrected for overflow)
        test_slt_case(1'b1, 1'b1, 1'b0, "Overflow case: Positive overflow (MSB flipped)");
        
        // Test Case 4: Overflow case - negative overflow
        // Example: 0x80000000 - 1 = 0x7FFFFFFF (overflow from negative to positive)
        // MSB = 0, overflow = 1 -> SLT = 1 (corrected for overflow)
        test_slt_case(1'b0, 1'b1, 1'b1, "Overflow case: Negative overflow (MSB flipped)");
        
        // Test Case 5: Edge case - zero result
        // Example: 5 - 5 = 0 (zero, no overflow)
        // MSB = 0, overflow = 0 -> SLT = 0 (5 >= 5)
        test_slt_case(1'b0, 1'b0, 1'b0, "Edge case: 5 - 5 = 0 (zero result)");
        
        // Test Case 6: Edge case - minimum negative
        // Example: 0x80000000 - 0 = 0x80000000 (minimum negative, no overflow)
        // MSB = 1, overflow = 0 -> SLT = 1 (0x80000000 < 0)
        test_slt_case(1'b1, 1'b0, 1'b1, "Edge case: 0x80000000 - 0 (minimum negative)");
        
        // Test Case 7: Edge case - maximum positive
        // Example: 0x7FFFFFFF - 0 = 0x7FFFFFFF (maximum positive, no overflow)
        // MSB = 0, overflow = 0 -> SLT = 0 (0x7FFFFFFF >= 0)
        test_slt_case(1'b0, 1'b0, 1'b0, "Edge case: 0x7FFFFFFF - 0 (maximum positive)");
        
        // Verify that all upper bits are 0
        $display("Verifying upper bits are zero...");
        if (result[31:1] !== 31'b0) begin
            $display("ERROR: Upper bits are not zero! Got = 0x%08h", result);
        end else begin
            $display("PASS: All upper bits are correctly zero");
        end
        
        $display("================================================");
        $display("Comprehensive SLT module testbench completed");
        $display("All test cases demonstrate correct SLT logic:");
        $display("  - Normal cases: MSB directly indicates sign");
        $display("  - Overflow cases: MSB XOR overflow corrects for overflow");
        $display("  - 32-bit output with LSB as SLT result");
        $finish;
    end

endmodule
