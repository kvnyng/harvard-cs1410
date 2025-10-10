module half_adder_tb;
    logic a, b;

    logic s, c;

    logic exp_s, exp_c;

    half_adder dut (
        .a(a),
        .b(b),
        .s(s),
        .c(c)
    );

    task check(input logic ta, tb);
        begin
            a = ta;
            b = tb;
            #1;
            exp_s = a ^ b;
            exp_c = a & b;

            if (s !== exp_s || c !== exp_c) begin
                $error("FAIL: a=%0b b=%0b -> s=%0b c=%0b (expected s=%0b c=%0b)",
                       a, b, s, c, exp_s, exp_c);
            end else begin
                $display("PASS: a=%0b b=%0b -> s=%0b c=%0b",
                         a, b, s, c);
            end
        end
    endtask

    initial begin
        $display("Starting half adder testbench...");

        // All possible input combinations
        check(0,0);
        check(0,1);
        check(1,0);
        check(1,1);

        $display("All tests completed.");
        $finish;
    end
endmodule


module full_adder_tb;
    // Inputs
    logic a, b, c_in;

    // Outputs
    logic s, c_out;

    // Expected
    logic exp_s, exp_c_out;

    // Instantiate the DUT
    full_adder dut (
        .a(a),
        .b(b),
        .c_in(c_in),
        .s(s),
        .c_out(c_out)
    );

    // Task to apply one test vector and check results
    task check_full(input logic ta, tb, tcin);
        begin
            a = ta;
            b = tb;
            c_in = tcin;
            #1;
            exp_s     = a ^ b ^ c_in;
            exp_c_out = (a & b) | (b & c_in) | (a & c_in);

            if (s !== exp_s || c_out !== exp_c_out) begin
                $error("FULL ADDER FAIL: a=%0b b=%0b cin=%0b -> s=%0b cout=%0b (expected s=%0b cout=%0b)",
                       a, b, c_in, s, c_out, exp_s, exp_c_out);
            end else begin
                $display("FULL ADDER PASS: a=%0b b=%0b cin=%0b -> s=%0b cout=%0b",
                         a, b, c_in, s, c_out);
            end
        end
    endtask

    initial begin
        $display("Starting full adder testbench...");

        // Exhaustive test: 8 input combinations
        check_full(0,0,0);
        check_full(0,0,1);
        check_full(0,1,0);
        check_full(0,1,1);
        check_full(1,0,0);
        check_full(1,0,1);
        check_full(1,1,0);
        check_full(1,1,1);

        $display("Full adder tests completed.");
        $finish;
    end
endmodule

