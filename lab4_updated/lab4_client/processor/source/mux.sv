`timescale 1ns / 1ps
`include "cpu.svh"

// 4-to-1 multiplexer with parameterized data width
// Selects one of four inputs based on 2-bit select signal
module mux
    #(parameter N = 2)  // Data width (default 2 bits for backward compatibility)
    (
        input logic [1:0] sel,      // 2-bit select signal (00, 01, 10, 11)
        input logic [N-1:0] in0,     // Input 0 (selected when sel = 00)
        input logic [N-1:0] in1,     // Input 1 (selected when sel = 01)
        input logic [N-1:0] in2,     // Input 2 (selected when sel = 10)
        input logic [N-1:0] in3,     // Input 3 (selected when sel = 11)
        output logic [N-1:0] out     // Selected output
    );

    always_comb begin
        case (sel)
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            2'b11: out = in3;
            default: out = '0; // Default case (shouldn't happen)
        endcase
    end

endmodule

// 2-to-1 multiplexer with parameterized data width
// Selects one of two inputs based on 1-bit select signal
module mux_1bit
    #(parameter N = 1)  // Data width (default 1 bit for backward compatibility)
    (
        input logic sel,      // 1-bit select signal (0 or 1)
        input logic [N-1:0] in0,     // Input 0 (selected when sel = 0)
        input logic [N-1:0] in1,     // Input 1 (selected when sel = 1)
        output logic [N-1:0] out     // Selected output
    );

    always_comb begin
        case (sel)
            1'b0: out = in0;
            1'b1: out = in1;
            default: out = '0; // Default case (shouldn't happen)
        endcase
    end

endmodule

