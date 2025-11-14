`timescale 1ns / 1ps
`include "../source/cpu.svh"

module barrel_shifter_tb();

    // Test signals
    logic [31:0] data_in;
    logic [31:0] data_out;
    logic [31:0] expected;
    
    // Instantiate barrel shifter
    barrel_shifter dut (
        .data_in(data_in),
        .data_out(data_out)
    );
    
    // Task to test a shift operation
    task test_shift(input logic [31:0] input_data, input logic [31:0] expected_output, 
                    input string test_name);
        data_in = input_data;
        #1; // Small delay for combinational logic
        
        if (data_out !== expected_output) begin
            $error("Test '%s' failed: input=%h, expected=%h, got=%h", 
                   test_name, input_data, expected_output, data_out);
        end else begin
            $display("  ✓ %s: input=%h → output=%h", test_name, input_data, data_out);
        end
    endtask
    
    initial begin
        $display("========================================");
        $display("Barrel Shifter (Left Shift by 2) Testbench");
        $display("========================================\n");
        
        $display("=== Test 1: Basic shifts ===");
        // Shift 1 by 2 = 4
        test_shift(32'h00000001, 32'h00000004, "Shift 1 → 4");
        // Shift 2 by 2 = 8
        test_shift(32'h00000002, 32'h00000008, "Shift 2 → 8");
        // Shift 4 by 2 = 16
        test_shift(32'h00000004, 32'h00000010, "Shift 4 → 16");
        // Shift 8 by 2 = 32
        test_shift(32'h00000008, 32'h00000020, "Shift 8 → 32");
        
        $display("\n=== Test 2: Powers of 2 ===");
        test_shift(32'h00000001, 32'h00000004, "2^0 → 2^2");
        test_shift(32'h00000010, 32'h00000040, "2^4 → 2^6");
        test_shift(32'h00000100, 32'h00000400, "2^8 → 2^10");
        test_shift(32'h00001000, 32'h00004000, "2^12 → 2^14");
        test_shift(32'h00010000, 32'h00040000, "2^16 → 2^18");
        test_shift(32'h00100000, 32'h00400000, "2^20 → 2^22");
        test_shift(32'h01000000, 32'h04000000, "2^24 → 2^26");
        test_shift(32'h10000000, 32'h40000000, "2^28 → 2^30");
        
        $display("\n=== Test 3: Arbitrary values ===");
        test_shift(32'h0000000F, 32'h0000003C, "Shift 0xF → 0x3C");
        test_shift(32'h000000FF, 32'h000003FC, "Shift 0xFF → 0x3FC");
        test_shift(32'h00000FFF, 32'h00003FFC, "Shift 0xFFF → 0x3FFC");
        test_shift(32'h0000FFFF, 32'h0003FFFC, "Shift 0xFFFF → 0x3FFFC");
        
        $display("\n=== Test 4: Upper bits (testing overflow) ===");
        test_shift(32'hC0000000, 32'h00000000, "Shift 0xC0000000 → 0x0 (overflow)");
        test_shift(32'h80000000, 32'h00000000, "Shift 0x80000000 → 0x0 (overflow)");
        test_shift(32'hFFFFFFFF, 32'hFFFFFFFC, "Shift 0xFFFFFFFF → 0xFFFFFFFC");
        test_shift(32'hFFFFFFFE, 32'hFFFFFFF8, "Shift 0xFFFFFFFE → 0xFFFFFFF8");
        
        $display("\n=== Test 5: Lower 2 bits become zero ===");
        test_shift(32'h00000003, 32'h0000000C, "Shift 0x3 → 0xC (lower 2 bits cleared)");
        test_shift(32'h00000007, 32'h0000001C, "Shift 0x7 → 0x1C (lower 2 bits cleared)");
        test_shift(32'h0000000B, 32'h0000002C, "Shift 0xB → 0x2C (lower 2 bits cleared)");
        test_shift(32'h0000000D, 32'h00000034, "Shift 0xD → 0x34 (lower 2 bits cleared)");
        
        $display("\n=== Test 6: Edge cases ===");
        test_shift(32'h00000000, 32'h00000000, "Shift 0 → 0");
        test_shift(32'h00000001, 32'h00000004, "Shift 1 → 4");
        test_shift(32'h7FFFFFFF, 32'hFFFFFFFC, "Shift 0x7FFFFFFF → 0xFFFFFFFC (overflow)");
        test_shift(32'h40000000, 32'h00000000, "Shift 0x40000000 → 0x0 (overflow)");
        
        $display("\n=== Test 7: Verify multiply by 4 ===");
        test_shift(32'd1, 32'd4, "1 * 4 = 4");
        test_shift(32'd5, 32'd20, "5 * 4 = 20");
        test_shift(32'd10, 32'd40, "10 * 4 = 40");
        test_shift(32'd100, 32'd400, "100 * 4 = 400");
        test_shift(32'd1000, 32'd4000, "1000 * 4 = 4000");
        
        $display("\n========================================");
        $display("All barrel shifter tests completed!");
        $display("========================================");
        
        #10;
        $finish;
    end

endmodule

