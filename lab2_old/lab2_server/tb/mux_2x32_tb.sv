module mux_2x32_tb;
    logic [31:0] a, b;
    logic        sel;
    logic [31:0] out;

    mux_2x32 dut (.a(a), .b(b), .sel(sel), .out(out));

    function automatic logic [31:0] golden(input logic [31:0] aa,
                                           input logic [31:0] bb,
                                           input logic        ss);
        golden = ss ? bb : aa;
    endfunction

    task automatic check(input logic [31:0] aa,
                         input logic [31:0] bb,
                         input logic        ss,
                         input string       tag);
        logic [31:0] exp; // <-- renamed
        begin
            a=aa; b=bb; sel=ss;
            #1;
            exp = golden(aa,bb,ss);
            if (out !== exp)
                $error("[2x32 %s] FAIL sel=%0d a=%h b=%h -> out=%h (exp %h)",
                       tag, ss, aa, bb, out, exp);
            else
                $display("[2x32 %s] PASS sel=%0d a=%h b=%h -> out=%h",
                         tag, ss, aa, bb, out);
        end
    endtask

    initial begin
        check(32'h0000_0000, 32'hFFFF_FFFF, 1'b0, "S0");
        check(32'h0000_0000, 32'hFFFF_FFFF, 1'b1, "S1");
        repeat (12) begin
            automatic logic [31:0] ra=$urandom(), rb=$urandom();
            automatic logic rs=$urandom_range(0,1);
            check(ra, rb, rs, "RND");
        end
        $finish;
    end
endmodule