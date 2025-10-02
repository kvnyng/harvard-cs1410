//------------------------------------------------------------------------
// Opal Kelly Wrapper
//------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

// Definition
module logic_analyzer_wrapper (
    input  wire [4:0]  okUH,    
    output wire [2:0]  okHU,    
    inout  wire [31:0] okUHU,   
    inout  wire        okAA,    
    input  wire        sys_clkp,
    input  wire        sys_clkn
);

// 
// Declarations
//

localparam      LA_NUM_BUF_STAGES=32;   // TODO: Update this value for your experiment!
localparam      LA_ENTRY_LENGTH=16;
localparam      LA_NUM_ENTRY=15;

// Clock defn -- also see clk_wiz_0 submodule
wire sys_clk;   // 100.8 MHz on-chip clock 
wire fclk;      // 200 MHz on-chip clock 
IBUFGDS osc_clk(.O(sys_clk), .I(sys_clkp), .IB(sys_clkn)); // see xdc file for sys_clkn/p defns

// Pass to la_inst
wire                        la_trig_begin;
wire                        la_nrst;
wire                        la_trig_end;
wire [LA_ENTRY_LENGTH-1:0]  la_shift_out [LA_NUM_ENTRY-1:0];

// Pass to ok interface
wire [31:0]     ok_trig_in; 
wire [31:0]     ok_wo_arr [15:0]; // 16 entries, 32b e/a
wire            okClk;
wire [112:0]    okHE;
wire [64:0]     okEH;
wire [65*17:0]  okEHx; // BOZO: This might need to be 18, and generally should be parameterized with the okwireOR param

//
// Combinational Logic
//

// Connect la_inst ports to ok interface
// output wire [ENTRY_LENGTH-1:0]  shift_out [NUM_ENTRY-1:0]
assign la_trig_begin = ok_trig_in[0];
assign la_nrst = ~ok_trig_in[1]; // Inverted because triggers are active-high; otherwise machine would be stuck in reset all the time

genvar i;
generate 
    for (i=0; i<16; i=i+1) begin // there are 16 wireOuts
        assign ok_wo_arr[i] = {16'b0, la_shift_out[i]};
    end
endgenerate

//
// Instantiate submodules
//

// Logic analyzer
logic_analyzer #(.NUM_BUF_STAGES(LA_NUM_BUF_STAGES)) la_inst (
    .clk(fclk), 
    .nrst(la_nrst),
    .trig_begin(la_trig_begin),
    .trig_end(la_trig_end),
    .shift_out(la_shift_out)
);

// Clock wizard -- requires the Vivado-generated clk_wiz_0 IP in sources
clk_wiz_0 fclk_gen(
    .clk_out1(fclk),
    .resetn(la_nrst),
    .locked(),
    .clk_in1(sys_clk)
);

// OpalKelly modules
okHost okHI(
	.okUH(okUH),    /*user->host*/
	.okHU(okHU),    /*host->user*/
	.okUHU(okUHU),  /*user<->host*/
	.okAA(okAA),    /*user<->host*/
	.okClk(okClk),  /*100.8 MHz clock*/
    .okHE(okHE),    /*host->endpoint*/
    .okEH(okEH)     /*endpoint->host*/
);

okWireOR # (.N(17)) wireOR (okEH, okEHx); // N=17; 16 WireOut + 1 TriggerOut

// Wire Outs ('wo')
genvar j;
generate 
    for (j=0; j<16; j=j+1) begin 
        // Starting address 8'h20 = 32
        okWireOut ok_wo_inst (.okHE(okHE), .okEH(okEHx[ j*65 +: 65 ]),  .ep_addr(32+j), .ep_datain(ok_wo_arr[j]));
    end
endgenerate

// Triggers 
okTriggerIn  ok_ti_inst (.okHE(okHE),                              .ep_addr(64), .ep_clk(sys_clk), .ep_trigger(ok_trig_in));
okTriggerOut ok_to_inst (.okHE(okHE), .okEH(okEHx[ 16*65 +: 65 ]), .ep_addr(96), .ep_clk(sys_clk), .ep_trigger({31'b0, la_trig_end}));

endmodule // END logic_analyzer_wrapper
