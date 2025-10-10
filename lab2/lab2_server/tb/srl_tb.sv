`timescale 1ns/1ps

module srl_tb;
    // Test signals
    logic [31:0] x, y, z;
    
    // Instantiate the SRL module
    srl srl_inst (.x(x), .y(y), .z(z));
    
    // Test task
    task test_srl(input [31:0] test_x, input [31:0] test_y, input [31:0] expected_z);
        x = test_x;
        y = test_y;
        #10; // Wait for propagation
        
        $display("Testing SRL: x=0x%08h, y=0x%08h (shift=%d)", test_x, test_y, test_y[4:0]);
        $display("  Expected: 0x%08h", expected_z);
        $display("  Got:      0x%08h", z);
        
        if (z !== expected_z) begin
            $display("  ERROR: SRL test failed!");
        end else begin
            $display("  PASS: SRL test passed");
        end
        $display("");
    endtask
    
    initial begin
        $display("Starting SRL module testbench...");
        $display("=====================================");
        
        // Test basic shifts
        test_srl(32'h12345678, 32'h00000000, 32'h12345678); // No shift
        test_srl(32'h12345678, 32'h00000001, 32'h091A2B3C); // Shift by 1
        test_srl(32'h12345678, 32'h00000002, 32'h048D159E); // Shift by 2
        test_srl(32'h12345678, 32'h00000004, 32'h01234567); // Shift by 4
        test_srl(32'h12345678, 32'h00000008, 32'h00123456); // Shift by 8
        test_srl(32'h12345678, 32'h00000010, 32'h00001234); // Shift by 16
        test_srl(32'h12345678, 32'h00000020, 32'h12345678); // Shift by 32 (y[4:0]=0, so no shift)
        
        // Test with all 1s
        test_srl(32'hFFFFFFFF, 32'h00000001, 32'h7FFFFFFF); // Shift by 1
        test_srl(32'hFFFFFFFF, 32'h00000002, 32'h3FFFFFFF); // Shift by 2
        test_srl(32'hFFFFFFFF, 32'h00000004, 32'h0FFFFFFF); // Shift by 4
        test_srl(32'hFFFFFFFF, 32'h00000008, 32'h00FFFFFF); // Shift by 8
        test_srl(32'hFFFFFFFF, 32'h00000010, 32'h0000FFFF); // Shift by 16
        test_srl(32'hFFFFFFFF, 32'h00000020, 32'hFFFFFFFF); // Shift by 32 (y[4:0]=0, so no shift)
        
        // Test edge cases
        test_srl(32'h80000000, 32'h00000001, 32'h40000000); // MSB set, shift by 1
        test_srl(32'h00000001, 32'h00000001, 32'h00000000); // LSB set, shift by 1
        test_srl(32'h00000000, 32'h00000005, 32'h00000000); // Zero input
        
        // Test large shift amounts (should be 0)
        test_srl(32'h12345678, 32'h0000001F, 32'h00000000); // Shift by 31
        test_srl(32'h12345678, 32'h000000FF, 32'h00000000); // Shift by 255 (should use only 5 bits)
        
        $display("=====================================");
        $display("SRL module testbench completed");
        $finish;
    end

endmodule
