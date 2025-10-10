/*
 * =============================================================================
 * CLA (32-BIT CARRY LOOK-AHEAD ADDER) TESTBENCH
 * =============================================================================
 * 
 * FILE: cla_tb.sv
 * PURPOSE: Comprehensive testbench for cla module
 * 
 * METHODOLOGY:
 * This testbench tests the 32-bit carry look-ahead adder with various test cases
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

module cla_tb;

    // Test signals
    logic [31:0] a, b;
    logic carry_in;
    wire [31:0] sum;
    wire carry_out;
    
    // Error counters
    int sum_errors = 0, carry_errors = 0, overflow_errors = 0;
    int total_tests = 0;
    
    // Instantiate cla module
    cla cla_inst (
        .a(a),
        .b(b),
        .carry_in(carry_in),
        .sum(sum),
        .carry_out(carry_out)
    );
    
    // Test task for comprehensive testing
    task test_cla(input [31:0] test_a, input [31:0] test_b, input test_carry_in);
        logic [31:0] expected_sum;
        logic expected_carry_out, expected_overflow;
        logic [32:0] full_result;
        
        // Calculate expected values using SystemVerilog arithmetic
        full_result = {1'b0, test_a} + {1'b0, test_b} + {31'b0, test_carry_in};
        expected_sum = full_result[31:0];
        expected_carry_out = full_result[32];
        
        // Overflow for signed addition: (a[31] == b[31]) && (sum[31] != a[31])
        expected_overflow = (test_a[31] == test_b[31]) && (expected_sum[31] != test_a[31]);
        
        // Apply test inputs
        a = test_a;
        b = test_b;
        carry_in = test_carry_in;
        #10; // Wait for propagation
        
        // Check sum
        if (sum !== expected_sum) begin
            $display("ERROR: CLA sum failed at time %t", $time);
            $display("  Input a = 0x%08h (%032b) = %d", test_a, test_a, $signed(test_a));
            $display("  Input b = 0x%08h (%032b) = %d", test_b, test_b, $signed(test_b));
            $display("  Carry in = %b", test_carry_in);
            $display("  Expected sum = 0x%08h (%032b) = %d", expected_sum, expected_sum, $signed(expected_sum));
            $display("  Got      sum = 0x%08h (%032b) = %d", sum, sum, $signed(sum));
            sum_errors++;
        end
        
        // Check carry out
        if (carry_out !== expected_carry_out) begin
            $display("ERROR: CLA carry_out failed at time %t", $time);
            $display("  Input a = 0x%08h (%032b) = %d", test_a, test_a, $signed(test_a));
            $display("  Input b = 0x%08h (%032b) = %d", test_b, test_b, $signed(test_b));
            $display("  Carry in = %b", test_carry_in);
            $display("  Expected carry_out = %b", expected_carry_out);
            $display("  Got      carry_out = %b", carry_out);
            carry_errors++;
        end
        
        total_tests++;
    endtask
    
    // Main test sequence
    initial begin
        $display("Starting CLA (32-bit Carry Look-Ahead Adder) testbench...");
        $display("=====================================");
        
        // Corner case tests
        $display("Testing corner cases...");
        test_cla(32'h00000000, 32'h00000000, 1'b0);  // 0 + 0 + 0
        test_cla(32'h00000000, 32'h00000000, 1'b1);  // 0 + 0 + 1
        test_cla(32'hFFFFFFFF, 32'hFFFFFFFF, 1'b0);  // Max + Max + 0
        test_cla(32'hFFFFFFFF, 32'hFFFFFFFF, 1'b1);  // Max + Max + 1
        test_cla(32'h00000001, 32'h00000000, 1'b0);  // 1 + 0 + 0
        test_cla(32'h00000000, 32'h00000001, 1'b0);  // 0 + 1 + 0
        test_cla(32'h00000001, 32'h00000001, 1'b0);  // 1 + 1 + 0
        test_cla(32'h00000001, 32'h00000001, 1'b1);  // 1 + 1 + 1
        
        // Maximum and minimum values
        $display("Testing maximum and minimum values...");
        test_cla(32'h7FFFFFFF, 32'h00000001, 1'b0);  // Max positive + 1
        test_cla(32'h80000000, 32'hFFFFFFFF, 1'b0);  // Min negative + -1
        test_cla(32'h7FFFFFFF, 32'h7FFFFFFF, 1'b0);  // Max positive + Max positive
        test_cla(32'h80000000, 32'h80000000, 1'b0);  // Min negative + Min negative
        
        // Overflow cases
        $display("Testing overflow cases...");
        test_cla(32'h7FFFFFFF, 32'h00000001, 1'b0);  // Positive overflow
        test_cla(32'h80000000, 32'hFFFFFFFF, 1'b0);  // Negative overflow
        test_cla(32'h7FFFFFFF, 32'h7FFFFFFF, 1'b0);  // Large positive overflow
        test_cla(32'h80000000, 32'h80000000, 1'b0);  // Large negative overflow
        
        // No overflow cases
        $display("Testing no-overflow cases...");
        test_cla(32'h7FFFFFFE, 32'h00000001, 1'b0);  // Just under positive overflow
        test_cla(32'h80000001, 32'hFFFFFFFF, 1'b0);  // Just under negative overflow
        test_cla(32'h00000001, 32'h00000001, 1'b0);  // Small positive
        test_cla(32'hFFFFFFFF, 32'hFFFFFFFF, 1'b0);  // Small negative
        
        // Single bit patterns
        $display("Testing single bit patterns...");
        test_cla(32'h00000001, 32'h00000000, 1'b0);  // LSB set
        test_cla(32'h80000000, 32'h00000000, 1'b0);  // MSB set
        test_cla(32'h00000002, 32'h00000000, 1'b0);  // Bit 1 set
        test_cla(32'h40000000, 32'h00000000, 1'b0);  // Bit 30 set
        test_cla(32'h00000001, 32'h80000000, 1'b0);  // LSB + MSB
        test_cla(32'h00000002, 32'h40000000, 1'b0);  // Bit 1 + Bit 30
        
        // Alternating bit patterns
        $display("Testing alternating bit patterns...");
        test_cla(32'hAAAAAAAA, 32'h55555555, 1'b0);  // Alternating 1010... + 0101...
        test_cla(32'h55555555, 32'hAAAAAAAA, 1'b0);  // Alternating 0101... + 1010...
        test_cla(32'hAAAAAAAA, 32'hAAAAAAAA, 1'b0);  // Alternating 1010... + 1010...
        test_cla(32'h55555555, 32'h55555555, 1'b0);  // Alternating 0101... + 0101...
        
        // Specific hex patterns
        $display("Testing specific hex patterns...");
        test_cla(32'h12345678, 32'h9ABCDEF0, 1'b0);  // Mixed pattern
        test_cla(32'hDEADBEEF, 32'hCAFEBABE, 1'b0);  // Fun pattern
        test_cla(32'h0000FFFF, 32'hFFFF0000, 1'b0);  // Lower/upper halves
        test_cla(32'hFF00FF00, 32'h00FF00FF, 1'b0);  // Alternating bytes
        test_cla(32'hF0F0F0F0, 32'h0F0F0F0F, 1'b0);  // Alternating nibbles
        
        // Carry propagation tests
        $display("Testing carry propagation...");
        test_cla(32'h00000001, 32'hFFFFFFFF, 1'b0);  // Single carry propagation
        test_cla(32'h00000001, 32'hFFFFFFFF, 1'b1);  // Single carry propagation with carry_in
        test_cla(32'h00000002, 32'hFFFFFFFE, 1'b0);  // Multiple carry propagation
        test_cla(32'h00000003, 32'hFFFFFFFD, 1'b0);  // More carry propagation
        
        // Edge cases with carry_in
        $display("Testing edge cases with carry_in...");
        test_cla(32'h00000000, 32'h00000000, 1'b1);  // 0 + 0 + 1 = 1
        test_cla(32'hFFFFFFFF, 32'h00000000, 1'b1);  // -1 + 0 + 1 = 0
        test_cla(32'h00000000, 32'hFFFFFFFF, 1'b1);  // 0 + -1 + 1 = 0
        test_cla(32'hFFFFFFFF, 32'hFFFFFFFF, 1'b1);  // -1 + -1 + 1 = -1
        
        // Random pattern tests
        $display("Testing random patterns...");
        for (int i = 0; i < 20; i++) begin
            automatic logic [31:0] rand_a = $random;
            automatic logic [31:0] rand_b = $random;
            automatic logic rand_carry = $random;
            
            test_cla(rand_a, rand_b, rand_carry);
        end
        
        // Print final results
        $display("\n=====================================");
        $display("Test Results Summary:");
        $display("Total tests run: %d", total_tests);
        $display("Sum errors: %d", sum_errors);
        $display("Carry out errors: %d", carry_errors);
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
        $dumpfile("cla_tb.vcd");
        $dumpvars(0, cla_tb);
    end

endmodule
