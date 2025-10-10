module not32
    (
        input logic [31:0] x,
        output logic [31:0] z
    );

    genvar i;
    generate
        for (i = 0; i<32; i=i+1) begin: gen_not
            not g (z[i], x[i]);
        end
    endgenerate
endmodule