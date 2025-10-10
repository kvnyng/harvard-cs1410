/*
 * =============================================================================
 * ALU TESTBENCH - IMPLEMENTED OPERATIONS ONLY
 * =============================================================================
 * 
 * FILE: alu_tb.sv
 * PURPOSE: Comprehensive testbench for implemented ALU operations
 * 
 * IMPLEMENTED OPERATIONS TESTED:
 * 1. AND (ALU_AND - 3'b000): 32-bit bitwise AND between x and y
 * 2. ADD (ALU_ADD - 3'b001): 32-bit signed addition using RCA
 * 3. SUB (ALU_SUB - 3'b010): 32-bit signed subtraction using two's complement
 * 4. SLT (ALU_SLT - 3'b011): Set Less Than using MSB XOR overflow logic
 * 5. SRL (ALU_SRL - 3'b100): Shift Right Logical (zero-fill)
 * 6. SRA (ALU_SRA - 3'b101): Shift Right Arithmetic (sign-fill)
 * 7. SLL (ALU_SLL - 3'b110): Shift Left Logical (zero-fill)
 * 
 * TESTING STRATEGY:
 * 1. CORNER CASE TESTING:
 *    - Zero values, maximum values, minimum values
 *    - Edge cases for signed arithmetic
 * 
 * 2. OVERFLOW TESTING:
 *    - Positive overflow (0x7FFFFFFF + 1)
 *    - Negative overflow (0x80000000 + 0x80000000)
 *    - No overflow cases
 * 
 * 3. FLAG TESTING:
 *    - Zero flag for all operations
 *    - Equal flag for all operations
 *    - Overflow flag for ADD and SUB only
 * 
 * 4. ARITHMETIC VERIFICATION:
 *    - Known addition results
 *    - Known subtraction results
 *    - Bitwise AND verification
 * 
 * TOTAL TEST COVERAGE: 100+ individual test cases
 * =============================================================================
 */

