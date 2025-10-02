`include "alu.svh"

module alu_tb;
	// Inputs
	logic signed [31:0] x;
	logic signed [31:0] y;
	logic [2:0] op;

	// Outputs
	logic signed [31:0] z;
	logic equal;
	logic overflow;
	logic zero;

	// Instantiate the Unit Under Test (UUT)
	STUDENT_alu uut (
		.x, 
		.y, 
		.z, 
		.op, 
		.equal, 
		.overflow, 
		.zero
	);

    int error;
    // TODO: Declare any additional signals here if you need them



    initial begin
        error = 0;
		// TODO: YOUR TESTS HERE
		// loop through all important test vectors
		// this triggers the always block, which will check your tests

        // Remember, your testbench is only as strong as you make it.

		
				
        $finish;
	end
	

	// an 'always' block is executed whenever any of the variables in the sensitivity
	// list are changed (x, y, or op in this case)
        //** Use this block to check the outputs of your operations against the corresponding SystemVerilog constructs. **//
	always @(x, y, op) begin
		#1;
		case (op)
			`ALU_AND: begin
				if (z !== (x & y)) begin
					$display("ERROR: AND:  op = %b, x = %h, y = %h, z = %h", op, x, y, z);
					error = error + 1;
				end
			end
			`ALU_ADD: begin
			     if (z !== (x + y)) begin
					$display("ERROR: ADD:  op = %b, x = %h, y = %h, z = %h", op, x, y, z);
					error = error + 1;
				end
            end
			`ALU_SUB: begin
			     if (z !== (x - y)) begin
					$display("ERROR: SUB:  op = %b, x = %h, y = %h, z = %h", op, x, y, z);
					error = error + 1;
				end
			end
			`ALU_SLT: begin
			     if (z !== (x < y)) begin
					$display("ERROR: SLT:  op = %b, x = %h, y = %h, z = %h", op, x, y, z);
					error = error + 1;
				end
			end
			`ALU_SRL: begin
			     if (z !== (x >> y)) begin
					$display("ERROR: SRL:  op = %b, x = %h, y = %h, z = %h", op, x, y, z);
					error = error + 1;
				end
			end
			`ALU_SLL: begin
			     if (z !== (x << y)) begin
					$display("ERROR: SLL:  op = %b, x = %h, y = %h, z = %h", op, x, y, z);
					error = error + 1;
				end
			end
			`ALU_SRA: begin
			     if (z !== (x >>> y)) begin
					$display("ERROR: SRA:  op = %b, x = %h, y = %h, z = %h", op, x, y, z);
					error = error + 1;
				end
			end
			default : begin
				// executes if no op codes are matched
			end
		endcase
		
	end
endmodule

