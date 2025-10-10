`timescale 1ns/1ps

module sll_tb;
    // Test signals
    logic [31:0] x, y, z;
    
    // Instantiate the SLL module
    sll sll_inst (.x(x), .y(y), .z(z));
    
    // Test task
    task test_sll(input [31:0] test_x, input [31:0] test_y, input [31:0] expected_z);
        x = test_x;
        y = test_y;
        #10; // Wait for propagation
        
        $display("Testing SLL: x=0x%08h, y=0x%08h (shift=%d)", test_x, test_y, test_y[4:0]);
        $display("  Expected: 0x%08h", expected_z);
        $display("  Got:      0x%08h", z);
        
        if (z !== expected_z) begin
            $display("  ERROR: SLL test failed!");
        end else begin
            $display("  PASS: SLL test passed");
        end
        $display("");
    endtask
    
    initial begin
        $display("Starting SLL module testbench...");
        $display("=====================================");
        $display("SLL performs logical left shift (fills with 0s on the right)");
        $display("=====================================");
        
        // Test basic shifts
        test_sll(32'h12345678, 32'h00000000, 32'h12345678); // No shift
        test_sll(32'h12345678, 32'h00000001, 32'h2468ACF0); // Shift by 1
        test_sll(32'h12345678, 32'h00000002, 32'h48D159E0); // Shift by 2
        test_sll(32'h12345678, 32'h00000004, 32'h23456780); // Shift by 4
        test_sll(32'h12345678, 32'h00000008, 32'h34567800); // Shift by 8
        test_sll(32'h12345678, 32'h00000010, 32'h56780000); // Shift by 16
        test_sll(32'h12345678, 32'h00000020, 32'h12345678); // Shift by 32 (y[4:0]=0, so no shift)
        
        // Test with all 1s
        test_sll(32'hFFFFFFFF, 32'h00000001, 32'hFFFFFFFE); // Shift by 1
        test_sll(32'hFFFFFFFF, 32'h00000002, 32'hFFFFFFFC); // Shift by 2
        test_sll(32'hFFFFFFFF, 32'h00000004, 32'hFFFFFFF0); // Shift by 4
        test_sll(32'hFFFFFFFF, 32'h00000008, 32'hFFFFFF00); // Shift by 8
        test_sll(32'hFFFFFFFF, 32'h00000010, 32'hFFFF0000); // Shift by 16
        test_sll(32'hFFFFFFFF, 32'h00000020, 32'hFFFFFFFF); // Shift by 32 (y[4:0]=0, so no shift)
        
        // Test edge cases
        test_sll(32'h80000000, 32'h00000001, 32'h00000000); // MSB set, shift by 1 (overflow)
        test_sll(32'h00000001, 32'h00000001, 32'h00000002); // LSB set, shift by 1
        test_sll(32'h00000000, 32'h00000005, 32'h00000000); // Zero input
        
        // Test maximum positive value
        test_sll(32'h7FFFFFFF, 32'h00000001, 32'hFFFFFFFE); // Max positive >> 1 (becomes negative)
        test_sll(32'h7FFFFFFF, 32'h00000002, 32'hFFFFFFFC); // Max positive >> 2
        
        // Test large shift amounts (should be 0)
        test_sll(32'h12345678, 32'h0000001F, 32'h00000000); // Shift by 31
        test_sll(32'h12345678, 32'h000000FF, 32'h00000000); // Shift by 255 (should use only 5 bits)
        
        // Test specific patterns
        test_sll(32'h00000001, 32'h0000001F, 32'h80000000); // 1 << 31 = 0x80000000
        test_sll(32'h00000001, 32'h0000001E, 32'h40000000); // 1 << 30 = 0x40000000
        test_sll(32'h00000001, 32'h0000001D, 32'h20000000); // 1 << 29 = 0x20000000
        
        // Test overflow cases
        test_sll(32'h80000000, 32'h00000001, 32'h00000000); // 0x80000000 << 1 = 0x00000000 (overflow)
        test_sll(32'h40000000, 32'h00000001, 32'h80000000); // 0x40000000 << 1 = 0x80000000
        test_sll(32'h20000000, 32'h00000001, 32'h40000000); // 0x20000000 << 1 = 0x40000000
        
        $display("=====================================");
        $display("SLL module testbench completed");
        $display("Key features of SLL:");
        $display("  - Shifts bits to the left (higher indices)");
        $display("  - Fills with 0s on the right (lower indices)");
        $display("  - Equivalent to multiplication by powers of 2");
        $display("  - Can cause overflow (bits shifted out of range)");
        $finish;
    end

endmodule
