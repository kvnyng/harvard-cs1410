/*
 * =============================================================================
 * FULL ADDER TESTBENCH
 * =============================================================================
 * 
 * FILE: full_adder_tb.sv
 * PURPOSE: Comprehensive testbench for full_adder module
 * 
 * METHODOLOGY:
 * This testbench uses brute force testing to verify all possible input
 * combinations for the full_adder module. Since it's a 1-bit adder with
 * 3 inputs (a, b, carry_in), there are 2^3 = 8 possible combinations.
 * 
 * TESTING STRATEGY:
 * 1. BRUTE FORCE EXHAUSTIVE TESTING:
 *    - Tests all 8 possible input combinations
 *    - Verifies sum and carry_out outputs against expected values
 * 
 * 2. VERIFICATION METHODOLOGY:
 *    - Expected sum = a XOR b XOR carry_in
 *    - Expected carry_out = (a AND b) OR ((a XOR b) AND carry_in)
 *    - Detailed error reporting with binary output
 * 
 * 3. TIMING AND SIMULATION:
 *    - 10ns delays between test cases for signal propagation
 *    - VCD file generation for waveform viewing
 * 
 * TOTAL TEST COVERAGE: 8 individual test cases (100% coverage)
 * =============================================================================
 */

module full_adder_tb;

    // Test signals
    logic a, b, carry_in;
    wire sum, carry_out;
    
    // Error counter
    int errors = 0;
    int total_tests = 0;
    
    // Instantiate full_adder module
    full_adder fa_inst (
        .a        (a),
        .b        (b),
        .carry_in (carry_in),
        .sum      (sum),
        .carry_out(carry_out)
    );
    
    // Test task for full_adder
    task test_full_adder(input test_a, input test_b, input test_carry_in);
        logic expected_sum, expected_carry_out;
        
        // Calculate expected values
        expected_sum = test_a ^ test_b ^ test_carry_in;
        expected_carry_out = (test_a & test_b) | ((test_a ^ test_b) & test_carry_in);
        
        #10; // Wait for propagation
        
        if (sum !== expected_sum || carry_out !== expected_carry_out) begin
            $display("ERROR: full_adder test failed at time %t", $time);
            $display("  Inputs: a=%b, b=%b, carry_in=%b", test_a, test_b, test_carry_in);
            $display("  Expected: sum=%b, carry_out=%b", expected_sum, expected_carry_out);
            $display("  Got:      sum=%b, carry_out=%b", sum, carry_out);
            errors++;
        end
        total_tests++;
    endtask
    
    // Main test sequence
    initial begin
        $display("Starting full_adder testbench...");
        $display("=====================================");
        
        // Test all 8 possible input combinations
        $display("\nTesting all input combinations...");
        
        // Test case 0: 0 + 0 + 0 = 0, carry = 0
        a = 1'b0; b = 1'b0; carry_in = 1'b0;
        test_full_adder(1'b0, 1'b0, 1'b0);
        
        // Test case 1: 0 + 0 + 1 = 1, carry = 0
        a = 1'b0; b = 1'b0; carry_in = 1'b1;
        test_full_adder(1'b0, 1'b0, 1'b1);
        
        // Test case 2: 0 + 1 + 0 = 1, carry = 0
        a = 1'b0; b = 1'b1; carry_in = 1'b0;
        test_full_adder(1'b0, 1'b1, 1'b0);
        
        // Test case 3: 0 + 1 + 1 = 0, carry = 1
        a = 1'b0; b = 1'b1; carry_in = 1'b1;
        test_full_adder(1'b0, 1'b1, 1'b1);
        
        // Test case 4: 1 + 0 + 0 = 1, carry = 0
        a = 1'b1; b = 1'b0; carry_in = 1'b0;
        test_full_adder(1'b1, 1'b0, 1'b0);
        
        // Test case 5: 1 + 0 + 1 = 0, carry = 1
        a = 1'b1; b = 1'b0; carry_in = 1'b1;
        test_full_adder(1'b1, 1'b0, 1'b1);
        
        // Test case 6: 1 + 1 + 0 = 0, carry = 1
        a = 1'b1; b = 1'b1; carry_in = 1'b0;
        test_full_adder(1'b1, 1'b1, 1'b0);
        
        // Test case 7: 1 + 1 + 1 = 1, carry = 1
        a = 1'b1; b = 1'b1; carry_in = 1'b1;
        test_full_adder(1'b1, 1'b1, 1'b1);
        
        // Print final results
        $display("\n=====================================");
        $display("Test Results Summary:");
        $display("Total tests run: %d", total_tests);
        $display("Errors: %d", errors);
        
        if (errors == 0) begin
            $display("ALL TESTS PASSED! ✓");
        end else begin
            $display("SOME TESTS FAILED! ✗");
        end
        
        $display("=====================================");
        $finish;
    end
    
    // Generate VCD file for waveform viewing
    initial begin
        $dumpfile("full_adder_tb.vcd");
        $dumpvars(0, full_adder_tb);
    end

endmodule
