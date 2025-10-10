`timescale 1ns/1ps

module sll
    (
        input logic [31:0] x,
        input logic [31:0] y,
        output logic [31:0] z
    );

    // The shift amount is the lowest 5 bits of y
    logic [4:0] shift_amount;
    assign shift_amount = y[4:0];

    // Construct a barrel shifter using 2x1 muxes with a depth of 5. Each layer will shift by 2^i.
    // For SLL (logical left shift), we shift left and fill with zeros on the right.

    genvar j;
    
    // Layer 1: Shift by 1 bit (controlled by shift_amount[0])
    logic [31:0] layer1;
    generate
        for (j = 1; j < 32; j = j + 1) begin : gen_layer1_mux
            mux_2x1 mux_unit (.in({x[j-1], x[j]}), .sel(shift_amount[0]), .out(layer1[j]));
        end
        // First bit gets 0 for left shift
        mux_2x1 mux_unit_first1 (.in({1'b0, x[0]}), .sel(shift_amount[0]), .out(layer1[0]));
    endgenerate

    // Layer 2: Shift by 2 bits (controlled by shift_amount[1])
    logic [31:0] layer2;
    generate
        for (j = 2; j < 32; j = j + 1) begin : gen_layer2_mux
            mux_2x1 mux_unit (.in({layer1[j-2], layer1[j]}), .sel(shift_amount[1]), .out(layer2[j]));
        end
        // First two bits get 0 for left shift
        for (j = 0; j < 2; j = j + 1) begin : gen_layer2_mux_zero
            mux_2x1 mux_unit (.in({1'b0, layer1[j]}), .sel(shift_amount[1]), .out(layer2[j]));
        end
    endgenerate

    // Layer 3: Shift by 4 bits (controlled by shift_amount[2])
    logic [31:0] layer3;
    generate
        for (j = 4; j < 32; j = j + 1) begin : gen_layer3_mux
            mux_2x1 mux_unit (.in({layer2[j-4], layer2[j]}), .sel(shift_amount[2]), .out(layer3[j]));
        end
        // First four bits get 0 for left shift
        for (j = 0; j < 4; j = j + 1) begin : gen_layer3_mux_zero
            mux_2x1 mux_unit (.in({1'b0, layer2[j]}), .sel(shift_amount[2]), .out(layer3[j]));
        end
    endgenerate

    // Layer 4: Shift by 8 bits (controlled by shift_amount[3])
    logic [31:0] layer4;
    generate
        for (j = 8; j < 32; j = j + 1) begin : gen_layer4_mux
            mux_2x1 mux_unit (.in({layer3[j-8], layer3[j]}), .sel(shift_amount[3]), .out(layer4[j]));
        end
        // First eight bits get 0 for left shift
        for (j = 0; j < 8; j = j + 1) begin : gen_layer4_mux_zero
            mux_2x1 mux_unit (.in({1'b0, layer3[j]}), .sel(shift_amount[3]), .out(layer4[j]));
        end
    endgenerate

    // Layer 5: Shift by 16 bits (controlled by shift_amount[4])
    logic [31:0] layer5;
    generate
        for (j = 16; j < 32; j = j + 1) begin : gen_layer5_mux
            mux_2x1 mux_unit (.in({layer4[j-16], layer4[j]}), .sel(shift_amount[4]), .out(layer5[j]));
        end
        // First sixteen bits get 0 for left shift
        for (j = 0; j < 16; j = j + 1) begin : gen_layer5_mux_zero
            mux_2x1 mux_unit (.in({1'b0, layer4[j]}), .sel(shift_amount[4]), .out(layer5[j]));
        end
    endgenerate

    assign z = layer5;

endmodule