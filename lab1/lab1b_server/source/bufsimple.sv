module bufsimple (
    input wire      in,
    output wire     out
);

(* DONT_TOUCH = "TRUE" *) wire middle;

// Just two inverters in series
(* DONT_TOUCH = "TRUE" *) INV inv0(.I(in), .O(middle));
(* DONT_TOUCH = "TRUE" *) INV inv1(.I(middle), .O(out));

endmodule
