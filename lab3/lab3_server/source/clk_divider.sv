`timescale 1ns / 1ps

module clk_divider
    #(
        parameter div_amt = 10**8 
    )
    (
        input logic clk_in, rst,
        output logic clk_out 
    );

    int counter = 0;

    // output one positive edge for every `div_amt` input positive edges
    always_ff @(posedge clk_in) begin
       if (rst == 1) begin
            counter <= 0;
            clk_out <= 0;
       end else begin if (counter >= (div_amt - 1)) begin
                clk_out <= 1;
                counter <= 0;
           end else begin
                clk_out <= 0;
                counter <= counter + 1;    
           end
        end  
    end
endmodule



/*module clk_divider
# ( parameter cycles = 10**8) 
    (
        input logic clk_in, rst,
        output logic clk_out
    );

    // output one positive edge for every 100 million input positive edges

int n = 1; //track number of positive edges so far/ since the last rst
   
always_ff @(posedge clk_in) begin 
    
    
    if (n == cycles) begin
        clk_out = 1;
        n = 1;
    end
    else begin
        clk_out = 0;
    end
    
    if (rst == 1) begin
        clk_out = 0;
        n = 1;
    end
    
    n = n + 1;
end      

endmodule*/
