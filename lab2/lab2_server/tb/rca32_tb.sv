/*
 * =============================================================================
 * RCA32 (32-BIT RIPPLE-CARRY ADDER) TESTBENCH
 * =============================================================================
 * 
 * FILE: rca32_tb.sv
 * PURPOSE: Comprehensive testbench for rca32 module
 * 
 * METHODOLOGY:
 * This testbench tests the 32-bit ripple-carry adder with various test cases
 * including corner cases, edge cases, and arithmetic verification.
 * 
 * TESTING STRATEGY:
 * 1. CORNER CASE TESTING:
 *    - Zero addition (0 + 0)
 *    - Maximum values (0xFFFFFFFF + 0xFFFFFFFF)
 *    - Single bit patterns
 * 
 * 2. ARITHMETIC VERIFICATION:
 *    - Known addition results
 *    - Overflow detection for signed arithmetic
 *    - Carry propagation testing
 * 
 * 3. EDGE CASE TESTING:
 *    - MSB and LSB specific tests
 *    - Alternating bit patterns
 *    - Specific hex patterns
 * 
 * 4. VERIFICATION METHODOLOGY:
 *    - Expected sum = a + b + carry_in (using SystemVerilog arithmetic)
 *    - Expected carry_out = (a + b + carry_in) > 32'hFFFFFFFF
 *    - Expected overflow = signed overflow detection
 * 
 * TOTAL TEST COVERAGE: 50+ individual test cases
 * =============================================================================
 */

