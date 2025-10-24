//------------------------------------------------------------------------
// Opal Kelly Wrapper
//------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

/*
xdc currently has clk of 9.92 ns (instead of 10ns)
*/


//Usable for part 2

// Definition
module tlc_top (
    input  wire [4:0]  okUH,
    output wire [2:0]  okHU,
    inout  wire [31:0] okUHU,
    inout  wire        okAA,
   
    input  wire        mmcm0_clk0,
	output wire [7:0] led
	);


//inputs
wire  okClk, clk_1hz; 
wire car_ns, car_ew, click_rst;
wire clk_div_rst, timer_rst;
wire en, load; 
wire [4:0] init;

//outputs
wire [1:0] light_ew, light_ns;
wire [3:0] ped_sigs;
wire [4:0] out;



clk_divider div_1hz (.clk_in(okClk), .rst(clk_div_rst), .clk_out(clk_1hz));

timer timer_u (.clk(okClk), .clk_slow(clk_1hz), .rst(timer_rst), .en(en),
                   .load(load), .init(init), .out(out));

// Uncomment for part 2
tlc tlc_u (.clk(okClk), .clk_slow(clk_1hz), .rst(timer_rst), .timer_en(en),
                .timer_load(load), .timer_init(init), .timer_out(out),
                .car_ns(car_ns), .car_ew(car_ew), .light_ns(light_ns),
                .click_rst(click_rst),
                .light_ew(light_ew), .ped_sigs(ped_sigs));




// --Wires In and Out
wire [31:0] WireIn00; //for car_ns (1b, ie. 1 bit)
wire [31:0] WireIn01; //for car_ew (1b)
wire [31:0] WireIn02; //for click_rst (1b)
wire [31:0] WireIn03; //for clk_div_rst (1b)
wire [31:0] WireIn04; //for timer_rst (1b)

wire [31:0] WireOut20; //for output out (4b)
wire [31:0] WireOut21; //for light_ew (3b)
wire [31:0] WireOut22; //for light_ns (3b)
wire [31:0] WireOut23; //for ped_sigs (4b)


assign car_ns = WireIn00[0];
assign car_ew = WireIn01[0];
assign click_rst = WireIn02[0];
assign clk_div_rst = WireIn03[0];
assign timer_rst = WireIn04[0];

assign WireOut20[4:0] = out;
assign WireOut20[31:5] = 27'b0;

assign WireOut21[1:0] = light_ew;
assign WireOut21[31:2] = 30'b0;

assign WireOut22[1:0] = light_ns;
assign WireOut22[31:2] = 30'b0;

assign WireOut23[3:0] = ped_sigs;
assign WireOut23[31:4] = 28'b0;


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
assign led = xem7310_led({light_ns, light_ew, ped_sigs}); //2b, 2b, 4b



// Opal Kelly Signals
// --OK Library
wire[112:0] okHE;
wire[64:0]  okEH;
// --OK Host
wire [65*4-1:0]  okEHx;

okHost okHI(
	.okUH(okUH),
	.okHU(okHU),
	.okUHU(okUHU),
	.okAA(okAA),
	.okClk(okClk),
	.okHE(okHE), 
	.okEH(okEH)
);

okWireOR # (.N(4)) wireOR (okEH, okEHx);

//Wires Ins
okWireIn     ep00 (.okHE(okHE),                             .ep_addr(8'h00), .ep_dataout(WireIn00)); //for car_ns 
okWireIn     ep01 (.okHE(okHE),                             .ep_addr(8'h01), .ep_dataout(WireIn01)); //for car_ew
okWireIn     ep02 (.okHE(okHE),                             .ep_addr(8'h02), .ep_dataout(WireIn02)); //for click_rst
okWireIn     ep03 (.okHE(okHE),                             .ep_addr(8'h03), .ep_dataout(WireIn03)); //for clk_div_rst 
okWireIn     ep04 (.okHE(okHE),                             .ep_addr(8'h04), .ep_dataout(WireIn04)); //for timer_rst

//Wire Outs 
okWireOut    ep20 (.okHE(okHE), .okEH(okEHx[ 0*65 +: 65 ]), .ep_addr(8'h20), .ep_datain(WireOut20)); //for output out 
okWireOut    ep21 (.okHE(okHE), .okEH(okEHx[ 1*65 +: 65 ]), .ep_addr(8'h21), .ep_datain(WireOut21)); //for light_ew 
okWireOut    ep22 (.okHE(okHE), .okEH(okEHx[ 2*65 +: 65 ]), .ep_addr(8'h22), .ep_datain(WireOut22)); //for light_ns 
okWireOut    ep23 (.okHE(okHE), .okEH(okEHx[ 3*65 +: 65 ]), .ep_addr(8'h23), .ep_datain(WireOut23)); //for ped_sigs

endmodule
