//============================================================
// Testbench: mux_32x8  (sel=0→in[0], 1→in[1], …, 7→in[7])
//============================================================

module mux_8x32_tb;

    // DUT I/O
    logic [7:0][31:0] in_bus;   // 8 inputs, each 32-bit
    logic [2:0]       sel;
    logic [31:0]      out;

    // Instantiate DUT (new API)
    mux_8x32 dut (
        .in  (in_bus),
        .sel (sel),
        .out (out)
    );

    // Distinct patterns per input (declare at module scope)
    logic [31:0] A = 32'h1111_1111;
    logic [31:0] B = 32'h2222_2222;
    logic [31:0] C = 32'h3333_3333;
    logic [31:0] D = 32'h4444_4444;
    logic [31:0] E = 32'h5555_5555;
    logic [31:0] F = 32'h6666_6666;
    logic [31:0] G = 32'h7777_7777;
    logic [31:0] H = 32'h8888_8888;

    // Golden model (array version)
    function automatic logic [31:0] golden_arr(
        input logic [7:0][31:0] in_local,
        input logic [2:0]       ss
    );
        case (ss)
            3'd0: golden_arr = in_local[0];
            3'd1: golden_arr = in_local[1];
            3'd2: golden_arr = in_local[2];
            3'd3: golden_arr = in_local[3];
            3'd4: golden_arr = in_local[4];
            3'd5: golden_arr = in_local[5];
            3'd6: golden_arr = in_local[6];
            default: golden_arr = in_local[7]; // 3'd7
        endcase
    endfunction

    // Helper to pack eight 32-bit values into in_bus (element-by-element)
    task automatic load_in_bus(
        input logic [31:0] a, b, c, d, e, f, g, h
    );
        begin
            in_bus[0] = a;
            in_bus[1] = b;
            in_bus[2] = c;
            in_bus[3] = d;
            in_bus[4] = e;
            in_bus[5] = f;
            in_bus[6] = g;
            in_bus[7] = h;
        end
    endtask

    // Check task
    task automatic check(
        input logic [31:0] aa, bb, cc, dd, ee, ff, gg, hh,
        input logic [2:0]  ss,
        input string       tag
    );
        logic [31:0] exp;
        begin
            load_in_bus(aa,bb,cc,dd,ee,ff,gg,hh);
            sel = ss;
            #1;
            exp = golden_arr(in_bus, ss);
            if (out !== exp) begin
                $error("[32x8 %s] FAIL sel=%0d -> out=%h (exp %h)",
                       tag, ss, out, exp);
                $display("        in[0]=%h in[1]=%h in[2]=%h in[3]=%h", in_bus[0], in_bus[1], in_bus[2], in_bus[3]);
                $display("        in[4]=%h in[5]=%h in[6]=%h in[7]=%h", in_bus[4], in_bus[5], in_bus[6], in_bus[7]);
            end else begin
                $display("[32x8 %s] PASS sel=%0d -> out=%h", tag, ss, out);
            end
        end
    endtask

    // Tests
    initial begin
        $display("=== mux_32x8_tb start ===");

        // Sweep select 0..7 using distinct patterns
        check(A,B,C,D,E,F,G,H, 3'd0, "SEL0->in[0]=A");
        check(A,B,C,D,E,F,G,H, 3'd1, "SEL1->in[1]=B");
        check(A,B,C,D,E,F,G,H, 3'd2, "SEL2->in[2]=C");
        check(A,B,C,D,E,F,G,H, 3'd3, "SEL3->in[3]=D");
        check(A,B,C,D,E,F,G,H, 3'd4, "SEL4->in[4]=E");
        check(A,B,C,D,E,F,G,H, 3'd5, "SEL5->in[5]=F");
        check(A,B,C,D,E,F,G,H, 3'd6, "SEL6->in[6]=G");
        check(A,B,C,D,E,F,G,H, 3'd7, "SEL7->in[7]=H");

        // Edge patterns
        check(32'h0000_0000, 32'hFFFF_FFFF, 32'hAAAA_AAAA, 32'h5555_5555,
              32'h8000_0000, 32'h0000_0001, 32'h0000_0000, 32'hFFFF_0000,
              3'd0, "EDGE0");
        check(32'h0000_0000, 32'hFFFF_FFFF, 32'hAAAA_AAAA, 32'h5555_5555,
              32'h8000_0000, 32'h0000_0001, 32'h0000_0000, 32'hFFFF_0000,
              3'd7, "EDGE7");

        // Randoms
        repeat (10) begin
            automatic logic [31:0] rA = $urandom();
            automatic logic [31:0] rB = $urandom();
            automatic logic [31:0] rC = $urandom();
            automatic logic [31:0] rD = $urandom();
            automatic logic [31:0] rE = $urandom();
            automatic logic [31:0] rF = $urandom();
            automatic logic [31:0] rG = $urandom();
            automatic logic [31:0] rH = $urandom();
            automatic logic [2:0]  rS = $urandom_range(0,7);
            check(rA,rB,rC,rD,rE,rF,rG,rH, rS, "RND");
        end

        $display("=== mux_32x8_tb done ===");
        $finish;
    end
endmodule

// Compile & run:
// xvlog -sv source/mux.sv tb/mux_8x32_tb.sv
// xelab mux_8x32_tb -s mux_8x32_tb_sim -debug typical
// xsim mux_8x32_tb_sim -R