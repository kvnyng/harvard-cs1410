`timescale 1ns/1ps

module sra
    (
        input logic [31:0] x,
        input logic [31:0] y,
        output logic [31:0] z
    );

    // The shift amount is the lowest 5 bits of y
    logic [4:0] shift_amount;
    assign shift_amount = y[4:0];

    // Construct a barrel shifter using 2x1 muxes with a depth of 5. Each layer will shift by 2^i.
    // For SRA (arithmetic right shift), we shift right and fill with the sign bit (MSB).

    genvar j;
    
    // Layer 1: Shift by 1 bit (controlled by shift_amount[0])
    logic [31:0] layer1;
    generate
        for (j = 0; j < 31; j = j + 1) begin : gen_layer1_mux
            mux_2x1 mux_unit (.in({x[j+1], x[j]}), .sel(shift_amount[0]), .out(layer1[j]));
        end
        // Last bit gets the sign bit (MSB) for arithmetic right shift
        mux_2x1 mux_unit_last1 (.in({x[31], x[31]}), .sel(shift_amount[0]), .out(layer1[31]));
    endgenerate

    // Layer 2: Shift by 2 bits (controlled by shift_amount[1])
    logic [31:0] layer2;
    generate
        for (j = 0; j < 30; j = j + 1) begin : gen_layer2_mux
            mux_2x1 mux_unit (.in({layer1[j+2], layer1[j]}), .sel(shift_amount[1]), .out(layer2[j]));
        end
        // Last two bits get the sign bit for arithmetic right shift
        for (j = 30; j < 32; j = j + 1) begin : gen_layer2_mux_sign
            mux_2x1 mux_unit (.in({x[31], layer1[j]}), .sel(shift_amount[1]), .out(layer2[j]));
        end
    endgenerate

    // Layer 3: Shift by 4 bits (controlled by shift_amount[2])
    logic [31:0] layer3;
    generate
        for (j = 0; j < 28; j = j + 1) begin : gen_layer3_mux
            mux_2x1 mux_unit (.in({layer2[j+4], layer2[j]}), .sel(shift_amount[2]), .out(layer3[j]));
        end
        // Last four bits get the sign bit for arithmetic right shift
        for (j = 28; j < 32; j = j + 1) begin : gen_layer3_mux_sign
            mux_2x1 mux_unit (.in({x[31], layer2[j]}), .sel(shift_amount[2]), .out(layer3[j]));
        end
    endgenerate

    // Layer 4: Shift by 8 bits (controlled by shift_amount[3])
    logic [31:0] layer4;
    generate
        for (j = 0; j < 24; j = j + 1) begin : gen_layer4_mux
            mux_2x1 mux_unit (.in({layer3[j+8], layer3[j]}), .sel(shift_amount[3]), .out(layer4[j]));
        end
        // Last eight bits get the sign bit for arithmetic right shift
        for (j = 24; j < 32; j = j + 1) begin : gen_layer4_mux_sign
            mux_2x1 mux_unit (.in({x[31], layer3[j]}), .sel(shift_amount[3]), .out(layer4[j]));
        end
    endgenerate

    // Layer 5: Shift by 16 bits (controlled by shift_amount[4])
    logic [31:0] layer5;
    generate
        for (j = 0; j < 16; j = j + 1) begin : gen_layer5_mux
            mux_2x1 mux_unit (.in({layer4[j+16], layer4[j]}), .sel(shift_amount[4]), .out(layer5[j]));
        end
        // Last sixteen bits get the sign bit for arithmetic right shift
        for (j = 16; j < 32; j = j + 1) begin : gen_layer5_mux_sign
            mux_2x1 mux_unit (.in({x[31], layer4[j]}), .sel(shift_amount[4]), .out(layer5[j]));
        end
    endgenerate

    assign z = layer5;

endmodule