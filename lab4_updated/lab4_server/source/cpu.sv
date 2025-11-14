`timescale 1ns / 1ps
`include "cpu.svh"

module cpu
    # ( parameter DATA_WIDTH = 32, 
        parameter ADDR_WIDTH = 5)
    (
        input logic clk, clk_en, rst,
        output logic [31:0] r_data,  // Memory read data (from internal memory)
        output logic wr_en,
        output logic [31:0] mem_addr, w_data,

        //OK regs
        output logic [DATA_WIDTH-1:0] regs_ok [0:2**ADDR_WIDTH-1]
    );


    /*

        You should split the CPU into one or more submodules. 
        We have provided modules for you to use inside the CPU. Please see the following files:
            reg_file.sv (register file)
            reg_en.sv (register with enable and reset),
            reg_reset.sv (register with only reset)
            alu.sv (ALU)

        Useful constants and opcodes are provided in cpu.svh, which is included 
        at the top of this file.

    */


    /* Datapath */
    /*
         
        The CPU interfaces with main memory which is enabled by the
        inputs and outputs of this module (r_data, wr_en, mem_addr, w_data)
        You should create the register file, flip flops, and logic implementing
        a simple datapath so that instructions can be loaded from main memory,
        executed, and the results can be inspected in the register file, or in
        main memory (once lw and sw are supported). 

    */
    
    // Internal memory data signal (memory output)
    logic [31:0] mem_r_data;
    
    // Main memory (instruction and data memory)
    // This unified memory handles both instruction memory (starting at 0x00400000)
    // and data memory (starting at 0x0)
    rw_ram main_memory (
        .clk(clk),
        .clk_en(clk_en),
        .wr_en(wr_en),
        .addr(mem_addr),
        .w_data(w_data),
        .r_data(mem_r_data)
    );
    
    // Connect internal memory data to port (for external access if needed)
    // The datapath will use mem_r_data internally
    assign r_data = mem_r_data;


    /* Controller */
    /*

        You should also create a control FSM that controls the behavior of the 
        datapath depending on the instruction that is currently executing. 
        

    */
    


endmodule

