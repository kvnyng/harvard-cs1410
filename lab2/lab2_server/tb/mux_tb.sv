/*
 * =============================================================================
 * MULTIPLEXER TESTBENCH DOCUMENTATION
 * =============================================================================
 * 
 * FILE: mux_tb.sv
 * PURPOSE: Comprehensive testbench for multiplexer modules (mux_2x1, mux_4x1, mux_8x1)
 * 
 * METHODOLOGY:
 * This testbench employs a brute force testing approach to achieve 100% coverage
 * of all possible input combinations for each multiplexer module. The methodology
 * is feasible due to the small size of the multiplexers being tested.
 * 
 * TESTING STRATEGY:
 * 1. BRUTE FORCE EXHAUSTIVE TESTING:
 *    - mux_2x1: Tests all 4 input combinations × 2 select values = 8 total tests
 *    - mux_4x1: Tests all 16 input combinations × 4 select values = 64 total tests  
 *    - mux_8x1: Tests all 256 input combinations × 8 select values = 2,048 total tests
 * 
 * 2. CORNER CASE TESTING:
 *    - All zeros pattern (0x00, 0x0000, 0x00000000)
 *    - All ones pattern (0xFF, 0xFFFF, 0xFFFFFFFF)
 *    - Alternating patterns (0xAA, 0x55, 0xAAAA, 0x5555, etc.)
 *    - Single bit patterns (testing each bit position individually)
 *    - Specific edge cases with known hex patterns
 * 
 * 3. VERIFICATION METHODOLOGY:
 *    - Each test compares the actual multiplexer output against expected results
 *    - Expected results are calculated using SystemVerilog's built-in operators
 *    - Detailed error reporting with binary and hex output for debugging
 *    - Error counting per module type for comprehensive failure analysis
 * 
 * 4. TIMING AND SIMULATION:
 *    - 10ns delays between test cases to allow for proper signal propagation
 *    - VCD file generation for waveform viewing and debugging
 *    - Comprehensive test summary with pass/fail statistics
 * 
 * MODULES TESTED:
 * - mux_2x1: 2-input, 1-output multiplexer with 1-bit select
 * - mux_4x1: 4-input, 1-output multiplexer with 2-bit select  
 * - mux_8x1: 8-input, 1-output multiplexer with 3-bit select
 * - mux_8x32: 8-input, 32-bit output multiplexer with 3-bit select
 * 
 * EXPECTED BEHAVIOR:
 * Each multiplexer should output the input signal selected by the select lines:
 * - mux_2x1: out = sel ? in[1] : in[0]
 * - mux_4x1: out = in[sel] where sel is 2-bit
 * - mux_8x1: out = in[sel] where sel is 3-bit
 * - mux_8x32: out = in[sel] where sel is 3-bit and in is 8x32-bit array
 * 
 * TOTAL TEST COVERAGE: >2,100 individual test cases
 * 
 * =============================================================================
 */

