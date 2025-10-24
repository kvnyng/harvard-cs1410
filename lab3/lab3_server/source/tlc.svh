// define states
`define IDLE 4'b0000
`define SAMPLE_STATE1 4'b0001
`define SAMPLE_STATE2 4'b0010

// useful macros
`define LIGHT_RED 2'b00
`define LIGHT_YELLOW 2'b01
`define LIGHT_GREEN 2'b10

`define PED_RED 2'b00
`define PED_WHITE 2'b01
`define PED_ORANGE 2'b10
`define PED_AMBER 2'b11

`define DIR_START 2'b00
`define DIR_NS 2'b01
`define DIR_EW 2'b10
`define DIR_BOTH 2'b11

//`define PED_NS 2'b10
//`define PED_EW 2'b01
//`define PED_BOTH 2'b11
//`define PED_NEITHER 2'b00

// Pedestrian signal combinations (NS_EW format)
`define PED_NS_AMBER_EW_AMBER 4'b0000
`define PED_NS_AMBER_EW_ORANGE 4'b0001
`define PED_NS_AMBER_EW_WHITE 4'b0010
`define PED_NS_ORANGE_EW_AMBER 4'b0100
`define PED_NS_ORANGE_EW_ORANGE 4'b0101
`define PED_NS_ORANGE_EW_WHITE 4'b0110
`define PED_NS_WHITE_EW_AMBER 4'b1000
`define PED_NS_WHITE_EW_ORANGE 4'b1001
`define PED_NS_WHITE_EW_WHITE 4'b1010

