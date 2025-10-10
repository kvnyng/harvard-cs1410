`timescale 1ns/1ps

module sra_tb;
    // Test signals
    logic [31:0] x, y, z;
    
    // Instantiate the SRA module
    sra sra_inst (.x(x), .y(y), .z(z));
    
    // Test task
    task test_sra(input [31:0] test_x, input [31:0] test_y, input [31:0] expected_z);
        x = test_x;
        y = test_y;
        #10; // Wait for propagation
        
        $display("Testing SRA: x=0x%08h, y=0x%08h (shift=%d)", test_x, test_y, test_y[4:0]);
        $display("  Expected: 0x%08h", expected_z);
        $display("  Got:      0x%08h", z);
        
        if (z !== expected_z) begin
            $display("  ERROR: SRA test failed!");
        end else begin
            $display("  PASS: SRA test passed");
        end
        $display("");
    endtask
    
    initial begin
        $display("Starting SRA module testbench...");
        $display("=====================================");
        $display("SRA performs arithmetic right shift (preserves sign bit)");
        $display("=====================================");
        
        // Test basic shifts with positive numbers (should behave like SRL)
        $display("Testing positive numbers (should behave like SRL):");
        test_sra(32'h12345678, 32'h00000000, 32'h12345678); // No shift
        test_sra(32'h12345678, 32'h00000001, 32'h091A2B3C); // Shift by 1
        test_sra(32'h12345678, 32'h00000002, 32'h048D159E); // Shift by 2
        test_sra(32'h12345678, 32'h00000004, 32'h01234567); // Shift by 4
        test_sra(32'h12345678, 32'h00000008, 32'h00123456); // Shift by 8
        test_sra(32'h12345678, 32'h00000010, 32'h00001234); // Shift by 16
        test_sra(32'h12345678, 32'h00000020, 32'h12345678); // Shift by 32 (y[4:0]=0, so no shift)
        
        // Test with negative numbers (MSB = 1, should fill with 1s)
        $display("Testing negative numbers (should fill with 1s):");
        test_sra(32'h80000000, 32'h00000001, 32'hC0000000); // -2147483648 >> 1 = -1073741824
        test_sra(32'h80000000, 32'h00000002, 32'hE0000000); // -2147483648 >> 2 = -536870912
        test_sra(32'h80000000, 32'h00000004, 32'hF8000000); // -2147483648 >> 4 = -134217728
        test_sra(32'h80000000, 32'h00000008, 32'hFF800000); // -2147483648 >> 8 = -8388608
        test_sra(32'h80000000, 32'h00000010, 32'hFFFF8000); // -2147483648 >> 16 = -32768
        test_sra(32'h80000000, 32'h0000001F, 32'hFFFFFFFF); // -2147483648 >> 31 = -1
        
        // Test with other negative numbers
        test_sra(32'hFFFFFFFF, 32'h00000001, 32'hFFFFFFFF); // -1 >> 1 = -1 (all 1s)
        test_sra(32'hFFFFFFFE, 32'h00000001, 32'hFFFFFFFF); // -2 >> 1 = -1
        test_sra(32'hFFFFFF00, 32'h00000008, 32'hFFFFFFFF); // -256 >> 8 = -1
        
        // Test edge cases
        $display("Testing edge cases:");
        test_sra(32'h00000001, 32'h00000001, 32'h00000000); // 1 >> 1 = 0
        test_sra(32'h00000000, 32'h00000005, 32'h00000000); // 0 >> 5 = 0
        test_sra(32'h7FFFFFFF, 32'h00000001, 32'h3FFFFFFF); // 2147483647 >> 1 = 1073741823
        
        // Test large shift amounts
        test_sra(32'h12345678, 32'h0000001F, 32'h00000000); // Shift by 31 (positive number)
        test_sra(32'h80000000, 32'h0000001F, 32'hFFFFFFFF); // Shift by 31 (negative number)
        test_sra(32'h12345678, 32'h000000FF, 32'h00000000); // Shift by 31 (y[4:0]=31)
        test_sra(32'h80000000, 32'h000000FF, 32'hFFFFFFFF); // Shift by 31 (y[4:0]=31)
        
        $display("=====================================");
        $display("SRA module testbench completed");
        $display("Key differences from SRL:");
        $display("  - Positive numbers: Same as SRL (fill with 0s)");
        $display("  - Negative numbers: Fill with 1s (preserve sign)");
        $display("  - Sign bit (MSB) is replicated to fill vacated positions");
        $finish;
    end

endmodule
