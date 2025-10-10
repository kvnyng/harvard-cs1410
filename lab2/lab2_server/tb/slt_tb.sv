`timescale 1ns/1ps

module slt_tb;
    // Test signals
    logic msb, overflow;
    logic [31:0] result;
    
    // Instantiate the SLT module
    slt_32bit slt_inst (.msb(msb), .overflow(overflow), .result(result));
    
    // Test task
    task test_slt(input logic test_msb, input logic test_overflow, input logic expected_lsb);
        msb = test_msb;
        overflow = test_overflow;
        #10; // Wait for propagation
        
        if (result[0] !== expected_lsb) begin
            $display("ERROR: SLT test failed at time %t", $time);
            $display("  MSB = %b, Overflow = %b", test_msb, test_overflow);
            $display("  Expected LSB = %b, Got = %b", expected_lsb, result[0]);
            $display("  Full result = 0x%08h", result);
        end else begin
            $display("PASS: SLT test at time %t", $time);
            $display("  MSB = %b, Overflow = %b, LSB = %b", test_msb, test_overflow, result[0]);
        end
    endtask
    
    initial begin
        $display("Starting SLT module testbench...");
        $display("=====================================");
        
        // Test cases for SLT logic: SLT = MSB XOR overflow
        
        // Case 1: No overflow, positive result (MSB=0) -> SLT=0
        $display("Testing: No overflow, positive result");
        test_slt(1'b0, 1'b0, 1'b0); // MSB=0, overflow=0 -> SLT=0
        
        // Case 2: No overflow, negative result (MSB=1) -> SLT=1  
        $display("Testing: No overflow, negative result");
        test_slt(1'b1, 1'b0, 1'b1); // MSB=1, overflow=0 -> SLT=1
        
        // Case 3: Overflow, positive result (MSB=0) -> SLT=1
        $display("Testing: Overflow, positive result");
        test_slt(1'b0, 1'b1, 1'b1); // MSB=0, overflow=1 -> SLT=1
        
        // Case 4: Overflow, negative result (MSB=1) -> SLT=0
        $display("Testing: Overflow, negative result");
        test_slt(1'b1, 1'b1, 1'b0); // MSB=1, overflow=1 -> SLT=0
        
        // Test that all other bits are 0
        $display("Testing: All other bits should be 0");
        if (result[31:1] !== 31'b0) begin
            $display("ERROR: Upper bits are not zero! Got = 0x%08h", result);
        end else begin
            $display("PASS: Upper bits are correctly zero");
        end
        
        $display("=====================================");
        $display("SLT module testbench completed");
        $finish;
    end

endmodule
