// Test bench for each primitive
`include "primitives32.svh"

module primitives32_tb;

    // Test signals
    logic [31:0] x, y;
    logic [31:0] and_result, not_result, or_result;
    logic [31:0] expected_and, expected_not, expected_or;
    
    // Error counters
    int and_errors = 0, not_errors = 0, or_errors = 0;
    int total_tests = 0;
    
    // Instantiate modules
    and32 and_inst (
        .x(x),
        .y(y),
        .z(and_result)
    );
    
    not32 not_inst (
        .x(x),
        .z(not_result)
    );
    
    or32 or_inst (
        .x(x),
        .y(y),
        .z(or_result)
    );
    
    // Test task for AND operation
    task test_and(input logic [31:0] test_x, input logic [31:0] test_y);
        x = test_x;
        y = test_y;
        expected_and = test_x & test_y;
        #10; // Wait for propagation
        
        if (and_result !== expected_and) begin
            $display("ERROR: AND test failed at time %t", $time);
            $display("  Input x = 0x%08h (%032b)", test_x, test_x);
            $display("  Input y = 0x%08h (%032b)", test_y, test_y);
            $display("  Expected = 0x%08h (%032b)", expected_and, expected_and);
            $display("  Got      = 0x%08h (%032b)", and_result, and_result);
            and_errors++;
        end
        total_tests++;
    endtask
    
    // Test task for NOT operation
    task test_not(input logic [31:0] test_x);
        x = test_x;
        expected_not = ~test_x;
        #10; // Wait for propagation
        
        if (not_result !== expected_not) begin
            $display("ERROR: NOT test failed at time %t", $time);
            $display("  Input x = 0x%08h (%032b)", test_x, test_x);
            $display("  Expected = 0x%08h (%032b)", expected_not, expected_not);
            $display("  Got      = 0x%08h (%032b)", not_result, not_result);
            not_errors++;
        end
        total_tests++;
    endtask
    
    // Test task for OR operation
    task test_or(input logic [31:0] test_x, input logic [31:0] test_y);
        x = test_x;
        y = test_y;
        expected_or = test_x | test_y;
        #10; // Wait for propagation
        
        if (or_result !== expected_or) begin
            $display("ERROR: OR test failed at time %t", $time);
            $display("  Input x = 0x%08h (%032b)", test_x, test_x);
            $display("  Input y = 0x%08h (%032b)", test_y, test_y);
            $display("  Expected = 0x%08h (%032b)", expected_or, expected_or);
            $display("  Got      = 0x%08h (%032b)", or_result, or_result);
            or_errors++;
        end
        total_tests++;
    endtask
    
    // Main test sequence
    initial begin
        $display("Starting primitives32 testbench...");
        $display("=====================================");
        
        // Test AND operation corner cases
        $display("\nTesting AND32 module...");
        
        // All zeros
        test_and(32'h00000000, 32'h00000000);
        
        // All ones
        test_and(32'hFFFFFFFF, 32'hFFFFFFFF);
        
        // Mixed patterns
        test_and(32'h00000000, 32'hFFFFFFFF);
        test_and(32'hFFFFFFFF, 32'h00000000);
        
        // Alternating patterns
        test_and(32'hAAAAAAAA, 32'h55555555);
        test_and(32'h55555555, 32'hAAAAAAAA);
        
        // Single bit patterns
        test_and(32'h00000001, 32'h00000001);
        test_and(32'h80000000, 32'h80000000);
        test_and(32'h00000001, 32'h80000000);
        
        // Edge cases with specific bit patterns
        test_and(32'h12345678, 32'h87654321);
        test_and(32'hDEADBEEF, 32'hCAFEBABE);
        
        // Test NOT operation corner cases
        $display("\nTesting NOT32 module...");
        
        // All zeros
        test_not(32'h00000000);
        
        // All ones
        test_not(32'hFFFFFFFF);
        
        // Alternating patterns
        test_not(32'hAAAAAAAA);
        test_not(32'h55555555);
        
        // Single bit patterns
        test_not(32'h00000001);
        test_not(32'h80000000);
        test_not(32'h00000002);
        test_not(32'h40000000);
        
        // Edge cases with specific bit patterns
        test_not(32'h12345678);
        test_not(32'hDEADBEEF);
        test_not(32'hCAFEBABE);
        
        // Test OR operation corner cases
        $display("\nTesting OR32 module...");
        
        // All zeros
        test_or(32'h00000000, 32'h00000000);
        
        // All ones
        test_or(32'hFFFFFFFF, 32'hFFFFFFFF);
        
        // Mixed patterns
        test_or(32'h00000000, 32'hFFFFFFFF);
        test_or(32'hFFFFFFFF, 32'h00000000);
        
        // Alternating patterns
        test_or(32'hAAAAAAAA, 32'h55555555);
        test_or(32'h55555555, 32'hAAAAAAAA);
        
        // Single bit patterns
        test_or(32'h00000001, 32'h00000001);
        test_or(32'h80000000, 32'h80000000);
        test_or(32'h00000001, 32'h80000000);
        
        // Edge cases with specific bit patterns
        test_or(32'h12345678, 32'h87654321);
        test_or(32'hDEADBEEF, 32'hCAFEBABE);
        
        // Additional comprehensive tests
        $display("\nRunning additional comprehensive tests...");
        
        // Test all bit positions individually for AND
        for (int i = 0; i < 32; i++) begin
            logic [31:0] mask = (1 << i);
            test_and(mask, mask);
            test_and(mask, ~mask);
        end
        
        // Test all bit positions individually for NOT
        for (int i = 0; i < 32; i++) begin
            logic [31:0] mask = (1 << i);
            test_not(mask);
            test_not(~mask);
        end
        
        // Test all bit positions individually for OR
        for (int i = 0; i < 32; i++) begin
            logic [31:0] mask = (1 << i);
            test_or(mask, mask);
            test_or(mask, ~mask);
        end
        
        // Random pattern tests
        $display("\nRunning random pattern tests...");
        for (int i = 0; i < 100; i++) begin
            logic [31:0] rand_x = $random;
            logic [31:0] rand_y = $random;
            
            test_and(rand_x, rand_y);
            test_not(rand_x);
            test_or(rand_x, rand_y);
        end
        
        // Print final results
        $display("\n=====================================");
        $display("Test Results Summary:");
        $display("Total tests run: %d", total_tests);
        $display("AND32 errors: %d", and_errors);
        $display("NOT32 errors: %d", not_errors);
        $display("OR32 errors: %d", or_errors);
        
        if (and_errors == 0 && not_errors == 0 && or_errors == 0) begin
            $display("ALL TESTS PASSED! ✓");
        end else begin
            $display("SOME TESTS FAILED! ✗");
        end
        
        $display("=====================================");
        $finish;
    end
    
    // Generate VCD file for waveform viewing
    initial begin
        $dumpfile("primitives32_tb.vcd");
        $dumpvars(0, primitives32_tb);
    end

endmodule