`timescale 1ns/1ps

module alu_tb;

    // Test signals
    logic [31:0] x, y;
	logic [2:0] op;
    wire [31:0] z;
    wire zero, equal, overflow;
    
    // Error counters
    int and_errors = 0, add_errors = 0, sub_errors = 0, slt_errors = 0;
    int srl_errors = 0, sra_errors = 0, sll_errors = 0;
    int flag_errors = 0;
    int total_tests = 0;
    
    // Instantiate ALU module
    STUDENT_alu alu_inst (
        .x(x),
        .y(y),
        .op(op),
        .z(z),
        .zero(zero),
        .equal(equal),
        .overflow(overflow)
    );
    
    // Test task for AND operation
    task test_and(input [31:0] test_x, input [31:0] test_y);
        logic [31:0] expected_z;
        logic expected_zero, expected_equal;
        
        expected_z = test_x & test_y;
        expected_zero = (expected_z == 32'h00000000);
        expected_equal = (test_x == test_y);

       // What is happening below? Is the equal assig

       assign x = test_x;
       assign y = test_y;
       assign op = `ALU_AND;
       #10; // Wait for propagation

    //    assign x = test_x;
    //     x = test_x;
    //     y = test_y;
    //     op = `ALU_AND;
    //     #10; // Wait for propagation
        
        if (z !== expected_z) begin
            $display("ERROR: AND operation failed at time %t", $time);
            $display("  Operation: AND (3'b000)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d", test_y, test_y, $signed(test_y));
            $display("  Expected z = 0x%08h (%032b) = %d", expected_z, expected_z, $signed(expected_z));
            $display("  Got      z = 0x%08h (%032b) = %d", z, z, $signed(z));
            and_errors++;
        end
        
        if (zero !== expected_zero) begin
            $display("ERROR: AND zero flag failed at time %t", $time);
            $display("  Operation: AND (3'b000)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d", test_y, test_y, $signed(test_y));
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected zero = %b, Got = %b", expected_zero, zero);
            flag_errors++;
        end
        
        if (equal !== expected_equal) begin
            $display("ERROR: AND equal flag failed at time %t", $time);
            $display("  Operation: AND (3'b000)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d", test_y, test_y, $signed(test_y));
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected equal = %b, Got = %b", expected_equal, equal);
            flag_errors++;
        end
        
        if (overflow !== 1'b0) begin
            $display("ERROR: AND overflow flag should be 0 at time %t", $time);
            $display("  Got overflow = %b", overflow);
            flag_errors++;
        end
        
        total_tests++;
    endtask
    
    // Test task for ADD operation
    task test_add(input [31:0] test_x, input [31:0] test_y);
        logic [31:0] expected_z;
        logic expected_zero, expected_equal, expected_overflow;
        logic [32:0] full_result;
        
        // Calculate expected values
        full_result = {1'b0, test_x} + {1'b0, test_y};
        expected_z = full_result[31:0];
        expected_zero = (expected_z == 32'h00000000);
        expected_equal = (test_x == test_y);
        
        // Overflow for signed addition: (x[31] == y[31]) && (z[31] != x[31])
        expected_overflow = (test_x[31] == test_y[31]) && (expected_z[31] != test_x[31]);
        
        assign x = test_x;
        assign y = test_y;
        assign op = `ALU_ADD;
        #10; // Wait for propagation

        if (z !== expected_z) begin
            $display("ERROR: ADD operation failed at time %t", $time);
            $display("  Operation: ADD (3'b001)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d", test_y, test_y, $signed(test_y));
            $display("  Expected z = 0x%08h (%032b) = %d", expected_z, expected_z, $signed(expected_z));
            $display("  Got      z = 0x%08h (%032b) = %d", z, z, $signed(z));
            add_errors++;
        end
        
        if (zero !== expected_zero) begin
            $display("ERROR: ADD zero flag failed at time %t", $time);
            $display("  Operation: ADD (3'b001)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d", test_y, test_y, $signed(test_y));
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected zero = %b, Got = %b", expected_zero, zero);
            flag_errors++;
        end
        
        if (equal !== expected_equal) begin
            $display("ERROR: ADD equal flag failed at time %t", $time);
            $display("  Operation: ADD (3'b001)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d", test_y, test_y, $signed(test_y));
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected equal = %b, Got = %b", expected_equal, equal);
            flag_errors++;
        end
        
        if (overflow !== expected_overflow) begin
            $display("ERROR: ADD overflow flag failed at time %t", $time);
            $display("  Operation: ADD (3'b001)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d", test_y, test_y, $signed(test_y));
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected overflow = %b, Got = %b", expected_overflow, overflow);
            flag_errors++;
        end
        
        total_tests++;
    endtask
    
    // Test task for SUB operation
    task test_sub(input [31:0] test_x, input [31:0] test_y);
        logic [31:0] expected_z;
        logic expected_zero, expected_equal, expected_overflow;
        logic [32:0] full_result;
        
        // Calculate expected values (x - y)
        full_result = {1'b0, test_x} - {1'b0, test_y};
        expected_z = full_result[31:0];
        expected_zero = (expected_z == 32'h00000000);
        expected_equal = (test_x == test_y);
        
        // Overflow for signed subtraction: (x[31] != y[31]) && (z[31] != x[31])
        expected_overflow = (test_x[31] != test_y[31]) && (expected_z[31] != test_x[31]);
        
        assign x = test_x;
        assign y = test_y;
        assign op = `ALU_SUB;
        #10; // Wait for propagation
        
        if (z !== expected_z) begin
            $display("ERROR: SUB operation failed at time %t", $time);
            $display("  Operation: SUB (3'b010)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d", test_y, test_y, $signed(test_y));
            $display("  Expected z = 0x%08h (%032b) = %d", expected_z, expected_z, $signed(expected_z));
            $display("  Got      z = 0x%08h (%032b) = %d", z, z, $signed(z));
            sub_errors++;
        end
        
        if (zero !== expected_zero) begin
            $display("ERROR: SUB zero flag failed at time %t", $time);
            $display("  Operation: SUB (3'b010)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d", test_y, test_y, $signed(test_y));
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected zero = %b, Got = %b", expected_zero, zero);
            flag_errors++;
        end
        
        if (equal !== expected_equal) begin
            $display("ERROR: SUB equal flag failed at time %t", $time);
            $display("  Operation: SUB (3'b010)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d", test_y, test_y, $signed(test_y));
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected equal = %b, Got = %b", expected_equal, equal);
            flag_errors++;
        end
        
        if (overflow !== expected_overflow) begin
            $display("ERROR: SUB overflow flag failed at time %t", $time);
            $display("  Operation: SUB (3'b010)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d", test_y, test_y, $signed(test_y));
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected overflow = %b, Got = %b", expected_overflow, overflow);
            flag_errors++;
        end
        
        total_tests++;
    endtask
    
    // Test task for SLT operation
    task test_slt(input [31:0] test_x, input [31:0] test_y);
        logic [31:0] expected_z;
        logic expected_zero, expected_equal, expected_overflow;
        
        // Calculate expected SLT result: if x < y (signed), then SLT = 1, else SLT = 0
        expected_z = ($signed(test_x) < $signed(test_y)) ? 32'd1 : 32'd0;
        expected_zero = (expected_z == 32'd0) ? 1'b1 : 1'b0;
        expected_equal = (test_x == test_y) ? 1'b1 : 1'b0;
        expected_overflow = 1'b0; // SLT doesn't set overflow flag
        
        assign x = test_x;
        assign y = test_y;
        assign op = `ALU_SLT;
        #10; // Wait for propagation
        
        if (z !== expected_z) begin
            $display("ERROR: SLT operation failed at time %t", $time);
            $display("  Operation: SLT (3'b011)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d", test_y, test_y, $signed(test_y));
            $display("  Expected z = 0x%08h (%032b) = %d", expected_z, expected_z, $signed(expected_z));
            $display("  Got      z = 0x%08h (%032b) = %d", z, z, $signed(z));
            slt_errors++;
        end
        
        if (zero !== expected_zero) begin
            $display("ERROR: SLT zero flag failed at time %t", $time);
            $display("  Operation: SLT (3'b011)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d", test_y, test_y, $signed(test_y));
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected zero = %b, Got = %b", expected_zero, zero);
            flag_errors++;
        end
        
        if (equal !== expected_equal) begin
            $display("ERROR: SLT equal flag failed at time %t", $time);
            $display("  Operation: SLT (3'b011)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d", test_y, test_y, $signed(test_y));
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected equal = %b, Got = %b", expected_equal, equal);
            flag_errors++;
        end
        
        if (overflow !== expected_overflow) begin
            $display("ERROR: SLT overflow flag failed at time %t", $time);
            $display("  Operation: SLT (3'b011)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d", test_y, test_y, $signed(test_y));
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected overflow = %b, Got = %b", expected_overflow, overflow);
            flag_errors++;
        end
        
        total_tests++;
    endtask
    
    // Test task for SRL operation
    task test_srl(input [31:0] test_x, input [31:0] test_y);
        logic [31:0] expected_z;
        logic expected_zero, expected_equal, expected_overflow;
        logic [4:0] shift_amount;
        
        shift_amount = test_y[4:0]; // Only use lower 5 bits for shift amount
        expected_z = test_x >> shift_amount; // Logical right shift
        expected_zero = (expected_z == 32'h00000000);
        expected_equal = (test_x == test_y);
        expected_overflow = 1'b0; // SRL doesn't set overflow flag
        
        assign x = test_x;
        assign y = test_y;
        assign op = `ALU_SRL;
        #10; // Wait for propagation
        
        if (z !== expected_z) begin
            $display("ERROR: SRL operation failed at time %t", $time);
            $display("  Operation: SRL (3'b100)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d (shift=%d)", test_y, test_y, $signed(test_y), shift_amount);
            $display("  Expected z = 0x%08h (%032b) = %d", expected_z, expected_z, $signed(expected_z));
            $display("  Got      z = 0x%08h (%032b) = %d", z, z, $signed(z));
            srl_errors++;
        end
        
        if (zero !== expected_zero) begin
            $display("ERROR: SRL zero flag failed at time %t", $time);
            $display("  Operation: SRL (3'b100)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d (shift=%d)", test_y, test_y, $signed(test_y), shift_amount);
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected zero = %b, Got = %b", expected_zero, zero);
            flag_errors++;
        end
        
        if (equal !== expected_equal) begin
            $display("ERROR: SRL equal flag failed at time %t", $time);
            $display("  Operation: SRL (3'b100)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d (shift=%d)", test_y, test_y, $signed(test_y), shift_amount);
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected equal = %b, Got = %b", expected_equal, equal);
            flag_errors++;
        end
        
        if (overflow !== expected_overflow) begin
            $display("ERROR: SRL overflow flag failed at time %t", $time);
            $display("  Operation: SRL (3'b100)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d (shift=%d)", test_y, test_y, $signed(test_y), shift_amount);
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected overflow = %b, Got = %b", expected_overflow, overflow);
            flag_errors++;
        end
        
        total_tests++;
    endtask
    
    // Test task for SRA operation
    task test_sra(input [31:0] test_x, input [31:0] test_y);
        logic [31:0] expected_z;
        logic expected_zero, expected_equal, expected_overflow;
        logic [4:0] shift_amount;
        
        shift_amount = test_y[4:0]; // Only use lower 5 bits for shift amount
        expected_z = $signed(test_x) >>> shift_amount; // Arithmetic right shift
        expected_zero = (expected_z == 32'h00000000);
        expected_equal = (test_x == test_y);
        expected_overflow = 1'b0; // SRA doesn't set overflow flag
        
        assign x = test_x;
        assign y = test_y;
        assign op = `ALU_SRA;
        #10; // Wait for propagation
        
        if (z !== expected_z) begin
            $display("ERROR: SRA operation failed at time %t", $time);
            $display("  Operation: SRA (3'b101)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d (shift=%d)", test_y, test_y, $signed(test_y), shift_amount);
            $display("  Expected z = 0x%08h (%032b) = %d", expected_z, expected_z, $signed(expected_z));
            $display("  Got      z = 0x%08h (%032b) = %d", z, z, $signed(z));
            sra_errors++;
        end
        
        if (zero !== expected_zero) begin
            $display("ERROR: SRA zero flag failed at time %t", $time);
            $display("  Operation: SRA (3'b101)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d (shift=%d)", test_y, test_y, $signed(test_y), shift_amount);
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected zero = %b, Got = %b", expected_zero, zero);
            flag_errors++;
        end
        
        if (equal !== expected_equal) begin
            $display("ERROR: SRA equal flag failed at time %t", $time);
            $display("  Operation: SRA (3'b101)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d (shift=%d)", test_y, test_y, $signed(test_y), shift_amount);
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected equal = %b, Got = %b", expected_equal, equal);
            flag_errors++;
        end
        
        if (overflow !== expected_overflow) begin
            $display("ERROR: SRA overflow flag failed at time %t", $time);
            $display("  Operation: SRA (3'b101)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d (shift=%d)", test_y, test_y, $signed(test_y), shift_amount);
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected overflow = %b, Got = %b", expected_overflow, overflow);
            flag_errors++;
        end
        
        total_tests++;
    endtask
    
    // Test task for SLL operation
    task test_sll(input [31:0] test_x, input [31:0] test_y);
        logic [31:0] expected_z;
        logic expected_zero, expected_equal, expected_overflow;
        logic [4:0] shift_amount;
        
        shift_amount = test_y[4:0]; // Only use lower 5 bits for shift amount
        expected_z = test_x << shift_amount; // Logical left shift
        expected_zero = (expected_z == 32'h00000000);
        expected_equal = (test_x == test_y);
        expected_overflow = 1'b0; // SLL doesn't set overflow flag
        
        assign x = test_x;
        assign y = test_y;
        assign op = `ALU_SLL;
        #10; // Wait for propagation
        
        if (z !== expected_z) begin
            $display("ERROR: SLL operation failed at time %t", $time);
            $display("  Operation: SLL (3'b110)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d (shift=%d)", test_y, test_y, $signed(test_y), shift_amount);
            $display("  Expected z = 0x%08h (%032b) = %d", expected_z, expected_z, $signed(expected_z));
            $display("  Got      z = 0x%08h (%032b) = %d", z, z, $signed(z));
            sll_errors++;
        end
        
        if (zero !== expected_zero) begin
            $display("ERROR: SLL zero flag failed at time %t", $time);
            $display("  Operation: SLL (3'b110)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d (shift=%d)", test_y, test_y, $signed(test_y), shift_amount);
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected zero = %b, Got = %b", expected_zero, zero);
            flag_errors++;
        end
        
        if (equal !== expected_equal) begin
            $display("ERROR: SLL equal flag failed at time %t", $time);
            $display("  Operation: SLL (3'b110)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d (shift=%d)", test_y, test_y, $signed(test_y), shift_amount);
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected equal = %b, Got = %b", expected_equal, equal);
            flag_errors++;
        end
        
        if (overflow !== expected_overflow) begin
            $display("ERROR: SLL overflow flag failed at time %t", $time);
            $display("  Operation: SLL (3'b110)");
            $display("  Input x = 0x%08h (%032b) = %d", test_x, test_x, $signed(test_x));
            $display("  Input y = 0x%08h (%032b) = %d (shift=%d)", test_y, test_y, $signed(test_y), shift_amount);
            $display("  Result z = 0x%08h (%032b) = %d", z, z, $signed(z));
            $display("  Expected overflow = %b, Got = %b", expected_overflow, overflow);
            flag_errors++;
        end
        
        total_tests++;
    endtask
    
    // Main test sequence
    initial begin
        $display("Starting ALU testbench for implemented operations...");
        $display("=====================================");
        
        // Test AND operation
        $display("\nTesting AND operation...");
        
        // Basic AND tests
        test_and(32'h00000000, 32'h00000000);
        test_and(32'hFFFFFFFF, 32'hFFFFFFFF);
        test_and(32'h00000000, 32'hFFFFFFFF);
        test_and(32'hFFFFFFFF, 32'h00000000);
        test_and(32'hAAAAAAAA, 32'h55555555);
        test_and(32'h12345678, 32'h87654321);
        test_and(32'hDEADBEEF, 32'hCAFEBABE);
        
        // Test ADD operation
        $display("\nTesting ADD operation...");
        
        // Basic addition tests
        test_add(32'h00000000, 32'h00000000);
        test_add(32'h00000001, 32'h00000001);
        test_add(32'h7FFFFFFF, 32'h00000000);
        test_add(32'h80000000, 32'h00000000);
        
        // Overflow tests for ADD
        $display("Testing ADD overflow cases...");
        test_add(32'h7FFFFFFF, 32'h00000001);  // Positive overflow
        test_add(32'h7FFFFFFF, 32'h7FFFFFFF);  // Positive overflow
        test_add(32'h80000000, 32'h80000000);  // Negative overflow
        test_add(32'h80000000, 32'hFFFFFFFF);  // Negative overflow
        
        // No overflow tests for ADD
        $display("Testing ADD no-overflow cases...");
        test_add(32'h7FFFFFFF, 32'h00000000);  // No overflow
        test_add(32'h80000000, 32'h00000001);  // No overflow
        test_add(32'h40000000, 32'h40000000);  // No overflow
        
        // Test SUB operation
        $display("\nTesting SUB operation...");
        
        // Basic subtraction tests
        test_sub(32'h00000000, 32'h00000000);
        test_sub(32'h00000002, 32'h00000001);
        test_sub(32'h7FFFFFFF, 32'h00000000);
        test_sub(32'h80000000, 32'h00000000);
        
        // Overflow tests for SUB
        $display("Testing SUB overflow cases...");
        test_sub(32'h80000000, 32'h00000001);  // Negative overflow
        test_sub(32'h80000000, 32'h7FFFFFFF);  // Negative overflow
        test_sub(32'h7FFFFFFF, 32'h80000000);  // Positive overflow
        test_sub(32'h00000000, 32'h80000000);  // Positive overflow
        
        // No overflow tests for SUB
        $display("Testing SUB no-overflow cases...");
        test_sub(32'h7FFFFFFF, 32'h00000001);  // No overflow
        test_sub(32'h80000000, 32'hFFFFFFFF);  // No overflow
        test_sub(32'h40000000, 32'h20000000);  // No overflow
        
        // Test SLT operation
        $display("\nTesting SLT operation...");
        
        // Basic SLT tests
        test_slt(32'h00000000, 32'h00000000);  // 0 < 0 = false
        test_slt(32'h00000001, 32'h00000002);  // 1 < 2 = true
        test_slt(32'h00000002, 32'h00000001);  // 2 < 1 = false
        test_slt(32'h00000005, 32'h00000003);  // 5 < 3 = false
        test_slt(32'h00000003, 32'h00000005);  // 3 < 5 = true
        
        // Signed comparison tests
        $display("Testing SLT signed comparison cases...");
        test_slt(32'h00000001, 32'hFFFFFFFF);  // 1 < -1 = false
        test_slt(32'hFFFFFFFF, 32'h00000001);  // -1 < 1 = true
        test_slt(32'h80000000, 32'h7FFFFFFF);  // -2147483648 < 2147483647 = true
        test_slt(32'h7FFFFFFF, 32'h80000000);  // 2147483647 < -2147483648 = false
        
        // Edge cases for SLT
        $display("Testing SLT edge cases...");
        test_slt(32'h80000000, 32'h00000000);  // -2147483648 < 0 = true
        test_slt(32'h00000000, 32'h80000000);  // 0 < -2147483648 = false
        test_slt(32'h7FFFFFFF, 32'h00000000);  // 2147483647 < 0 = false
        test_slt(32'h00000000, 32'h7FFFFFFF);  // 0 < 2147483647 = true
        
        // Overflow cases for SLT (these test the MSB XOR overflow logic)
        $display("Testing SLT overflow cases...");
        test_slt(32'h7FFFFFFF, 32'h80000000);  // Positive overflow case
        test_slt(32'h80000000, 32'h7FFFFFFF);  // Negative overflow case
        
        // Edge cases for all operations
        $display("\nTesting edge cases...");
        
        // Maximum and minimum values
        test_and(32'h7FFFFFFF, 32'h80000000);
        test_add(32'h7FFFFFFF, 32'h80000000);
        test_sub(32'h7FFFFFFF, 32'h80000000);
        
        // Zero flag testing
        test_and(32'h12345678, 32'h00000000);  // Should set zero flag
        test_add(32'h12345678, 32'hEDCBA988);  // Should set zero flag if result is 0
        test_sub(32'h12345678, 32'h12345678);  // Should set zero flag
        
        // Equal flag testing
        test_and(32'h12345678, 32'h12345678);  // Should set equal flag
        test_add(32'h12345678, 32'h12345678);  // Should set equal flag
        test_sub(32'h12345678, 32'h12345678);  // Should set equal flag
        
        // Test SRL operations
        $display("\nTesting SRL (Shift Right Logical) operations...");
        $display("Basic SRL tests:");
        test_srl(32'h12345678, 32'h00000000);  // No shift
        test_srl(32'h12345678, 32'h00000001);  // Shift by 1
        test_srl(32'h12345678, 32'h00000002);  // Shift by 2
        test_srl(32'h12345678, 32'h00000004);  // Shift by 4
        test_srl(32'h12345678, 32'h00000008);  // Shift by 8
        test_srl(32'h12345678, 32'h00000010);  // Shift by 16
        test_srl(32'h12345678, 32'h00000020);  // Shift by 32 (y[4:0]=0, so no shift)
        
        $display("SRL edge cases:");
        test_srl(32'h80000000, 32'h00000001);  // MSB set, shift by 1
        test_srl(32'h00000001, 32'h00000001);  // LSB set, shift by 1
        test_srl(32'h00000000, 32'h00000005);  // Zero input
        test_srl(32'hFFFFFFFF, 32'h00000001);  // All 1s, shift by 1
        test_srl(32'h12345678, 32'h0000001F);  // Shift by 31
        test_srl(32'h12345678, 32'h000000FF);  // Shift by 255 (y[4:0]=31)
        
        // Test SRA operations
        $display("\nTesting SRA (Shift Right Arithmetic) operations...");
        $display("Basic SRA tests (positive numbers - same as SRL):");
        test_sra(32'h12345678, 32'h00000000);  // No shift
        test_sra(32'h12345678, 32'h00000001);  // Shift by 1
        test_sra(32'h12345678, 32'h00000002);  // Shift by 2
        test_sra(32'h12345678, 32'h00000004);  // Shift by 4
        test_sra(32'h12345678, 32'h00000008);  // Shift by 8
        test_sra(32'h12345678, 32'h00000010);  // Shift by 16
        
        $display("SRA edge cases (negative numbers - sign-preserving):");
        test_sra(32'h80000000, 32'h00000001);  // -2147483648 >> 1 = -1073741824
        test_sra(32'h80000000, 32'h00000002);  // -2147483648 >> 2 = -536870912
        test_sra(32'h80000000, 32'h00000004);  // -2147483648 >> 4 = -134217728
        test_sra(32'h80000000, 32'h00000008);  // -2147483648 >> 8 = -8388608
        test_sra(32'h80000000, 32'h00000010);  // -2147483648 >> 16 = -32768
        test_sra(32'h80000000, 32'h0000001F);  // -2147483648 >> 31 = -1
        test_sra(32'hFFFFFFFF, 32'h00000001);  // -1 >> 1 = -1
        test_sra(32'hFFFFFFFE, 32'h00000001);  // -2 >> 1 = -1
        test_sra(32'h7FFFFFFF, 32'h00000001);  // Max positive >> 1
        
        // Test SLL operations
        $display("\nTesting SLL (Shift Left Logical) operations...");
        $display("Basic SLL tests:");
        test_sll(32'h12345678, 32'h00000000);  // No shift
        test_sll(32'h12345678, 32'h00000001);  // Shift by 1
        test_sll(32'h12345678, 32'h00000002);  // Shift by 2
        test_sll(32'h12345678, 32'h00000004);  // Shift by 4
        test_sll(32'h12345678, 32'h00000008);  // Shift by 8
        test_sll(32'h12345678, 32'h00000010);  // Shift by 16
        test_sll(32'h12345678, 32'h00000020);  // Shift by 32 (y[4:0]=0, so no shift)
        
        $display("SLL edge cases:");
        test_sll(32'h80000000, 32'h00000001);  // MSB set, shift by 1 (overflow)
        test_sll(32'h00000001, 32'h00000001);  // LSB set, shift by 1
        test_sll(32'h00000000, 32'h00000005);  // Zero input
        test_sll(32'hFFFFFFFF, 32'h00000001);  // All 1s, shift by 1
        test_sll(32'h12345678, 32'h0000001F);  // Shift by 31 (should be 0)
        test_sll(32'h00000001, 32'h0000001F);  // 1 << 31 = 0x80000000
        test_sll(32'h00000001, 32'h0000001E);  // 1 << 30 = 0x40000000
        test_sll(32'h7FFFFFFF, 32'h00000001);  // Max positive << 1 (overflow)
        
        $display("SLL overflow cases:");
        test_sll(32'h40000000, 32'h00000001);  // 0x40000000 << 1 = 0x80000000
        test_sll(32'h20000000, 32'h00000001);  // 0x20000000 << 1 = 0x40000000
        test_sll(32'h10000000, 32'h00000001);  // 0x10000000 << 1 = 0x20000000
        
        // Random pattern tests
        $display("\nTesting random patterns...");
        for (int i = 0; i < 20; i++) begin
            automatic logic [31:0] rand_x = $random;
            automatic logic [31:0] rand_y = $random;
            
            test_and(rand_x, rand_y);
            test_add(rand_x, rand_y);
            test_sub(rand_x, rand_y);
            test_slt(rand_x, rand_y);
            test_srl(rand_x, rand_y);
            test_sra(rand_x, rand_y);
            test_sll(rand_x, rand_y);
        end
        
        // Print final results
        $display("\n=====================================");
        $display("Test Results Summary:");
        $display("Total tests run: %d", total_tests);
        $display("AND errors: %d", and_errors);
        $display("ADD errors: %d", add_errors);
        $display("SUB errors: %d", sub_errors);
        $display("SLT errors: %d", slt_errors);
        $display("SRL errors: %d", srl_errors);
        $display("SRA errors: %d", sra_errors);
        $display("SLL errors: %d", sll_errors);
        $display("Flag errors: %d", flag_errors);
        
        if (and_errors == 0 && add_errors == 0 && sub_errors == 0 && slt_errors == 0 &&
            srl_errors == 0 && sra_errors == 0 && sll_errors == 0 && flag_errors == 0) begin
            $display("ALL TESTS PASSED! ✓");
        end else begin
            $display("SOME TESTS FAILED! ✗");
        end
        
        $display("=====================================");
        $finish;
    end
    
    // Generate VCD file for waveform viewing
    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);
    end

endmodule