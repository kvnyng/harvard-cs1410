module mux_8x1_tb;
    // Inputs
    logic [7:0] in;
    logic [2:0] sel;

    // Outputs
    logic out;

    // Expected output for self-checking
    logic exp_out;

    // Instantiate the Unit Under Test (UUT)
    mux_8x1 uut (
        .in(in),
        .sel(sel),
        .out(out)
    );

    // Task to apply stimulus and check result
    task check(input logic [7:0] i, input logic [2:0] s);
        begin
            in  = i;
            sel = s;
            #1; // small delay for propagation

            case (s)
                3'b000: exp_out = i[0];
                3'b001: exp_out = i[1];
                3'b010: exp_out = i[2];
                3'b011: exp_out = i[3];
                3'b100: exp_out = i[4];
                3'b101: exp_out = i[5];
                3'b110: exp_out = i[6];
                3'b111: exp_out = i[7];
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
        $display("Starting self-checking testbench for mux_8x1...");

        // Apply all combinations of inputs (256 values) and select lines (8 values)
        for (int s = 0; s < 8; s++) begin
            for (int i = 0; i < 256; i++) begin
                check(i[7:0], s[2:0]);
            end
        end

        $display("All tests completed.");
        $finish;
    end
endmodule