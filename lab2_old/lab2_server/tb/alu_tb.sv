`timescale 1ns/1ps
`include "alu.svh"

module alu_tb;
    // Inputs
    logic signed [31:0] x;
    logic signed [31:0] y;
    logic [2:0]         op;

    // Outputs
    logic signed [31:0] z;
    logic               equal;
    logic               overflow;
    logic               zero;

    logic [31:0] E [0:7];

    // Instantiate the Unit Under Test (UUT)
    STUDENT_alu uut (
        .x, .y, .z, .op, .equal, .overflow, .zero
    );

    int error;

    // ---------- helpers for overflow (signed) ----------
    function automatic bit ovf_add(input logic [31:0] a, b, input logic [31:0] sum);
        return (~(a[31]^b[31])) & (sum[31]^a[31]);
    endfunction
    function automatic bit ovf_sub(input logic [31:0] a, b, input logic [31:0] diff);
        return (a[31]^b[31]) & (diff[31]^a[31]);
    endfunction

    // flag check task (supplements the always block that checks z)
    task automatic check_flags(input string tag);
        logic exp_equal, exp_zero, exp_ovf;
        logic [31:0] res_golden;
        begin
            // golden result for current op (only ops under test)
            unique case (op)
                `ALU_AND: res_golden = x & y;
                `ALU_ADD: res_golden = x + y;
                `ALU_SUB: res_golden = x - y;
                // SLT now returns all 1s (true) or all 0s (false)
                `ALU_SLT: res_golden = ($signed(x) < $signed(y)) ? 32'hFFFF_FFFF : 32'h0000_0000;
                default:  res_golden = 32'h0; // shouldn't hit
            endcase

            exp_equal = (x === y);
            exp_zero  = (res_golden == 32'h0);
            exp_ovf   = (op==`ALU_ADD) ? ovf_add(x, y, res_golden)
                      : (op==`ALU_SUB) ? ovf_sub(x, y, res_golden)
                      : 1'b0;

            // compare flags (z is already checked in the always block below)
            if (equal !== exp_equal) begin
                $display("ERROR: FLAG equal: op=%b x=%h y=%h  DUT=%0d EXP=%0d  (%s)",
                         op, x, y, equal, exp_equal, tag);
                error++;
            end
            if (zero !== exp_zero) begin
                $display("ERROR: FLAG zero:  op=%b z=%h  DUT=%0d EXP=%0d  (%s)",
                         op, z, zero, exp_zero, tag);
                error++;
            end
            if (overflow !== exp_ovf) begin
                $display("ERROR: FLAG ovf:   op=%b x=%h y=%h z=%h  DUT=%0d EXP=%0d  (%s)",
                         op, x, y, z, overflow, exp_ovf, tag);
                error++;
            end
        end
    endtask

    // convenience constants
    localparam logic [31:0] Z  = 32'h0000_0000;
    localparam logic [31:0] ON = 32'hFFFF_FFFF;
    localparam logic [31:0] PM = 32'h7FFF_FFFF; // +max (signed)
    localparam logic [31:0] NM = 32'h8000_0000; // -min (signed)
    localparam logic [31:0] A  = 32'hAAAA_AAAA;
    localparam logic [31:0] S5 = 32'h5555_5555;
    localparam logic [31:0] L1 = 32'h0000_0001;
    localparam logic [31:0] L2 = 32'h0000_0002;

    // drive helper
    task automatic drive(input logic [2:0] op_i,
                         input logic signed [31:0] xi,
                         input logic signed [31:0] yi,
                         input string tag);
        begin
            op = op_i; x = xi; y = yi;
            #1;               // allow comb to settle
            check_flags(tag); // flags check (z is checked in always)
        end
    endtask

    initial begin
        error = 0;

        $display("=== alu_tb (edge cases) start ===");

        // ---------- AND ----------
        drive(`ALU_AND, Z , Z , "AND zero&zero");
        drive(`ALU_AND, ON, ON, "AND ones&ones");
        drive(`ALU_AND, A , S5, "AND alternating");
        drive(`ALU_AND, NM, PM, "AND min&max");
        drive(`ALU_AND, ON, Z , "AND annihilator");
        drive(`ALU_AND, 32'hDEAD_BEEF, 32'hDEAD_BEEF, "AND idempotent");

        // ---------- ADD (signed overflow edges, wraps) ----------
        drive(`ALU_ADD, ON, L1, "ADD wrap to zero (unsigned carry)");
        drive(`ALU_ADD, PM, L1, "ADD +max + 1 (signed ovf=1)");
        drive(`ALU_ADD, NM, NM, "ADD min + min (signed ovf=1)");
        drive(`ALU_ADD, PM, Z , "ADD +max + 0 (no ovf)");
        drive(`ALU_ADD, NM, Z , "ADD min  + 0 (no ovf)");
        drive(`ALU_ADD, 32'h0000_FFFF, 32'h0000_0001, "ADD ripple across low16");
        drive(`ALU_ADD, 32'h7FFF_0000, 32'h0001_0000, "ADD ripple near sign");

        // ---------- SUB (signed overflow edges, borrow behavior) ----------
        drive(`ALU_SUB, 32'hDEAD_BEEF, 32'hDEAD_BEEF, "SUB a-a -> 0");
        drive(`ALU_SUB, Z , L1, "SUB 0-1 => FFFF_FFFF (borrow)");
        drive(`ALU_SUB, NM, L1, "SUB min - 1 (signed ovf=1)");
        drive(`ALU_SUB, PM, ON, "SUB +max - (-1) (signed ovf=1)");
        drive(`ALU_SUB, L1, L2, "SUB 1-2 => -1 (no ovf)");
        drive(`ALU_SUB, L2, L1, "SUB 2-1 => +1 (no ovf)");

        // ---------- SLT (signed; now all-ones/all-zeros) ----------
        drive(`ALU_SLT, 32'hFFFF_FFFF, L1, "SLT -1 < +1 => FFFF_FFFF");
        drive(`ALU_SLT, L1, 32'hFFFF_FFFF, "SLT +1 < -1 => 0000_0000");
        drive(`ALU_SLT, NM, Z , "SLT min < 0 => FFFF_FFFF");
        drive(`ALU_SLT, Z , NM, "SLT 0 < min => 0000_0000");
        drive(`ALU_SLT, PM, NM, "SLT +max < min => 0000_0000");
        drive(`ALU_SLT, NM, PM, "SLT min < +max => FFFF_FFFF");
        drive(`ALU_SLT, 32'h1234_5678, 32'h1234_5678, "SLT equal => 0000_0000");

        // a few extreme pair sweeps (compact)
        // initialize E once
        E = '{
        32'h8000_0000, // NM
        32'h7FFF_FFFF, // PM
        32'hFFFF_FFFF, // ON
        32'h0000_0000, // Z
        32'h7FFF_FFFE,
        32'h8000_0001,
        32'h0000_7FFF,
        32'hFFFF_8000
        };

        foreach (E[i]) foreach (E[j]) begin
            drive(`ALU_ADD, E[i], E[j], $sformatf("ADD edge sweep %0d,%0d", i,j));
            drive(`ALU_SUB, E[i], E[j], $sformatf("SUB edge sweep %0d,%0d", i,j));
            drive(`ALU_AND, E[i], E[j], $sformatf("AND edge sweep %0d,%0d", i,j));
            drive(`ALU_SLT, E[i], E[j], $sformatf("SLT edge sweep %0d,%0d", i,j));
        end

        $display("=== DONE. Total errors: %0d ===", error);
        $finish;
    end

    // ===========================================================
    // Provided checker: verifies z (updated for all-ones/all-zeros SLT)
    // ===========================================================
    always @(x, y, op) begin
        #1;
        case (op)
            `ALU_AND: begin
                if (z !== (x & y)) begin
                    $display("ERROR: AND:  op=%b, x=%h, y=%h, z=%h, expected=%h", op, x, y, z, (x&y));
                    error = error + 1;
                end
            end
            `ALU_ADD: begin
                if (z !== (x + y)) begin
                    $display("ERROR: ADD:  op=%b, x=%h, y=%h, z=%h, expected=%h", op, x, y, z, (x+y));
                    error = error + 1;
                end
            end
            `ALU_SUB: begin
                if (z !== (x - y)) begin
                    $display("ERROR: SUB:  op=%b, x=%h, y=%h, z=%h, expected=%h", 
                            op, x, y, z, (x - y));
                    error = error + 1;
                end
            end
            `ALU_SLT: begin
                // SLT must be 32'hFFFF_FFFF when (x<y) is true (signed), else 32'h0000_0000
                if (z !== (($signed(x) < $signed(y)) ? 32'hFFFF_FFFF : 32'h0000_0000)) begin
                    $display("ERROR: SLT:  op=%b, x=%h, y=%h, z=%h, expected=%h", 
                                op, x, y, z, 
                                (($signed(x) < $signed(y)) ? 32'hFFFF_FFFF : 32'h0000_0000)
                                );
                    error = error + 1;
                end
            end
            default: begin
                // not exercised here
            end
        endcase
    end

endmodule