module blackbox
    (
        input logic in1,
        input logic in2, 
        input logic in3,
        output logic out
    );

    assign not_in1 = ~in1;
    assign not_in2 = ~in2;
    assign not_in3 = ~in3;


    assign minterm_2 = not_in1 & in2 & not_in3;
    assign minterm_4 = in1 & not_in2 & not_in3;

    // TODO: Edit this section to describe the blackbox circuit
    assign out = minterm_2 | minterm_4;

endmodule