module ripple_carry_adder_tb;
    logic [31:0] x, y;
    logic        c_in;
    logic [31:0] s;
    logic        c_out;

    ripple_carry_adder dut (
        .a(x),
        .b(y),
        .c_in(c_in),
        .s(s),
        .c_out(c_out)
    );

    function automatic bit signed_overflow(input logic [31:0] a,
                                           input logic [31:0] b,
                                           input logic [31:0] sum);
        // Two's-complement overflow: adding same-sign operands and result flips sign
        signed_overflow = (~(a[31] ^ b[31])) & (sum[31] ^ a[31]);
    endfunction

    task automatic check(input logic [31:0] tx,
                         input logic [31:0] ty,
                         input bit          tcin,
                         input string       label);
        logic [32:0] gold;          // 33-bit to capture carry-out
        bit          ovf_signed;

        begin
            x    = tx;
            y    = ty;
            c_in = tcin;
            #1; // allow propagation

            gold = {1'b0, tx} + {1'b0, ty} + tcin;
            ovf_signed = signed_overflow(tx, ty, s);

            if ({c_out, s} !== gold) begin
                $error("[%s] MISMATCH  x=%h  y=%h  cin=%0d  ->  DUT {cout,sum}=%b_%h  expected=%b_%h",
                       label, tx, ty, tcin, c_out, s, gold[32], gold[31:0]);
            end else begin
                $display("[%s] PASS     x=%h  y=%h  cin=%0d  ->  {cout,sum}=%b_%h  (signed_overflow=%0d)",
                         label, tx, ty, tcin, c_out, s, ovf_signed);
            end
        end
    endtask

    initial begin
        $display("=== adder_tb: edge-case verification start ===");

        // ---- Zero cases ----
        check(32'h0000_0000, 32'h0000_0000, 1'b0, "ZERO+ZERO");
        check(32'h0000_0000, 32'h0000_0000, 1'b1, "ZERO+ZERO+Cin1");
        check(32'h0000_0001, 32'hFFFF_FFFF, 1'b0, "ONE+NEGONE -> zero (unsigned wrap)");

        // ---- Unsigned overflow / carry-out edge ----
        check(32'hFFFF_FFFF, 32'h0000_0001, 1'b0, "MAXU+1 (carry out, sum=0)");
        check(32'hFFFF_FFFF, 32'hFFFF_FFFF, 1'b1, "MAXU+MAXU+1 (carry out, sum=FFFF_FFFF)");

        // ---- Signed positive overflow ----
        check(32'h7FFF_FFFF, 32'h0000_0001, 1'b0, "POS_MAX+1 (signed overflow)");
        check(32'h7FFF_F000, 32'h0000_FFFF, 1'b0, "POS+POS boundary (possible ovf)");

        // ---- Signed negative overflow ----
        check(32'h8000_0000, 32'hFFFF_FFFF, 1'b0, "NEG_MIN+(-1) (signed overflow)");
        check(32'h8000_0000, 32'h8000_0000, 1'b0, "NEG_MIN+NEG_MIN (signed overflow)");

        // ---- Negative + Positive (no overflow expected in many cases) ----
        check(32'h8000_0000, 32'h7FFF_FFFF, 1'b0, "NEG_MIN+POS_MAX -> -1 (no ovf)");
        check(32'hFFFF_0000, 32'h0000_8000, 1'b1, "NEG + POS + Cin");

        // ---- Carry chain edges around MSB ----
        check(32'h7FFF_FFFF, 32'h7FFF_FFFF, 1'b0, "POS_MAX+POS_MAX (signed ovf, no carry into MSB? verify)");
        check(32'hFFFF_FFFE, 32'h0000_0001, 1'b1, "…FFE + 1 + Cin1 -> …000 with carry");

        // ---- A few random near-boundary values ----
        check(32'h0000_0000, 32'hFFFF_FFFF, 1'b1, "ZERO + -1 + Cin1");
        check(32'hAAAA_AAAA, 32'h5555_5555, 1'b0, "Pattern mix (no ovf)");
        check(32'h8000_0001, 32'h8000_0001, 1'b0, "Negatives add (signed ovf)");

        // ---- Optional: quick randomized smoke (small count; expand if desired) ----
        repeat (20) begin
            automatic logic [31:0] rx = $urandom();
            automatic logic [31:0] ry = $urandom();
            automatic bit          rc = $urandom_range(0,1);
            check(rx, ry, rc, "RANDOM");
        end

        $display("=== ripple_carry_adder_tb: all tests complete ===");
        $finish;
    end
endmodule

module adder_subtractor_tb;
    // Inputs
    logic [31:0] x, y;

    // DUT outputs
    logic [31:0] sum_s, sub_s;
    logic        sum_c, sub_c;

    // Instantiate DUTs
    adder dut_add (
        .a(x),
        .b(y),
        .s(sum_s),
        .c_out(sum_c)
    );

    subtractor dut_sub (
        .a(x),
        .b(y),
        .s(sub_s),
        .c_out(sub_c)
    );

    // --- Overflow detection functions ---
    function automatic bit add_overflow(input logic [31:0] a,
                                        input logic [31:0] b,
                                        input logic [31:0] sum);
        add_overflow = (~(a[31] ^ b[31])) & (sum[31] ^ a[31]);
    endfunction

    function automatic bit sub_overflow(input logic [31:0] a,
                                        input logic [31:0] b,
                                        input logic [31:0] diff);
        sub_overflow = (a[31] ^ b[31]) & (diff[31] ^ a[31]);
    endfunction

    // --- Test task ---
    task automatic check(input logic [31:0] tx,
                         input logic [31:0] ty,
                         input string       label);
        logic [32:0] gold_sum;
        logic [32:0] gold_sub;
        bit ovf_add, ovf_sub;
        begin
            x = tx;
            y = ty;
            #1

            // Golden results
            gold_sum = {1'b0, tx} + {1'b0, ty};
            gold_sub = {1'b0, tx} + {1'b0, ~ty} + 1;

            ovf_add = add_overflow(tx, ty, sum_s);
            ovf_sub = sub_overflow(tx, ty, sub_s);

            // --- Check adder ---
            if ({sum_c, sum_s} !== gold_sum) begin
                $error("[%s] ADD FAIL: x=%h y=%h -> DUT={c=%b,s=%h}, expected={c=%b,s=%h}, signed_ovf=%0d",
                       label, x, y, sum_c, sum_s, gold_sum[32], gold_sum[31:0], ovf_add);
            end else begin
                $display("[%s] ADD PASS: x=%h y=%h -> {c_out,s}=%b_%h, signed_ovf=%0d",
                         label, x, y, sum_c, sum_s, ovf_add);
            end

            // --- Check subtractor ---
            if ({sub_c, sub_s} !== gold_sub) begin
                $error("[%s] SUB FAIL: x=%h y=%h -> DUT={c=%b,s=%h}, expected={c=%b,s=%h}, signed_ovf=%0d",
                       label, x, y, sub_c, sub_s, gold_sub[32], gold_sub[31:0], ovf_sub);
            end else begin
                $display("[%s] SUB PASS: x=%h y=%h -> {c_out,s}=%b_%h, signed_ovf=%0d",
                         label, x, y, sub_c, sub_s, ovf_sub);
            end
        end
    endtask

    initial begin
        $display("=== adder_tb: starting tests ===");

        // Directed cases
        check(32'h0000_0000, 32'h0000_0000, "ZERO+ZERO");
        check(32'hFFFF_FFFF, 32'h0000_0001, "MAXU+1 (wrap)");
        check(32'h8000_0000, 32'h7FFF_FFFF, "NEG_MIN+POS_MAX");
        check(32'h7FFF_FFFF, 32'h0000_0001, "POS_MAX+1 (signed overflow)");
        check(32'h8000_0000, 32'hFFFF_FFFF, "NEG_MIN-1 (signed overflow)");
        check(32'hAAAA_AAAA, 32'h5555_5555, "Alternating pattern");

        // Randomized checks
        repeat (10) begin
            automatic logic [31:0] rx = $urandom();
            automatic logic [31:0] ry = $urandom();
            check(rx, ry, "RANDOM");
        end

        $display("=== adder_tb: all tests completed ===");
        $finish;
    end
endmodule
