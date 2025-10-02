module bufslow 
    #(
        parameter NUM_BUF_STAGES = 32
    )
    (
        input wire          a,
        output wire         b
    );

    // One bit for each buffer, plus input line
    wire [NUM_BUF_STAGES:0] buf_bits;

    assign buf_bits[0] = a;

    genvar i;
    generate 
        // Create NUM_BUF_STAGES buffers
        for (i=0; i<NUM_BUF_STAGES; i=i+1) begin 
            (* DONT_TOUCH = "TRUE" *) bufsimple buf_inst(.out(buf_bits[i+1]), .in(buf_bits[i]));
        end
    endgenerate

    assign b = buf_bits[NUM_BUF_STAGES];

endmodule
