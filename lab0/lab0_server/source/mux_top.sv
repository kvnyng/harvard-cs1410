//------------------------------------------------------------------------
// Opal Kelly Wrapper
//------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps


// Definition
module mux_top (
    input  wire [4:0]  okUH,
    output wire [2:0]  okHU,
    inout  wire [31:0] okUHU,
    inout  wire        okAA,
   
    input  wire        mmcm0_clk0,
	output wire [7:0] led
	);






wire a;
wire b;
wire c;
wire d;

wire [1:0] sel;
wire z;


mux mux_instance
    (
        .a(a), 
        .b(b), 
        .c(c),
        .d(d),
        .sel(sel),
        .z(z)
    );


// --Wires In and Out
wire [31:0] WireIn00; //for input a
wire [31:0] WireIn01; //for input b
wire [31:0] WireIn02; //for input c
wire [31:0] WireIn03; //for input d
wire [31:0] WireIn04; //for input sel

wire [31:0] WireOut20;//for output z

assign a = WireIn00[0];
assign b = WireIn01[0];
assign c = WireIn02[0];
assign d = WireIn03[0];
assign sel = WireIn04[1:0];

assign WireOut20[0] = z;
assign WireOut20[31:1] = 31'b0;


// --LED Handler
function [7:0] xem7310_led;
input [7:0] a;
integer i;
begin
	for(i=0; i<8; i=i+1) begin: u
		xem7310_led[i] = (a[i]==1'b1) ? (1'b0) : (1'bz);
	end
end
endfunction

//The first LED displays the output f 
assign led = xem7310_led({1'b0, z, sel, d, c, b, a});



// Opal Kelly Signals
// --OK Library
wire        okClk;
wire[112:0] okHE;
wire[64:0]  okEH;
// --OK Host
wire [65*1-1:0]  okEHx;

okHost okHI(
	.okUH(okUH),
	.okHU(okHU),
	.okUHU(okUHU),
	.okAA(okAA),
	.okClk(okClk),
	.okHE(okHE), 
	.okEH(okEH)
);

okWireOR # (.N(1)) wireOR (okEH, okEHx);

//Wires Ins are the inputs: a, b, c, d, sel
okWireIn     ep00 (.okHE(okHE),                             .ep_addr(8'h00), .ep_dataout(WireIn00));
okWireIn     ep01 (.okHE(okHE),                             .ep_addr(8'h01), .ep_dataout(WireIn01));
okWireIn     ep02 (.okHE(okHE),                             .ep_addr(8'h02), .ep_dataout(WireIn02));
okWireIn     ep03 (.okHE(okHE),                             .ep_addr(8'h03), .ep_dataout(WireIn03));
okWireIn     ep04 (.okHE(okHE),                             .ep_addr(8'h04), .ep_dataout(WireIn04));

//Wire Out is the output: f
okWireOut    ep20 (.okHE(okHE), .okEH(okEHx[ 0*65 +: 65 ]), .ep_addr(8'h20), .ep_datain(WireOut20));

endmodule
