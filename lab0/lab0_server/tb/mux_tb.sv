// The following module is made for SIMULATION ONLY - most of the language
// constructs used here will not synthesize, but will simulate
module mux_tb;
    // timeunit for the simulator waveform
    // delays (#1) are in units of nanoseconds with 2 decimal
    // places of accuracy
    timeunit 1ns/1ps;

    logic a, b, c, d;
    logic [1:0] sel; // inputs
    logic z; // outputs

    // instantiate unit under test (uut)
    // somtimes this is also called the device under test (dut)
    mux uut (.a, .b, .c, .d, .sel, .z);

    initial begin
        for (int i = 0; i <= 7'b0111111; i++) begin
            // set inputs
            a = i[0];
            b = i[1];
            c = i[2];
            d = i[3];
            sel[0] = i[4];
            sel[1] = i[5];

            // wait 10 time units
            #10;

            // verify the output is correct
            if (sel == 0 && z !== a) begin
                $display("ERROR: a=%b, b=%b, sel=%b, f=%b", a, b, sel, z);
            end
            
             if (sel == 1 && z !== b) begin
                $display("ERROR: a=%b, b=%b, sel=%b, f=%b", a, b, sel, z);
            end
            
            if (sel == 2 && z !== c) begin
                $display("ERROR: a=%b, b=%b, sel=%b, f=%b", a, b, sel, z);
            end
            
            if (sel == 3 && z !== d) begin
                $display("ERROR: a=%b, b=%b, sel=%b, f=%b", a, b, sel, z);
            end
            
           
        end

        $finish;
    end
endmodule
