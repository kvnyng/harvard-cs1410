module cla16_hierarchical_tb;

    // Testbench signals
    logic [15:0] a, b;
    logic carry_in;
    logic [15:0] sum;
    logic carry_out;
    logic overflow;
    logic generate_out;
    logic propagate_out;
    
    // Error counters
    int sum_errors = 0, carry_errors = 0, overflow_errors = 0;
    int total_tests = 0;
    
    // Instantiate cla16 module
    cla16 cla16_inst (
        .a(a),
        .b(b),
        .carry_in(carry_in),
        .sum(sum),
        .carry_out(carry_out),
        .overflow(overflow),
        .generate_out(generate_out),
        .propagate_out(propagate_out)
    );
    
    // Test task for hierarchical CLA testing
    task test_cla16_hierarchical(input [15:0] test_a, input [15:0] test_b, input test_carry_in, string test_name);
        logic [15:0] expected_sum;
        logic expected_carry_out;
        logic expected_overflow;
        
        // Calculate expected results
        {expected_carry_out, expected_sum} = test_a + test_b + test_carry_in;
        expected_overflow = (test_a[15] == test_b[15]) && (expected_sum[15] != test_a[15]);
        
        // Apply inputs
        a = test_a;
        b = test_b;
        carry_in = test_carry_in;
        #10; // Wait for propagation
        
        // Check results
        total_tests++;
        
        if (sum !== expected_sum) begin
            $display("ERROR: %s - CLA16 sum failed at time %t", test_name, $time);
            $display("  Input a = 0x%h (%d) = %d", test_a, test_a, $signed(test_a));
            $display("  Input b = 0x%h (%d) = %d", test_b, test_b, $signed(test_b));
            $display("  Carry in = %d", test_carry_in);
            $display("  Expected sum = 0x%h (%d) = %d", expected_sum, expected_sum, $signed(expected_sum));
            $display("  Got      sum = 0x%h (%d) = %d", sum, sum, $signed(sum));
            sum_errors++;
        end
        
        if (carry_out !== expected_carry_out) begin
            $display("ERROR: %s - CLA16 carry_out failed at time %t", test_name, $time);
            $display("  Input a = 0x%h (%d) = %d", test_a, test_a, $signed(test_a));
            $display("  Input b = 0x%h (%d) = %d", test_b, test_b, $signed(test_b));
            $display("  Carry in = %d", test_carry_in);
            $display("  Expected carry_out = %d", expected_carry_out);
            $display("  Got      carry_out = %d", carry_out);
            carry_errors++;
        end
        
        if (overflow !== expected_overflow) begin
            $display("ERROR: %s - CLA16 overflow failed at time %t", test_name, $time);
            $display("  Input a = 0x%h (%d) = %d", test_a, test_a, $signed(test_a));
            $display("  Input b = 0x%h (%d) = %d", test_b, test_b, $signed(test_b));
            $display("  Carry in = %d", test_carry_in);
            $display("  Expected overflow = %d", expected_overflow);
            $display("  Got      overflow = %d", overflow);
            overflow_errors++;
        end
    endtask
    
    initial begin
        $display("Starting CLA16 Hierarchical Carry Look-Ahead Test...");
        $display("Testing arithmetic correctness with hierarchical carry look-ahead");
        $display("=====================================");
        
        // Test 1: Basic Addition
        $display("\n=== TEST 1: BASIC ADDITION ===");
        test_cla16_hierarchical(16'h0001, 16'h0001, 1'b0, "Basic Addition 1+1");
        test_cla16_hierarchical(16'h0002, 16'h0003, 1'b0, "Basic Addition 2+3");
        test_cla16_hierarchical(16'h000A, 16'h000B, 1'b0, "Basic Addition 10+11");
        test_cla16_hierarchical(16'h00FF, 16'h0001, 1'b0, "Basic Addition 255+1");
        test_cla16_hierarchical(16'hFFFF, 16'h0001, 1'b0, "Basic Addition 65535+1");
        test_cla16_hierarchical(16'h7FFF, 16'h0001, 1'b0, "Basic Addition MAX_INT+1");
        
        // Test 2: Basic Subtraction (using two's complement)
        $display("\n=== TEST 2: BASIC SUBTRACTION ===");
        test_cla16_hierarchical(16'h0005, 16'hFFFE, 1'b0, "Subtraction 5-2"); // 5 + (-2)
        test_cla16_hierarchical(16'h000A, 16'hFFF6, 1'b0, "Subtraction 10-10"); // 10 + (-10)
        test_cla16_hierarchical(16'h000F, 16'hFFF1, 1'b0, "Subtraction 15-15"); // 15 + (-15)
        test_cla16_hierarchical(16'h0064, 16'hFF9C, 1'b0, "Subtraction 100-100"); // 100 + (-100)
        test_cla16_hierarchical(16'h0000, 16'hFFFF, 1'b0, "Subtraction 0-1"); // 0 + (-1)
        test_cla16_hierarchical(16'h0001, 16'hFFFF, 1'b0, "Subtraction 1-1"); // 1 + (-1)
        
        // Test 3: Zero Operations
        $display("\n=== TEST 3: ZERO OPERATIONS ===");
        test_cla16_hierarchical(16'h0000, 16'h0000, 1'b0, "Zero + Zero");
        test_cla16_hierarchical(16'h0000, 16'h0000, 1'b1, "Zero + Zero + Carry");
        test_cla16_hierarchical(16'h0001, 16'h0000, 1'b0, "One + Zero");
        test_cla16_hierarchical(16'h0000, 16'h0001, 1'b0, "Zero + One");
        test_cla16_hierarchical(16'hFFFF, 16'h0000, 1'b0, "Max + Zero");
        test_cla16_hierarchical(16'h0000, 16'hFFFF, 1'b0, "Zero + Max");
        
        // Test 4: Maximum Values
        $display("\n=== TEST 4: MAXIMUM VALUES ===");
        test_cla16_hierarchical(16'hFFFF, 16'hFFFF, 1'b0, "Max + Max");
        test_cla16_hierarchical(16'hFFFF, 16'hFFFF, 1'b1, "Max + Max + Carry");
        test_cla16_hierarchical(16'h7FFF, 16'h7FFF, 1'b0, "Max Positive + Max Positive");
        test_cla16_hierarchical(16'h8000, 16'h8000, 1'b0, "Min Negative + Min Negative");
        test_cla16_hierarchical(16'h7FFF, 16'h8000, 1'b0, "Max Positive + Min Negative");
        test_cla16_hierarchical(16'h8000, 16'h7FFF, 1'b0, "Min Negative + Max Positive");
        
        // Test 5: Overflow Cases
        $display("\n=== TEST 5: OVERFLOW CASES ===");
        test_cla16_hierarchical(16'h7FFF, 16'h0001, 1'b0, "Overflow: MAX+1");
        test_cla16_hierarchical(16'h7FFE, 16'h0002, 1'b0, "Overflow: MAX-1+2");
        test_cla16_hierarchical(16'h7FFF, 16'h7FFF, 1'b0, "Overflow: MAX+MAX");
        test_cla16_hierarchical(16'h8000, 16'hFFFF, 1'b0, "Overflow: MIN+(-1)");
        test_cla16_hierarchical(16'h8001, 16'hFFFE, 1'b0, "Overflow: MIN+1+(-2)");
        test_cla16_hierarchical(16'h8000, 16'h8000, 1'b0, "Overflow: MIN+MIN");
        
        // Test 6: No Overflow Cases
        $display("\n=== TEST 6: NO OVERFLOW CASES ===");
        test_cla16_hierarchical(16'h7FFE, 16'h0001, 1'b0, "No Overflow: MAX-1+1");
        test_cla16_hierarchical(16'h7FFF, 16'hFFFF, 1'b0, "No Overflow: MAX+(-1)");
        test_cla16_hierarchical(16'h8001, 16'hFFFF, 1'b0, "No Overflow: MIN+1+(-1)");
        test_cla16_hierarchical(16'h0001, 16'h0001, 1'b0, "No Overflow: 1+1");
        test_cla16_hierarchical(16'h0000, 16'h0000, 1'b0, "No Overflow: 0+0");
        test_cla16_hierarchical(16'hFFFF, 16'h0001, 1'b0, "No Overflow: (-1)+1");
        
        // Test 7: Carry Propagation
        $display("\n=== TEST 7: CARRY PROPAGATION ===");
        test_cla16_hierarchical(16'h0001, 16'hFFFF, 1'b0, "Carry Propagation: 1+(-1)");
        test_cla16_hierarchical(16'h0002, 16'hFFFE, 1'b0, "Carry Propagation: 2+(-2)");
        test_cla16_hierarchical(16'h0003, 16'hFFFD, 1'b0, "Carry Propagation: 3+(-3)");
        test_cla16_hierarchical(16'h0004, 16'hFFFC, 1'b0, "Carry Propagation: 4+(-4)");
        test_cla16_hierarchical(16'h0005, 16'hFFFB, 1'b0, "Carry Propagation: 5+(-5)");
        test_cla16_hierarchical(16'h0010, 16'hFFF0, 1'b0, "Carry Propagation: 16+(-16)");
        
        // Test 8: Large Numbers
        $display("\n=== TEST 8: LARGE NUMBERS ===");
        test_cla16_hierarchical(16'h1234, 16'h9ABC, 1'b0, "Large Numbers: 0x1234+0x9ABC");
        test_cla16_hierarchical(16'hDEAD, 16'hBEEF, 1'b0, "Large Numbers: 0xDEAD+0xBEEF");
        test_cla16_hierarchical(16'hCAFE, 16'hFEED, 1'b0, "Large Numbers: 0xCAFE+0xFEED");
        test_cla16_hierarchical(16'hFACE, 16'hB00B, 1'b0, "Large Numbers: 0xFACE+0xB00B");
        test_cla16_hierarchical(16'h1111, 16'h2222, 1'b0, "Large Numbers: 0x1111+0x2222");
        test_cla16_hierarchical(16'h3333, 16'h4444, 1'b0, "Large Numbers: 0x3333+0x4444");
        
        // Test 9: Random Patterns
        $display("\n=== TEST 9: RANDOM PATTERNS ===");
        test_cla16_hierarchical(16'h3524, 16'h5E81, 1'b1, "Random: 0x3524+0x5E81+Carry");
        test_cla16_hierarchical(16'h5663, 16'h7B0D, 1'b1, "Random: 0x5663+0x7B0D+Carry");
        test_cla16_hierarchical(16'h8465, 16'h5212, 1'b1, "Random: 0x8465+0x5212+Carry");
        test_cla16_hierarchical(16'hCD0D, 16'hF176, 1'b1, "Random: 0xCD0D+0xF176+Carry");
        test_cla16_hierarchical(16'h57ED, 16'hF78C, 1'b1, "Random: 0x57ED+0xF78C+Carry");
        test_cla16_hierarchical(16'h24C6, 16'h84C5, 1'b0, "Random: 0x24C6+0x84C5");
        
        // Test 10: Edge Cases
        $display("\n=== TEST 10: EDGE CASES ===");
        test_cla16_hierarchical(16'h0001, 16'h0000, 1'b1, "Edge: 1+0+Carry");
        test_cla16_hierarchical(16'h0000, 16'h0001, 1'b1, "Edge: 0+1+Carry");
        test_cla16_hierarchical(16'hFFFF, 16'h0000, 1'b1, "Edge: (-1)+0+Carry");
        test_cla16_hierarchical(16'h0000, 16'hFFFF, 1'b1, "Edge: 0+(-1)+Carry");
        test_cla16_hierarchical(16'h7FFF, 16'h0000, 1'b1, "Edge: MAX+0+Carry");
        test_cla16_hierarchical(16'h8000, 16'h0000, 1'b1, "Edge: MIN+0+Carry");
        
        // Test 11: Power of 2 Operations
        $display("\n=== TEST 11: POWER OF 2 OPERATIONS ===");
        test_cla16_hierarchical(16'h0001, 16'h0001, 1'b0, "Power of 2: 1+1");
        test_cla16_hierarchical(16'h0002, 16'h0002, 1'b0, "Power of 2: 2+2");
        test_cla16_hierarchical(16'h0004, 16'h0004, 1'b0, "Power of 2: 4+4");
        test_cla16_hierarchical(16'h0008, 16'h0008, 1'b0, "Power of 2: 8+8");
        test_cla16_hierarchical(16'h0010, 16'h0010, 1'b0, "Power of 2: 16+16");
        test_cla16_hierarchical(16'h0020, 16'h0020, 1'b0, "Power of 2: 32+32");
        test_cla16_hierarchical(16'h0040, 16'h0040, 1'b0, "Power of 2: 64+64");
        test_cla16_hierarchical(16'h0080, 16'h0080, 1'b0, "Power of 2: 128+128");
        test_cla16_hierarchical(16'h0100, 16'h0100, 1'b0, "Power of 2: 256+256");
        test_cla16_hierarchical(16'h1000, 16'h1000, 1'b0, "Power of 2: 4096+4096");
        test_cla16_hierarchical(16'h4000, 16'h4000, 1'b0, "Power of 2: 16384+16384");
        
        // Test 12: Alternating Bit Patterns
        $display("\n=== TEST 12: ALTERNATING BIT PATTERNS ===");
        test_cla16_hierarchical(16'hAAAA, 16'hAAAA, 1'b0, "Alternating: 0xAAAA+0xAAAA");
        test_cla16_hierarchical(16'h5555, 16'h5555, 1'b0, "Alternating: 0x5555+0x5555");
        test_cla16_hierarchical(16'hAAAA, 16'h5555, 1'b0, "Alternating: 0xAAAA+0x5555");
        test_cla16_hierarchical(16'h5555, 16'hAAAA, 1'b0, "Alternating: 0x5555+0xAAAA");
        test_cla16_hierarchical(16'hCCCC, 16'hCCCC, 1'b0, "Alternating: 0xCCCC+0xCCCC");
        test_cla16_hierarchical(16'h3333, 16'h3333, 1'b0, "Alternating: 0x3333+0x3333");
        
        // Test 13: Sequential Numbers
        $display("\n=== TEST 13: SEQUENTIAL NUMBERS ===");
        test_cla16_hierarchical(16'h0001, 16'h0002, 1'b0, "Sequential: 1+2");
        test_cla16_hierarchical(16'h0002, 16'h0003, 1'b0, "Sequential: 2+3");
        test_cla16_hierarchical(16'h0003, 16'h0004, 1'b0, "Sequential: 3+4");
        test_cla16_hierarchical(16'h0004, 16'h0005, 1'b0, "Sequential: 4+5");
        test_cla16_hierarchical(16'h0005, 16'h0006, 1'b0, "Sequential: 5+6");
        test_cla16_hierarchical(16'h000A, 16'h000B, 1'b0, "Sequential: 10+11");
        test_cla16_hierarchical(16'h0064, 16'h0065, 1'b0, "Sequential: 100+101");
        test_cla16_hierarchical(16'h03E8, 16'h03E9, 1'b0, "Sequential: 1000+1001");
        
        // Test 14: Boundary Values
        $display("\n=== TEST 14: BOUNDARY VALUES ===");
        test_cla16_hierarchical(16'h0000, 16'h0001, 1'b0, "Boundary: 0+1");
        test_cla16_hierarchical(16'h0001, 16'h0000, 1'b0, "Boundary: 1+0");
        test_cla16_hierarchical(16'h7FFF, 16'h0001, 1'b0, "Boundary: MAX+1");
        test_cla16_hierarchical(16'h8000, 16'hFFFF, 1'b0, "Boundary: MIN+(-1)");
        test_cla16_hierarchical(16'h0000, 16'hFFFF, 1'b0, "Boundary: 0+(-1)");
        test_cla16_hierarchical(16'hFFFF, 16'h0001, 1'b0, "Boundary: (-1)+1");
        
        // Print results
        $display("\n=====================================");
        $display("HIERARCHICAL CLA16 TEST RESULTS SUMMARY:");
        $display("=====================================");
        $display("Total tests run: %12d", total_tests);
        $display("Sum errors: %12d", sum_errors);
        $display("Carry out errors: %12d", carry_errors);
        $display("Overflow errors: %12d", overflow_errors);
        $display("");
        
        if (sum_errors == 0 && carry_errors == 0 && overflow_errors == 0) begin
            $display("🎉 ALL TESTS PASSED! 🎉");
            $display("CLA16 hierarchical carry look-ahead is working correctly!");
        end else begin
            $display("❌ SOME TESTS FAILED! ❌");
            $display("CLA16 hierarchical carry look-ahead has issues.");
            if (sum_errors > 0) $display("  - %d sum calculation errors", sum_errors);
            if (carry_errors > 0) $display("  - %d carry out errors", carry_errors);
            if (overflow_errors > 0) $display("  - %d overflow detection errors", overflow_errors);
        end
        $display("=====================================");
        
        $finish;
    end

endmodule