module rca32_tb;

    // Test signals
    logic [31:0] a, b;
    logic carry_in;
    wire [31:0] sum;
    wire carry_out, overflow;
    
    // Error counters
    int sum_errors = 0, carry_errors = 0, overflow_errors = 0;
    int total_tests = 0;
    
    // Instantiate rca32 module
    rca32 rca_inst (
        .a        (a),
        .b        (b),
        .carry_in (carry_in),
        .sum      (sum),
        .carry_out(carry_out),
        .overflow (overflow)
    );
    
    // Test task for rca32
    task test_rca32(input [31:0] test_a, input [31:0] test_b, input test_carry_in);
        logic [31:0] expected_sum;
        logic expected_carry_out, expected_overflow;
        logic [32:0] full_result;
        
        // Calculate expected values using SystemVerilog arithmetic
        full_result = {1'b0, test_a} + {1'b0, test_b} + {32'b0, test_carry_in};
        expected_sum = full_result[31:0];
        expected_carry_out = full_result[32];
        
        // Calculate expected overflow for signed arithmetic
        // Overflow occurs when the sign of the result differs from what we expect
        // for signed addition: overflow = (a[31] == b[31]) && (sum[31] != a[31])
        expected_overflow = (test_a[31] == test_b[31]) && (expected_sum[31] != test_a[31]);
        
        #10; // Wait for propagation
        
        // Check sum
        if (sum !== expected_sum) begin
            $display("ERROR: rca32 sum test failed at time %t", $time);
            $display("  Inputs: a=0x%08h, b=0x%08h, carry_in=%b", test_a, test_b, test_carry_in);
            $display("  Expected sum: 0x%08h, Got: 0x%08h", expected_sum, sum);
            sum_errors++;
        end
        
        // Check carry_out
        if (carry_out !== expected_carry_out) begin
            $display("ERROR: rca32 carry_out test failed at time %t", $time);
            $display("  Inputs: a=0x%08h, b=0x%08h, carry_in=%b", test_a, test_b, test_carry_in);
            $display("  Expected carry_out: %b, Got: %b", expected_carry_out, carry_out);
            carry_errors++;
        end
        
        // Check overflow
        if (overflow !== expected_overflow) begin
            $display("ERROR: rca32 overflow test failed at time %t", $time);
            $display("  Inputs: a=0x%08h, b=0x%08h, carry_in=%b", test_a, test_b, test_carry_in);
            $display("  Expected overflow: %b, Got: %b", expected_overflow, overflow);
            overflow_errors++;
        end
        
        total_tests++;
    endtask
    
    // Main test sequence
    initial begin
        $display("Starting rca32 testbench...");
        $display("=====================================");
        
        // Corner case tests
        $display("\nTesting corner cases...");
        
        // Test 1: Zero addition
        a = 32'h00000000; b = 32'h00000000; carry_in = 1'b0;
        test_rca32(32'h00000000, 32'h00000000, 1'b0);
        
        // Test 2: Maximum values
        a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; carry_in = 1'b0;
        test_rca32(32'hFFFFFFFF, 32'hFFFFFFFF, 1'b0);
        
        // Test 3: Zero with carry
        a = 32'h00000000; b = 32'h00000000; carry_in = 1'b1;
        test_rca32(32'h00000000, 32'h00000000, 1'b1);
        
        // Test 4: Maximum with carry
        a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; carry_in = 1'b1;
        test_rca32(32'hFFFFFFFF, 32'hFFFFFFFF, 1'b1);
        
        // Single bit tests
        $display("\nTesting single bit patterns...");
        
        for (int i = 0; i < 32; i++) begin
            automatic logic [31:0] single_bit = (1 << i);
            a = single_bit; b = single_bit; carry_in = 1'b0;
            test_rca32(single_bit, single_bit, 1'b0);
        end
        
        // Known arithmetic tests
        $display("\nTesting known arithmetic results...");
        
        // Test 5: 1 + 1 = 2
        a = 32'h00000001; b = 32'h00000001; carry_in = 1'b0;
        test_rca32(32'h00000001, 32'h00000001, 1'b0);
        
        // Test 6: 0x7FFFFFFF + 1 = 0x80000000 (overflow case)
        a = 32'h7FFFFFFF; b = 32'h00000001; carry_in = 1'b0;
        test_rca32(32'h7FFFFFFF, 32'h00000001, 1'b0);
        
        // Test 7: 0x80000000 + 0x80000000 = 0x00000000 (overflow case)
        a = 32'h80000000; b = 32'h80000000; carry_in = 1'b0;
        test_rca32(32'h80000000, 32'h80000000, 1'b0);
        
        // Test 8: 0x12345678 + 0x87654321
        a = 32'h12345678; b = 32'h87654321; carry_in = 1'b0;
        test_rca32(32'h12345678, 32'h87654321, 1'b0);
        
        // Test 9: 0xDEADBEEF + 0xCAFEBABE
        a = 32'hDEADBEEF; b = 32'hCAFEBABE; carry_in = 1'b0;
        test_rca32(32'hDEADBEEF, 32'hCAFEBABE, 1'b0);
        
        // Alternating pattern tests
        $display("\nTesting alternating patterns...");
        
        // Test 10: 0xAAAAAAAA + 0x55555555
        a = 32'hAAAAAAAA; b = 32'h55555555; carry_in = 1'b0;
        test_rca32(32'hAAAAAAAA, 32'h55555555, 1'b0);
        
        // Test 11: 0x55555555 + 0xAAAAAAAA
        a = 32'h55555555; b = 32'hAAAAAAAA; carry_in = 1'b0;
        test_rca32(32'h55555555, 32'hAAAAAAAA, 1'b0);
        
        // Overflow-specific tests
        $display("\nTesting overflow detection...");
        
        // Test 12: Positive overflow (0x7FFFFFFF + 0x00000001)
        a = 32'h7FFFFFFF; b = 32'h00000001; carry_in = 1'b0;
        test_rca32(32'h7FFFFFFF, 32'h00000001, 1'b0);
        
        // Test 13: Negative overflow (0x80000000 + 0x80000000)
        a = 32'h80000000; b = 32'h80000000; carry_in = 1'b0;
        test_rca32(32'h80000000, 32'h80000000, 1'b0);
        
        // Test 14: No overflow (0x7FFFFFFF + 0x00000000)
        a = 32'h7FFFFFFF; b = 32'h00000000; carry_in = 1'b0;
        test_rca32(32'h7FFFFFFF, 32'h00000000, 1'b0);
        
        // Test 15: No overflow (0x80000000 + 0x00000001)
        a = 32'h80000000; b = 32'h00000001; carry_in = 1'b0;
        test_rca32(32'h80000000, 32'h00000001, 1'b0);
        
        // Random pattern tests
        $display("\nTesting random patterns...");
        
        for (int i = 0; i < 10; i++) begin
            automatic logic [31:0] rand_a = $random;
            automatic logic [31:0] rand_b = $random;
            automatic logic rand_carry = $random;
            a = rand_a; b = rand_b; carry_in = rand_carry;
            test_rca32(rand_a, rand_b, rand_carry);
        end
        
        // Print final results
        $display("\n=====================================");
        $display("Test Results Summary:");
        $display("Total tests run: %d", total_tests);
        $display("Sum errors: %d", sum_errors);
        $display("Carry errors: %d", carry_errors);
        $display("Overflow errors: %d", overflow_errors);
        
        if (sum_errors == 0 && carry_errors == 0 && overflow_errors == 0) begin
            $display("ALL TESTS PASSED! ✓");
        end else begin
            $display("SOME TESTS FAILED! ✗");
        end
        
        $display("=====================================");
        $finish;
    end
    
    // Generate VCD file for waveform viewing
    initial begin
        $dumpfile("rca32_tb.vcd");
        $dumpvars(0, rca32_tb);
    end

endmodule
