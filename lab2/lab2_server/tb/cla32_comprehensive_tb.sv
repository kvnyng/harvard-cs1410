module cla32_comprehensive_tb;

    // Testbench signals
    logic [31:0] a, b;
    logic carry_in;
    logic [31:0] sum;
    logic carry_out;
    logic overflow;
    logic generate_out;
    logic propagate_out;
    
    // Error counters
    int sum_errors = 0, carry_errors = 0, overflow_errors = 0;
    int total_tests = 0;
    
    // Instantiate cla32 module
    cla32 cla32_inst (
        .a(a),
        .b(b),
        .carry_in(carry_in),
        .sum(sum),
        .carry_out(carry_out),
        .overflow(overflow),
        .generate_out(generate_out),
        .propagate_out(propagate_out)
    );
    
    // Test task for comprehensive testing
    task test_cla32_arithmetic(input [31:0] test_a, input [31:0] test_b, input test_carry_in, string test_name);
        logic [31:0] expected_sum;
        logic expected_carry_out;
        logic expected_overflow;
        
        // Calculate expected results
        {expected_carry_out, expected_sum} = test_a + test_b + test_carry_in;
        expected_overflow = (test_a[31] == test_b[31]) && (expected_sum[31] != test_a[31]);
        
        // Apply inputs
        a = test_a;
        b = test_b;
        carry_in = test_carry_in;
        #10; // Wait for propagation
        
        // Check results
        total_tests++;
        
        if (sum !== expected_sum) begin
            $display("ERROR: %s - CLA32 sum failed at time %t", test_name, $time);
            $display("  Input a = 0x%h (%d) = %d", test_a, test_a, $signed(test_a));
            $display("  Input b = 0x%h (%d) = %d", test_b, test_b, $signed(test_b));
            $display("  Carry in = %d", test_carry_in);
            $display("  Expected sum = 0x%h (%d) = %d", expected_sum, expected_sum, $signed(expected_sum));
            $display("  Got      sum = 0x%h (%d) = %d", sum, sum, $signed(sum));
            sum_errors++;
        end
        
        if (carry_out !== expected_carry_out) begin
            $display("ERROR: %s - CLA32 carry_out failed at time %t", test_name, $time);
            $display("  Input a = 0x%h (%d) = %d", test_a, test_a, $signed(test_a));
            $display("  Input b = 0x%h (%d) = %d", test_b, test_b, $signed(test_b));
            $display("  Carry in = %d", test_carry_in);
            $display("  Expected carry_out = %d", expected_carry_out);
            $display("  Got      carry_out = %d", carry_out);
            carry_errors++;
        end
        
        if (overflow !== expected_overflow) begin
            $display("ERROR: %s - CLA32 overflow failed at time %t", test_name, $time);
            $display("  Input a = 0x%h (%d) = %d", test_a, test_a, $signed(test_a));
            $display("  Input b = 0x%h (%d) = %d", test_b, test_b, $signed(test_b));
            $display("  Carry in = %d", test_carry_in);
            $display("  Expected overflow = %d", expected_overflow);
            $display("  Got      overflow = %d", overflow);
            overflow_errors++;
        end
    endtask
    
    initial begin
        $display("Starting CLA32 Comprehensive Arithmetic Test...");
        $display("Testing all addition and subtraction tasks");
        $display("=====================================");
        
        // Test 1: Basic Addition
        $display("\n=== TEST 1: BASIC ADDITION ===");
        test_cla32_arithmetic(32'h00000001, 32'h00000001, 1'b0, "Basic Addition 1+1");
        test_cla32_arithmetic(32'h00000002, 32'h00000003, 1'b0, "Basic Addition 2+3");
        test_cla32_arithmetic(32'h0000000A, 32'h0000000B, 1'b0, "Basic Addition 10+11");
        test_cla32_arithmetic(32'h000000FF, 32'h00000001, 1'b0, "Basic Addition 255+1");
        test_cla32_arithmetic(32'h0000FFFF, 32'h00000001, 1'b0, "Basic Addition 65535+1");
        test_cla32_arithmetic(32'h7FFFFFFF, 32'h00000001, 1'b0, "Basic Addition MAX_INT+1");
        
        // Test 2: Basic Subtraction (using two's complement)
        $display("\n=== TEST 2: BASIC SUBTRACTION ===");
        test_cla32_arithmetic(32'h00000005, 32'hFFFFFFFE, 1'b0, "Subtraction 5-2"); // 5 + (-2)
        test_cla32_arithmetic(32'h0000000A, 32'hFFFFFFF6, 1'b0, "Subtraction 10-10"); // 10 + (-10)
        test_cla32_arithmetic(32'h0000000F, 32'hFFFFFFF1, 1'b0, "Subtraction 15-15"); // 15 + (-15)
        test_cla32_arithmetic(32'h00000064, 32'hFFFFFF9C, 1'b0, "Subtraction 100-100"); // 100 + (-100)
        test_cla32_arithmetic(32'h00000000, 32'hFFFFFFFF, 1'b0, "Subtraction 0-1"); // 0 + (-1)
        test_cla32_arithmetic(32'h00000001, 32'hFFFFFFFF, 1'b0, "Subtraction 1-1"); // 1 + (-1)
        
        // Test 3: Zero Operations
        $display("\n=== TEST 3: ZERO OPERATIONS ===");
        test_cla32_arithmetic(32'h00000000, 32'h00000000, 1'b0, "Zero + Zero");
        test_cla32_arithmetic(32'h00000000, 32'h00000000, 1'b1, "Zero + Zero + Carry");
        test_cla32_arithmetic(32'h00000001, 32'h00000000, 1'b0, "One + Zero");
        test_cla32_arithmetic(32'h00000000, 32'h00000001, 1'b0, "Zero + One");
        test_cla32_arithmetic(32'hFFFFFFFF, 32'h00000000, 1'b0, "Max + Zero");
        test_cla32_arithmetic(32'h00000000, 32'hFFFFFFFF, 1'b0, "Zero + Max");
        
        // Test 4: Maximum Values
        $display("\n=== TEST 4: MAXIMUM VALUES ===");
        test_cla32_arithmetic(32'hFFFFFFFF, 32'hFFFFFFFF, 1'b0, "Max + Max");
        test_cla32_arithmetic(32'hFFFFFFFF, 32'hFFFFFFFF, 1'b1, "Max + Max + Carry");
        test_cla32_arithmetic(32'h7FFFFFFF, 32'h7FFFFFFF, 1'b0, "Max Positive + Max Positive");
        test_cla32_arithmetic(32'h80000000, 32'h80000000, 1'b0, "Min Negative + Min Negative");
        test_cla32_arithmetic(32'h7FFFFFFF, 32'h80000000, 1'b0, "Max Positive + Min Negative");
        test_cla32_arithmetic(32'h80000000, 32'h7FFFFFFF, 1'b0, "Min Negative + Max Positive");
        
        // Test 5: Overflow Cases
        $display("\n=== TEST 5: OVERFLOW CASES ===");
        test_cla32_arithmetic(32'h7FFFFFFF, 32'h00000001, 1'b0, "Overflow: MAX+1");
        test_cla32_arithmetic(32'h7FFFFFFE, 32'h00000002, 1'b0, "Overflow: MAX-1+2");
        test_cla32_arithmetic(32'h7FFFFFFF, 32'h7FFFFFFF, 1'b0, "Overflow: MAX+MAX");
        test_cla32_arithmetic(32'h80000000, 32'hFFFFFFFF, 1'b0, "Overflow: MIN+(-1)");
        test_cla32_arithmetic(32'h80000001, 32'hFFFFFFFE, 1'b0, "Overflow: MIN+1+(-2)");
        test_cla32_arithmetic(32'h80000000, 32'h80000000, 1'b0, "Overflow: MIN+MIN");
        
        // Test 6: No Overflow Cases
        $display("\n=== TEST 6: NO OVERFLOW CASES ===");
        test_cla32_arithmetic(32'h7FFFFFFE, 32'h00000001, 1'b0, "No Overflow: MAX-1+1");
        test_cla32_arithmetic(32'h7FFFFFFF, 32'hFFFFFFFF, 1'b0, "No Overflow: MAX+(-1)");
        test_cla32_arithmetic(32'h80000001, 32'hFFFFFFFF, 1'b0, "No Overflow: MIN+1+(-1)");
        test_cla32_arithmetic(32'h00000001, 32'h00000001, 1'b0, "No Overflow: 1+1");
        test_cla32_arithmetic(32'h00000000, 32'h00000000, 1'b0, "No Overflow: 0+0");
        test_cla32_arithmetic(32'hFFFFFFFF, 32'h00000001, 1'b0, "No Overflow: (-1)+1");
        
        // Test 7: Carry Propagation
        $display("\n=== TEST 7: CARRY PROPAGATION ===");
        test_cla32_arithmetic(32'h00000001, 32'hFFFFFFFF, 1'b0, "Carry Propagation: 1+(-1)");
        test_cla32_arithmetic(32'h00000002, 32'hFFFFFFFE, 1'b0, "Carry Propagation: 2+(-2)");
        test_cla32_arithmetic(32'h00000003, 32'hFFFFFFFD, 1'b0, "Carry Propagation: 3+(-3)");
        test_cla32_arithmetic(32'h00000004, 32'hFFFFFFFC, 1'b0, "Carry Propagation: 4+(-4)");
        test_cla32_arithmetic(32'h00000005, 32'hFFFFFFFB, 1'b0, "Carry Propagation: 5+(-5)");
        test_cla32_arithmetic(32'h00000010, 32'hFFFFFFF0, 1'b0, "Carry Propagation: 16+(-16)");
        
        // Test 8: Large Numbers
        $display("\n=== TEST 8: LARGE NUMBERS ===");
        test_cla32_arithmetic(32'h12345678, 32'h9ABCDEF0, 1'b0, "Large Numbers: 0x12345678+0x9ABCDEF0");
        test_cla32_arithmetic(32'hDEADBEEF, 32'hBEEFCAFE, 1'b0, "Large Numbers: 0xDEADBEEF+0xBEEFCAFE");
        test_cla32_arithmetic(32'hCAFEBABE, 32'hFEEDFACE, 1'b0, "Large Numbers: 0xCAFEBABE+0xFEEDFACE");
        test_cla32_arithmetic(32'hFACEB00C, 32'hB00B1355, 1'b0, "Large Numbers: 0xFACEB00C+0xB00B1355");
        test_cla32_arithmetic(32'h11111111, 32'h22222222, 1'b0, "Large Numbers: 0x11111111+0x22222222");
        test_cla32_arithmetic(32'h33333333, 32'h44444444, 1'b0, "Large Numbers: 0x33333333+0x44444444");
        
        // Test 9: Random Patterns
        $display("\n=== TEST 9: RANDOM PATTERNS ===");
        test_cla32_arithmetic(32'h3524A1B2, 32'h5E81C3D4, 1'b1, "Random: 0x3524A1B2+0x5E81C3D4+Carry");
        test_cla32_arithmetic(32'h5663E5F6, 32'h7B0D9A8B, 1'b1, "Random: 0x5663E5F6+0x7B0D9A8B+Carry");
        test_cla32_arithmetic(32'h8465C7D8, 32'h5212E3F4, 1'b1, "Random: 0x8465C7D8+0x5212E3F4+Carry");
        test_cla32_arithmetic(32'hCD0DF1A2, 32'hF176B3C4, 1'b1, "Random: 0xCD0DF1A2+0xF176B3C4+Carry");
        test_cla32_arithmetic(32'h57EDC5D6, 32'hF78CE9FA, 1'b1, "Random: 0x57EDC5D6+0xF78CE9FA+Carry");
        test_cla32_arithmetic(32'h24C6A1B2, 32'h84C5C3D4, 1'b0, "Random: 0x24C6A1B2+0x84C5C3D4");
        
        // Test 10: Edge Cases
        $display("\n=== TEST 10: EDGE CASES ===");
        test_cla32_arithmetic(32'h00000001, 32'h00000000, 1'b1, "Edge: 1+0+Carry");
        test_cla32_arithmetic(32'h00000000, 32'h00000001, 1'b1, "Edge: 0+1+Carry");
        test_cla32_arithmetic(32'hFFFFFFFF, 32'h00000000, 1'b1, "Edge: (-1)+0+Carry");
        test_cla32_arithmetic(32'h00000000, 32'hFFFFFFFF, 1'b1, "Edge: 0+(-1)+Carry");
        test_cla32_arithmetic(32'h7FFFFFFF, 32'h00000000, 1'b1, "Edge: MAX+0+Carry");
        test_cla32_arithmetic(32'h80000000, 32'h00000000, 1'b1, "Edge: MIN+0+Carry");
        
        // Test 11: Power of 2 Operations
        $display("\n=== TEST 11: POWER OF 2 OPERATIONS ===");
        test_cla32_arithmetic(32'h00000001, 32'h00000001, 1'b0, "Power of 2: 1+1");
        test_cla32_arithmetic(32'h00000002, 32'h00000002, 1'b0, "Power of 2: 2+2");
        test_cla32_arithmetic(32'h00000004, 32'h00000004, 1'b0, "Power of 2: 4+4");
        test_cla32_arithmetic(32'h00000008, 32'h00000008, 1'b0, "Power of 2: 8+8");
        test_cla32_arithmetic(32'h00000010, 32'h00000010, 1'b0, "Power of 2: 16+16");
        test_cla32_arithmetic(32'h00000020, 32'h00000020, 1'b0, "Power of 2: 32+32");
        test_cla32_arithmetic(32'h00000040, 32'h00000040, 1'b0, "Power of 2: 64+64");
        test_cla32_arithmetic(32'h00000080, 32'h00000080, 1'b0, "Power of 2: 128+128");
        test_cla32_arithmetic(32'h00000100, 32'h00000100, 1'b0, "Power of 2: 256+256");
        test_cla32_arithmetic(32'h00001000, 32'h00001000, 1'b0, "Power of 2: 4096+4096");
        test_cla32_arithmetic(32'h00010000, 32'h00010000, 1'b0, "Power of 2: 65536+65536");
        test_cla32_arithmetic(32'h00100000, 32'h00100000, 1'b0, "Power of 2: 1048576+1048576");
        test_cla32_arithmetic(32'h01000000, 32'h01000000, 1'b0, "Power of 2: 16777216+16777216");
        test_cla32_arithmetic(32'h10000000, 32'h10000000, 1'b0, "Power of 2: 268435456+268435456");
        test_cla32_arithmetic(32'h40000000, 32'h40000000, 1'b0, "Power of 2: 1073741824+1073741824");
        
        // Test 12: Alternating Bit Patterns
        $display("\n=== TEST 12: ALTERNATING BIT PATTERNS ===");
        test_cla32_arithmetic(32'hAAAAAAAA, 32'hAAAAAAAA, 1'b0, "Alternating: 0xAAAAAAAA+0xAAAAAAAA");
        test_cla32_arithmetic(32'h55555555, 32'h55555555, 1'b0, "Alternating: 0x55555555+0x55555555");
        test_cla32_arithmetic(32'hAAAAAAAA, 32'h55555555, 1'b0, "Alternating: 0xAAAAAAAA+0x55555555");
        test_cla32_arithmetic(32'h55555555, 32'hAAAAAAAA, 1'b0, "Alternating: 0x55555555+0xAAAAAAAA");
        test_cla32_arithmetic(32'hCCCCCCCC, 32'hCCCCCCCC, 1'b0, "Alternating: 0xCCCCCCCC+0xCCCCCCCC");
        test_cla32_arithmetic(32'h33333333, 32'h33333333, 1'b0, "Alternating: 0x33333333+0x33333333");
        
        // Test 13: Sequential Numbers
        $display("\n=== TEST 13: SEQUENTIAL NUMBERS ===");
        test_cla32_arithmetic(32'h00000001, 32'h00000002, 1'b0, "Sequential: 1+2");
        test_cla32_arithmetic(32'h00000002, 32'h00000003, 1'b0, "Sequential: 2+3");
        test_cla32_arithmetic(32'h00000003, 32'h00000004, 1'b0, "Sequential: 3+4");
        test_cla32_arithmetic(32'h00000004, 32'h00000005, 1'b0, "Sequential: 4+5");
        test_cla32_arithmetic(32'h00000005, 32'h00000006, 1'b0, "Sequential: 5+6");
        test_cla32_arithmetic(32'h0000000A, 32'h0000000B, 1'b0, "Sequential: 10+11");
        test_cla32_arithmetic(32'h00000064, 32'h00000065, 1'b0, "Sequential: 100+101");
        test_cla32_arithmetic(32'h000003E8, 32'h000003E9, 1'b0, "Sequential: 1000+1001");
        
        // Test 14: Boundary Values
        $display("\n=== TEST 14: BOUNDARY VALUES ===");
        test_cla32_arithmetic(32'h00000000, 32'h00000001, 1'b0, "Boundary: 0+1");
        test_cla32_arithmetic(32'h00000001, 32'h00000000, 1'b0, "Boundary: 1+0");
        test_cla32_arithmetic(32'h7FFFFFFF, 32'h00000001, 1'b0, "Boundary: MAX+1");
        test_cla32_arithmetic(32'h80000000, 32'hFFFFFFFF, 1'b0, "Boundary: MIN+(-1)");
        test_cla32_arithmetic(32'h00000000, 32'hFFFFFFFF, 1'b0, "Boundary: 0+(-1)");
        test_cla32_arithmetic(32'hFFFFFFFF, 32'h00000001, 1'b0, "Boundary: (-1)+1");
        
        // Print results
        $display("\n=====================================");
        $display("COMPREHENSIVE TEST RESULTS SUMMARY:");
        $display("=====================================");
        $display("Total tests run: %12d", total_tests);
        $display("Sum errors: %12d", sum_errors);
        $display("Carry out errors: %12d", carry_errors);
        $display("Overflow errors: %12d", overflow_errors);
        $display("");
        
        if (sum_errors == 0 && carry_errors == 0 && overflow_errors == 0) begin
            $display("🎉 ALL TESTS PASSED! 🎉");
            $display("CLA32 is working correctly for all arithmetic operations!");
        end else begin
            $display("❌ SOME TESTS FAILED! ❌");
            $display("CLA32 has issues with arithmetic operations.");
            if (sum_errors > 0) $display("  - %d sum calculation errors", sum_errors);
            if (carry_errors > 0) $display("  - %d carry out errors", carry_errors);
            if (overflow_errors > 0) $display("  - %d overflow detection errors", overflow_errors);
        end
        $display("=====================================");
        
        $finish;
    end

endmodule
