`timescale 1ns / 1ps
`include "../source/cpu.svh"

module mux_tb();

    // Test signals for 2-bit 4-to-1 mux
    logic [1:0] sel;
    logic [1:0] in0, in1, in2, in3;
    logic [1:0] out;
    logic [1:0] expected;
    
    // Test signals for 1-bit 2-to-1 mux
    logic sel_1bit;
    logic in0_1bit, in1_1bit;
    logic out_1bit;
    
    // Instantiate 2-bit 4-to-1 mux
    mux dut (
        .sel(sel),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .out(out)
    );
    
    // Instantiate 1-bit 2-to-1 mux
    mux_1bit dut_1bit (
        .sel(sel_1bit),
        .in0(in0_1bit),
        .in1(in1_1bit),
        .out(out_1bit)
    );
    
    // Task to test a mux selection
    task test_mux(input logic [1:0] select, input logic [1:0] input0, 
                  input logic [1:0] input1, input logic [1:0] input2, 
                  input logic [1:0] input3, input logic [1:0] expected_out, 
                  input string test_name);
        sel = select;
        in0 = input0;
        in1 = input1;
        in2 = input2;
        in3 = input3;
        #1; // Small delay for combinational logic
        
        if (out !== expected_out) begin
            $error("Test '%s' failed: sel=%b, expected=%b, got=%b", 
                   test_name, select, expected_out, out);
        end else begin
            $display("  ✓ %s: sel=%b → out=%b", test_name, select, out);
        end
    endtask
    
    initial begin
        $display("========================================");
        $display("2-bit 4-to-1 Multiplexer Testbench");
        $display("========================================\n");
        
        $display("=== Test 1: Select 00 (in0) ===");
        test_mux(2'b00, 2'b00, 2'b01, 2'b10, 2'b11, 2'b00, "Select in0 (00)");
        test_mux(2'b00, 2'b01, 2'b10, 2'b11, 2'b00, 2'b01, "Select in0 (01)");
        test_mux(2'b00, 2'b10, 2'b11, 2'b00, 2'b01, 2'b10, "Select in0 (10)");
        test_mux(2'b00, 2'b11, 2'b00, 2'b01, 2'b10, 2'b11, "Select in0 (11)");
        
        $display("\n=== Test 2: Select 01 (in1) ===");
        test_mux(2'b01, 2'b00, 2'b00, 2'b10, 2'b11, 2'b00, "Select in1 (00)");
        test_mux(2'b01, 2'b10, 2'b01, 2'b11, 2'b00, 2'b01, "Select in1 (01)");
        test_mux(2'b01, 2'b11, 2'b10, 2'b00, 2'b01, 2'b10, "Select in1 (10)");
        test_mux(2'b01, 2'b01, 2'b11, 2'b10, 2'b00, 2'b11, "Select in1 (11)");
        
        $display("\n=== Test 3: Select 10 (in2) ===");
        test_mux(2'b10, 2'b00, 2'b01, 2'b00, 2'b11, 2'b00, "Select in2 (00)");
        test_mux(2'b10, 2'b01, 2'b10, 2'b01, 2'b00, 2'b01, "Select in2 (01)");
        test_mux(2'b10, 2'b10, 2'b11, 2'b10, 2'b01, 2'b10, "Select in2 (10)");
        test_mux(2'b10, 2'b11, 2'b00, 2'b11, 2'b10, 2'b11, "Select in2 (11)");
        
        $display("\n=== Test 4: Select 11 (in3) ===");
        test_mux(2'b11, 2'b00, 2'b01, 2'b10, 2'b00, 2'b00, "Select in3 (00)");
        test_mux(2'b11, 2'b01, 2'b10, 2'b11, 2'b01, 2'b01, "Select in3 (01)");
        test_mux(2'b11, 2'b10, 2'b11, 2'b00, 2'b10, 2'b10, "Select in3 (10)");
        test_mux(2'b11, 2'b11, 2'b00, 2'b01, 2'b11, 2'b11, "Select in3 (11)");
        
        $display("\n=== Test 5: All inputs different ===");
        test_mux(2'b00, 2'b00, 2'b01, 2'b10, 2'b11, 2'b00, "All different, sel=00");
        test_mux(2'b01, 2'b00, 2'b01, 2'b10, 2'b11, 2'b01, "All different, sel=01");
        test_mux(2'b10, 2'b00, 2'b01, 2'b10, 2'b11, 2'b10, "All different, sel=10");
        test_mux(2'b11, 2'b00, 2'b01, 2'b10, 2'b11, 2'b11, "All different, sel=11");
        
        $display("\n=== Test 6: All inputs same ===");
        test_mux(2'b00, 2'b01, 2'b01, 2'b01, 2'b01, 2'b01, "All same (01), sel=00");
        test_mux(2'b01, 2'b10, 2'b10, 2'b10, 2'b10, 2'b10, "All same (10), sel=01");
        test_mux(2'b10, 2'b11, 2'b11, 2'b11, 2'b11, 2'b11, "All same (11), sel=10");
        test_mux(2'b11, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, "All same (00), sel=11");
        
        $display("\n========================================");
        $display("1-bit 2-to-1 Multiplexer Tests");
        $display("========================================\n");
        
        $display("=== Test 7: Select 0 (in0) ===");
        sel_1bit = 1'b0;
        in0_1bit = 1'b0;
        in1_1bit = 1'b1;
        #1;
        if (out_1bit !== 1'b0) $error("1-bit mux: sel=0, in0=0, expected=0, got=%b", out_1bit);
        else $display("  ✓ Select in0 (0): sel=0 → out=0");
        
        sel_1bit = 1'b0;
        in0_1bit = 1'b1;
        in1_1bit = 1'b0;
        #1;
        if (out_1bit !== 1'b1) $error("1-bit mux: sel=0, in0=1, expected=1, got=%b", out_1bit);
        else $display("  ✓ Select in0 (1): sel=0 → out=1");
        
        $display("\n=== Test 8: Select 1 (in1) ===");
        sel_1bit = 1'b1;
        in0_1bit = 1'b0;
        in1_1bit = 1'b0;
        #1;
        if (out_1bit !== 1'b0) $error("1-bit mux: sel=1, in1=0, expected=0, got=%b", out_1bit);
        else $display("  ✓ Select in1 (0): sel=1 → out=0");
        
        sel_1bit = 1'b1;
        in0_1bit = 1'b0;
        in1_1bit = 1'b1;
        #1;
        if (out_1bit !== 1'b1) $error("1-bit mux: sel=1, in1=1, expected=1, got=%b", out_1bit);
        else $display("  ✓ Select in1 (1): sel=1 → out=1");
        
        $display("\n=== Test 9: All combinations ===");
        // Test all 4 combinations: sel=0/1, in0=0/1, in1=0/1
        sel_1bit = 1'b0; in0_1bit = 1'b0; in1_1bit = 1'b0; #1;
        if (out_1bit !== 1'b0) $error("1-bit mux failed: sel=0, in0=0, in1=0");
        else $display("  ✓ sel=0, in0=0, in1=0 → out=0");
        
        sel_1bit = 1'b0; in0_1bit = 1'b0; in1_1bit = 1'b1; #1;
        if (out_1bit !== 1'b0) $error("1-bit mux failed: sel=0, in0=0, in1=1");
        else $display("  ✓ sel=0, in0=0, in1=1 → out=0");
        
        sel_1bit = 1'b0; in0_1bit = 1'b1; in1_1bit = 1'b0; #1;
        if (out_1bit !== 1'b1) $error("1-bit mux failed: sel=0, in0=1, in1=0");
        else $display("  ✓ sel=0, in0=1, in1=0 → out=1");
        
        sel_1bit = 1'b0; in0_1bit = 1'b1; in1_1bit = 1'b1; #1;
        if (out_1bit !== 1'b1) $error("1-bit mux failed: sel=0, in0=1, in1=1");
        else $display("  ✓ sel=0, in0=1, in1=1 → out=1");
        
        sel_1bit = 1'b1; in0_1bit = 1'b0; in1_1bit = 1'b0; #1;
        if (out_1bit !== 1'b0) $error("1-bit mux failed: sel=1, in0=0, in1=0");
        else $display("  ✓ sel=1, in0=0, in1=0 → out=0");
        
        sel_1bit = 1'b1; in0_1bit = 1'b0; in1_1bit = 1'b1; #1;
        if (out_1bit !== 1'b1) $error("1-bit mux failed: sel=1, in0=0, in1=1");
        else $display("  ✓ sel=1, in0=0, in1=1 → out=1");
        
        sel_1bit = 1'b1; in0_1bit = 1'b1; in1_1bit = 1'b0; #1;
        if (out_1bit !== 1'b0) $error("1-bit mux failed: sel=1, in0=1, in1=0");
        else $display("  ✓ sel=1, in0=1, in1=0 → out=0");
        
        sel_1bit = 1'b1; in0_1bit = 1'b1; in1_1bit = 1'b1; #1;
        if (out_1bit !== 1'b1) $error("1-bit mux failed: sel=1, in0=1, in1=1");
        else $display("  ✓ sel=1, in0=1, in1=1 → out=1");
        
        $display("\n========================================");
        $display("All mux tests completed!");
        $display("========================================");
        
        #10;
        $finish;
    end
    
    // Monitor for debugging (commented out to reduce output)
    // initial begin
    //     $monitor("Time: %0t | 2-bit mux: sel=%b, out=%b | 1-bit mux: sel=%b, out=%b",
    //              $time, sel, out, sel_1bit, out_1bit);
    // end

endmodule