module mux_tb;

    // Test signals for mux_2x1
    logic [1:0] in_2x1;
    logic sel_2x1;
    wire out_2x1;
    
    // Test signals for mux_4x1
    logic [3:0] in_4x1;
    logic [1:0] sel_4x1;
    wire out_4x1;
    
    // Test signals for mux_8x1
    logic [7:0] in_8x1;
    logic [2:0] sel_8x1;
    wire out_8x1;
    
    // Test signals for mux_8x32
    logic [31:0] in_8x32 [7:0];
    logic [2:0] sel_8x32;
    wire [31:0] out_8x32;
    
    // Error counters
    int errors_2x1 = 0, errors_4x1 = 0, errors_8x1 = 0, errors_8x32 = 0;
    int total_tests = 0;
    
    // Instantiate modules
    mux_2x1 mux2x1_inst (
        .in(in_2x1),
        .sel(sel_2x1),
        .out(out_2x1)
    );
    
    mux_4x1 mux4x1_inst (
        .in(in_4x1),
        .sel(sel_4x1),
        .out(out_4x1)
    );
    
    mux_8x1 mux8x1_inst (
        .in(in_8x1),
        .sel(sel_8x1),
        .out(out_8x1)
    );
    
    mux_8x32 mux8x32_inst (
        .in(in_8x32),
        .sel(sel_8x32),
        .out(out_8x32)
    );
    
    // Test task for mux_2x1
    task test_mux_2x1(input [1:0] test_in, input test_sel);
        logic expected;
        expected = test_sel ? test_in[1] : test_in[0];
        #10; // Wait for propagation
        
        if (out_2x1 !== expected) begin
            $display("ERROR: mux_2x1 test failed at time %t", $time);
            $display("  Input = %b, Select = %b", test_in, test_sel);
            $display("  Expected = %b, Got = %b", expected, out_2x1);
            errors_2x1++;
        end
        total_tests++;
    endtask
    
    // Test task for mux_4x1
    task test_mux_4x1(input [3:0] test_in, input [1:0] test_sel);
        logic expected;
        expected = test_in[test_sel];
        #10; // Wait for propagation
        
        if (out_4x1 !== expected) begin
            $display("ERROR: mux_4x1 test failed at time %t", $time);
            $display("  Input = %b, Select = %b", test_in, test_sel);
            $display("  Expected = %b, Got = %b", expected, out_4x1);
            errors_4x1++;
        end
        total_tests++;
    endtask
    
    // Test task for mux_8x1
    task test_mux_8x1(input [7:0] test_in, input [2:0] test_sel);
        logic expected;
        expected = test_in[test_sel];
        #10; // Wait for propagation
        
        if (out_8x1 !== expected) begin
            $display("ERROR: mux_8x1 test failed at time %t", $time);
            $display("  Input = %b, Select = %b", test_in, test_sel);
            $display("  Expected = %b, Got = %b", expected, out_8x1);
            errors_8x1++;
        end
        total_tests++;
    endtask
    
    // Test task for mux_8x32
    task test_mux_8x32(input [31:0] test_in[7:0], input [2:0] test_sel);
        logic [31:0] expected;
        expected = test_in[test_sel];
        #10; // Wait for propagation
        
        if (out_8x32 !== expected) begin
            $display("ERROR: mux_8x32 test failed at time %t", $time);
            $display("  Select = %b", test_sel);
            $display("  Expected = 0x%08h (%032b)", expected, expected);
            $display("  Got      = 0x%08h (%032b)", out_8x32, out_8x32);
            $display("  Input array:");
            for (int i = 0; i < 8; i++) begin
                $display("    in[%d] = 0x%08h (%032b)", i, test_in[i], test_in[i]);
            end
            errors_8x32++;
        end
        total_tests++;
    endtask
    
    // Main test sequence
    initial begin
        $display("Starting multiplexer testbench...");
        $display("=====================================");
        
        // Test mux_2x1 - Brute force all 4 input combinations × 2 select values = 8 tests
        $display("\nTesting mux_2x1 module (8 total tests)...");
        
        for (int i = 0; i < 4; i++) begin
            for (int sel = 0; sel < 2; sel++) begin
                in_2x1 = i[1:0];
                sel_2x1 = sel;
                test_mux_2x1(i[1:0], sel);
            end
        end
        
        // Test mux_4x1 - Brute force all 16 input combinations × 4 select values = 64 tests
        $display("\nTesting mux_4x1 module (64 total tests)...");
        
        for (int i = 0; i < 16; i++) begin
            for (int sel = 0; sel < 4; sel++) begin
                in_4x1 = i[3:0];
                sel_4x1 = sel[1:0];
                test_mux_4x1(i[3:0], sel[1:0]);
            end
        end
        
        // Test mux_8x1 - Brute force all 256 input combinations × 8 select values = 2048 tests
        $display("\nTesting mux_8x1 module (2048 total tests)...");
        
        for (int i = 0; i < 256; i++) begin
            for (int sel = 0; sel < 8; sel++) begin
                in_8x1 = i[7:0];
                sel_8x1 = sel[2:0];
                test_mux_8x1(i[7:0], sel[2:0]);
            end
        end
        
        // Additional corner case tests
        $display("\nRunning additional corner case tests...");
        
        // Test specific patterns for mux_2x1
        $display("Testing mux_2x1 corner cases...");
        in_2x1 = 2'b00; sel_2x1 = 1'b0; test_mux_2x1(2'b00, 1'b0);
        in_2x1 = 2'b00; sel_2x1 = 1'b1; test_mux_2x1(2'b00, 1'b1);
        in_2x1 = 2'b11; sel_2x1 = 1'b0; test_mux_2x1(2'b11, 1'b0);
        in_2x1 = 2'b11; sel_2x1 = 1'b1; test_mux_2x1(2'b11, 1'b1);
        in_2x1 = 2'b01; sel_2x1 = 1'b0; test_mux_2x1(2'b01, 1'b0);
        in_2x1 = 2'b01; sel_2x1 = 1'b1; test_mux_2x1(2'b01, 1'b1);
        in_2x1 = 2'b10; sel_2x1 = 1'b0; test_mux_2x1(2'b10, 1'b0);
        in_2x1 = 2'b10; sel_2x1 = 1'b1; test_mux_2x1(2'b10, 1'b1);
        
        // Test specific patterns for mux_4x1
        $display("Testing mux_4x1 corner cases...");
        in_4x1 = 4'b0000; sel_4x1 = 2'b00; test_mux_4x1(4'b0000, 2'b00);
        in_4x1 = 4'b1111; sel_4x1 = 2'b11; test_mux_4x1(4'b1111, 2'b11);
        in_4x1 = 4'b1010; sel_4x1 = 2'b01; test_mux_4x1(4'b1010, 2'b01);
        in_4x1 = 4'b0101; sel_4x1 = 2'b10; test_mux_4x1(4'b0101, 2'b10);
        
        // Test specific patterns for mux_8x1
        $display("Testing mux_8x1 corner cases...");
        in_8x1 = 8'b00000000; sel_8x1 = 3'b000; test_mux_8x1(8'b00000000, 3'b000);
        in_8x1 = 8'b11111111; sel_8x1 = 3'b111; test_mux_8x1(8'b11111111, 3'b111);
        in_8x1 = 8'b10101010; sel_8x1 = 3'b101; test_mux_8x1(8'b10101010, 3'b101);
        in_8x1 = 8'b01010101; sel_8x1 = 3'b010; test_mux_8x1(8'b01010101, 3'b010);
        
        // Test alternating patterns
        $display("Testing alternating patterns...");
        in_8x1 = 8'b10101010; 
        for (int sel = 0; sel < 8; sel++) begin
            sel_8x1 = sel[2:0];
            test_mux_8x1(8'b10101010, sel[2:0]);
        end
        
        in_8x1 = 8'b01010101;
        for (int sel = 0; sel < 8; sel++) begin
            sel_8x1 = sel[2:0];
            test_mux_8x1(8'b01010101, sel[2:0]);
        end
        
        // Test single bit patterns
        $display("Testing single bit patterns...");
        for (int bit_pos = 0; bit_pos < 8; bit_pos++) begin
            automatic logic [7:0] single_bit = (1 << bit_pos);
            in_8x1 = single_bit;
            sel_8x1 = bit_pos[2:0];
            test_mux_8x1(single_bit, bit_pos[2:0]);
        end
        
        // Test mux_8x32 - Comprehensive testing of 8x32 multiplexer
        $display("\nTesting mux_8x32 module...");
        
        // Test 1: All zeros
        $display("Testing all zeros pattern...");
        for (int i = 0; i < 8; i++) begin
            in_8x32[i] = 32'h00000000;
        end
        for (int sel = 0; sel < 8; sel++) begin
            sel_8x32 = sel[2:0];
            test_mux_8x32(in_8x32, sel[2:0]);
        end
        
        // Test 2: All ones
        $display("Testing all ones pattern...");
        for (int i = 0; i < 8; i++) begin
            in_8x32[i] = 32'hFFFFFFFF;
        end
        for (int sel = 0; sel < 8; sel++) begin
            sel_8x32 = sel[2:0];
            test_mux_8x32(in_8x32, sel[2:0]);
        end
        
        // Test 3: Sequential values (0x00000001, 0x00000002, ..., 0x00000008)
        $display("Testing sequential values...");
        for (int i = 0; i < 8; i++) begin
            in_8x32[i] = 32'h00000001 << i;
        end
        for (int sel = 0; sel < 8; sel++) begin
            sel_8x32 = sel[2:0];
            test_mux_8x32(in_8x32, sel[2:0]);
        end
        
        // Test 4: Distinct hex patterns
        $display("Testing distinct hex patterns...");
        in_8x32[0] = 32'h12345678;
        in_8x32[1] = 32'h87654321;
        in_8x32[2] = 32'hDEADBEEF;
        in_8x32[3] = 32'hCAFEBABE;
        in_8x32[4] = 32'hAAAAAAAA;
        in_8x32[5] = 32'h55555555;
        in_8x32[6] = 32'hF0F0F0F0;
        in_8x32[7] = 32'h0F0F0F0F;
        for (int sel = 0; sel < 8; sel++) begin
            sel_8x32 = sel[2:0];
            test_mux_8x32(in_8x32, sel[2:0]);
        end
        
        // Test 5: Alternating patterns
        $display("Testing alternating patterns...");
        for (int i = 0; i < 8; i++) begin
            in_8x32[i] = (i % 2) ? 32'hAAAAAAAA : 32'h55555555;
        end
        for (int sel = 0; sel < 8; sel++) begin
            sel_8x32 = sel[2:0];
            test_mux_8x32(in_8x32, sel[2:0]);
        end
        
        // Test 6: Single bit patterns (each input has a different bit set)
        $display("Testing single bit patterns...");
        for (int i = 0; i < 8; i++) begin
            in_8x32[i] = 32'h00000001 << (i * 4); // Bits 0, 4, 8, 12, 16, 20, 24, 28
        end
        for (int sel = 0; sel < 8; sel++) begin
            sel_8x32 = sel[2:0];
            test_mux_8x32(in_8x32, sel[2:0]);
        end
        
        // Test 7: MSB patterns (each input has MSB at different position)
        $display("Testing MSB patterns...");
        for (int i = 0; i < 8; i++) begin
            in_8x32[i] = 32'h80000000 >> (i * 4); // MSB at positions 31, 27, 23, 19, 15, 11, 7, 3
        end
        for (int sel = 0; sel < 8; sel++) begin
            sel_8x32 = sel[2:0];
            test_mux_8x32(in_8x32, sel[2:0]);
        end
        
        // Test 8: Random patterns
        $display("Testing random patterns...");
        for (int test_case = 0; test_case < 10; test_case++) begin
            for (int i = 0; i < 8; i++) begin
                in_8x32[i] = $random;
            end
            for (int sel = 0; sel < 8; sel++) begin
                sel_8x32 = sel[2:0];
                test_mux_8x32(in_8x32, sel[2:0]);
            end
        end
        
        // Test 9: Edge case - Maximum and minimum values
        $display("Testing edge cases...");
        in_8x32[0] = 32'h00000000;  // Minimum
        in_8x32[1] = 32'h00000001;  // Small positive
        in_8x32[2] = 32'h7FFFFFFF;  // Maximum positive
        in_8x32[3] = 32'h80000000;  // Maximum negative
        in_8x32[4] = 32'hFFFFFFFF;  // Maximum unsigned
        in_8x32[5] = 32'h80000001;  // Small negative
        in_8x32[6] = 32'h7FFFFFFE;  // Near maximum positive
        in_8x32[7] = 32'h80000001;  // Near maximum negative
        for (int sel = 0; sel < 8; sel++) begin
            sel_8x32 = sel[2:0];
            test_mux_8x32(in_8x32, sel[2:0]);
        end
        
        // Test 10: Bit position testing (each input tests different bit positions)
        $display("Testing bit position coverage...");
        for (int bit_pos = 0; bit_pos < 32; bit_pos += 4) begin
            for (int i = 0; i < 8; i++) begin
                in_8x32[i] = 32'h00000001 << ((bit_pos + i) % 32);
            end
            for (int sel = 0; sel < 8; sel++) begin
                sel_8x32 = sel[2:0];
                test_mux_8x32(in_8x32, sel[2:0]);
            end
        end
        
        // Print final results
        $display("\n=====================================");
        $display("Test Results Summary:");
        $display("Total tests run: %d", total_tests);
        $display("mux_2x1 errors: %d", errors_2x1);
        $display("mux_4x1 errors: %d", errors_4x1);
        $display("mux_8x1 errors: %d", errors_8x1);
        $display("mux_8x32 errors: %d", errors_8x32);
        
        if (errors_2x1 == 0 && errors_4x1 == 0 && errors_8x1 == 0 && errors_8x32 == 0) begin
            $display("ALL TESTS PASSED! ✓");
        end else begin
            $display("SOME TESTS FAILED! ✗");
        end
        
        $display("=====================================");
        $finish;
    end
    
    // Generate VCD file for waveform viewing
    initial begin
        $dumpfile("mux_tb.vcd");
        $dumpvars(0, mux_tb);
    end

endmodule
