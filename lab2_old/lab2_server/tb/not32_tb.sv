module not32_tb;
    // DUT signals
    logic [31:0] x;
    logic [31:0] z;

    // Instantiate DUT
    not32 dut (
        .x(x),
        .z(z)
    );

    // Task to check one input pattern
    task automatic check(input logic [31:0] tx, input string label);
        logic [31:0] exp_z;
        begin
            x = tx;
            #1; // allow propagation
            exp_z = ~tx;

            if (z !== exp_z) begin
                $error("[%s] FAIL: x=%h -> z=%h (expected %h)", 
                       label, x, z, exp_z);
            end else begin
                $display("[%s] PASS: x=%h -> z=%h", 
                         label, x, z);
            end
        end
    endtask

    initial begin
        $display("=== not32_tb: starting tests ===");

        // Directed edge cases
        check(32'h0000_0000, "ALL ZEROS");
        check(32'hFFFF_FFFF, "ALL ONES");
        check(32'hAAAA_AAAA, "ALTERNATING A");
        check(32'h5555_5555, "ALTERNATING 5");
        check(32'h8000_0000, "ONLY MSB SET");
        check(32'h0000_0001, "ONLY LSB SET");

        // A few randoms
        repeat (5) begin
            automatic logic [31:0] rx = $urandom();
            check(rx, "RANDOM");
        end

        $display("=== not32_tb: all tests complete ===");
        $finish;
    end
endmodule