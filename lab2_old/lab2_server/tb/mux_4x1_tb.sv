module mux_4x1_tb;
    // Inputs
    logic [3:0] in;
    logic [1:0] sel;

    // Outputs
    logic out;

    // Expected output for self-checking
    logic exp_out;

    // Instantiate the Unit Under Test (UUT)
    mux_4x1 uut (
        .in(in),
        .sel(sel),
        .out(out)
    );

    // Task to apply stimulus and check result
    task check(input logic [3:0] i, input logic [1:0] s);
        begin
            in  = i;
            sel = s;
            #1; // small delay for propagation
            case (s)
                2'b00: exp_out = i[0];
                2'b01: exp_out = i[1];
                2'b10: exp_out = i[2];
                2'b11: exp_out = i[3];
            endcase

            if (out !== exp_out) begin
                $error("Mismatch at time %0t: in=%b sel=%b => out=%b (expected %b)",
                        $time, in, sel, out, exp_out);
            end else begin
                $display("PASS at time %0t: in=%b sel=%b => out=%b",
                         $time, in, sel, out);
            end
        end
    endtask

    initial begin
        $display("Starting self-checking testbench for mux_4x1...");

        // Apply all combinations of inputs (16 values) and select lines (4 values)
        for (int s = 0; s < 4; s++) begin
            for (int i = 0; i < 16; i++) begin
                check(i[3:0], s[1:0]);
            end
        end

        $display("All tests completed.");
        $finish;
    end
endmodule