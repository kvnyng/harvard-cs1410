// The following module is made for SIMULATION ONLY - most of the language
// constructs used here will not synthesize, but will simulate
module logic_analyzer_tb;
    // timeunit for the simulator waveform
    // delays (#1) are in units of nanoseconds with 2 decimal
    // places of accuracy
    timeunit 1ns/1ps;
    parameter CLK_PERIOD = 5; // 200 MHz freq = 5 ns period
    parameter LA_ENTRY_LENGTH=16, LA_NUM_ENTRY=15;
    
    /*input*/   logic clk;                      
    /*input*/   logic nrst;
    /*input*/   logic trig_begin;
    /*output*/  logic trig_end;
    /*output*/  logic [LA_ENTRY_LENGTH-1:0]  shift_out [LA_NUM_ENTRY:0];
    /*signal*/  logic display_flag;

    // instantiate unit under test (uut)
    logic_analyzer uut (.clk(clk), .nrst(nrst), .trig_begin(trig_begin), .shift_out(shift_out));

    // Clock generation
    initial
        clk = 1'b0;
    always
        #(CLK_PERIOD/2) clk = ~clk;

    // Main TB block
    initial begin
        // Initial reset
        $display("INFO: Resetting logic analyzer");
        nrst = 1'b1; // just an initial condition, gets set to 0 later 
        trig_begin = 1'b1;
        display_flag = 1'b0;

        #(CLK_PERIOD);
        nrst = 1'b0;

        $display("INFO: Beginning functional simulation");
        #(10*CLK_PERIOD);
        nrst = 1'b1;
        display_flag = 1'b1;
        
        #(CLK_PERIOD);
        trig_begin = 1'b0;

        #(LA_NUM_ENTRY*CLK_PERIOD); 
        $display("INFO: Ending logic analysis; entering idle state");
        
        #(LA_NUM_ENTRY*CLK_PERIOD); 
        $display("INFO: Ending functional simulation");
        $finish;
    end

    // Display the output on every clock edge
    always@(posedge clk) begin
        if (display_flag == 1) begin
            for (int i = 0; i < LA_NUM_ENTRY; i++) begin
                $display("%b", shift_out[i]);
            end
            $display("END shift_out");
        end
    end
endmodule
