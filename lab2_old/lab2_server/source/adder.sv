`default_nettype wire
`timescale 1ns/1ps
module half_adder 
    (
        input logic a,b,
        output logic s,c
    );

    xor s_out (s, a, b);
    and c_out (c, a, b);

endmodule

//  xvlog -sv source/adder.sv tb/adder_tb.sv
//  xelab half_adder_tb -s half_adder_tb_sim -debug typical
//  xsim half_adder_tb_sim -R

module full_adder
    (
        input logic a,b,c_in,
        output logic s, c_out
    );

    logic xor_ab, and_ab, xor_ab_and_cin;

    xor u1 (xor_ab, a, b);
    and u2 (and_ab, a, b);

    xor u3 (s, xor_ab, c_in);
    and u4 (xor_ab_and_cin, xor_ab, c_in);

    or u5 (c_out, xor_ab_and_cin, and_ab);
    
endmodule

//  xvlog -sv source/adder.sv tb/adder_tb.sv
//  xelab full_adder_tb -s full_adder_tb_sim -debug typical
//  xsim full_adder_tb_sim -R

module ripple_carry_adder
    (
        input logic [31:0] a,
        input logic [31:0] b,
        input logic c_in,
        
        output logic [31:0] s,
        output logic c_out,
        output logic overflow

    );

    logic [32:0] carry;

    assign carry[0] = c_in;

    genvar i;
    generate 
        for (i = 0; i<32; i=i+1) begin: gen_add
            full_adder fa_i (
                .a (a[i]),
                .b (b[i]),
                .c_in (carry[i]),
                .s (s[i]),
                .c_out (carry[i+1])
            );
        end
    endgenerate

    assign c_out = carry[32];
    xor u1 (overflow, carry[31], carry[32]);

endmodule

//  xvlog -sv source/adder.sv tb/adder_tb.sv
//  xelab adder_tb -s adderatb_sim -debug typical
//  xsim adder_tb_sim -R

module adder
    (
        input logic [31:0] a,
        input logic [31:0] b,

        output logic [31:0] s,
        output logic c_out,
        output logic overflow
    );

    ripple_carry_adder u (
        .a (a[31:0]),
        .b (b[31:0]),
        .c_in(1'b0),
        .s (s[31:0]),
        .c_out (c_out),
        .overflow (overflow)
    );

endmodule

//  xvlog -sv source/adder.sv tb/adder_tb.sv
//  xelab adder_tb -s adderatb_sim -debug typical
//  xsim adder_tb_sim -R

module subtractor
    (
        input logic [31:0] a,
        input logic [31:0] b,

        output logic [31:0] s,
        output logic c_out,
        output logic overflow
    );

    logic [31:0] not_b;
    logic adder_out, adder_overflow;

    not32 not_u1 (
        .x(b),
        .z(not_b)
    );
    
    ripple_carry_adder u (
        .a (a),
        .b (not_b),
        .c_in(1'b1),
        .s (s[31:0]),
        .c_out (c_out),
        .overflow (overflow)
    );

    // not u1 (c_out, adder_out);

    // // Flags for subtraction:
    // assign borrow   = ~adder_out;                       // subtract borrow
    // assign overflow = (a[31] ^ b[31]) & (a[31] ^ s[31]); // subtract overflow

endmodule

//  xvlog -sv source/not32.sv source/adder.sv tb/adder_tb.sv
//  xelab adder_subtractor_tb -s adder_subtractor_tb_sim -debug typical
//  xsim adder_subtractor_tb_sim -R

`default_nettype wire