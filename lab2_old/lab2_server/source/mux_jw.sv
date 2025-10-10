module mux_2x1(
    input  wire [1:0] in,
    input  wire       sel,
    output wire       out
    );
    wire w1, w2, w3;
    
    not u_not1(w1, sel);
    and u_and1(w2, w1, in[0]);
    and u_and2(w3, sel, in[1]);
    or u_or1(out, w2, w3);
endmodule

module mux_4x1(
    input wire [3:0] in,
    input wire [1:0] sel,
    output wire      out
    );
    wire y01, y23;
    
    mux_2x1 u0 ({in[1], in[0]}, sel[0], y01);
    mux_2x1 u1 ({in[3], in[2]}, sel[0], y23);
    mux_2x1 u2 ({y23, y01}, sel[1], out);
endmodule

module mux_8x1(
    input wire [7:0] in,
    input wire [2:0] sel,
    output wire      out
    );
    wire y03, y47;
    
    mux_4x1 u0 ({in[3], in[2], in[1], in[0]}, {sel[1], sel[0]}, y03);
    mux_4x1 u1 ({in[7], in[6], in[5], in[4]}, {sel[1], sel[0]}, y47);
    mux_2x1 u2 ({y47, y03}, sel[2], out);
endmodule