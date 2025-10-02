// The following module is made for SIMULATION ONLY - most of the language
// constructs used here will not synthesize, but will simulate

module blackbox_tb;
    timeunit 1ns/1ps; // time measured in 1ns with accuracy up to 1ps
   
    // Declare blackbox signals 
    logic in1, in2, in3; // inputs
    logic out; // outputs
    logic ground_truth;

    // Instantiate blackbox (uut stands for "unit under test")
    blackbox uut (.in1, .in2, .in3, .out);

    logic truth_table [0:7] = '{
        1'b0,  // 000
        1'b0,  // 001 
        1'b1,  // 010 
        1'b0,  // 011 
        1'b1, // 100
        1'b0,  // 101 
        1'b0,  // 110
        1'b0   // 111 
    };


    initial begin
        for (int i = 0; i<8; i++) begin
            {in1, in2, in3} = i[2:0];

            #1; // Wait for blackbox

            ground_truth = truth_table[i];

            if (out === ground_truth) begin
                // If output is correct, print a message:
                $display("CORRECT: f(%b,%b,%b) = %b", in1, in2, in3, out);
            end else begin

                $display("ERROR: f(%b,%b,%b) = %b", in1, in2, in3, out);
            end
        end
        // After checking every input combination, end the testbench:
        $finish;
    end
endmodule

