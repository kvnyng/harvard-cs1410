module mux_2x1(
    input logic sel,
    input logic [1:0] in,
    output logic out
    );

   logic not_sel;
   logic in0_and_not_sel;
   logic in1_and_sel;

   not u_not (not_sel, sel);
   and u_and0 (in0_and_not_sel, in[0], not_sel);
   and u_and1 (in1_and_sel, in[1], sel);

   or u_or (out, in0_and_not_sel, in1_and_sel);

endmodule


// Build and run commands
// // 1. Compile:
// // xvlog -sv source/mux_2x1.sv tb/mux_tb.sv

// // 2. Create simulation snapsho
// // xelab mux_tb -s mux_tb_sim -debug typical

// // 3. Run simulation image
// // xsim mux_tb_sim -R