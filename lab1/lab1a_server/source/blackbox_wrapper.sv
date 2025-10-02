//------------------------------------------------------------------------
// Opal Kelly Wrapper
//------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

// Definition
module blackbox_wrapper (
    input  wire [4:0]  okUH,
    output wire [2:0]  okHU,
    inout  wire [31:0] okUHU,
    inout  wire        okAA,
    input  wire        mmcm0_clk0,
	output wire [7:0] led
	);
// 
// Declarations
//

// Pass to blackbox_instance
wire in1;
wire in2;
wire in3;
wire out;

// Pass to ok interface 
wire            okClk;
wire [112:0]    okHE;
wire [64:0]     okEH;
wire [65*1-1:0] okEHx;
wire [31:0]     WireIn00;  //for input in1
wire [31:0]     WireIn01;  //for input in2
wire [31:0]     WireIn02;  //for input in3
wire [31:0]     WireOut20; //for output out

//
// Combinational Logic
//

// connect blackbox to ok interface
assign in1 = WireIn00[0];
assign in2 = WireIn01[0];
assign in3 = WireIn02[0];
assign WireOut20[0] = out;
assign WireOut20[31:1] = 31'b0;

// LED handling function 
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
assign led = xem7310_led({out,4'b0,in3,in2,in1});

//
// Instantiate submodules
//

// blackbox
blackbox blackbox_instance
    (
        .in1(in1), 
        .in2(in2), 
        .in3(in3),
        .out(out)
    );

// OpalKelly modules
okHost okHI(
	.okUH(okUH),
	.okHU(okHU),
	.okUHU(okUHU),
	.okAA(okAA),
	.okClk(okClk),
	.okHE(okHE), 
	.okEH(okEH)
);

okWireOR # (.N(1)) wireOR (okEH, okEHx); // N = 1 wireOut
okWireIn     ep00 (.okHE(okHE),                             .ep_addr(8'h00), .ep_dataout(WireIn00));
okWireIn     ep01 (.okHE(okHE),                             .ep_addr(8'h01), .ep_dataout(WireIn01));
okWireIn     ep02 (.okHE(okHE),                             .ep_addr(8'h02), .ep_dataout(WireIn02));
okWireOut    ep20 (.okHE(okHE), .okEH(okEHx[ 0*65 +: 65 ]), .ep_addr(8'h20), .ep_datain(WireOut20));

endmodule // END blackbox_wrapper
