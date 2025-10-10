module mux_tb;
    // Inputs
    logic [1:0] in;
    logic sel;

    // Outputs
    logic out;

    // Expected output for self-checking
    logic exp_out;

    // Instantiate the Unit Under Test (UUT)
    mux_2x1 uut (
        .in(in),
        .sel(sel),
        .out(out)
    );

    // Task to apply stimulus and check result
    task check(input logic [1:0] i, input logic s);
        begin
            in  = i;
            sel = s;
            #1; // small delay for propagation
            exp_out = (s == 0) ? i[0] : i[1]; // Expected behavior of mux
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
        $display("Starting self-checking testbench...");

        // Apply all input combinations
        check(2'b00, 0);
        check(2'b00, 1);

        check(2'b01, 0);
        check(2'b01, 1);

        check(2'b10, 0);
        check(2'b10, 1);

        check(2'b11, 0);
        check(2'b11, 1);

        $display("All tests completed.");
        $finish;
    end
endmodule