/*
 * =============================================================================
 * FLAGS MODULES TESTBENCH
 * =============================================================================
 * 
 * FILE: flags_tb.sv
 * PURPOSE: Comprehensive testbench for flag modules (check_zero32, check_equal32)
 * 
 * MODULES TESTED:
 * 1. check_zero32: Determines if a 32-bit value is zero using OR gate tree
 * 2. check_equal32: Determines if two 32-bit values are equal using XOR/AND gate tree
 * 
 * TESTING STRATEGY:
 * 1. CORNER CASE TESTING:
 *    - Zero values, maximum values, minimum values
 *    - Single bit patterns, alternating patterns
 * 
 * 2. EDGE CASE TESTING:
 *    - All zeros, all ones
 *    - Single bit differences
 *    - MSB and LSB specific tests
 * 
 * 3. COMPREHENSIVE TESTING:
 *    - Random pattern testing
 *    - Systematic bit position testing
 *    - Known equality/inequality cases
 * 
 * TOTAL TEST COVERAGE: 100+ individual test cases
 * =============================================================================
 */

`timescale 1ns/1ps

module flags_tb;

    // Test signals for check_zero32
    logic [31:0] z_zero;
    wire zero_out;
    
    // Test signals for check_equal32
    logic [31:0] x_equal, y_equal;
    wire equal_out;
    
    // Error counters
    int zero_errors = 0, equal_errors = 0;
    int total_tests = 0;
    
    // Instantiate modules
    check_zero32 zero_checker (
        .z(z_zero),
        .zero(zero_out)
    );
    
    check_equal32 equal_checker (
        .x(x_equal),
        .y(y_equal),
        .equal(equal_out)
    );
    
    // Test task for check_zero32
    task test_zero(input [31:0] test_z);
        logic expected_zero;
        expected_zero = (test_z == 32'h00000000);
        
        z_zero = test_z;
        #10; // Wait for propagation
        
        if (zero_out !== expected_zero) begin
            $display("ERROR: check_zero32 test failed at time %t", $time);
            $display("  Input z = 0x%08h (%032b)", test_z, test_z);
            $display("  Expected zero = %b, Got = %b", expected_zero, zero_out);
            zero_errors++;
        end
        total_tests++;
    endtask
    
    // Test task for check_equal32
    task test_equal(input [31:0] test_x, input [31:0] test_y);
        logic expected_equal;
        expected_equal = (test_x == test_y);
        
        x_equal = test_x;
        y_equal = test_y;
        #10; // Wait for propagation
        
        if (equal_out !== expected_equal) begin
            $display("ERROR: check_equal32 test failed at time %t", $time);
            $display("  Input x = 0x%08h (%032b)", test_x, test_x);
            $display("  Input y = 0x%08h (%032b)", test_y, test_y);
            $display("  Expected equal = %b, Got = %b", expected_equal, equal_out);
            equal_errors++;
        end
        total_tests++;
    endtask
    
    // Main test sequence
    initial begin
        $display("Starting flags testbench...");
        $display("=====================================");
        
        // Test check_zero32 module
        $display("\nTesting check_zero32 module...");
        
        // Corner cases for zero detection
        $display("Testing zero detection corner cases...");
        test_zero(32'h00000000);  // All zeros - should be true
        test_zero(32'h00000001);  // Single bit set - should be false
        test_zero(32'h80000000);  // MSB set - should be false
        test_zero(32'hFFFFFFFF);  // All ones - should be false
        test_zero(32'h12345678);  // Random pattern - should be false
        
        // Single bit patterns
        $display("Testing single bit patterns...");
        for (int i = 0; i < 32; i++) begin
            automatic logic [31:0] single_bit = (1 << i);
            test_zero(single_bit);
        end
        
        // Alternating patterns
        $display("Testing alternating patterns...");
        test_zero(32'hAAAAAAAA);  // Alternating 1010... - should be false
        test_zero(32'h55555555);  // Alternating 0101... - should be false
        test_zero(32'hCCCCCCCC);  // Alternating 1100... - should be false
        test_zero(32'h33333333);  // Alternating 0011... - should be false
        
        // Edge cases
        $display("Testing edge cases...");
        test_zero(32'h7FFFFFFF);  // Maximum positive - should be false
        test_zero(32'h80000000);  // Maximum negative - should be false
        test_zero(32'h00000001);  // Minimum positive - should be false
        test_zero(32'hFFFFFFFF);  // Maximum unsigned - should be false
        
        // Test check_equal32 module
        $display("\nTesting check_equal32 module...");
        
        // Equal cases
        $display("Testing equal cases...");
        test_equal(32'h00000000, 32'h00000000);  // Both zero
        test_equal(32'hFFFFFFFF, 32'hFFFFFFFF);  // Both all ones
        test_equal(32'h12345678, 32'h12345678);  // Same random pattern
        test_equal(32'h7FFFFFFF, 32'h7FFFFFFF);  // Same maximum positive
        test_equal(32'h80000000, 32'h80000000);  // Same maximum negative
        
        // Not equal cases
        $display("Testing not equal cases...");
        test_equal(32'h00000000, 32'h00000001);  // Zero vs one
        test_equal(32'h00000000, 32'hFFFFFFFF);  // Zero vs all ones
        test_equal(32'h12345678, 32'h87654321);  // Different patterns
        test_equal(32'h7FFFFFFF, 32'h80000000);  // Max positive vs max negative
        test_equal(32'hAAAAAAAA, 32'h55555555);  // Alternating patterns
        
        // Single bit difference tests
        $display("Testing single bit differences...");
        for (int i = 0; i < 32; i++) begin
            automatic logic [31:0] base = 32'h12345678;
            automatic logic [31:0] modified = base ^ (1 << i);
            test_equal(base, modified);
        end
        
        // MSB and LSB specific tests
        $display("Testing MSB and LSB specific cases...");
        test_equal(32'h00000000, 32'h00000001);  // LSB different
        test_equal(32'h00000000, 32'h80000000);  // MSB different
        test_equal(32'h7FFFFFFF, 32'hFFFFFFFF);  // MSB different
        test_equal(32'h00000001, 32'h00000000);  // LSB different (reversed)
        test_equal(32'h80000000, 32'h00000000);  // MSB different (reversed)
        
        // Alternating pattern tests
        $display("Testing alternating pattern comparisons...");
        test_equal(32'hAAAAAAAA, 32'hAAAAAAAA);  // Same alternating
        test_equal(32'h55555555, 32'h55555555);  // Same alternating
        test_equal(32'hAAAAAAAA, 32'h55555555);  // Different alternating
        test_equal(32'hCCCCCCCC, 32'h33333333);  // Different alternating
        test_equal(32'hF0F0F0F0, 32'h0F0F0F0F);  // Different alternating
        
        // Known hex pattern tests
        $display("Testing known hex patterns...");
        test_equal(32'hDEADBEEF, 32'hDEADBEEF);  // Same pattern
        test_equal(32'hCAFEBABE, 32'hCAFEBABE);  // Same pattern
        test_equal(32'hDEADBEEF, 32'hCAFEBABE);  // Different patterns
        test_equal(32'h12345678, 32'h87654321);  // Different patterns
        test_equal(32'hABCDEF01, 32'hFEDCBA98);  // Different patterns
        
        // Edge case comparisons
        $display("Testing edge case comparisons...");
        test_equal(32'h7FFFFFFF, 32'h7FFFFFFE);  // Max positive vs max positive - 1
        test_equal(32'h80000000, 32'h80000001);  // Max negative vs max negative + 1
        test_equal(32'h00000000, 32'h00000000);  // Both zero
        test_equal(32'hFFFFFFFF, 32'hFFFFFFFE);  // Max unsigned vs max unsigned - 1
        
        // Random pattern tests
        $display("Testing random patterns...");
        for (int i = 0; i < 20; i++) begin
            automatic logic [31:0] rand_x = $random;
            automatic logic [31:0] rand_y = $random;
            test_equal(rand_x, rand_y);
        end
        
        // Test equal cases with random patterns
        for (int i = 0; i < 10; i++) begin
            automatic logic [31:0] rand_val = $random;
            test_equal(rand_val, rand_val);  // Same value should be equal
        end
        
        // Bit position systematic testing
        $display("Testing systematic bit position differences...");
        for (int bit_pos = 0; bit_pos < 32; bit_pos++) begin
            automatic logic [31:0] base = 32'h12345678;
            automatic logic [31:0] modified = base ^ (1 << bit_pos);
            test_equal(base, modified);  // Should be false (not equal)
            test_equal(modified, modified);  // Should be true (equal)
        end
        
        // Print final results
        $display("\n=====================================");
        $display("Test Results Summary:");
        $display("Total tests run: %d", total_tests);
        $display("check_zero32 errors: %d", zero_errors);
        $display("check_equal32 errors: %d", equal_errors);
        
        if (zero_errors == 0 && equal_errors == 0) begin
            $display("ALL TESTS PASSED! ✓");
        end else begin
            $display("SOME TESTS FAILED! ✗");
        end
        
        $display("=====================================");
        $finish;
    end
    
    // Generate VCD file for waveform viewing
    initial begin
        $dumpfile("flags_tb.vcd");
        $dumpvars(0, flags_tb);
    end

endmodule
