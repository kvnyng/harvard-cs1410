module mux //4:1
    (
        input logic a, b, c, d,
        input logic [1:0] sel,
        output logic z 
    );
    
    assign z     = ~sel[0] & ~sel[1] & a 
                 | sel[0] & ~sel[1] & b
                 | ~sel[0] & sel[1] & c
                 | sel[0] & sel[1] & d;
 
   
endmodule
