// 32x32 register file

`timescale 1ns / 1ps

module reg_file
    #(
        parameter DATA_WIDTH = 32, // bits per reg
                  ADDR_WIDTH = 5   // number of address bits
    )
    (
        input logic clk,
        input logic wr_en,
        input logic [ADDR_WIDTH-1:0] w_addr, r0_addr, r1_addr,
        input logic [DATA_WIDTH-1:0] w_data,
        output logic [DATA_WIDTH-1:0] r0_data, r1_data,
        
        //OK debug
        output logic [DATA_WIDTH-1:0] regs_ok [0:2**ADDR_WIDTH-1]
        
    );

    logic [DATA_WIDTH-1:0] regs [0:2**ADDR_WIDTH-1];
    
    assign regs_ok = regs; //OK
    
    // Register $0 is always 0 and cannot be written to
    always_ff @(posedge clk) begin
        if (wr_en && w_addr != 0)  // Never write to register $0
            regs[w_addr] <= w_data;
        // Ensure regs[0] is always 0
        regs[0] <= 0;
    end

    // Register $0 always returns 0
    assign r0_data = r0_addr == 0 ? 0 : regs[r0_addr];
    assign r1_data = r1_addr == 0 ? 0 : regs[r1_addr];
endmodule
