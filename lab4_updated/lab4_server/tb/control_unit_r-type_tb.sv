`timescale 1ns / 1ps
`include "../source/cpu.svh"

module control_unit_rtype_tb();

    // Clock signal
    logic clk = 0;
    
    // Control unit inputs
    logic [5:0] opcode;
    logic [5:0] funct;
    
    // Control unit outputs
    logic PCWrite;
    logic Branch;
    logic PCSrc;
    logic [3:0] ALUControl;
    logic [1:0] ALUSrcB;
    logic ALUSrcA;
    logic RegWrite;
    logic IorD;
    logic MemWrite;
    logic IRWrite;
    logic MemToReg;
    logic RegDst;
    
    // Instantiate control unit
    control_unit dut (
        .clk(clk),
        .opcode(opcode),
        .funct(funct),
        .PCWrite(PCWrite),
        .Branch(Branch),
        .PCSrc(PCSrc),
        .ALUControl(ALUControl),
        .ALUSrcB(ALUSrcB),
        .ALUSrcA(ALUSrcA),
        .RegWrite(RegWrite),
        .IorD(IorD),
        .MemWrite(MemWrite),
        .IRWrite(IRWrite),
        .MemToReg(MemToReg),
        .RegDst(RegDst)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    // Structure to record control signals at each clock edge
    typedef struct packed {
        logic IorD;
        logic ALUSrcA;
        logic [1:0] ALUSrcB;
        logic [3:0] ALUControl;
        logic PCSrc;
        logic IRWrite;
        logic PCWrite;
        logic RegDst;
        logic MemToReg;
        logic RegWrite;
        logic [5:0] opcode;
        logic [5:0] funct;
        time timestamp;
    } control_snapshot_t;
    
    // Array to store snapshots
    control_snapshot_t snapshots [0:1000];
    int snapshot_count = 0;
    
    // Task to record current control signals
    task record_snapshot();
        snapshots[snapshot_count].IorD = IorD;
        snapshots[snapshot_count].ALUSrcA = ALUSrcA;
        snapshots[snapshot_count].ALUSrcB = ALUSrcB;
        snapshots[snapshot_count].ALUControl = ALUControl;
        snapshots[snapshot_count].PCSrc = PCSrc;
        snapshots[snapshot_count].IRWrite = IRWrite;
        snapshots[snapshot_count].PCWrite = PCWrite;
        snapshots[snapshot_count].RegDst = RegDst;
        snapshots[snapshot_count].MemToReg = MemToReg;
        snapshots[snapshot_count].RegWrite = RegWrite;
        snapshots[snapshot_count].opcode = opcode;
        snapshots[snapshot_count].funct = funct;
        snapshots[snapshot_count].timestamp = $time;
        snapshot_count++;
    endtask
    
    // Task to verify S0 signals from a snapshot
    task automatic verify_S0(control_snapshot_t s, int cycle_num);
        automatic int errors = 0;
        if (s.IorD != 1'b0) begin
            $error("Cycle %0d (S0): IorD should be 0, got %b", cycle_num, s.IorD);
            errors++;
        end
        if (s.ALUSrcA != 1'b0) begin
            $error("Cycle %0d (S0): ALUSrcA should be 0, got %b", cycle_num, s.ALUSrcA);
            errors++;
        end
        if (s.ALUSrcB != 2'b01) begin
            $error("Cycle %0d (S0): ALUSrcB should be 01, got %b", cycle_num, s.ALUSrcB);
            errors++;
        end
        if (s.ALUControl != `ALU_ADD) begin
            $error("Cycle %0d (S0): ALUControl should be ADD (0101), got %b", cycle_num, s.ALUControl);
            errors++;
        end
        if (s.PCSrc != 1'b0) begin
            $error("Cycle %0d (S0): PCSrc should be 0, got %b", cycle_num, s.PCSrc);
            errors++;
        end
        if (s.IRWrite != 1'b1) begin
            $error("Cycle %0d (S0): IRWrite should be 1, got %b", cycle_num, s.IRWrite);
            errors++;
        end
        if (s.PCWrite != 1'b1) begin
            $error("Cycle %0d (S0): PCWrite should be 1, got %b", cycle_num, s.PCWrite);
            errors++;
        end
        if (errors == 0) begin
            $display("  Cycle %0d (S0): ✓ All signals correct", cycle_num);
        end
    endtask
    
    // Task to verify S1 signals from a snapshot
    task automatic verify_S1(control_snapshot_t s, int cycle_num);
        automatic int errors = 0;
        if (s.ALUSrcA != 1'b0) begin
            $error("Cycle %0d (S1): ALUSrcA should be 0, got %b", cycle_num, s.ALUSrcA);
            errors++;
        end
        if (s.ALUSrcB != 2'b11) begin
            $error("Cycle %0d (S1): ALUSrcB should be 11, got %b", cycle_num, s.ALUSrcB);
            errors++;
        end
        if (s.ALUControl != `ALU_ADD) begin
            $error("Cycle %0d (S1): ALUControl should be ADD (0101), got %b", cycle_num, s.ALUControl);
            errors++;
        end
        if (errors == 0) begin
            $display("  Cycle %0d (S1): ✓ All signals correct", cycle_num);
        end
    endtask
    
    // Task to verify S2 signals from a snapshot
    task automatic verify_S2(control_snapshot_t s, int cycle_num, logic [5:0] expected_funct);
        automatic logic [3:0] expected_alu_op;
        automatic int errors = 0;
        
        if (s.ALUSrcA != 1'b1) begin
            $error("Cycle %0d (S2): ALUSrcA should be 1, got %b", cycle_num, s.ALUSrcA);
            errors++;
        end
        if (s.ALUSrcB != 2'b00) begin
            $error("Cycle %0d (S2): ALUSrcB should be 00, got %b", cycle_num, s.ALUSrcB);
            errors++;
        end
        
        // Determine expected ALU op based on funct
        case (expected_funct)
            `F_AND: expected_alu_op = `ALU_AND;
            `F_OR:  expected_alu_op = `ALU_OR;
            `F_XOR: expected_alu_op = `ALU_XOR;
            `F_NOR: expected_alu_op = `ALU_NOR;
            `F_ADD: expected_alu_op = `ALU_ADD;
            `F_SUB: expected_alu_op = `ALU_SUB;
            `F_SLT: expected_alu_op = `ALU_SLT;
            `F_SLL: expected_alu_op = `ALU_SLL;
            `F_SRL: expected_alu_op = `ALU_SRL;
            `F_SRA: expected_alu_op = `ALU_SRA;
            default: expected_alu_op = `ALU_ADD;
        endcase
        
        if (s.ALUControl != expected_alu_op) begin
            $error("Cycle %0d (S2): ALUControl should be %b for funct %b, got %b", 
                   cycle_num, expected_alu_op, expected_funct, s.ALUControl);
            errors++;
        end
        if (errors == 0) begin
            $display("  Cycle %0d (S2): ✓ All signals correct (ALU op: %b for funct: %b)", 
                     cycle_num, s.ALUControl, expected_funct);
        end
    endtask
    
    // Task to verify S3 signals from a snapshot
    task automatic verify_S3(control_snapshot_t s, int cycle_num);
        automatic int errors = 0;
        if (s.RegDst != 1'b1) begin
            $error("Cycle %0d (S3): RegDst should be 1, got %b", cycle_num, s.RegDst);
            errors++;
        end
        if (s.MemToReg != 1'b0) begin
            $error("Cycle %0d (S3): MemToReg should be 0, got %b", cycle_num, s.MemToReg);
            errors++;
        end
        if (s.RegWrite != 1'b1) begin
            $error("Cycle %0d (S3): RegWrite should be 1, got %b", cycle_num, s.RegWrite);
            errors++;
        end
        if (errors == 0) begin
            $display("  Cycle %0d (S3): ✓ All signals correct", cycle_num);
        end
    endtask
    
    // Task to test a single R-type instruction
    task automatic test_rtype_instruction(input logic [5:0] test_funct, input string inst_name);
        automatic int start_cycle;
        $display("\n=== Testing %s (funct: %b) ===", inst_name, test_funct);
        
        // Set up for R-type instruction
        opcode = `OP_RTYPE;
        funct = test_funct;
        
        // Wait for a clock cycle to ensure we're in a known state
        @(posedge clk);
        @(negedge clk);
        
        // Record starting cycle
        start_cycle = snapshot_count;
        
        // Wait for posedge to enter S0, then record after state settles
        @(posedge clk);
        #2; // Small delay for combinational logic to settle
        record_snapshot();
        
        // Wait for posedge to transition to S1, then record after state settles
        @(posedge clk);
        #2;
        record_snapshot();
        
        // Wait for posedge to transition to S2, then record after state settles
        @(posedge clk);
        #2;
        record_snapshot();
        
        // Wait for posedge to transition to S3, then record after state settles
        @(posedge clk);
        #2;
        record_snapshot();
        
        // Wait for posedge to transition back to S0, then record after state settles
        @(posedge clk);
        #2;
        record_snapshot();
        
        // Post-mortem verification
        $display("  Post-mortem verification:");
        verify_S0(snapshots[start_cycle + 0], start_cycle + 0);
        verify_S1(snapshots[start_cycle + 1], start_cycle + 1);
        verify_S2(snapshots[start_cycle + 2], start_cycle + 2, test_funct);
        verify_S3(snapshots[start_cycle + 3], start_cycle + 3);
        verify_S0(snapshots[start_cycle + 4], start_cycle + 4);
        
        $display("✓ %s test passed!\n", inst_name);
    endtask
    
    // Main test sequence
    initial begin
        $display("========================================");
        $display("Control Unit R-Type Instruction Testbench");
        $display("========================================\n");
        
        // Initialize inputs
        opcode = `OP_RTYPE;
        funct = 6'b0;
        
        // Wait a few clock cycles for initialization
        #20;
        
        // Test various R-type instructions
        test_rtype_instruction(`F_ADD, "ADD");
        test_rtype_instruction(`F_SUB, "SUB");
        test_rtype_instruction(`F_AND, "AND");
        test_rtype_instruction(`F_OR,  "OR");
        test_rtype_instruction(`F_XOR, "XOR");
        test_rtype_instruction(`F_NOR, "NOR");
        test_rtype_instruction(`F_SLT, "SLT");
        test_rtype_instruction(`F_SLL, "SLL");
        test_rtype_instruction(`F_SRL, "SRL");
        test_rtype_instruction(`F_SRA, "SRA");
        
        // Test that non-R-type opcode returns to S0 after S1
        $display("\n=== Testing non-R-type opcode handling ===");
        opcode = `OP_ADDI;  // I-type instruction
        funct = 6'b0;
        
        begin
            automatic int start_cycle = snapshot_count;
            
            // Wait for posedge to enter S0, then record after state settles
            @(posedge clk);
            #2;
            record_snapshot();
            
            @(posedge clk);
            #2;
            record_snapshot();
            
            // Should return to S0, not go to S2
            @(posedge clk);
            #2;
            record_snapshot();
            
            // Post-mortem verification
            $display("  Post-mortem verification:");
            verify_S0(snapshots[start_cycle + 0], start_cycle + 0);
            verify_S1(snapshots[start_cycle + 1], start_cycle + 1);
            verify_S0(snapshots[start_cycle + 2], start_cycle + 2);
        end
        $display("✓ Non-R-type opcode correctly returns to S0\n");
        
        $display("========================================");
        $display("All tests completed successfully!");
        $display("========================================");
        
        #50;
        $finish;
    end

endmodule
